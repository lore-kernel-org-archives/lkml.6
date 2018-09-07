Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E022DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5892075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D5892075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbeIHB4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:56:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40784 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbeIHB4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:56:20 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9AFACF07;
        Fri,  7 Sep 2018 21:13:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chirantan Ekbote <chirantan@chromium.org>,
        Greg Kurz <groug@kaod.org>, Dylan Reid <dgreid@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Dominique Martinet <dominique.martinet@cea.fr>
Subject: [PATCH 4.18 004/145] 9p/net: Fix zero-copy path in the 9p virtio transport
Date:   Fri,  7 Sep 2018 23:07:50 +0200
Message-Id: <20180907210904.004099774@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/9p/trans_virtio.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -406,6 +406,7 @@ p9_virtio_zc_request(struct p9_client *c
 	p9_debug(P9_DEBUG_TRANS, "virtio request\n");
 
 	if (uodata) {
+		__le32 sz;
 		int n = p9_get_mapped_pages(chan, &out_pages, uodata,
 					    outlen, &offs, &need_drop);
 		if (n < 0)
@@ -416,6 +417,12 @@ p9_virtio_zc_request(struct p9_client *c
 			memcpy(&req->tc->sdata[req->tc->size - 4], &v, 4);
 			outlen = n;
 		}
+		/* The size field of the message must include the length of the
+		 * header and the length of the data.  We didn't actually know
+		 * the length of the data until this point so add it in now.
+		 */
+		sz = cpu_to_le32(req->tc->size + outlen);
+		memcpy(&req->tc->sdata[0], &sz, sizeof(sz));
 	} else if (uidata) {
 		int n = p9_get_mapped_pages(chan, &in_pages, uidata,
 					    inlen, &offs, &need_drop);


