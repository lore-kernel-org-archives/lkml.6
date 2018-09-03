Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5C1C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C327F20862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C327F20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbeICV1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:27:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39636 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbeICV1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:27:13 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 370D4D06;
        Mon,  3 Sep 2018 17:06:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve French <stfrench@microsoft.com>,
        Pavel Shilovsky <pshilov@microsoft.com>
Subject: [PATCH 4.9 054/107] smb3: enumerating snapshots was leaving part of the data off end
Date:   Mon,  3 Sep 2018 18:56:18 +0200
Message-Id: <20180903165639.919546430@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165637.293735109@linuxfoundation.org>
References: <20180903165637.293735109@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve French <stfrench@microsoft.com>

commit e02789a53d71334b067ad72eee5d4e88a0158083 upstream.

When enumerating snapshots, the last few bytes of the final
snapshot could be left off since we were miscalculating the
length returned (leaving off the sizeof struct SRV_SNAPSHOT_ARRAY)
See MS-SMB2 section 2.2.32.2. In addition fixup the length used
to allow smaller buffer to be passed in, in order to allow
returning the size of the whole snapshot array more easily.

Sample userspace output with a kernel patched with this
(mounted to a Windows volume with two snapshots).
Before this patch, the second snapshot would be missing a
few bytes at the end.

~/cifs-2.6# ~/enum-snapshots /mnt/file
press enter to issue the ioctl to retrieve snapshot information ...

size of snapshot array = 102
Num snapshots: 2 Num returned: 2 Array Size: 102

Snapshot 0:@GMT-2018.06.30-19.34.17
Snapshot 1:@GMT-2018.06.30-19.33.37

CC: Stable <stable@vger.kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2ops.c |   34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -894,6 +894,13 @@ smb3_set_integrity(const unsigned int xi
 
 }
 
+/* GMT Token is @GMT-YYYY.MM.DD-HH.MM.SS Unicode which is 48 bytes + null */
+#define GMT_TOKEN_SIZE 50
+
+/*
+ * Input buffer contains (empty) struct smb_snapshot array with size filled in
+ * For output see struct SRV_SNAPSHOT_ARRAY in MS-SMB2 section 2.2.32.2
+ */
 static int
 smb3_enum_snapshots(const unsigned int xid, struct cifs_tcon *tcon,
 		   struct cifsFileInfo *cfile, void __user *ioc_buf)
@@ -922,14 +929,27 @@ smb3_enum_snapshots(const unsigned int x
 			kfree(retbuf);
 			return rc;
 		}
-		if (snapshot_in.snapshot_array_size < sizeof(struct smb_snapshot_array)) {
-			rc = -ERANGE;
-			kfree(retbuf);
-			return rc;
-		}
 
-		if (ret_data_len > snapshot_in.snapshot_array_size)
-			ret_data_len = snapshot_in.snapshot_array_size;
+		/*
+		 * Check for min size, ie not large enough to fit even one GMT
+		 * token (snapshot).  On the first ioctl some users may pass in
+		 * smaller size (or zero) to simply get the size of the array
+		 * so the user space caller can allocate sufficient memory
+		 * and retry the ioctl again with larger array size sufficient
+		 * to hold all of the snapshot GMT tokens on the second try.
+		 */
+		if (snapshot_in.snapshot_array_size < GMT_TOKEN_SIZE)
+			ret_data_len = sizeof(struct smb_snapshot_array);
+
+		/*
+		 * We return struct SRV_SNAPSHOT_ARRAY, followed by
+		 * the snapshot array (of 50 byte GMT tokens) each
+		 * representing an available previous version of the data
+		 */
+		if (ret_data_len > (snapshot_in.snapshot_array_size +
+					sizeof(struct smb_snapshot_array)))
+			ret_data_len = snapshot_in.snapshot_array_size +
+					sizeof(struct smb_snapshot_array);
 
 		if (copy_to_user(ioc_buf, retbuf, ret_data_len))
 			rc = -EFAULT;


