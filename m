Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78991C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23BC22199D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="jBCFq4FW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23BC22199D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933056AbeGCIsZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:48:25 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:40996 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754218AbeGCIsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:48:22 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id D958F5C0C47;
        Tue,  3 Jul 2018 10:48:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1530607700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uKm+hxPH3mbZJohEA4rM+tTZkc4RoRNx7IlQvxRRGT0=;
        b=jBCFq4FW5getMFWGNoK33Ai3Ery8q+i1C9UnUzV97ZuId/MhX7Q/yF3DHtNGddV9+KiAla
        aQo5GivY6uoWcxH76bxEkDXV2b5lSd8Evvy9q8hUIB3z3S20DO78gqTr28yd8mHMLkH3f/
        BoIMrDq4FZJe/w9uI7prifOrQfG/p/I=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Tue, 03 Jul 2018 10:48:19 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] mmc: sdhci: add quirk to prevent higher speed modes
In-Reply-To: <CAPDyKFqPaRRuXdSD50q=et-OvJ=emdbq-XWyeddkiuC5SjuLig@mail.gmail.com>
References: <20180628081331.13051-1-stefan@agner.ch>
 <20180628081331.13051-3-stefan@agner.ch>
 <CAPDyKFqPaRRuXdSD50q=et-OvJ=emdbq-XWyeddkiuC5SjuLig@mail.gmail.com>
Message-ID: <76c619e6267c5f0adfda80d0fdba3c6b@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-2.93 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         TAGGED_RCPT(0.00)[kernel];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[9];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-2.83)[99.26%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.07.2018 16:36, Ulf Hansson wrote:
> On 28 June 2018 at 10:13, Stefan Agner <stefan@agner.ch> wrote:
>> Some hosts are capable of running higher speed modes but do not
>> have the board support for it. Introduce a quirk which prevents
>> the stack from using modes running at 100MHz or faster.
> 
> To cap the freq, use the DT property "max-frequency". To enable
> certain speed modes, use the corresponding speed mode binding. For
> example "sd-uhs-sdr*" and "mmc-hs200*".
> Documented in Documentation/devicetree/bindings/mmc/mmc.txt

I had bad experience with max-frequency: Some higher speed modes seem
not to work reliably if constraint to low frequencies. E.g. we had lots
of devices fail in practise with HS400@100MHz... So it is doing what it
should, but it just seems that higher speed modes do not necessarily run
well with lower frequencies...

So I'd rather prefer to limit speed modes as it is done right now.

> 
> In case the sdhci cap register, doesn't reflect the board support
> properly, such that you may want to disable some speed modes, then you
> may benefit from using the DT properties "sdhci-caps*.
> Documented in Documentation/devicetree/bindings/mmc/sdhci.txt

Hm, yeah I guess something like

sdhci-caps-mask =  /bits/ 64 <((SDHCI_SUPPORT_SDR104 |
SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_DDR50) << 32)>

would come close.

But it does not restrict MMC modes such as HS200/HS400. There seem to be
no mmc-caps...


My aim is to replace the SDHCI_QUIRK2_NO_1_8_V fix, which does not
restrict modes correctly. Currently the driver checks whether >=100MHz
pinctrl settings are available, and if not uses the quirk to restrict
higher speed modes. Removing that would break device tree backward
compatibility... 

We probably could do something like this:
if (!100mhzpinctrl) {
     if (!sdhci-caps) {
          /*
           * If no 100MHz/200MHz pinctrl are available, SDHC caps should
be used to restrict 
           * modes. Falling back to old behavior...
           */
         pr_warn(...)
         host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
     }
}


--
Stefan

> 
> Kind regards
> Uffe
> 
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  drivers/mmc/host/sdhci.c | 8 ++++++++
>>  drivers/mmc/host/sdhci.h | 2 ++
>>  2 files changed, 10 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 1c828e0e9905..8ac257dfaab3 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -3749,6 +3749,14 @@ int sdhci_setup_host(struct sdhci_host *host)
>>                 }
>>         }
>>
>> +       if (host->quirks2 & SDHCI_QUIRK2_NO_UHS_HS200_HS400) {
>> +               host->caps1 &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
>> +                                SDHCI_SUPPORT_DDR50);
>> +
>> +               mmc->caps2 &= ~(MMC_CAP2_HSX00_1_8V | MMC_CAP2_HSX00_1_2V |
>> +                               MMC_CAP2_HS400_ES);
>> +       }
>> +
>>         if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V) {
>>                 host->caps1 &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
>>                                  SDHCI_SUPPORT_DDR50);
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index 23966f887da6..cb2433d6d61f 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -450,6 +450,8 @@ struct sdhci_host {
>>   * obtainable timeout.
>>   */
>>  #define SDHCI_QUIRK2_DISABLE_HW_TIMEOUT                        (1<<17)
>> +/* Do not support any higher speeds (>50MHz) */
>> +#define SDHCI_QUIRK2_NO_UHS_HS200_HS400                        (1<<18)
>>
>>         int irq;                /* Device IRQ */
>>         void __iomem *ioaddr;   /* Mapped address */
>> --
>> 2.18.0
>>
