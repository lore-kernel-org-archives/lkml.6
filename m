Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751352AbeCLMhe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 08:37:34 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37537 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751053AbeCLMhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 08:37:32 -0400
X-Google-Smtp-Source: AG47ELuLdq/SD3VFd6md6bZrO6nfFWjupTDB1cfDVEyZWjIhsrvUsfTV+X1r3ycq4UDgNJI2I5HmiA==
Subject: Re: [PATCH v3 1/3] clk: tegra: Mark HCLK, SCLK and EMC as critical
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <699ce67980d71fd315085ea9785ee6213e0772cb.1515589507.git.digetx@gmail.com>
 <cbf3e9ff-f7e1-32c2-546d-85fd198c2a3b@gmail.com>
 <1487f4a9-d924-3366-c86a-f1bd33ebb1bf@gmail.com> <20180308144437.GJ3529@ulmo>
 <92084f1b-848a-39e6-7d77-7ceaa6a6f1d3@gmail.com>
 <20180312071548.GB23060@ulmo>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5fc86cc6-947f-ec7c-0c57-905f7aecdfbb@gmail.com>
Date: Mon, 12 Mar 2018 15:37:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180312071548.GB23060@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.03.2018 10:15, Thierry Reding wrote:
> On Fri, Mar 09, 2018 at 05:35:46PM +0300, Dmitry Osipenko wrote:
>> On 08.03.2018 17:44, Thierry Reding wrote:
>>> On Thu, Mar 01, 2018 at 04:33:29PM +0300, Dmitry Osipenko wrote:
>>>> On 15.01.2018 13:56, Dmitry Osipenko wrote:
>>>>> On 10.01.2018 16:59, Dmitry Osipenko wrote:
>>>>>> Machine dies if HCLK, SCLK or EMC is disabled. Hence mark these clocks
>>>>>> as critical.
>>>>>>
>>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
>>>>>> ---
>>>>>>
>>>>>> Change log:
>>>>>> v2:     Fixed accidentally missed marking EMC as critical on Tegra30 and
>>>>>>         Tegra124. Switched to a use of common EMC gate definition on Tegra20
>>>>>>         and Tegra30.
>>>>>>
>>>>>> v3:     Dropped marking PLL_P outputs as critical, because seems they are
>>>>>>         not so critical. Although, I still haven't got a definitive answer
>>>>>>         about what exact HW functions are affected by the fixed-clocks.
>>>>>>         Anyway it should be cleaner to correct the actual drivers.
>>>>>
>>>>> Stephen / Michael, would it be possible to schedule these patches for 4.16? My
>>>>> T20 and T30 devices aren't working without the 'critical clocks' patch. Things
>>>>> happen to work with the opensource u-boot, but not with the proprietary
>>>>> bootloader. It's probably not a big deal that out-of-tree devices are broken,
>>>>> although would be nice to have one problem less.
>>>>
>>>> Guys, is there anything I could do to get these patches in linux-next?
>>>
>>> I've picked these up into the for-4.17/clk branch in the Tegra tree. I
>>> already have that branch for the MBIST patches which are a dependency
>>> for the for-4.17/soc branch.
>>
>> Thank you very much! Could you please add stable tag to this ("Mark HCLK, SCLK
>> and EMC as critical") patch? It would be nice to have 4.16 unbroken eventually
>> for those who (have to) use downstream android bootloader.
>>
>> Cc: <stable@vger.kernel.org> # v4.16
> 
> Should we add a Fixes: line instead? That way it will get automatically
> backported to all applicable stable releases.
> 
> This is a little complicated because the clocks were introduced in
> different commits, most of them a very long time ago:
> 
> 	a7c8485a0ebbdce303c6709e208bb4fd08aff8ad (sclk)
> 	2db04f16b589c6c96bd07df3f1ef8558bfdb6810 (emc)
> 	76ebc134d45d7e6e1dc29fdcef4e539c5bc76eb8 (emc)
> 	...
> 
> So Fixes: is perhaps not desirable after all, but then, so isn't tagging
> v4.16 specifically because this is a bug since almost forever, so v4.16
> is fairly arbitrary. Shouldn't we at least get this fixed for the last
> couple of LTS releases?

That issue was masked in earlier kernels and only appears in 4.16, there is no
need to backport it further. I thought that adding of 'stable' tag is enough to
get patch backported automatically, so let's add 'fixes' instead:

Fixes: 109eba2eb61a ("clk: tegra: Mark APB clock as critical")

This patch applies cleanly to 4.16, everything should be fine.
