Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C48ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 10:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B5420838
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 10:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38B5420838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbeJUSfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 14:35:03 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41175 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeJUSfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 14:35:02 -0400
Received: from tmo-101-14.customers.d1-online.com ([80.187.101.14] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gEAqn-0003hN-DV; Sun, 21 Oct 2018 12:20:49 +0200
Date:   Sun, 21 Oct 2018 12:20:47 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andi Kleen <ak@linux.intel.com>
cc:     Andi Kleen <andi@firstfloor.org>, peterz@infradead.org,
        x86@kernel.org, eranian@google.com, kan.liang@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] x86/cpufeature: Add facility to match microcode
 revisions
In-Reply-To: <20181020143857.GC27951@tassilo.jf.intel.com>
Message-ID: <alpine.DEB.2.21.1810210954440.1651@nanos.tec.linutronix.de>
References: <20181010162608.23899-1-andi@firstfloor.org> <alpine.DEB.2.21.1810171151010.6000@nanos.tec.linutronix.de> <20181019234743.GA27951@tassilo.jf.intel.com> <alpine.DEB.2.21.1810201017070.1651@nanos.tec.linutronix.de>
 <20181020143857.GC27951@tassilo.jf.intel.com>
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

Andi,

On Sat, 20 Oct 2018, Andi Kleen wrote:
> On Sat, Oct 20, 2018 at 10:19:37AM +0200, Thomas Gleixner wrote:
> > On Fri, 19 Oct 2018, Andi Kleen wrote:
> > There is no point to return the pointer because it's not a compound
> > structure. If you want to provide the possibility to use the index then
> > return the index and an error code if it does not match.
> 
> It will be useful with the driver_data pointer, which you short sightedly
> forced me to remove, and likely will need to be readded at some point
> anyways if this gets more widely used.

It's good and established practice not to add functionality on a 'might be
used' basis. If you'd provide at least one or two patches which demonstrate
how that is useful then that would be convincing.

>  At least with the pointer not all callers will need to be changed then.

It doesn't need to be changed at all, when done correctly.

So lets walk through that again:

1) x86_match_microcode() is a misnomer because it's not as the name
   suggests a match function. It compares whether the micro code revision
   is greater or equal the minimal required micro code revision for the
   current CPU.
   
2) None of the existing implementations needs a pointer return value,
   neither does your use case at hand.

3) If this should be extended to a generic cpu id matching facility, then
   it can be very well designed so. See below.

Step 1:

struct x86_cpu_check {
	u8	vendor;
	u8	family;
	u8	model;
	u8	stepping;
};

struct x86_cpu_check *x86_match_cpu(struct x86_cpu_check *table)
{
	// Find matching vendor, family, model, stepping entry
	... {
		return entry;
	}
	return NULL;
}

Genuine CPU match function, which can be extended by extending the data
structure.

Step 2:

struct x86_cpu_check {
	u8	vendor;
	u8	family;
	u8	model;
	u8	stepping;
	u32	microcode_rev;
};

bool x86_cpu_has_min_microcode(struct x86_cpu_check *table)
{
	struct x86_cpu_check *res = x86_match_cpu(table);

	if (!res)
		return false;
	return res->microcode_revision >= boot_cpu_data.microcode;
}

Step 3:

struct x86_cpu_check {
	u8	vendor;
	u8	family;
	u8	model;
	u8	stepping;
	union {
		u32	microcode_rev;
		void	*driver_data;
	}
};

Can be used with x86_match_cpu() for all non microcode based matching.

So if you really need something which checks the microcode and provides the
pointer, then it's easy enough to do:

Step 4:

struct x86_cpu_check {
	u8	vendor;
	u8	family;
	u8	model;
	u8	stepping;
	u32	microcode_rev;
	void	*driver_data;
};

struct x86_cpu_check *x86_check_min_microcode(struct x86_cpu_check *table)
{
	struct x86_cpu_check *res = x86_match_cpu(table);

	if (!res || res->microcode_rev < boot_cpu_data.microcode)
		return NULL;
	return res;
}

static inline bool x86_cpu_has_min_microcode(struct x86_cpu_check *table)
{
	return !!x86_check_min_microcode(table);
}

None of these steps requires to change a call site or a table.

But probably I'm too short sighted and missing something crucial. Looking
forward for enlightment.

> Also it's symmetric with how the PCI and USB and the existing x86 match
> discovery interfaces work.

And the point is? That we need to keep everything as we've done it 20 years
ago?

> > > > VENDOR_INTEL = 0, so this check is obscure to begin with. Either you chose
> > > > a explicit condition to put at the end of the table, e.g. vendor = U8_MAX
> > > > or you hand in the array size to the function.
> > > 
> > > That would both be awkward. It's the same as match_cpu, and 0 terminators
> > > are standard practice in practical all similar code. I removed
> > > the or with the family.
> > 
> > That's debatable because it's more easy to miss the terminator than getting
> > the ARRAY_SIZE() argument wrong. But it doesn't matter much.
> 
> Ok then please apply it. 

Sure, once this argument is settled and all review comments are addressed.

Thanks,

	tglx
