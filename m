Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 589B7C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 14:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D60E20896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 14:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="qlGR1Fwv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D60E20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.bosch.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756239AbeFOO0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 10:26:24 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:56814 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755816AbeFOO0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 10:26:21 -0400
Received: from fe0vm1649.rbesz01.com (unknown [139.15.230.188])
        by si0vms0216.rbdmz01.com (Postfix) with ESMTPS id 416jTl6BKMz1XLFtG;
        Fri, 15 Jun 2018 16:26:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=de.bosch.com;
        s=2015-01-21; t=1529072779;
        bh=8kQS3p+bvawjwzAgJsHtGVf2NYPdIRS1vLSshqpTpOo=; l=10;
        h=From:From:Reply-To:Sender;
        b=qlGR1FwvPytOQdjlwPyEGa+Pb4rweuwvmJ9Q45Fl1g+F2EZHIjjomcFFzmEjhHUDS
         vrAqgV5JISxz475S/jQ8+qO8ZjXQlJzGRgBFUmi/if+J0xhRu3oY1krekL+cyxnCwO
         OO6EzuqWsE59McDhkzdSCQS0ubC/+cN0/h/v/alQ=
Received: from si0vm2082.rbesz01.com (unknown [10.58.172.176])
        by fe0vm1649.rbesz01.com (Postfix) with ESMTP id 416jTl5pm1z1N9;
        Fri, 15 Jun 2018 16:26:19 +0200 (CEST)
X-AuditID: 0a3aad16-be7ff70000000413-e0-5b23cc84575e
Received: from si0vm1949.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by si0vm2082.rbesz01.com (SMG Outbound) with SMTP id 0A.2F.01043.48CC32B5; Fri, 15 Jun 2018 16:26:12 +0200 (CEST)
Received: from FE-MBX2051.de.bosch.com (fe-mbx2051.de.bosch.com [10.3.231.61])
        by si0vm1949.rbesz01.com (Postfix) with ESMTPS id 416jTl49x9z6D44M7;
        Fri, 15 Jun 2018 16:26:19 +0200 (CEST)
Received: from FE-MBX2051.de.bosch.com (10.3.231.61) by
 FE-MBX2051.de.bosch.com (10.3.231.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1466.3; Fri, 15 Jun 2018 16:26:19 +0200
Received: from FE-MBX2051.de.bosch.com ([fe80::d5b5:44fa:ef15:153e]) by
 FE-MBX2051.de.bosch.com ([fe80::d5b5:44fa:ef15:153e%6]) with mapi id
 15.01.1466.008; Fri, 15 Jun 2018 16:26:19 +0200
From:   "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hs@denx.de" <hs@denx.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "D_ZHU Yi (BT-FIR/ENG1-Zhu)" <D_Yi.Zhu5@cn.bosch.com>,
        "ZHANG Kevin (BT-FIR/ENG1-Zhu)" <Kevin.Zhang3@cn.bosch.com>,
        Zhu Yi <zhuyi882004@126.com>,
        "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>,
        "RUAN Tingquan (BT-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>
Subject: Re: [PATCH v5] Input: add bu21029 touch driver
Thread-Topic: [PATCH v5] Input: add bu21029 touch driver
Thread-Index: AdQEtL7RQCg/6r2vTbqVlvssv9t8Uw==
Date:   Fri, 15 Jun 2018 14:26:19 +0000
Message-ID: <df1d4c275c554533944cc17cec7e93ed@de.bosch.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.19.142.147]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA21TbUxTVxjm9N6WS9fLblsL7zq76UUmulERXbzRZWMu2/qDLC4ubpMlrow7
        2ggt6W0bYUuGmyh2uiEfK5QCIoM1DCY2MD786FYhQnGiEhEmihN0WnHZVBTJgmu5YPtj/573
        ed/nfc55Tg6ByToJJaE3mFmTQZtFi8S4eH2zKnHX6bi0pLaKZOZW0UnE1HSfETInD91ETMfo
        GMaM3H0gZAa7nCKm/uI5AVNwvDuSqR+oQylRmvqRs7imqboJaaodvbim03E5UuNu3CvS3HM/
        t0m0VfxKBpult7KmVa9+LNZ5vh0X5FyX7NjZ1Ybno2KxDREEUGuhcUhjQ2JCRpUL4Ni5IQFf
        nEDgLnWJ+OIOAq/jKMYXvyB4dPx8pA1FESJqPexp6J/Di6hV0F45g4JDGDWJw797ZrBgQ06t
        g97J2vkhBhoGjgh4rIbKbu8cj1PxYB+9JApiktoAVWfG5mYQpYKWloG5PRgVC+4bD4VBDBQF
        3x/jeaAUcGt8VsjfZyk4yzfy42oYLisV8fhFaKi9jfHrpdBXMYEXIYUjbKsjTOIIkzjCJAcR
        3ogUnD7Jmp2cxCSrTeksl5e0Wv2JMduN+LeM6UBf/ZrhRRSBaAmp9MalyYRaK5eb7UUvEwJa
        QVbbA1R0ujEjV6fldNtMliyWo5UkioiIkMmf0JwlPVvPcXqjwYuAwOhF5H4znSYjM7S5eazJ
        yMu86FkCp2PJiZS/t8qoTK2Z3c6yOaxpobuBIGgglf0BQ6mJzWR3fKrPMi+0aRXvGRPeCbcV
        EFFetIaQBLz/8gVWkFyONpvTZ87Ln+HlsgU2JPWhN4jJ3fv2YTLcYDSwyliyMHgEKjipsxie
        nEC5mExrXZImU4Q1Qlv8aAQFMpSTUUGxJPBlQt5AdsidH8qk82RIlFwf0FCVBIw9KEXgGRlE
        cHj2DgZ995tFMOV4HAl+zyMCpptcYjhSf+IpKKj9UwLTF3wklFy+SoKnsjgavrlSGw0zFWVP
        w67b1RSMVu2Vws3yTikMu3oV0GI/HAMllzpi4ZpjWgmzA92LYaLvn+fh6LWCOCiua10GLudM
        PJyuOvUC3Lt7cTl42u0roPBg90twf+pUIlw5O5zoDwQrCATb07MkGKxZa/6fYOfZ0O2U+ags
        5e3PbHkJ1I0D599a+9OXBV8nLi2Jc71j/uD6axuLvnv8+tX3p3x6S69N/Vuievvvvizr522H
        TNb36grzNezumv4xQ4Jqsu/AINjf3Nwljx7a/O42f/zY9AXFTsNHqtShTT+v9Cc0/7Bist2Y
        N7AlxfJj6hrx8tQ/mrEvanrG929pdS6jcU6nXb0SM3Ha/wAyvHYHzAQAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

> > > > [PATCH v5] Input: add bu21029 touch driver
> > > >
> > > > Add Rohm BU21029 resistive touch panel controller support with I2C
> > > > interface.
> > >
> > > Is the patch ready to be pushed upstream? Is there anything I still n=
eed to do?
> >
> > I would like to kindly remind you of the BU21029 touch screen driver.
> > Could you please forward it to the mainline kernel?
>=20
> Sorry for the delay. Could you please tell me if the patch below (shoudl
> apply on top of your v5 version) works?

Yes, the patch works. We applied and compiled it with 4.14 and
4.17-rc3. We tested on our hardware with 4.14.

Only for 4.14 an #include <linux/regulator/consumer.h> was missing. I
Guess the API changed here a little in the meantime.

Because we do not have a controllable power supply on our board we see
the following complaint. But I think it is intentional and ok, right?

	[    1.715963] bu21029 0-0040: 0-0040 supply vdd not found, using dummy re=
gulator
	[    1.723806] input: bu21029 as /devices/soc0/soc/2100000.aips-bus/21a000=
0.i2c/i2c-0/0-0040/input/input0=20

> + - vdd-supply              : power supply for the controoler

There is a typo in controller.

What's the next step?

Greetings,
Mark

Building Technologies, Panel Software Fire (BT-FIR/ENG1)=20
Bosch Sicherheitssysteme GmbH | Postfach 11 11 | 85626 Grasbrunn | GERMANY =
| www.boschsecurity.com

Sitz: Stuttgart, Registergericht: Amtsgericht Stuttgart HRB 23118=20
Aufsichtsratsvorsitzender: Stefan Hartung; Gesch=E4ftsf=FChrung: Gert van I=
peren, Andreas Bartz, Thomas Quante, Bernhard Schuster
