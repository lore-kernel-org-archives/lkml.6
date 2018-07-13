Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E62ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A682087A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ild+ET+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A682087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387852AbeGMREb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 13:04:31 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36218 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729926AbeGMREb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 13:04:31 -0400
Received: by mail-pl0-f66.google.com with SMTP id a7-v6so12435608plp.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 09:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y/Xhl5/gUDYUp/VvKuXT/qm15MXj0lmtQ9q7aD+uLxE=;
        b=Ild+ET+v7Vw0M27wpl0fkBs5eyqnK1ptvm8nDRJgRhc5FTrnGlHIc3ogr4T0EBQbja
         NLp6ftI+QuX/M+OvIygY34Ax5URmjPWpamtdUHX2ImEb1qiSBFcIJ7POMZbjQSUrNxGO
         unMoMi9WHWXGgG2lHZZErl3ycmda/N9tNGsHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y/Xhl5/gUDYUp/VvKuXT/qm15MXj0lmtQ9q7aD+uLxE=;
        b=aNqJJh6BoSG4jpC5UMDD+JqInaZOAy4pwdKyhJqV+WIWew1v7rd7YtQwWkdcMPWwSW
         bwA+8fwgZyteybwh918bcqs+RjqLDBv41vVfIayVPFEJCFHdHbTCpqkU+YX8DhNdtV85
         62pq3Z1DHCaRgYcfqniEgiFo0BOOlwgdHN77T46cycjdxC5XhAbChjE1lD1wDlXmoj1V
         9zLmZTpGBW7WyzMDGsXGFWx5hjw7/GyhsmtzqM4kG0ENEYvWa+7Ftuaxf5fu5B+M+CWn
         zrJFOcIoDk1oOHQI0bCS92ubyOcTkeHCTpoxKpW0fksJBkEWFYCI56ZagCGdAZLcBMKA
         i03g==
X-Gm-Message-State: AOUpUlE5oT4pcIXJShtfAnHEsE4Qz0FihrYe1t8RP8PkM7Qsa4Zl4VDR
        +2mx/hvWMcjxlpZClslaKLQWcw==
X-Google-Smtp-Source: AAOMgpcAkcmMM09uAXq9mlqCLYswt/rfEUOY65Lr9oP1KKDvgkDqUwruR3WEYik0uEBk+pTI4pUlEQ==
X-Received: by 2002:a17:902:6b0b:: with SMTP id o11-v6mr7306421plk.101.1531500544785;
        Fri, 13 Jul 2018 09:49:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id p26-v6sm46390356pfi.164.2018.07.13.09.49.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 09:49:04 -0700 (PDT)
Date:   Fri, 13 Jul 2018 09:49:03 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     David Collins <collinsd@codeaurora.org>
Cc:     Doug Anderson <dianders@chromium.org>,
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
Message-ID: <20180713164903.GX129942@google.com>
References: <20180628210915.160893-3-mka@chromium.org>
 <CAD=FV=Wo4wc_QZYr0a2_Ge=B6T4RNJDnOyxAd8r6sT4iZJjCKg@mail.gmail.com>
 <20180629185102.GV129942@google.com>
 <3b5054bb-76e4-a06f-54bb-e6ea7bbbcc69@codeaurora.org>
 <20180629235417.GY129942@google.com>
 <8144dd3c-6138-7f16-ec17-d75e84fcfb34@codeaurora.org>
 <CAD=FV=XqoRajjNcW8RyJfrcXQVDihfjAnAsN+O9g+6qDrLHfJw@mail.gmail.com>
 <03904a71-c6be-4f93-ad43-7d25631f9a04@codeaurora.org>
 <CAD=FV=XbnuNg_B_Uoj8j9hz0t7=ORdcVB16oDmVk1q2iZYGs9A@mail.gmail.com>
 <aff517d2-df92-da86-fc1e-5f8f8c42f736@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aff517d2-df92-da86-fc1e-5f8f8c42f736@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 05:10:50PM -0700, David Collins wrote:
> Hello Doug,
> 
> On 07/11/2018 03:43 PM, Doug Anderson wrote:
> > On Wed, Jul 11, 2018 at 3:36 PM, David Collins <collinsd@codeaurora.org> wrote:
> >>> On Tue, Jul 10, 2018 at 10:45 AM, David Collins <collinsd@codeaurora.org> wrote:
> >>>> On 06/29/2018 04:54 PM, Matthias Kaehlcke wrote:
> >>>>> On Fri, Jun 29, 2018 at 02:29:55PM -0700, David Collins wrote:
> >>>> ...
> >>>>>> The PMIC TEMP_ALARM hardware peripheral will perform an automatic partial
> >>>>>> PMIC shutdown upon hitting over-temperature stage 2 (125 C).  This turns
> >>>>>> off peripherals within the PMIC that are expected to draw significant
> >>>>>> current.  The set of peripherals included varies between PMICs.  This
> >>>>>> partial shutdown will occur simultaneously with the triggering of an
> >>>>>> interrupt to the APPS processor that informs the qcom-spmi-temp-alarm
> >>>>>> driver that an over-temperature threshold has been crossed.
> >>>>>>
> >>>>>> The TEMP_ALARM peripheral will perform an automatic full PMIC shutdown
> >>>>>> upon hitting over-temperature stage 3 (145 C).  Software won't receive an
> >>>>>> interrupt in this case because all power is cut.
> >>>>>
> >>>>> This information is very useful, thanks David!
> >>>>>
> >>>>> The (partial) hardware shutdown seems like a good measure of last
> >>>>> resort, however I suppose we prefer Linux to initiate a shutdown
> >>>>> before losing part of the peripherals (drivers might not be happy
> >>>>> about this and probably not revover even when the temperature goes
> >>>>> down again) or reach a full PMIC shutdown.
> >>>>>
> >>>>> Please let me know if there are reasons to prefer to go the hardware
> >>>>> limits, it's also an option for device makers to overwrite these
> >>>>> settings if they want different behavior.
> >>>>
> >>>> Disabling stage 3 automatic full PMIC shutdown at 145 C is definitely a
> >>>> bad idea.  This exists as a last resort in order to save the hardware and
> >>>> ensure end user safety in case of excessive temperature even if software
> >>>> is locked up.
> >>>>
> >>>> Disabling stage 2 automatic partial PMIC shutdown at 125 C is not
> >>>> recommended as the PMIC is already outside of reasonable operating
> >>>> conditions and needs to take corrective action quickly.  However, doing so
> >>>> may be acceptable if software is taking action to shut down the system
> >>>> immediately upon receiving the stage 2 over-temperature interrupt.
> >>>> Just to confirm: is it expected that at stage 2 the CPU's on the SoC
> >>> should continue running even with partial PMIC shutdown enabled?
> >>
> >> This is not guaranteed.
> >>
> >>
> >>> It sounded to me like partial PMIC shutdown was supposed to shut down
> >>> high-power rails that were not essential to the task of performing an
> >>> orderly shutdown.
> >>
> >> Shutting down high-power peripherals is accurate; however, special care is
> >> not taken to ensure that an orderly shutdown is possible.  At the very
> >> least, the HW and SW state will be out of sync for the peripherals that
> >> are shut down.
> > 
> > OK, I guess I'm confused now.  Why does partial PMIC shutdown even
> > exist then?  What is the point of leaving some rails alive if software
> > could stop running?  It seems like it would be better to just shut
> > everything down.
> > 
> > Said another way: can you describe what benefit you see for only
> > partially shutting down the PMIC at stage 2 compared to just fully
> > shutting it down at stage 2?
> 
> Stage 2 partial shutdown is present on PM8998 for legacy reasons.  It is
> being phased out on future PMICs.  My understanding is that it was
> originally intended to be a less aggressive mitigation option than a full
> shutdown and that it allows for more post-mitigation analysis (e.g.
> preserved RAM contents).
> 
> The set of peripherals which are disabled during stage 2 partial shutdown
> is not well defined which leads to the kind of uncertainty and ill-defined
> behavior being discussed in this thread.

Thanks for the information!

> >> Disabling stage 2 partial shutdown and then using software to
> >> perform a controlled shutdown at 125 C is probably the best option for you
> >> at this point.
> > 
> > This seems OK to me given that I don't understand the original purpose
> > of the partial PMIC shutdown.  Would you expect that all upstream PMIC
> > users would want stage 2 partial shutdown disabled, so we should just
> > do this for all users of the PMIC?
> 
> I'd think that we only want to override stage 2 partial shutdown if
> thermal nodes are defined which cause a graceful software controlled
> shutdown in place of the PMIC partial shutdown.  Therefore, management of
> the feature should probably be tied to a boolean DT property.

Sounds good, I'll send a patch to disable the partial shutdown through
a DT property soon.

