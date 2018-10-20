Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30ACC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 08:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C7D521486
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 08:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C7D521486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbeJTQ3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 12:29:34 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40556 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbeJTQ3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 12:29:34 -0400
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gDmTy-0002nZ-Ap; Sat, 20 Oct 2018 10:19:38 +0200
Date:   Sat, 20 Oct 2018 10:19:37 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andi Kleen <ak@linux.intel.com>
cc:     Andi Kleen <andi@firstfloor.org>, peterz@infradead.org,
        x86@kernel.org, eranian@google.com, kan.liang@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] x86/cpufeature: Add facility to match microcode
 revisions
In-Reply-To: <20181019234743.GA27951@tassilo.jf.intel.com>
Message-ID: <alpine.DEB.2.21.1810201017070.1651@nanos.tec.linutronix.de>
References: <20181010162608.23899-1-andi@firstfloor.org> <alpine.DEB.2.21.1810171151010.6000@nanos.tec.linutronix.de> <20181019234743.GA27951@tassilo.jf.intel.com>
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

On Fri, 19 Oct 2018, Andi Kleen wrote:

> > > +	u32 min_ucode;
> > > +};
> > > +
> > > +const struct x86_ucode_id *x86_match_ucode(const struct x86_ucode_id *match)
> > 
> > What's the point of returning the struct pointer? Shouldn't it be enough to
> > make it return bool? Also the function name really should reflect that this
> > checks whether the minimal required microcode revision is active.
> 
> This allows the user to find the table entry to tie something to it
> (e.g. use the index to match some other table)
> 
> Same pattern as pci discovery etc. use.
> 
> Given the current caller doesn't need it, but we still follow standard
> conventions.

There is no point to return the pointer because it's not a compound
structure. If you want to provide the possibility to use the index then
return the index and an error code if it does not match.

> > 
> > > +{
> > > +	struct cpuinfo_x86 *c = &boot_cpu_data;
> > > +	const struct x86_ucode_id *m;
> > > +
> > > +	for (m = match; m->vendor | m->family | m->model; m++) {
> > 
> > VENDOR_INTEL = 0, so this check is obscure to begin with. Either you chose
> > a explicit condition to put at the end of the table, e.g. vendor = U8_MAX
> > or you hand in the array size to the function.
> 
> That would both be awkward. It's the same as match_cpu, and 0 terminators
> are standard practice in practical all similar code. I removed
> the or with the family.

That's debatable because it's more easy to miss the terminator than getting
the ARRAY_SIZE() argument wrong. But it doesn't matter much.

Thanks,

	tglx


