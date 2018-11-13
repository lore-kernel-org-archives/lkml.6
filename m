Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85C5C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B3A22419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YbVXhM8/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7B3A22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbeKMKYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 05:24:31 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33630 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730387AbeKMKYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 05:24:31 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so2175762pgu.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 16:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xeOMmT1evZEpl0IdVTzJZveGTFhfPUqinZDcLFXZX/g=;
        b=YbVXhM8/jJ0EbXrRRfhmi8GRRxThCiVt4GkovYykZxBi2z7CAFSkQoZL249bJjeV8v
         DoPMRC2kJ339Rrle9K28leIP3j5MpTCDUfYfVNmQDa8SwSaczuJEosTSsq/2bxlFAi5t
         TKRcPiEDX2HZ3Sfhq1WZEQZoS+QFKyNEriSQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xeOMmT1evZEpl0IdVTzJZveGTFhfPUqinZDcLFXZX/g=;
        b=jEhPDSKd8BeX/lEmhtYPXeB16bOO0tjsMeH6es28dTH9u83OX2jNuwXu75Kb/gcwsL
         +znrYWHaKcO9m4c7amWwLRRJIbo7LW5E3p4q/6Dg/9fm8r+kX6jJ7Oisz3eL9+vA5vah
         4duktU+suT4H0DnHfEFNsJDyNahc/gwFOYRnkDh5IiBkIj1y8709djbLd0xLoMbRAGsE
         xho1dt+F/iyIdPvKphyX9oKpDjM/GN9i9XmmUTTxmiDz1RhCpFKJ7FsYQ+J1x1pbBksF
         VcijzY38LNVEL6TuhnyDUuWtNPuZLXGsZfO+TuIIKF3FXNlAUakJzkI/36b9pJSO4oqj
         ig8Q==
X-Gm-Message-State: AGRZ1gL3hdKRib8PHOuQzcx61eGhkYCGevGYpqSvRNCy21K3QBP21BQC
        hNqAi3kxcBhgas4fprQ88h5YvA==
X-Google-Smtp-Source: AJdET5dR2V2DgCB4BE7ekFBYuvIUz1Gy20mhUrmq7AmF+B852T5ZPW4/XBsfQZcs7mksnbtjqEjK0A==
X-Received: by 2002:a63:5ec6:: with SMTP id s189mr2638723pgb.357.1542068938184;
        Mon, 12 Nov 2018 16:28:58 -0800 (PST)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id g7-v6sm19005797pfo.139.2018.11.12.16.28.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 16:28:57 -0800 (PST)
Date:   Mon, 12 Nov 2018 16:28:56 -0800
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
Message-ID: <20181113002856.GF22824@google.com>
References: <1539257761-23023-1-git-send-email-tdas@codeaurora.org>
 <1539257761-23023-2-git-send-email-tdas@codeaurora.org>
 <CAP245DV4yK2u2tS_Jjgb1PBx+qkXPXBOs3w4THNDaBEw7WGDLg@mail.gmail.com>
 <20181025224339.GB22824@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181025224339.GB22824@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 03:43:39PM -0700, Matthias Kaehlcke wrote:
> Hi,
> 
> On Tue, Oct 23, 2018 at 05:23:34PM +0530, Amit Kucheria wrote:
> > Hi Taniya,
> > 
> > Both the patches are missing v9 in their subject line - this threw off
> > patchwork when trying to download the patches.
> > 
> > On Thu, Oct 11, 2018 at 5:06 PM Taniya Das <tdas@codeaurora.org> wrote:
> > >
> > > Add QCOM cpufreq firmware device bindings for Qualcomm Technology Inc's
> > > SoCs. This is required for managing the cpu frequency transitions which are
> > > controlled by the hardware engine.
> > 
> > I tested these patches on the sdm845-mtp against 4.19 and found that
> > the frequency gets stuck at the highest opp (the boost frequency)
> > after running a couple of 'yes > /dev/null &' instances. Have you
> > tested these against a mainline kernel?
> > 
> > See cpufreq statistics below:
> > 
> > linaro-test [rc=0]# cat policy?/scaling_cur_freq
> > 300000
> > 2803200
> > 
> > linaro-test [rc=0]# cat policy?/stats/time_in_state
> > 300000 100840
> > 403200 388
> > 480000 71
> > 576000 54
> > 652800 22
> > 748800 11
> > 825600 5
> > 902400 5
> > 979200 9
> > 1056000 3
> > 1132800 2
> > 1228800 5
> > 1324800 8
> > 1420800 2
> > 1516800 1
> > 1612800 0
> > 1689600 0
> > 1766400 392
> > 825600 22048
> > 902400 21
> > 979200 4
> > 1056000 15
> > 1209600 6
> > 1286400 0
> > 1363200 1
> > 1459200 0
> > 1536000 0
> > 1612800 1
> > 1689600 0
> > 1766400 0
> > 1843200 2
> > 1920000 2
> > 1996800 0
> > 2092800 0
> > 2169600 0
> > 2246400 0
> > 2323200 0
> > 2400000 0
> > 2476800 0
> > 2553600 0
> > 2649600 0
> > 2707200 0
> > 2764800 0
> > 2784000 0
> > 2803200 79718
> 
> I can repro this on SDM845 with a v4.19 kernel.
> 
> Since the little cores don't have a boost frequency I think maxing out
> can be expected with a high workload and no thermal throttling.
> However the big cores have a boost frequency (2.803 MHz), so the
> driver shouldn't be stuck at it. Though in practice I also wonder if
> the ~1% 'boost' makes a big difference in terms of performance or CPU
> overload ...

From Documentation/cpu-freq/boost.txt:

"Some CPUs support a functionality to raise the operating frequency of
some cores in a multi-core package if certain conditions apply, mostly
if the whole chip is not fully utilized and below it's intended thermal
budget."

According to this it is not per se an issue that the cores are
operating at the boost frequency for a prolonged time. The use of the
highest frequency can be expected with a certain system load and
the/a boost frequency may be used unless a thermal or other conditions
prevents it.

I think the real question is: why is the last frequency automatically
considered a boost frequency? On (my) SDM845 it is only about 1%
higher than the previous one (2.803 GHz vs 2.784 GHz), that hardly
seems like a 'boost'.

Thanks

Matthias
