Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD39C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C8B21104
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBVfEgKd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C8B21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731814AbeKTEYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:24:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:60520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730366AbeKTDAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:00:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EC5C2086A;
        Mon, 19 Nov 2018 16:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645387;
        bh=abLEzmd4TqcJ+zQW8RpUFf/uqxtqM1S8j4x0qr2vjBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oBVfEgKdLodyZT8ztYJPA4h78awPXmfBbRxnRtmwepE5ckW/jr3Xr05VdyWpHpeJh
         TRczxN/BZ1+K8EHVK7EpKFA5KpC28aZAzrMGm3879Og07c6hJZyEaDEC6nsf3i7UP+
         X9vW67qfaElgOcgGChrWNb76kGo0oypaCzJ9setc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 4.19 106/205] ARM: 8809/1: proc-v7: fix Thumb annotation of cpu_v7_hvc_switch_mm
Date:   Mon, 19 Nov 2018 17:26:53 +0100
Message-Id: <20181119162633.996059388@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

commit 6282e916f774e37845c65d1eae9f8c649004f033 upstream.

Due to what appears to be a copy/paste error, the opening ENTRY()
of cpu_v7_hvc_switch_mm() lacks a matching ENDPROC(), and instead,
the one for cpu_v7_smc_switch_mm() is duplicated.

Given that it is ENDPROC() that emits the Thumb annotation, the
cpu_v7_hvc_switch_mm() routine will be called in ARM mode on a
Thumb2 kernel, resulting in the following splat:

  Internal error: Oops - undefined instruction: 0 [#1] SMP THUMB2
  Modules linked in:
  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.18.0-rc1-00030-g4d28ad89189d-dirty #488
  Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
  PC is at cpu_v7_hvc_switch_mm+0x12/0x18
  LR is at flush_old_exec+0x31b/0x570
  pc : [<c0316efe>]    lr : [<c04117c7>]    psr: 00000013
  sp : ee899e50  ip : 00000000  fp : 00000001
  r10: eda28f34  r9 : eda31800  r8 : c12470e0
  r7 : eda1fc00  r6 : eda53000  r5 : 00000000  r4 : ee88c000
  r3 : c0316eec  r2 : 00000001  r1 : eda53000  r0 : 6da6c000
  Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none

Note the 'ISA ARM' in the last line.

Fix this by using the correct name in ENDPROC().

Cc: <stable@vger.kernel.org>
Fixes: 10115105cb3a ("ARM: spectre-v2: add firmware based hardening")
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/mm/proc-v7.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -112,7 +112,7 @@ ENTRY(cpu_v7_hvc_switch_mm)
 	hvc	#0
 	ldmfd	sp!, {r0 - r3}
 	b	cpu_v7_switch_mm
-ENDPROC(cpu_v7_smc_switch_mm)
+ENDPROC(cpu_v7_hvc_switch_mm)
 #endif
 ENTRY(cpu_v7_iciallu_switch_mm)
 	mov	r3, #0


