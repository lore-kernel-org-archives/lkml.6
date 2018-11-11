Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB11C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8838A20872
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4PYkpSd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8838A20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404041AbeKLIqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:46:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:54620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403874AbeKLIWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:53 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB1052243E;
        Sun, 11 Nov 2018 22:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975576;
        bh=7Yr2wb0NIdTkYOitdsKrY4fA6di1vmuy9wtp3CXTeCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i4PYkpSdAMtsPVLfz86bcloTS+7gsQDkoh1PtbimHthPa0j68jc+7SsSuPlkMyMZn
         4N3p0uZBIbNqq1bEWrb0WqqMayA/JgbataqE1MBOMIkyFV59h4/ZVeOCgKQgCvXDY0
         orXGZU4bHB1UKJOrbSUgO8+/8omVrExk/vJEvlZ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christopher Dall <christoffer.dall@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.14 157/222] KVM: arm64: Fix caching of host MDCR_EL2 value
Date:   Sun, 11 Nov 2018 14:24:14 -0800
Message-Id: <20181111221701.367448114@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>

commit da5a3ce66b8bb51b0ea8a89f42aac153903f90fb upstream.

At boot time, KVM stashes the host MDCR_EL2 value, but only does this
when the kernel is not running in hyp mode (i.e. is non-VHE). In these
cases, the stashed value of MDCR_EL2.HPMN happens to be zero, which can
lead to CONSTRAINED UNPREDICTABLE behaviour.

Since we use this value to derive the MDCR_EL2 value when switching
to/from a guest, after a guest have been run, the performance counters
do not behave as expected. This has been observed to result in accesses
via PMXEVTYPER_EL0 and PMXEVCNTR_EL0 not affecting the relevant
counters, resulting in events not being counted. In these cases, only
the fixed-purpose cycle counter appears to work as expected.

Fix this by always stashing the host MDCR_EL2 value, regardless of VHE.

Cc: Christopher Dall <christoffer.dall@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: stable@vger.kernel.org
Fixes: 1e947bad0b63b351 ("arm64: KVM: Skip HYP setup when already running in HYP")
Tested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 virt/kvm/arm/arm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -1148,8 +1148,6 @@ static void cpu_init_hyp_mode(void *dumm
 
 	__cpu_init_hyp_mode(pgd_ptr, hyp_stack_ptr, vector_ptr);
 	__cpu_init_stage2();
-
-	kvm_arm_init_debug();
 }
 
 static void cpu_hyp_reset(void)
@@ -1173,6 +1171,8 @@ static void cpu_hyp_reinit(void)
 		cpu_init_hyp_mode(NULL);
 	}
 
+	kvm_arm_init_debug();
+
 	if (vgic_present)
 		kvm_vgic_init_cpu_hardware();
 }


