Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086B3C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B060720850
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B060720850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbeHaUKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:10:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35642 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbeHaUKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:10:37 -0400
Received: from localhost (unknown [72.28.92.217])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 19845C0C;
        Fri, 31 Aug 2018 16:02:27 +0000 (UTC)
Date:   Fri, 31 Aug 2018 09:02:23 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Roland Dreier <roland@purestorage.com>,
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
Message-ID: <20180831160223.GE25066@kroah.com>
References: <20171215092311.347628971@linuxfoundation.org>
 <CAL1RGDVgShymmT+TJ3mAHEL7n+qoisk6mQ=Tji_T=0d_QA=VKw@mail.gmail.com>
 <1535129126.2902.36.camel@codethink.co.uk>
 <CAL1RGDW1Lo+F5D479Jsi-AFsmjVpdDre_qOFSCwWubG6U=bxeQ@mail.gmail.com>
 <20180824191749.GA15489@kroah.com>
 <CAL1RGDXUx-frpWuuYyc-VrAEoOU2+irGQPRWvoBzO2ZxEPGrww@mail.gmail.com>
 <20180824201025.GB18715@roeck-us.net>
 <CAL1RGDXa2POjmrr8UK-2oYyQtxYxiOs5t9BrpGUHRXqkDjMW5w@mail.gmail.com>
 <20180824203251.GD18715@roeck-us.net>
 <5dd63596-9f7f-f72a-37ad-b0d97580667e@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dd63596-9f7f-f72a-37ad-b0d97580667e@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 07:24:08AM +0100, Guillaume Tucker wrote:
> On 24/08/18 21:32, Guenter Roeck wrote:
> > On Fri, Aug 24, 2018 at 01:16:18PM -0700, Roland Dreier wrote:
> >>> Sounds great. I'll hold off with sending my RFT series and wait for your
> >>> test results. I think we'll also need d367cef0a7f0c6 ("x86/mm/pat: Fix
> >>> boot crash when 1GB pages are not supported by the CPU").
> >>
> >> Sure, makes sense - I don't have any EFI systems with CPUs old enough
> >> not to support 1G pages but that looks reasonable.  I'll pull that
> >> into my tree as well.
> >>
> > kernelci reported a crash on a CPU which doesn't support 1G pages.
> > See https://kernelci.org/boot/id/5b7d39ea59b514c03796ba9c/
> 
> Looks like this has now been fixed with Andi's patch in 4.4.153:
> 
>   "x86/mm/pat: Fix L1TF stable backport for CPA"
> 
> I can confirm this platform is now booting fine in kernelci:
> 
>   http://lava.streamtester.net/scheduler/job/146195

Wonderful, thanks for letting us know.

greg k-h
