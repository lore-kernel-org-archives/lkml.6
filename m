Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445EDC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 06:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C5F2157F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 06:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C5F2157F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeHXKao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 06:30:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:15374 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbeHXKan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 06:30:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Aug 2018 23:57:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,281,1531810800"; 
   d="scan'208";a="257644884"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.137]) ([10.237.72.137])
  by fmsmga006.fm.intel.com with ESMTP; 23 Aug 2018 23:57:22 -0700
Subject: Re: [PATCH V5 07/10] mmc: sdhci: Add Auto CMD Auto Select support
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@unisoc.com>,
        Jason Wu <jason.wu@unisoc.com>
References: <1534406064-10065-1-git-send-email-zhang.chunyan@linaro.org>
 <1534406064-10065-8-git-send-email-zhang.chunyan@linaro.org>
 <0dc112ca-1c01-d8ae-c6f0-80492264f5a4@intel.com>
 <CAAfSe-uZ3ghR+8dZ7CD03UnGX2Uf1fv=-5s656ZkybcU8LWzJQ@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <c1e0a508-c47b-c02f-7df9-d3e928526e86@intel.com>
Date:   Fri, 24 Aug 2018 09:55:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAAfSe-uZ3ghR+8dZ7CD03UnGX2Uf1fv=-5s656ZkybcU8LWzJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/18 09:52, Chunyan Zhang wrote:
> On 23 August 2018 at 20:55, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 16/08/18 10:54, Chunyan Zhang wrote:
>>> As SD Host Controller Specification v4.10 documents:
>>> Host Controller Version 4.10 defines this "Auto CMD Auto Select" mode.
>>> Selection of Auto CMD depends on setting of CMD23 Enable in the Host
>>> Control 2 register which indicates whether card supports CMD23. If CMD23
>>> Enable =1, Auto CMD23 is used and if CMD23 Enable =0, Auto CMD12 is
>>> used. In case of Version 4.10 or later, use of Auto CMD Auto Select is
>>> recommended rather than use of Auto CMD12 Enable or Auto CMD23
>>> Enable.
>>>
>>> This patch add this new mode support.
>>>
>>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>>> ---
>>>  drivers/mmc/host/sdhci.c | 67 ++++++++++++++++++++++++++++++++++++++++--------
>>>  drivers/mmc/host/sdhci.h |  2 ++
>>>  2 files changed, 58 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index a72ad0d..06c2ae9 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -312,6 +312,23 @@ static void sdhci_config_dma(struct sdhci_host *host)
>>>       sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>>>  }
>>>
>>> +static void sdhci_enable_cmd23(struct sdhci_host *host)
>>> +{
>>> +     u16 ctrl2;
>>> +
>>> +     /*
>>> +      * This is used along with "Auto CMD Auto Select" feature,
>>> +      * which is introduced from v4.10, if card supports CMD23,
>>> +      * Auto CMD23 should be used instead of Auto CMD12.
>>> +      */
>>> +     if (host->version >= SDHCI_SPEC_410 &&
>>> +         (host->mmc->caps & MMC_CAP_CMD23)) {
>>
>> The caller has already checked those conditions
>>
>>> +             ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>> +             ctrl2 |= SDHCI_CMD23_ENABLE;
>>> +             sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
>>> +     }
>>> +}
>>> +
>>>  static void sdhci_init(struct sdhci_host *host, int soft)
>>>  {
>>>       struct mmc_host *mmc = host->mmc;
>>> @@ -1095,6 +1112,44 @@ static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
>>>              !mrq->cap_cmd_during_tfr;
>>>  }
>>>
>>> +static inline void sdhci_auto_cmd_select(struct sdhci_host *host,
>>> +                                      struct mmc_command *cmd,
>>> +                                      u16 *mode)
>>> +{
>>> +     bool use_cmd12 = sdhci_auto_cmd12(host, cmd->mrq) &&
>>> +                      (cmd->opcode != SD_IO_RW_EXTENDED);
>>> +     bool use_cmd23 = cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23);
>>> +
>>> +     /*
>>> +      * In case of Version 4.10 or later, use of 'Auto CMD Auto
>>> +      * Select' is recommended rather than use of 'Auto CMD12
>>> +      * Enable' or 'Auto CMD23 Enable'.
>>> +      */
>>> +     if (host->version >= SDHCI_SPEC_410 && (use_cmd12 || use_cmd23)) {
>>> +             *mode |= SDHCI_TRNS_AUTO_SEL;
>>> +             /*
>>> +              * Note no need to set SDHCI_ARGUMENT2 here, since for version
>>> +              * 4.10 and aboves, it doesn't support stuff bits of CMD23
>>> +              * argument but only number of blocks which have been set
>>> +              * already during prepare data.
>>
>> The argument will only have already been written in v4_mode.
> 
> It seems that we still need to set SDHCI_ARGUMENT2 here, if adding a
> quirk for broken using 32-bit block count and also moved below to
> sdhci-sprd.c

Yes

> 
> "
> +     /*
> +      * For version 4.10 and above, ARGUMENT2 register is also used as 32-bit
> +      * block count register which don't support stuff bits of CMD23 argument
> +      */
> +     if (host->version >= SDHCI_SPEC_410 &&
> +         mrq->sbc && (mrq->sbc->arg & SDHCI_ARG2_STUFF) &&
> +         (host->flags & SDHCI_AUTO_CMD23))
> +             host->flags &= ~SDHCI_AUTO_CMD23
> "
> 
>>
>>> +              */
>>> +             if (use_cmd23)
>>> +                     sdhci_enable_cmd23(host);
>>
>> Need to ensure that SDHCI_CMD23_ENABLE is cleared for !use_cmd23
>>
>>> +             return;
>>> +     }
>>> +
>>> +     /*
>>> +      * If we are sending CMD23, CMD12 never gets sent
>>> +      * on successful completion (so no Auto-CMD12).
>>> +      */
>>> +     if (use_cmd12) {
>>> +             *mode |= SDHCI_TRNS_AUTO_CMD12;
>>> +     } else if (use_cmd23) {
>>> +             *mode |= SDHCI_TRNS_AUTO_CMD23;
>>> +             sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
>>> +     }
>>> +}
>>> +
>>>  static void sdhci_set_transfer_mode(struct sdhci_host *host,
>>>       struct mmc_command *cmd)
>>>  {
>>> @@ -1121,17 +1176,7 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
>>>
>>>       if (mmc_op_multi(cmd->opcode) || data->blocks > 1) {
>>>               mode = SDHCI_TRNS_BLK_CNT_EN | SDHCI_TRNS_MULTI;
>>> -             /*
>>> -              * If we are sending CMD23, CMD12 never gets sent
>>> -              * on successful completion (so no Auto-CMD12).
>>> -              */
>>> -             if (sdhci_auto_cmd12(host, cmd->mrq) &&
>>> -                 (cmd->opcode != SD_IO_RW_EXTENDED))
>>> -                     mode |= SDHCI_TRNS_AUTO_CMD12;
>>> -             else if (cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23)) {
>>> -                     mode |= SDHCI_TRNS_AUTO_CMD23;
>>> -                     sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
>>> -             }
>>> +             sdhci_auto_cmd_select(host, cmd, &mode);
>>>       }
>>>
>>>       if (data->flags & MMC_DATA_READ)
>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>> index daf8c1e..a8d5be5 100644
>>> --- a/drivers/mmc/host/sdhci.h
>>> +++ b/drivers/mmc/host/sdhci.h
>>> @@ -43,6 +43,7 @@
>>>  #define  SDHCI_TRNS_BLK_CNT_EN       0x02
>>>  #define  SDHCI_TRNS_AUTO_CMD12       0x04
>>>  #define  SDHCI_TRNS_AUTO_CMD23       0x08
>>> +#define  SDHCI_TRNS_AUTO_SEL 0x0C
>>>  #define  SDHCI_TRNS_READ     0x10
>>>  #define  SDHCI_TRNS_MULTI    0x20
>>>
>>> @@ -186,6 +187,7 @@
>>>  #define   SDHCI_CTRL_DRV_TYPE_D              0x0030
>>>  #define  SDHCI_CTRL_EXEC_TUNING              0x0040
>>>  #define  SDHCI_CTRL_TUNED_CLK                0x0080
>>> +#define  SDHCI_CMD23_ENABLE          0x0800
>>>  #define  SDHCI_CTRL_V4_MODE          0x1000
>>>  #define  SDHCI_CTRL_64BIT_ADDR               0x2000
>>>  #define  SDHCI_CTRL_PRESET_VAL_ENABLE        0x8000
>>>
>>
> 

