Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B78C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B3A218D9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Y86G9V/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbfB0IK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 03:10:29 -0500
Received: from forwardcorp1g.cmail.yandex.net ([87.250.241.190]:35077 "EHLO
        forwardcorp1g.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729221AbfB0IKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 03:10:22 -0500
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1g.cmail.yandex.net (Yandex) with ESMTP id 4E67921754;
        Wed, 27 Feb 2019 11:10:21 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id tCiqGkyt7o-ALQSmQGl;
        Wed, 27 Feb 2019 11:10:21 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1551255021; bh=OUtvS1UMR1WtRUBZFcHbMYWQBpjANbSUrjd5/KOC9O0=;
        h=Message-ID:References:Date:To:From:Subject:In-Reply-To;
        b=Y86G9V/L9IfbgrOaX87CFLyAG7qTmmhagDrjdthEeeTZVXLBlGjjoXQjZ8b5x9yxe
         xZOnPaHDjItWn92nsHuS2IC6vJTU702z8+xRP0WRIX/Hp50PBvSsOd9uIu0y0uhl3r
         +TYBHgSFDZrqhnhSkMKkqsNcgmxOtaKuT1+P5Gok=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8865:6f76:e76b:3fab])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id Ar7zbBtz1k-AL2KR1QZ;
        Wed, 27 Feb 2019 11:10:21 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH 3/3] sched/core: check quota and period overflow at usec to
 nsec conversion
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Date:   Wed, 27 Feb 2019 11:10:20 +0300
Message-ID: <155125502079.293431.3947497929372138600.stgit@buzz>
In-Reply-To: <155125501739.293431.5252197504404771496.stgit@buzz>
References: <155125501739.293431.5252197504404771496.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Large values could overflow u64 and pass following sanity checks.

# echo 18446744073750000 > cpu.cfs_period_us
# cat cpu.cfs_period_us
40448

# echo 18446744073750000 > cpu.cfs_quota_us
# cat cpu.cfs_quota_us
40448

After this patch they will fail with -EINVAL.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 kernel/sched/core.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a626fbd9fdc7..5f46aa335b28 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6606,8 +6606,10 @@ int tg_set_cfs_quota(struct task_group *tg, long cfs_quota_us)
 	period = ktime_to_ns(tg->cfs_bandwidth.period);
 	if (cfs_quota_us < 0)
 		quota = RUNTIME_INF;
-	else
+	else if ((u64)cfs_quota_us <= U64_MAX / NSEC_PER_USEC)
 		quota = (u64)cfs_quota_us * NSEC_PER_USEC;
+	else
+		return -EINVAL;
 
 	return tg_set_cfs_bandwidth(tg, period, quota);
 }
@@ -6629,6 +6631,9 @@ int tg_set_cfs_period(struct task_group *tg, long cfs_period_us)
 {
 	u64 quota, period;
 
+	if ((u64)cfs_period_us > U64_MAX / NSEC_PER_USEC)
+		return -EINVAL;
+
 	period = (u64)cfs_period_us * NSEC_PER_USEC;
 	quota = tg->cfs_bandwidth.quota;
 

