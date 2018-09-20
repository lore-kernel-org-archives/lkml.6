Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF19ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA7021522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA7021522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388754AbeIUDun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 23:50:43 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55776 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeIUDun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 23:50:43 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id A4E1C80749; Fri, 21 Sep 2018 00:05:03 +0200 (CEST)
Date:   Fri, 21 Sep 2018 00:05:02 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Len Brown <len.brown@intel.com>,
        Zhimin Gu <kookoo.gu@intel.com>
Subject: Re: [PATCH 01/12][RFC v3] x86, hibernate: Fix nosave_regions setup
 for hibernation
Message-ID: <20180920220502.GD27468@xo-6d-61-c0.localdomain>
References: <cover.1537275915.git.yu.c.chen@intel.com>
 <9df6959bc2f3776eb512b7964a94bd02639e65eb.1537275915.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9df6959bc2f3776eb512b7964a94bd02639e65eb.1537275915.git.yu.c.chen@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-09-19 15:37:15, Chen Yu wrote:
> From: Zhimin Gu <kookoo.gu@intel.com>
> 
> On 32bit systems, nosave_regions(non RAM areas) located between
> max_low_pfn and max_pfn are not excluded from hibernation snapshot
> currently, which may result in a machine check exception when
> trying to access these unsafe regions during hibernation:
> 
> [  612.800453] Disabling lock debugging due to kernel taint
> [  612.805786] mce: [Hardware Error]: CPU 0: Machine Check Exception: 5 Bank 6: fe00000000801136
> [  612.814344] mce: [Hardware Error]: RIP !INEXACT! 60:<00000000d90be566> {swsusp_save+0x436/0x560}
> [  612.823167] mce: [Hardware Error]: TSC 1f5939fe276 ADDR dd000000 MISC 30e0000086
> [  612.830677] mce: [Hardware Error]: PROCESSOR 0:306c3 TIME 1529487426 SOCKET 0 APIC 0 microcode 24
> [  612.839581] mce: [Hardware Error]: Run the above through 'mcelog --ascii'
> [  612.846394] mce: [Hardware Error]: Machine check: Processor context corrupt
> [  612.853380] Kernel panic - not syncing: Fatal machine check
> [  612.858978] Kernel Offset: 0x18000000 from 0xc1000000 (relocation range: 0xc0000000-0xf7ffdfff)
> 
> This is because on 32bit systems, pages above max_low_pfn are regarded
> as high memeory, and accessing unsafe pages might cause expected MCE.
> On the problematic 32bit system, there are reserved memory above low
> memory, which triggered the MCE:
> 
> Fix this problem by changing pfn limit from max_low_pfn to max_pfn.
> This fix does not impact 64bit system because on 64bit max_low_pfn
> is the same as max_pfn.
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>

Thanks.

I think this is nasty enough to add Cc: stable.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
