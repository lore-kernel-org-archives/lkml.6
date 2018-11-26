Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6F8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C9420672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Q3rgiuqT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BjHMsLch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C9420672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbeKZSz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 13:55:26 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60166 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbeKZSz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 13:55:26 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2B369607EB; Mon, 26 Nov 2018 08:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543219328;
        bh=ykUx7CT2MOKmjg+tOHKFzGmsns32YE71FL4ItgdspMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q3rgiuqTExt69/+fxNW2h21WTDSV8gU0XBLm18eVYpNZIexZnBBGrZH+Zq1Igc5Xd
         Dlo4s4KRL+DE2r3JSLMqoo9etwKK4tDLzqrrZsp4NGj9C5KFtRIkkIKsGAYFA5chc2
         OoEiobdPNXvKZa87Pz76A0F1m3pBzPMGTfw1H1Sg=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BAA316079C;
        Mon, 26 Nov 2018 08:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543219327;
        bh=ykUx7CT2MOKmjg+tOHKFzGmsns32YE71FL4ItgdspMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BjHMsLch6lJhDBIpMVX4uzvsNHxrxNUYU05mPqMHSeVkVSLv4YyN0eZTpZzekF7TJ
         gNq4vHv6A3aCjG/vx6zLVKxdxZP0CS/egLtGHex7Upn6xYlA7kgOlsMb4kLlZOkpRI
         +QCGHZz3nBcKsYVk7tU0w5mXtTy5d3+ElrVg4bjA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BAA316079C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org,
        Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH v3 2/2] f2fs: adjust trace print in f2fs_get_victim() to cover all paths
Date:   Mon, 26 Nov 2018 13:31:42 +0530
Message-Id: <1543219302-12219-2-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1543219302-12219-1-git-send-email-stummala@codeaurora.org>
References: <1543219302-12219-1-git-send-email-stummala@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust the trace print in f2fs_get_victim() to cover GC done by
F2FS_IOC_GARBAGE_COLLECT_RANGE.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/gc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index d720551..e4689c6 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -403,11 +403,12 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
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

