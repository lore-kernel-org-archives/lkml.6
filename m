Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA28AC433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 15:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6084221766
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 15:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6084221766
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbeHYSqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 14:46:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37838 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeHYSqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 14:46:43 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9E0CC3EE;
        Sat, 25 Aug 2018 15:07:26 +0000 (UTC)
Date:   Sat, 25 Aug 2018 17:07:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Roland Dreier <roland@purestorage.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        matt@codeblueprint.co.uk, bp@suse.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>, luto@kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, bp@alien8.de,
        brgerst@gmail.com, davej@codemonkey.org.uk, dvlasenk@redhat.com,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        sai.praneeth.prakhya@intel.com, sds@tycho.nsa.gov,
        Thomas Gleixner <tglx@linutronix.de>, toshi.kani@hp.com,
        linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Yazen.Ghannam@amd.com
Subject: Re: [PATCH 4.4 103/105] Revert "x86/mm/pat: Ensure cpa->pfn only
 contains page frame numbers"
Message-ID: <20180825150723.GA10230@kroah.com>
References: <20171215092305.994559179@linuxfoundation.org>
 <20171215092311.347628971@linuxfoundation.org>
 <CAL1RGDVgShymmT+TJ3mAHEL7n+qoisk6mQ=Tji_T=0d_QA=VKw@mail.gmail.com>
 <1535129126.2902.36.camel@codethink.co.uk>
 <CAL1RGDW1Lo+F5D479Jsi-AFsmjVpdDre_qOFSCwWubG6U=bxeQ@mail.gmail.com>
 <20180824191749.GA15489@kroah.com>
 <CAL1RGDXUx-frpWuuYyc-VrAEoOU2+irGQPRWvoBzO2ZxEPGrww@mail.gmail.com>
 <35e0f79b-6fac-5027-6377-67dbe2a293b9@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35e0f79b-6fac-5027-6377-67dbe2a293b9@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 25, 2018 at 06:52:32AM -0700, Guenter Roeck wrote:
> Hi Roland,
> 
> On 08/24/2018 01:04 PM, Roland Dreier wrote:
> > > Ok, so what patch should be reverted?  I'm seeing other reports of
> > > problems all around this same area, but I can't figure out exactly what
> > > to do.
> > 
> > Are any of those reports public?  If so can you point me at them, I'm
> > curious if the symptoms match up.
> > 
> > I don't think we want to revert anything.  I think you should pull in
> > edc3b9129cec and at least the first three patches that Ben listed:
> > 
> > 21cdb6b56843 x86/mm: Page align the '_end' symbol to avoid pfn conversion bugs
> > b61a76f8850d x86/efi: Map RAM into the identity page table for mixed mode
> > 753b11ef8e92 x86/efi: Setup separate EFI page tables in kexec paths
> > 
> > the first patch takes a bit of massaging (mostly because some of it is
> > already touched by 02ff2769edbc, which keeps the changes from
> > edc3b9129cec, and so we can drop a good bit when applying).  The other
> > three apply cleanly.
> > 
> > I'm currently testing that and can send you the state of my tree in a bit.
> > 
> 
> Have you made any progress ? On my side I am still out of luck since I can not
> reproduce the problem.

Perhaps just the patch that Andi posted to the stable list helps out
here?

Roland, can you try just that?

thanks,

greg k-h
