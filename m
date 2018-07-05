Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9FDC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC73219CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="FHD/bwx+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDC73219CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754215AbeGEO06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:26:58 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:40060 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753614AbeGEO0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:26:55 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 01DA85C0744;
        Thu,  5 Jul 2018 16:26:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1530800814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+E5xAwdG2dAEnzMr7Li5NgT2Rje4/Gdx3bw6xI85E3c=;
        b=FHD/bwx+yp1BPZgmGfeuVXixxKCHpn/evr9jD6VhGr/6zZHOiC4O4zGBv20d/ebSuwWx1x
        cmHlpLs010iHAB5cZFkZkhuHbqEzCzYumguIbpy+CuAn0K+uE8PuK5az87q8xab76Idpjg
        IGQbX0SXr0+AU2QBEAZpu6GR3VGJGfE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Thu, 05 Jul 2018 16:26:54 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, marcel@ziswiler.com,
        linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: disable clocks before changing
 frequency
In-Reply-To: <CAPDyKFrHH2Hm+Z1DgJiSunFwaC_yed_oVp82Y0dw7UMAhAq3+w@mail.gmail.com>
References: <20180705121500.6256-1-stefan@agner.ch>
 <CAPDyKFrHH2Hm+Z1DgJiSunFwaC_yed_oVp82Y0dw7UMAhAq3+w@mail.gmail.com>
Message-ID: <7c2e40400de27f7887500f1ccf41db18@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-2.29 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         RCPT_COUNT_FIVE(0.00)[5];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-2.19)[96.16%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.07.2018 15:09, Ulf Hansson wrote:
> On 5 July 2018 at 14:15, Stefan Agner <stefan@agner.ch> wrote:
>> In the uSDHC case (e.g. i.MX 6) clocks only get disabled if frequency
>> is set to 0. However, it could be that the stack asks for a frequency
>> change while clocks are on. In that case the function clears the
>> divider registers (by clearing ESDHC_CLOCK_MASK) while the clock is
>> enabled! This causes a short period of time where the clock is
>> undivided (on a i.MX 6DL a clock of 196MHz has been measured).
>>
>> For older IP variants the driver disables clock by clearing some bits
>> in ESDHC_SYSTEM_CONTROL.
>>
>> Make sure to disable card clock before chainging frequency for uSDHC
>> IP variants too. Also fix indent to make disable/enable clock look
>> alike.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
> 
> Thanks, applied for next!
> 
> Please tell if you want this for fixes and if I should add a stable tag.

I haven't seen any direct negative impact by that, so I don't think its
worth back-porting at this point.

--
Stefan

> 
> Kind regards
> Uffe
> 
>> ---
>>  drivers/mmc/host/sdhci-esdhc-imx.c | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
>> index 85fd5a8b0b6d..aa48f4b2541a 100644
>> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>> @@ -708,14 +708,14 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
>>         int div = 1;
>>         u32 temp, val;
>>
>> +       if (esdhc_is_usdhc(imx_data)) {
>> +               val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
>> +               writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
>> +                       host->ioaddr + ESDHC_VENDOR_SPEC);
>> +       }
>> +
>>         if (clock == 0) {
>>                 host->mmc->actual_clock = 0;
>> -
>> -               if (esdhc_is_usdhc(imx_data)) {
>> -                       val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
>> -                       writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
>> -                                       host->ioaddr + ESDHC_VENDOR_SPEC);
>> -               }
>>                 return;
>>         }
>>
>> @@ -761,7 +761,7 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
>>         if (esdhc_is_usdhc(imx_data)) {
>>                 val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
>>                 writel(val | ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
>> -               host->ioaddr + ESDHC_VENDOR_SPEC);
>> +                       host->ioaddr + ESDHC_VENDOR_SPEC);
>>         }
>>
>>         mdelay(1);
>> --
>> 2.18.0
>>
