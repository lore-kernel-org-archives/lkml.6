Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148E4C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B559C20851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="DW5MC0yx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B559C20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbeLCKWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:22:03 -0500
Received: from mail-eopbgr50097.outbound.protection.outlook.com ([40.107.5.97]:15393
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726039AbeLCKWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:22:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAByDQP+mfQRQFw5/jDvORfGMc4k8oyV/HKt1fUXXc8=;
 b=DW5MC0yxbCtZMPMVmfnqlRNMtbY5OLYEfccI2MumB1i1WEUn/3OHqoLdszdz7rhtN1bRsUOZQ0oEUor2/gW3F/50Mf+EdtWS1F2LDpAKED/Y0h7vmdZGUWN7Nao9u9aWSKNG/ZcDNyuVs/3TUs7vn6uQsVC9BANHwNL0/2KH0jg=
Received: from VI1PR07MB5085.eurprd07.prod.outlook.com (20.177.203.157) by
 VI1PR07MB5133.eurprd07.prod.outlook.com (20.178.9.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.14; Mon, 3 Dec 2018 10:20:51 +0000
Received: from VI1PR07MB5085.eurprd07.prod.outlook.com
 ([fe80::7d44:e1e4:2a0a:4a8f]) by VI1PR07MB5085.eurprd07.prod.outlook.com
 ([fe80::7d44:e1e4:2a0a:4a8f%5]) with mapi id 15.20.1404.016; Mon, 3 Dec 2018
 10:20:51 +0000
From:   "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>,
        Tobias Jordan <Tobias.Jordan@elektrobit.com>,
        Peter Rosin <peda@axentia.se>,
        Anders Berg <anders.berg@lsi.com>
Subject: Re: [PATCH] i2c-axxia: properly handle master timeout
Thread-Topic: [PATCH] i2c-axxia: properly handle master timeout
Thread-Index: AQHUfa+0yU5CDqRvp0O+anAOl9uWAqVjnZCAgAlKpYA=
Date:   Mon, 3 Dec 2018 10:20:51 +0000
Message-ID: <d80cca69-26e7-8af7-bf42-8ccb0d44a374@nokia.com>
References: <20181116132334.GA3951@localhost.localdomain>
 <20181127122649.GL1107@kunai>
In-Reply-To: <20181127122649.GL1107@kunai>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0101CA0012.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::22) To VI1PR07MB5085.eurprd07.prod.outlook.com
 (2603:10a6:803:9e::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [131.228.32.168]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR07MB5133;6:ji+JZS1bB5Uhcd+jjpQ9fP17uvlB1LJ8OPZ+aDj3ZoJqUXTmYeYdqQVQ/WM7EmE3IBRsn9ijNExRDDkYK5qWPT8qrzVCT0+wmLpQhsFmjhq+qPgYkzCCuJLWszm/OC3rG+1TSfPftFZpvk+/7MPcc2bWwzYmtTnWBzup8/jZSsnI4l66Dg52W/SvHwQloW2KhtJvqL2Jus3Ef37tg5faGxjNHK9ioSQNZM3CSmTgKy2juI1NW56m2fo5Z9yZ1MHooDgGDEnLAqXV+43CfSribSwJI9EDdYN/RCCsXlp4Wz4pVkiBOwKSDrDSBochjvZz98We+dH2EKEj1T0eQWnBmvVMdbibM3StWKWUXOjVibEkopj2p0m0Zj3oZEIAlXie69g6AifGxIJy9INlJ0h1owhwAAHVwdtjrQJ//oT1GsWGtNk8g7I7eRxuu8Tl8p9YXuJf63WJyitMNe+FAqffug==;5:XwK+iatBnkKyFg/Jl82RzwJX6EHcaRxGQNpOarmciJt0pOBVOxuXhoNtA1pn3K+RpDx164SYT78YKe2+x04qUxOW6UhkIdrTXU9k1vQNWR8OOoUzcqB0H/EZz6uoBMO/SrLahJ4QDWDccwAhPi4dHJvQETjNC/Ggltzr4eVYFZ0=;7:TF7qzuWBwN6OelE4Vg+jhDI3XdfYpAe3bBOP+RSGBLQRP6xIw/aGdf0pp3axZ0q0K9/oc2/hhQ5chE07Q/9MKgZ4lXaxaWxLVFtiBBcjJSOpyENRkEx2H+yKtBNfzioKRWHGe7wDa0MENHynY1AmJg==
x-ms-office365-filtering-correlation-id: 72d4a55c-3f42-414a-e7e2-08d65908fee8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR07MB5133;
x-ms-traffictypediagnostic: VI1PR07MB5133:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=krzysztof.adamski@nokia.com; 
x-microsoft-antispam-prvs: <VI1PR07MB5133887C064A1921343FBBF4EFAE0@VI1PR07MB5133.eurprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(11241501185)(806100)(944501493)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR07MB5133;BCL:0;PCL:0;RULEID:;SRVR:VI1PR07MB5133;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(346002)(136003)(39860400002)(199004)(189003)(51914003)(68736007)(31686004)(6486002)(105586002)(106356001)(6436002)(97736004)(486006)(99286004)(14454004)(86362001)(102836004)(71200400001)(25786009)(476003)(71190400001)(31696002)(229853002)(7736002)(478600001)(2616005)(66066001)(305945005)(186003)(36756003)(386003)(6506007)(2906002)(11346002)(53936002)(6512007)(6246003)(6916009)(4326008)(446003)(5660300001)(8676002)(52116002)(14444005)(76176011)(256004)(8936002)(26005)(54906003)(81166006)(316002)(81156014)(551934003)(3846002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB5133;H:VI1PR07MB5085.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: blGgcA+XFzRvQP+2LznaUeAd8I16z8P3NIZ4v4hm+PzhBpVO/SziGrK8f5Fv2W2BxfqFsBaGWaj9yCQ/vH48c2m6Ot+kmzksz5qFL6fvOMzknefPRfhcrf8QZ15J7eBwKdJxNeXsPmNwo09tgCLcBEMlPnMWzLPrs2cf5ZIES17TPeo1d/anXijnfXiWd40a91CVbcASac+pi0y583QykK7hg96jyfh0fHo04eH7plJYAWAJ0je1CwmGwXGL7CmbNLcWnT8qV8cuglLh+MLEEybZDEGq3k79J/DCZ+P7MRfCM1ny+OdkAkpomkbnmpFVaykncj+GW850NCn5rZ9WKK9Znf3Msy6NJyIVHHqjO8g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <CB29AFA95D10254F87D8B785D9540C11@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d4a55c-3f42-414a-e7e2-08d65908fee8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 10:20:51.6417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB5133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

W dniu 27.11.2018 o=A013:26, Wolfram Sang pisze:
> On Fri, Nov 16, 2018 at 01:24:41PM +0000, Adamski, Krzysztof (Nokia - PL/=
Wroclaw) wrote:
>> According to Intel (R) Axxia TM Lionfish Communication Processor
>> Peripheral Subsystem Hardware Reference Manual, the AXXIA I2C module
>> have a programmable Master Wait Timer, which among others, checks the
>> time between commands send in manual mode. When a timeout (25ms) passes,
>> TSS bit is set in Master Interrupt Status register and a Stop command is
>> issued by the hardware.
>>
>> The axxia_i2c_xfer(), does not properly handle this situation, however.
>> For each message a separate axxia_i2c_xfer_msg() is called and this
>> function incorrectly assumes that any interrupt might happen only when
>> waiting for completion. This is mostly correct but there is one
>> exception - a master timeout can trigger if enough time has passed
>> between individual transfers. It will, by definition, happen between
>> transfers when the interrupts are disabled by the code. If that happens,
>> the hardware issues Stop command.
>>
>> The interrupt indicating timeout will not be triggered as soon as we
>> enable them since the Master Interrupt Status is cleared when master
>> mode is entered again (which happens before enabling irqs) meaning this
>> error is lost and the transfer is continued even though the Stop was
>> issued on the bus. The subsequent operations completes without error but
>> a bogus value (0xFF in case of read) is read as the client device is
>> confused because aborted transfer. No error is returned from
>> master_xfer() making caller believe that a valid value was read.
>>
>> To fix the problem, the TSS bit (indicating timeout) in Master Interrupt
>> Status register is checked before each transfer. If it is set, there was
>> a timeout before this transfer and (as described above) the hardware
>> already issued Stop command so the transaction should be aborted thus
>> -ETIMEOUT is returned from the master_xfer() callback. In order to be
>> sure no timeout was issued we can't just read the status just before
>> starting new transaction as there will always be a small window of time
>> (few CPU cycles at best) where this might still happen. For this reason
>> we have to temporally disable the timer before checking for TSS bit.
>> Disabling it will, however, clear the TSS bit so in order to preserve
>> that information, we have to read it in ISR so we have to ensure that
>> the TSS interrupt is not masked between transfers of one transaction.
>> There is no need to call bus recovery or controller reinitialization if
>> that happens so it's skipped.
>>
>> Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
>> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> Applied to for-current, thanks!
>
> Since you and/or Alexander are the ones doing functional changes to this
> driver, would you be interested in maintaining it? This would ensure you
> get notified when someone else has patches for it.

Thanks for the offer. Since I think I became quite familiar with
his code and the hardware itself and we do have an interest real
interest in this driver, I think it is a good idea. I will send
a patch to MAINTAINERS soon.

Krzysztof
