Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0A1C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0892086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YY+D1gtR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="E+NndtMv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C0892086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeIDK5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 06:57:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50040 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbeIDK5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 06:57:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D0757607F7; Tue,  4 Sep 2018 06:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536042830;
        bh=MsGY8ib0tPhRcCEXecUovExlnWrd0B2L2l1G5cGNXFI=;
        h=From:To:Cc:Subject:Date:From;
        b=YY+D1gtRjKH2uLQ+f+crBB65ojRBCqD01rbfmWXR3oUYwwQWgXWnjdk26D7kuqtFf
         ktzOVOXJoLtiOQaiu165PC4k2IB/Vp0JnErAKJ9wozaJKVHx/n5PEtXxdVm1tGbrK3
         Wibq6zb3Uv2ytkhOKrU/TZvHl56N9PQqIjrEOG+Y=
Received: from neeraju-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 682D360388;
        Tue,  4 Sep 2018 06:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536042829;
        bh=MsGY8ib0tPhRcCEXecUovExlnWrd0B2L2l1G5cGNXFI=;
        h=From:To:Cc:Subject:Date:From;
        b=E+NndtMvRuk15IoPZlCxL5g6voZKlD9kmtffUZfekaVXg0ZEjQc0m1Vl1Z8ZK03rs
         3dOAtU7BPLGIFB/pBy8yvZZ4NlscWEC/BxIzM+zxAPhSeThM9gZCzeN+GMdk95J/gi
         Fxw0qKzkEwDmPs/staawmrMdaPFKtiY7fPZyKN/c=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 682D360388
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=neeraju@codeaurora.org
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
To:     tglx@linutronix.de, josh@joshtriplett.org, peterz@infradead.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dzickus@redhat.com,
        brendan.jackman@arm.com, malat@debian.org
Cc:     linux-kernel@vger.kernel.org, sramana@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH] cpu/hotplug: Fix rollback during error-out in takedown_cpu()
Date:   Tue,  4 Sep 2018 12:03:23 +0530
Message-Id: <1536042803-6152-1-git-send-email-neeraju@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If takedown_cpu() fails during _cpu_down(), st->state is reset,
by calling cpuhp_reset_state(). This results in an additional
increment of st->state, which results in CPUHP_AP_SMPBOOT_THREADS
state being skipped during rollback. Fix this by not calling
cpuhp_reset_state() and doing the state reset directly in
_cpu_down().

Fixes: 4dddfb5faa61 ("smp/hotplug: Rewrite AP state machine core")
Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 kernel/cpu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index aa7fe85..9f49edb 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -970,7 +970,14 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
 	 */
 	ret = cpuhp_down_callbacks(cpu, st, target);
 	if (ret && st->state > CPUHP_TEARDOWN_CPU && st->state < prev_state) {
-		cpuhp_reset_state(st, prev_state);
+		/*
+		 * As st->last is not set, cpuhp_reset_state() increments
+		 * st->state, which results in CPUHP_AP_SMPBOOT_THREADS being
+		 * skipped during rollback. So, don't use it here.
+		 */
+		st->rollback = true;
+		st->target = prev_state;
+		st->bringup = !st->bringup;
 		__cpuhp_kick_ap(st);
 	}
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

