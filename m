Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE966ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714762145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 714762145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbeIXR6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:58:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52010 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728790AbeIXR6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:58:10 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 69EC71073;
        Mon, 24 Sep 2018 11:56:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dr Silvio Cesare of InfoSect <silvio.cesare@gmail.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Aurelien Aptel <aaptel@suse.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.4 45/70] cifs: prevent integer overflow in nxt_dir_entry()
Date:   Mon, 24 Sep 2018 13:52:44 +0200
Message-Id: <20180924113105.056365058@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113058.420454070@linuxfoundation.org>
References: <20180924113058.420454070@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/readdir.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/fs/cifs/readdir.c
+++ b/fs/cifs/readdir.c
@@ -373,8 +373,15 @@ static char *nxt_dir_entry(char *old_ent
 
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


