Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276F8C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 14:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97FE20843
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 14:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D97FE20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eircom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbeJ1XK4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 19:10:56 -0400
Received: from vie01a-dmta-pe06-1.mx.upcmail.net ([84.116.36.14]:62219 "EHLO
        vie01a-dmta-pe06-1.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726450AbeJ1XK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 19:10:56 -0400
Received: from [172.31.216.235] (helo=vie01a-pemc-psmtp-pe12.mail.upcmail.net)
        by vie01a-dmta-pe06.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <mikebrady@eircom.net>)
        id 1gGm13-0001bu-0V
        for linux-kernel@vger.kernel.org; Sun, 28 Oct 2018 15:26:09 +0100
Received: from helix.aillwee.com ([37.228.204.209])
        by vie01a-pemc-psmtp-pe12.mail.upcmail.net with ESMTP
        id Gm11gtJgIkosQGm11g9Cde; Sun, 28 Oct 2018 15:26:08 +0100
X-Env-Mailfrom: mikebrady@eircom.net
X-Env-Rcptto: linux-kernel@vger.kernel.org
X-SourceIP: 37.228.204.209
X-CNFS-Analysis: v=2.3 cv=NNQEBHyg c=1 sm=1 tr=0
 a=/+iDkf0alGTUGXENEoGzTg==:117 a=/+iDkf0alGTUGXENEoGzTg==:17
 a=IkcTkHD0fZMA:10 a=smKx5t2vBNcA:10 a=3uxiNX8bdHwq9VOc5UcA:9 a=QEXdDO2ut3YA:10
Received: from [172.20.10.4] (unknown [77.75.241.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by helix.aillwee.com (Postfix) with ESMTPSA id 7B9B54E6CD;
        Sun, 28 Oct 2018 14:26:06 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [alsa-devel] [PATCH v2] staging: bcm2835-audio: interpolate audio
 delay
From:   Mike Brady <mikebrady@eircom.net>
In-Reply-To: <s5hftwuo4t0.wl-tiwai@suse.de>
Date:   Sun, 28 Oct 2018 14:26:12 +0000
Cc:     Kirill Marinushkin <k.marinushkin@gmail.com>,
        stefan.wahren@i2se.com, devel@driverdev.osuosl.org,
        alsa-devel@alsa-project.org, f.fainelli@gmail.com, eric@anholt.net,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        julia.lawall@lip6.fr, linux-rpi-kernel@lists.infradead.org,
        nishka.dasgupta_ug18@ashoka.edu.in,
        linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 8BIT
Message-Id: <126FA055-050B-4AAC-9392-CA8CCA821768@eircom.net>
References: <20181022191708.GA4659@ubuntu>
 <a703f8a2-e85a-bc5b-750a-cc43ef252ba5@gmail.com>
 <EA85FEC9-B1C7-4548-88F5-F0E7BC12158E@eircom.net>
 <046aea96-e0d3-60f4-c61a-c26bb1b5c193@gmail.com>
 <B9A84822-3780-4E01-96AD-FD3B42C44B45@eircom.net>
 <9884c4f5-2343-e3a4-8d8b-dd2db404ef27@gmail.com>
 <s5hftwuo4t0.wl-tiwai@suse.de>
To:     Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3445.100.39)
X-CMAE-Envelope: MS4wfNJXJWIA8zFo7T3zMz66ebeaL/jBU7Ay6GNnjEDnD4NwjhNVbbay36/n+jPjzVrHK3qJfyrr3KkMw1KFpWKYWK/F11KKPNmFbskmWbpyBNvU/DBGCc3j
 nKEusel5Ihv1CDV+FoaLZRm4jN13efbvxE1Sc5uzpzxsgoHxL2Z6U+G0wHXMfmED8UYkWpuIWLi+Xr2+OyZfg0uHAxpfvPVLs6VKrgNTXlnSsGC1uuP3AOnT
 BrXzOMawo+4mySks3mgkfBkHfsFXv/10jtXqjAWO21aBRMx1HKi7MYLZ6684ZjQA0k6ULbxPE52KbcnqqyxWA3E8wtGnxlsJrFkCqY3qYw58GtBbsVsiCAC/
 Y5bUaoDm062j5RL8rKVQAuIZdwlV4nCIWfEMWA6Lyj1vTqyNsOIwOqjMrIFknVi6+CWaFW0WStRZ8i7NMAgu3HxSfLxdGikHeiZMbHDAjOhXwAPmirvbr+CV
 kExkHG0I1bgxdfFwc6erMcRI6X66mSbRUEPGkdlRLfMsNtLEEBeeEKiKv9PvsrXaQa+aHKl2ndYNf4qF1V7wLGDV7jYJv8jKaXQ5shxXiTw6GojlPtAGBUjH
 5G5LsHDI+mjfs9CYFHxwilCrUiMXscVU/hm0qpEivqAx/8fmkvHZhdQHux0j4SADlLg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 25 Oct 2018, at 08:37, Takashi Iwai <tiwai@suse.de> wrote:
> 
> On Thu, 25 Oct 2018 00:02:34 +0200,
> Kirill Marinushkin wrote:
>> 
>>>> When you play sound - the pointer increments.
>>> 
>>> Unfortunately, when you play sound, the pointer does not actually increment, for up to about 10 milliseconds. I know of no way to actually access the true “live” position of the frame that is being played at any instant; hence the desire to estimate it.
>>> 
>> 
>> Your vision of situation in the opposite from my vision. What you see as a
>> symptom - I see as a root cause. As I see, you should fix the
>> pointer-not-incrementing. Why do you think that it's okay that the pointer is
>> not updating during sound play? Why do you insist that there is a delay? I don't
>> understand why we are so stuck here.
> 
> Well, in the API POV, it's nothing wrong to keep hwptr sticking while
> updating only delay value.  It implies that the hardware chip doesn't
> provide the hwptr update.
> 
> Though, usually the delay value is provided also from the hardware,
> e.g. reading the link position or such.  It's a typical case like
> USB-audio, where the hwptr gets updated and the delay indicates the
> actual position *behind* hwptr.  That works because hwptr shows the
> position in the ring buffer at which you can access the data.  And it
> doesn't mean that hwptr is the actually playing position, but it can
> be ahead of the current position, when many samples are queued on
> FIFO.  The delay is provided to correct the position back to the
> actual point.
> 
> But, this also doesn't mean that the delay shouldn't be used for the
> purpose like this patchset, either.  OTOH, providing a finer hwptr
> value would be likely more apps-friendly; there must be many programs
> that don't evaluate the delay value properly.
> 
> So, I suppose that hwptr update might be a better option if the code
> won't become too complex.  Let's see.

Indeed. It will take me a few days to look into this…

Regards
Mike

> One another thing I'd like to point out is that the value given in the
> patch is nothing but an estimated position, optimistically calculated
> via the system timer.  Mike and I had already discussion in another
> thread, and another possible option would be to provide the proper
> timestamp-vs-hwptr pair, instead of updating the timestamp always at
> the status read.
> 
> Maybe it's worth to have a module option to suppress this optimistic
> hwptr update behavior, in case something went wrong with clocks?
> 
> 
> thanks,
> 
> Takashi

