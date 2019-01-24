Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5A0C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF5A218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358881;
	bh=fzAL4xsGPXkR4JBvlPSzXhiruQJoHf7g558ljgfGys4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=njVXBZwzN1UE9TSAOQoppAm9bpZqzek4bYwB8hOQDyrekymJZugRn0t9ENMR2uIaO
	 r/KxfBwsZ2lzCED5qJKvupd2eJ7EoXsvqUUxUuAFRhRAQoxx/ASOzHyG+nvnb2QG8R
	 Z2o1dQSIjX7dm/Hb6Rnb6BrUE9VQBk/B/1/Aj1Yg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732101AbfAXTlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:41:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:41556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732752AbfAXTlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:41:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9BCA218D0;
        Thu, 24 Jan 2019 19:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358875;
        bh=fzAL4xsGPXkR4JBvlPSzXhiruQJoHf7g558ljgfGys4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NxeMxFWt6etRZ1k9RIbcfOUbSdm1KBzVK/lmcpuO+CijSOLOTnKL66+07R2n0jmpr
         MEOBMtAgYt7yKKkkDYssDEM9pBhdBSYawtZVAkwaKdVEvgoLhsXrAtPVFtml6feozi
         R/oAyRTz9h7Qfy3wCm58Zw/a8caZ2R2mDm6vNXmg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Breno Leitao <leitao@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 057/127] powerpc/pseries/cpuidle: Fix preempt warning
Date:   Thu, 24 Jan 2019 20:20:03 +0100
Message-Id: <20190124190214.611847638@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 9e56bc411061..74c247972bb3 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -247,7 +247,13 @@ static int pseries_idle_probe(void)
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



