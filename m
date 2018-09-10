Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908A8C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F8E20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Jbbs/fiD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XTXrK1gE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F8E20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbeIJW3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:29:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53820 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbeIJW3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:29:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0704960847; Mon, 10 Sep 2018 17:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536600854;
        bh=EvYbUi8Q+LDt1ZZ5JBi/TKvwmMbFIhypoPuZJgSU2Cs=;
        h=From:To:Cc:Subject:Date:From;
        b=Jbbs/fiDF3pI0t+nuLzJh35dhWzXqwieUWTwNBwB+IYE1RJyML//0nS7Ms5UxWzsj
         TzHCeSqzLxr++ENwTlWNKeFOTf2jFzswxsFmldNjVaNTIqWEq6Zeb7JiYuSwcK1v+p
         yY64NABWDAdD5xO7DIIaQIIwKRmgUMeE720wF5Wc=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 28F4960558;
        Mon, 10 Sep 2018 17:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536600853;
        bh=EvYbUi8Q+LDt1ZZ5JBi/TKvwmMbFIhypoPuZJgSU2Cs=;
        h=From:To:Cc:Subject:Date:From;
        b=XTXrK1gEqxKQIAt93AanmQ/sqk1Q6cVyooDl93pW3jUZ4W4GGg80mhNW8LXKqz4TO
         ACTiWoge/jf9RF8gXAw78l8L0znf8GWRVq8nArohRkphsdFTHvRsG9BOZMnCoS1Kju
         DKK382cZ08sd7HV4EfLyRjre3ys0IfQg5RGJ0PsU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 28F4960558
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH] ASoC: Fix UBSAN warning at snd_soc_get/put_volsw_sx()
Date:   Mon, 10 Sep 2018 23:03:56 +0530
Message-Id: <1536600836-12153-1-git-send-email-rohitkr@codeaurora.org>
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
 sound/soc/soc-ops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 592efb3..f8e3190 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -373,7 +373,7 @@ int snd_soc_get_volsw_sx(struct snd_kcontrol *kcontrol,
 	unsigned int rshift = mc->rshift;
 	int max = mc->max;
 	int min = mc->min;
-	unsigned int mask = (1 << (fls(min + max) - 1)) - 1;
+	unsigned int mask = ((unsigned int)(1 << (fls(min + max) - 1)) - 1);
 	unsigned int val;
 	int ret;
 
@@ -418,7 +418,7 @@ int snd_soc_put_volsw_sx(struct snd_kcontrol *kcontrol,
 	unsigned int rshift = mc->rshift;
 	int max = mc->max;
 	int min = mc->min;
-	unsigned int mask = (1 << (fls(min + max) - 1)) - 1;
+	unsigned int mask = ((unsigned int)(1 << (fls(min + max) - 1)) - 1);
 	int err = 0;
 	unsigned int val, val_mask, val2 = 0;
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

