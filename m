Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753612AbeDSWKs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 18:10:48 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46031 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753560AbeDSWKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 18:10:47 -0400
X-Google-Smtp-Source: AIpwx4+9GZrWDfH/A8+6d8/0MiLAoeBAZ1gtnWYJ4Ll1Xmp4DhnN3Zlr/2Cq7U+fQR7WXkO/TMR33KyAExSgAnRYeS0=
MIME-Version: 1.0
In-Reply-To: <c20dc303-8753-5684-1fff-62f363a37a4c@gmail.com>
References: <20180418155643.36464-1-code@mmayer.net> <20180418155643.36464-3-code@mmayer.net>
 <c20dc303-8753-5684-1fff-62f363a37a4c@gmail.com>
From: Markus Mayer <mmayer@broadcom.com>
Date: Thu, 19 Apr 2018 15:10:45 -0700
Message-ID: <CAGt4E5voQJO6RaO64Z90EL5CzRF-AWtswzDQgYuOZTmpapzG-g@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpufreq: brcmstb-avs-cpufreq: prefer SCMI cpufreq if supported
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Power Management List <linux-pm@vger.kernel.org>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 April 2018 at 09:37, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 04/18/2018 08:56 AM, Markus Mayer wrote:
>> From: Jim Quinlan <jim2101024@gmail.com>
>>
>> If the SCMI cpufreq driver is supported, we bail, so that the new
>> approach can be used.
>>
>> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
>> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
>> ---
>>  drivers/cpufreq/brcmstb-avs-cpufreq.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
>> index b07559b9ed99..b4861a730162 100644
>> --- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
>> +++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
>> @@ -164,6 +164,8 @@
>>  #define BRCM_AVS_CPU_INTR    "brcm,avs-cpu-l2-intr"
>>  #define BRCM_AVS_HOST_INTR   "sw_intr"
>>
>> +#define ARM_SCMI_COMPAT              "arm,scmi"
>> +
>>  struct pmap {
>>       unsigned int mode;
>>       unsigned int p1;
>> @@ -511,6 +513,20 @@ static int brcm_avs_prepare_init(struct platform_device *pdev)
>>       struct device *dev;
>>       int host_irq, ret;
>>
>> +     /*
>> +      * If the SCMI cpufreq driver is supported, we bail, so that the more
>> +      * modern approach can be used.
>> +      */
>> +     if (IS_ENABLED(CONFIG_ARM_SCMI_PROTOCOL)) {
>> +             struct device_node *np;
>> +
>> +             np = of_find_compatible_node(NULL, NULL, ARM_SCMI_COMPAT);
>> +             if (np) {
>> +                     of_node_put(np);
>> +                     return -ENXIO;
>> +             }
>
> We would probably want to make sure that the node is also enabled (that
> is, does not have a status = "disabled" property) otherwise the check
> can be defeated. Something like:
>
>                 if (np && of_device_is_available(np))

Would we want something like this instead?

                 if (np) {
                                  bool bail_early =
(of_device_is_available(np) > 0);

                                  of_node_put(np);
                                  if (bail_early)
                                          return -ENXIO;
                 }

To ensure of_node_put() is called?

> should be good for that.
>
> Thanks!
> --
> Florian
