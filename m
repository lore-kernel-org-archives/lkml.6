Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388FEC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF24E20849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="MGw0v0/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF24E20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbeLMLm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 06:42:29 -0500
Received: from mail.micronovasrl.com ([212.103.203.10]:60154 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbeLMLm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 06:42:28 -0500
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id 9B6C0B01A1C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 12:42:27 +0100 (CET)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:user-agent:date:date
        :message-id:from:from:references:to:subject:subject; s=dkim; t=
        1544701346; x=1545565347; bh=kgZqYC9vikjAoU9wQs5xBoiKv1EX/ne2dvN
        mwNodLs4=; b=MGw0v0/nSnFcY8rG8N8gGx76SkKh6FGcg52xU6AjIQW864UJUBB
        0+MwSUQ4jyQfYzM076ztKMLDeABsbv4u2SI1/lJzVCKARdag0a17ggXVGUXw/7bB
        IGTvKyQUzpiSGWmv6+QrtPbcmhvYuIX98kTsSN9ScBQtQ6AAFA0c7/P4=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id n3XSlh4m0vQb for <linux-kernel@vger.kernel.org>;
        Thu, 13 Dec 2018 12:42:26 +0100 (CET)
Received: from [192.168.178.33] (host180-21-dynamic.5-87-r.retail.telecomitalia.it [87.5.21.180])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id 6480DB002CF;
        Thu, 13 Dec 2018 12:42:25 +0100 (CET)
Subject: Re: [PATCH] drm/sun4i: fix HSYNC and VSYNC polarity
To:     Jonathan Liu <net147@gmail.com>
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1518717288-123578-1-git-send-email-giulio.benetti@micronovasrl.com>
 <CANwerB3Zr9axz+1rwCnNpLsX-xcOhOKEY4MT53v1+vzd99KRMg@mail.gmail.com>
 <57d929cf-4458-dae4-36d4-4e89170eba4a@micronovasrl.com>
 <CANwerB1aUP4Rw-B_qmzOu0BWmkpr-LQ5b4FKQbzZeeYHPtGoqA@mail.gmail.com>
 <05786c98-6bc9-44f1-91ea-14452448cced@micronovasrl.com>
 <e3307630-7ae7-2bd4-4933-a31419a0cc3a@micronovasrl.com>
 <CANwerB2GGLT6fOZk7Q8RXhmiEb7KYnQrx-Rj5AgGn-YPCiMH4g@mail.gmail.com>
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <cf5ac5cc-3696-a4fc-ae64-4f0304ab7df3@micronovasrl.com>
Date:   Thu, 13 Dec 2018 12:42:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CANwerB2GGLT6fOZk7Q8RXhmiEb7KYnQrx-Rj5AgGn-YPCiMH4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

Il 13/12/2018 03:55, Jonathan Liu ha scritto:
>> Can you precisely point me the sources of:
>> - u-boot
>> - kernel
>> - dts
>>
>> you're using?
>>
>> Thanks
> 
> U-Boot - git tag v2017.03
> Linux - git tag v4.19.6
> DTS - see device tree changes in
> https://github.com/net147/linux/tree/sun7i-drm-wip but change the
> compatible to "innolux,at070tn92"

With Linux v4.19.6 "innolux,at070tn92" doesn't even work and I suspect 
it is because of clock frequency tolerance check for pll setting, so it 
gets discarded from drm resulting in not having a crtc.

Anyway I've just re-checked the signals using another display:
"innolux,at043tn24" that has a more rounded clock frequency, so it's 
accepted by drm and **signals are correct**.
Unfortunately I don't have your same display here to test, so I can't 
help you about that precise panel.

Sorry.
Best regards
-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale € 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
