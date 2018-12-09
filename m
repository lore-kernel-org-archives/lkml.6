Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7917C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870082081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 870082081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbeLIWWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:22:08 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35220 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726520AbeLIVzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:21 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72l-0002iZ-AI; Sun, 09 Dec 2018 21:55:19 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72h-0003ZG-R3; Sun, 09 Dec 2018 21:55:15 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        "Ronnie Sahlberg" <lsahlber@redhat.com>,
        "Aurelien Aptel" <aaptel@suse.com>,
        "Dr Silvio Cesare of InfoSect" <silvio.cesare@gmail.com>,
        "Steve French" <stfrench@microsoft.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.345248489@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 236/328] cifs: prevent integer overflow in
 nxt_dir_entry()
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

commit 8ad8aa353524d89fa2e09522f3078166ff78ec42 upstream.

The "old_entry + le32_to_cpu(pDirInfo->NextEntryOffset)" can wrap
around so I have added a check for integer overflow.

Reported-by: Dr Silvio Cesare of InfoSect <silvio.cesare@gmail.com>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/cifs/readdir.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/fs/cifs/readdir.c
+++ b/fs/cifs/readdir.c
@@ -370,8 +370,15 @@ static char *nxt_dir_entry(char *old_ent
 
 		new_entry = old_entry + sizeof(FIND_FILE_STANDARD_INFO) +
 				pfData->FileNameLength;
-	} else
-		new_entry = old_entry + le32_to_cpu(pDirInfo->NextEntryOffset);
+	} else {
+		u32 next_offset = le32_to_cpu(pDirInfo->NextEntryOffset);
+
+		if (old_entry + next_offset < old_entry) {
+			cifs_dbg(VFS, "invalid offset %u\n", next_offset);
+			return NULL;
+		}
+		new_entry = old_entry + next_offset;
+	}
 	cifs_dbg(FYI, "new entry %p old entry %p\n", new_entry, old_entry);
 	/* validate that new_entry is not past end of SMB */
 	if (new_entry >= end_of_smb) {

