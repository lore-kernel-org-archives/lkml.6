Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5089C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582472086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="L1N99fmU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582472086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbeJKFLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 01:11:52 -0400
Received: from mail-dm3nam03on0099.outbound.protection.outlook.com ([104.47.41.99]:19036
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725841AbeJKFLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 01:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3C9P21xUNmZVx0xsB2doFNvZKBWI75OxecCdksHp9vk=;
 b=L1N99fmUQXbh3KpYitf3Sn+rYZW81j6bIgDnhqmewyHDsaMx7n7CLn+IZi6+9j+bp4Xdstqss4joiwJenKaQVLkrtuVa03vtYx1VRV8HRIo02HmdKuTq4c3uGhG4zfyhPtTUjyTTE1C/EcaxR7D7lDKbPtw12Ippi4W5CiYrLoE=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3593.namprd06.prod.outlook.com (10.167.173.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.26; Wed, 10 Oct 2018 21:47:44 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f4ee:3633:74c0:ab4]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f4ee:3633:74c0:ab4%3]) with mapi id 15.20.1228.020; Wed, 10 Oct 2018
 21:47:44 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@vger.kernel.org" <linux-mtd@vger.kernel.org>
Subject: Re: [PATCH 3/3] eeprom: at25: Split writes in two SPI transfers to
 optimize DMA
Thread-Topic: [PATCH 3/3] eeprom: at25: Split writes in two SPI transfers to
 optimize DMA
Thread-Index: AQHUYJ7cjQhJphA9VkO7UPnHFHxntKUZBIGA
Date:   Wed, 10 Oct 2018 21:47:44 +0000
Message-ID: <1539208063.1944.12.camel@impinj.com>
References: <20181010134036.8296-1-geert+renesas@glider.be>
         <20181010134036.8296-4-geert+renesas@glider.be>
In-Reply-To: <20181010134036.8296-4-geert+renesas@glider.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3593;6:Eopvi0FyeAXqDJQIKN5yJLkwfvEE9CHI25kmcm8BfM/IJSdiUNiTIxA3N+qK+QawS2eIceTgtdlcL+uLA9QqxBKBb+JoMUoABKfR16hfC9yPXsYM3TzWOAy1E1I+p7W7z6oPxTyxCPZRUQH1tMhGbrdYVA+7DwYX4DTCuffZTqj0E9+emvDlBP/+xOPtwz+SDGEck/zZt/8ndi0Cjc+S/4fyP6cUtOuW5t/b5oopJwLAo7iVdyi041iuGVj7W/1Lm50ZPxyKegPs1OqS2XkYs5OUUMnWb2+rz4U+3teZXHAyDxeYXJ8GgrzLj96g0N26+L1Tt7UJg8n9Q9LPhSM4qq4/AypeROW5gpqZLmNltVe9SwPyu6vJJKp6SOx8XtNFsWrJVFk3XbJZQSR+E3nl41U7htgLE8vMLX5wKe9k7l60z6+l3YWOErUR2ZerWBTo7Yrm/Xegzjw1rgo/34f05g==;5:36VW4xf11975+IZl3sUMjUhjZoDluPkITPZiUqfJTJW0jHvl5LeFaVUp4jdKC0fFUuF+UoN59KnfExULI8J9d1NAIGoiA499aBE/f/N5jEY4SQwVmpGNRBW8yrl6QZbe5EWkiz2yZuySTFsXaLIwrALGNlvPwt035VAnCoVv3uw=;7:pnMCtuEPptIEY/AEWPwn/siOz3BCWWXDiYkpT9eWy6L98h6G+Dzsk8o2GHCV8L4OLQhUnNlzxy5oujhIQ+qtqg3Vaqaa+7MvCczk9AafdWPJF1QnJeIO/m2mMpet6pfLZVfL49I0MvzgHbqRo3rCSuB8dCBHJju0f++SYoKVLP5CvAMP+y9qB8t5jkI3eTMpDjaapsgWoCXE67q7SYuj0pJe7OLAjxUEEODACosqPIyuVwTUpojO2UuV/fOkvrJj
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 12756719-6f37-4128-b2cb-08d62efa02b9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3593;
x-ms-traffictypediagnostic: MWHPR0601MB3593:
x-microsoft-antispam-prvs: <MWHPR0601MB35931E79211800C7F161935CD3E00@MWHPR0601MB3593.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:MWHPR0601MB3593;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3593;
x-forefront-prvs: 08213D42D3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(366004)(39850400004)(346002)(376002)(199004)(189003)(102836004)(110136005)(8676002)(66066001)(53936002)(25786009)(6246003)(54906003)(6506007)(76176011)(6436002)(36756003)(105586002)(99286004)(4326008)(186003)(2201001)(106356001)(2616005)(476003)(446003)(6486002)(256004)(11346002)(86362001)(5660300001)(5250100002)(14454004)(316002)(71190400001)(71200400001)(229853002)(7736002)(2906002)(305945005)(26005)(6116002)(478600001)(6512007)(8936002)(3846002)(486006)(81156014)(103116003)(68736007)(97736004)(2900100001)(81166006)(4001150100001)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3593;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gwnb5GF64DvtOm5L160wLmGJXTkEVFcDVIoZu9c/SPPXNUu+iDWXtRFb7VL8iUMX0o63lAGB7/EYpOx59yeCpQaxKO+k45r222tMvbIfUw28N+Va84PjAH1Mii6zW2HECF4gLt3WxLmxAljTeQvngZ+fzLURkJjqkyMccj/AJJsAgFxTnUPEVvxukxI6vNX8sAutPIDzaLT1ieY90zgLh7hhknIClS7cawQJDDXk8GCCughBI4vrCWUEXq2pXUOyxLzZd2WCwOL1AR7QXoK5cklnZ4WBCszc3t0IzcD46KK7GRTTrdXbcd0vqICyqL4aDifA0k5jDGV96NbSVq1vrEyehd9YJgS7y2cVr/nmtU8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD31C196B848E14FB1B404D2DC096035@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12756719-6f37-4128-b2cb-08d62efa02b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2018 21:47:44.0939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3593
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTEwLTEwIGF0IDE1OjQwICswMjAwLCBHZWVydCBVeXR0ZXJob2V2ZW4gd3Jv
dGU6DQo+IEN1cnJlbnRseSBFRVBST00gd3JpdGVzIGFyZSBpbXBsZW1lbnRlZCB1c2luZyBhIHNp
bmdsZSBTUEkgdHJhbnNmZXIsDQo+IHdoaWNoIGNvbnRhaW5zIGFsbCBvZiBjb21tYW5kLCBhZGRy
ZXNzLCBhbmQgcGF5bG9hZCBkYXRhIGJ5dGVzLg0KPiBBcyBzb21lIFNQSSBjb250cm9sbGVycyBp
bXBvc2UgbGltaXRhdGlvbnMgb24gdHJhbnNmZXJzIHdpdGggcmVzcGVjdCB0bw0KPiB0aGUgdXNl
IG9mIERNQSwgdGhleSBtYXkgaGF2ZSB0byBmYWxsIGJhY2sgdG8gUElPLiBFLmcuIERNQSBtYXkg
cmVxdWlyZQ0KPiB0aGUgdHJhbnNmZXIgbGVuZ3RoIHRvIGJlIGEgbXVsdGlwbGUgb2YgNCBieXRl
cy4NCj4gDQo+IE9wdGltaXplIHdyaXRlcyBmb3IgRE1BIGJ5IHNwbGl0dGluZyB3cml0ZXMgaW4g
dHdvIFNQSSB0cmFuc2ZlcnM6DQo+ICAgLSBUaGUgZmlyc3QgdHJhbnNmZXIgY29udGFpbnMgY29t
bWFuZCBhbmQgYWRkcmVzcyBieXRlcywNCj4gICAtIFRoZSBzZWNvbmQgdHJhbnNmZXIgY29udGFp
bnMgdGhlIGFjdHVhbCBwYXlsb2FkIGRhdGEsIG5vdyBzdG9yZWQgYXQNCj4gICAgIHRoZSBzdGFy
dCBvZiB0aGUgKGttYWxsb2MoKSBhbGlnbmVkKSBidWZmZXIsIHRvIGltcHJvdmUgcGF5bG9hZA0K
PiAgICAgYWxpZ25tZW50Lg0KDQpEb2VzIHRoaXMgYWx3YXlzIG9wdGltaXplPyAgQSBtYXN0ZXIg
Y2FwYWJsZSBvZiBhbiBvZiBhbGlnbmVkIDE4IGJ5dGUNCkRNQSB4ZmVyIHdvdWxkIG5vdyBoYXZl
IGEgMiBieXRlIHhmZXIgdGhhdCB3b3VsZCBwcm9iYWJseSBiZSBQSU8NCmZvbGxvd2VkIGJ5IGEg
MTYgYnl0ZSBETUEuDQoNCk9yIHdyaXRpbmcgMTQgYnl0ZXMgdG8gdGhlIEVFUFJPTSBoYXMgY2hh
bmdlZCBmcm9tIGFuIGFsaWduZWQgMTYgYnl0ZQ0Kd3JpdGUgdG8gYSAyIGJ5dGUgYW5kIGEgMTQg
Ynl0ZSwgd2hpY2ggaXMgbm93IHdvcnNlIGZvciB0aGUgNCBieXRlDQptdWx0aXBsZSByZXF1aXJl
bWVudCBtYXN0ZXIgd2hpY2ggY2FuIHVzZSBhbnkgRE1BIGFueW1vcmUuDQoNCkl0IHNlZW1zIGxp
a2UgYW4gZW5oYW5jZW1lbnQgdG8gdGhlIERNQSBjb2RlIHRvIGxvb2sgbW9yZSBsaWtlIGENCmVm
ZmljaWVudCBtZW1jcHkoKSB0aGF0IGFsaWducyB0aGUgYWRkcmVzcywgdGhlbiB4ZmVycyBlZmZp
Y2llbnQNCmJsb2NrcywgdGhlbiBmaW5pc2hlcyB0aGUgc3ViLWJsb2NrIHRhaWwgd291bGQgYmUg
bW9yZSBnZW5lcmFsbHkNCmFwcGxpY2FibGUuDQoNCk9yIG1vcmUgc2ltcGx5LCBnaXZlbiBhbiBh
bGlnbmVkIDE4IGJ5dGUgeGZlciwgdGhlIGRyaXZlciBzaG91bGQgZG8gYW4NCmFsaWduZWQgMTYg
Ynl0ZSBETUEgYW5kIHRoZW4gdHdvIG1vcmUgYnl0ZXMuDQo=
