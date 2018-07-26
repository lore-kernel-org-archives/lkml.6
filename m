Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDB4C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C631D20673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="ZAz/PVAN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C631D20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbeGZQE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 12:04:27 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:57202 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730030AbeGZQE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 12:04:27 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id C106F5C1E35;
        Thu, 26 Jul 2018 16:47:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1532616433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wSz4edBz0AYboyPCJnEklOAvMvnCCmur9Hs02wTpqCI=;
        b=ZAz/PVANIVQnwFpK3ONHdo13e9V6+a8n7n3/EcUv2fk8Fq70AfM/MiMF8wFaGQZeVnK1Yc
        t5nasHu6VCsfqrOvqcGUCigMBjdNnxhAGbvFzqt/SBOY5WGGkzYBo9zcbzO8OzAbs+Pv6I
        eN/UJgnXrPQISYn2QzFYD11G10B1Ed0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Thu, 26 Jul 2018 16:47:12 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        marcel.ziswiler@toradex.com, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mmc: tegra: prevent ACMD23 on Tegra 3
In-Reply-To: <430c718d-9ede-d47a-44c0-b8e47e297720@gmail.com>
References: <20180712073904.4705-1-stefan@agner.ch>
 <20180712073904.4705-3-stefan@agner.ch>
 <430c718d-9ede-d47a-44c0-b8e47e297720@gmail.com>
Message-ID: <1553c44e99b96a813af129d1c4169222@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-0.11 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[9];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.01)[48.63%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.07.2018 15:56, Peter Geis wrote:
> On 07/12/2018 03:39 AM, Stefan Agner wrote:
>> It seems that SD3.0 advertisement needs to be set for higher eMMC
>> speed modes (namely DDR52) as well. The TRM states that the SD3.0
>> advertisement bit should be set for all controller instances, even
>> for those not supporting UHS-I mode...
>>
>> When specifying vqmmc-supply as a fixed 1.8V regulator on a Tegra
>> SD/MMC instance which is connected to a eMMC device, the stack
>> enables SD3.0. However, enabling it has consequences: If SDHCI 3.0
>> support is advertised the stack enables Auto-CMD23. Unfortunately
>> Auto-CMD23 seems not to work well with Tegra 3 currently. It leads
>> to regular warnings:
>>    mmc2: Got command interrupt 0x00010000 even though no command operation was in progress.
>>
>> It is not entirely clear why those errors happens. It seems that
>> a Linux 3.1 based downstream kernel which has Auto-CMD23 support
>> does not show those warnings.
>>
>> Use quirk SDHCI_QUIRK2_ACMD23_BROKEN to prevent Auto-CMD23 being
>> used for now. With this the eMMC works stable on high-speed mode
>> while still announcing SD3.0.
>>
>> This allows to use mmc-ddr-1_8v to enables DDR52 mode. In DDR52
>> mode read speed improves from about 42MiB/s to 72MiB/s on an
>> Apalis T30.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>   drivers/mmc/host/sdhci-tegra.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
>> index 888a1ad511db..11c0b2069c7c 100644
>> --- a/drivers/mmc/host/sdhci-tegra.c
>> +++ b/drivers/mmc/host/sdhci-tegra.c
>> @@ -336,7 +336,15 @@ static const struct sdhci_pltfm_data sdhci_tegra30_pdata = {
>>   		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
>>   		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
>>   	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
>> -		   SDHCI_QUIRK2_BROKEN_HS200,
>> +		   SDHCI_QUIRK2_BROKEN_HS200 |
>> +		   /*
>> +		    * Auto-CMD23 leads to "Got command interrupt 0x00010000 even
>> +		    * though no command operation was in progress."
>> +		    *
>> +		    * The exact reason is unknown, as the same hardware seems
>> +		    * to support Auto CMD23 on a downstream 3.1 kernel.
>> +		    */
>> +		   SDHCI_QUIRK2_ACMD23_BROKEN,
>>   	.ops  = &tegra_sdhci_ops,
>>   };
>>
> 
> I finally got around to testing this on the Ouya (Tegra 3).

Thanks for testing!

> 
> I found that the "Got command interrupt 0x00010000 even though no
> command operation was in progress." error occurred when the interface
> is unstable.
> I've had a lot of problems with sdmmc4 stability on the Ouya above 34
> Mhz, probably due to the fact that they are using the internal cmd and
> clock pull-up resistors, against the TRM's instruction.
> At 39Mhz, I saw the error this patch corrects.
> With the patch, the error went away, but the interface is still
> unstable under load.

How does this instability manifest exactly?

> 
> Lowering down to 32Mhz, without the patch there are no errors.

So the patch does not make it less stable right?

--
Stefan
