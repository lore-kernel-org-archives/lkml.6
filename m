Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA3CC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E5B219CB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="b99iZZz3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26E5B219CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732327AbeHFPME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:12:04 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:54788 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbeHFPME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:12:04 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 31BFB5C05A2;
        Mon,  6 Aug 2018 15:03:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1533560581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BaVLRCSdY5vRmupC116BnQPio1JUDtggAKLb27LmI14=;
        b=b99iZZz3m8cly754gIzfFHRUqHpj4mlS9cClGwxiWY/07qqyFfjZ6I24OIhUuLZScnO/Y9
        qk05tYcUww7xjKW/Qxm+ZaalUrywKdVfgP3GnsLcDl8G1/e5JzAeKL3wD0ReTKjwvu9feE
        RfvTav7wMDICy27QZDWXN0pSb8eidfw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Mon, 06 Aug 2018 15:03:01 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>, thierry.reding@gmail.com,
        Jon Hunter <jonathanh@nvidia.com>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        linux-tegra@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] pinctrl: tegra: Move drivers registration to
 arch_init level
In-Reply-To: <2738202.Xfnp0pFbCN@dimapc>
References: <20180802111144.12512-1-digetx@gmail.com>
 <20a52a0461e32e776e526171c250551a@agner.ch>
 <CACRpkda+t=0aJMSKre+U-GHN2d47pV3b_g13PcinXScP_UX5Ng@mail.gmail.com>
 <2738202.Xfnp0pFbCN@dimapc>
Message-ID: <e60cd1f07f7c7515c117fa3446914c7f@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.08.2018 16:01, Dmitry Osipenko wrote:
> On Friday, 3 August 2018 20:24:56 MSK Linus Walleij wrote:
>> On Thu, Aug 2, 2018 at 1:31 PM Stefan Agner <stefan@agner.ch> wrote:
>> > A while back at least using those init lists were not well received even
>> > for GPIO/pinctrl drivers:
>> >
>> > https://lore.kernel.org/lkml/CACRpkdYk0zW12qNXgOstTLmdVDYacu0Un+8quTN+J_az
>> > Oic7AA@mail.gmail.com/T/#mf0596982324a6489b5537b0531ac5aed60a316ba
>> You shouldn't listen too much to that guy he's not trustworthy.

;-)

>>
>> > I still think we should make an exception for GPIO/pinctrl and use
>> > earlier initcalls. Platform GPIO/pinctrl drivers provide basic
>> > infrastructure often used by many other drivers, we want to have them
>> > loaded early. It avoids unnecessary EPROBE_DEFER and hence probably even
>> > boots faster.
>>
>> When we have the pin control and GPIO at different initlevels it makes me
>> uneasy because I feel we have implicit init dependencies that seem more
>> than a little fragile.
> 
> Yes, it is not very good.
> 

Btw, just noticed this now:
GPIO driver -> arch_initcall
pinctrl driver -> subsys_initcall

And arch is before subsys. So we initialize GPIO driver first? But isn't
pinctrl required for the GPIO range?

Afaik, especially with gpio-ranges enabled, the GPIO probe will return
-EPROBE_DEFER (I think due to pinctrl_get_device_gpio_range).

So my intuition would be that it should be the other way around...

--
Stefan

>> My recent thinking has involved the component method used in DRM drivers
>> such as drivers/gpu/drm/vc4/vc4_drv.c where a few different component
>> subdrivers are linked together at bind time (not probe time!) into a master
>> component.
>> Rob was no big fan of this but the DRM people like it and I was thinking to
>> make a try at it.
>>
>> This way we could at least probe and bind the pin control and GPIO drivers
>> at the *same* initlevel and express the dependencies between them
>> somewhat.
> 
> Sounds interesting, maybe you could help to convert Tegra drivers to a such 
> method and others will follow afterwards.
> 
>> > This should definitely go in, at least as a stop gap solution.
>>
>> Agreed. (And patch applied.)
> 
> The best solution will be to fix the deferred probing, it's awkward that it 
> could break suspend-resume order. Hopefully somebody with a good knowledge of 
> driver/base will manage to fix it eventually.
