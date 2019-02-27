Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874A9C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F4C218D9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="G8FaNp6O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbfB0IKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 03:10:25 -0500
Received: from forwardcorp1j.cmail.yandex.net ([5.255.227.105]:37991 "EHLO
        forwardcorp1j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729249AbfB0IKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 03:10:22 -0500
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1j.cmail.yandex.net (Yandex) with ESMTP id A5EF821576;
        Wed, 27 Feb 2019 11:10:19 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 9wiH75Up3X-AJQGrPHt;
        Wed, 27 Feb 2019 11:10:19 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1551255019; bh=nHxLRba8hwVikPHwTuKeE6G1NROyk72EdJ/rfD/Ha8s=;
        h=Message-ID:References:Date:To:From:Subject:In-Reply-To;
        b=G8FaNp6Oft27WQ2YD7EiIoa+ZRJ4wcTx/OUdy0HT0ZLbEWp0Bh3jXQ2EdaVsZgr4F
         BqODNh6yxq/zY03qKU84a88nMxsGfHMWM7mI34vfFmr182866fqgjdUq+OIkc3lBLS
         UfCZN4eCNXnbd7IazfCuhq6bdLvziuAGsDi6TCBc=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8865:6f76:e76b:3fab])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id AO5zLD244o-AJ9u8gKl;
        Wed, 27 Feb 2019 11:10:19 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH 2/3] sched/core: handle overflow in cpu_shares_write_u64
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Date:   Wed, 27 Feb 2019 11:10:18 +0300
Message-ID: <155125501891.293431.3345233332801109696.stgit@buzz>
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

Bit shift in scale_load() could overflow shares. This patch saturates
it to MAX_SHARES like following sched_group_set_shares().

Example:
# echo 9223372036854776832 > cpu.shares
# cat cpu.shares

Before patch: 1024
After pattch: 262144

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 kernel/sched/core.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d8d76a65cfdd..a626fbd9fdc7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6502,6 +6502,8 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
 static int cpu_shares_write_u64(struct cgroup_subsys_state *css,
 				struct cftype *cftype, u64 shareval)
 {
+	if (shareval > scale_load_down(ULONG_MAX))
+		shareval = MAX_SHARES;
 	return sched_group_set_shares(css_tg(css), scale_load(shareval));
 }
 

