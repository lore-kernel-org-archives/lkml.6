Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5C7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB2E20779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLU5oRtN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DB2E20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387999AbeGWIML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 04:12:11 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34123 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387828AbeGWIMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 04:12:10 -0400
Received: by mail-lf1-f65.google.com with SMTP id n96-v6so5635311lfi.1;
        Mon, 23 Jul 2018 00:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PBtx/Z4DEawR0qgh0FFvupp+aDCRVuPEMDZO6efj5qg=;
        b=gLU5oRtNC+eDAe+fFymrcr+lOiVHv+Apun6Nk5ktT5TRipi5CUpn9BQC0ao9IH06Hw
         UhLVwQty1K+rahKyEHhi3ANJUN++k1JWHNnfwMiW6mqDSMunLmLRhJPTTuln3dJpW0vk
         DqNkbI9qagPw+L7xN582JStVKkYGfUQES+hn6mqmUnyBvMyHuxYpP61a4KJApVNCIbKv
         O8305qZ631ISSOVMban2iabbgjfFxIQo9TaBJzhJ0jrbABkO/8jOncly3TpPpGGef+Yl
         NSEvh2CPPVoKkMF5T2LNsQvQUbfgGA7lqK63fWnU5eVqPQgv+BnjnejgPA/M/WYvytaN
         Mh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PBtx/Z4DEawR0qgh0FFvupp+aDCRVuPEMDZO6efj5qg=;
        b=Bsj5+pruRttz7qqIA0FUeO+3lQsknGhfH7TsD5xZRh+llko9EsUGanc8I6WhYH28nI
         m6vE3Ov8z9X6fgqh+vCPYTAiHtB7mNYwHVoF+lS2K9u6Ou12zrs2L607YfomPLtE/cKt
         KfNja57G28V0tZnibT0fmfc7w2CzUrlltVJ+hma7bc003wgfXX/eD4lp4mmUV4ytoKqY
         BCHv3QC4gYbpqDNOf4scyKs6pvOLskODH33Ai5TLvu73rdta4d60ST+bEd8ZPaWW8id5
         0K1NprK6LbCPHxpCjesaluMIerIHl11mLZbLRhCzqDVRLhl0+TWSD6eNgVRnMmtuQeaL
         e33Q==
X-Gm-Message-State: AOUpUlHUvCQzdWhRetRpy3etFRrUeqDJ4yv2aH0Lgn5qqqKeTtFFoC/3
        t+/AqrgLeRg8cHwx19k5th/yaYsQEle6JGYI9sY=
X-Google-Smtp-Source: AAOMgpdKbDKUpenE/wUm4ltVmDr17S9zCO6pXtYWz7pRXony4sNUOI21r8Hnb5L1xKyqBt25kBpjkYyfM97lT7BbU7U=
X-Received: by 2002:a19:b598:: with SMTP id g24-v6mr6833993lfk.129.1532329942754;
 Mon, 23 Jul 2018 00:12:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:631a:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 00:11:42
 -0700 (PDT)
In-Reply-To: <3cc11907-5248-ea5a-5e2a-f93e12ef4e68@intel.com>
References: <1531106398-14062-1-git-send-email-zhang.chunyan@linaro.org>
 <1531106398-14062-6-git-send-email-zhang.chunyan@linaro.org> <3cc11907-5248-ea5a-5e2a-f93e12ef4e68@intel.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Mon, 23 Jul 2018 15:11:42 +0800
Message-ID: <CAAfSe-t8T0JRR7w++FeWppEaC0S7x838EGmySoBsS0+WMOpDng@mail.gmail.com>
Subject: Re: [PATCH V3 5/7] mmc: sdhci: add Auto CMD Auto Select support
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 July 2018 at 19:16, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 09/07/18 06:19, Chunyan Zhang wrote:
>> As SD Host Controller Specification v4.10 documents:
>> Host Controller Version 4.10 defines this "Auto CMD Auto Select" mode.
>> Selection of Auto CMD depends on setting of CMD23 Enable in the Host
>> Control 2 register which indicates whether card supports CMD23. If CMD23
>> Enable =1, Auto CMD23 is used and if CMD23 Enable =0, Auto CMD12 is
>> used. In case of Version 4.10 or later, use of Auto CMD Auto Select is
>> recommended rather than use of Auto CMD12 Enable or Auto CMD23
>> Enable.
>>
>> This patch add this new mode support.
>>
>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>> ---
>>  drivers/mmc/host/sdhci.c | 39 ++++++++++++++++++++++++++++-----------
>>  drivers/mmc/host/sdhci.h |  2 ++
>>  2 files changed, 30 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index f64e766..1ca3871 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1033,6 +1033,33 @@ static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
>>              !mrq->cap_cmd_during_tfr;
>>  }
>>
>> +static inline void sdhci_auto_cmd_enable(struct sdhci_host *host,
>> +                                      struct mmc_command *cmd,
>> +                                      u16 *mode)
>> +{
>> +     /*
>> +      * In case of Version 4.10 or later, use of 'Auto CMD Auto
>> +      * Select' is recommended rather than use of 'Auto CMD12
>> +      * Enable' or 'Auto CMD23 Enable'.
>> +      */
>> +     if (host->version >= SDHCI_SPEC_410) {
>> +             *mode |= SDHCI_TRNS_AUTO_SEL;
>
> The rules for selecting auto commands still need to be applied.  In effect:
>
>         if (sdhci_auto_cmd12(host, cmd->mrq) &&
>             (cmd->opcode != SD_IO_RW_EXTENDED)) {
>                 *mode |= SDHCI_TRNS_AUTO_SEL;
>         } else if (cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23)) {
>                 *mode |= SDHCI_TRNS_AUTO_SEL;
>                 sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);

The fact seems that SDHCI_TRNS_AUTO_SEL mode don't need
SDHCI_ARGUMENT2 register being written. The test result on my board
showed that mounting a blk partition would fail due to lack of a
hardware interrupt if SDHCI_ARGUMENT2 was set like above.

>         }
>
> Also the selection of Host Control 2 register CMD23 Enable should be done by
> SDHCI (if supported by the card) not the Spreadtrum driver.

Ok.

>
>> +             return;
>> +     }
>> +
>> +     /*
>> +      * If we are sending CMD23, CMD12 never gets sent
>> +      * on successful completion (so no Auto-CMD12).
>> +      */
>> +     if (sdhci_auto_cmd12(host, cmd->mrq) &&
>> +         (cmd->opcode != SD_IO_RW_EXTENDED)) {
>> +             *mode |= SDHCI_TRNS_AUTO_CMD12;
>> +     } else if (cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23)) {
>> +             *mode |= SDHCI_TRNS_AUTO_CMD23;
>> +             sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
>> +     }
>> +}
>> +
>>  static void sdhci_set_transfer_mode(struct sdhci_host *host,
>>       struct mmc_command *cmd)
>>  {
>> @@ -1059,17 +1086,7 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
>>
>>       if (mmc_op_multi(cmd->opcode) || data->blocks > 1) {
>>               mode = SDHCI_TRNS_BLK_CNT_EN | SDHCI_TRNS_MULTI;
>> -             /*
>> -              * If we are sending CMD23, CMD12 never gets sent
>> -              * on successful completion (so no Auto-CMD12).
>> -              */
>> -             if (sdhci_auto_cmd12(host, cmd->mrq) &&
>> -                 (cmd->opcode != SD_IO_RW_EXTENDED))
>> -                     mode |= SDHCI_TRNS_AUTO_CMD12;
>> -             else if (cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23)) {
>> -                     mode |= SDHCI_TRNS_AUTO_CMD23;
>> -                     sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
>> -             }
>> +             sdhci_auto_cmd_enable(host, cmd, &mode);
>>       }
>>
>>       if (data->flags & MMC_DATA_READ)
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index 889e48b..8263ac6 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -42,6 +42,7 @@
>>  #define  SDHCI_TRNS_BLK_CNT_EN       0x02
>>  #define  SDHCI_TRNS_AUTO_CMD12       0x04
>>  #define  SDHCI_TRNS_AUTO_CMD23       0x08
>> +#define  SDHCI_TRNS_AUTO_SEL 0x0C
>>  #define  SDHCI_TRNS_READ     0x10
>>  #define  SDHCI_TRNS_MULTI    0x20
>>
>> @@ -185,6 +186,7 @@
>>  #define   SDHCI_CTRL_DRV_TYPE_D              0x0030
>>  #define  SDHCI_CTRL_EXEC_TUNING              0x0040
>>  #define  SDHCI_CTRL_TUNED_CLK                0x0080
>> +#define  SDHCI_CMD23_ENABLE          0x0800
>>  #define  SDHCI_CTRL_V4_MODE          0x1000
>>  #define  SDHCI_CTRL_64BIT_ADDR               0x2000
>>  #define  SDHCI_CTRL_PRESET_VAL_ENABLE        0x8000
>>
>
