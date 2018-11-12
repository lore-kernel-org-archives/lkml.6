Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA33C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF9B223D0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF9B223D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbeKMAUl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 19:20:41 -0500
Received: from foss.arm.com ([217.140.101.70]:37280 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729129AbeKMAUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 19:20:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE4F280D;
        Mon, 12 Nov 2018 06:27:10 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D6883F5BD;
        Mon, 12 Nov 2018 06:27:09 -0800 (PST)
Date:   Mon, 12 Nov 2018 14:27:03 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: arm64 + ARM64_64K_PAGES=y
Message-ID: <20181112142703.0d6ceb57@donnerap.cambridge.arm.com>
In-Reply-To: <274c9742-0aa9-b4a5-11cb-b506aeef7761@ti.com>
References: <1ab7ee03-64fe-384a-c88f-f6d519b965db@ti.com>
        <20181108120040.pzupzyqnsxeuv5ne@linutronix.de>
        <99e0b883-cf9f-2ab9-5003-d4506bfa461d@ti.com>
        <274c9742-0aa9-b4a5-11cb-b506aeef7761@ti.com>
Organization: ARM
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Nov 2018 13:15:47 -0600
Grygorii Strashko <grygorii.strashko@ti.com> wrote:

Hi,

> On 11/8/18 12:14 PM, Grygorii Strashko wrote:
> > 
> > 
> > On 11/8/18 6:00 AM, Sebastian Andrzej Siewior wrote:  
> >> On 2018-11-06 15:34:55 [-0600], Grygorii Strashko wrote:  
> >>> Hi All,  
> >> Hi,
> >>  
> >>> Do anybody tried to use ARM64 RT with 76K pages enabled?  
> >>
> >> 75 would be an off by one but this :)  
> > 
> > Ops 8-). at least subj is correct.
> >   
> >>  
> >>> My attempt shows that enabling  CONFIG_ARM64_64K_PAGES=y
> >>> increases latencies by ~30%

That's not really surprising. Performance on systems using a bigger page
size granules might have some trade-offs (bigger memory overhead, worse
cache utilization), so 64K pages might not be really great for your
particular workload. You would probably need a real performance
analysis (using perf, for instance) to pinpoint TLB misses as your
bottleneck.

> >>> cyclictest -n -m -Sp98 -q -D2m with  =y
> >>>
> >>>
> >>> T: 0 (  772) P:98 I:1000 C: 120000 Min:      7 Act:   13 Avg:
> >>> 10 Max:      85 T: 1 (  773) P:98 I:1500 C:  79998 Min:      7
> >>> Act:   13 Avg:   10 Max:      71 T: 2 (  774) P:98 I:2000 C:
> >>> 59997 Min:      7 Act:   11 Avg:   11 Max:      64 T: 3 (  775)
> >>> P:98 I:2500 C:  47996 Min:      7 Act:   14 Avg:   12 Max:      66
> >>>
> >>>
> >>> cyclictest -n -m -Sp98 -q -D2m with CONFIG_ARM64_64K_PAGES=n
> >>>
> >>>
> >>> T: 0 (  697) P:98 I:1000 C: 120000 Min:      7 Act:   10 Avg:
> >>> 9 Max:      38 T: 1 (  698) P:98 I:1500 C:  79987 Min:      7
> >>> Act:   10 Avg:   10 Max:      32 T: 2 (  699) P:98 I:2000 C:
> >>> 59981 Min:      7 Act:   14 Avg:   11 Max:      46 T: 3 (  700)
> >>> P:98 I:2500 C:  47977 Min:      6 Act:   11 Avg:   10 Max:
> >>> 45  
> >>
> >> So this is an idle system?  
> > 
> > Yes (in general) - it's collected with systemd, so some daemons are
> > active. 
> >> The Kconfig help says "faster TLB lookup". Interesting.
> >> Are the 16k pages in between (latency wise) by any chance?  
> > 
> > I'll try it.  
> 
> no i'll not, at least not fast. with 16k pages enabled I can't boot
> TI 4.14 kernel
> -  4.14.71-rt44.
> No msg in log, just "Starting kernel ..."

You need a core that actually supports 16K pages (supporting
certain page size granules is architecturally optional).
From the Arm Ltd. cores it's Cortex-A73, A75 or A55, possibly other
newer ones as well. Cortex-A53, A57 and A72 do not support 16k pages.

Cheers,
Andre.
