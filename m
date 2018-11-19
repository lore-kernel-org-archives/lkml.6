Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9128BC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593A82145D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZclziWt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593A82145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404142AbeKTDT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:19:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:59212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404132AbeKTDT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:19:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D22EE2145D;
        Mon, 19 Nov 2018 16:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646544;
        bh=tztlRvucgkSc95eCm6Wikt7R9F/KWJIvbDSMSLkpA+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pZclziWtjqq9Rs3wgtD9cvtu0iYalVLDKFehzkkLdUjk7pCUhe343Ognq3aBhoE0T
         zmD6Q4Aq12YbGtsjMvauYZvlHkbX0eWZVRY7ITSm86QpOYQLca+EI+ANo2SR1d2wJL
         1XT/7UEAjXL9vFQm8Yn7uigxA/FgCQ8tM8IlicG0=
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
Subject: [PATCH 4.9 82/83] KVM: arm64: Fix caching of host MDCR_EL2 value
Date:   Mon, 19 Nov 2018 17:29:48 +0100
Message-Id: <20181119162627.621351252@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.046511542@linuxfoundation.org>
References: <20181119162612.046511542@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 arch/arm/kvm/arm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -1092,8 +1092,6 @@ static void cpu_init_hyp_mode(void *dumm
 
 	__cpu_init_hyp_mode(pgd_ptr, hyp_stack_ptr, vector_ptr);
 	__cpu_init_stage2();
-
-	kvm_arm_init_debug();
 }
 
 static void cpu_hyp_reinit(void)
@@ -1108,6 +1106,8 @@ static void cpu_hyp_reinit(void)
 		if (__hyp_get_vectors() == hyp_default_vectors)
 			cpu_init_hyp_mode(NULL);
 	}
+
+	kvm_arm_init_debug();
 }
 
 static void cpu_hyp_reset(void)


