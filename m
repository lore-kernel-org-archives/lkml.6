Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D878C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBDDC20899
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="gnW/vLRS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBDDC20899
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753639AbeGDNS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:18:56 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:56312 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753610AbeGDNSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:18:53 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 910BC5C07A2;
        Wed,  4 Jul 2018 15:18:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1530710331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KOhqLpxD8+Zx+AniXF/gC4iFw7dxGYb1ytGmhsRqA1A=;
        b=gnW/vLRSeVIM6GnEZnEZtutRchILy2JczREL6dgf2mTrpzFSPAr82dxbKdKzls+AwE3q4p
        5nOzmutYur40MXEeTFy2OP4HOnw+M7MgggyrsligzralCuIPzI65j0AXNWVyW5agc82jtA
        +7lJZaSa6bn3+DCrkcYW+iELP5k5r7Y=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Wed, 04 Jul 2018 15:18:51 +0200
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
In-Reply-To: <CAPDyKFrDMmMu1kuJdPDyyGKu6b0dR2MF2U4Rnb4hoHAcwNYtuw@mail.gmail.com>
References: <20180628081331.13051-1-stefan@agner.ch>
 <20180628081331.13051-3-stefan@agner.ch>
 <CAPDyKFqPaRRuXdSD50q=et-OvJ=emdbq-XWyeddkiuC5SjuLig@mail.gmail.com>
 <76c619e6267c5f0adfda80d0fdba3c6b@agner.ch>
 <CAPDyKFrjSadT0T2+zWhpq-E5kS1bm01y4R+LfyHyhjFBuK_hLQ@mail.gmail.com>
 <ffea342896629cf57b78661b04f60eda@agner.ch>
 <CAPDyKFrDMmMu1kuJdPDyyGKu6b0dR2MF2U4Rnb4hoHAcwNYtuw@mail.gmail.com>
Message-ID: <6cf2fd635bc65de33edcdf401b035a67@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-0.30 / 15.00];
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
         BAYES_HAM(-0.20)[71.15%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.07.2018 13:16, Ulf Hansson wrote:
> On 4 July 2018 at 12:55, Stefan Agner <stefan@agner.ch> wrote:
>> On 04.07.2018 12:07, Ulf Hansson wrote:
>>> On 3 July 2018 at 10:48, Stefan Agner <stefan@agner.ch> wrote:
>>>> On 02.07.2018 16:36, Ulf Hansson wrote:
>>>>> On 28 June 2018 at 10:13, Stefan Agner <stefan@agner.ch> wrote:
>>>>>> Some hosts are capable of running higher speed modes but do not
>>>>>> have the board support for it. Introduce a quirk which prevents
>>>>>> the stack from using modes running at 100MHz or faster.
>>>>>
>>>>> To cap the freq, use the DT property "max-frequency". To enable
>>>>> certain speed modes, use the corresponding speed mode binding. For
>>>>> example "sd-uhs-sdr*" and "mmc-hs200*".
>>>>> Documented in Documentation/devicetree/bindings/mmc/mmc.txt
>>>>
>>>> I had bad experience with max-frequency: Some higher speed modes seem
>>>> not to work reliably if constraint to low frequencies. E.g. we had lots
>>>> of devices fail in practise with HS400@100MHz... So it is doing what it
>>>> should, but it just seems that higher speed modes do not necessarily run
>>>> well with lower frequencies...
>>>>
>>>> So I'd rather prefer to limit speed modes as it is done right now.
>>>>
>>>>>
>>>>> In case the sdhci cap register, doesn't reflect the board support
>>>>> properly, such that you may want to disable some speed modes, then you
>>>>> may benefit from using the DT properties "sdhci-caps*.
>>>>> Documented in Documentation/devicetree/bindings/mmc/sdhci.txt
>>>>
>>>> Hm, yeah I guess something like
>>>>
>>>> sdhci-caps-mask =  /bits/ 64 <((SDHCI_SUPPORT_SDR104 |
>>>> SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_DDR50) << 32)>
>>>>
>>>> would come close.
>>>>
>>>> But it does not restrict MMC modes such as HS200/HS400. There seem to be
>>>> no mmc-caps...
>>>
>>> Right.
>>>
>>> The solution to fix this, should be to *not* set those DT properties,
>>> like "mmc-hs*" for example. That should work, no?
>>>
>>
>> The controller does not make use of the dt modes so far, so I can't not
>> set those properties...
> 
> Then where are the corresponding caps for the eMMC speed modes being set?
> 
> Can't you just avoid setting them?
> 

That was the right question:

On closer look, the higher speed MMC modes are actually not set at all!

So just using sdhci-caps-mask = <0x7 0x0>; (which masks
SDR104/SDR50/DDR50) is doing the job as far as I can tell.

>>
>>>>
>>>>
>>>> My aim is to replace the SDHCI_QUIRK2_NO_1_8_V fix, which does not
>>>> restrict modes correctly. Currently the driver checks whether >=100MHz
>>>> pinctrl settings are available, and if not uses the quirk to restrict
>>>> higher speed modes. Removing that would break device tree backward
>>>> compatibility...
>>>
>>> Looks like the problem is not really SDHCI_QUIRK2_NO_1_8_V, but rather
>>> how the pinctrl setting becomes interpreted when setting the quirk.
>>>
>>
>> Yes, sorry for the confusion. SDHCI_QUIRK2_NO_1_8_V is fine, it is just
>> not the quirk this driver needs.
>>
>> I argue that commit ad93220de7da ("mmc: sdhci-esdhc-imx: change pinctrl
>> state according to uhs mode") chose the wrong quirk from the
>> beginning...
> 
> That's seems reasonable! But it's been there since 3.13, so I guess we
> have to think about backwards compatibility issues, as you stated.
> 

It seems that the driver already fakes
SDHCI_CAPABILITIES/SDHCI_CAPABILITIES_1 in esdhc_readl_le, so instead
using the sdhci-caps-mask we could implement the work around there. Not
very clean, but backward compatible and everything self contained in the
driver.

--
Stefan

>>
>> Afaict, the quirk needed here does not exist.
> 
> [...]
> 
> Kind regards
> Uffe
