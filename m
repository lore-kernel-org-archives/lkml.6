Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9646C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D50820684
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZDXI6y1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D50820684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbeHWXjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 19:39:53 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:42928 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeHWXjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 19:39:53 -0400
Received: by mail-pg1-f171.google.com with SMTP id y4-v6so3173143pgp.9;
        Thu, 23 Aug 2018 13:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0jNc55KDkwnHLe69KKFkrCM/qYRzT3Klu6wWHAWnLLs=;
        b=XZDXI6y1Qn//JcLQcOONXFgEuBI2Zv0vwcyu+cgsGVcYwj2QrC42iTYLIfaD3mHJ0P
         J5ryG/tsfOICu1tl0UHJwLzt79Y4ruPPkDfwriRatQ0o3Eura+xJtKI5Yb0c1A8gp87f
         Y2zCK18H2l86T2Xhv0QI837HBIe6Wie7A5WEiZLB10FTBUfXVz5c9X1E4ZSC4CHvWWJK
         RGJat2G8FHz5jRQRnP92zvCRTqS3oU0cPE6vlQGO4KbC5j4OLBPHER5GeAl8wimS8FYz
         6/nYCIOsWL8MabigwsmZDPbj8sLM1D8PoTjMeIMUHCEVdLXhSjq3FjfCVT3V9DlDy/HY
         0xoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=0jNc55KDkwnHLe69KKFkrCM/qYRzT3Klu6wWHAWnLLs=;
        b=UBVJAecIEIFsgDZa/oQxe7fmXznhjot3R4T1/t8YnuBdzdb2+/C+HXRYlhbi92E2Ic
         UZoI1PPESN4H7xuLS31eGpSYADTwKM9jRrhAbKibIb1io8/yiltslkqojSPDAu59I8zC
         QBWqj7wiEe9l/ZekkWNa/0fO4nHwvYptu+Klr6TUCib/agxe0FyQVxcywH1wUfTkXiMt
         /KKoao4uRfZtU/APm07tlkJaIKLozdWY5PzX0XEjMEbu01jSeB3+prysniSLzakUh7t6
         FmyUUYlxUVwlxjDYKjbP/yZ3GVCzy2qj3xbdoOknlaK9Iiymvi1rp9Zq/ZlPXb0JQW4n
         +zMg==
X-Gm-Message-State: AOUpUlH5uk2CIxW4HtnOzK/xP3KsV43w1Bl762y5+sgmWKJZAelZ6Heg
        nCzRj8fu4H4dfRNUjo63LZo=
X-Google-Smtp-Source: AA+uWPxjlxBs+pqvUqgI4Twb+qcejnV0v20Bh0GCyhUJUqP44NSqOtMjvRnK+6QIetDRHx0mYiZkiw==
X-Received: by 2002:a63:e516:: with SMTP id r22-v6mr56884686pgh.170.1535054916766;
        Thu, 23 Aug 2018 13:08:36 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id m7-v6sm5928204pgr.62.2018.08.23.13.08.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 13:08:35 -0700 (PDT)
Date:   Thu, 23 Aug 2018 13:08:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mark Brown <broonie@kernel.org>,
        Kirill Kapranov <kirill.kapranov@compulab.co.il>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: -next: Traceback at at drivers/spi/spi.c:2179 spi_register_controller
Message-ID: <20180823200834.GA9368@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I see the attached warning when booting 'sabrelite' images in qemu,
using imx_v6_v7_defconfig and imx6dl-sabrelite.dts.

Context suggests that the warning is seen since commit 1a4327fbf4554 ("spi:
fix IDR collision on systems with both fixed and dynamic SPI bus numbers").

Guenter

---
[    7.105230] ------------[ cut here ]------------
[    7.105509] WARNING: CPU: 0 PID: 1 at drivers/spi/spi.c:2179 spi_register_controller+0x7dc/0x938
[    7.105760] couldn't get idr
[    7.105849] Modules linked in:
[    7.106363] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.18.0-next-20180822 #1
[    7.106593] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[    7.106869] Backtrace: 
[    7.107126] [<c010e1f0>] (dump_backtrace) from [<c010e4c0>] (show_stack+0x18/0x1c)
[    7.107426]  r7:00000000 r6:60000013 r5:00000000 r4:c11cee68
[    7.107641] [<c010e4a8>] (show_stack) from [<c0b63894>] (dump_stack+0xb4/0xec)
[    7.107845] [<c0b637e0>] (dump_stack) from [<c012908c>] (__warn+0xe8/0x114)
[    7.108048]  r10:ffffffe4 r9:00000883 r8:c06d1f60 r7:00000009 r6:c0eda848 r5:00000000
[    7.108254]  r4:c6097cac r3:2f537163
[    7.108395] [<c0128fa4>] (__warn) from [<c0129104>] (warn_slowpath_fmt+0x4c/0x6c)
[    7.108596]  r9:c61a8010 r8:c66f5590 r7:cbdc031c r6:00000001 r5:c0edab28 r4:c1108908
[    7.108802] [<c01290bc>] (warn_slowpath_fmt) from [<c06d1f60>] (spi_register_controller+0x7dc/0x938)
[    7.109020]  r3:2f537163 r2:c0edab28
[    7.109150]  r5:c62fe268 r4:c62fe000
[    7.109291] [<c06d1784>] (spi_register_controller) from [<c06d4b44>] (spi_bitbang_start+0xa8/0x12c)
[    7.109517]  r10:c62fe268 r9:c66f54c0 r8:c61a8010 r7:00000000 r6:c61a8000 r5:c62fe4e8
[    7.109710]  r4:c62fe000
[    7.109836] [<c06d4a9c>] (spi_bitbang_start) from [<c06d8df4>] (spi_imx_probe+0x3fc/0x694)
[    7.110044]  r5:c62fe000 r4:c62fe4e8
[    7.110189] [<c06d89f8>] (spi_imx_probe) from [<c060ddc4>] (platform_drv_probe+0x50/0xa0)
[    7.110405]  r10:00000000 r9:00000000 r8:c1180380 r7:00000000 r6:c1180380 r5:00000000
[    7.110600]  r4:c61a8010
[    7.110725] [<c060dd74>] (platform_drv_probe) from [<c060ba78>] (really_probe+0x1d4/0x2c8)
[    7.110935]  r7:00000000 r6:c1946d58 r5:c1946d54 r4:c61a8010
[    7.111109] [<c060b8a4>] (really_probe) from [<c060bd0c>] (driver_probe_device+0x64/0x170)
[    7.111325]  r10:ffffe000 r9:c11d5cb0 r8:c11d6de0 r7:c1108908 r6:c61a8044 r5:c1180380
[    7.111523]  r4:c61a8010 r3:00000000
[    7.111663] [<c060bca8>] (driver_probe_device) from [<c060bef8>] (__driver_attach+0xe0/0xe4)
[    7.111880]  r9:c11d5cb0 r8:c11d6de0 r7:c1108908 r6:c61a8044 r5:c1180380 r4:c61a8010
[    7.112086] [<c060be18>] (__driver_attach) from [<c0609b4c>] (bus_for_each_dev+0x78/0xbc)
[    7.112307]  r7:c1108908 r6:c060be18 r5:c1180380 r4:00000000
[    7.112481] [<c0609ad4>] (bus_for_each_dev) from [<c060b3c4>] (driver_attach+0x20/0x28)
[    7.112685]  r7:00000000 r6:c11747e8 r5:c66f3300 r4:c1180380
[    7.112856] [<c060b3a4>] (driver_attach) from [<c060ae00>] (bus_add_driver+0x17c/0x210)
[    7.113067] [<c060ac84>] (bus_add_driver) from [<c060cd18>] (driver_register+0x7c/0x110)
[    7.113277]  r7:c105fc4c r6:00000000 r5:c1108908 r4:c1180380
[    7.113451] [<c060cc9c>] (driver_register) from [<c060dd18>] (__platform_driver_register+0x34/0x48)
[    7.113670]  r5:c1108908 r4:c1108930
[    7.113815] [<c060dce4>] (__platform_driver_register) from [<c105fc64>] (spi_imx_driver_init+0x18/0x20)
[    7.114063] [<c105fc4c>] (spi_imx_driver_init) from [<c0103174>] (do_one_initcall+0x88/0x318)
[    7.114299] [<c01030ec>] (do_one_initcall) from [<c100123c>] (kernel_init_freeable+0x2f8/0x3d8)
[    7.114530]  r10:ffffe000 r9:c1108930 r8:c1092850 r7:c11d6de0 r6:00000007 r5:c11dbc40
[    7.114731]  r4:c10aa244
[    7.114863] [<c1000f44>] (kernel_init_freeable) from [<c0b7e150>] (kernel_init+0x10/0x11c)
[    7.115086]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c0b7e140
[    7.115282]  r4:00000000
[    7.115411] [<c0b7e140>] (kernel_init) from [<c01010b4>] (ret_from_fork+0x14/0x20)
[    7.115647] Exception stack(0xc6097fb0 to 0xc6097ff8)
[    7.115962] 7fa0:                                     00000000 00000000 00000000 00000000
[    7.116339] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    7.116665] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    7.116906]  r5:c0b7e140 r4:00000000
[    7.117632] irq event stamp: 195919
[    7.117930] hardirqs last  enabled at (195927): [<c018b428>] console_unlock+0x1bc/0x5e0
[    7.118211] hardirqs last disabled at (195934): [<c018b2ec>] console_unlock+0x80/0x5e0
[    7.118472] softirqs last  enabled at (195918): [<c0102538>] __do_softirq+0x350/0x510
[    7.118703] softirqs last disabled at (195903): [<c0130cf4>] irq_exit+0x100/0x1b0
[    7.118996] ---[ end trace c06b605fd79953be ]---
[    7.119974] spi_imx 2008000.ecspi: probed
