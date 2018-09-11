Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC19C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E905820839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="o210RpPD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DByO+rkG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E905820839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbeIKO2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:28:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45080 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbeIKO2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:28:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 108CC609A1; Tue, 11 Sep 2018 09:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536658175;
        bh=OoRYiez0Ts7XmH7Dz9+CGoLOGADJA4HEL/KMhw9/xvM=;
        h=From:To:Cc:Subject:Date:From;
        b=o210RpPDq5XoxjCCVRnEOC4M1X8zeVC9DKgWqP3ikuHcPkgFrWVF+Sz5tJ7Zp8JR5
         Twp31+HTJqwK/d7DYuTwpHUKoGiGWa+GVZsHl/DjbAvsBazWoeJrQGMWMT49Mjoj32
         qci1H38yKMq9YbaBgGFuNLeXnw9/OkKtFhmIBZjg=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D5116607EB;
        Tue, 11 Sep 2018 09:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536658174;
        bh=OoRYiez0Ts7XmH7Dz9+CGoLOGADJA4HEL/KMhw9/xvM=;
        h=From:To:Cc:Subject:Date:From;
        b=DByO+rkGvXtdBMUZFUsNAN6+6iMZN8C96z9xjVx9FP/HXAlOnFIg/lBZwabsWF/R8
         8LIUBWxoNuWPJ7txwQ3qUPjajwNXshMeyXIw6BCzTLs5kqLk6DNk5HRIfPgeBA0AoS
         RKcUxJzkELbB0ctbm/XXzyv1emElk2lYigZdnWVw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D5116607EB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     plai@codeaurora.org, bgoswami@codeaurora.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        rohkumar@qti.qualcomm.com
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH v2] ASoC: Fix UBSAN warning at snd_soc_get/put_volsw_sx()
Date:   Tue, 11 Sep 2018 14:59:21 +0530
Message-Id: <1536658161-31656-1-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In functions snd_soc_get_volsw_sx() or snd_soc_put_volsw_sx(),
if the result of (min + max) is negative, then fls() returns
signed integer with value as 32. This leads to signed integer
overflow as complete operation is considered as signed integer.

UBSAN: Undefined behaviour in sound/soc/soc-ops.c:382:50
signed integer overflow:
-2147483648 - 1 cannot be represented in type 'int'
Call trace:
[<ffffff852f746fe4>] __dump_stack lib/dump_stack.c:15 [inline]
[<ffffff852f746fe4>] dump_stack+0xec/0x158 lib/dump_stack.c:51
[<ffffff852f7b5f3c>] ubsan_epilogue+0x18/0x50 lib/ubsan.c:164
[<ffffff852f7b6840>] handle_overflow+0xf8/0x130 lib/ubsan.c:195
[<ffffff852f7b68f0>] __ubsan_handle_sub_overflow+0x34/0x44 lib/ubsan.c:211
[<ffffff85307971a0>] snd_soc_get_volsw_sx+0x1a8/0x1f8 sound/soc/soc-ops.c:382

Typecast the operation to unsigned int to fix the issue.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
Changes since v1:
    Addressed comments given by Takashi.

 sound/soc/soc-ops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 592efb3..f4dc3d4 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -373,7 +373,7 @@ int snd_soc_get_volsw_sx(struct snd_kcontrol *kcontrol,
 	unsigned int rshift = mc->rshift;
 	int max = mc->max;
 	int min = mc->min;
-	unsigned int mask = (1 << (fls(min + max) - 1)) - 1;
+	unsigned int mask = (1U << (fls(min + max) - 1)) - 1;
 	unsigned int val;
 	int ret;
 
@@ -418,7 +418,7 @@ int snd_soc_put_volsw_sx(struct snd_kcontrol *kcontrol,
 	unsigned int rshift = mc->rshift;
 	int max = mc->max;
 	int min = mc->min;
-	unsigned int mask = (1 << (fls(min + max) - 1)) - 1;
+	unsigned int mask = (1U << (fls(min + max) - 1)) - 1;
 	int err = 0;
 	unsigned int val, val_mask, val2 = 0;
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

