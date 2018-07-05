Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1E4C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42DA220847
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:18:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42DA220847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754324AbeGENSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:18:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:6623 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753868AbeGENSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:18:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2018 06:18:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,312,1526367600"; 
   d="scan'208";a="69859223"
Received: from jnikula-mobl2.fi.intel.com (HELO localhost) ([10.237.72.62])
  by fmsmga001.fm.intel.com with ESMTP; 05 Jul 2018 06:18:19 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Chris Chiu <chiu@endlessm.com>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        David Airlie <airlied@linux.ie>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        intel-gfx@lists.freedesktop.org,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [BUG] i915 HDMI connector status is connected after disconnection
In-Reply-To: <CAB4CAwe2Q7ZUUDucE60y97V9A8apF6MhM4+G-eNU0W7u6RiQPA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <CAB4CAwcfj32FovZwpTbekvHpoc3gG0sVbNtW8jeXRcp5qwEsmw@mail.gmail.com> <87efgioy7i.fsf@intel.com> <153078146934.15734.3696654838092752426@skylake-alporthouse-com> <87bmbmowek.fsf@intel.com> <CAB4CAwe2Q7ZUUDucE60y97V9A8apF6MhM4+G-eNU0W7u6RiQPA@mail.gmail.com>
Date:   Thu, 05 Jul 2018 16:18:03 +0300
Message-ID: <87wou9om7o.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jul 2018, Chris Chiu <chiu@endlessm.com> wrote:
> On Thu, Jul 5, 2018 at 5:37 PM, Jani Nikula <jani.nikula@intel.com> wrote:
>> On Thu, 05 Jul 2018, Chris Wilson <chris@chris-wilson.co.uk> wrote:
>>> Quoting Jani Nikula (2018-07-05 09:58:57)
>>>> On Thu, 05 Jul 2018, Chris Chiu <chiu@endlessm.com> wrote:
>>>> > Hi,
>>>> >     We have few ASUS laptops X705FD (The new WiskyLake), X560UD (intel
>>>> > i5-8250U), X530UN (intel i7-8550U) share the same problem, which is
>>>> > the HDMI connector status stays connected even the HDMI cable has been
>>>> > unplugged. Look into the "/sys/class/drm/card0-HDMI-A-1/status" for
>>>> > checking the status while plug/unplug the HDMI, it shows
>>>> > "disconnected" before plug in HDMI cable, then switch to "connected"
>>>> > after plugin, and still stay "connected" after unplug. This would
>>>> > cause the audio output path cannot correctly switch from HDMI to
>>>> > internal speaker after unplugging the HDMI.
>>>> >
>>>> > I then try to verify with the latest kernel 4.18.0-rc3+, the bug still
>>>> > present. The full "dmesg" log is here.
>>>> > https://gist.github.com/mschiu77/d761d7c5cf191b7868d4d7788ae087f1
>>>> >
>>>> > The HDMI cable is plugged in at ~26th second.
>>>> > "[ 26.214371] [drm:drm_detect_monitor_audio [drm]] Monitor has basic
>>>> > audio support"
>>>> > then unplug the HDMI at ~73th second.
>>>> > "[ 73.328361] [drm:drm_detect_monitor_audio [drm]] Monitor has basic
>>>> > audio support"
>>>> >
>>>> > Please advise what I can do to fix this. Thanks
>>>>
>>>> Seems rather odd. Please file a bug report at [1]. Attach the dmesg on
>>>> the bug. Please attach 'xrandr --verbose' output before and after
>>>> unplugging on the bug.
>>>
>>> Note that 'xrandr --verbose' will trigger a reprobe of the devices,
>>> papering over any missed probe following hotplug.  I would suggest
>>> preceding with 'xrandr --current --verbose'.
>>>
>>> If all you are doing is checking status, you need to 'echo detect >
>>> status' to trigger a reprobe after hotplug.
>
> It's interesting that reprobe triggered by 'xrandr --verbose' after unplug will
> get the status back to "disconnected". But if I just do 'xrandr
> --current --verbose'
> before and after unplugging the cable, the output shows the same status
> 'connected'.
>
> Here's the output of 'xrandr --verbose' before unplugging HDMI
> https://gist.github.com/mschiu77/ea2e843078297f344596243418dcdaf7
>
> And the output of 'xrandr --current --verbose' after unplugging the cable
> https://gist.github.com/mschiu77/55756c0801046d49cd9bc3f87712b079
>
> Then do 'xrandr --current --verbose' to trigger reprobe, the ouput
> https://gist.github.com/mschiu77/72e6ab5438cbe64443300fc4fd71770c
>
> It means that the HDMI unplug not detected by the driver?

Please do file the bug, and attach the information there. People go on
vacations, the pastebins will go away, and the memory of all of this
will fade.

BR,
Jani.

>
> Chris
>
>>
>> I was curious about the logs seemingly indicating that we can read the
>> EDID even after the user says they've unplugged the cable. The updating
>> of sysfs status attribute is another matter.
>>
>> BR,
>> Jani.
>>
>>
>> --
>> Jani Nikula, Intel Open Source Graphics Center

-- 
Jani Nikula, Intel Open Source Graphics Center
