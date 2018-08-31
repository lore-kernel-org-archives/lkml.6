Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD34C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C6E205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TGZkydbK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TGZkydbK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38C6E205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeHaNqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 09:46:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38144 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeHaNqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 09:46:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B104C606DB; Fri, 31 Aug 2018 09:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535708395;
        bh=vLdNAC02QhWz4QbSaCGU9JBeEd92DAajnnaw9KyWz+U=;
        h=From:To:Cc:Subject:Date:From;
        b=TGZkydbKEaQsvffdi2Z0adL3axEfN/vw8ujKHxLvYTRIYV3Hgd9Hwe3FiyK7VNH4z
         cojwh/zSuT66z1wiVqu+abLqOSyPffEF3389UsR5IFR6zM20iRY4QU/xgolgvvD8h0
         YeRc+8n2PupY0R/OnQwfGdLwFeBxJkBb8btCQHm8=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3822960445;
        Fri, 31 Aug 2018 09:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535708395;
        bh=vLdNAC02QhWz4QbSaCGU9JBeEd92DAajnnaw9KyWz+U=;
        h=From:To:Cc:Subject:Date:From;
        b=TGZkydbKEaQsvffdi2Z0adL3axEfN/vw8ujKHxLvYTRIYV3Hgd9Hwe3FiyK7VNH4z
         cojwh/zSuT66z1wiVqu+abLqOSyPffEF3389UsR5IFR6zM20iRY4QU/xgolgvvD8h0
         YeRc+8n2PupY0R/OnQwfGdLwFeBxJkBb8btCQHm8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3822960445
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org,
        Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH] f2fs: fix unnecessary periodic wakeup of discard thread when dev is busy
Date:   Fri, 31 Aug 2018 15:09:26 +0530
Message-Id: <1535708366-11318-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dev is busy, discard thread wake up timeout can be aligned with the
exact time that it needs to wait for dev to come out of busy. This helps
to avoid unnecessary periodic wakeups and thus save some power.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/segment.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8bcbb50..df14030 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1379,6 +1379,8 @@ static int issue_discard_thread(void *data)
 	struct discard_policy dpolicy;
 	unsigned int wait_ms = DEF_MIN_DISCARD_ISSUE_TIME;
 	int issued;
+	unsigned long interval = sbi->interval_time[REQ_TIME] * HZ;
+	long delta;
 
 	set_freezable();
 
@@ -1410,7 +1412,11 @@ static int issue_discard_thread(void *data)
 			__wait_all_discard_cmd(sbi, &dpolicy);
 			wait_ms = dpolicy.min_interval;
 		} else if (issued == -1){
-			wait_ms = dpolicy.mid_interval;
+			delta = (sbi->last_time[REQ_TIME] + interval) - jiffies;
+			if (delta > 0)
+				wait_ms = jiffies_to_msecs(delta);
+			else
+				wait_ms = dpolicy.mid_interval;
 		} else {
 			wait_ms = dpolicy.max_interval;
 		}
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

