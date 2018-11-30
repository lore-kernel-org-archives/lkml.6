Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40D4C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EBCD2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EBCD2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbeK3MW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 07:22:59 -0500
Received: from lucky1.263xmail.com ([211.157.147.135]:37778 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeK3MW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 07:22:58 -0500
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.152])
        by lucky1.263xmail.com (Postfix) with ESMTP id 0C163969;
        Fri, 30 Nov 2018 09:15:25 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from [172.16.12.37] (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id 9C2D7359;
        Fri, 30 Nov 2018 09:15:22 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: nsekhar@ti.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <5dce2b9c02548287941551d8bd8ee4e4>
X-ATTACHMENT-NUM: 0
X-SENDER: lintao@rock-chips.com
X-DNS-TYPE: 0
Received: from [172.16.12.37] (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 24057389YZW;
        Fri, 30 Nov 2018 09:15:24 +0800 (CST)
Cc:     shawn.lin@rock-chips.com, Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        kishon@ti.com, nsekhar@ti.com
Subject: Re: [PATCH v2 1/3] mmc: sdhci: add support for using external DMA
 devices
To:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
References: <1542007566-9449-1-git-send-email-zhang.chunyan@linaro.org>
 <1542007566-9449-2-git-send-email-zhang.chunyan@linaro.org>
 <84836600-c705-9ac3-297e-bb67a611daca@intel.com>
 <CAAfSe-us5aKOv9F6KHwvJR_cMAF8KFo6W1Gs_B3zBiNOuD10Qg@mail.gmail.com>
 <f78de042-69cf-5345-f16f-236d04d57051@intel.com>
 <CAAfSe-sfe5A7b_8iBiUmvi_mo1zRZ_Oh0yu-uwXo8Hv+WBftWQ@mail.gmail.com>
From:   Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <22591bc4-ea34-dcc6-a3d5-8a75e890ff2b@rock-chips.com>
Date:   Fri, 30 Nov 2018 09:15:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CAAfSe-sfe5A7b_8iBiUmvi_mo1zRZ_Oh0yu-uwXo8Hv+WBftWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/29 17:59, Chunyan Zhang wrote:
> Hi Adrian,
> 
> On Thu, 29 Nov 2018 at 15:36, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 29/11/18 8:22 AM, Chunyan Zhang wrote:
>>> On Tue, 20 Nov 2018 at 21:41, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>
>>>> On 12/11/18 9:26 AM, Chunyan Zhang wrote:
>>>>> Some standard SD host controllers can support both external dma
>>>>> controllers as well as ADMA/SDMA in which the SD host controller
>>>>> acts as DMA master. TI's omap controller is the case as an example.
>>>>>
>>>>> Currently the generic SDHCI code supports ADMA/SDMA integrated in
>>>>> the host controller but does not have any support for external DMA
>>>>> controllers implemented using dmaengine, meaning that custom code is
>>>>> needed for any systems that use an external DMA controller with SDHCI.
>>>>
>>>> I still think you probably need to reset the DMA if there are transfer
>>>> errors - perhaps you could comment on that.  Also there are some comments below.
>>>
>>> With regard to "transfer error", do you mean if
>>> sdhci_external_dma_setup() failed?
>>
>> No, I mean any error interrupt that can leave the DMA uncompleted.  For
>> SDHCI, resetting the data circuit cleans that up, but presumably something
>> is needed for external DMA?
> 
> Yes, it should need a dmaengine_terminate_all().
> 

No, dmaengine_terminate_all is deprecated for quite a long time.
Please use dmaengine_terminate_{async, sync}() instead.

See Documentation/dmaengine/client.txt


> How about adding that at here (I will wrap it up of course):
> https://elixir.bootlin.com/linux/v4.19.5/source/drivers/mmc/host/sdhci.c#L2553
> 
> Is there somewhere else I'm missing?
> 
> Thanks,
> Chunyan
> 
> 

