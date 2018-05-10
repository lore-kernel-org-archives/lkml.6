Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935108AbeEJLfR convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 07:35:17 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:41242 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757123AbeEJLfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 07:35:16 -0400
Subject: Re: [PATCH 4.17 2/2] ssb: make SSB_PCICORE_HOSTMODE depend on SSB = y
To: =?UTF-8?Q?Michael_B=c3=bcsch?= <m@bues.ch>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC: Kalle Valo <kvalo@codeaurora.org>,
        Larry Finger <larry.finger@lwfinger.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>, LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20180510111401.1161-1-zajec5@gmail.com>
 <20180510111401.1161-2-zajec5@gmail.com> <20180510131725.111079af@wiggum>
 <CACna6ryWUCnrw9w4yhfiNXFHy1hFjVV-BqH07i7DQqxq8FtjMw@mail.gmail.com>
 <20180510132612.25c8c20e@wiggum>
From: Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <a6a2e4af-815d-bcb6-de74-3940febe9413@mips.com>
Date: Thu, 10 May 2018 12:35:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180510132612.25c8c20e@wiggum>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [192.168.155.41]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1525952083-298554-31095-59973-1
X-BESS-VER: 2018.5-r1804261738
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.192873
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/05/18 12:26, Michael Büsch wrote:
> On Thu, 10 May 2018 13:20:01 +0200
> Rafał Miłecki <zajec5@gmail.com> wrote:
> 
>> On 10 May 2018 at 13:17, Michael Büsch <m@bues.ch> wrote:
>>> On Thu, 10 May 2018 13:14:01 +0200
>>> Rafał Miłecki <zajec5@gmail.com> wrote:
>>>   
>>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>>
>>>> SSB_PCICORE_HOSTMODE protects MIPS specific code that calls not exported
>>>> symbols pcibios_enable_device and register_pci_controller. This code is
>>>> supposed to be compiled only with ssb builtin.
>>>>
>>>> This fixes:
>>>> ERROR: "pcibios_enable_device" [drivers/ssb/ssb.ko] undefined!
>>>> ERROR: "register_pci_controller" [drivers/ssb/ssb.ko] undefined!
>>>> make[1]: *** [scripts/Makefile.modpost:92: __modpost] Error 1
>>>>
>>>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>>>> ---
>>>>   drivers/ssb/Kconfig | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/ssb/Kconfig b/drivers/ssb/Kconfig
>>>> index b3f5cae98ea6..c574dd210500 100644
>>>> --- a/drivers/ssb/Kconfig
>>>> +++ b/drivers/ssb/Kconfig
>>>> @@ -131,7 +131,7 @@ config SSB_DRIVER_PCICORE
>>>>
>>>>   config SSB_PCICORE_HOSTMODE
>>>>        bool "Hostmode support for SSB PCI core"
>>>> -     depends on SSB_DRIVER_PCICORE && SSB_DRIVER_MIPS
>>>> +     depends on SSB_DRIVER_PCICORE && SSB_DRIVER_MIPS && SSB = y
>>>>        help
>>>>          PCIcore hostmode operation (external PCI bus).
>>>>   
>>>
>>>
>>> I think we also need to depend on PCI_DRIVERS_LEGACY.
>>> See the other patch that floats around.
>>
>> I believe it's already handled by SSB_PCIHOST_POSSIBLE's dependency on
>> PCI_DRIVERS_LEGACY.
> 
> 
> That dependency seems to be wrong there.
> Was it added among some other "let's just unbreak some random
> build" change as well?

Yeah - that was commit 58eae1416b80 ("ssb: Disable PCI host for 
PCI_DRIVERS_GENERIC").

> 
> SSB_PCIHOST enables support for SSB on top of PCI. (Which is 99% of it
> uses). I don't see how this uses the legacy API.
> 
> SSB_PCICORE_HOSTMODE enables PCI on top of SSB. Which is a MIPS corner
> case. This uses the legacy MIPS API to register a PCI bus.
> 

Yeah the dependency would seem to be in the wrong place and should be on 
SSB_PCICORE_HOSTMODE, in the same way as the bcma driver - commits 
664eadd6f44b ("bcma: Fix 'allmodconfig' and BCMA builds on MIPS 
targets") & 79ca239a68f8 ("bcma: Prevent build of PCI host features in 
module").

Thanks,
Matt
