Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CD2C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39F020645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B39F020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbeJNXhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:37:41 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36022 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727668AbeJNXLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:54 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLh-0004cD-TZ; Sun, 14 Oct 2018 16:30:34 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLa-0000io-97; Sun, 14 Oct 2018 16:30:26 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Michael Neuling" <mikey@neuling.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.217205595@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 332/366] powerpc/64s: Clear PCR on boot
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Neuling <mikey@neuling.org>

commit faf37c44a105f3608115785f17cbbf3500f8bc71 upstream.

Clear the PCR (Processor Compatibility Register) on boot to ensure we
are not running in a compatibility mode.

We've seen this cause problems when a crash (and kdump) occurs while
running compat mode guests. The kdump kernel then runs with the PCR
set and causes problems. The symptom in the kdump kernel (also seen in
petitboot after fast-reboot) is early userspace programs taking
sigills on newer instructions (seen in libc).

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
[bwh: Backported to 3.16: Drop changes in __{setup,restore}_cpu_power9
 and __restore_cpu_cpufeatures()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -27,6 +27,7 @@ _GLOBAL(__setup_cpu_power7)
 	beqlr
 	li	r0,0
 	mtspr	SPRN_LPID,r0
+	mtspr	SPRN_PCR,r0
 	mfspr	r3,SPRN_LPCR
 	bl	__init_LPCR
 	bl	__init_tlb_power7
@@ -40,6 +41,7 @@ _GLOBAL(__restore_cpu_power7)
 	beqlr
 	li	r0,0
 	mtspr	SPRN_LPID,r0
+	mtspr	SPRN_PCR,r0
 	mfspr	r3,SPRN_LPCR
 	bl	__init_LPCR
 	bl	__init_tlb_power7
@@ -55,6 +57,7 @@ _GLOBAL(__setup_cpu_power8)
 	beqlr
 	li	r0,0
 	mtspr	SPRN_LPID,r0
+	mtspr	SPRN_PCR,r0
 	mfspr	r3,SPRN_LPCR
 	ori	r3, r3, LPCR_PECEDH
 	bl	__init_LPCR
@@ -74,6 +77,7 @@ _GLOBAL(__restore_cpu_power8)
 	beqlr
 	li	r0,0
 	mtspr	SPRN_LPID,r0
+	mtspr	SPRN_PCR,r0
 	mfspr   r3,SPRN_LPCR
 	ori	r3, r3, LPCR_PECEDH
 	bl	__init_LPCR

