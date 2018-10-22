Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B324FC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 11:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F9A2064E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 11:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CXidYPeS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F9A2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbeJVTuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 15:50:40 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43066 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbeJVTuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 15:50:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id q1-v6so2447361pfh.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 04:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pmSrV/enPkfssMWClfaJg8M8jPW63Ek/iZEk5rNKztU=;
        b=CXidYPeSeTDqx3Si8EdhoFN33+GbRTn04lExmIAzmRIwtS49iA9fpgX+prQPXGR9TD
         IS1Ws1kgNUtyQMMMOo+x/U3u1zBt3mKrozpYeLvjTyy7+1uYVBy9GMNPrYX/ZKkQME5J
         AzwwKh17/MS2RHDbE7kLV/Ks0Vci7pjKDpaQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pmSrV/enPkfssMWClfaJg8M8jPW63Ek/iZEk5rNKztU=;
        b=gFaVYXk7bCPvHmDEjUGsV6hh1+L1NsnjzUzLwn9ho8dJn9XKsARrsLP/eogcNcuyE3
         mcO/GiLl3mCn3C+mRn4jo31YbBw7KBo/uTSZ5JZq/J2Lzg1p4uporfpDFA7Risbmsb9K
         a/bGYhY/Op5fKvX1bBdo87TIlYHOD2MHt94TfyUmH7z2Q7nc45RHoNYXQ31jYMTLmYXO
         5t9BHGxCwytJKF/+lY+uz9SuAgtvufqGpVcKCZ7xn4a6ZV3pf79yZOD2gdIB3FCe+eIT
         48dTRkDQaDiVk2tYMqTC+eczeihfiOzD2hcLEXWd/tnPBPqeyyIvYbkMEx8hSPepxFN8
         Q+Dg==
X-Gm-Message-State: ABuFfoh1TENZ8sMXgNTOjxD7JO1rmj9YGtGyKgT6ZnqVSLgDKINRFVHL
        RVs4wxR2N56C34Jox1/w01PXlQ==
X-Google-Smtp-Source: ACcGV63aFj98ux6kS+XNZfGA5/qw7remWO99UgO8H34/RNeAK2dkT5fSBuv4NtWPyHAFMkI/25c8Pw==
X-Received: by 2002:a63:2584:: with SMTP id l126-v6mr15695359pgl.382.1540207948025;
        Mon, 22 Oct 2018 04:32:28 -0700 (PDT)
Received: from localhost ([122.172.217.9])
        by smtp.gmail.com with ESMTPSA id h8-v6sm43973743pgg.23.2018.10.22.04.32.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 04:32:27 -0700 (PDT)
Date:   Mon, 22 Oct 2018 17:02:24 +0530
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
Message-ID: <20181022113224.b5fiebgy2aap66nd@vireshk-i7>
References: <20181021205501.23943-1-digetx@gmail.com>
 <20181021205501.23943-2-digetx@gmail.com>
 <20181022053636.ag62j3rj3vovbz53@vireshk-i7>
 <e4027793-9436-413d-2a7b-34cf519218c3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4027793-9436-413d-2a7b-34cf519218c3@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-10-18, 14:29, Dmitry Osipenko wrote:
> On 10/22/18 8:36 AM, Viresh Kumar wrote:
> > On 21-10-18, 23:54, Dmitry Osipenko wrote:
> >> Voltage regulators may be not available on some variations of HW, allow to
> >> request stub voltage regulators by OPP core in a such case to reduce code
> >> churning within drivers.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  drivers/cpufreq/cpufreq-dt.c | 2 +-
> >>  drivers/cpufreq/ti-cpufreq.c | 3 ++-
> >>  drivers/opp/core.c           | 9 +++++++--
> >>  include/linux/pm_opp.h       | 4 ++--
> >>  4 files changed, 12 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> >> index e58bfcb1169e..6ebca472ec76 100644
> >> --- a/drivers/cpufreq/cpufreq-dt.c
> >> +++ b/drivers/cpufreq/cpufreq-dt.c
> >> @@ -196,7 +196,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
> >>  	 */
> >>  	name = find_supply_name(cpu_dev);
> >>  	if (name) {
> >> -		opp_table = dev_pm_opp_set_regulators(cpu_dev, &name, 1);
> >> +		opp_table = dev_pm_opp_set_regulators(cpu_dev, &name, 1, false);
> >>  		if (IS_ERR(opp_table)) {
> >>  			ret = PTR_ERR(opp_table);
> >>  			dev_err(cpu_dev, "Failed to set regulator for cpu%d: %d\n",
> > 
> > Have you actually tested this stuff ? The cpufreq-dt driver will
> > probably fail to probe if the CPU node has a "-supply" property, but
> > no regulator matching that.
> > 
> 
> Please notice that this patch doesn't change the original behaviour
> and I suppose that failing in a case of missing regulator is the
> expected behaviour for cpufreq-dt. Hence can't see any problem here.

So why have this patch then ?

-- 
viresh
