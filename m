Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F2F87C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A86D3208BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A86D3208BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933559AbeFLMGh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 08:06:37 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:42179 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932412AbeFLMGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 08:06:35 -0400
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.8])
        by lucky1.263xmail.com (Postfix) with ESMTP id 0944C9540A;
        Tue, 12 Jun 2018 20:06:26 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from [192.168.10.112] (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id 5BC9B39C;
        Tue, 12 Jun 2018 20:06:26 +0800 (CST)
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: adrian.hunter@intel.com
X-SENDER-IP: 220.200.5.8
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <4874d0a801f7b2e8285b3d113d9ae522>
X-ATTACHMENT-NUM: 0
X-SENDER: lintao@rock-chips.com
X-DNS-TYPE: 0
Received: from [192.168.10.112] (unknown [220.200.5.8])
        by smtp.263.net (Postfix) whith ESMTP id 30847RZPGDL;
        Tue, 12 Jun 2018 20:06:27 +0800 (CST)
Cc:     Feng Tang <feng.tang@intel.com>, shawn.lin@rock-chips.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: Move the mmc driver init earlier
To:     Ulf Hansson <ulf.hansson@linaro.org>
References: <20180608095154.22413-1-feng.tang@intel.com>
 <CAPDyKFrs3ngkVVQaq34V9qzV3KoFdy=B+UbLnzR=fHKsOco=tg@mail.gmail.com>
 <20180612084234.gjzq66xsqblryrkm@shbuild888>
 <CAPDyKFq8WZhQQ9EBjfuVvu=YHB9AdwvMHwyKOY5Wxku1V5PtmA@mail.gmail.com>
From:   Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <03aa85b4-74cf-621c-08cf-271b4c0d8e8c@rock-chips.com>
Date:   Tue, 12 Jun 2018 20:05:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFq8WZhQQ9EBjfuVvu=YHB9AdwvMHwyKOY5Wxku1V5PtmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/6/12 18:29, Ulf Hansson wrote:
> On 12 June 2018 at 10:42, Feng Tang <feng.tang@intel.com> wrote:
>> Hi Ulf,
>>
>> Thanks for the review.
>>
>> On Tue, Jun 12, 2018 at 08:25:44AM +0200, Ulf Hansson wrote:
>>> On 8 June 2018 at 11:51, Feng Tang <feng.tang@intel.com> wrote:
>>>> When doing some boot time optimization for an eMMC rootfs NUCs,
>>>> we found the rootfs may spend around 100 microseconds waiting
>>>> for eMMC card to be initialized, then the rootfs could be
>>>> mounted.
>>>>          [    1.216561] Waiting for root device /dev/mmcblk1p1...
>>>>          [    1.289262] mmc1: new HS400 MMC card at address 0001
>>>>          [    1.289667] mmcblk1: mmc1:0001 R1J56L 14.7 GiB
>>>>          [    1.289772] mmcblk1boot0: mmc1:0001 R1J56L partition 1 8.00 MiB
>>>>          [    1.289869] mmcblk1boot1: mmc1:0001 R1J56L partition 2 8.00 MiB
>>>>          [    1.289967] mmcblk1rpmb: mmc1:0001 R1J56L partition 3 4.00 MiB
>>>>          [    1.292798]  mmcblk1: p1 p2 p3
>>>>          [    1.300576] EXT4-fs (mmcblk1p1): couldn't mount as ext3 due to feature incompatibilities
>>>>          [    1.300912] EXT4-fs (mmcblk1p1): couldn't mount as ext2 due to feature incompatibilities
>>>>
>>>> And this is a common problem for smartphones, tablets, embedded
>>>> devices and automotive products. This patch will make the eMMC/SD
>>>> card  start initializing earlier, by changing its order in drivers/Makefile.
>>>>
>>>> On our platform, the waiting for eMMC card is almost eliminated with the patch,
>>>> which is critical to boot time.
>>>
>>> I am wondering what kernel version you are running here. There have
>>> been some changes to the mmc initialization path, which perhaps can
>>> help.
>> These logs in commit msg are based on kernel 4.14, and the patch is generated
>> against kernel 4.17.
> 
> Right. So it's quite recent, even if lot's of changes have been made
> to the mmc core since then.
> 
> A few things (old/new) that is important.
> 1) Check if your mmc host driver support MMC_CAP_WAIT_WHILE_BUSY. That
> should have some effect, avoiding unnecessary polling.
> 
> 2) Since 4.18 rc1, you will be able to configure an over estimated
> "power on" delay (via DT as well). Look at commit
> 6d796c68cd15234a33a4bd2ef7231125fea2dc6c.

Sorry to chime in. We could also reduce the "power on" delay via hosts'
->set_ios() callback.

> 
> 3) If you use a DT based platform, I think what people do is to
> re-organize the order of device nodes, such that as many as possible
> -EPROBE_DEFER is avoided to be returned by drivers. This is also not a
> good solution, but the best we have at this moment.

Also DT based platform is allowed to add no-sd and no-sdio for the eMMC
node, which could slighly help reduce the boot time.
You could refer to Documentation/devicetree/bindings/mmc/mmc.txt for
details.

> 
>>
>>>
>>>>
>>>> Signed-off-by: Feng Tang <feng.tang@intel.com>
>>>> ---
>>>>   drivers/Makefile | 4 +++-
>>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/Makefile b/drivers/Makefile
>>>> index 24cd47014657..c473afd3c688 100644
>>>> --- a/drivers/Makefile
>>>> +++ b/drivers/Makefile
>>>> @@ -50,6 +50,9 @@ obj-$(CONFIG_REGULATOR)               += regulator/
>>>>   # reset controllers early, since gpu drivers might rely on them to initialize
>>>>   obj-$(CONFIG_RESET_CONTROLLER) += reset/
>>>>
>>>> +# put mmc early as many morden devices use emm/sd card as rootfs storage
>>>> +obj-y                          += mmc/
>>>> +
>>>
>>> Your suggested approach isn't really a solution, as it may work for
>>> your particular case but not for everybody else.
>>
>> Do you mean the patch may break some platforms? Yes, I only tested on
>> some IA based NUCs, and I did think about other architectures, things
>> that may affect MMC are gpio/clk/pinctrl, and those are still earlier
>> than mmc after change.
> 
> I don't know if it breaks things, potentially it could, if drivers
> don't implement support for -EPROBE_DEFER properly.
> 
> However, more importantly, it's not real fix to the problem, just
> something that seems to work for you.
> 
> Kind regards
> Uffe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 


-- 
Best Regards
Shawn Lin

