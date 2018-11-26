Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF1FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8880C20663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IRUhB1yt";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KYlSjUgo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8880C20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbeKZSzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 13:55:17 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60018 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbeKZSzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 13:55:17 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 251A8607EB; Mon, 26 Nov 2018 08:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543219319;
        bh=eg7F/O8PfmLHXRqDJs8fTOOx+/UgebWt5cBuEiD6heU=;
        h=From:To:Cc:Subject:Date:From;
        b=IRUhB1ytuQ2K4UGv2cFbK3tgxjoRVqYGZTpZ/pmuRpfxhKXFkJ6FzWc8Lm8ejkYXd
         6XXnH4FRGx/mwh2oIywq62rU3I3DHN0hgoOfxyguavQxWbbA5u7UEvCO3w0f4xcB0z
         y1G3zjvkzFulaoUVoEoQLgGdQAIOWcwiXkPU9Y9E=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B3E1960115;
        Mon, 26 Nov 2018 08:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543219318;
        bh=eg7F/O8PfmLHXRqDJs8fTOOx+/UgebWt5cBuEiD6heU=;
        h=From:To:Cc:Subject:Date:From;
        b=KYlSjUgo7SYpOe4c7OtQNuHQgjDv0LVQloycZCvF/BfOGscJlDOC1QdgMZHb2tvFl
         /5N+3sQJfvsSaweOuiFeGrUCpbKieQoz4zxrux9qLacam/ZkVdq7EHCYTo5DcvErJ3
         7r/RvGveo7xOuaFCv/hrqGwnDmRa8HatPxLs5M6s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B3E1960115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org,
        Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH v3 1/2] f2fs: fix to allow node segment for GC by ioctl path
Date:   Mon, 26 Nov 2018 13:31:41 +0530
Message-Id: <1543219302-12219-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow node type segments also to be GC'd via f2fs ioctl
F2FS_IOC_GARBAGE_COLLECT_RANGE.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
v3:
seperate the trace print change from this patch

 fs/f2fs/gc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index a07241f..d720551 100644
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
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

