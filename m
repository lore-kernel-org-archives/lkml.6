Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489A2C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1804420661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1804420661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeLIWJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:09:23 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37422 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727045AbeLIWJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:09:18 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73F-0002pp-Li; Sun, 09 Dec 2018 21:55:49 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72d-0003NT-49; Sun, 09 Dec 2018 21:55:11 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Dominique Martinet" <dominique.martinet@cea.fr>,
        "Chirantan Ekbote" <chirantan@chromium.org>,
        "Dylan Reid" <dgreid@chromium.org>,
        "Guenter Roeck" <groeck@chromium.org>, "Greg Kurz" <groug@kaod.org>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.953274689@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 128/328] 9p/net: Fix zero-copy path in the 9p virtio
 transport
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Chirantan Ekbote <chirantan@chromium.org>

commit d28c756caee6e414d9ba367d0b92da24145af2a8 upstream.

The zero-copy optimization when reading or writing large chunks of data
is quite useful.  However, the 9p messages created through the zero-copy
write path have an incorrect message size: it should be the size of the
header + size of the data being written but instead it's just the size
of the header.

This only works if the server ignores the size field of the message and
otherwise breaks the framing of the protocol. Fix this by re-writing the
message size field with the correct value.

Tested by running `dd if=/dev/zero of=out bs=4k count=1` inside a
virtio-9p mount.

Link: http://lkml.kernel.org/r/20180717003529.114368-1-chirantan@chromium.org
Signed-off-by: Chirantan Ekbote <chirantan@chromium.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Tested-by: Greg Kurz <groug@kaod.org>
Cc: Dylan Reid <dgreid@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/9p/trans_virtio.c | 7 +++++++
 1 file changed, 7 insertions(+)

--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -378,6 +378,7 @@ p9_virtio_zc_request(struct p9_client *c
 	p9_debug(P9_DEBUG_TRANS, "virtio request\n");
 
 	if (uodata) {
+		__le32 sz;
 		out_nr_pages = p9_nr_pages(uodata, outlen);
 		out_pages = kmalloc(sizeof(struct page *) * out_nr_pages,
 				    GFP_NOFS);
@@ -393,6 +394,12 @@ p9_virtio_zc_request(struct p9_client *c
 			out_pages = NULL;
 			goto err_out;
 		}
+		/* The size field of the message must include the length of the
+		 * header and the length of the data.  We didn't actually know
+		 * the length of the data until this point so add it in now.
+		 */
+		sz = cpu_to_le32(req->tc->size + outlen);
+		memcpy(&req->tc->sdata[0], &sz, sizeof(sz));
 	}
 	if (uidata) {
 		in_nr_pages = p9_nr_pages(uidata, inlen);

