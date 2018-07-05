Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E04C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C08D2405A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:04:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C08D2405A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chris-wilson.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753225AbeGEJEk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 05:04:40 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:61133 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752440AbeGEJEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 05:04:39 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 12258083-1500050 
        for multiple; Thu, 05 Jul 2018 10:04:28 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Chris Chiu <chiu@endlessm.com>, David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@intel.com>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <87efgioy7i.fsf@intel.com>
Cc:     intel-gfx@lists.freedesktop.org,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <CAB4CAwcfj32FovZwpTbekvHpoc3gG0sVbNtW8jeXRcp5qwEsmw@mail.gmail.com>
 <87efgioy7i.fsf@intel.com>
Message-ID: <153078146934.15734.3696654838092752426@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [BUG] i915 HDMI connector status is connected after disconnection
Date:   Thu, 05 Jul 2018 10:04:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jani Nikula (2018-07-05 09:58:57)
> On Thu, 05 Jul 2018, Chris Chiu <chiu@endlessm.com> wrote:
> > Hi,
> >     We have few ASUS laptops X705FD (The new WiskyLake), X560UD (intel
> > i5-8250U), X530UN (intel i7-8550U) share the same problem, which is
> > the HDMI connector status stays connected even the HDMI cable has been
> > unplugged. Look into the "/sys/class/drm/card0-HDMI-A-1/status" for
> > checking the status while plug/unplug the HDMI, it shows
> > "disconnected" before plug in HDMI cable, then switch to "connected"
> > after plugin, and still stay "connected" after unplug. This would
> > cause the audio output path cannot correctly switch from HDMI to
> > internal speaker after unplugging the HDMI.
> >
> > I then try to verify with the latest kernel 4.18.0-rc3+, the bug still
> > present. The full "dmesg" log is here.
> > https://gist.github.com/mschiu77/d761d7c5cf191b7868d4d7788ae087f1
> >
> > The HDMI cable is plugged in at ~26th second.
> > "[ 26.214371] [drm:drm_detect_monitor_audio [drm]] Monitor has basic
> > audio support"
> > then unplug the HDMI at ~73th second.
> > "[ 73.328361] [drm:drm_detect_monitor_audio [drm]] Monitor has basic
> > audio support"
> >
> > Please advise what I can do to fix this. Thanks
> 
> Seems rather odd. Please file a bug report at [1]. Attach the dmesg on
> the bug. Please attach 'xrandr --verbose' output before and after
> unplugging on the bug.

Note that 'xrandr --verbose' will trigger a reprobe of the devices,
papering over any missed probe following hotplug.  I would suggest
preceding with 'xrandr --current --verbose'.

If all you are doing is checking status, you need to 'echo detect >
status' to trigger a reprobe after hotplug.
-Chris
