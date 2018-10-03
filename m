Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919B0C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598832082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YMHHpwDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 598832082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbeJCWap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:30:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41964 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeJCWap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sS023jMjNpbPElBrK0hX1qr4JH/Ikqoc1XYy7kVV7Yg=; b=YMHHpwDVsRkohJtH2mFLU1Zax
        d/NPBL3X26omG9K9Lsw7eHjsYHaaxr51oKPPCZwVX364R41eHuu+lWNmC3EDhMAJJaBZqirXlFT7a
        MLCrBuw7SFLon58YHuxSoEEKc0UbUdtNizcXH9SGD297fexuucrLoWB/Dg+lfeHUcQqNckeFUfIZR
        ny/4s8QqQbrqT6v0q2vhomMPrBUB4wlFTOz0JAE/60ufvAjUFA5VofGeag7Xw6M0MDXbE/zA+85DT
        midfsO5AzoF3U/rNKFdijVQuExaViN2O+lxaOYGwP5t4wOW1PNeTzqXJBYHY5Rkyl/s4LoYmTm4y6
        FtT+tM4AQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7jHR-00030s-6Y; Wed, 03 Oct 2018 15:41:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DDFE1202C1A17; Wed,  3 Oct 2018 17:41:32 +0200 (CEST)
Date:   Wed, 3 Oct 2018 17:41:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kan Liang <kan.liang@linux.intel.com>, mingo@redhat.com,
        acme@kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
        ak@linux.intel.com, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH] perf/x86/intel: Add counter freezing quirk for Goldmont
Message-ID: <20181003154132.GA19272@hirez.programming.kicks-ass.net>
References: <1538515812-8808-1-git-send-email-kan.liang@linux.intel.com>
 <alpine.DEB.2.21.1810030803260.1435@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810030803260.1435@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 08:10:31AM +0200, Thomas Gleixner wrote:
> On Tue, 2 Oct 2018, kan.liang@linux.intel.com wrote:
> 
> There is another variant of model/stepping micro code verification code in
> intel_snb_pebs_broken(). Can we please make this table based and use a
> common function? That's certainly not the last quirk we're going to have.
> 
> We already have a table based variant of ucode checking in
> bad_spectre_microcode(). It's trivial enough to generalize that.

apic_check_deadline_errata() is another one. That one already uses the
x86_cpu_id thing, but still plays silly games for steppings. So if we're
going to build a new microcode table matcher...
