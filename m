Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FABC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98CCC2083A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98CCC2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729936AbeIXSkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:40:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58712 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728702AbeIXSkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:40:21 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 11DED1097;
        Mon, 24 Sep 2018 12:38:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Steve French <stfrench@microsoft.com>,
        Aurelien Aptel <aaptel@suse.com>,
        Pavel Shilovsky <pshilov@microsoft.com>
Subject: [PATCH 4.18 135/235] CIFS: fix wrapping bugs in num_entries()
Date:   Mon, 24 Sep 2018 13:52:01 +0200
Message-Id: <20180924113119.288427413@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 56446f218af1133c802dad8e9e116f07f381846c upstream.

The problem is that "entryptr + next_offset" and "entryptr + len + size"
can wrap.  I ended up changing the type of "entryptr" because it makes
the math easier when we don't have to do so much casting.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2pdu.c |   25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -3492,33 +3492,38 @@ num_entries(char *bufstart, char *end_of
 	int len;
 	unsigned int entrycount = 0;
 	unsigned int next_offset = 0;
-	FILE_DIRECTORY_INFO *entryptr;
+	char *entryptr;
+	FILE_DIRECTORY_INFO *dir_info;
 
 	if (bufstart == NULL)
 		return 0;
 
-	entryptr = (FILE_DIRECTORY_INFO *)bufstart;
+	entryptr = bufstart;
 
 	while (1) {
-		entryptr = (FILE_DIRECTORY_INFO *)
-					((char *)entryptr + next_offset);
-
-		if ((char *)entryptr + size > end_of_buf) {
+		if (entryptr + next_offset < entryptr ||
+		    entryptr + next_offset > end_of_buf ||
+		    entryptr + next_offset + size > end_of_buf) {
 			cifs_dbg(VFS, "malformed search entry would overflow\n");
 			break;
 		}
 
-		len = le32_to_cpu(entryptr->FileNameLength);
-		if ((char *)entryptr + len + size > end_of_buf) {
+		entryptr = entryptr + next_offset;
+		dir_info = (FILE_DIRECTORY_INFO *)entryptr;
+
+		len = le32_to_cpu(dir_info->FileNameLength);
+		if (entryptr + len < entryptr ||
+		    entryptr + len > end_of_buf ||
+		    entryptr + len + size > end_of_buf) {
 			cifs_dbg(VFS, "directory entry name would overflow frame end of buf %p\n",
 				 end_of_buf);
 			break;
 		}
 
-		*lastentry = (char *)entryptr;
+		*lastentry = entryptr;
 		entrycount++;
 
-		next_offset = le32_to_cpu(entryptr->NextEntryOffset);
+		next_offset = le32_to_cpu(dir_info->NextEntryOffset);
 		if (!next_offset)
 			break;
 	}


