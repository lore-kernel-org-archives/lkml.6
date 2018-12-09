Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD64C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18A42081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D18A42081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbeLIWWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:22:35 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35222 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726521AbeLIVzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:21 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72l-0002ih-AF; Sun, 09 Dec 2018 21:55:19 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72h-0003ZR-Uo; Sun, 09 Dec 2018 21:55:15 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Steve French" <stfrench@microsoft.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        "Aurelien Aptel" <aaptel@suse.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.281385949@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 238/328] cifs: integer overflow in in SMB2_ioctl()
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

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 2d204ee9d671327915260071c19350d84344e096 upstream.

The "le32_to_cpu(rsp->OutputOffset) + *plen" addition can overflow and
wrap around to a smaller value which looks like it would lead to an
information leak.

Fixes: 4a72dafa19ba ("SMB2 FSCTL and IOCTL worker function")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
[bwh: Backported to 3.16: Use get_rfc1002_length(rsp) instead of
 rsp->iov.iov_len]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/cifs/smb2pdu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -1394,14 +1394,14 @@ SMB2_ioctl(const unsigned int xid, struc
 	/* We check for obvious errors in the output buffer length and offset */
 	if (*plen == 0)
 		goto ioctl_exit; /* server returned no data */
-	else if (*plen > 0xFF00) {
+	else if (*plen > get_rfc1002_length(rsp) || *plen > 0xFF00) {
 		cifs_dbg(VFS, "srv returned invalid ioctl length: %d\n", *plen);
 		*plen = 0;
 		rc = -EIO;
 		goto ioctl_exit;
 	}
 
-	if (get_rfc1002_length(rsp) < le32_to_cpu(rsp->OutputOffset) + *plen) {
+	if (get_rfc1002_length(rsp) - *plen < le32_to_cpu(rsp->OutputOffset)) {
 		cifs_dbg(VFS, "Malformed ioctl resp: len %d offset %d\n", *plen,
 			le32_to_cpu(rsp->OutputOffset));
 		*plen = 0;

