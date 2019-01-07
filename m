Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1F1C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692662085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=godking.net header.i=@godking.net header.b="VnZWC0A5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfAGCZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 21:25:24 -0500
Received: from s18231873.onlinehome-server.info ([217.160.179.168]:57932 "EHLO
        godking.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbfAGCZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 21:25:24 -0500
X-Greylist: delayed 406 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Jan 2019 21:25:23 EST
Received: from localhost (localhost [IPv6:::1])
        by godking.net (Postfix) with ESMTPS id 9BBDA1D2AE834;
        Sun,  6 Jan 2019 20:18:31 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=godking.net; s=mail;
        t=1546827516; bh=+n0gLknDPXuAId1ixDbhZtu9Rkqpo9gRLUCsP+Rcse8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=VnZWC0A5VqZa8O/AY9MVjCNJv3u+xpB3jTtHPjkMKpnCtvVMAGeF5cdnKvymSbsNz
         SPvxHw8xe8+t83CfGgm+KFmH0AYsK4cMDbUjtu4KghthW8vfz6/WuSEHyacBqHm+hM
         06fhFunb900kzD/SHIfmkXW9mCcBF5qAwEx4ststhMJPR45i3iwA1mfvT8x8WUWAxH
         GDB2aWNmFUG13l6/WJXjiRRZOsv3izkmupMaTbhA/K07EWT4M2zvIdptwGnelwudzX
         WERRKZE0gGnmJ4A8CjM0S4y9CzflSC1Kh8zGf2RHdos3GbMno7MQKZXXxVt7HGgjhn
         NWIhyHoBVb8jg==
Date:   Sun, 6 Jan 2019 18:18:27 -0800 (PST)
From:   Alexander Kappner <agk@godking.net>
X-X-Sender: ak@REDDOT
To:     Takashi Iwai <tiwai@suse.de>
cc:     Alexander Kappner <agk@godking.net>, Jim.Qu@amd.com,
        bhelgaas@google.com, guneshwor.o.singh@intel.com, perex@perex.cz,
        hdegoede@redhat.com, lukas@wunner.de, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [snd_hda_intel] snd_hda_intel causes high CPU lockup and system
 instability if mic disabled in BIOS on Lenovo P50
In-Reply-To: <s5htvjst6b3.wl-tiwai@suse.de>
Message-ID: <alpine.DEB.2.11.1901061816210.19003@REDDOT>
References: <alpine.DEB.2.11.1811251505140.20766@REDDOT> <s5hpnus6yb5.wl-tiwai@suse.de> <alpine.DEB.2.11.1811262126040.2578@REDDOT> <s5h8t1ey7tn.wl-tiwai@suse.de> <alpine.DEB.2.11.1812011117340.26587@REDDOT> <s5htvjst6b3.wl-tiwai@suse.de>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 5 Dec 2018, Takashi Iwai wrote:

> On Sat, 01 Dec 2018 20:33:16 +0100,
> Alexander Kappner wrote:
>>
>> On Tue, 27 Nov 2018, Takashi Iwai wrote:
>>
>>> On Tue, 27 Nov 2018 06:34:02 +0100,
>>> Alexander Kappner wrote:
>>>>
>>>>
>>>>
>>>>
>>>> On Mon, 26 Nov 2018, Takashi Iwai wrote:
>>>>
>>>>> On Mon, 26 Nov 2018 00:17:15 +0100,
>>>>> Alexander Kappner wrote:
>>>>>>
>>>>>> My Lenovo P50 laptop has a BIOS option to disable the microphone. When
>>>>>> this option gets chosen, the snd_hda_intel driver causes high CPU load
>>>>>> on a single kworker thread, spinning on "process_unsol_events", and
>>>>>> system
>>>>>> instability. This behavior occurs from the time that the snd_hda_intel
>>>>>> module is loaded, irrespective of whether anything is attempting to access
>>>>>> the mic. The sound output still works.
>>>>>>
>>>>>> When in this state, the module cannot be removed cleanly; attempting to
>>>>>> remove it (even without rmmod -f) triggers an oops.
>>>>>>
>>>>>> I have attached two exemplary dmesg outputs. Strangely enough, the exact
>>>>>> location of the oops varies, but further up the call chain, I always see
>>>>>> process_unsol_events.
>>>>>>
>>>>>> When the mic is not disabled in the BIOS, the module works stable,
>>>>>> regardless whether or not the mic is muted in ALSA.
>>>>>>
>>>>>> I wasn't able to pinpoint the root cause. Any pointers on where to
>>>>>> start? Much appreciated.
>>>>>
>>>>> Could you load snd-hda-intel driver with probe_only=1 option, and give
>>>>> alsa-info.sh output (run it with --no-upload option)?  This should
>>>>> leave only the codec probing without configuring, so we can see the
>>>>> codec widget contents and check the emulator.
>>>>>
>>>>>
>>>>> thanks,
>>>>>
>>>>> Takashi
>>>>>
>>>>
>>>> Hi Takashi,
>>>>
>>>> thank you for looking into this. Please see quoted below the output of
>>>> alsa-info.sh (after "modprobe snd_hda_intel probe_only=1").
>>>
>>> This is the state where BIOS disabled the mic, right?
>>> It seems that BIOS doesn't change the pin configuration.  The pin NID
>>> 0x18 and 0x19 still show up as the mic jack and dock mic jack, as well
>>> as the built-in mic on NID 0x12.  And I couldn't see anything wrong in
>>> the emulator with this input.
>>>
>>> When BIOS disables the mic, how is supposed?  Does it disable all
>>> mics, including built-in one?
>>>
>>> Could you check alsa-info.sh outputs on both BIOS mic disable and
>>> enabled (but keep probe_only=1 option in both cases)?
>>>
>>> Also alsa-info.sh outputs on both cases without probe_only=1 would be
>>> helpful, too.
>>>
>>>
>>> thanks,
>>>
>>> Takashi
>>>
>> Hi Takashi,
>>
>> as requestd, please see attached four files, reflecting each
>> combination of probe_only and mic enabled/disabled. To answer your
>> question -- yes, the initial file I had sent reflected the mic
>> disabled state.
>>
>> The BIOS option definitely disables the internal microphone. I could
>> not test whether it would also disable other microphones
>> (e.g. externally connected) since I do not have an external mic, but I
>> will find out.
>
> Hrm, that's strange.  The mic_enabled_default.txt shows "Mic Jack"
> false while the mic_disabled_default.txt shows "Mic Jack" true.
> It sounds like other way round.  Could you confirm this behavior?
>
> In anyway, there seems no difference in the pin configs or such
> between BIOS mic enable/disable.  So this shouldn't be the cause.
>
> And I noticed that you're testing 4.19-rc4.  Could you test with 4.19
> final or 4.19.y stable, at least?
>
>
> thanks,
>
> Takashi
>
Hi Takashi,

I have been trying to reproduce 
this issue with the more recent 4.20-rc6 kernel, and it has not 
reoccurred. As such, I tentatively consider this issue resolved. Thank you 
for your help.

Best regards
Alexander
