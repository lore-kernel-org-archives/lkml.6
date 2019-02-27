Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFEFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C85D218D9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Jm6wm1Fv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729628AbfB0IKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 03:10:21 -0500
Received: from forwardcorp1j.cmail.yandex.net ([5.255.227.105]:37979 "EHLO
        forwardcorp1j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729221AbfB0IKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 03:10:20 -0500
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1j.cmail.yandex.net (Yandex) with ESMTP id C4F0A215A2;
        Wed, 27 Feb 2019 11:10:17 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id SmDtaZTOFG-AHVCS2UM;
        Wed, 27 Feb 2019 11:10:17 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1551255017; bh=dZRH3kB9yafvNvSEvkcyjOTuG8G8AyRQwaE6yHEz84Q=;
        h=Message-ID:Date:To:From:Subject;
        b=Jm6wm1FvB7LsJs0ZVjQtT4Z98JdcOpv16pQA6WAcbeILLg3wKuvazDrrBxr6dnp0S
         j/O9otcArh9umggBugu5Qz43jadsEH83QjkFeAufKdVF2/fTHNn8FDalwZGC76Bz4g
         Douk/ehEgEEQ5p+Fjo8YFJggEbRuN1efhPtQI2Cg=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8865:6f76:e76b:3fab])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id jzmD5UXEBG-AH9WDINY;
        Wed, 27 Feb 2019 11:10:17 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH 1/3] sched/rt: check integer overflow at usec to nsec
 conversion
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Date:   Wed, 27 Feb 2019 11:10:17 +0300
Message-ID: <155125501739.293431.5252197504404771496.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Example of unhandled overflows:

# echo 18446744073709651 > cpu.rt_runtime_us
# cat cpu.rt_runtime_us
99

# echo 18446744073709900 > cpu.rt_period_us
# cat cpu.rt_period_us
348

After this patch they will fail with -EINVAL.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 kernel/sched/rt.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index e4f398ad9e73..aa7ee3a0bf90 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2555,6 +2555,8 @@ int sched_group_set_rt_runtime(struct task_group *tg, long rt_runtime_us)
 	rt_runtime = (u64)rt_runtime_us * NSEC_PER_USEC;
 	if (rt_runtime_us < 0)
 		rt_runtime = RUNTIME_INF;
+	else if ((u64)rt_runtime_us > U64_MAX / NSEC_PER_USEC)
+		return -EINVAL;
 
 	return tg_set_rt_bandwidth(tg, rt_period, rt_runtime);
 }
@@ -2575,6 +2577,9 @@ int sched_group_set_rt_period(struct task_group *tg, u64 rt_period_us)
 {
 	u64 rt_runtime, rt_period;
 
+	if (rt_period_us > U64_MAX / NSEC_PER_USEC)
+		return -EINVAL;
+
 	rt_period = rt_period_us * NSEC_PER_USEC;
 	rt_runtime = tg->rt_bandwidth.rt_runtime;
 

