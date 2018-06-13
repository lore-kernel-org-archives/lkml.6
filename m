Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BEF1EC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9E220693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="eKiV8r59"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B9E220693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.bosch.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935938AbeFMP1V (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:27:21 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:42106 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935691AbeFMP1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:27:18 -0400
Received: from si0vm1948.rbesz01.com (unknown [139.15.230.188])
        by si0vms0217.rbdmz01.com (Postfix) with ESMTPS id 415Vx12pLWz4f3kp0;
        Wed, 13 Jun 2018 17:27:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=de.bosch.com;
        s=2015-01-21; t=1528903637;
        bh=HOaT1hrdMtb1781JxR/wpK0GpltgC8HtsieGbtWl1ek=; l=10;
        h=From:From:Reply-To:Sender;
        b=eKiV8r59pzbwUCc8ELQMcbiLVZdcIXFcM7qjg4EmVIyMr4fgHkCJap3THVrNdfAX+
         p5NBtXA10KXtC4oQlngBJNMM3aetrwmO/IFmBcwEoIAjYKXuDNwMp2i6gveyhGBqRB
         dV9WQryaP6C5MoDC3e0Yl9vPU82NUzYsbq8EfJJo=
Received: from fe0vm1741.rbesz01.com (unknown [10.58.172.176])
        by si0vm1948.rbesz01.com (Postfix) with ESMTPS id 415Vx12ch4z4fw;
        Wed, 13 Jun 2018 17:27:17 +0200 (CEST)
X-AuditID: 0a3aad15-9f3ff70000007ca2-e1-5b2137de4e8e
Received: from fe0vm1652.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by fe0vm1741.rbesz01.com (SMG Outbound) with SMTP id 46.66.31906.ED7312B5; Wed, 13 Jun 2018 17:27:26 +0200 (CEST)
Received: from FE-MBX2051.de.bosch.com (fe-mbx2051.de.bosch.com [10.3.231.61])
        by fe0vm1652.rbesz01.com (Postfix) with ESMTPS id 415Vx10gKQzBpBg;
        Wed, 13 Jun 2018 17:27:17 +0200 (CEST)
Received: from FE-MBX2051.de.bosch.com (10.3.231.61) by
 FE-MBX2051.de.bosch.com (10.3.231.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1466.3; Wed, 13 Jun 2018 17:27:16 +0200
Received: from FE-MBX2051.de.bosch.com ([fe80::d5b5:44fa:ef15:153e]) by
 FE-MBX2051.de.bosch.com ([fe80::d5b5:44fa:ef15:153e%6]) with mapi id
 15.01.1466.008; Wed, 13 Jun 2018 17:27:16 +0200
From:   "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hs@denx.de" <hs@denx.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "ZHU Yi (BT-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>,
        "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Subject: Re: [PATCH v5] Input: add bu21029 touch driver
Thread-Topic: [PATCH v5] Input: add bu21029 touch driver
Thread-Index: AdQDKorsQCg/6r2vTbqVlvssv9t8Uw==
Date:   Wed, 13 Jun 2018 15:27:16 +0000
Message-ID: <73b4ea3ce1aa453681fae87b7bad5cab@de.bosch.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.19.142.147]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA21TbUxTVxjm9N6WS8OF21s73tWxSDOXxc2u3dxo1CzEzQR/IGxLMErUlfVK
        u/WD9FIGxmxkRmYVJ9nESQFpGXRIcHVlP9gAu5XqUDMMY0yILXOwzVYri4qVbLPulgu2P/bv
        Oc/7PO/znvfkEBjtIeSEwVzFWM1ao0IkxsXrT+eunc7PK1NNHpdoIo3DSNMeGBVqhjvCSNMf
        /BXTTN2JCTXj37aKNF1XxgSaA0OB9AKisPdkLyo86RjBC79xhNILvT12UeFd75Mlwh3ijTrG
        aKhmrM+/8pZYP9DUgSqPimriP3pRHfoXP4QyCKDWwfwv8UVMUycEcLVNegiJOTyI4LMjXwj4
        wy0EA1fvpPOH7xAMfmjHEhYRtR4+cl9KT+AVVA08cAeECRFG1WHgPt8iSBSkVD6MRF1LIg24
        L38l4LESZvumF7NxajUcCNpRApPUBnj408CiHlG5cObM5cUwjMoB75/3hfzcFHQO8jxQMojM
        xjme4HAetJ7YxMuVMNl0TMTjZ8Htuonx7SVwofl3vBHJHCldHSkWR4rFkWJxIrwHyfYwqmqT
        On+dWmktZ9i9KrXybYvJi/gXlPUjl6vUjygCKTLJDFVeGS3UVrO1Jj96iRAoZOTWxlVldFa5
        RVer17L63VabkWEVchKlpaXR0kc0ays3GVjWYDH7ERCYYgW5Ncz5SJ22di9jtfA2P1pJ4Ioc
        skG3bwdNVWirmHcZppKxLlc3EIQCyCMvczNIrEwFU7PHYKxaLity+czHUiupsQIiw49eJDK5
        7MOJFiRbqTWxhool++O8nV5mk9aL6FUiWt/QgNG42WJm5Dlkd8JPJZR6m/nRBPInyLKvuUvJ
        UgrJLjfQFOJ2KCUzuB9BZ3IfJZkNZL+0dTstWSKTphe6OA91HQff1DgCT/wWBgsTF0nwtXyS
        BR9Pu7Lg7+ambAi22SUw2T0ig4POwHMwf++HtXAlOqbiJH9o4PZR5yYIeEKvwcC1qc1wbM6+
        BXwXWrfAl/XeIug//n0R2AOuYmg61fImhJ1DpRCMdm2Hg/H9u8DX7t8Nkd52HUR6QhUQHBwz
        QPifNhN8er2ehanpPhYWHGffv8EtVsAt9ty5xKOyVdqq/1nsEpu8nbwOda95T/iUMf+voaJd
        tpnRvlhD9l00kXn/NIFFz8qZ5gZccHtbbP78Bw+k48qh2LaHJfuLI6MdodynRTPPxPrUE6s2
        3tw8HHV2zoR39ouyOwOnZsNvwM/vkKV220p18aXQvRp3vMS6eo54vYbed/jzDk+OpxNHBQu/
        7dQW+OzX5hQ4q9eq12BWVvsfH+ysLMIEAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dmitry,

> > [PATCH v5] Input: add bu21029 touch driver
> >
> > Add Rohm BU21029 resistive touch panel controller support with I2C
> > interface.
>=20
> Is the patch ready to be pushed upstream? Is there anything I still need =
to do?

I would like to kindly remind you of the BU21029 touch screen driver.
Could you please forward it to the mainline kernel?

Greetings,
Mark

 Mark Jonas

Building Technologies, Panel Software Fire (BT-FIR/ENG1)=20
Bosch Sicherheitssysteme GmbH | Postfach 11 11 | 85626 Grasbrunn | GERMANY =
| www.boschsecurity.com

Sitz: Stuttgart, Registergericht: Amtsgericht Stuttgart HRB 23118=20
Aufsichtsratsvorsitzender: Stefan Hartung; Gesch=E4ftsf=FChrung: Gert van I=
peren, Andreas Bartz, Thomas Quante, Bernhard Schuster
