Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205F4C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88E6218E0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfADKNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 05:13:12 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39276 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfADKNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 05:13:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B895DEBD;
        Fri,  4 Jan 2019 02:13:11 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 84A453F575;
        Fri,  4 Jan 2019 02:13:11 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 074761AE0C51; Fri,  4 Jan 2019 10:13:12 +0000 (GMT)
Date:   Fri, 4 Jan 2019 10:13:11 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Dave Martin <Dave.Martin@arm.com>, mark.rutland@arm.com,
        julien.thierry@arm.com, mlangsdo@redhat.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        suzuki.poulose@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, steven.price@arm.com,
        shankerd@codeaurora.org, Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ykaukab@suse.de, Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/7] sysfs/cpu: Add "Unknown" vulnerability state
Message-ID: <20190104101311.GB24160@edgewater-inn.cambridge.arm.com>
References: <20190103004921.1928921-1-jeremy.linton@arm.com>
 <20190103004921.1928921-2-jeremy.linton@arm.com>
 <20190103163740.GC3529@e103592.cambridge.arm.com>
 <db5968e6-609b-1a1f-464d-436327dd1738@arm.com>
 <1951199845.271163.1546543806398@email.ionos.de>
 <5818faa8-e820-7aee-5aaa-42ced65d6f9d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5818faa8-e820-7aee-5aaa-42ced65d6f9d@arm.com>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 02:32:44PM -0600, Jeremy Linton wrote:
> On 01/03/2019 01:30 PM, Stefan Wahren wrote:
> > > Jeremy Linton <jeremy.linton@arm.com> hat am 3. Januar 2019 um 17:46 geschrieben:
> > > On 01/03/2019 10:37 AM, Dave Martin wrote:
> > > > On Wed, Jan 02, 2019 at 06:49:15PM -0600, Jeremy Linton wrote:
> > > > > There is a lot of variation in the Arm ecosystem. Because of this,
> > > > > there exist possible cases where the kernel cannot authoritatively
> > > > > determine if a machine is vulnerable.
> > > > > 
> > > > > Rather than guess the vulnerability status in cases where
> > > > > the mitigation is disabled or the firmware isn't responding
> > > > > correctly, we need to display an "Unknown" state.
> > > > > 
> > 
> > i applied your patch series on linux-next-20190103. On my Raspberry Pi 3B+ (defconfig) i'm getting this from sysfs:
> > 
> > l1tf:Not affected
> > meltdown:Not affected
> > spec_store_bypass:Unknown
> > spectre_v1:Mitigation: __user pointer sanitization
> > spectre_v2:Unknown
> > 
> > AFAIK it has 4 Cortex-A53 cores (no PSCI firmware), so shouldn't be affected.
> 
> So, for spec_store_bypass, as you noted your getting hit by the lack of
> psci/smccc to report the ssb state, and this patch is just reflecting that.
> 
> In the case of spectrev2 it may be correct to blame this patch set because
> its displaying "unknown" since your core isn't in the black list, and your
> core isn't new enough to have the csv2 bit indicating its not vulnerable. In
> this case if we do away with the unknown state, we should probably depend
> entirely on the black list and simply display "Not affected" if the core
> isn't listed. (meaning we may report cores not affected when they are
> missing from the blacklist).
> 
> 
> > How can this be fixed?
> 
> For ssb, the correct answer is probably fix the firmware, but given the
> situation, its likely this kind of machine is going to force an additional
> MIDR list to report the state correctly. Maybe Will or someone can chime in
> here?

Marc Z is already working on this iirc, since we need it to fix the message
printed to dmesg about the mitigation status anyway.

Will
