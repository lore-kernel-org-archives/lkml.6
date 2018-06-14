Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2A909C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96AE208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="YC4mRElK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C96AE208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.bosch.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755394AbeFNQXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 12:23:42 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:33394 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754965AbeFNQXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 12:23:40 -0400
Received: from si0vm1948.rbesz01.com (unknown [139.15.230.188])
        by si0vms0216.rbdmz01.com (Postfix) with ESMTPS id 41687Z3XZhz1XLFtD;
        Thu, 14 Jun 2018 18:23:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=de.bosch.com;
        s=2015-01-21; t=1528993418;
        bh=HOaT1hrdMtb1781JxR/wpK0GpltgC8HtsieGbtWl1ek=; l=10;
        h=From:From:Reply-To:Sender;
        b=YC4mRElKZy5wmK+ciDP2gwnSDo6jEp2fiRotvDWQuxCEH93ePq34ddKS2gpYVaDEF
         MT9hIR9AyJTgQlN6H1i3D4P1wc9NGa8eZW+0F22LoH5p8N1zCqRPTsG2pFYUl41g/S
         0HHYKde2RHKn0+0c6ZyqS0+6+qn+u7RatopKtfCI=
Received: from si0vm4642.rbesz01.com (unknown [10.58.172.176])
        by si0vm1948.rbesz01.com (Postfix) with ESMTPS id 41687Z33rhz398;
        Thu, 14 Jun 2018 18:23:38 +0200 (CEST)
X-AuditID: 0a3aad12-eddff70000016568-7f-5b2296875fec
Received: from fe0vm1651.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by si0vm4642.rbesz01.com (SMG Outbound) with SMTP id ED.D9.25960.786922B5; Thu, 14 Jun 2018 18:23:35 +0200 (CEST)
Received: from FE-MBX2050.de.bosch.com (fe-mbx2050.de.bosch.com [10.3.231.60])
        by fe0vm1651.rbesz01.com (Postfix) with ESMTPS id 41687Z1fX6zFNF0;
        Thu, 14 Jun 2018 18:23:38 +0200 (CEST)
Received: from FE-MBX2051.de.bosch.com (10.3.231.61) by
 FE-MBX2050.de.bosch.com (10.3.231.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1466.3; Thu, 14 Jun 2018 18:23:37 +0200
Received: from FE-MBX2051.de.bosch.com ([fe80::d5b5:44fa:ef15:153e]) by
 FE-MBX2051.de.bosch.com ([fe80::d5b5:44fa:ef15:153e%6]) with mapi id
 15.01.1466.008; Thu, 14 Jun 2018 18:23:37 +0200
From:   "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hs@denx.de" <hs@denx.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "ZHU Yi (BT-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>,
        "ZHANG Kevin (BT-FIR/ENG1-Zhu)" <Kevin.Zhang3@cn.bosch.com>,
        Zhu Yi <zhuyi882004@126.com>,
        "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Subject: AW: [PATCH v5] Input: add bu21029 touch driver
Thread-Topic: [PATCH v5] Input: add bu21029 touch driver
Thread-Index: AdQDKorsQCg/6r2vTbqVlvssv9t8UwAKXa0AACnxBtA=
Date:   Thu, 14 Jun 2018 16:23:37 +0000
Message-ID: <267fd38819114d99bbdaabc6afcf28cd@de.bosch.com>
References: <73b4ea3ce1aa453681fae87b7bad5cab@de.bosch.com>
 <20180613222044.GC62746@dtor-ws>
In-Reply-To: <20180613222044.GC62746@dtor-ws>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.19.142.147]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA22TfVAUdRjH+d3uHXvnrf1YJJ5OeXGnzMlANKwNmoTK5qxxpmmcXqDSI1bu
        8rij24MRJydgEuLFl4BTOEghPIYRIkVmIjUxkDGtEZgbgSMQGhA80pJXCUbs7hbk/ui/5/f9
        Pp/n+/s9O0sRTCelonQGM28yaPSsTEEqor4PCss5xsZHzFdwnPNoK+JOXrkh5Vq/u4O4pr4B
        gnNMzEg5+/lyGWfr7pRwB3++4svZ2qtQjFxtc3SQ6roTdUh9wvorqf7J2u+rbjidK1NPNgS/
        I4tTvJLI63VpvGnjq7sV2kfOMTJlmt6XfXlKmoGmFXmIogBHQsel9XlIQTG4RAL27lkkHi4i
        +HZyaPFwD0HH37/5iofLCP49UiHJQ3JKhqMgp9ptyKlVeCP8WDbnIQhcTUJh/gTpNvzxS9A3
        2iUTmziobj8rEWsXPDLu0Un8DDyc6fHoNI6G3+czpO6awZ9Ah6PWo8txGOSOV3rCEA6CM2fa
        CXdN4EBoGHng6QeM4dRFUQccAM6hBan4zrVQXvKa2B4OPZZimVhvgOrKvwgx1g+ulQ6TR1Gg
        1Wuq1QuxeiFWL6QCkadRgKCLSEuOfDFyc7gpgRf2R2wK/9SY3IDEb8w0oXxbQgvCFGKV9BEt
        G89INWlCenIL2kJJ2AA69ObaeGZlgjExXasRtLtMqXpeYFU08vHxYfwfy0JqQrJOEHRGQwsC
        imBX0YfMrlF0oiZ9P28yilgLWk2RbCBdkPhFHIOTNGZ+L8+n8KYlN5qiWKBftrhAPxOfxO/b
        o9Obl2w2SMx80tvxjpVQ8hb0AqV0ZevdI2ghRZMs6JIW8adEnFlSl9Hr6HXqbnZBAcGQBqOB
        VwXSb7t57O7Uphoe30C1ho5vDI1nAryM5SljyIFcO/QX7690/UrL2UA3+Zd/yPgtisvQZpuL
        wbdkMDBTjKDZYUfww8I9Akor7stgtq5GAWdtl1aA1T6jhBJrLQ1F/YM0NJcVroS5UssT8NXo
        BIbJSqcKFor/DIZG+1wwZHXfYKGwqvFp6B0cXgc9I2PPQldm0fMwNX01DGYt97fA4Vu3OZjK
        fbQVnHUDMe6WN+DCoGMbWP/pV0PztfLt4Gye2g712Q07oOnYLzvGXIuVuBbb1hbqXqxZY/6f
        xS6qy69TZaDYnqzRaByYt/W9HuOFD4Z2f2ndGdX7kS6y5q3zBz/OvPOgrT7kdt+GzDfrH65X
        hpSdm62vNspDYnqh99yU4nDhYGxX/tXP6r/JnKh1+o53otVFPu+fzDzevUu/RjkfkVNzYEVr
        fuzX8/TNOOqPtAOn7MOfq7M6r7+7be/xu1XEznWWmD0sKWg1m54jTILmP7J3kTnkBAAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dmitry,

> Sorry for the delay. Could you please tell me if the patch below (shoudl
> apply on top of your v5 version) works?

The patch applies cleanly and we will give the code a thorough test.

> diff --git a/Documentation/devicetree/bindings/input/touchscreen/bu21029.=
txt
> b/Documentation/devicetree/bindings/input/touchscreen/bu21029.txt
> index 030a888365dff..1aaa647cc3eaa 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/bu21029.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/bu21029.txt
> @@ -5,13 +5,14 @@ Required properties:
>   - reg                     : i2c device address of the chip (0x40 or 0x4=
1)
>   - interrupt-parent        : the phandle for the gpio controller
>   - interrupts              : (gpio) interrupt to which the chip is conne=
cted
> - - reset-gpios             : gpio pin to reset the chip (active low)
>   - rohm,x-plate-ohms       : x-plate resistance in Ohm
>=20
>  Optional properties:
> + - reset-gpios             : gpio pin to reset the chip (active low)
>   - touchscreen-size-x      : horizontal resolution of touchscreen (in pi=
xels)
>   - touchscreen-size-y      : vertical resolution of touchscreen (in pixe=
ls)
>   - touchscreen-max-pressure: maximum pressure value
> + - vdd-supply              : power supply for the controoler

There is a typo in controller.

Greetings,
Mark

Building Technologies, Panel Software Fire (BT-FIR/ENG1)=20
Bosch Sicherheitssysteme GmbH | Postfach 11 11 | 85626 Grasbrunn | GERMANY =
| www.boschsecurity.com

Sitz: Stuttgart, Registergericht: Amtsgericht Stuttgart HRB 23118=20
Aufsichtsratsvorsitzender: Stefan Hartung; Gesch=E4ftsf=FChrung: Gert van I=
peren, Andreas Bartz, Thomas Quante, Bernhard Schuster
