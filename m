Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B41AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3AEA208F7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3AEA208F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbeHXSjJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 14:39:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:62705 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbeHXSjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 14:39:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Aug 2018 08:04:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,283,1531810800"; 
   d="scan'208";a="84204811"
Received: from bpeschka-mobl.amr.corp.intel.com (HELO localhost) ([10.252.24.83])
  by fmsmga001.fm.intel.com with ESMTP; 24 Aug 2018 08:04:04 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Chris Chiu <chiu@endlessm.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [BUG] i915 HDMI connector status is connected after disconnection
In-Reply-To: <CAB4CAwdjPFLTj+bL+bAeXw2cwAtk9tWFxPPaATpQ4QbuZsM0ew@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <CAB4CAwcfj32FovZwpTbekvHpoc3gG0sVbNtW8jeXRcp5qwEsmw@mail.gmail.com> <20180705144009.GC5565@intel.com> <CAB4CAwfQxrfRF=MaJZqagtRyPfJOdHjcS32GTqyG8cOg5=UgKw@mail.gmail.com> <CAB4CAwdjPFLTj+bL+bAeXw2cwAtk9tWFxPPaATpQ4QbuZsM0ew@mail.gmail.com>
Date:   Fri, 24 Aug 2018 18:04:30 +0300
Message-ID: <87tvnjlsap.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2018, Chris Chiu <chiu@endlessm.com> wrote:
> On Fri, Jul 6, 2018 at 2:44 PM, Chris Chiu <chiu@endlessm.com> wrote:
>> On Thu, Jul 5, 2018 at 10:40 PM, Ville Syrjälä
>> <ville.syrjala@linux.intel.com> wrote:
>>> On Thu, Jul 05, 2018 at 03:58:36PM +0800, Chris Chiu wrote:
>>>> Hi,
>>>>     We have few ASUS laptops X705FD (The new WiskyLake), X560UD (intel
>>>> i5-8250U), X530UN (intel i7-8550U) share the same problem, which is
>>>> the HDMI connector status stays connected even the HDMI cable has been
>>>> unplugged. Look into the "/sys/class/drm/card0-HDMI-A-1/status" for
>>>> checking the status while plug/unplug the HDMI, it shows
>>>> "disconnected" before plug in HDMI cable, then switch to "connected"
>>>> after plugin, and still stay "connected" after unplug. This would
>>>> cause the audio output path cannot correctly switch from HDMI to
>>>> internal speaker after unplugging the HDMI.
>>>>
>>>> I then try to verify with the latest kernel 4.18.0-rc3+, the bug still
>>>> present. The full "dmesg" log is here.
>>>> https://gist.github.com/mschiu77/d761d7c5cf191b7868d4d7788ae087f1
>>>>
>>>> The HDMI cable is plugged in at ~26th second.
>>>> "[ 26.214371] [drm:drm_detect_monitor_audio [drm]] Monitor has basic
>>>> audio support"
>>>> then unplug the HDMI at ~73th second.
>>>> "[ 73.328361] [drm:drm_detect_monitor_audio [drm]] Monitor has basic
>>>> audio support"
>>>>
>>>> Please advise what I can do to fix this. Thanks
>>>
>>> Pull the cable out faster?
>>>
>>> I presume this is the same old case of hpd disconnecting slightly
>>> before ddc and we still manage to read the EDID when processing
>>> the hpd irq. We kinda tried to fix that with the live status
>>> check but that thing failed spectacularly.
>>>
>>> --
>>> Ville Syrjälä
>>> Intel
>
> There's a patch https://bugs.freedesktop.org/show_bug.cgi?id=107125#c8.
> And I verified on the X705FD/X560UD which were easy to reproduce, the patch
> works as expected. Can anyone kindly give comments about this patch?
> We can do anything to help fix this issue upstream. Thanks

Seems like a hack. Should look into hw based debouncing or a slight
delay in the hotplug work processing I think.

BR,
Jani.

>
> Chris
>
>> Thanks for the suggestion. I tried pulling the cable out faster, the status
>> shows correctly. I also tried branch drm-tip of
>> https://cgit.freedesktop.org/drm/drm-tip
>> but the symptom persists.
>>
>> Anything I can help here? Or any old commit/patch I can try to do some
>> experiments?
>>
>> Chris

-- 
Jani Nikula, Intel Open Source Graphics Center
