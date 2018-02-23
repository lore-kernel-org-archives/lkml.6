Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751497AbeBWKhF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 05:37:05 -0500
Received: from regular1.263xmail.com ([211.150.99.137]:48419 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbeBWKhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 05:37:03 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: randy.li@rock-chips.com
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <c99ba9f67d1f7cbad58f2cbf53d10855>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Message-ID: <5A8FEEC1.5040303@rock-chips.com>
Date: Fri, 23 Feb 2018 18:36:49 +0800
From: JeffyChen <jeffy.chen@rock-chips.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:19.0) Gecko/20130126 Thunderbird/19.0
MIME-Version: 1.0
To: Randy Li <randy.li@rock-chips.com>, tfiga@chromium.org
CC: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        xxm@rock-chips.com, Joerg Roedel <joro@8bytes.org>,
        jcliang@chromium.org, linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v4 08/13] iommu/rockchip: Control clocks needed to access
 the IOMMU
References: <20180118115251.5542-1-jeffy.chen@rock-chips.com> <20180118115251.5542-9-jeffy.chen@rock-chips.com> <c188e6a9-744c-d984-545c-408607f35cc9@arm.com> <5A60AE41.2050101@rock-chips.com> <1f4b3c0d-1414-0012-a072-f4a11f432c21@rock-chips.com> <5A654925.9020203@rock-chips.com> <5A6563FA.8080602@rock-chips.com> <c05d4794-b76d-cfaa-d7ed-c44108117ee2@rock-chips.com> <5A69B065.30501@rock-chips.com>
In-Reply-To: <5A69B065.30501@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

On 01/25/2018 06:24 PM, JeffyChen wrote:
> On 01/25/2018 05:42 PM, Randy Li wrote:
>>>>
>>>
>>> confirmed with Simon, there might be some iommus don't have a pd, and
>> We use the pd to control the NIU node(not on upstream), without a pd or
>> fake pd, none of the platform would work.
> after talked offline, it's possible to have iommu without pd in upstream
> kernel(and chromeos kernel), but on our internal kernel, the drivers
> would require pd(or fake pd) to reset modules when error happens.
>
> anyway, i think that means we do need clock control here.

found another reason to not depend on pd to control clocks.

currently we are using pd's pm_clk to keep clocks enabled during power 
on. but in our pd binding doc, that is not needed:
- clocks (optional): phandles to clocks which need to be enabled while 
power domain
         switches state.

confirmed with Caesar, the pm_clk only required for some old 
chips(rk3288 for example) due to hardware issue.

and i tested my chromebook kevin(rk3399), it works well after remove the 
pm_clk:

+++ b/drivers/soc/rockchip/pm_domains.c
@@ -478,7 +478,6 @@ static int rockchip_pm_add_one_domain(struct 
rockchip_pmu *pmu,
         pd->genpd.power_on = rockchip_pd_power_on;
         pd->genpd.attach_dev = rockchip_pd_attach_dev;
         pd->genpd.detach_dev = rockchip_pd_detach_dev;
-       pd->genpd.flags = GENPD_FLAG_PM_CLK;

will do more tests and send patch tomorrow.

>
>>> the CONFIG_PM could be disabled.I am hard to believe a modern platform
>>> can work without that.
>>>
>>> so it might be better to control clocks in iommu driver itself.
>> I won't
>> insist how the version of the iommu patch on the upstream, I
>> just post an idea here.
>> The version for kernel 4.4 is under internal review, the implementation
>> has been modified many times.
>>
>> I would suggest the managing clocks in pd is a more easy way and don't
>> need to spare those thing in two places.
