Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F277C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 04:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F1820865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 04:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Zk1Pf1fT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PHplHNQd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F1820865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbeKZPv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 10:51:58 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46970 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeKZPv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 10:51:58 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2322660877; Mon, 26 Nov 2018 04:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543208344;
        bh=IttxXtTRD34URLuQVm/RSwrW+rSCd/ivt1Shjkuv9RM=;
        h=From:To:Cc:Subject:Date:From;
        b=Zk1Pf1fTIX/va7EiRGq3FfFi/0BOwgVah6tYJk6high1NkR6OxKl+klW+n+0u4gSY
         oUUtK0ItILHdhWpTVlbbUbWYmcLAWi+O8bGa20Nn+DYn+ySqdC8ogCasGLCVETo68u
         dnocGVMu6KKKEOgy/o4N26KoWiFmJQS7FCie5vdQ=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A894A6020A;
        Mon, 26 Nov 2018 04:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543208343;
        bh=IttxXtTRD34URLuQVm/RSwrW+rSCd/ivt1Shjkuv9RM=;
        h=From:To:Cc:Subject:Date:From;
        b=PHplHNQd5dViCkoABaGo+qHaHhnxEAx7iVRf996EcvuENoShbxjICYqfNCWvtCWlN
         sSq8AK9pQnDJQT1W4yi9K4fE9+fBtRk1zdctVHLEdHq+4nRdOfYwFVyO/6OvCYBF37
         nhVHMRfpx5lsujzLqAWUbcBcK9QCI/e0Xc6cVwAg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A894A6020A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org,
        Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH v2] f2fs: fix to allow node segment for GC by ioctl path
Date:   Mon, 26 Nov 2018 10:28:54 +0530
Message-Id: <1543208334-309-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow node type segments also to be GC'd via f2fs ioctl
F2FS_IOC_GARBAGE_COLLECT_RANGE.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
v2:
update commit message

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

