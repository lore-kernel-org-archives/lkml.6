Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752626AbeEPONv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 10:13:51 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42126 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752510AbeEPONq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 10:13:46 -0400
X-Google-Smtp-Source: AB8JxZrdhfhwievo54ledtYgr/tNx0eGS+MfzmWxcBydM3o4p4urkVP3+LyK2+96lchhOcKEMOL+O4qT/qZmlNGCoT4=
MIME-Version: 1.0
In-Reply-To: <20180516141132.aqjif7d5motmmnlo@vireshk-i7>
References: <1526375616-16904-1-git-send-email-ilialin@codeaurora.org>
 <1526375616-16904-13-git-send-email-ilialin@codeaurora.org>
 <CAHLCerOYq4q2GE+m3MQAbMfxM4azPr95XiLKVtoPVG1Kv2Db=A@mail.gmail.com> <20180516141132.aqjif7d5motmmnlo@vireshk-i7>
From: Amit Kucheria <amit.kucheria@linaro.org>
Date: Wed, 16 May 2018 17:13:44 +0300
Message-ID: <CAP245DVO8mG--ZvUitLkEwvUP_YkQe0cz2qmpXg+uyZD_cT9+g@mail.gmail.com>
Subject: Re: [PATCH v7 12/14] cpufreq: Add Kryo CPU scaling driver
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ilia Lin <ilialin@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "Menon, Nishanth" <nm@ti.com>, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-clk@vger.kernel.org,
        DTML <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>, celster@codeaurora.org,
        tfinkel@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 5:11 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 16-05-18, 16:12, Amit Kucheria wrote:
>> > +       ret = PTR_ERR_OR_ZERO(opp_temp =
>> > +                             dev_pm_opp_set_supported_hw(cpu_dev,&versions,1));
>> > +       if (0 > ret)
>>
>> Any particular reason to prefer this over (ret < 0) that is generally
>> used? I've seen it used to avoid the == vs. = typos, but not for other
>> comparisons.
>>
>> Suggest sticking to what is commonly used i.e. ret < 0.
>>
>> > +               goto free_opp;
>> > +
>> > +       cpu_dev = get_cpu_device(GOLD_LEAD);
>>
>> Error check cpu_dev here?
>>
>> > +       ret = PTR_ERR_OR_ZERO(opp_temp =
>> > +                             dev_pm_opp_set_supported_hw(cpu_dev,&versions,1));
>> > +       if (0 > ret)
>> > +               goto free_opp;
>
> The goto here is wrong
>
>> > +
>> > +
>> > +       ret = PTR_ERR_OR_ZERO(platform_device_register_simple("cpufreq-dt",
>> > +                                                             -1, NULL, 0));
>> > +
>> > +       if (0 == ret)
>> > +               return 0;
>> > +
>> > +free_opp:
>> > +       dev_pm_opp_put_supported_hw(opp_temp);
>>
>> This is not needed because dev_pm_opp_set_supported_hw will free
>> memory in case of failure. This call in only needed in case of a
>> successful get.
>
> But this is still required for the case where platform device
> registration fails.

Agreed. The overall error path needs to be re-written with proper
check of return values.
