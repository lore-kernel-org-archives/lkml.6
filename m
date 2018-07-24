Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1573FECDE5F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 00:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B271020852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 00:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wm+8oyzy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B271020852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388244AbeGXBXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 21:23:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34826 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388149AbeGXBXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 21:23:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6-v6so1530421pgv.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 17:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VHS1EWb9GT/7Qy/MnDqMpQcxktJ5P4zMipAxegMiH1s=;
        b=Wm+8oyzypPrg0mz9ibBX28CTzjk+QGmyiSgf8Q1EZYUaM9TtclvZ8GdsNrWCnjY5Mr
         7Ikg9krnGJcW3zAJNX2gk6ahJ3dc7nufbGN7UsDkaXPVwIZyCkEFx5L0KHbwqDA2xc2t
         cQP1L33HY7LPVcPKNG18Z84MeUCb6h8EFqv3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VHS1EWb9GT/7Qy/MnDqMpQcxktJ5P4zMipAxegMiH1s=;
        b=cnl80yzQMeIP+ulYFqXbE7CX5U7wtdr5rq1lLpuxqDcRfrL63P7DYl7w5Ej3WnS2Cn
         GNqPSbKsC1zP9QhzTsPaHL1bZ49yEFyh2EDBQXauJYwAQVnTxFXspUGEx10a2Gh08iVo
         rzaQMaPn5mJoeDUHKBQO0xjWJIzHKolcIFcEuSFGc7ZmDzbe4uGHokX/b1MNiOiiT9LN
         wXbnFy3607QKMEBq7m2qLpUskxgdUbKVLW2kU0o6ILbBV7EMzypnTvDECzfvE1x79ROV
         Fhpsm/Btj0QYlo1pdczZs85Ma3Qc2N8GRSjgiSchlB5kL3U/h6X3vhsWnZlMD9xLaX+Z
         9elA==
X-Gm-Message-State: AOUpUlGoT40iEx/2z1TU/UTZEN9iUO6JKVRxiyK3r15mqmp7MlgQ8Fh2
        2pZNPx9GmTcXILZ0VbVJM44R+A==
X-Google-Smtp-Source: AAOMgpcX+uWP0ws6y+L/tMaRGzXWMCuanSAYm8k5UjJorLfa+MfOgFkNl9TJlJsdz6LXKyZWE9xl4A==
X-Received: by 2002:a62:34c4:: with SMTP id b187-v6mr15179969pfa.15.1532391597107;
        Mon, 23 Jul 2018 17:19:57 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g10-v6sm12115863pgs.17.2018.07.23.17.19.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 17:19:56 -0700 (PDT)
Date:   Mon, 23 Jul 2018 17:18:51 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     David Lechner <david@lechnology.com>
Cc:     Baolin Wang <baolin.wang@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] leds: core: Introduce generic pattern interface
Message-ID: <20180724001851.GE30024@minitux>
References: <1665b877dc2f886a90a00e3ca3b7425372d99b6e.1530248085.git.baolin.wang@linaro.org>
 <CAMz4kuJfPKykB6G-8C25mmMCfQgefv-Y=k2OQYZR_e0Tvg3guQ@mail.gmail.com>
 <8da1b769-8aa3-9698-467a-2e7b0707fecf@gmail.com>
 <CAMz4kuKZ6Z1h=yzFYJihEH1ARC5FKtDC6RLz0u8SmaekOZ=utw@mail.gmail.com>
 <20180714212033.GA31950@amd>
 <00fa2693-9308-8d74-0124-04066a76c35a@gmail.com>
 <20180714222924.GA2776@amd>
 <20180714223907.GB2776@amd>
 <1138f834-e805-6076-bb5b-aa1fdc1f2606@gmail.com>
 <2c3a8911-150a-9b25-2a66-a9432047f96b@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c3a8911-150a-9b25-2a66-a9432047f96b@lechnology.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 15 Jul 18:00 PDT 2018, David Lechner wrote:

> On 07/15/2018 07:22 AM, Jacek Anaszewski wrote:
> > On 07/15/2018 12:39 AM, Pavel Machek wrote:
> > > On Sun 2018-07-15 00:29:25, Pavel Machek wrote:
> > > > On Sun 2018-07-15 00:02:57, Jacek Anaszewski wrote:
> > > > > Hi Pavel,
> > > > > 
> > > > > On 07/14/2018 11:20 PM, Pavel Machek wrote:
> > > > > > Hi!
> > > > > > 
> > > > > > > > It also drew my attention to the issue of desired pattern sysfs
> > > > > > > > interface semantics on uninitialized pattern. In your implementation
> > > > > > > > user seems to be unable to determine if the pattern is activated
> > > > > > > > or not. We should define the semantics for this use case and
> > > > > > > > describe it in the documentation. Possibly pattern could
> > > > > > > > return alone new line character then.
> > > > > > 
> > > > > > Let me take a step back: we have triggers.. like LED blinking.
> > > > > > 
> > > > > > How is that going to interact with patterns? We probably want the
> > > > > > patterns to be ignored in that case...?
> > > > > > 
> > > > > > Which suggest to me that we should treat patterns as a trigger. I
> > > > > > believe we do something similar with blinking already.
> > > > > > 
> > > > > > Then it is easy to determine if pattern is active, and pattern
> > > > > > vs. trigger issue is solved automatically.
> > > > > 
> > > > > I'm all for it. I proposed this approach during the previous
> > > > > discussions related to possible pattern interface implementations,
> > > > > but you seemed not to be so enthusiastic in [0].
> > > > > 
> > > > > [0] https://lkml.org/lkml/2017/4/7/350
> > > > 
> > > > Hmm. Reading my own email now, I can't decipher it.
> > > > 
> > > > I believe I meant "changing patterns from kernel in response to events
> > > > is probably overkill"... or something like that.
> > > 
> > > Anyway -- to clean up the confusion -- I'd like to see
> > > 
> > > echo pattern > trigger
> > > echo "1 2 3 4 5 6 7 8" > somewhere
> > 
> > s/somewhere/pattern/
> > 
> > pattern trigger should create "pattern" file similarly how ledtrig-timer
> > creates delay_{on|off} files.
> > 
> 
> I don't think this is the best way. For example, if you want more than one
> LED to have the same pattern, then the patterns will not be synchronized
> between the LEDs. The same things happens now with many of the existing
> triggers. For example, if I have two LEDs side-by-side using the heartbeat
> trigger, they may blink at the same time or they may not, which is not
> very nice. I think we can make something better.
> 
> Perhaps a way to do this would be to use configfs to create a pattern
> trigger that can be shared by multiple LEDs. Like this:
> 
>     mkdir /sys/kernel/config/leds/triggers/my-nice-pattern
>     echo "1 2 3 4" > /sys/kernel/config/leds/triggers/my-nice-pattern/pattern
>     echo my-nice-pattern > /sys/class/leds/led0/trigger
>     echo my-nice-pattern > /sys/class/leds/led1/trigger
> 

In the case where you describe this as two different LEDs (to Linux) and
you rely on the two enable-calls to happen fairly quickly I think you
can just as well specify the same pattern in two independent triggers.

This also helps by not providing the illusion of there being any
synchronization between them.

Regards,
Bjorn
