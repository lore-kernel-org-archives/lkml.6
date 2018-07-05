Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4907DC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0101E24048
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="lGEeMn58"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0101E24048
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753999AbeGELnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:43:50 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:38476 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753848AbeGELns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:43:48 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 476835C16B5;
        Thu,  5 Jul 2018 13:43:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1530791027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VyopVX8tcOCX1GCLUUrigB0jzRVuz1Ro2KwZ6t7W3l0=;
        b=lGEeMn58QBUO8B+HN2h7RWmkYlc5kV6I9jxX6sMVQDoeg3IfjLtYPMQRdF6xryOHY4Fn9y
        5kRI1BiOH5le2YoEjLoqk4Couux0o5JxUP8JmlRUiyS7kKX1HP+hm9p8uDiWdCvuxSfFT2
        bZsK9SlMFuiyM+khmRT3thvecBfcXFg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Thu, 05 Jul 2018 13:43:47 +0200
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
Subject: Re: [PATCH v2] mmc: sdhci-esdhc-imx: allow 1.8V modes without
 100/200MHz pinctrl states
In-Reply-To: <CAPDyKFovmZxR=Bv0rogas+RTkzkSwbcyRyu1pD4m0LYvExbY8A@mail.gmail.com>
References: <20180704150745.21003-1-stefan@agner.ch>
 <CAPDyKFovmZxR=Bv0rogas+RTkzkSwbcyRyu1pD4m0LYvExbY8A@mail.gmail.com>
Message-ID: <a0c658d298aa8254b0ceb514793608ae@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-0.10 / 15.00];
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
         BAYES_HAM(-0.00)[38.09%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.07.2018 13:23, Ulf Hansson wrote:
> On 4 July 2018 at 17:07, Stefan Agner <stefan@agner.ch> wrote:
>> If pinctrl nodes for 100/200MHz are missing, the controller should
>> not select any mode which need signal frequencies 100MHz or higher.
>> To prevent such speed modes the driver currently uses the quirk flag
>> SDHCI_QUIRK2_NO_1_8_V. This works nicely for SD cards since 1.8V
>> signaling is required for all faster modes and slower modes use 3.3V
>> signaling only.
>>
>> However, there are eMMC modes which use 1.8V signaling and run below
>> 100MHz, e.g. DDR52 at 1.8V. With using SDHCI_QUIRK2_NO_1_8_V this
>> mode is prevented. When using a fixed 1.8V regulator as vqmmc-supply
>> the stack has no valid mode to use. In this tenuous situation the
>> kernel continuously prints voltage switching errors:
>>   mmc1: Switching to 3.3V signalling voltage failed
>>
>> Avoid using SDHCI_QUIRK2_NO_1_8_V and prevent faster modes by
>> altering the SDHCI capability register. With that the stack is able
>> to select 1.8V modes even if no faster pinctrl states are available:
>>   # cat /sys/kernel/debug/mmc1/ios
>>   ...
>>   timing spec:    8 (mmc DDR52)
>>   signal voltage: 1 (1.80 V)
>>   ...
>>
>> Link: http://lkml.kernel.org/r/20180628081331.13051-1-stefan@agner.ch
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
> 
> I am fine with this. Do you want me to apply this for now, to get it tested?
> 

Yes.

> I guess its also material for stable and as fix?
> 

I guess. We probably want to wait until it gets some more testing?

> In regards to the printed warning, it sounds to me like a different
> issue, which we can solve on top. Right?

Yes different issue, which we can handle separately.

--
Stefan
