Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532CBC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A3D121708
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A3D121708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbeHHHc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 03:32:59 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50410 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbeHHHc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 03:32:59 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fnGo9-0003RO-1W; Wed, 08 Aug 2018 07:14:53 +0200
Date:   Wed, 8 Aug 2018 07:14:52 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andi Kleen <ak@linux.intel.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        kan.liang@linux.intel.com, mingo@redhat.com, len.brown@intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/cpu: Rename Denverton and Gemini Lake
In-Reply-To: <20180807221725.GU4238@tassilo.jf.intel.com>
Message-ID: <alpine.DEB.2.21.1808080653120.1672@nanos.tec.linutronix.de>
References: <1533662247-17575-1-git-send-email-kan.liang@linux.intel.com> <1b7cb461-5321-86cf-3031-5ff545c3dc42@linux.intel.com> <20180807174851.GJ2494@hirez.programming.kicks-ass.net> <20180807183736.GR4238@tassilo.jf.intel.com>
 <alpine.DEB.2.21.1808072257080.1672@nanos.tec.linutronix.de> <20180807221725.GU4238@tassilo.jf.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Aug 2018, Andi Kleen wrote:

> > Which simply does not work. Look at Goldmont Fam 6 Model 5C. The SoCs
> > with that Fam/Model combination are:
> > 
> >  - Apollo Lake
> >  - Broxton (has two platforms: Morganfield and Willowtrail)
> 
> Right pick one. The others are the same for software purposes
> and can be handled in the same way.

Pick one is really not a good choice. 

> > It's even worse with Silvermont.
> > 
> > So no, the interesting information is the UARCH and the variant of that,
> 
> With Uarch you mean the core uarch?  That doesn't really work for
> something like Silvermont or Goldmont.
> 
> > e.g. UARCH_CLIENT, UARCH_SERVER, UARCH_WHATEVER. All the magic Code Names
> 
> Right your scheme totally doesn't work on Silvermont because there
> are multiple client variants.

We have that for the big cores as well:

#define INTEL_FAM6_HASWELL_CORE         0x3C
#define INTEL_FAM6_HASWELL_X            0x3F
#define INTEL_FAM6_HASWELL_ULT          0x45
#define INTEL_FAM6_HASWELL_GT3E         0x46

Why would we treat ATOM differently? It's all the same scheme:

SILVERMONT_CLIENT  	0x37	     Baytrail, Valleyview
SILVERMONT_SERVER	0x40	     Avaton, Rangely

and on goldmont it's not any different.

We really want one scheme for both Core and ATOM and not randomly picked
different ones. For the kernel (aside of some peripheral stuff) the most
interesting information is the UARCH plus the extra features which are
enabled on a particular SoC.

The current naming scheme e.g. for SILVERMONT is utter crap because the 1/2
variants are in fact CLIENT/SERVER and the comment in the header file, that
there is no better name, is just silly.

Thanks,

	tglx


