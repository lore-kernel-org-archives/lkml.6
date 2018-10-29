Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D54C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 06:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739B22054F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 06:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jsHcmiq1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739B22054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbeJ2Pkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 11:40:51 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38472 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729323AbeJ2Pkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 11:40:51 -0400
Received: by mail-pl1-f193.google.com with SMTP id p7-v6so3332544plk.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 23:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B/ZylJSVuUpgOcweumoLkbeQjDOc4GfwGjte7r8U6EM=;
        b=jsHcmiq1aYWIXnwApUxQO3QDSYc/7ol2ufmxfGxOMf4gxSeQCzTEH8rqBKfvRcb2mY
         T5f7DoYIwfWLWvNyT/rAuxkw1DHzhiTN7xa7EwEOhwe49ZNRAzScMnni/2ElA6wBRU/k
         /YvR/IWvldLkrQu+lQc9SJ6XtchD8Nkr3IV7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B/ZylJSVuUpgOcweumoLkbeQjDOc4GfwGjte7r8U6EM=;
        b=CWA+e0gRtX3oHZleR2mPbZUiO2PuIT3Ky61c1mQPWTmfOk5Qa9gyKBzY6ZRd/dp9aP
         eid7KmXol4uoZLOZkkEWM4dfLXH7Ze+adAf6Lxq9DeuQ/DHUnPwVPMQGig4dVRobLD7T
         6kpgyohoVSavTbEtdwDS/Z8O8qUGJbvFilAh48z8a2oJkDlZ+pu2S3E7yPJv4H8ajJ3L
         6i11Yriz1GPPT2Pvh47qJbn1gwixc0zskrO1rstLcwQVyru+s/uudLkg27oFaymcy4Uj
         V6McQ+fdo4iuiufxIumCCr1k6gtrMxzBVHhMFCRYPcFK40koHyCg4YkYNd2co7Xuyzlk
         ytdA==
X-Gm-Message-State: AGRZ1gIra/IsrBvKtREQgYDSKw7q/7BhrMAJ+maiGEN0GnJE5LaVFAgB
        CzteFTAAkCn7tyWpHXCj2hI2Sw==
X-Google-Smtp-Source: AJdET5fHKRQKd94lUA+f7rTYx8CNFXe4fn7Y89+CB2BijR6ubmNy8X4UkLG2StotVLExFWnHmitxaQ==
X-Received: by 2002:a17:902:b692:: with SMTP id c18-v6mr13135737pls.191.1540796011019;
        Sun, 28 Oct 2018 23:53:31 -0700 (PDT)
Received: from localhost ([122.172.56.94])
        by smtp.gmail.com with ESMTPSA id u2-v6sm3625534pfn.50.2018.10.28.23.53.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 23:53:30 -0700 (PDT)
Date:   Mon, 29 Oct 2018 12:23:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 01/17] OPP: Allow to request stub voltage
 regulators
Message-ID: <20181029065328.6vkbwjnq2zzwxric@vireshk-i7>
References: <20181021205501.23943-1-digetx@gmail.com>
 <20181021205501.23943-2-digetx@gmail.com>
 <20181022053636.ag62j3rj3vovbz53@vireshk-i7>
 <e4027793-9436-413d-2a7b-34cf519218c3@gmail.com>
 <20181022113224.b5fiebgy2aap66nd@vireshk-i7>
 <29f893be-feed-c4c5-8468-51f7228dd468@gmail.com>
 <20181024064123.lbpbeervghp35fe7@vireshk-i7>
 <ba782346-6ac0-7bf3-e187-00d2634b145b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba782346-6ac0-7bf3-e187-00d2634b145b@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-10-18, 15:03, Dmitry Osipenko wrote:
> On 10/24/18 9:41 AM, Viresh Kumar wrote:
> > On 22-10-18, 15:12, Dmitry Osipenko wrote:
> >> Because there is one Tegra20 board (tegra20-trimslice) that doesn't declare
> >> necessary regulators, but we want to have CPU frequency scaling. I couldn't
> >> find board schematics and so don't know if CPU / CORE voltages are fixed on
> >> Trim-Slice or it is just preferable not to have DVFS for that board, it is an
> >> outlet-powered device [0]. Hence tegra20-cpufreq driver will request a dummy
> >> regulators when appropriate. 
> > 
> > We have been using the regulator_get_optional() variant until now in the OPP
> > core to make sure that we don't do DVFS for the CPU without the mandatory
> > regulators being present, as that may make things unstable and cause harm to the
> > SoC if we try to take CPU to frequency range over the currently programmed
> > regulator can support.
> > 
> > Now coming back to tegra-20 SoC, which actually requires a regulator normally by
> > design. On one of the boards (which is outlet powered), you aren't sure if there
> > is a programmable regulator or not, or if DVFS should really be done or not.
> > Isn't it worth checking the same from Tegra maintainers, or whomsoever has
> > information on that board ?
> 
> I'll try to find out more detailed information for the next revision of the patchset.

Thanks Dmitry.

>  What would happen if there actually was a regulator

Please preserve the '>' from previous replies at the beginning of the
lines. Otherwise it looks as if you have written the above line. :)

> > and its default settings aren't good enough for high end frequencies ?
> 
> Usually this causes kernel/applications crashes and/or machine hang.

Sure. I also do remember from some guys (maybe TI), where they
mentioned that such scenarios can harm the hardware as well sometimes.
Don't remember the details though.

>  And because you are moving to regulator_get() API for
> > the entire SoC (i.e. its cpufreq driver), people will never find the missing
> > regulator.
> 
> Regulators core prints info message when dummy regulator is being used.

Sure, but they are easy to miss and they are only seen by developers
not regular users of a machine.

> > If we can do it safely for all tegra20 boards, why not migrate to using
> > regulator_get() instead of regulator_get_optional() in the OPP core API itself
> > for everyone ?
> > 
> 
> This should be a platform-specific decision. For Tegra we know that regulators should be in a good state at kernel boot time, I don't think that this applies to other platforms.

Based on the other discussion with Lucas on this thread, I don't think
this is correct any more ?

Don't get me wrong, I am all good for changes and another API change
doesn't matter much to me. I am just wondering if it would be the
right approach to fix the issue. Why not rather call
dev_pm_opp_set_regulators() conditionally and avoid calling it for the
specific tegra20 board.

-- 
viresh
