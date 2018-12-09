Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD3AC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B2A20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B2A20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbeLIWWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:22:52 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35210 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726518AbeLIVzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:21 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72l-0002il-5F; Sun, 09 Dec 2018 21:55:19 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72h-0003ZL-Sz; Sun, 09 Dec 2018 21:55:15 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Steve French" <stfrench@microsoft.com>,
        "Pavel Shilovsky" <pshilov@microsoft.com>,
        "Aurelien Aptel" <aaptel@suse.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.154984642@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 237/328] CIFS: fix wrapping bugs in num_entries()
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

commit 56446f218af1133c802dad8e9e116f07f381846c upstream.

The problem is that "entryptr + next_offset" and "entryptr + len + size"
can wrap.  I ended up changing the type of "entryptr" because it makes
the math easier when we don't have to do so much casting.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/cifs/smb2pdu.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -2148,33 +2148,38 @@ num_entries(char *bufstart, char *end_of
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

