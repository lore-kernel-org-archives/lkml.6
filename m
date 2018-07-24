Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4278BECDE5F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 00:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F6120874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 00:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H6VUW9aj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F6120874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388285AbeGXCAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 22:00:16 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40485 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388227AbeGXCAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 22:00:16 -0400
Received: by mail-pg1-f193.google.com with SMTP id x5-v6so1582710pgp.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 17:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=le7y31HR/Bi4pdssjNqnjp0yx7LL2M7ZC2semmqdVZ8=;
        b=H6VUW9aj2ZqMlEmfB5jEr/QaOGG1JZlQOHf2QpPP3HrW0AhN4XKPlxVYpi9guBRzdE
         P2fbYmQKcn+PpKeYxuMbpj41Hf4TJRdHsUquXJsoHg1/kAbV71T7+ffC+Q9ZZdJSA0h8
         5tcN9KCWo3pJkB9aZYCVLPx7sadI+3AFbbKiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=le7y31HR/Bi4pdssjNqnjp0yx7LL2M7ZC2semmqdVZ8=;
        b=IrJ/TPNfSp/SOUiuNJNVlBIIhZMgW4oH1CdZzsTsUB2LgW8Uj1eGfzFTPTYCUOvJnh
         8fI5NHO8wYhxS1XN5n6vs1aM3s8OZvp1VtzoccOp5Ku4NYyMD0GSqdwndJn0wlkZrdq9
         Hx/yMLXknyImzGTmZUkZ0re47WMJy5J27/b43H3RUKiZOfD0DzSZ440OVajYQ3p4FmpH
         nCY23YhL9Q6SUyppsDWbauljqMCid23EPPHyNb+d091DmENIv1R1rZKyreAHcY34sUBM
         QUKVIOJw2BGmxM8cOrSQ+5QbGReXU3xSYwDqUT8TgZzgqCXcMXsN/OMfCpIVgbqNmtmo
         p5nA==
X-Gm-Message-State: AOUpUlH9HkAnInxVkxPpxeVC5pnikT+zcVY84Sfeyeh6mMLTZh3t11bm
        FshJ3kehm4kmNrqcGh0UHpn8rHuUOQk=
X-Google-Smtp-Source: AAOMgpcrFGUeUemQ5im1Rmbz66W3bgKZw183MvcATAZKk1RD4bO6OWiezHmXqD0fTNrzxhKhCIMTrA==
X-Received: by 2002:a63:fd06:: with SMTP id d6-v6mr14379608pgh.348.1532393786655;
        Mon, 23 Jul 2018 17:56:26 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y69-v6sm27997581pfd.36.2018.07.23.17.56.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 17:56:26 -0700 (PDT)
Date:   Mon, 23 Jul 2018 17:55:21 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     David Lechner <david@lechnology.com>, Pavel Machek <pavel@ucw.cz>,
        Baolin Wang <baolin.wang@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] leds: core: Introduce generic pattern interface
Message-ID: <20180724005521.GG30024@minitux>
References: <20180714222924.GA2776@amd>
 <20180714223907.GB2776@amd>
 <1138f834-e805-6076-bb5b-aa1fdc1f2606@gmail.com>
 <2c3a8911-150a-9b25-2a66-a9432047f96b@lechnology.com>
 <68996338-a902-2b57-0bb9-df274a496b06@gmail.com>
 <20180718075637.GA10279@amd>
 <CAMz4kuJa=s19q7wQFQT1giUe0AN4hpux4PG2koUcnE7q_x7LCQ@mail.gmail.com>
 <20180718120836.GB23157@amd>
 <47b1b143-48dd-a265-c2af-254dda53a2cc@lechnology.com>
 <8e51d2f1-0fc0-a968-4f97-3a4e09dd99e0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e51d2f1-0fc0-a968-4f97-3a4e09dd99e0@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 20 Jul 12:11 PDT 2018, Jacek Anaszewski wrote:

> Hi David,
> 
> On 07/18/2018 07:00 PM, David Lechner wrote:
> > 
> > 
> > On 7/18/18 7:08 AM, Pavel Machek wrote:
> > > On Wed 2018-07-18 19:32:01, Baolin Wang wrote:
> > > > On 18 July 2018 at 15:56, Pavel Machek <pavel@ucw.cz> wrote:
> > > > > Hi!
> > > > > 
> > > > > > > > > > I believe I meant "changing patterns
> > > > > > > > > > from kernel in response to events
> > > > > > > > > > is probably overkill"... or something like that.
> > > > > > > > > 
> > > > > > > > > Anyway -- to clean up the confusion -- I'd like to see
> > > > > > > > > 
> > > > > > > > > echo pattern > trigger
> > > > > > > > > echo "1 2 3 4 5 6 7 8" > somewhere
> > > > > > > > 
> > > > > > > > s/somewhere/pattern/
> > > > > > > > 
> > > > > > > > pattern trigger should create "pattern" file
> > > > > > > > similarly how ledtrig-timer
> > > > > > > > creates delay_{on|off} files.
> > > > > 
> > > > > Yes, that sounds reasonable. v5 still says
> > > > > 
> > > > > +               Writing non-empty string to this file will
> > > > > activate the pattern,
> > > > > +               and empty string will disable the pattern.
> > > > > 
> > > > > I'd deactivate the pattern by simply writing something else to the
> > > > > trigger file.
> > > > 
> > > > For the case we met in patch 2, it is not related with trigger things.
> > > > We just set some series of tuples including brightness and duration
> > > > (ms) to the hardware to enable the breath mode of the LED, we did not
> > > > trigger anything. So it is weird to write something to trigger file to
> > > > deactive the pattern.
> > > 
> > > Confused. I thought that "breathing mode" would be handled similar way
> > > to hardware blinking: userland selects pattern trigger, pattern file
> > > appears (similar way to delay_on/delay_off files with blinking), he
> > > configures it, hardware brightness follows the pattern ("breathing
> > > mode"). If pattern is no longer required, echo none > trigger stops
> > > it.
> > >                                     Pavel
> > > 
> > 
> > I was confused too when I first read this thread. But after reviewing
> > v5, it is clear that this is _not_ a trigger (and it should not be a
> > trigger). This is basically the equivalent the brightness attribute -
> > except that now the brightness changes over time instead of being a
> > constant value.
> 
> Pattern trigger would be just more flexible version of existing
> ledtrig-timer.c, which also changes brightness over time.
> 
> Trigger, by definition, is a kernel based source of LED events,
> so timer trigger falls under this definition, same way as pattern
> trigger would.
> 
> What may cause confusion is the possibility of exploiting hardware
> capabilities, in case the requested settings fit in.
> ledtrig-timer fathom the hardware capabilities using blink_set op,
> and pattern trigger would use pattern_set op for that purpose.
> 

For the use cases I had in mind it's perfectly fine to describe this as
a trigger.

But that said, I rather quickly started playing around with associating
patterns to trigger events; e.g. having a continuous pulse associated
with the bluetooth "power" trigger or defining a smooth rampdown for the
mmc activity trigger.

> > This way, the pattern can be used in conjunction with triggers.
> > 
> > For example, one might want to set the _pattern_ to something like a
> > "breathe" pattern and set the _trigger_ to the power supply charging
> > full trigger. This way, the LED will be off until the battery is full
> > and then the LED will "breath" when the battery is full.
> 
> AFAICS you comprehend "pattern trigger" notion as a LED trigger that
> activates pattern functionality. I'd say that you'd need a specialized
> "battery" trigger for that purpose, that instead of calling
> led_set_brightness_nosleep() would schedule call to
> led_trigger_set(led_cdev "pattern"), assuming that pattern trigger
> would be implemented as I explained above.
> 

Presumably the battery logic has a number of states; low batter
discharging, low battery charging, full battery, levels in-between.

Defining the levels for these and an appropriate UX seems like a job for
something with a little bit of configurability and product specific
logic. The transitions here would need to reconfigure the pattern, so it
doesn't seem unreasonable for it to also set the pattern trigger.


I'm not sure this logic does belong in the kernel, but I think that
question is of less importance for the design of this.

Regards,
Bjorn
