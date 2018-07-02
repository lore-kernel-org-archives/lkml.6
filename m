Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B95C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A654725CC2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="neHeWtkZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A654725CC2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752639AbeGBMTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:19:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36234 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752428AbeGBMTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aQA14AgAeiOOiC4rYbFW53imUVd4Qn0YAM86rrZbrig=; b=neHeWtkZqt4JpJ4SxI6k0Ej3r
        BXqXhH/HzbArttG3zEPiAKFNttiPJMoOWBZEhABfhIE7haw1KtZhdPdFrnwTFV+eyGBe7OEdaJ1mg
        mMUMLMyRANNzbCBAp0moQbdUQCf3g/UfbaZ3BPPIxvdjlzUykiyVLUQx2WEIJz3nAOkW8fJc+5MfU
        Sk95X20/yrthNgGtyVsbZNCIb2/vEn9c8UcDILG8R5UjNf29fAi01FWXSyllVtAyN/YmPQjpyrLPE
        uOy/J0U1RQSMPEdIETOnnx47TRUen2tZjl9Z9uDh5KDtsPmFkLC14lt/63l8RE/nZg53fCeHg2SOT
        owRfFURFQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fZxnI-0006IX-Sq; Mon, 02 Jul 2018 12:19:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5C73D2029F1D9; Mon,  2 Jul 2018 14:18:59 +0200 (CEST)
Date:   Mon, 2 Jul 2018 14:18:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v2 2/4] x86/split_lock: Align x86_capability to unsigned
 long to avoid split locked access
Message-ID: <20180702121859.GL2494@hirez.programming.kicks-ass.net>
References: <1530282807-66555-1-git-send-email-fenghua.yu@intel.com>
 <1530282807-66555-3-git-send-email-fenghua.yu@intel.com>
 <ae0b8cb1-a8a9-f0ef-3c20-f4fe4b9b6f4a@intel.com>
 <alpine.DEB.2.21.1806291824010.1595@nanos.tec.linutronix.de>
 <20180629190346.GO18979@romley-ivt3.sc.intel.com>
 <alpine.DEB.2.21.1806292148510.1595@nanos.tec.linutronix.de>
 <20180629203844.GA68178@romley-ivt3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629203844.GA68178@romley-ivt3.sc.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 01:38:44PM -0700, Fenghua Yu wrote:
> include/linux/efi.h because set_bit() sets bits in efi.flags:
> -       unsigned long flags;
> +       unsigned long flags __aligned(unsigned long);
>  } efi;

Help me out here; how is the above change not a complete no-op?
