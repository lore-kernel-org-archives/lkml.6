Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CDCC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498D22082D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 498D22082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbeLEPRc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:17:32 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:53041 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbeLEPRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:17:32 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4392Qx69T5z1qxkk;
        Wed,  5 Dec 2018 16:17:29 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4392Qx5Zdxz1qsJW;
        Wed,  5 Dec 2018 16:17:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 7VgH6MA1Z3GN; Wed,  5 Dec 2018 16:17:23 +0100 (CET)
X-Auth-Info: HKX1L2szS1Wgg4ZSEcLRd6n5x2DpFHEyBOQ7oDLhJdU=
Received: from crub (p508DE362.dip0.t-ipconnect.de [80.141.227.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed,  5 Dec 2018 16:17:23 +0100 (CET)
Date:   Wed, 5 Dec 2018 16:17:18 +0100
From:   Anatolij Gustschin <agust@denx.de>
To:     Song Qiang <songqiang1304521@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: usb: thoughts of adding more support for FT232H
Message-ID: <20181205161718.7451d98f@crub>
In-Reply-To: <48bc71bb-68e4-8b29-f609-940c9aedc0a9@gmail.com>
References: <48bc71bb-68e4-8b29-f609-940c9aedc0a9@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 5 Dec 2018 22:10:40 +0800
Song Qiang songqiang1304521@gmail.com wrote:
...
>I've been developing some iio device drivers and found that some people
>would like to test their devices with a qemu system which requires an
>i2c or spi port on our development hosts. Usually this is achieved with
>a DLN-2 adapter, while this is a bit difficult for me because it costs
>~175$ in my country. Then I found that FTDI's FT232H supports both these
>two modes and costs only less than 5$ but without full support in kernel.
>The ftdi-sio driver supports FT232H only as a serial converter.
>So I'm planning to write a mfd driver for it supports both these three
>modes, here are my thoughts:

There already has been a discussion [1] about adding an MFD driver for
FT232H, since the operating modes are mutually exclusive (and bus pins
shared between different modes), the MFD approach doesn't seem to be
a good fit.

>  - This device cannot support these three modes together because they
>    share some common pins, so I'm planning to add a sysfs entry
>    'current_mode' for selecting which mode the device should be working
>    on.
>  - This device is in uart mode on reset, so default mode would be reset,
>    too. This also helps for people only want to use this as a serial
>    converter feels nothing has happened (compatible).
>  - I was trying to reuse the ftdi-sio driver but it seems like mfd can
>    only register platform devices, while this is a usb driver. I may
>    have to copy some functions from this driver.
>
>Would you share any ideas? I'd appreciate it.

There is a patch series [2] adding an interface driver for FT232H-
based adapter devices, it already supports adding custom MPSSE based
SPI busses with SPI slaves for a custom USB PID. It already supports
adding custom CBUS-/MPSSE-GPIO adapters for user-defined USB PID.
Adding I2C driver/adapter support should be easy, too. Maybe you can
re-use it.

Thanks,
Anatolij

[1] https://patchwork.kernel.org/patch/9828985
[2] https://patchwork.kernel.org/project/linux-usb/list/?series=48255
