Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0378C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8341A2083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8341A2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eircom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388789AbeKGGcY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 01:32:24 -0500
Received: from vie01a-dmta-pe06-1.mx.upcmail.net ([84.116.36.14]:18090 "EHLO
        vie01a-dmta-pe06-1.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388709AbeKGGcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 01:32:24 -0500
Received: from [172.31.216.235] (helo=vie01a-pemc-psmtp-pe12.mail.upcmail.net)
        by vie01a-dmta-pe06.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <mikebrady@eircom.net>)
        id 1gK8XC-0004Tw-0u
        for linux-kernel@vger.kernel.org; Tue, 06 Nov 2018 22:05:14 +0100
Received: from helix.aillwee.com ([37.228.204.209])
        by vie01a-pemc-psmtp-pe12.mail.upcmail.net with ESMTP
        id K8XAgjn21kosQK8XAgt5bC; Tue, 06 Nov 2018 22:05:13 +0100
X-Env-Mailfrom: mikebrady@eircom.net
X-Env-Rcptto: linux-kernel@vger.kernel.org
X-SourceIP: 37.228.204.209
X-CNFS-Analysis: v=2.3 cv=NNQEBHyg c=1 sm=1 tr=0
 a=/+iDkf0alGTUGXENEoGzTg==:117 a=/+iDkf0alGTUGXENEoGzTg==:17
 a=IkcTkHD0fZMA:10 a=JHtHm7312UAA:10 a=L036LgW0_Yr9JVcQY6gA:9 a=QEXdDO2ut3YA:10
Received: from [192.168.50.181] (apu.aillwee.com [192.168.50.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by helix.aillwee.com (Postfix) with ESMTPSA id E09714E607;
        Tue,  6 Nov 2018 21:05:11 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [alsa-devel] [PATCH v2] staging: bcm2835-audio: interpolate audio
 delay
From:   Mike Brady <mikebrady@eircom.net>
In-Reply-To: <s5hsh0f1p30.wl-tiwai@suse.de>
Date:   Tue, 6 Nov 2018 21:05:11 +0000
Cc:     Stefan Wahren <stefan.wahren@i2se.com>, devel@driverdev.osuosl.org,
        alsa-devel@alsa-project.org, f.fainelli@gmail.com,
        julia.lawall@lip6.fr,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        linux-rpi-kernel@lists.infradead.org,
        nishka.dasgupta_ug18@ashoka.edu.in,
        Kirill Marinushkin <k.marinushkin@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 8BIT
Message-Id: <6AF69E32-029E-478F-9BFA-6262316364A9@eircom.net>
References: <20181022191708.GA4659@ubuntu>
 <a703f8a2-e85a-bc5b-750a-cc43ef252ba5@gmail.com>
 <EA85FEC9-B1C7-4548-88F5-F0E7BC12158E@eircom.net>
 <046aea96-e0d3-60f4-c61a-c26bb1b5c193@gmail.com>
 <B9A84822-3780-4E01-96AD-FD3B42C44B45@eircom.net>
 <9884c4f5-2343-e3a4-8d8b-dd2db404ef27@gmail.com>
 <s5hftwuo4t0.wl-tiwai@suse.de>
 <126FA055-050B-4AAC-9392-CA8CCA821768@eircom.net>
 <C35AD288-063F-4197-A758-450CBB3B1184@eircom.net>
 <s5hsh0f1p30.wl-tiwai@suse.de>
To:     Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3445.101.1)
X-CMAE-Envelope: MS4wfF61j+ZIMmWnjl1sFnu1hqd6EJyuMzItfjGIDOQ84Dgq6eGPi1HhfWOIkbJHmcaRLbv0kJP4mxBOb/bRAupqhEquDg3ALJv36pzpVbUtFmyrWF2ELUR/
 nEvlaBF0pt9QDMWgT4NNfwuq/KMnwf5OoFPpL26fnfSR257TafeApVnSmx+xXmO/bfSo5kakWI7McKBZq+/v6g2KIEhUzq71eHAb88tEHlW8WFHnH4Q638fI
 OnbmNReviyBTnqYoTjQb5pL4JpsXWMeqjPVgLjQU4Crj/VSnYuFVGoo7fPQzUoOLpt3j8qUWGdRk3ZrrN16zQSgr8lDJ3etCcqhiL2CYW5Z3MByxbWySVKJv
 rlwkjhqQO1jc/xPkLm+J5WPj/+KKQvz441VarjaIBw1xBLyDdiYCMpl0ykc/Bo/s1WTOuTOKnVu/fuHGSaWJ1ph4ml4D2o9UjwxWvYzKO7G79TQqtPkEwcm7
 bYUTYX2APeEmgG/CrRVY3kIhaU/lPCpSiiI6vJFvAPa2tHtFMSFKE7s4lYQu0DS6elZLg8/SENpK5jwb79B/tvbvRKDTme3L4OYYYtMeJQPdcmjgHULTlGNT
 wZLggCo2I2lUvmfdkkDSmCOXV+E+grtbAf9vquBWLlQt5mlNjiCllZW1ehE5WPdnBX0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 5 Nov 2018, at 16:11, Takashi Iwai <tiwai@suse.de> wrote:
> 
> On Mon, 05 Nov 2018 16:57:07 +0100,
> Mike Brady wrote:
>> 
>>> One another thing I'd like to point out is that the value given in the
>>> patch is nothing but an estimated position, optimistically calculated
>>> via the system timer.  Mike and I had already discussion in another
>>> thread, and another possible option would be to provide the proper
>>> timestamp-vs-hwptr pair, instead of updating the timestamp always at
>>> the status read.
>> 
>> Agreed — that would give the caller the information needed to do the
>> interpolation for themselves if desired.
> 
> And now I wonder whether the problem is still present with the latest
> code.  There was a (kind of) regression in this regard when we
> introduced the fine-grained hardware timestamping, but it should have
> been addressed by the commit 20e3f985bb875fea4f86b04eba4b6cc29bfd6b71
>    ALSA: pcm: update tstamp only if audio_tstamp changed
> 
> Could you double-check whether the tstamp field gets still updated
> even if no hwptr (and delay) is changed?

Yes, this could be a bit problematic. The function update_audio_tstamp in pcm_lib.c could include the interpolated delay in the calculation of audio_tstamp, and hence
could trigger the update of tstamp.

Another issue, as I see it, is that the the audio_tstamp value would depend on whether, and when, a snd_pcm_delay() call (which recalculates the interpolation and puts it into the delay field) was made immediately prior to it. By zeroing the delay when a GPU interrupt occurs, you could be certain that the interpolated delay would be less than or equal to the true delay, but this doesn’t seem very satisfactory — you have neither the timestamp of the last update nor the correctly interpolated timestamp. 

Sadly, therefore, I’m now of the view that this approach to interpolating the delay between GPU interrupts is not really viable. Would that be your view?

Regards
Mike

> thanks,
> 
> Takashi

