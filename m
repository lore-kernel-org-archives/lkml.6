Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31882C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D912A21A15
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="AEclGKMn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D912A21A15
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732958AbeHFXL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 19:11:56 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:59604 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728948AbeHFXL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 19:11:56 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 103A55C045D;
        Mon,  6 Aug 2018 23:01:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1533589263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qw3Q87xwyHz4jt/sLC52qM9VLVGRlmfoHzjFPVP6b6E=;
        b=AEclGKMnmiIguEkVr/AiM+163ARO/QGcSMYkWv6ZxwXhWhbOnRrORymrTUGAOQP7/X5ofn
        oDOmMSTYITfk6lVrJQE2XE735YQUwW5zvSGHvenmCG6PcU/8yRA/A33fh8vgaJo7d9efS8
        wVOE/ixJUeBnhi9QCBgZ4iZ+/72h0/g=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Mon, 06 Aug 2018 23:01:03 +0200
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
In-Reply-To: <2282091.6Fec9mOu3z@dimapc>
References: <20180802111144.12512-1-digetx@gmail.com>
 <2738202.Xfnp0pFbCN@dimapc> <e60cd1f07f7c7515c117fa3446914c7f@agner.ch>
 <2282091.6Fec9mOu3z@dimapc>
Message-ID: <d5f15ea80f5cf967df247579aa4ffd7a@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.08.2018 15:38, Dmitry Osipenko wrote:
> On Monday, 6 August 2018 16:03:01 MSK Stefan Agner wrote:
>> On 04.08.2018 16:01, Dmitry Osipenko wrote:
>> > On Friday, 3 August 2018 20:24:56 MSK Linus Walleij wrote:
>> >> On Thu, Aug 2, 2018 at 1:31 PM Stefan Agner <stefan@agner.ch> wrote:
>> >> > A while back at least using those init lists were not well received
>> >> > even
>> >> > for GPIO/pinctrl drivers:
>> >> >
>> >> > https://lore.kernel.org/lkml/CACRpkdYk0zW12qNXgOstTLmdVDYacu0Un+8quTN+J
>> >> > _az
>> >> > Oic7AA@mail.gmail.com/T/#mf0596982324a6489b5537b0531ac5aed60a316ba
>> >>
>> >> You shouldn't listen too much to that guy he's not trustworthy.
>>
>> ;-)
>>
>> >> > I still think we should make an exception for GPIO/pinctrl and use
>> >> > earlier initcalls. Platform GPIO/pinctrl drivers provide basic
>> >> > infrastructure often used by many other drivers, we want to have them
>> >> > loaded early. It avoids unnecessary EPROBE_DEFER and hence probably
>> >> > even
>> >> > boots faster.
>> >>
>> >> When we have the pin control and GPIO at different initlevels it makes me
>> >> uneasy because I feel we have implicit init dependencies that seem more
>> >> than a little fragile.
>> >
>> > Yes, it is not very good.
>>
>> Btw, just noticed this now:
>> GPIO driver -> arch_initcall
>> pinctrl driver -> subsys_initcall
> 
> I'm not sure what you're talking about, it's the other way around in the 
> patches.

Wow, yeah sorry... That must be the heat in our office ':-)

--
Stefan
