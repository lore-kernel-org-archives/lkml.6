Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBC1C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE26206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546976794;
	bh=ws06QMiXAOzxhRvDDCKCriZfLflRfuPdMXvIPpcR52g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LVS4XYjnM7/phvk8Opmh2N+d8kWZfws2Pn7qv6LXOj5tMsS8VHvJTogugDIB3QLV8
	 hLq44HbFHhgVXjSwwrM7L/F8ubtoRR9crHhwMEW+7At+Z0qOjp/WQyjj+KwrLCiNOY
	 ZDj4FayTg5ULJjVslyFsVADBknsdmcIccRJbXtE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731545AbfAHTdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:33:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:41702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731508AbfAHTc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:32:57 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B21520665;
        Tue,  8 Jan 2019 19:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975976;
        bh=ws06QMiXAOzxhRvDDCKCriZfLflRfuPdMXvIPpcR52g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xxt3BN3sRUsMeXx5jfqg6hHilUiEdT7yZgS2pUkdmxQ+VqQNAPZhtXBV9A+oCBS3S
         vhh4NzA4lLklTiKBLI+7U3Uc4xrFMvU0tjnQ0eVcA80ntf7nolv+5XA/4YdZxguUjs
         ML06Re2/ISxM9VPtl7roOa+RKHtdv6gQZuQUNrQc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Breno Leitao <leitao@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.14 19/53] powerpc/pseries/cpuidle: Fix preempt warning
Date:   Tue,  8 Jan 2019 14:31:47 -0500
Message-Id: <20190108193222.123316-19-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108193222.123316-1-sashal@kernel.org>
References: <20190108193222.123316-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 2b038cbc5fcf12a7ee1cc9bfd5da1e46dacdee87 ]

When booting a pseries kernel with PREEMPT enabled, it dumps the
following warning:

   BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
   caller is pseries_processor_idle_init+0x5c/0x22c
   CPU: 13 PID: 1 Comm: swapper/0 Not tainted 4.20.0-rc3-00090-g12201a0128bc-dirty #828
   Call Trace:
   [c000000429437ab0] [c0000000009c8878] dump_stack+0xec/0x164 (unreliable)
   [c000000429437b00] [c0000000005f2f24] check_preemption_disabled+0x154/0x160
   [c000000429437b90] [c000000000cab8e8] pseries_processor_idle_init+0x5c/0x22c
   [c000000429437c10] [c000000000010ed4] do_one_initcall+0x64/0x300
   [c000000429437ce0] [c000000000c54500] kernel_init_freeable+0x3f0/0x500
   [c000000429437db0] [c0000000000112dc] kernel_init+0x2c/0x160
   [c000000429437e20] [c00000000000c1d0] ret_from_kernel_thread+0x5c/0x6c

This happens because the code calls get_lppaca() which calls
get_paca() and it checks if preemption is disabled through
check_preemption_disabled().

Preemption should be disabled because the per CPU variable may make no
sense if there is a preemption (and a CPU switch) after it reads the
per CPU data and when it is used.

In this device driver specifically, it is not a problem, because this
code just needs to have access to one lppaca struct, and it does not
matter if it is the current per CPU lppaca struct or not (i.e. when
there is a preemption and a CPU migration).

That said, the most appropriate fix seems to be related to avoiding
the debug_smp_processor_id() call at get_paca(), instead of calling
preempt_disable() before get_paca().

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpuidle/cpuidle-pseries.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index a187a39fb866..7f21c6a57178 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -239,7 +239,13 @@ static int pseries_idle_probe(void)
 		return -ENODEV;
 
 	if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
-		if (lppaca_shared_proc(get_lppaca())) {
+		/*
+		 * Use local_paca instead of get_lppaca() since
+		 * preemption is not disabled, and it is not required in
+		 * fact, since lppaca_ptr does not need to be the value
+		 * associated to the current CPU, it can be from any CPU.
+		 */
+		if (lppaca_shared_proc(local_paca->lppaca_ptr)) {
 			cpuidle_state_table = shared_states;
 			max_idle_state = ARRAY_SIZE(shared_states);
 		} else {
-- 
2.19.1

