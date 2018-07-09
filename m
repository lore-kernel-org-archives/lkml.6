Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E079CC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A5B20881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HA8ketiF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A5B20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932789AbeGIJXB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:23:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39426 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932241AbeGIJW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KWOj7qFmFEURuu4N1y/wrecXj0PqeZ+USMPyxWQVuRI=; b=HA8ketiFmix1gHSLIxLdHAOUp
        /t1N6aj78pVYgwOFjthqgb3r/2kmaaFLFWpPnBSK7R8a/gufAtmdLSdrJoFUCYfK1GJvyYS+UFGrA
        1QZ3CRDXil9dnL0iCqUfU65r8DCH1t1bG3aeueclP4ZtHBxsgvDNTUxtfwdrTp8FGVO4EyeBn8tt2
        nZ4GmNZVprDaJbVNYu83HpudQyiQr4yJBGAZJk00VkYsI4fZsp0JkbYcKFXXUymhh4Cq3gaxFREsJ
        vneb1BOCXkQBxX0+qlyjIOKFUeNh0xg1i9ZsxUUFR4/+CegXGd6+7PrjRy1RxAsu49BnoyVzvuY82
        aWS2XAviA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcSNZ-0004VE-Cd; Mon, 09 Jul 2018 09:22:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B80E72028932D; Mon,  9 Jul 2018 11:22:43 +0200 (CEST)
Date:   Mon, 9 Jul 2018 11:22:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        x86@kernel.org, kvm@vger.kernel.org
Subject: [patch 8/7] x86/kvmclock: Avoid TSC recalibration
Message-ID: <20180709092243.GG2476@hirez.programming.kicks-ass.net>
References: <20180706161307.733337643@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706161307.733337643@linutronix.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


If the host gives us a TSC rate, assume it is good and don't try and
recalibrate things against virtual timer hardware.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -140,7 +140,16 @@ static inline void kvm_sched_clock_init(
  */
 static unsigned long kvm_get_tsc_khz(void)
 {
-	return pvclock_tsc_khz(this_cpu_pvti());
+	unsigned long tsc_khz = pvclock_tsc_khz(this_cpu_pvti());
+
+	/*
+	 * TSC frequency is reported by the host; calibration against (virtual)
+	 * HPET/PM-timer in a guest is dodgy and pointless since the host already
+	 * did it for us where required.
+	 */
+	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
+
+	return tsc_khz;
 }
 
 static void kvm_get_preset_lpj(void)
