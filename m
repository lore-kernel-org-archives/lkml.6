Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2598DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB1C20672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAB1C20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbeKZTU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:20:29 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35392 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbeKZTU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:20:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id 96so17885932wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 00:27:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sUNnxf10BQ43fGuMPNYJxR5eiOGeH+c7dglcAwv07tI=;
        b=Ezg23h+zzbig++PWi0cGXD0IrsW4SMchPtHLURok9HJfXbcQ/mQZ69yfdV/0CjCUaw
         0zq7kzkIGHBPIK+t0mGSpOT9NBf/8OC7uJILtSTs9y7PnN3GrmgufBS2TkfqfgUMN/s5
         b2nhFOji7I+upIdhaHVAH/4QvlRbu/RoBTP2uLCT6JRvCkswxfmTpCgulwkqYx0z+BEm
         dc7KwyeRGiPQY59fbUG9AdEr6vFZwKEKRhKzts9OEYZiGiJYTEBKCaYaPmHLCyJDrdG+
         nD3SeSY2HOZzydLyW5fmygxbc5jM9rDrXToqdvQe7Nz8H33Y8PI9bs9nUM05obsufbGY
         eCRw==
X-Gm-Message-State: AA+aEWYmQUSQExSMkzWO7qB4PE4OR6GH1IhwS6mk9WUke7EYcMaWcP2T
        quZRUw84s2hAYCAYiAcbID6DUw==
X-Google-Smtp-Source: AFSGD/UD47yuOwfQm5/rAopXSN6D02FFjdhebaOt/zw+id/xZK0SmcO5Os0DJqCV+hyHgDUMFfVIPA==
X-Received: by 2002:a5d:6aca:: with SMTP id u10mr21979617wrw.310.1543220825972;
        Mon, 26 Nov 2018 00:27:05 -0800 (PST)
Received: from localhost.localdomain ([151.15.226.84])
        by smtp.gmail.com with ESMTPSA id x81sm25220wmg.17.2018.11.26.00.27.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 00:27:04 -0800 (PST)
Date:   Mon, 26 Nov 2018 09:27:02 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] base/drivers/arch_topology: Replace mutex with
 READ_ONCE / WRITE_ONCE
Message-ID: <20181126082702.GA18469@localhost.localdomain>
References: <1540830201-2947-1-git-send-email-daniel.lezcano@linaro.org>
 <1540830201-2947-2-git-send-email-daniel.lezcano@linaro.org>
 <20181123135807.GA14964@e107155-lin>
 <9cea4556-15f8-9377-305a-b629ba7e811f@linaro.org>
 <20181123162040.GB27793@e107155-lin>
 <1e013fee-e218-c489-9cd6-a384950d304f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e013fee-e218-c489-9cd6-a384950d304f@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23/11/18 17:54, Daniel Lezcano wrote:
> On 23/11/2018 17:20, Sudeep Holla wrote:
> > On Fri, Nov 23, 2018 at 05:04:18PM +0100, Daniel Lezcano wrote:
> >> On 23/11/2018 14:58, Sudeep Holla wrote:
> >>> On Mon, Oct 29, 2018 at 05:23:18PM +0100, Daniel Lezcano wrote:
> >>>> The mutex protects a per_cpu variable access. The potential race can
> >>>> happen only when the cpufreq governor module is loaded and at the same
> >>>> time the cpu capacity is changed in the sysfs.
> >>>>
> >>>
> >>> I wonder if we really need that sysfs entry to be writable. For some
> >>> reason, I had assumed it's read only, obviously it's not. I prefer to
> >>> make it RO if there's no strong reason other than debug purposes.
> >>
> >> Are you suggesting to remove the READ_ONCE/WRITE_ONCE patch and set the
> >> sysfs file read-only ?
> >>
> > 
> > Just to be sure, if we retain RW capability we still need to fix the
> > race you are pointing out.
> > 
> > However I just don't see the need for RW cpu_capacity sysfs and hence
> > asking the reason here. IIRC I had pointed this out long back(not sure
> > internally or externally) but seemed to have missed the version that got
> > merged. So I am just asking if we really need write capability given that
> > it has known issues.
> > 
> > If user-space starts writing the value to influence the scheduler, then
> > it makes it difficult for kernel to change the way it uses the
> > cpu_capacity in future.
> > 
> > Sorry if there's valid usecase and I am just making noise here.
> 
> It's ok [added Juri Lelli]
> 
> I've been through the history:
> 
> commit be8f185d8af4dbd450023a42a48c6faa8cbcdfe6
> Author: Juri Lelli <juri.lelli@arm.com>
> Date:   Thu Nov 3 05:40:18 2016 +0000
> 
>     arm64: add sysfs cpu_capacity attribute
> 
>     Add a sysfs cpu_capacity attribute with which it is possible to read and
>     write (thus over-writing default values) CPUs capacity. This might be
>     useful in situations where values needs changing after boot.
> 
>     The new attribute shows up as:
> 
>      /sys/devices/system/cpu/cpu*/cpu_capacity
> 
>     Cc: Will Deacon <will.deacon@arm.com>
>     Cc: Mark Brown <broonie@kernel.org>
>     Cc: Sudeep Holla <sudeep.holla@arm.com>
>     Signed-off-by: Juri Lelli <juri.lelli@arm.com>
>     Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> Juri do you have a use case where we want to override the capacity?
> 
> Shall we switch the sysfs attribute to read-only?

So, I spent a bit of time researching patchset history and IIRC the
point of having a RW cpu_capacity was to help in situations where one
wants to change values after boot, because she/he now has "better"
numbers (remember we advocate to use Dhrystone to populate DTs, but that
is highly debatable). I also seem to remember that there might also be
cases where DT values cannot be changed at all for a (new?) platform
that happens to be using DTs shipped with an old revision; something
along these lines was mentioned (by Mark?) during the review process,
but exact details escape my mind ATM, apologies.

Best,

- Juri
