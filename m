Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0DCC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5534623DC6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5534623DC6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753812AbeGEOkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:40:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:62182 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753353AbeGEOkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:40:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2018 07:40:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,312,1526367600"; 
   d="scan'208";a="72479836"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga002.jf.intel.com with SMTP; 05 Jul 2018 07:40:10 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 05 Jul 2018 17:40:09 +0300
Date:   Thu, 5 Jul 2018 17:40:09 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Chris Chiu <chiu@endlessm.com>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [BUG] i915 HDMI connector status is connected after disconnection
Message-ID: <20180705144009.GC5565@intel.com>
References: <CAB4CAwcfj32FovZwpTbekvHpoc3gG0sVbNtW8jeXRcp5qwEsmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB4CAwcfj32FovZwpTbekvHpoc3gG0sVbNtW8jeXRcp5qwEsmw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 03:58:36PM +0800, Chris Chiu wrote:
> Hi,
>     We have few ASUS laptops X705FD (The new WiskyLake), X560UD (intel
> i5-8250U), X530UN (intel i7-8550U) share the same problem, which is
> the HDMI connector status stays connected even the HDMI cable has been
> unplugged. Look into the "/sys/class/drm/card0-HDMI-A-1/status" for
> checking the status while plug/unplug the HDMI, it shows
> "disconnected" before plug in HDMI cable, then switch to "connected"
> after plugin, and still stay "connected" after unplug. This would
> cause the audio output path cannot correctly switch from HDMI to
> internal speaker after unplugging the HDMI.
> 
> I then try to verify with the latest kernel 4.18.0-rc3+, the bug still
> present. The full "dmesg" log is here.
> https://gist.github.com/mschiu77/d761d7c5cf191b7868d4d7788ae087f1
> 
> The HDMI cable is plugged in at ~26th second.
> "[ 26.214371] [drm:drm_detect_monitor_audio [drm]] Monitor has basic
> audio support"
> then unplug the HDMI at ~73th second.
> "[ 73.328361] [drm:drm_detect_monitor_audio [drm]] Monitor has basic
> audio support"
> 
> Please advise what I can do to fix this. Thanks

Pull the cable out faster?

I presume this is the same old case of hpd disconnecting slightly
before ddc and we still manage to read the EDID when processing
the hpd irq. We kinda tried to fix that with the live status
check but that thing failed spectacularly.

-- 
Ville Syrjälä
Intel
