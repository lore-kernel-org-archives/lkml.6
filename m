Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429DEC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 04:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B5E2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 04:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="KiTlePbB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B5E2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbeLNEIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 23:08:37 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46183 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbeLNEIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 23:08:37 -0500
Received: by mail-qk1-f196.google.com with SMTP id q1so2512872qkf.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 20:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WVG1s8uPH9QZYQD2OxlIfEzK4+hEPnhFvyzAce4PHvA=;
        b=KiTlePbBFxTtN7GPW74DQYa3U94/yABfYM3zZIOuI69NzSPIQBYAzaShj+ppeMi+WH
         Ex5BlTolbeCmfdDOTUZGrMHUp0HhkKFVlx9gesOnb2GaI0rY28SoyqaNtYZO3NFWSYes
         o/rIvaOz7G8sxScqFfBnO5cqGsShimouIf374zek1l3VlKdWppY9msOLDxMKLuaDzhi6
         aQJ+Q5XmZR0+TnkbaOatMAOmhbuBkIAQEtkJbK+W+mT79gDOuDik9SehQ17AhlPEz4AY
         4A2aPewPqCIdYjz9IsQXN9ezSpHpWPfcYFjRYjFvwdV7SwAtCkLfqW8o+9Ye52J2aI6o
         058w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WVG1s8uPH9QZYQD2OxlIfEzK4+hEPnhFvyzAce4PHvA=;
        b=n7tc96jgplhGz9vDaxMZPatwE13rCEMnc0N5fn4gu7/6h7UM8xexrAyLOVJDScCRwP
         NeWT48Xv9NzhokskODastkpNPrbITdCPFh3e6JB/9xpEGVrX5Au7/k9ZditKBNFDFZmF
         6DTEjT86/zrK1edUjXb89NvkitN5MRmGz8HYOW6kIRAgylmjvb0dcOfH+x46XTzB195K
         18vCVm7UsmHWsV4r2izObXZrl4fBFlvKuwtOCHAzKzGD4grxRzfyQbB7IdATfNDHvMHL
         MFftc1EUuqKOG4IVupyPZeawvvoPb0j3uRXQrtxjZ11y2bUsGTxc/zGBAK9ZHKcop3T7
         MGHw==
X-Gm-Message-State: AA+aEWYVjUKHUbWAX8xGvrZ6ozghobu1c/li5zZt5LDozH3bve3N5qyr
        VKixtiuqqoemlUzXi/8KvvQf9Q==
X-Google-Smtp-Source: AFSGD/VfQUhFS+ZhtP6Rq287/qYBYAPaa8NsHUt0SEnoxZvu1baeVGS/bEtXoSh5T/Ub1wfMeq/ycA==
X-Received: by 2002:a37:2e42:: with SMTP id u63mr1208090qkh.249.1544760515746;
        Thu, 13 Dec 2018 20:08:35 -0800 (PST)
Received: from ovpn-121-90.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id a185sm2201187qkb.1.2018.12.13.20.08.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 20:08:35 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     catalin.marinas@arm.com, will.deacon@arm.com
Cc:     marc.zyngier@arm.com, james.morse@arm.com,
        takahiro.akashi@linaro.org, ard.biesheuvel@linaro.org,
        linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH v2] arm64: invalidate TLB just before turning MMU on
Date:   Thu, 13 Dec 2018 23:08:19 -0500
Message-Id: <20181214040819.58625-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20181213052259.56352-1-cai@lca.pw>
References: <20181213052259.56352-1-cai@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On this HPE Apollo 70 arm64 server with 256 CPUs, triggering a crash
dump just hung. It has 4 threads on each core. Each 2-core share a same
L1 and L2 caches, so that is 8 CPUs shares those. All CPUs share a same
L3 cache.

It turned out that this was due to the TLB contained stale entries (or
uninitialized junk which just happened to look valid) before turning the
MMU on in the second kernel which caused this instruction hung,

msr	sctlr_el1, x0

Although there is a local TLB flush in the second kernel in
__cpu_setup(), it is called too early. When the time to turn the MMU on
later, the TLB is dirty again from some reasons.

Also tried to move the local TLB flush part around a bit inside
__cpu_setup(), although it did complete kdump some times, it did trigger
"Synchronous Exception" in EFI after a cold-reboot fairly often that
seems no way to recover remotely without reinstalling the OS. For
example, in those places,

ENTRY(__cpu_setup)
+	isb
	tlbi	vmalle1
	dsb	nsh

or

	mov	x0, #3 << 20
	msr	cpacr_el1, x0
+	tlbi    vmalle1
+	dsb     nsh

Since it is only necessary to flush local TLB right before turning the
MMU on, just re-arrage the part a bit like the one in __primary_switch()
within CONFIG_RANDOMIZE_BASE path, so it does not depends on other
instructions in between that could pollute the TLB, and it no longer
trigger "Synchronous Exception" as well.

Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: merge the similar part from __cpu_setup() pointed out by James.

 arch/arm64/kernel/head.S | 4 ++++
 arch/arm64/mm/proc.S     | 3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 4471f570a295..7f555dd4577e 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -771,6 +771,10 @@ ENTRY(__enable_mmu)
 	msr	ttbr0_el1, x2			// load TTBR0
 	msr	ttbr1_el1, x1			// load TTBR1
 	isb
+
+	tlbi	vmalle1				// invalidate TLB
+	dsb	nsh
+
 	msr	sctlr_el1, x0
 	isb
 	/*
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 2c75b0b903ae..14f68afdd57f 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -406,9 +406,6 @@ ENDPROC(idmap_kpti_install_ng_mappings)
  */
 	.pushsection ".idmap.text", "awx"
 ENTRY(__cpu_setup)
-	tlbi	vmalle1				// Invalidate local TLB
-	dsb	nsh
-
 	mov	x0, #3 << 20
 	msr	cpacr_el1, x0			// Enable FP/ASIMD
 	mov	x0, #1 << 12			// Reset mdscr_el1 and disable
-- 
2.17.2 (Apple Git-113)

