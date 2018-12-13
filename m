Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14ADC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B037F21104
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B037F21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbeLMQgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:36:43 -0500
Received: from mga06.intel.com ([134.134.136.31]:20264 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727579AbeLMQgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 11:36:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2018 08:36:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,349,1539673200"; 
   d="scan'208";a="129684813"
Received: from spandruv-mobl.amr.corp.intel.com ([10.252.153.167])
  by fmsmga001.fm.intel.com with ESMTP; 13 Dec 2018 08:36:36 -0800
Message-ID: <f65d387ffa66caf0ca6e124f7cd77f411e80ade7.camel@linux.intel.com>
Subject: Re: intel_pstate: Lowest frequency not reached with Intel i7-6700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Doug Smythies <dsmythies@telus.net>, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>
Date:   Thu, 13 Dec 2018 08:36:29 -0800
In-Reply-To: <efc5d72c-ca07-9a09-8e9e-2bb0732e0040@molgen.mpg.de>
References: <000701d4926f$533eb270$f9bc1750$@net>
         <a4321c48-e9df-1a2a-cfbd-bac07a9c65d8@molgen.mpg.de>
         <CAJZ5v0gUDzy8vV=JajDHZJi2F0FyHUkFfYbbJhMioUa5XoKuqA@mail.gmail.com>
         <efc5d72c-ca07-9a09-8e9e-2bb0732e0040@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-12-13 at 13:41 +0100, Paul Menzel wrote:
> Dear Rafael,
> 
> 
> On 12/13/18 11:39, Rafael J. Wysocki wrote:
> > On Thu, Dec 13, 2018 at 10:54 AM Paul Menzel <pmenzel@molgen.mpg.de
> > > wrote:
> > > On 12/13/18 00:06, Doug Smythies wrote:
> > > > On 2018.12.12 13:40 Paul Menzel wrote:
> > > > 
> > > > > Using *powersave* as P-state selection algorithm, on an idle
> > > > > system
> > > > 
> > > > Define "idle system".
> > > > If your computer is running a GUI, or is even a server without
> > > > a GUI
> > > > but with many services running, then "idle" really isn't.
> > > > Below is from my test server, with many services disabled, so
> > > > "idle" really is quite "idle"
> > > > 
> > > > doug@s15:~/temp$ sudo turbostat --Summary --quiet --show
> > > > Busy%,Bzy_MHz,PkgTmp,PkgWatt --interval 15
> > > > Busy%   Bzy_MHz PkgTmp  PkgWatt
> > > > 0.01    1608    27      3.71
> > > > 0.01    1619    27      3.71
> > > > 0.01    1600    28      3.71
> > > > 0.01    1600    28      3.70
> > > > 
> > > > Note that p state 16 (1600 MHz) is the minimum for my older i7-
> > > > 2600k
> > > > processor.
> > > 
> > > The thing is, on an Intel Kaby Lake laptop with Ubuntu 18.10 and
> > > GNOME
> > > running, it goes down to the lowest listed frequency.
> 
> Checking the numbers again, I was mistaken. The lowest possible
> frequency
> of the Intel Kaby Lake i7-7500U in that laptop is 400 MHz, and it is
> going down to 600 MHz. Busy% from turbostat is 0.3 to 0.4.
> 
> > Kaby Lake has hardware-managed P-states (HWP) which is a different
> > mechanism.
> 
> Isn’t HWP also available for the 6th generation?
> 
>     $ dmesg | grep intel_pstate
>     [    2.092456] intel_pstate: Intel P-state driver initializing
>     [    2.094820] intel_pstate: HWP enabled
> 
> > > > > Shouldn’t it go down until 800 MHz?
> > > > 
> > > > We would need some actual busy information, turbostat is the
> > > > recommended tool, to know for sure.
> > > 
> > > Here you go.
> > > 
> > > ```
> > > tools/power/x86/turbostat> sudo ./turbostat --Summary --quiet --
> > > show Busy%,Bzy_MHz,PkgTmp,PkgWatt --interval 15
> > > Busy%    Bzy_MHz    PkgTmp    PkgWatt
> > > 3.59    1167    31    1.68
> > > 3.21    903    31    1.34
> > > 3.21    906    31    1.34
> > > 3.27    901    31    1.35
> > > 8.23    2715    30    2.32  ← stopping GDM (systemctl stop gdm)
> > > 2.95    915    30    1.18
> > > 2.91    906    30    1.18
> > > 2.92    903    30    1.17
> > > 2.90    900    29    1.17
> > > 2.89    903    29    1.18
> > > 2.91    903    30    1.18
> > > 2.89    903    29    1.18
> > > 2.89    900    29    1.18
> > > 2.90    903    30    1.18
> > > 2.90    903    29    1.17
> > > 2.90    903    29    1.17
> > > 2.90    900    29    1.16
> > > 2.90    903    29    1.14
> > > 2.90    903    28    1.11
> > > 2.90    903    29    1.10
> > > 2.91    900    29    1.16
> > > 2.91    903    29    1.14
> > > 2.90    903    29    1.12
> > > 2.90    903    29    1.16
> > > 2.90    900    28    1.17
> > > 2.92    903    29    1.16
> > > 2.90    903    29    1.16
> > > 2.90    903    29    1.16
> > > ```
> > > 
> > > 800 MHz should be enough to keep GDM running, shouldn’t it?
> > 
> > Well, depending.
> > 
> > > Otherwise only SSH was running.
> > 
> > There obviously is something that causes it to stay at 900 MHz.
> 
> It’s not obvious to me, but you have more experience. It’d expect
> to at least one core(?) to go down to 800 MHz and not all to stay
> at 900 MHz.
Also HWP will pick up energy efficient P-state. If it sees that it is
better to run at a higher P-state and complete the job at the same
power level.
There is a way to turn off that but better not do.

Thanks,
Srinivas

> 
> > Please check max_perf_pct, min_perf_pct and num_pstates under
> > /sys/devices/system/cpu/intel_pstate/ .
> 
>     /sys/devices/system/cpu/intel_pstate> cat max_perf_pct
> min_perf_pct num_pstates
>     100
>     20
>     33
> 
> > Also cpuinfo_max_freq, cpuinfo_min_freq, scaling_max_freq,
> > scaling_min_freq under /sys/devices/system/cpu/cpufreq/policy0/ .
> 
> /sys/devices/system/cpu/cpufreq/policy0> cat cpuinfo_{min,max}_freq
> scaling_{min,max}_freq
>     800000
>     4000000
>     800000
>     4000000
> 
> > However, please note that Busy% of 3 isn't particularly low.
> 
> Indeed. On the laptop it is around 0.3 to 0.4 even with GNOME
> running.
> 
> So, to check if everything is working, I boot into initramfs
> and check the numbers there?
> 
> 
> Kind regards,
> 
> Paul
> 

