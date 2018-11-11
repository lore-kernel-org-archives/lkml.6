Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42ED7C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0679A20872
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBgphLud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0679A20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732903AbeKLISc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:18:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:37584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732848AbeKLISa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:30 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A34C2175B;
        Sun, 11 Nov 2018 22:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975314;
        bh=sK96i5YP9udCKP0ERLW/GwVrs+XGEA94k1LI65yRJx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aBgphLud0ufD6W6H1tJAd/jZJakx1vogddbJFpqSURLubA5BAb1sOizhJFGD/eKoy
         vUFrwe4OzcKZu/Ysz2K4+ijlrSiFiKdTghTfsjQIb6gPb13AGdhBcGsulBRAZ4gx+d
         mgaKI6eLpHpD2VfqCsQq2Du42aWa1tVZ5H9XCcfw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.19 283/361] powerpc/64s/hash: Do not use PPC_INVALIDATE_ERAT on CPUs before POWER9
Date:   Sun, 11 Nov 2018 14:20:30 -0800
Message-Id: <20181111221656.049774374@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
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

From: Nicholas Piggin <npiggin@gmail.com>

commit bc276ecba132caccb1fda5863a652c15def2b8c6 upstream.

PPC_INVALIDATE_ERAT is slbia IH=7 which is a new variant introduced
with POWER9, and the result is undefined on earlier CPUs.

Commits 7b9f71f974 ("powerpc/64s: POWER9 machine check handler") and
d4748276ae ("powerpc/64s: Improve local TLB flush for boot and MCE on
POWER9") caused POWER7/8 code to use this instruction. Remove it. An
ERAT flush can be made by invalidatig the SLB, but before POWER9 that
requires a flush and rebolt.

Fixes: 7b9f71f974 ("powerpc/64s: POWER9 machine check handler")
Fixes: d4748276ae ("powerpc/64s: Improve local TLB flush for boot and MCE on POWER9")
Cc: stable@vger.kernel.org # v4.11+
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/mce_power.c  |    7 +++++++
 arch/powerpc/mm/hash_native_64.c |    4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -89,6 +89,13 @@ static void flush_and_reload_slb(void)
 
 static void flush_erat(void)
 {
+#ifdef CONFIG_PPC_BOOK3S_64
+	if (!early_cpu_has_feature(CPU_FTR_ARCH_300)) {
+		flush_and_reload_slb();
+		return;
+	}
+#endif
+	/* PPC_INVALIDATE_ERAT can only be used on ISA v3 and newer */
 	asm volatile(PPC_INVALIDATE_ERAT : : :"memory");
 }
 
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -115,6 +115,8 @@ static void tlbiel_all_isa300(unsigned i
 	tlbiel_hash_set_isa300(0, is, 0, 2, 1);
 
 	asm volatile("ptesync": : :"memory");
+
+	asm volatile(PPC_INVALIDATE_ERAT "; isync" : : :"memory");
 }
 
 void hash__tlbiel_all(unsigned int action)
@@ -140,8 +142,6 @@ void hash__tlbiel_all(unsigned int actio
 		tlbiel_all_isa206(POWER7_TLB_SETS, is);
 	else
 		WARN(1, "%s called on pre-POWER7 CPU\n", __func__);
-
-	asm volatile(PPC_INVALIDATE_ERAT "; isync" : : :"memory");
 }
 
 static inline unsigned long  ___tlbie(unsigned long vpn, int psize,


