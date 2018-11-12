Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B625C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B836322504
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpP95+uH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B836322504
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730442AbeKMGdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 01:33:33 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36781 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeKMGdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 01:33:33 -0500
Received: by mail-wm1-f65.google.com with SMTP id s11so36664wmh.1;
        Mon, 12 Nov 2018 12:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y3UxzJ9Et54vuLiTQFY03dDdYROSmU05QRg2B5+IVHk=;
        b=KpP95+uHfznvEhDkb5+IdcuG+lpFGVaeFklII1mM+PkKPpjOCsTYuQyRJUtzy4fiHi
         yy+656G8T0z9vzXmW9EKgJqoEiyAeXLfrSHjzCOanlUdBplUuSZmH/bW0hu2OseOk1pO
         2mCOK6EMAnwiHq5I7TsxoirZ7Z/L5JJB0HY4bU3Hjgjas8i3/R/7YVkOwFX009yEK9OX
         Gt4WjqHeL9Qgi+tHM1WuRcxlwbCea3pi4K7Uhl0LDeP0gShsvLG2EQx/WMYM6JWg3kEX
         7jRfDUghYPqbglIg4UAYQ98LmWjA2svO02EPEapSGWP/iXV2NnUCPzSde5kenekNTNNb
         upBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y3UxzJ9Et54vuLiTQFY03dDdYROSmU05QRg2B5+IVHk=;
        b=d1vM7Tp5vtYEQHZjSuqMTA72LfV7w2Zts74PRk3YE8hLz9/AU6KrMLSG3x7sbiuUIl
         iXK5D2BwjQyj/IPwzXgueDKXU3j0SC8nq56/3XDc9KvBhKjFc4CxVMS7RdY4Exmv0nuN
         zuFBwIf50GvhFMDbZN0FtqmBurYimjWj50VupIdvwiLKF4kMsysPcKA2pnrHdZPoWjqf
         lSNgEW9fh/xjMR/kPT7e42FipBQ8q5x4XztkPLF1c5L9137bsX6V1CUv00RQsIcdpupB
         /wSQwA7gE93/xWgqiLbKh/qlDgRATBw2YDuWSrPbvbJE+S/lMgfP9WQWKtA66oPfo6aB
         iYqw==
X-Gm-Message-State: AGRZ1gIlsX1l7uJfr+vQOUgXE97mpsy7bRC7CoECbtagIve709Xl+sSR
        8ZhyE0U8nuUpjeRG+2A7Beg=
X-Google-Smtp-Source: AJdET5dl/orp4LUnMf4eamEmG8h46JYu1Pn5YsThMJRnqgaXwnHFD3awl7u2kpmV/syl8VidX89Aog==
X-Received: by 2002:a1c:c46:: with SMTP id 67-v6mr969684wmm.6.1542055118792;
        Mon, 12 Nov 2018 12:38:38 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:b49e:56b0:fb3c:b53? (p200300EA8BCFE300B49E56B0FB3C0B53.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:b49e:56b0:fb3c:b53])
        by smtp.googlemail.com with ESMTPSA id s16sm1055528wrt.77.2018.11.12.12.38.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 12:38:38 -0800 (PST)
Subject: Re: [PATCH net-next v3 1/2] net: phy: replace PHY_HAS_INTERRUPT with
 a check for config_intr and ack_interrupt
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     f.fainelli@gmail.com, andrew@lunn.ch, netdev@vger.kernel.org,
        richardcochran@gmail.com, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, khilman@baylibre.com,
        carlo@caione.org, linux-amlogic@lists.infradead.org,
        davem@davemloft.net, linux-arm-kernel@lists.infradead.org
References: <203c4d9e-f39a-7a08-46c3-4ee6e61f181e@gmail.com>
 <fd9674b3-4033-95c6-a93e-10c8b5ba2e6a@gmail.com>
 <20181109201307.GV5259@lunn.ch>
 <44b503b8-9f2a-50ac-c4c9-d25258d98ef5@gmail.com>
 <4330cb5b-b1a5-5004-af51-39199943639d@gmail.com>
 <c067d321-c69e-706d-304a-04e1e477b47c@gmail.com>
 <CAFBinCCmNYGp8kzy45ojjr27tEaPVs-QwMsLRrfXHCvw_taDOw@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <b6f0c1bb-9c0b-a02a-1571-b2804fcbcaa1@gmail.com>
Date:   Mon, 12 Nov 2018 21:38:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCCmNYGp8kzy45ojjr27tEaPVs-QwMsLRrfXHCvw_taDOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.11.2018 21:32, Martin Blumenstingl wrote:
> Hi Heiner,
> 
> On Fri, Nov 9, 2018 at 9:56 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> On 09.11.2018 21:33, Florian Fainelli wrote:
>>> On 11/9/18 12:22 PM, Heiner Kallweit wrote:
>>>> On 09.11.2018 21:13, Andrew Lunn wrote:
>>>>> Hi Heiner
>>>>>
>>>>>> +static bool phy_drv_supports_irq(struct phy_driver *phydrv)
>>>>>> +{
>>>>>> +  return phydrv->config_intr || phydrv->ack_interrupt;
>>>>>> +}
>>>>>
>>>>> Should this be && not || ? I thought both needed to be provided for
>>>>> interrupts to work.
>>>>>
>>>>>        Andrew
>>>>>
>>>> I've seen at least one driver which configures interrupts in
>>>> config_init and doesn't define a config_intr callback
>>>> (ack_interrupt callback is there)
>>>
>>> That driver should probably be fixed, while it most likely does not make
>>> any significant difference during probe/connect, since config_init() and
>>> config_intr() are virtually happening at the same time, this is not
>>> necessarily true when disconnecting from the PHY where we really want
>>> config_intr() to effectively disable the interrupts and not leaving
>>> something enabled that would now become unmaskable, because no more
>>> driver attached.
>>>
>> Found the driver: It's the IP101A/G in icplus.c
>> It should be easy to fix the behavior and move the interrupt config
>> to a config_intr callback. But the last real changes to the driver
>> have been done 6 years ago, so I'm not sure there's anybody out
>> there who can test.
> if you want I can take care of the IP101A/G code.
> I have at least one board with an IP101A/G (PHY ID: 0x02430c54,
> according to the schematics it's an IP101GR-GP) where the interrupt is
> routed to the SoC.
> 
> please let me know whether you'd like to work on it or if I should
> give it a try.
> 
I made the change already based on the datasheet of IP101A LF which
is supposed to be register-compatible with IP101A/G.
The patch is not applied yet, you can find it in the mailing
list archive or in patchwork. Would be great if you could test it
and report problems or add a Tested-by.

> 
> Regards
> Martin
> 
Rgds, Heiner
