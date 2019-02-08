Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC331C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1A92070B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="gGW1+OWB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfBHN27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:28:59 -0500
Received: from mail.dice.at ([217.10.52.18]:24433 "EHLO smtp2.infineon.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726624AbfBHN26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:28:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1549632536; x=1581168536;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ymzaBINszasDojp9Vae0c6Ox4DF+ALxUgNsn0cpgsBQ=;
  b=gGW1+OWBfI0u/JXEgOT0+UoyASPuNpDw+0qmZyBh/dceYZY9pDl7y7Hk
   1YYoYCYoQlhcSq+oxS8Bsk3FBYJA/p949t78+989VK1JWYREt24CV0WYE
   kTd/5vbuvdH27VszpkXlG6VaiJDfKIreDifCusJV22RcLt2UwN6EOrKRG
   c=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="5900,7806,9160"; a="100067579"
X-IronPort-AV: E=Sophos;i="5.58,347,1544482800"; 
   d="scan'208";a="100067579"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp2.infineon.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2019 14:28:55 +0100
Received: from MUCSE708.infineon.com (MUCSE708.infineon.com [172.23.7.82])
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS;
        Fri,  8 Feb 2019 14:28:55 +0100 (CET)
Received: from [10.154.32.28] (172.23.8.247) by MUCSE708.infineon.com
 (172.23.7.82) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1531.3; Fri, 8 Feb
 2019 14:28:54 +0100
Subject: Re: [PATCH v11 00/16] Remove nested TPM operations
To:     Stefan Berger <stefanb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
References: <20190205224723.19671-1-jarkko.sakkinen@linux.intel.com>
 <20190206120634.GA4680@linux.intel.com>
 <3d6fdcc1-8221-2137-fc82-596377cc2fdc@infineon.com>
 <20190207212912.GD23906@linux.intel.com>
 <0af40351-91d5-d0a7-2965-0a9c6505af79@linux.ibm.com>
 <20190208003314.GB7202@linux.intel.com>
 <1fbd29ad-1005-8450-4c39-00974468183b@linux.ibm.com>
 <9cd734ad-ea9d-77f7-b657-3f0910a9d92f@linux.ibm.com>
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
Message-ID: <515b6c56-59e9-468d-35e0-3ae183bcea8c@infineon.com>
Date:   Fri, 8 Feb 2019 14:28:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <9cd734ad-ea9d-77f7-b657-3f0910a9d92f@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE707.infineon.com (172.23.7.81) To
 MUCSE708.infineon.com (172.23.7.82)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.02.2019 03:14, Stefan Berger wrote:
> On 2/7/19 8:51 PM, Stefan Berger wrote:
>> On 2/7/19 7:33 PM, Jarkko Sakkinen wrote:
>>> On Thu, Feb 07, 2019 at 06:29:43PM -0500, Stefan Berger wrote:
>>>> On 2/7/19 4:29 PM, Jarkko Sakkinen wrote:
>>
>>
>>>
>>>> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
>>>> index e74c5b7b64bf..52afe20cc8a1 100644
>>>> --- a/drivers/char/tpm/tpm2-cmd.c
>>>> +++ b/drivers/char/tpm/tpm2-cmd.c
>>>> @@ -799,7 +799,9 @@ int tpm2_probe(struct tpm_chip *chip)
>>>>       tpm_buf_append_u32(&buf, TPM2_CAP_TPM_PROPERTIES);
>>>>       tpm_buf_append_u32(&buf, TPM_PT_TOTAL_COMMANDS);
>>>>       tpm_buf_append_u32(&buf, 1);
>>>> +    tpm_chip_start(chip);
>>>>       rc = tpm_transmit_cmd(chip, &buf, 0, NULL);
>>>> +    tpm_chip_stop(chip);
>>> Thanks Stefan! I added call to tpm_tis_core as tpm2-cmd.c is to be kept
>>> out of chip management common case being that you call 
>>> tpm_try_get_ops(),
>>> do 1-N TPM commands and release with tpm_put_ops(). These functions take
>>> care starting and stopping the chip.
>>>
>>> I fixed the 2nd issue in the master.
>>
>> You also need to export the tpm_chip_start/stop symbols.
>>
>>
>> Master now seems to (still) have a problem when rmmod'ing:
>>
>> A TPM error (325) occurred stopping the TPM. This happens at the same 
>> patch where I had to add the tpm_chip_start/stop above.
>>
>>
> 
> Here's my current overall patch against your master. I suppose the other 
> tpm2_shutdown() for power management doesn't need the chip start ?
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 9865776ee2cd..f7147706a9c3 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -115,6 +115,7 @@ int tpm_chip_start(struct tpm_chip *chip)
> 
>       return 0;
>   }
> +EXPORT_SYMBOL_GPL(tpm_chip_start);
> 
>   /**
>    * tpm_chip_stop() - power off the TPM
> @@ -131,7 +132,7 @@ void tpm_chip_stop(struct tpm_chip *chip)
>       if (chip->ops->clk_enable)
>           chip->ops->clk_enable(chip, false);
>   }
> -
> +EXPORT_SYMBOL_GPL(tpm_chip_stop);
> 
>   /**
>    * tpm_try_get_ops() - Get a ref to the tpm_chip
> @@ -474,8 +475,11 @@ static void tpm_del_char_device(struct tpm_chip *chip)
> 
>       /* Make the driver uncallable. */
>       down_write(&chip->ops_sem);
> -    if (chip->flags & TPM_CHIP_FLAG_TPM2)
> +    if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> +        tpm_chip_start(chip, 0);
>           tpm2_shutdown(chip, TPM2_SU_CLEAR);
> +        tpm_chip_stop(chip, 0);
> +    }
>       chip->ops = NULL;
>       up_write(&chip->ops_sem);
>   }
> diff --git a/drivers/char/tpm/tpm-interface.c 
> b/drivers/char/tpm/tpm-interface.c
> index 02e8cffd1163..fcd845ad8c3c 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -124,6 +124,8 @@ static ssize_t tpm_try_transmit(struct tpm_chip 
> *chip, void *buf, size_t bufsiz)
>           dev_err(&chip->dev, "tpm_transmit: tpm_recv: error %d\n", rc);
>       } else if (len < TPM_HEADER_SIZE || len != 
> be32_to_cpu(header->length))
>           rc = -EFAULT;
> +    else
> +        rc = 0;
> 
>       return rc ? rc : len;
>   }

Applying those changes fixes all the issues I saw, thanks. I'll retest 
Jarkko's tree without custom patches, once you've agreed on the rc question.

Alexander
