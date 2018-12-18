Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8856C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7626D21873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="m1jJLvGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbeLRO1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:27:07 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37319 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbeLRO1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:27:07 -0500
Received: by mail-ot1-f66.google.com with SMTP id 40so15816983oth.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 06:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rBrK8cQ72TbNjqCTL0/cxQjz7lUhccTjfnchQwNrscc=;
        b=m1jJLvGYGeGJSTC2uwsAU1GbC48Vi3+LLS+/7Zn9Y2SoaAUQzYQNzKw/escLXzVDBV
         5noCt9Ql2cjw7LarZTxqZGVaQbMoSh0II/Va6TJNI2/7DyQiCf3i7teZw0gpawx20Ihm
         Sgl0EwXsgt0dFJ5iaWeh60xb4tF0DWl5UX5EQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rBrK8cQ72TbNjqCTL0/cxQjz7lUhccTjfnchQwNrscc=;
        b=U0ZypZwRgN67EcugKzP24xGXE2UTuAS+m5wHAhKHFEJyiZAj9hw6tVQNl8vPpf3/+r
         AoKXAhSPm5Z+v8rZShMBrSguEyUx5nyrNxOjBHCF+WyfeRaxYYFN7onuGzg+qTFuk+f0
         6KUfXVBknGZ7MssBFaVBJzomqZ0bpZehREPZhsWe/Mk1gHYDDMJVAEGHs9gZj9tZXX4Y
         i6wIFW9uoO1TFghYu0xJ0pBYAPr4DcwByYqRuZv7P8OSVg21brBtI8ZKkRSBM88Yilrf
         60NojzKbXnK2CsN3NqVJZV9d4+vv5uzIdaXslHA2ZBG/7g18hDNjXv0A2mVaM/yzWOWi
         9pJw==
X-Gm-Message-State: AA+aEWbaOg+qEJr5Bab7rYlY9Cuz6jgNh8KCOPnAxsz0yPgZTi15z9Ow
        8DtQCtHiRoqS0iXTV7gDTryWSQ==
X-Google-Smtp-Source: AFSGD/V8W1y/DP/TF60L/0yG8OV46TVUdiqXerl70daoOt0KIgIyw3kO3Rg4NSfGzm5N8HduJmIPrg==
X-Received: by 2002:a05:6830:13c2:: with SMTP id e2mr11661728otq.15.1545143225081;
        Tue, 18 Dec 2018 06:27:05 -0800 (PST)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com. [209.85.210.42])
        by smtp.gmail.com with ESMTPSA id 4sm7775041otw.39.2018.12.18.06.27.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 06:27:04 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id t5so15861644otk.1;
        Tue, 18 Dec 2018 06:27:03 -0800 (PST)
X-Received: by 2002:a9d:77d4:: with SMTP id w20mr12017080otl.196.1545143223416;
 Tue, 18 Dec 2018 06:27:03 -0800 (PST)
MIME-Version: 1.0
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-6-starnight@g.ncu.edu.tw> <20181217140233.GG2096@nanopsycho>
In-Reply-To: <20181217140233.GG2096@nanopsycho>
From:   Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date:   Tue, 18 Dec 2018 22:27:09 +0800
X-Gmail-Original-Message-ID: <CAC=mGziN5KrXPMAXoN_hhfQrtofCeyzTr4AjbbJLOoJ+p2+Nng@mail.gmail.com>
Message-ID: <CAC=mGziN5KrXPMAXoN_hhfQrtofCeyzTr4AjbbJLOoJ+p2+Nng@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] net: maclorawan: Implement maclorawan class module
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Sun, Dec 16, 2018 at 11:18:59AM CET, starnight@g.ncu.edu.tw wrote:
> >LoRaWAN defined by LoRa Alliance(TM) is the MAC layer over LoRa devices.
> >
> >This patch implements part of Class A end-devices SoftMAC defined in
> >LoRaWAN(TM) Specification Ver. 1.0.2:
> >1. End-device receive slot timing
> >2. Only single channel and single data rate for now
> >3. Unconfirmed data up/down message types
> >
> >On the other side, it defines the basic interface and operation
> >functions for compatible LoRa device drivers.
> >
> >Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
> >---
> >V2:
> >- Split the LoRaWAN class module patch in V1 into LoRaWAN socket and
> >  LoRaWAN Soft MAC modules
> >- Modify for Big/Little-Endian
> >- Use SPDX license identifiers
> >
> >V3:
> >- Remove the decoration word - inline of the functions
> >- Order local variables from longest to shortest line in the functions
> >- Change the calling mac_cb function to lrw_get_mac_cb macro
> >
> >V4:
> >- Fix the delay period between RX window#1 and window#2
> >- Fix by coding style report from scripts/checkpatch.pl
> >
> >V5:
> >- Initial rx_skb_list when it is allocated with LoRa hardware
> >- Check the sk_buff's data length before access it
> >- Deal FPort field and decrypt payload in lrw_parse_frame function
> >- Drop the recieved frame if parse failed
> >- Fix the bug which passes wrong skb properties from maclorawan to lorawan module
> >
> > net/maclorawan/Kconfig  |  14 +
> > net/maclorawan/Makefile |   2 +
> > net/maclorawan/mac.c    | 555 ++++++++++++++++++++++++++++++++++++
> > net/maclorawan/main.c   | 606 ++++++++++++++++++++++++++++++++++++++++
> > 4 files changed, 1177 insertions(+)
> > create mode 100644 net/maclorawan/Kconfig
> > create mode 100644 net/maclorawan/Makefile
> > create mode 100644 net/maclorawan/mac.c
> > create mode 100644 net/maclorawan/main.c
>
>
> I don't get it. In patch "Add LoRaWAN API declaration for LoRa devices"
> you add headers for "API" and here you implement functions. That is just
> weird. Does it mean you can have other implementations?

LoRaWAN defined by LoRa Alliance(TM) is the MAC layer over LoRa PHY.
This part is soft-MAC as Andreas mentioned
http://lists.infradead.org/pipermail/linux-lpwan/2018-December/000010.html

> Also, you don't really have any user of this API in the set. Please
> introduce at least 1 driver, preferably more (I see that Andreas has
> multiple ones in his patchset). You cannot push kernel infrastructure
> without kernel user.

The soft-MAC is suitable for the LoRa chips' device drivers, like
sx1276/77/78/79, RFM95/96/97/98W ...
Still waiting for Andreas' sx1276 version 2 patch and more discussion.
For example, how to make PF_LORA and PF_LORAWAN like Ethernet, PF_INET
and PF_INET6 don't need separate devices either, both use eth0.
https://lkml.org/lkml/2018/8/3/266

Jian-Hong Pan
