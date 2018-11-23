Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BECFC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 05:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE4420672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 05:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Xrl3Ilj7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Mi05Qti5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE4420672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501857AbeKWPzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 10:55:16 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40896 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730451AbeKWPzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 10:55:16 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0CC766022B; Fri, 23 Nov 2018 05:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542949959;
        bh=fybzytoy6rCEUHXiQlbWpA2nm4Ek+WcIElAQz9jXgE4=;
        h=From:To:Cc:Subject:Date:From;
        b=Xrl3Ilj7vC/aVpwIslo2L4FTJnAMoEz7aAtm4dGJw31QSl3Y7OAOCkgzrYjIxCsh/
         56e9uI6xA79dX7OBiMi0SBALvNNuwiosqq31hR1oyQGyQtGNkJVzR4/snoc6zx5MBV
         sq66ZNSyrVFMKY5qvfNtSCtj+Hv8+VR09vHYWzAo=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AEC05606DB;
        Fri, 23 Nov 2018 05:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542949958;
        bh=fybzytoy6rCEUHXiQlbWpA2nm4Ek+WcIElAQz9jXgE4=;
        h=From:To:Cc:Subject:Date:From;
        b=Mi05Qti5K7dGunuAkagX/vF3JWOGskHx0I9ui21FkpqWfFeKLyJ7nXcgpt+5+V0jO
         EC7ODwFjk/nEtUdUU1a0SJmC417/hAmRKWI3Iqf/x/X+qTB1e6eMowTNqDp9EGzHE8
         JrfW73XdqC6e6GMxo1CgrTRrx5wjqdR5bDoe+KY8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AEC05606DB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org,
        Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH] f2fs: fix to allow node segment for GC by ioctl path
Date:   Fri, 23 Nov 2018 10:42:22 +0530
Message-Id: <1542949942-30275-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow node type segments also to be GC'd via f2fs ioctls
F2FS_IOC_GARBAGE_COLLECT and F2FS_IOC_GARBAGE_COLLECT_RANGE.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/gc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index a07241f..e4689c6 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -323,8 +323,7 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 	p.min_cost = get_max_cost(sbi, &p);
 
 	if (*result != NULL_SEGNO) {
-		if (IS_DATASEG(get_seg_entry(sbi, *result)->type) &&
-			get_valid_blocks(sbi, *result, false) &&
+		if (get_valid_blocks(sbi, *result, false) &&
 			!sec_usage_check(sbi, GET_SEC_FROM_SEG(sbi, *result)))
 			p.min_segno = *result;
 		goto out;
@@ -404,11 +403,12 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 		}
 		*result = (p.min_segno / p.ofs_unit) * p.ofs_unit;
 
+	}
+out:
+	if (p.min_segno != NULL_SEGNO)
 		trace_f2fs_get_victim(sbi->sb, type, gc_type, &p,
 				sbi->cur_victim_sec,
 				prefree_segments(sbi), free_segments(sbi));
-	}
-out:
 	mutex_unlock(&dirty_i->seglist_lock);
 
 	return (p.min_segno == NULL_SEGNO) ? 0 : 1;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

