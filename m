Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259B9C43A1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 22:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B680520C10
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 22:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kR2HMH7i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B680520C10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390724AbeGKW7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 18:59:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38845 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387885AbeGKW7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 18:59:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id k3-v6so3302735pgq.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 15:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k4UizP5E8ZkFaLZDeK6cy6CNyLs8GMOvdlRQ/BOX66Q=;
        b=kR2HMH7iIt7DaesPzHUGyrKbVWzIOjyThRLcpb7RfASxWxlh0EpZk1kFudayeH5LZn
         2aIN9+driJBfct/jHIyN0FkczMIglR6BhKzxfQw9W4txPkvfqAkFfglfn2/vK7Q76OlM
         ENObHyY5DdCnwmX71Gc40CbdnQQhhm+WkF2ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k4UizP5E8ZkFaLZDeK6cy6CNyLs8GMOvdlRQ/BOX66Q=;
        b=DJb9IqtpBhJnxkiK2CV6T0e4Ltfscxo1GRw2kfX+m7VKCAK4exf3eNCKZ8eSf24DZA
         CCLLbv4JVdDMgOuW+tfavHzlHC7KSlQn5Q768NDFQ2E7VC+aH7zAqizKyYTYFL67e7kR
         /SDWuxFxmGtwkpWEP80rdU2JYjea5XCWv+z6HfZi6ANSzrWmAw9KqyPxrhKmODiFHuoX
         ZHVVYXhKjwLLGtWinsE/eTpSBnLYeSGRNHW5XwkSJT6JGU0ygtS/lY29pa4c6wew8IXR
         9OsxUA+kZR2rC+Jnxyo9WwXfEYh8gj4jKMPZP4+1qd3WBPoL2DA1QXrEjSwDLwcsRsU/
         Mf1A==
X-Gm-Message-State: AOUpUlFziTOtRreN+7ZKUciUe7Oi2yCYHB32shJhIQi/lb1AgjmQ1Sc7
        GFeT/DipkcJUJUFqi379yM2luro+wNQ=
X-Google-Smtp-Source: AAOMgpd2gi/AnYyakcuH7PdXkhsRuav326hu7m+O7SHocOsHbkehRB/8QqBwkB+4ydhhCG6bGI7+LQ==
X-Received: by 2002:a65:6258:: with SMTP id q24-v6mr447382pgv.131.1531349589911;
        Wed, 11 Jul 2018 15:53:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id b11-v6sm28616650pgw.79.2018.07.11.15.53.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 15:53:09 -0700 (PDT)
Date:   Wed, 11 Jul 2018 15:53:08 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     David Collins <collinsd@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: pm8998: Add thermal zone
Message-ID: <20180711225308.GU129942@google.com>
References: <20180628210915.160893-1-mka@chromium.org>
 <20180628210915.160893-3-mka@chromium.org>
 <CAD=FV=Wo4wc_QZYr0a2_Ge=B6T4RNJDnOyxAd8r6sT4iZJjCKg@mail.gmail.com>
 <20180629185102.GV129942@google.com>
 <3b5054bb-76e4-a06f-54bb-e6ea7bbbcc69@codeaurora.org>
 <20180629235417.GY129942@google.com>
 <8144dd3c-6138-7f16-ec17-d75e84fcfb34@codeaurora.org>
 <CAD=FV=XqoRajjNcW8RyJfrcXQVDihfjAnAsN+O9g+6qDrLHfJw@mail.gmail.com>
 <03904a71-c6be-4f93-ad43-7d25631f9a04@codeaurora.org>
 <CAD=FV=XbnuNg_B_Uoj8j9hz0t7=ORdcVB16oDmVk1q2iZYGs9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=XbnuNg_B_Uoj8j9hz0t7=ORdcVB16oDmVk1q2iZYGs9A@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 03:43:34PM -0700, Doug Anderson wrote:
> Hi
> 
> On Wed, Jul 11, 2018 at 3:36 PM, David Collins <collinsd@codeaurora.org> wrote:
> > Hello Doug,
> >
> >> On Tue, Jul 10, 2018 at 10:45 AM, David Collins <collinsd@codeaurora.org> wrote:
> >>> On 06/29/2018 04:54 PM, Matthias Kaehlcke wrote:
> >>>> On Fri, Jun 29, 2018 at 02:29:55PM -0700, David Collins wrote:
> >>> ...
> >>>>> The PMIC TEMP_ALARM hardware peripheral will perform an automatic partial
> >>>>> PMIC shutdown upon hitting over-temperature stage 2 (125 C).  This turns
> >>>>> off peripherals within the PMIC that are expected to draw significant
> >>>>> current.  The set of peripherals included varies between PMICs.  This
> >>>>> partial shutdown will occur simultaneously with the triggering of an
> >>>>> interrupt to the APPS processor that informs the qcom-spmi-temp-alarm
> >>>>> driver that an over-temperature threshold has been crossed.
> >>>>>
> >>>>> The TEMP_ALARM peripheral will perform an automatic full PMIC shutdown
> >>>>> upon hitting over-temperature stage 3 (145 C).  Software won't receive an
> >>>>> interrupt in this case because all power is cut.
> >>>>
> >>>> This information is very useful, thanks David!
> >>>>
> >>>> The (partial) hardware shutdown seems like a good measure of last
> >>>> resort, however I suppose we prefer Linux to initiate a shutdown
> >>>> before losing part of the peripherals (drivers might not be happy
> >>>> about this and probably not revover even when the temperature goes
> >>>> down again) or reach a full PMIC shutdown.
> >>>>
> >>>> Please let me know if there are reasons to prefer to go the hardware
> >>>> limits, it's also an option for device makers to overwrite these
> >>>> settings if they want different behavior.
> >>>
> >>> Disabling stage 3 automatic full PMIC shutdown at 145 C is definitely a
> >>> bad idea.  This exists as a last resort in order to save the hardware and
> >>> ensure end user safety in case of excessive temperature even if software
> >>> is locked up.
> >>>
> >>> Disabling stage 2 automatic partial PMIC shutdown at 125 C is not
> >>> recommended as the PMIC is already outside of reasonable operating
> >>> conditions and needs to take corrective action quickly.  However, doing so
> >>> may be acceptable if software is taking action to shut down the system
> >>> immediately upon receiving the stage 2 over-temperature interrupt.
> >>> Just to confirm: is it expected that at stage 2 the CPU's on the SoC
> >> should continue running even with partial PMIC shutdown enabled?
> >
> > This is not guaranteed.
> >
> >
> >> It sounded to me like partial PMIC shutdown was supposed to shut down
> >> high-power rails that were not essential to the task of performing an
> >> orderly shutdown.
> >
> > Shutting down high-power peripherals is accurate; however, special care is
> > not taken to ensure that an orderly shutdown is possible.  At the very
> > least, the HW and SW state will be out of sync for the peripherals that
> > are shut down.
> 
> OK, I guess I'm confused now.  Why does partial PMIC shutdown even
> exist then?  What is the point of leaving some rails alive if software
> could stop running?  It seems like it would be better to just shut
> everything down.
> 
> Said another way: can you describe what benefit you see for only
> partially shutting down the PMIC at stage 2 compared to just fully
> shutting it down at stage 2?
> 
> 
> >> I think Matthias was seeing that when he reached stage 2 and partial
> >> PMIC shutdown happened that the system was just falling on the floor.
> >> ...maybe we just have things configured incorrectly?
> >
> > More information about the exact crash steps would be helpful to
> > investigate this further.  I'm not sure how much time you want to put into
> > it though.
> 
> Matthias can add more, but basically he heated the system up and when
> it reached the stage 2 shutdown it was no longer responsive.

The system behaved as on a warm reset when reaching stage 2
temperature, no kernel crash, but messages in /dev/pstore were
preserved.
