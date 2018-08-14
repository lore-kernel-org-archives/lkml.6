Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14578C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 11:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB42021741
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 11:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB42021741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732383AbeHNO2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 10:28:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:27845 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730759AbeHNO2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 10:28:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2018 04:41:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,238,1531810800"; 
   d="scan'208";a="81630598"
Received: from unknown (HELO [10.237.72.72]) ([10.237.72.72])
  by orsmga001.jf.intel.com with ESMTP; 14 Aug 2018 04:41:41 -0700
Subject: Re: [PATCH V4 4/7] mmc: sdhci: add 32-bit block count support for v4
 mode
To:     =?UTF-8?B?SmFzb24gV3UgKOWQtOmcgeeIvSk=?= <Jason.Wu@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        =?UTF-8?B?QmlsbG93cyBXdSAo5q2m5rSq5rabKQ==?= 
        <Billows.Wu@unisoc.com>
References: <1532340508-8749-5-git-send-email-zhang.chunyan@linaro.org>
 <1532400671-23429-1-git-send-email-zhang.chunyan@linaro.org>
 <3e586922-c5e8-fb3c-233e-06836f4dad48@intel.com>
 <CAAfSe-vT0+9seTJwioY8Um0ch85Q_pDfbWC=uCyF2Ch+LEby-g@mail.gmail.com>
 <598422fd0106427c85945baf1e1f1548@SHMBX02.spreadtrum.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <b23b9836-66f0-9fa5-b5ff-2629b1e3ac06@intel.com>
Date:   Tue, 14 Aug 2018 14:40:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <598422fd0106427c85945baf1e1f1548@SHMBX02.spreadtrum.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/18 04:58, Jason Wu (吴霁爽) wrote:
>  
> 
> According the information of following picture, in this case I think, we
> just have 2 choice in sdio v4.1:
> 
> 1 do not define SDHCI_AUTO_CMD23: argument of cmd23 will define in register
> 0x8(Argument register)

That would only need to be done for requests that use the upper bits. i.e.
Perhaps hook host->mmc_host_ops->request() and check if sbc argument is ok.
Then toggle SDHCI_AUTO_CMD23 accordingly.

> 
> 2 or define SDHCI_USE_ADMA: block count of cmd18/28 will be get in “Command
> Descriptor for SD Mod”of ADMA. And block cnt register will be used as
> parameter of auto cmd23.
> 
> -----Original Message-----
> From: Chunyan Zhang [mailto:zhang.lyra@gmail.com]
> Sent: Monday, August 06, 2018 7:29 PM
> To: Adrian Hunter
> Cc: Chunyan Zhang; Ulf Hansson; linux-mmc@vger.kernel.org; Linux Kernel
> Mailing List; Orson Zhai; Baolin Wang; Billows Wu (武洪涛); Jason Wu (吴霁爽)
> Subject: Re: [PATCH V4 4/7] mmc: sdhci: add 32-bit block count support for
> v4 mode
> 
>  
> 
> Hi Adrian,
> 
>  
> 
> On 30 July 2018 at 21:05, Adrian Hunter <adrian.hunter@intel.com
> <mailto:adrian.hunter@intel.com>> wrote:
> 
>> On 24/07/18 05:51, Chunyan Zhang wrote:
> 
>>> Host Controller Version 4.10 re-defines SDMA System Address register
> 
>>> as 32-bit Block Count for v4 mode, and SDMA uses ADMA System Address
> 
>>> register (05Fh-058h) instead if v4 mode is enabled. Also when using
> 
>>> 32-bit block count, 16-bit block count register need to be set to
> 
>>> zero.
> 
>>> 
> 
>>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org <mailto:zhang.chunyan@linaro.org>>
> 
>>> ---
> 
>>>  drivers/mmc/host/sdhci.c | 14 +++++++++++++- 
> 
>>> drivers/mmc/host/sdhci.h |  1 +
> 
>>>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
>>> 
> 
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> 
>>> index 920d8ec..c272a2b 100644
> 
>>> --- a/drivers/mmc/host/sdhci.c
> 
>>> +++ b/drivers/mmc/host/sdhci.c
> 
>>> @@ -1070,7 +1070,19 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
> 
>>>       /* Set the DMA boundary value and block size */
> 
>>>       sdhci_writew(host, SDHCI_MAKE_BLKSZ(host->sdma_boundary, data->blksz),
> 
>>>                    SDHCI_BLOCK_SIZE);
> 
>>> -     sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
> 
>>> +
> 
>>> +     /*
> 
>>> +      * For Version 4.10 onwards, if v4 mode is enabled, 16-bit Block Count
> 
>>> +      * register need to be set to zero, 32-bit Block Count register would
> 
>>> +      * be selected.
> 
>>> +      */
> 
>>> +     if (host->version >= SDHCI_SPEC_410 && host->v4_mode) {
> 
>>> +             if (sdhci_readw(host, SDHCI_BLOCK_COUNT))
> 
>>> +                     sdhci_writew(host, 0, SDHCI_BLOCK_COUNT);
> 
>>> +             sdhci_writew(host, data->blocks, SDHCI_32BIT_BLK_CNT);
> 
>> 
> 
>> So this is also SDHCI_ARGUMENT2 which is why there is a conflict with
> 
>> auto-CMD23.  We need to write SDHCI_32BIT_BLK_CNT only once, but also
> 
>> cater for eMMC which uses the CMD23 argument for more than just block count.
> 
>> 
> 
>  
> 
> What you would suggest on how should we change here?
> 
>  
> 
> I've double checked with the hardware fellow within the company, the sd host
> controller v4 (on our platform at least) would  use this register as block
> count only, that's saying that it would not deal with the flags (i.e.
> reliable write and data tag) of CMD23.
> 
>  
> 
> Thanks,
> 
> Chunyan
> 
>  
> 
>>> +     } else {
> 
>>> +             sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
> 
>>> +     }
> 
>>>  }
> 
>>> 
> 
>>>  static inline bool sdhci_auto_cmd12(struct sdhci_host *host, diff
> 
>>> --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h index
> 
>>> 23318ff..81aae07 100644
> 
>>> --- a/drivers/mmc/host/sdhci.h
> 
>>> +++ b/drivers/mmc/host/sdhci.h
> 
>>> @@ -28,6 +28,7 @@
> 
>>> 
> 
>>>  #define SDHCI_DMA_ADDRESS    0x00
> 
>>>  #define SDHCI_ARGUMENT2              SDHCI_DMA_ADDRESS
> 
>>> +#define SDHCI_32BIT_BLK_CNT  SDHCI_DMA_ADDRESS
> 
>>> 
> 
>>>  #define SDHCI_BLOCK_SIZE     0x04
> 
>>>  #define  SDHCI_MAKE_BLKSZ(dma, blksz) (((dma & 0x7) << 12) | (blksz
> 
>>> & 0xFFF))
> 
>>> 
> 
>> 
> 

