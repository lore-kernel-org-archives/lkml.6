Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35C0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65FDD20873
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="QdUJM2Wv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65FDD20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbeK0IO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:14:59 -0500
Received: from mail-eopbgr60130.outbound.protection.outlook.com ([40.107.6.130]:64048
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726315AbeK0IO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 03:14:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGF12AEBDF6jAbqSKlcPNnWZABooS09bVtngai8Wl9k=;
 b=QdUJM2WvU65qOEjog937IIPVrFIRqDbXRpV3f/kZiYxIhNDWznn/a+zfG/X+qTOUUfJBPYJLNw7LxKRrBQ4hRMKUfhd3+Bw7UC5IIBfOo9or0hUfG+R3QV7pmDp/fsqcZzKz4/oVwVpOX6hfdIwg6UQoKCS2h3gSH6nJygcqfFY=
Received: from VI1PR0201MB2464.eurprd02.prod.outlook.com (10.168.64.135) by
 VI1PR0201MB2064.eurprd02.prod.outlook.com (10.169.131.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.16; Mon, 26 Nov 2018 21:19:26 +0000
Received: from VI1PR0201MB2464.eurprd02.prod.outlook.com
 ([fe80::8de8:73c4:92c8:6c22]) by VI1PR0201MB2464.eurprd02.prod.outlook.com
 ([fe80::8de8:73c4:92c8:6c22%8]) with mapi id 15.20.1361.019; Mon, 26 Nov 2018
 21:19:26 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Geoff Levand <geoff@infradead.org>,
        James Simmons <jsimmons@users.sf.net>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
Subject: Re: [REGRESSION PATCH] fbdev: fbmem: behave better with small rotated
 displays and many CPUs
Thread-Topic: [REGRESSION PATCH] fbdev: fbmem: behave better with small
 rotated displays and many CPUs
Thread-Index: AQHUd0kJeMKk7GNIpUCu5UKgc0OKYKViR3YA///z3gCAAHGAAA==
Date:   Mon, 26 Nov 2018 21:19:26 +0000
Message-ID: <bfd5d16a-6fb2-4bc8-c5fd-b7086f44e7dc@axentia.se>
References: <20181108095347.19326-1-peda@axentia.se>
 <CGME20181126141651epcas1p346d68ff01402cea354ad4686fdbb7284@epcas1p3.samsung.com>
 <8faae5c6-ce11-99b4-4fc7-7a8925aad3e4@axentia.se>
 <94947dad-2ac4-99b0-3ebd-0aba62f27d4a@samsung.com>
In-Reply-To: <94947dad-2ac4-99b0-3ebd-0aba62f27d4a@samsung.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1P190CA0044.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::33)
 To VI1PR0201MB2464.eurprd02.prod.outlook.com (2603:10a6:800:55::7)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0201MB2064;6:Wo5+2/C3Y5rzJxtQXvke3ATLrLW8ne0FI0A4aO00jeApQxB4zCQHViryK9EY6pNDXgsx3xYDmnfmeocmun/OXhDMYAtJDVlYcpygaw67g9zydamJspniRDeUlU57nXG565B2B19Zw521r6rO1fRd/a5/X/gV3YhFO8A/kqoNz9Jmt4EDbnR44+dSakgbuNcqzHQGv8y6vhtNxX+492V3C2ETn+Bh6wtcnb8/fxib8LNLtpsXApOW2d0i0pBatuEjagVkleedEk5jlBe7KJJdVZfb5vQk47WA/6yssIexxteYphP2yUTemC9XOhLVVGgXCXC/vnnvU03lxOzu8fsXJi1t53tYwclrxnBGDtrLAAYJ9jhhccAwXw1gZU5iPQSgv9b9gNeSgbg1rsjK2W8mRjmQ6ebdtkOdClbeFGq1KQlUXZzu6JpkkUM4BDOmdspEphgkAafH23ijmEifChojoA==;5:64SDy3+Qw5SHOCaXQtWYuJfURqX4vWw80AEk7UDlwVjKGZuomRxs+LuUIx76x6I7Ry7dvhHzZUPG1g9WxoXrqDJgQ6+WOC2mpRED5lWhqR8lUyKJfkFEw1aF9Dz3McdaAhdI6Fi9XWjf1ely+vsXXdArnoBygNpBVBGGVhakGA4=;7:QulCH7IH/Ik3Sy8fZZrXNMokO6jHoCFcGGaGOqB94dTKWSPPsSZuC/a5BpYwqOXDssuxZHmQLNcqAsgTEoVECuzt7j9MDNL3KzL37Uf8fULbCWlnbA/AE7RO+pjv0PKENIZmN41a8aplBZ/XqmaA6w==
x-ms-office365-filtering-correlation-id: 209623e7-9c8f-4867-477b-08d653e4d7bf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2064;
x-ms-traffictypediagnostic: VI1PR0201MB2064:
x-microsoft-antispam-prvs: <VI1PR0201MB2064DA5A9B7FECA7554F85F6BCD70@VI1PR0201MB2064.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231443)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(2016111802025)(20161123558120)(20161123560045)(6043046)(201708071742011)(7699051)(76991095);SRVR:VI1PR0201MB2064;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2064;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(136003)(39830400003)(366004)(199004)(189003)(106356001)(14454004)(256004)(105586002)(74482002)(4001150100001)(25786009)(186003)(31686004)(6436002)(26005)(6486002)(229853002)(345774005)(71190400001)(476003)(6512007)(76176011)(52116002)(53546011)(68736007)(6506007)(386003)(53936002)(81156014)(8936002)(36756003)(8676002)(81166006)(97736004)(6116002)(31696002)(86362001)(6916009)(54906003)(65956001)(65806001)(446003)(3846002)(11346002)(4326008)(58126008)(99286004)(486006)(316002)(305945005)(7736002)(93886005)(66066001)(6246003)(65826007)(64126003)(2906002)(5660300001)(508600001)(71200400001)(2616005)(102836004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2064;H:VI1PR0201MB2464.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Q1zOv9BKUwFv+qqJpGUR7ZX7vinMZsk8nR1JY3RoxQYZCPGy5iuRSFkjNbBltEwZBH7CvLRyARxzFI78NtOofu++5/IdUrwSNB7CM912xhsjdGZ12Ymtwuy7CNtj5AKh2F/qjmYfxALSE4IMcUj9I7oj5K24S4xRDti49Jt7DZhKUuM2v8qv+TfA7cVK3e1HZuEy5clEK+Hgdw7KvQr39qFA3+yaGqrIyICfoiUxf6LndzhMCtBuV8OnNGT80AQlYxmm+Coh59IVIbsHkUUaFk0UJkBIaVNZoMMsOC+8njd7SnIDlI/3C8np6lGPUq3ORu9+5jFbGIZqRUn/QGY1hi2FcC2/hpOh1qwP11BGewY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4517DCFA147864DA2E201A32D56FB56@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 209623e7-9c8f-4867-477b-08d653e4d7bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 21:19:26.4016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOC0xMS0yNiAxNTozMywgQmFydGxvbWllaiBab2xuaWVya2lld2ljeiB3cm90ZToNCj4g
T24gMTEvMjYvMjAxOCAwMzoxNiBQTSwgUGV0ZXIgUm9zaW4gd3JvdGU6DQo+PiBQaW5nPyENCj4g
DQo+IEhpLA0KPiANCj4gVGhhbmsgeW91IGZvciB5b3VyIHBhdGNoLCBpdCB3aWxsIGJlIGNvbnNp
ZGVyZWQgZm9yIDQuMjEgKGFzIGl0IGlzIG5vdA0KPiBhIHJlY2VudCByZWdyZXNzaW9uICsgSSdt
IGJ1c3kgd2l0aCBvdGhlciB0aGluZ3MgY3VycmVudGx5KS4NCg0KUmlnaHQsIHRoYW5rcyBmb3Ig
bGV0dGluZyBtZSBrbm93IQ0KDQpDaGVlcnMsDQpQZXRlcg0K
