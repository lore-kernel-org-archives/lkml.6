Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81376C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 03:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21EA820840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 03:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="IkSrXxT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731435AbfAPDhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 22:37:40 -0500
Received: from mail-oln040092006075.outbound.protection.outlook.com ([40.92.6.75]:6140
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731278AbfAPDhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 22:37:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8OkHIne67zRmweAENW8r/22Rs4pHee8MxWrT4rhgEc=;
 b=IkSrXxT73Bz1XLdvQo/SaXjWUZIKIo/vL8P6ctkrz6wn5zYrkuhlorxf4CEGS4LaFnUwdmNnOflsGBEoSDhpiEhXMYqV25rPSyUE7YS/vm7Buxr9OqQdAHTPFgnz+o/iKr9QPBRcoi16hYmYe9PA3brLlcC5XrB0b0F1+rFoM7xg3je91TwOirHf9Hq8N3LZ/GcXahlWY9dBv7U0ZXIlEH0hHIt4Ps8mypzmQN8zWbJWEO5Rk0rUXsKGvSAxqbLVjin9VB+e5NaL7zadQK0t7DqCtNS7OtLXsLVsg1hjNU/IHPJDihZEmfVhvfHeGVdWzumZi2SZxvpia7KVl0C1Yw==
Received: from DM3NAM03FT038.eop-NAM03.prod.protection.outlook.com
 (10.152.82.54) by DM3NAM03HT073.eop-NAM03.prod.protection.outlook.com
 (10.152.83.176) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.18; Wed, 16 Jan
 2019 03:37:38 +0000
Received: from BLUPR13MB0289.namprd13.prod.outlook.com (10.152.82.54) by
 DM3NAM03FT038.mail.protection.outlook.com (10.152.83.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.13 via Frontend Transport; Wed, 16 Jan 2019 03:37:38 +0000
Received: from BLUPR13MB0289.namprd13.prod.outlook.com
 ([fe80::dd7d:4ced:858f:a868]) by BLUPR13MB0289.namprd13.prod.outlook.com
 ([fe80::dd7d:4ced:858f:a868%2]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 03:37:38 +0000
From:   Yueyi Li <liyueyi@live.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: kaslr: Reserve size of ARM64_MEMSTART_ALIGN in
 linear region
Thread-Topic: [PATCH] arm64: kaslr: Reserve size of ARM64_MEMSTART_ALIGN in
 linear region
Thread-Index: AQHUm1vkcfAdS8kQrUSpqXhyNic5x6WNpCYAgAEYtgCAAlAzAIAgVdQA
Date:   Wed, 16 Jan 2019 03:37:37 +0000
Message-ID: <BLUPR13MB028993B73A531E5C7EA62DCEDF820@BLUPR13MB0289.namprd13.prod.outlook.com>
References: <BLUPR13MB0289A32373545C7FBE3400CBDFBB0@BLUPR13MB0289.namprd13.prod.outlook.com>
 <CAKv+Gu_m353cv=Pf2cEUDLn8=5YTLjLDDO23n=P14nWXydQWDQ@mail.gmail.com>
 <BLUPR13MB02892B82F5EB663B2FECF20EDFB40@BLUPR13MB0289.namprd13.prod.outlook.com>
 <CAKv+Gu-YTdQmhU_br4amNZYn12=6Amr7w=wP57DyNn7_axptCg@mail.gmail.com>
In-Reply-To: <CAKv+Gu-YTdQmhU_br4amNZYn12=6Amr7w=wP57DyNn7_axptCg@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::35) To BLUPR13MB0289.namprd13.prod.outlook.com
 (2a01:111:e400:5951::22)
x-incomingtopheadermarker: OriginalChecksum:29B31055DCB4DD55086D6BC72A5CA9DD6726067E96F8C92DED005BA53413D77C;UpperCasedChecksum:990058379FFE75EF0853843130C5168299C4E5EA192EAD7FCE51A78FE02E087F;SizeAsReceived:9279;Count:65
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [fH6mqUAESb7h3inClVPgfTsPwgZdk4iC]
x-microsoft-original-message-id: <ab99e8ea-ac56-e983-778e-7cb266823ca7@live.com>
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM3NAM03HT073;6:1Wyr+JEkRqc3x1JB0arf6/6lxiK9D21sL66hbaYGfbnHEAtpkAFSPBceX6KIl0S5fBxsgisMQA8G1TM7pLXdfplHT80/RJy3F0hMtIwgGaYlRmduI5dz3Ap7FJTItlfjTmPN225ZAWGBtsRsRPjAyPj7dD+t3QSk/e84U2488px6S1nwSwai8FGd9dyrVTq0MqMfSw3Vp0io5Jjg9q5zEgFVvt/AXL4OzbVjTNM5J9GzSTj2VudizZ3POXmPsTirvrPFxX4NQSrT9sEd1CB4SNw9y3gy5Gw0qJcOdpswlPPx8G3zaQAIm8+uCD1lj2ZFlLTkYIZS+JItMCh1L19KAcRFs3P4W5zGCD6zfmxp0SJo7xPCnco7LWmDI3JCdF0Anm7honJFRkom9BVNFVrlHhLhd9t8drKb55W8rSYy3cJdcUqW6NGQVPe1Ge10VWT4uYmlBGt8fnRPqwEMhuUmqw==;5:7nj48DYAvHx2DUioZ+jkG9wR7sqadSqiTvQAcWMHWtfDVdurII1zfHqqZPlMD6mwlgbG6OlRdyoj6aYQ1v1OTe0T4fiPVsLN5mruXnj0qy+Rh49mSdsajo6gICtD1LaDGqYK7lFsh0CD5gLG3SEMHQFNaVjDzntdgpJ3p9+P6HNesuRQjFIMqJbemVDxR3nRIi83RhYVLwqYN9Tkk2tHYg==;7:VSJs0IInYFBQqLS3TznaKnCXnOtNMYPx2icdLpNDOW3iQbyp7sSrqfTpJg8bTOP1Z0Jifq7UjWF1iBTxVGIHs5W6kAwiHRgXSymcGdQbyyF8rXzMx8sWfJsO18Uxc3CCNNYigv5F/o8c1yKoTWgOPA==
x-incomingheadercount: 65
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(20181119070)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:DM3NAM03HT073;
x-ms-traffictypediagnostic: DM3NAM03HT073:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:DM3NAM03HT073;BCL:0;PCL:0;RULEID:;SRVR:DM3NAM03HT073;
x-microsoft-antispam-message-info: EnkQC5hLk9N996xiwyhsQIpOCMJ/sr3wbAr36HPFMqD0MO6/YVcS48bTtFKPu8m0
Content-Type: text/plain; charset="utf-8"
Content-ID: <5BC67A4777E9BB4A9B534EA7247C6686@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: f12efbb0-867f-4c93-8261-502eceebfafa
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1d3592-42bb-4f7c-a6d2-08d67b63f4cd
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: f12efbb0-867f-4c93-8261-502eceebfafa
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 03:37:33.6573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3NAM03HT073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T0ssIHRoYW5rcy4gQnV0IHNlZW1zIHRoaXMgbWFpbCBiZSBpZ25vcmVkLCBkbyBpIG5lZWQgcmUt
c2VudCB0aGUgcGF0Y2g/DQoNCk9uIDIwMTgvMTIvMjYgMjE6NDksIEFyZCBCaWVzaGV1dmVsIHdy
b3RlOg0KPiBPbiBUdWUsIDI1IERlYyAyMDE4IGF0IDAzOjMwLCBZdWV5aSBMaSA8bGl5dWV5aUBs
aXZlLmNvbT4gd3JvdGU6DQo+PiBIaSBBcmQsDQo+Pg0KPj4NCj4+IE9uIDIwMTgvMTIvMjQgMTc6
NDUsIEFyZCBCaWVzaGV1dmVsIHdyb3RlOg0KPj4+IERvZXMgdGhlIGZvbGxvd2luZyBjaGFuZ2Ug
Zml4IHlvdXIgaXNzdWUgYXMgd2VsbD8NCj4+Pg0KPj4+IGluZGV4IDliNDMyZDlmY2FkYS4uOWRj
ZjBmZjc1YTExIDEwMDY0NA0KPj4+IC0tLSBhL2FyY2gvYXJtNjQvbW0vaW5pdC5jDQo+Pj4gKysr
IGIvYXJjaC9hcm02NC9tbS9pbml0LmMNCj4+PiBAQCAtNDQ3LDcgKzQ0Nyw3IEBAIHZvaWQgX19p
bml0IGFybTY0X21lbWJsb2NrX2luaXQodm9pZCkNCj4+PiAgICAgICAgICAgICAgICAgICAgKiBt
ZW1vcnkgc3BhbnMsIHJhbmRvbWl6ZSB0aGUgbGluZWFyIHJlZ2lvbiBhcyB3ZWxsLg0KPj4+ICAg
ICAgICAgICAgICAgICAgICAqLw0KPj4+ICAgICAgICAgICAgICAgICAgIGlmIChtZW1zdGFydF9v
ZmZzZXRfc2VlZCA+IDAgJiYgcmFuZ2UgPj0gQVJNNjRfTUVNU1RBUlRfQUxJR04pIHsNCj4+PiAt
ICAgICAgICAgICAgICAgICAgICAgICByYW5nZSA9IHJhbmdlIC8gQVJNNjRfTUVNU1RBUlRfQUxJ
R04gKyAxOw0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHJhbmdlIC89IEFSTTY0X01FTVNU
QVJUX0FMSUdOOw0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgbWVtc3RhcnRfYWRkciAt
PSBBUk02NF9NRU1TVEFSVF9BTElHTiAqDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICgocmFuZ2UgKiBtZW1zdGFydF9vZmZzZXRfc2VlZCkgPj4gMTYpOw0K
Pj4+ICAgICAgICAgICAgICAgICAgIH0NCj4+IFllcywgaXQgY2FuIGZpeCB0aGlzIGFsc28uIEkg
anVzdCB0aGluayBtb2RpZnkgdGhlIGZpcnN0ICpyYW5nZSoNCj4+IGNhbGN1bGF0aW9uIHdvdWxk
IGJlIGVhc2llciB0byBncmFzcCwgd2hhdCBkbyB5b3UgdGhpbms/DQo+Pg0KPiBJIGRvbid0IHRo
aW5rIHRoZXJlIGlzIGEgZGlmZmVyZW5jZSwgdG8gYmUgaG9uZXN0LCBidXQgSSB3aWxsIGxlYXZl
IGl0DQo+IHVwIHRvIHRoZSBtYWludGFpbmVycyB0byBkZWNpZGUgd2hpY2ggYXBwcm9hY2ggdGhl
eSBwcmVmZXIuDQoNCg==
