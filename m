Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72209C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460F62082C
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbfBCODw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:03:52 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:54856 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728181AbfBCODr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:03:47 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIEO-0003tt-Da; Sun, 03 Feb 2019 13:54:44 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9u-0007Re-Il; Sun, 03 Feb 2019 14:50:06 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>,
        "Dmitry Bilunov" <kmeaw@yandex-team.ru>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.781946896@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 292/305] KVM: Handle MSR_IA32_PERF_CTL
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Bilunov <kmeaw@yandex-team.ru>

commit 0c2df2a1affd183ba9c114915f42a2d464b4f58f upstream.

Intel CPUs having Turbo Boost feature implement an MSR to provide a
control interface via rdmsr/wrmsr instructions. One could detect the
presence of this feature by issuing one of these instructions and
handling the #GP exception which is generated in case the referenced MSR
is not implemented by the CPU.

KVM's vCPU model behaves exactly as a real CPU in this case by injecting
a fault when MSR_IA32_PERF_CTL is called (which KVM does not support).
However, some operating systems use this register during an early boot
stage in which their kernel is not capable of handling #GP correctly,
causing #DP and finally a triple fault effectively resetting the vCPU.

This patch implements a dummy handler for MSR_IA32_PERF_CTL to avoid the
crashes.

Signed-off-by: Dmitry Bilunov <kmeaw@yandex-team.ru>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kvm/x86.c | 1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2461,6 +2461,7 @@ int kvm_get_msr_common(struct kvm_vcpu *
 	case MSR_AMD64_NB_CFG:
 	case MSR_FAM10H_MMIO_CONF_BASE:
 	case MSR_AMD64_BU_CFG2:
+	case MSR_IA32_PERF_CTL:
 		msr_info->data = 0;
 		break;
 	case MSR_P6_PERFCTR0:

