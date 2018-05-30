Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753790AbeE3S1c (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 14:27:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49074 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753526AbeE3S13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 14:27:29 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5AE106038E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH v2 1/6] soc: qcom: rpmpd: Add a powerdomain driver to
 model corners
To: Rajendra Nayak <rnayak@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180525100121.28214-1-rnayak@codeaurora.org>
 <20180525100121.28214-2-rnayak@codeaurora.org>
 <CAPDyKFoAJjZknWtbbQLn0Hnc3Du_1vnSUnqfwZLYK76j2rg52g@mail.gmail.com>
 <0e07d577-9728-e97a-2da0-dd7dd324f058@codeaurora.org>
From: David Collins <collinsd@codeaurora.org>
Message-ID: <7432f626-69cd-3535-04bc-de42e0285d41@codeaurora.org>
Date: Wed, 30 May 2018 11:27:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <0e07d577-9728-e97a-2da0-dd7dd324f058@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rajendra,

On 05/30/2018 03:14 AM, Rajendra Nayak wrote:
> On 05/30/2018 02:47 PM, Ulf Hansson wrote:
>> On 25 May 2018 at 12:01, Rajendra Nayak <rnayak@codeaurora.org> wrote:
...
>>> +               pm_genpd_init(&rpmpds[i]->pd, NULL, true);
>>
>> Question: Is there no hierarchical topology of the PM domains. No
>> genpd subdomains?
> 
> The hierarchy if any is all handled by the remote core (RPM in this case).
> For Linux its just a flat view.

There is one special case that we'll need to handle somehow.  The APPS
vlvl request for VDD_MX needs to be greater than or equal to the vlvl
request for VDD_CX.  Can you please add the necessary code to achieve
this?  RPMh hardware doesn't handle this hardware requirement due to
concerns about modem use case latency.

Please note that this is handled in a somewhat hacky manner [1] with the
downstream rpmh-regulator driver by specifying VDD_MX as the parent of
VDD_CX and VDD_MX_AO as the parent of VDD_CX_AO with a dropout voltage of
-1.  That way, enabling CX causes MX to be enabled and voltage level
requests are propagated from CX to MX (the -1 is ignored because it is
rounded up within the sparse vlvl numbering space).

Thanks,
David

[1]:
https://source.codeaurora.org/quic/la/kernel/msm-4.9/tree/arch/arm64/boot/dts/qcom/sdm845-regulator.dtsi?h=msm-4.9#n135

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
