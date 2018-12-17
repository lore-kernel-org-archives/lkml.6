Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33980C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A4D2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="TVZYntZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733187AbeLQOKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:10:09 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:47070 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727583AbeLQOKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:10:09 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so12375723wrt.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 06:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4Vta0M/fQVRTlBNYE1kAewYSFkDr9n3kHJqgLj7geIk=;
        b=TVZYntZimXn+8rpLKuR99wNFRZ3iV/ZM4F1BV0W0+VTyzzczUPkC5jRGRDALmfR0Yc
         40HeZNI8iLEue0A+v4/w5bDvjoUuNufHeTxJ0F6qAI1kQCUV9TxoC1d1zheGBC91cgDl
         7TzgOB0V7r1R5lf11y3/FN285VYcCbdzaDbcI2zJPSQsfQGUY0yoYHk3M6FAjPvRerY0
         22aI1Up1BVrNXa6b3VXE1IRypw0wsALEAMEPk5e6n5YTjZ8y55zKXYQxaJ5Tl4i8vFf/
         2jCnaGYPpFYdFWzDReHf8JGsH7PJBSsQe10Zg2bDfRgCecneOdkW+7Dgo20SzXc2nJpu
         /95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4Vta0M/fQVRTlBNYE1kAewYSFkDr9n3kHJqgLj7geIk=;
        b=RYwwsTJtdmguX+obU+/ZR6wJmK6whb8+GGus6hmLULFliLSZ82fMmQC5M4AHg3B2D1
         8ytyV4payNZU7H+ncbgn4kUcPXs3RTDxbCx0pQOFC02OwfbGaqPnt3QVXwj1TzeDF0pF
         7/6xL7eKYEHTySZnpB9EqNhGJaf17piVpyBDiZH7kJdGRuPvOCwum2CKsNeCrBHHTUTu
         kQNKms0ruZWhptVQCO5VMUcQ4rjL/9XAc+NXU7+MwDxrhLHRe0/ZLbR6N/xg6gSV1bS8
         1gwndqoRZzVVfnFX+Mv4gn4ioE/C5NL2G5gURRsU0vYX+YolpwlEtwR7yPZKSfQKfttu
         T3kw==
X-Gm-Message-State: AA+aEWY2SVJS+5OWrH7KCfb5tmnAWIPcLfUtmszGzLGZBWTDe4XnTyln
        y/8fMRgtXQP4hs8ISTWEK0T1UA==
X-Google-Smtp-Source: AFSGD/WGJYFWyZuGXd8rCUpKN/N76S4XsPJydfOnzW0OjhHd/FOJ6eccIlrVCZkhKLFU99tnOOrSXQ==
X-Received: by 2002:a5d:5351:: with SMTP id t17mr10782496wrv.288.1545055807335;
        Mon, 17 Dec 2018 06:10:07 -0800 (PST)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id f66sm13900556wmd.28.2018.12.17.06.10.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 06:10:06 -0800 (PST)
Date:   Mon, 17 Dec 2018 15:02:33 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jian-Hong Pan <starnight@g.ncu.edu.tw>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        "David S . Miller" <davem@davemloft.net>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        linux-lpwan@lists.infradead.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>, linux-wpan@vger.kernel.org
Subject: Re: [PATCH v5 5/6] net: maclorawan: Implement maclorawan class module
Message-ID: <20181217140233.GG2096@nanopsycho>
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-6-starnight@g.ncu.edu.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181216101858.9585-6-starnight@g.ncu.edu.tw>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sun, Dec 16, 2018 at 11:18:59AM CET, starnight@g.ncu.edu.tw wrote:
>LoRaWAN defined by LoRa Alliance(TM) is the MAC layer over LoRa devices.
>
>This patch implements part of Class A end-devices SoftMAC defined in
>LoRaWAN(TM) Specification Ver. 1.0.2:
>1. End-device receive slot timing
>2. Only single channel and single data rate for now
>3. Unconfirmed data up/down message types
>
>On the other side, it defines the basic interface and operation
>functions for compatible LoRa device drivers.
>
>Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
>---
>V2:
>- Split the LoRaWAN class module patch in V1 into LoRaWAN socket and
>  LoRaWAN Soft MAC modules
>- Modify for Big/Little-Endian
>- Use SPDX license identifiers
>
>V3:
>- Remove the decoration word - inline of the functions
>- Order local variables from longest to shortest line in the functions
>- Change the calling mac_cb function to lrw_get_mac_cb macro
>
>V4:
>- Fix the delay period between RX window#1 and window#2
>- Fix by coding style report from scripts/checkpatch.pl
>
>V5:
>- Initial rx_skb_list when it is allocated with LoRa hardware
>- Check the sk_buff's data length before access it
>- Deal FPort field and decrypt payload in lrw_parse_frame function
>- Drop the recieved frame if parse failed
>- Fix the bug which passes wrong skb properties from maclorawan to lorawan module
>
> net/maclorawan/Kconfig  |  14 +
> net/maclorawan/Makefile |   2 +
> net/maclorawan/mac.c    | 555 ++++++++++++++++++++++++++++++++++++
> net/maclorawan/main.c   | 606 ++++++++++++++++++++++++++++++++++++++++
> 4 files changed, 1177 insertions(+)
> create mode 100644 net/maclorawan/Kconfig
> create mode 100644 net/maclorawan/Makefile
> create mode 100644 net/maclorawan/mac.c
> create mode 100644 net/maclorawan/main.c


I don't get it. In patch "Add LoRaWAN API declaration for LoRa devices"
you add headers for "API" and here you implement functions. That is just
weird. Does it mean you can have other implementations?


Also, you don't really have any user of this API in the set. Please
introduce at least 1 driver, preferably more (I see that Andreas has
multiple ones in his patchset). You cannot push kernel infrastructure
without kernel user.
