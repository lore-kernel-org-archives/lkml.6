Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A29C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE7622496
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h1GrsWOU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE7622496
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933985AbeFUWLd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 18:11:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59046 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933940AbeFUWLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 18:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Lw6iQC4U0bPerWM08hnCpm4iR/9rVFXoaaf93W0Lz54=; b=h1GrsWOUjEoqlfcSey0g6lwSU
        6CteLb9oEYoAZmgbJ3KOOi4gEHUcvPLP7kLPaeatV1HElJWIXiOTqbac3KXbtSZmuHvk1jXjgkoJX
        JY1bpGQy2v/jcXODqkoLLApP/F9VCtvLdMCfBdslq4BLZxsmwbS5lxJRcKtKs/pjoSLjXdzU3NVmC
        N+LSYxOtNeF3lu9SW+GgNiNlzYa2annJZSk6Z+RQao+z4/Nw09aVlDIlbGIye83e160YN1V9+eUEY
        2FBwmGBG7IwcIh1teQ9skzrr/oR6Sh/rtwK38Hb3IKh/PtByroY9KGTAK0uhrZVmpSj/4gGoDIKRn
        KTAyU7T2Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW7nP-0001Zu-LF; Thu, 21 Jun 2018 22:11:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 282FA2029F1D7; Fri, 22 Jun 2018 00:11:14 +0200 (CEST)
Date:   Fri, 22 Jun 2018 00:11:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 00/16] x86/split_lock: Enable #AC exception for split
 locked accesses
Message-ID: <20180621221114.GD2494@hirez.programming.kicks-ass.net>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
 <20180621193738.GA13636@worktop.programming.kicks-ass.net>
 <20180621201851.GC114883@romley-ivt3.sc.intel.com>
 <alpine.DEB.2.21.1806212223480.1591@nanos.tec.linutronix.de>
 <20180621220003.GD114883@romley-ivt3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621220003.GD114883@romley-ivt3.sc.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 03:00:03PM -0700, Fenghua Yu wrote:
> The control knob for user is to choose killing the process (default) or
> re-executing the faulting instruction without blocking the process.
> Re-executing the instruction maybe be useful in platforms that run
> well controlled apps with less split locks.

Just fix the applications. I doubt there will be many, many other
platforms will already SIGBUS on unaligned access, atomic or not.
