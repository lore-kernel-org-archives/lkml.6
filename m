Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472CDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4C92148E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mV9MU+iJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F4C92148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406827AbeKTD3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:29:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:44428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406762AbeKTD3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:29:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2601B214DA;
        Mon, 19 Nov 2018 17:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542647123;
        bh=IulhjosOKyxX6XWZOThxxzN98EQprnHatfCoRkKK3SM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mV9MU+iJjwDz8dnAP/q23cfAr7v2p5zS38RtX2338kIDVHIKV23K3LlC+ysJ9IxQj
         Ut4o7/+qnac6fdTOKHGdZaaXUZM6XB3uj/cticvLOuTTLQXyqC4b4jxB3iVvmP3Keo
         TlkbKLKWhBjx/ELIVAEEKkhEriCmHmwpAqEmI98s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dengcheng Zhu <dzhu@wavecomp.com>,
        Paul Burton <paul.burton@mips.com>, pburton@wavecomp.com,
        ralf@linux-mips.org, linux-mips@linux-mips.org,
        rachel.mozes@intel.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 58/90] MIPS: kexec: Mark CPU offline before disabling local IRQ
Date:   Mon, 19 Nov 2018 17:29:40 +0100
Message-Id: <20181119162630.131797951@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162620.585061184@linuxfoundation.org>
References: <20181119162620.585061184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dengcheng Zhu <dzhu@wavecomp.com>

[ Upstream commit dc57aaf95a516f70e2d527d8287a0332c481a226 ]

After changing CPU online status, it will not be sent any IPIs such as in
__flush_cache_all() on software coherency systems. Do this before disabling
local IRQ.

Signed-off-by: Dengcheng Zhu <dzhu@wavecomp.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/20571/
Cc: pburton@wavecomp.com
Cc: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Cc: rachel.mozes@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/kernel/crash.c         |    3 +++
 arch/mips/kernel/machine_kexec.c |    3 +++
 2 files changed, 6 insertions(+)

--- a/arch/mips/kernel/crash.c
+++ b/arch/mips/kernel/crash.c
@@ -34,6 +34,9 @@ static void crash_shutdown_secondary(voi
 	if (!cpu_online(cpu))
 		return;
 
+	/* We won't be sent IPIs any more. */
+	set_cpu_online(cpu, false);
+
 	local_irq_disable();
 	if (!cpu_isset(cpu, cpus_in_crash))
 		crash_save_cpu(regs, cpu);
--- a/arch/mips/kernel/machine_kexec.c
+++ b/arch/mips/kernel/machine_kexec.c
@@ -95,6 +95,9 @@ machine_kexec(struct kimage *image)
 			*ptr = (unsigned long) phys_to_virt(*ptr);
 	}
 
+	/* Mark offline BEFORE disabling local irq. */
+	set_cpu_online(smp_processor_id(), false);
+
 	/*
 	 * we do not want to be bothered.
 	 */


