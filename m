Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5C018C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 14:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 093E920896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 14:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="byqOgaO/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 093E920896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.bosch.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756227AbeFOO2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 10:28:37 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:52864 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756005AbeFOO2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 10:28:34 -0400
Received: from fe0vm1650.rbesz01.com (unknown [139.15.230.188])
        by fe0vms0186.rbdmz01.com (Postfix) with ESMTPS id 416jXK2dyDz1XLFjK;
        Fri, 15 Jun 2018 16:28:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=de.bosch.com;
        s=2015-01-21; t=1529072913;
        bh=i9jJeFoYPhV6nkBu4CxI188Ht54+ZxBWJ0nMMevJtzs=; l=10;
        h=From:From:Reply-To:Sender;
        b=byqOgaO/3WxcZZhkVwmGBrvD9SHEaBBXh7nTix1tzOGhlAk4Nop2jz5oax9CJIu1I
         gi0OKKEYi6J1BO7jPyGrHw6VG5IytScQEtCGmFiW2vrd4l29Tq6xAzvk/WtsjaxK7O
         NOf56MRdx355t3zVckE4JxYPaX1Z5u/vSPvZNxB4=
Received: from fe0vm1740.rbesz01.com (unknown [10.58.172.176])
        by fe0vm1650.rbesz01.com (Postfix) with ESMTPS id 416jXK2G68z1W4;
        Fri, 15 Jun 2018 16:28:33 +0200 (CEST)
X-AuditID: 0a3aad14-93dff70000003a2f-8d-5b23cd1d1309
Received: from si0vm1950.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by fe0vm1740.rbesz01.com (SMG Outbound) with SMTP id 80.4D.14895.D1DC32B5; Fri, 15 Jun 2018 16:28:45 +0200 (CEST)
Received: from FE-MBX2036.de.bosch.com (fe-mbx2036.de.bosch.com [10.3.231.46])
        by si0vm1950.rbesz01.com (Postfix) with ESMTPS id 416jXK0JLKzCpP8;
        Fri, 15 Jun 2018 16:28:33 +0200 (CEST)
Received: from SGPMBX2031.APAC.bosch.com (10.187.56.92) by
 FE-MBX2036.de.bosch.com (10.3.231.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1466.3; Fri, 15 Jun 2018 16:28:32 +0200
Received: from FE-MBX2051.de.bosch.com (10.3.231.61) by
 SGPMBX2031.APAC.bosch.com (10.187.56.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1466.3; Fri, 15 Jun 2018 22:28:29 +0800
Received: from FE-MBX2051.de.bosch.com ([fe80::d5b5:44fa:ef15:153e]) by
 FE-MBX2051.de.bosch.com ([fe80::d5b5:44fa:ef15:153e%6]) with mapi id
 15.01.1466.008; Fri, 15 Jun 2018 16:28:27 +0200
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
        "RUAN Tingquan (BT-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>
Subject: AW: [PATCH v5] Input: add bu21029 touch driver
Thread-Topic: [PATCH v5] Input: add bu21029 touch driver
Thread-Index: AdQEtL7RQCg/6r2vTbqVlvssv9t8UwAADJCw
Date:   Fri, 15 Jun 2018 14:28:27 +0000
Message-ID: <2a68611474694fb2b68146d8d167bf26@de.bosch.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.19.142.147]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA21TfUwbZRjv2zvKgRweLYxnVcbsookzfM2ZnUPnMuNSxQkSY7I1isc4aJW2
        pFcQiH8wJ4xNnKwOx0phG/NYJMCgEukErSuQ0SIy5GOQAHMZQzr2IbKPBBPmlYO1f/jPm+f5
        fTy/930uR2DyfkJJ6Axm1mRgclWyUDx0e3NMXMzAJk3i2FQE7a3sRvSpnt+D6O76OUQ7Jq9i
        9MQ/D4Lo4Z9sMpq/MiSlS3/uCab5wbNoZ4ian7iMq5vqmpC6ztqHqy9Yp4LV9sbDMvWifUOa
        bF/oK1lsrq6ANSXs+ChU6yy/Js3rxwu/KavESpAXO4IIAqit8KBv8xEUSsipaim4xy0yselC
        MDd7ARebvxGc/rHV31R/cWy1+RXBvaEaoQkhZNR2ONTQH+yrI6kE6KhZQj4RRrXjMFZRKfMR
        CmobTP41JhNFNDQMtknFegssXbFivhqnngV+YGFFQ1LJcMw9sxKAqBhobR1c0WBUNNhnHwb5
        aqAo+K5LxIGKAu/15SDxcc+ArXqXKI+H8arjMrF+ARrOzGPi+Ahwn5zBK9E6a8BUa4DFGmCx
        BlhOI7wRRWWziQX6pG1bE+NNmSxXnJgUv9+otyPxw0Y6kOValgtRBFKFkXGuTRp5EFPAFeld
        6CVCqooi604IUHimMatIy3DaDFN+LsuplCSSSCRyxWOYy8/U6zhOZzS4EBCYKpL8yqzSyMks
        pqiYNRlFmws9ReCqaLK8ybtPTuUwZvYTls1jTWtsMkGogBzvFwIjTGwOW5ityzWv0aoYMXNd
        IBMYKyVCXOhFIkzInvaNILk8Rs/pclbt60W7fA31Wz3odeJWWUUFJscNRgOrjCa9Pj/lU2rz
        DY9voHya1LRv1MijAgj/lJtoGgk7VJCLPnOY8P/4s4F0KGx75RGroN+0pVHwUMdxcE4MIzi/
        fBuD+9ZHwdDG//IEOGss4bB0supJGLnTooD24aUNMONeiAVnx4nn4d79S3FwdPoGDd6mqzuh
        88+JN8Dptr0JdUctb0NLmX0POL69uAcO95xJhXIXnw6Tt/i9UL588ENwnnJlwB3PDwws3m3U
        wh9LD3Uw92+tHrq+vnQAwWLfgc8RjHQeEk7LYKNwPiobLUU3he1Khe329m70bdfMmP9nu6uo
        /4nKEiTZz/Pd52amNBL+yw8GMLcnfIw72zuQ8mrtdd3FXSUjL7+T4agqnkhPnb/7aW1/tW32
        YEr0c5ezjUTza4wkrcVz+7fRhti2ud2y9annPW91fDZf646l04Y8o9KPbTE74h2Fnab67vc7
        Ukbtyeml794wnpv7fqE5oVKJ7X6vnurjp1Q4p2WSNmMmjvkP28fO794EAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Correction:

> Only for 4.14 an #include <linux/regulator/consumer.h> was missing. I
> Guess the API changed here a little in the meantime.

The missing include is #include <linux/irq.h>.

Greetings,
Mark

Building Technologies, Panel Software Fire (BT-FIR/ENG1)
Bosch Sicherheitssysteme GmbH | Postfach 11 11 | 85626 Grasbrunn | GERMANY =
| www.boschsecurity.com

Sitz: Stuttgart, Registergericht: Amtsgericht Stuttgart HRB 23118
Aufsichtsratsvorsitzender: Stefan Hartung; Gesch=E4ftsf=FChrung: Gert van I=
peren, Andreas Bartz, Thomas Quante, Bernhard Schuster
