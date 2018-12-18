Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A71AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F406D218A1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="dxkjBY7G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeLROfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:35:36 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37223 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbeLROff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:35:35 -0500
Received: by mail-wr1-f67.google.com with SMTP id s12so15712787wrt.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 06:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4/0zY6u1RnApvmJHF2Wye5hDyNvlXySXtkNAZsbxooA=;
        b=dxkjBY7GaqejEiBFu65PXtKuy9H1n0cWKbSxNXMwZnNbFpofgPkQcozPZJ9Xro0HaM
         joOaIXsSuLsZtqYVa9iJWIXPcm6FQ6/War9WD13/YqNpLg/WFbQhirfVTdoRatIquplS
         jNLAmoQ11stj2Xeu4jVo0V8oQE9ImOcHda30kH5nYZVoRxxv33eLjNhhXWrGMtYhDocW
         S1BsdhXwZm/ZwX/lRCJsySp5/sbvwdhWGXpEVtpYpvsLAnLNLp+wvkdESySR2A1yka5M
         wib1pi/O+tUYOHF1/RVpVYZpdcyehKF2CvjRyieIo4DrqkPvZo8Wvx3eIs29+dytRWO/
         +x+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4/0zY6u1RnApvmJHF2Wye5hDyNvlXySXtkNAZsbxooA=;
        b=ZCNaJXI3QjkdVCsIlDEPjnD7uudd49iaSoOGG3ciJ1oRExTk2UOAf+XWT5xJ1s+g0B
         kTA14mJjadUvpk5gkH69gKPD83rQy5iiKsZlZMPd9nRk1q9bjMNDLmT05cDCckBA/m/z
         SZ9EA41JZlsN8D45wwnxE93pRKaa3rCXP8ULNoJthXuAa1w9cJWwBgtNbSSjpvIWxXKU
         rYu9Pbg4t2Z3xv/1hmXTAWHZyRATEYEzFQqaAs6R4w3+yTT/s4HGFU7pZLvQRwmdkWxV
         a9jNUJs/Vu2PkNNh9VdZLYiXSaOMBA5prwMb5p0CPgYTiGeQbLnM/fTiaUtZPDHu17TQ
         UE+g==
X-Gm-Message-State: AA+aEWZiCu5uhJUfOT4FVXgGiCyK0PkBy+qPPZHHqJDi2wJVXePXErB0
        lChgMXRfb7wxGgt2LUkBTOW9S6M9njI=
X-Google-Smtp-Source: AFSGD/XtIo2IPa6vdIXA6faQeaIDcdrNb8/xev1hGKBKrWAotKnKX+UF7Ruj43lhdmQ0t5yvKEomhw==
X-Received: by 2002:adf:d0c9:: with SMTP id z9mr14319964wrh.317.1545143733076;
        Tue, 18 Dec 2018 06:35:33 -0800 (PST)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id 202sm2863061wmt.8.2018.12.18.06.35.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 06:35:32 -0800 (PST)
Date:   Tue, 18 Dec 2018 15:27:56 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jian-Hong Pan <starnight@g.ncu.edu.tw>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        "David S . Miller" <davem@davemloft.net>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        linux-lpwan@lists.infradead.org, netdev@vger.kernel.org,
        "<linux-arm-kernel@lists.infradead.org\\" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org>," <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>
Subject: Re: [PATCH v5 5/6] net: maclorawan: Implement maclorawan class module
Message-ID: <20181218142756.GA2031@nanopsycho>
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-6-starnight@g.ncu.edu.tw>
 <20181217140233.GG2096@nanopsycho>
 <CAC=mGziN5KrXPMAXoN_hhfQrtofCeyzTr4AjbbJLOoJ+p2+Nng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC=mGziN5KrXPMAXoN_hhfQrtofCeyzTr4AjbbJLOoJ+p2+Nng@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Dec 18, 2018 at 03:27:09PM CET, starnight@g.ncu.edu.tw wrote:
>> Sun, Dec 16, 2018 at 11:18:59AM CET, starnight@g.ncu.edu.tw wrote:
>> >LoRaWAN defined by LoRa Alliance(TM) is the MAC layer over LoRa devices.
>> >
>> >This patch implements part of Class A end-devices SoftMAC defined in
>> >LoRaWAN(TM) Specification Ver. 1.0.2:
>> >1. End-device receive slot timing
>> >2. Only single channel and single data rate for now
>> >3. Unconfirmed data up/down message types
>> >
>> >On the other side, it defines the basic interface and operation
>> >functions for compatible LoRa device drivers.
>> >
>> >Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
>> >---
>> >V2:
>> >- Split the LoRaWAN class module patch in V1 into LoRaWAN socket and
>> >  LoRaWAN Soft MAC modules
>> >- Modify for Big/Little-Endian
>> >- Use SPDX license identifiers
>> >
>> >V3:
>> >- Remove the decoration word - inline of the functions
>> >- Order local variables from longest to shortest line in the functions
>> >- Change the calling mac_cb function to lrw_get_mac_cb macro
>> >
>> >V4:
>> >- Fix the delay period between RX window#1 and window#2
>> >- Fix by coding style report from scripts/checkpatch.pl
>> >
>> >V5:
>> >- Initial rx_skb_list when it is allocated with LoRa hardware
>> >- Check the sk_buff's data length before access it
>> >- Deal FPort field and decrypt payload in lrw_parse_frame function
>> >- Drop the recieved frame if parse failed
>> >- Fix the bug which passes wrong skb properties from maclorawan to lorawan module
>> >
>> > net/maclorawan/Kconfig  |  14 +
>> > net/maclorawan/Makefile |   2 +
>> > net/maclorawan/mac.c    | 555 ++++++++++++++++++++++++++++++++++++
>> > net/maclorawan/main.c   | 606 ++++++++++++++++++++++++++++++++++++++++
>> > 4 files changed, 1177 insertions(+)
>> > create mode 100644 net/maclorawan/Kconfig
>> > create mode 100644 net/maclorawan/Makefile
>> > create mode 100644 net/maclorawan/mac.c
>> > create mode 100644 net/maclorawan/main.c
>>
>>
>> I don't get it. In patch "Add LoRaWAN API declaration for LoRa devices"
>> you add headers for "API" and here you implement functions. That is just
>> weird. Does it mean you can have other implementations?
>
>LoRaWAN defined by LoRa Alliance(TM) is the MAC layer over LoRa PHY.
>This part is soft-MAC as Andreas mentioned
>http://lists.infradead.org/pipermail/linux-lpwan/2018-December/000010.html

Okay, that does not answer my concern about header file in one patch and
the actual implementation of functions in another one.


>
>> Also, you don't really have any user of this API in the set. Please
>> introduce at least 1 driver, preferably more (I see that Andreas has
>> multiple ones in his patchset). You cannot push kernel infrastructure
>> without kernel user.
>
>The soft-MAC is suitable for the LoRa chips' device drivers, like
>sx1276/77/78/79, RFM95/96/97/98W ...
>Still waiting for Andreas' sx1276 version 2 patch and more discussion.
>For example, how to make PF_LORA and PF_LORAWAN like Ethernet, PF_INET
>and PF_INET6 don't need separate devices either, both use eth0.
>https://lkml.org/lkml/2018/8/3/266

Then you should push this is RFC or together with Andreases work in a
single patchset. Infra without users cannot be merged.


>
>Jian-Hong Pan
