Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5052C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787672243E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhSD53n6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787672243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388136AbeKOIqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:46:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:34470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728743AbeKOI1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:27:24 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B96BC22513;
        Wed, 14 Nov 2018 22:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234140;
        bh=E/4ChsQ8iY/Cd6jUYfUCxL4aKyKdA8/o0duSaILRBVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IhSD53n6jXCX3BKmt2PRWq2UkrgqX9nDuIlKi78TDy30Gd7oiZ4aG/gmpU/VKEgaG
         b2ty1uBuYRT11ypzSYmxHtNKE3tMfdshoIxVaFRM3kvZ2LJ4CQMDO62+h/D6MXk+Rl
         1kHhjmkdiQmradqo+M9b6V67bxj2Nftol+5Xo8Oc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar.Eggemann@arm.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, morten.rasmussen@arm.com,
        quentin.perret@arm.com, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 52/73] sched/core: Take the hotplug lock in sched_init_smp()
Date:   Wed, 14 Nov 2018 17:21:46 -0500
Message-Id: <20181114222207.98701-52-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222207.98701-1-sashal@kernel.org>
References: <20181114222207.98701-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valentin Schneider <valentin.schneider@arm.com>

[ Upstream commit 40fa3780bac2b654edf23f6b13f4e2dd550aea10 ]

When running on linux-next (8c60c36d0b8c ("Add linux-next specific files
for 20181019")) + CONFIG_PROVE_LOCKING=y on a big.LITTLE system (e.g.
Juno or HiKey960), we get the following report:

 [    0.748225] Call trace:
 [    0.750685]  lockdep_assert_cpus_held+0x30/0x40
 [    0.755236]  static_key_enable_cpuslocked+0x20/0xc8
 [    0.760137]  build_sched_domains+0x1034/0x1108
 [    0.764601]  sched_init_domains+0x68/0x90
 [    0.768628]  sched_init_smp+0x30/0x80
 [    0.772309]  kernel_init_freeable+0x278/0x51c
 [    0.776685]  kernel_init+0x10/0x108
 [    0.780190]  ret_from_fork+0x10/0x18

The static_key in question is 'sched_asym_cpucapacity' introduced by
commit:

  df054e8445a4 ("sched/topology: Add static_key for asymmetric CPU capacity optimizations")

In this particular case, we enable it because smp_prepare_cpus() will
end up fetching the capacity-dmips-mhz entry from the devicetree,
so we already have some asymmetry detected when entering sched_init_smp().

This didn't get detected in tip/sched/core because we were missing:

  commit cb538267ea1e ("jump_label/lockdep: Assert we hold the hotplug lock for _cpuslocked() operations")

Calls to build_sched_domains() post sched_init_smp() will hold the
hotplug lock, it just so happens that this very first call is a
special case. As stated by a comment in sched_init_smp(), "There's no
userspace yet to cause hotplug operations" so this is a harmless
warning.

However, to both respect the semantics of underlying
callees and make lockdep happy, take the hotplug lock in
sched_init_smp(). This also satisfies the comment atop
sched_init_domains() that says "Callers must hold the hotplug lock".

Reported-by: Sudeep Holla <sudeep.holla@arm.com>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Dietmar.Eggemann@arm.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: morten.rasmussen@arm.com
Cc: quentin.perret@arm.com
Link: http://lkml.kernel.org/r/1540301851-3048-1-git-send-email-valentin.schneider@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ad97f3ba5ec5..35551110d277 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5854,11 +5854,14 @@ void __init sched_init_smp(void)
 	/*
 	 * There's no userspace yet to cause hotplug operations; hence all the
 	 * CPU masks are stable and all blatant races in the below code cannot
-	 * happen.
+	 * happen. The hotplug lock is nevertheless taken to satisfy lockdep,
+	 * but there won't be any contention on it.
 	 */
+	cpus_read_lock();
 	mutex_lock(&sched_domains_mutex);
 	sched_init_domains(cpu_active_mask);
 	mutex_unlock(&sched_domains_mutex);
+	cpus_read_unlock();
 
 	/* Move init over to a non-isolated CPU */
 	if (set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_FLAG_DOMAIN)) < 0)
-- 
2.17.1

