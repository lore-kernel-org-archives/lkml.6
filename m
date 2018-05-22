Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751272AbeEVJiK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 05:38:10 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33527 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751107AbeEVJiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 05:38:07 -0400
X-Google-Smtp-Source: AB8JxZoUbFae8oiwNn8QCm00t502Z1MUMIbQEeWG4R37EzBioavLsKiXmTU8nxqnWoPIGRt/KpB4BA==
Date: Tue, 22 May 2018 15:08:03 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: ilialin@codeaurora.org
Cc: "'Sudeep Holla'" <sudeep.holla@arm.com>, mturquette@baylibre.com,
        sboyd@kernel.org, robh@kernel.org, mark.rutland@arm.com, nm@ti.com,
        lgirdwood@gmail.com, broonie@kernel.org, andy.gross@linaro.org,
        david.brown@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com,
        rjw@rjwysocki.net, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rnayak@codeaurora.org, amit.kucheria@linaro.org,
        nicolas.dechesne@linaro.org, celster@codeaurora.org,
        tfinkel@codeaurora.org
Subject: Re: [PATCH] cpufreq: Add Kryo CPU scaling driver
Message-ID: <20180522093803.kfmfktdskumxyqbx@vireshk-i7>
References: <1526555955-29960-11-git-send-email-ilialin@codeaurora.org>
 <1526729701-8589-1-git-send-email-ilialin@codeaurora.org>
 <153cc316-dcb5-972f-5a2f-c91fe0f6348b@arm.com>
 <000f01d3f103$3ff78ba0$bfe6a2e0$@codeaurora.org>
 <2ace10bc-e1c4-2060-94d3-eb71e966ffbe@arm.com>
 <001401d3f1a2$c7328850$559798f0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001401d3f1a2$c7328850$559798f0$@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-05-18, 10:59, ilialin@codeaurora.org wrote:
> OK, I think I found out the way. Would this be correct?
> -----------------------------------------------------------------------------------------------
> extern struct cpu_topology cpu_topology[NR_CPUS];
> 
> static struct device *qcom_cpufreq_kryo_get_cluster_lead(int cluster)
> {
> 	unsigned cpu;
> 
> 	for_each_possible_cpu(cpu) {
> 		if ((cluster == cpu_topology[cpu].cluster_id) &&
> 			(0 == cpu_topology[cpu].core_id))
> 			return get_cpu_device(cpu);
> 	}
> 
> 	return NULL;
> }

Okay, this is what you should do IMHO.

for_each_possible_cpu(cpu) {
        cpu_dev = xxx..
        ret = dev_pm_opp_set_supported_hw(cpu_dev, xxx, xxx);
        if (ret && ret != -EBUSY)
                error-out.
}

This would require a trivial patch for the OPP core to not throw an
error message with -EBUSY. I can do that separately.

-- 
viresh
