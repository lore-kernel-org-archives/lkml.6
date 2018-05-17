Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752337AbeEQHvL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 03:51:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36092 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751680AbeEQHvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 03:51:07 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5481F60274
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilialin@codeaurora.org
From: <ilialin@codeaurora.org>
To: "'Viresh Kumar'" <viresh.kumar@linaro.org>,
        "'Amit Kucheria'" <amit.kucheria@linaro.org>
Cc: "'Michael Turquette'" <mturquette@baylibre.com>, <sboyd@kernel.org>,
        "'Rob Herring'" <robh@kernel.org>,
        "'Mark Rutland'" <mark.rutland@arm.com>, <nm@ti.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>,
        "'Andy Gross'" <andy.gross@linaro.org>,
        "'David Brown'" <david.brown@linaro.org>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Linux PM list'" <linux-pm@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-soc@vger.kernel.org>,
        "'lakml'" <linux-arm-kernel@lists.infradead.org>,
        "'Rajendra Nayak'" <rnayak@codeaurora.org>,
        <nicolas.dechesne@linaro.org>, <celster@codeaurora.org>,
        <tfinkel@codeaurora.org>
References: <1526375616-16904-1-git-send-email-ilialin@codeaurora.org> <1526375616-16904-13-git-send-email-ilialin@codeaurora.org> <CAHLCerOYq4q2GE+m3MQAbMfxM4azPr95XiLKVtoPVG1Kv2Db=A@mail.gmail.com> <20180516141132.aqjif7d5motmmnlo@vireshk-i7>
In-Reply-To: <20180516141132.aqjif7d5motmmnlo@vireshk-i7>
Subject: RE: [PATCH v7 12/14] cpufreq: Add Kryo CPU scaling driver
Date: Thu, 17 May 2018 10:50:34 +0300
Message-ID: <017601d3edb3$c0d96d40$428c47c0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGnp1nyG6UZbI+UZ9yYhcbjWitfQAKeDSLwAZ7sm4kCZbuURqRXAqOQ
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Sent: Wednesday, May 16, 2018 17:12
> To: Amit Kucheria <amit.kucheria@linaro.org>
> Cc: Ilia Lin <ilialin@codeaurora.org>; Michael Turquette
> <mturquette@baylibre.com>; sboyd@kernel.org; Rob Herring
> <robh@kernel.org>; Mark Rutland <mark.rutland@arm.com>; nm@ti.com;
> lgirdwood@gmail.com; broonie@kernel.org; Andy Gross
> <andy.gross@linaro.org>; David Brown <david.brown@linaro.org>;
> catalin.marinas@arm.com; will.deacon@arm.com; Rafael J. Wysocki
> <rjw@rjwysocki.net>; linux-clk@vger.kernel.org;
> devicetree@vger.kernel.org; LKML <linux-kernel@vger.kernel.org>; Linux
> PM list <linux-pm@vger.kernel.org>; linux-arm-msm@vger.kernel.org; linux-
> soc@vger.kernel.org; lakml <linux-arm-kernel@lists.infradead.org>;
> Rajendra Nayak <rnayak@codeaurora.org>; nicolas.dechesne@linaro.org;
> celster@codeaurora.org; tfinkel@codeaurora.org
> Subject: Re: [PATCH v7 12/14] cpufreq: Add Kryo CPU scaling driver
> 
> On 16-05-18, 16:12, Amit Kucheria wrote:
> > > +       ret = PTR_ERR_OR_ZERO(opp_temp =
> > > +
> dev_pm_opp_set_supported_hw(cpu_dev,&versions,1));
> > > +       if (0 > ret)
> >
> > Any particular reason to prefer this over (ret < 0) that is generally
> > used? I've seen it used to avoid the == vs. = typos, but not for other
> > comparisons.
> >
> > Suggest sticking to what is commonly used i.e. ret < 0.
> >
> > > +               goto free_opp;
> > > +
> > > +       cpu_dev = get_cpu_device(GOLD_LEAD);
> >
> > Error check cpu_dev here?
> >
> > > +       ret = PTR_ERR_OR_ZERO(opp_temp =
> > > +
> dev_pm_opp_set_supported_hw(cpu_dev,&versions,1));
> > > +       if (0 > ret)
> > > +               goto free_opp;
> 
> The goto here is wrong

If we are here, then the first dev_pm_opp_set_supported_hw() succeeded. And
should be deallocated before exit with error.

> 
> > > +
> > > +
> > > +       ret =
> PTR_ERR_OR_ZERO(platform_device_register_simple("cpufreq-dt",
> > > +                                                             -1,
> > > + NULL, 0));
> > > +
> > > +       if (0 == ret)
> > > +               return 0;
> > > +
> > > +free_opp:
> > > +       dev_pm_opp_put_supported_hw(opp_temp);
> >
> > This is not needed because dev_pm_opp_set_supported_hw will free
> > memory in case of failure. This call in only needed in case of a
> > successful get.
> 
> But this is still required for the case where platform device registration
fails.
> 
> --
> viresh
