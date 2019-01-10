Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382A0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADCE120663
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="vvfOqsW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbfAJVYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 16:24:07 -0500
Received: from mail-eopbgr80125.outbound.protection.outlook.com ([40.107.8.125]:38074
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728385AbfAJVYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 16:24:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TD4LGJ/dfugD2myBCJZqQf9LuECulpvIz4/7bwRZok=;
 b=vvfOqsW0GA3zDWknq356HXG71ADAyLYqCCHEkadhQ1gGCt70uOSzgjl4uA5xQhMCUI1xLtcgROmoY4KJkQMYdZAhYZlFFC/RFFd4w5x6w2l69hf+XcG62NQSTTUFTL3JsoX+CC6M8JTc92jf0pfNvwphMPAI2SGHrYX9ESeAoik=
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com (20.177.191.218) by
 AM6PR02MB4391.eurprd02.prod.outlook.com (20.177.190.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Thu, 10 Jan 2019 21:24:02 +0000
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453]) by AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453%6]) with mapi id 15.20.1516.016; Thu, 10 Jan 2019
 21:24:02 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Boris Brezillon <bbrezillon@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH 0/4] drm/atmel-hlcdc: fix plane clipping/rotation issues
Thread-Topic: [PATCH 0/4] drm/atmel-hlcdc: fix plane clipping/rotation issues
Thread-Index: AQHUqPaeuHFV8522kE2kP/gCblgMKKWoxn6AgAA9LwA=
Date:   Thu, 10 Jan 2019 21:24:02 +0000
Message-ID: <dae0e92e-e91f-6208-987b-a214583b45a1@axentia.se>
References: <20190110151020.30468-1-peda@axentia.se>
 <20190110184446.75b4350a@bbrezillon>
In-Reply-To: <20190110184446.75b4350a@bbrezillon>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1P195CA0013.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::23)
 To AM6PR02MB4470.eurprd02.prod.outlook.com (2603:10a6:20b:60::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR02MB4391;6:lQ1Jj99WFLrDaKum4h2WrWEw8JuyjneHWsldb2tpZ3xH5g/dGCerwxlilRIricIqoYF54Xn2KUracQMPQGjhUUsl6FhPtyrtiN5NlmyKnhZ5VcrU+tgeAU7adIJKqL7pAapxw6NapnLvXYi+PTD7t2hk5SIgOolv7nJ0nywbHV6FHaRXBkA6ECW03nua3D9+GrPFJXUeinff3aiwHeITeFKNC7hFElbiLIOuWtvuRYAPqipJslrf5DkJ8TZvWoDXwgHDdu1NVpbXh4EXHfyHMn5g2/mydFchPkh0uFP1Zkec4waNhTVm6S2Iv61LPRu/ZX6d3g63kpxdk7HTxCxNFjvgdY48ZXh47qxUUdhL5hs9j1O20FmBbelKZ2O37fRBfnpf6exHCK3ZVY5JwpbczNllnYxlb9x+Fz6q0vyvqGcryF0WEhred/cxiK8CbxYM3FtiZBYlblLBZhQxqEcCnw==;5:dKJaeUddhad43t/CKFZcfc5Mlu+BconkhNumzM7k79YaWoyo7uJ8SGYmp/elaDtbIfqc3Y0VkKR8QymtnB/mroCW0BAqlyFLp4ZpL7Qr66+OQ8OCxOC5xVfvAKml7uYHwRqqsKcSEhv/53V3ca/n3DowNql4uP/zraAfsu4kopSrQoU+wVZsN69MrnRoRxw902fUv/IvcAW4abOowmav9g==;7:qD4Tbh1QSOvl6rJh5ctsSnNmrsrphwyfzIxPGPY/uTOtjlDb8jGlCpZ8CJ2izsh+8wcrwbQv8pjo9Dql2wxdt/Sj7d7KCmqApC5o4OdxnNyxFMEbsAF8VRqtHn3nEmQOg/GhKDCqxQEEz8jdtTidYQ==
x-ms-office365-filtering-correlation-id: 1a0953b5-9d22-4f02-c8a9-08d67741f15c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR02MB4391;
x-ms-traffictypediagnostic: AM6PR02MB4391:
x-microsoft-antispam-prvs: <AM6PR02MB439197C935C22413A7BFB6ADBC840@AM6PR02MB4391.eurprd02.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:AM6PR02MB4391;BCL:0;PCL:0;RULEID:;SRVR:AM6PR02MB4391;
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(396003)(39830400003)(346002)(52314003)(189003)(199004)(53546011)(6506007)(68736007)(66066001)(65826007)(99286004)(229853002)(81166006)(5660300001)(26005)(8676002)(386003)(186003)(65956001)(106356001)(7736002)(102836004)(305945005)(476003)(446003)(11346002)(2616005)(2906002)(76176011)(486006)(316002)(105586002)(65806001)(58126008)(81156014)(8936002)(31686004)(54906003)(52116002)(4326008)(6116002)(25786009)(6436002)(3846002)(6512007)(64126003)(6246003)(6916009)(86362001)(74482002)(31696002)(71190400001)(256004)(36756003)(71200400001)(14454004)(508600001)(6486002)(97736004)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR02MB4391;H:AM6PR02MB4470.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TivzDkEmEM8nIfsh84NULAIgrgSFjdP25uF0G+06bLBsIRPVbMVvrgH6JHclYkqAzsitimAbmS2nBXUzFt8hs2zYEfBgwOo+7Y4bS6LvACl5UxfxmaWc+tQWqEkzr3j90qOOleB89JDgPr/qzcsa2GxtbMKUDIlCHb2hnfU7esjeDI4jBE44Ri+5bXI8PPq3mP+CpsdR8qWWWgu7LOkRodUHUF1KDiNZg1VIwCizrPPvdSxkWVxT97LLVBX5V2hEY/l6ECmBStD2NHmXC/AxSbefrasvde5UgZf7Zq4AXOk3S0aePrPNezpecNZyGiuW
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C616B4FE4CACD448F68AA381DF5801D@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0953b5-9d22-4f02-c8a9-08d67741f15c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 21:24:02.0449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB4391
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wMS0xMCAxODo0NSwgQm9yaXMgQnJlemlsbG9uIHdyb3RlOg0KPiBPbiBUaHUsIDEw
IEphbiAyMDE5IDE1OjEwOjI4ICswMDAwDQo+IFBldGVyIFJvc2luIDxwZWRhQGF4ZW50aWEuc2U+
IHdyb3RlOg0KPiANCj4+IEhpIQ0KPj4NCj4+IEkgZm91bmQgYW4gdW5mb3J0dW5hdGUgaXNzdWUg
d2hpbGUgcmVjb2RpbmcgcGxhbmUgaGFuZGxpbmcgdG8gdXNlDQo+PiBkcm1fYXRvbWljX2hlbHBl
cl9jaGVja19wbGFuZV9zdGF0ZSgpLiBUaGUgZHJpdmVyIHJvdGF0ZXMgY2xvY2t3aXNlLA0KPj4g
d2hpY2ggaXMgbm90IGNvcnJlY3QuIEkgc2ltcGx5IGZpeGVkIGl0IChwYXRjaCAxLzQpLCBidXQg
bWF5YmUgdGhhdA0KPj4gd2lsbCBjYXVzZSByZWdyZXNzaW9ucyBmb3IgdW5zdXNwZWN0aW5nIHVz
ZXJzIHdobyBzaW1wbHkgYXNzdW1lZA0KPj4gdGhhdCB0aGUgY2xvY2t3aXNlIHJvdGF0aW9uIHdh
cyBjb3JyZWN0PyBJIGRvbid0IGtub3cgd2hhdCB0byBkbw0KPj4gYWJvdXQgdGhhdD8gQWRkaW5n
IGFuIG9wdGlvbiB0byBnZXQgdGhlIG9sZCBicm9rZW4gYmVoYXZpb3Igc2VlbXMNCj4+IHVzZWxl
c3MsIHdvdWxkbid0IGl0IGJlIGp1c3QgYXMgZWFzeSB0byBqdXN0IGZpeCB3aGF0ZXZlciBhcHAg
dG8NCj4+IHJvdGF0ZSB0aGUgb3RoZXIgd2F5IGluc3RlYWQgb2YgYWRkaW5nIGFuIG9wdGlvbiBz
b21ld2hlcmU/DQo+IA0KPiBIbSwgcm90YXRpb24gc3VwcG9ydCBoYXMgYmVlbiBhZGRlZCBiZWZv
cmUgdGhlIHN0YW5kYXJkIHJvdGF0aW9uDQo+IHByb3BlcnR5IHdhcyBjcmVhdGVkLCBhbmQgYXQg
dGhhdCB0aW1lIEkgYXNzdW1lZCByb3RhdGlvbiB3YXMgY2xvY2t3aXNlDQo+ICh3aGljaCBhcHBh
cmVudGx5IHdhcyBhbiB1bndpc2UgY2hvaWNlKS4gQW55d2F5LCBJIGRvbid0IGhhdmUgYQ0KPiBz
b2x1dGlvbiBmb3IgdGhpcyBwcm9ibGVtLCBzbyBJJ2xsIGxldCBOaWNvbGFzIGRlY2lkZSBpZiBp
dCdzDQo+IGFjY2VwdGFibGUgdG8gY2hhbmdlIHRoZSByb3RhdGlvbiBiZWhhdmlvci4NCg0KU3Bl
YWtpbmcgb2YgdW53aXNlLCBmYmNvbiByb3RhdGlvbiBpcyBjbG9ja3dpc2UgYW5kIGRybSByb3Rh
dGlvbg0KaXMgY291bnRlcmNsb2Nrd2lzZS4gJ251ZmYgc2FpZC4NCg0KQ2hlZXJzLA0KUGV0ZXIN
Cg==
