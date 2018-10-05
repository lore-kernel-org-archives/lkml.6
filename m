Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CCAC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80512084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="CU4KIZ4i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E80512084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hammerspace.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbeJEUfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 16:35:08 -0400
Received: from mail-by2nam01on0121.outbound.protection.outlook.com ([104.47.34.121]:59930
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727701AbeJEUfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 16:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgsjqGF9Ulr/TnB+s5SCmHgpPNlXvMo1VEt8h0onrew=;
 b=CU4KIZ4iupMVR/68Ji1U19HhELwF7mrbenQaFuEMVmyedM4WSbYn1ytWYWcOaqJhCHnmUqeb4jOwtLwz95/gnaXJbXi8MQyxu5OHyqwtINZwOdQaXsxJNPlSciJFDnKZg6mLnJSYmPOHmOh9sVMoOb1XcyrQJKl0jNKNa9yt4UE=
Received: from SN6PR13MB2494.namprd13.prod.outlook.com (52.135.95.148) by
 SN6PR13MB2398.namprd13.prod.outlook.com (52.135.94.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.10; Fri, 5 Oct 2018 13:36:19 +0000
Received: from SN6PR13MB2494.namprd13.prod.outlook.com
 ([fe80::2514:20a4:bf40:4139]) by SN6PR13MB2494.namprd13.prod.outlook.com
 ([fe80::2514:20a4:bf40:4139%5]) with mapi id 15.20.1228.011; Fri, 5 Oct 2018
 13:36:19 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "arnd@arndb.de" <arnd@arndb.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "james@ettle.org.uk" <james@ettle.org.uk>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "stephen@networkplumber.org" <stephen@networkplumber.org>
Subject: Re: [PATCH] SUNRPC: use cmpxchg64() in gss_seq_send64_fetch_and_inc()
Thread-Topic: [PATCH] SUNRPC: use cmpxchg64() in
 gss_seq_send64_fetch_and_inc()
Thread-Index: AQHUWpKo54r9YwL7Zkm1aofzFs6+E6UQq6OA
Date:   Fri, 5 Oct 2018 13:36:19 +0000
Message-ID: <7c783e6ecca13af5ae603b75689a377e7a8a4855.camel@hammerspace.com>
References: <20181002205809.2300654-1-arnd@arndb.de>
In-Reply-To: <20181002205809.2300654-1-arnd@arndb.de>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [68.40.195.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR13MB2398;6:Iw59SrrQU2lKblwCjwdUHQ1QbTX/hDM+snd+bMhkOvB+Lqj/IYmTc6lMSNcbV/IUsJBMQf1HEK+Ub7PiW0lw2ITGG4HZOAD5LdIz0JAsFuBdtrDwto5vXoKGmyR1/AqixHpwp74T8cY2To3L7jIa9uOANZ2qnxvg5YBPj0F7No5uNxF0HLdB4a5yYJkzT81ZfzjOE66ZVJvguaR4Gtgjuq36XPBfjW2oGZp4c36QMknhN9/F6C1ubLnT0pcskyzUTgIWIJAopyK8HRZs5BO849Tcw69PuuRnCv3gjtkhlBb0u3r+T90utdCDt9HaPQNIeVKhY85pia5bbIN318OUv2QiNc37LD4oZ7pOuYH/4PlBZC9bImop0IZEnt34BSEr3ZamR2JJB84ujnhbW9fX2iISXY5FEq126DlL17hEbajVypPbR2rPvEXltxi109efFKV8GcRaTppehp81gnEA9w==;5:rwSopW4XIie6EjZx4U9BDl/9QrDe4otTi9oF5goiDandkCeBHqakC5ds6QI2IYsn06A6cBw7PoocTFMZalgtD18mE62ONXdB54OJAJ7p75k5FZsUepq/A0Sezr9Kfr4okGQqt9Zfg21WqMsc9bApUAMvXYPCaPPH5A6LFTF434w=;7:V4kzKvYMMY+uD9B/mpSvq2TEXw7W/EZtbH1DBo1HxBhQz1buGBTe8BMuYW4km/WlHAS4MetC+bDmXRzfwFNjbD2m3LzuDgbEezm+m/8DU6d8F+z64MztCtx63yISaYkiIwARNs16r2Y9U1uva0Z6e83JO2YlghBYZSdNw0v1GORlG/umIq/ejPTWXhyoirwN7sSo14fUY+07dB1kpekiysbOChWc+GDM2rEislQ2ffBXMc8wGAT3nr7pk/9TJ9GK
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f573f381-75d3-416c-0c2a-08d62ac7889a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR13MB2398;
x-ms-traffictypediagnostic: SN6PR13MB2398:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-microsoft-antispam-prvs: <SN6PR13MB23987B3D2C148321483DA3A2B8EB0@SN6PR13MB2398.namprd13.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991048);SRVR:SN6PR13MB2398;BCL:0;PCL:0;RULEID:;SRVR:SN6PR13MB2398;
x-forefront-prvs: 0816F1D86E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39830400003)(396003)(136003)(376002)(346002)(199004)(189003)(8676002)(7416002)(6506007)(36756003)(5660300001)(1730700003)(8936002)(81166006)(4326008)(3846002)(66066001)(11346002)(5250100002)(486006)(6116002)(81156014)(97736004)(2501003)(476003)(2900100001)(118296001)(6246003)(446003)(25786009)(2616005)(14454004)(53936002)(15760500003)(102836004)(86362001)(14444005)(106356001)(256004)(305945005)(6512007)(316002)(99286004)(6916009)(26005)(186003)(2906002)(68736007)(76176011)(71190400001)(5640700003)(6486002)(71200400001)(105586002)(6436002)(7736002)(54906003)(478600001)(2351001)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR13MB2398;H:SN6PR13MB2494.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kunc/9b8NUKH6lE5oci2OeWLBKYaDB7PvqnH8tDmflH8hpXP2QBHERG3n/lfVz8AWM5T+nLAxYLKJir6ZJbcbkb5qaHZ0vrjCcAeMNU0Q0VfPltBv2f76ZeV5xVOfE44/OzfblWGpKtr5zpiiujG0m0DmDO2kSy890b7IzlBOVBjSPFT0SAlfviat2zPvHL5Ke9Dfw7R4WuiIJlLMR4gMomeNiARKTRkpsSNyW8fbhxe55ymF5DquQsmWOmWNDNOX3OlIQWxssx3sgNEu4HRQAGAmBP+h4OchEV2oaDNWvZdY+kjFvrWgAlG2ugIWActXvswnLkXl07Ill8hmpcdFwwADLeNYiF+IOgmWFXfnik=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <278E45A928B5974B972B5177C2D45D53@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f573f381-75d3-416c-0c2a-08d62ac7889a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2018 13:36:19.7058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR13MB2398
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTEwLTAyIGF0IDIyOjU3ICswMjAwLCBBcm5kIEJlcmdtYW5uIHdyb3RlOg0K
PiBUaGUgbmV3bHkgaW50cm9kdWNlZCBnc3Nfc2VxX3NlbmQ2NF9mZXRjaF9hbmRfaW5jKCkgZmFp
bHMgdG8gYnVpbGQgb24NCj4gMzItYml0IGFyY2hpdGVjdHVyZXM6DQo+IA0KPiBuZXQvc3VucnBj
L2F1dGhfZ3NzL2dzc19rcmI1X3NlYWwuYzoxNDQ6MTQ6IG5vdGU6IGluIGV4cGFuc2lvbiBvZg0K
PiBtYWNybyAnY21weGNoZycNCj4gICAgc2VxX3NlbmQgPSBjbXB4Y2hnKCZjdHgtPnNlcV9zZW5k
NjQsIG9sZCwgb2xkICsgMSk7DQo+ICAgICAgICAgICAgICAgXn5+fn5+fg0KPiBhcmNoL3g4Ni9p
bmNsdWRlL2FzbS9jbXB4Y2hnLmg6MTI4OjM6IGVycm9yOiBjYWxsIHRvDQo+ICdfX2NtcHhjaGdf
d3Jvbmdfc2l6ZScgZGVjbGFyZWQgd2l0aCBhdHRyaWJ1dGUgZXJyb3I6IEJhZCBhcmd1bWVudA0K
PiBzaXplIGZvciBjbXB4Y2hnDQo+ICAgIF9fY21weGNoZ193cm9uZ19zaXplKCk7ICAgICBcDQo+
IA0KPiBBcyB0aGUgbWVzc2FnZSB0ZWxscyB1cywgY21weGNoZygpIGNhbm5vdCBiZSB1c2VkIG9u
IDY0LWJpdA0KPiBhcmd1bWVudHMsDQo+IHRoYXQncyB3aGF0IGNtcHhjaGc2NCgpIGRvZXMuDQo+
IA0KPiBGaXhlczogNTcxZWQxZmQyMzkwICgiU1VOUlBDOiBSZXBsYWNlIGtyYjVfc2VxX2xvY2sg
d2l0aCBhIGxvY2tsZXNzDQo+IHNjaGVtZSIpDQo+IFNpZ25lZC1vZmYtYnk6IEFybmQgQmVyZ21h
bm4gPGFybmRAYXJuZGIuZGU+DQo+IC0tLQ0KPiAgbmV0L3N1bnJwYy9hdXRoX2dzcy9nc3Nfa3Ji
NV9zZWFsLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9uZXQvc3VucnBjL2F1dGhfZ3NzL2dzc19rcmI1
X3NlYWwuYw0KPiBiL25ldC9zdW5ycGMvYXV0aF9nc3MvZ3NzX2tyYjVfc2VhbC5jDQo+IGluZGV4
IDkyNTk0NjgxZDYxOS4uNTc3NWI5ODA1YmRjIDEwMDY0NA0KPiAtLS0gYS9uZXQvc3VucnBjL2F1
dGhfZ3NzL2dzc19rcmI1X3NlYWwuYw0KPiArKysgYi9uZXQvc3VucnBjL2F1dGhfZ3NzL2dzc19r
cmI1X3NlYWwuYw0KPiBAQCAtMTQxLDcgKzE0MSw3IEBAIGdzc19zZXFfc2VuZDY0X2ZldGNoX2Fu
ZF9pbmMoc3RydWN0IGtyYjVfY3R4DQo+ICpjdHgpDQo+ICANCj4gIAlkbyB7DQo+ICAJCW9sZCA9
IHNlcV9zZW5kOw0KPiAtCQlzZXFfc2VuZCA9IGNtcHhjaGcoJmN0eC0+c2VxX3NlbmQ2NCwgb2xk
LCBvbGQgKyAxKTsNCj4gKwkJc2VxX3NlbmQgPSBjbXB4Y2hnNjQoJmN0eC0+c2VxX3NlbmQ2NCwg
b2xkLCBvbGQgKyAxKTsNCj4gIAl9IHdoaWxlIChvbGQgIT0gc2VxX3NlbmQpOw0KPiAgCXJldHVy
biBzZXFfc2VuZDsNCj4gIH0NCg0KVGhhbmtzIEFybmR0ISBBcHBsaWVkLg0KDQotLSANClRyb25k
IE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJv
bmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
