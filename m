Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848F2C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2819920848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z7VGjyrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2819920848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeJZHSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 03:18:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36293 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbeJZHSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 03:18:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id l81-v6so4919636pfg.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 15:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mbkRG7p2a1z0nDSRCqrXc2LRk/X9PRQSMcHMCepo6/E=;
        b=Z7VGjyrh1Bm2xRDRSG+SFCczB3XAQISiy0tdWeU1DhIVoPxq0zsxlWX7r9OlB9++Z2
         eIM1xgFNTY866zOE72AxPQBYEYq06ihkZFk+JhAfd8JSBZuff65HCLEUhc0+JyLbwBvt
         fGdCoQ0XeS/ve8KLi6NjOA5usJTpLdugH3J50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mbkRG7p2a1z0nDSRCqrXc2LRk/X9PRQSMcHMCepo6/E=;
        b=T43fwo8CsWskoUG+fcDmCP4rG+E84jkK+Oc0RVmJA2/yz894yA1GEXihmRxWrtyQbd
         K3WEQeF+0AVyi+tLuC1lykLcDZrq0meQESqA2VLX9uST9AwXH9VvAtoVk3Ym/7/5vgsG
         m7vnWOc06uu2NzRaApsPGssr9n44KK55rop3V1ANyRpsFEdZuWTJdXtI6ccV7zMK8RRh
         c7qh8Ni6dOLghZPODtRbEk75aLskj4mCLG715byuH4E4RAoawUGtCrchF1+4Knpv5ecv
         Bdbd1+PDuGaCq1vgGOVqoxkK5pxvX21DaUxGEX7U61jq79g+vNfRdLSs2uHKd15JTTS7
         5/gA==
X-Gm-Message-State: AGRZ1gJFX0G77G459T6alZJnEUQqy1CpOOlRwaJdDapB/OhvJqcs1O2U
        r/19EsmP7JjPvGFp5lYGgeyOpQ==
X-Google-Smtp-Source: AJdET5cFdM4uT3ev8VimQoqwk7YWihKZ2+bLSyIDAJsuZbcz5dQrqGEVDE12/v4PEEbx7YducrAKoA==
X-Received: by 2002:a63:e40e:: with SMTP id a14-v6mr1013005pgi.28.1540507420488;
        Thu, 25 Oct 2018 15:43:40 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id q127-v6sm31607053pgq.19.2018.10.25.15.43.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 15:43:39 -0700 (PDT)
Date:   Thu, 25 Oct 2018 15:43:39 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Taniya Das <tdas@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>, evgreen@google.com
Subject: Re: [PATCH 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ
 Firmware bindings
Message-ID: <20181025224339.GB22824@google.com>
References: <1539257761-23023-1-git-send-email-tdas@codeaurora.org>
 <1539257761-23023-2-git-send-email-tdas@codeaurora.org>
 <CAP245DV4yK2u2tS_Jjgb1PBx+qkXPXBOs3w4THNDaBEw7WGDLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP245DV4yK2u2tS_Jjgb1PBx+qkXPXBOs3w4THNDaBEw7WGDLg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 23, 2018 at 05:23:34PM +0530, Amit Kucheria wrote:
> Hi Taniya,
> 
> Both the patches are missing v9 in their subject line - this threw off
> patchwork when trying to download the patches.
> 
> On Thu, Oct 11, 2018 at 5:06 PM Taniya Das <tdas@codeaurora.org> wrote:
> >
> > Add QCOM cpufreq firmware device bindings for Qualcomm Technology Inc's
> > SoCs. This is required for managing the cpu frequency transitions which are
> > controlled by the hardware engine.
> 
> I tested these patches on the sdm845-mtp against 4.19 and found that
> the frequency gets stuck at the highest opp (the boost frequency)
> after running a couple of 'yes > /dev/null &' instances. Have you
> tested these against a mainline kernel?
> 
> See cpufreq statistics below:
> 
> linaro-test [rc=0]# cat policy?/scaling_cur_freq
> 300000
> 2803200
> 
> linaro-test [rc=0]# cat policy?/stats/time_in_state
> 300000 100840
> 403200 388
> 480000 71
> 576000 54
> 652800 22
> 748800 11
> 825600 5
> 902400 5
> 979200 9
> 1056000 3
> 1132800 2
> 1228800 5
> 1324800 8
> 1420800 2
> 1516800 1
> 1612800 0
> 1689600 0
> 1766400 392
> 825600 22048
> 902400 21
> 979200 4
> 1056000 15
> 1209600 6
> 1286400 0
> 1363200 1
> 1459200 0
> 1536000 0
> 1612800 1
> 1689600 0
> 1766400 0
> 1843200 2
> 1920000 2
> 1996800 0
> 2092800 0
> 2169600 0
> 2246400 0
> 2323200 0
> 2400000 0
> 2476800 0
> 2553600 0
> 2649600 0
> 2707200 0
> 2764800 0
> 2784000 0
> 2803200 79718

I can repro this on SDM845 with a v4.19 kernel.

Since the little cores don't have a boost frequency I think maxing out
can be expected with a high workload and no thermal throttling.
However the big cores have a boost frequency (2.803 MHz), so the
driver shouldn't be stuck at it. Though in practice I also wonder if
the ~1% 'boost' makes a big difference in terms of performance or CPU
overload ...

Cheers

Matthias
