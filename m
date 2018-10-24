Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416FFC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 06:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0728E2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 06:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lv8o6rXq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0728E2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbeJXPIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 11:08:10 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39503 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbeJXPIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 11:08:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id c25-v6so1942551pfe.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 23:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bYjblIwUWV3TvDA1gjPimUFpNpks8E4/u1/Kq3quwZc=;
        b=Lv8o6rXqSNonbLqWjruCzz+TvlRgLyrFL4Pu8ej6N927XdVXpz1uyoVlBcPfB/MpW1
         HXXl01AoEmqifSrZ7cTkUkiJSk0tWcHxtvsffgIeEVqwkDD3vaqrUc8iF5Ya9bnZSlIl
         rjh9NEObSWqo9uY7+DttnZptTGChVoVzUmhBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bYjblIwUWV3TvDA1gjPimUFpNpks8E4/u1/Kq3quwZc=;
        b=NWAyBsDVsFi92BoFtcz7S+IS7pqAclgd6LIUxRanAiCjFRs6X8x4lYu3TOkawkLsls
         UvltJDNaPDLcPXumHxYjROxG5asHtFsNZqtoan99ZjgAHVgte4WPrXQ8YjwhJ+SnxB3f
         XfdFtey0z9MedyI8lRAST4TLa+Wdqz1wB7Fgkn4UWChHKppmg0T8djdVWQC/smWggeak
         XYU4FzxKsjeKQNLhXnxHHDcL9VRlcE/nBkKsXABPMByRnr124MxG9CKxJVUY8gWR52ZZ
         vCC+NOlLLDZ0+48H3dfT4W+fXKwtwKlSZYTKB+c0MQ7yII6E8QoY2J0UUl9fYbucD5V3
         5YOA==
X-Gm-Message-State: AGRZ1gJyOEDO+4qg8R0+b5x7Jrhxh+rq/0hQWVQ+NXKfUXlFiJHFeXaV
        QRwbyz4yPGoJLsycJeUAIAstYfQtPkw=
X-Google-Smtp-Source: AJdET5f1AgmZDqSftT+i+YAGDNNpZQA/9WkZxXFXPhDhkQebYgMaFyKVvZ3B7LG4WBJxHTk34/+hCg==
X-Received: by 2002:a63:3e05:: with SMTP id l5mr1318777pga.96.1540363286463;
        Tue, 23 Oct 2018 23:41:26 -0700 (PDT)
Received: from localhost ([122.172.217.9])
        by smtp.gmail.com with ESMTPSA id n64-v6sm5147722pfi.185.2018.10.23.23.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 23:41:25 -0700 (PDT)
Date:   Wed, 24 Oct 2018 12:11:23 +0530
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
Message-ID: <20181024064123.lbpbeervghp35fe7@vireshk-i7>
References: <20181021205501.23943-1-digetx@gmail.com>
 <20181021205501.23943-2-digetx@gmail.com>
 <20181022053636.ag62j3rj3vovbz53@vireshk-i7>
 <e4027793-9436-413d-2a7b-34cf519218c3@gmail.com>
 <20181022113224.b5fiebgy2aap66nd@vireshk-i7>
 <29f893be-feed-c4c5-8468-51f7228dd468@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29f893be-feed-c4c5-8468-51f7228dd468@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-10-18, 15:12, Dmitry Osipenko wrote:
> Because there is one Tegra20 board (tegra20-trimslice) that doesn't declare
> necessary regulators, but we want to have CPU frequency scaling. I couldn't
> find board schematics and so don't know if CPU / CORE voltages are fixed on
> Trim-Slice or it is just preferable not to have DVFS for that board, it is an
> outlet-powered device [0]. Hence tegra20-cpufreq driver will request a dummy
> regulators when appropriate. 

We have been using the regulator_get_optional() variant until now in the OPP
core to make sure that we don't do DVFS for the CPU without the mandatory
regulators being present, as that may make things unstable and cause harm to the
SoC if we try to take CPU to frequency range over the currently programmed
regulator can support.

Now coming back to tegra-20 SoC, which actually requires a regulator normally by
design. On one of the boards (which is outlet powered), you aren't sure if there
is a programmable regulator or not, or if DVFS should really be done or not.
Isn't it worth checking the same from Tegra maintainers, or whomsoever has
information on that board ? What would happen if there actually was a regulator
and its default settings aren't good enough for high end frequencies ?

On the other hand, the tegra20 cpufreq driver is common across a lot of boards.
What will happen if the DT for some of the boards isn't correct and missed the
necessary regulator node ? And because you are moving to regulator_get() API for
the entire SoC (i.e. its cpufreq driver), people will never find the missing
regulator.

If we can do it safely for all tegra20 boards, why not migrate to using
regulator_get() instead of regulator_get_optional() in the OPP core API itself
for everyone ?

-- 
viresh
