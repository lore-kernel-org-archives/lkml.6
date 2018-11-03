Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C828C32789
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 00:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8592082D
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 00:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="gLIQDRSx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8592082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbeKCJrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 05:47:23 -0400
Received: from mail-eopbgr30048.outbound.protection.outlook.com ([40.107.3.48]:18944
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726729AbeKCJrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 05:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5ig0X7F1M31gC+n1eKBS1k/651w4VwwymTs5rTbGyw=;
 b=gLIQDRSx796DuAZwHTSKwTe2kADYxCgE0/+A4/MzQn7gi1fDDjcKiEaRhUPxcw9+Nvx1eRksUHvS3b11g72datfGwNebHBud4rDF9iFdxdsKquwkJ3DIgTQunFoshAnfx8uW3b8O0Fm1mu3lhY9sX4+6UQdDC4mSUFhFGv8kqtU=
Received: from DB6PR0502MB2901.eurprd05.prod.outlook.com (10.172.249.140) by
 DB6PR0502MB2869.eurprd05.prod.outlook.com (10.172.248.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Sat, 3 Nov 2018 00:37:53 +0000
Received: from DB6PR0502MB2901.eurprd05.prod.outlook.com
 ([fe80::3c1f:a6d8:45c6:5d5]) by DB6PR0502MB2901.eurprd05.prod.outlook.com
 ([fe80::3c1f:a6d8:45c6:5d5%5]) with mapi id 15.20.1294.027; Sat, 3 Nov 2018
 00:37:53 +0000
From:   Saeed Mahameed <saeedm@mellanox.com>
To:     "jgg@ziepe.ca" <jgg@ziepe.ca>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Moshe Shemesh <moshe@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Boris Pismenny <borisp@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "leon@kernel.org" <leon@kernel.org>,
        Kamal Heib <kamalh@mellanox.com>
Subject: Re: [PATCH] net/mlx5e: fix high stack usage
Thread-Topic: [PATCH] net/mlx5e: fix high stack usage
Thread-Index: AQHUcsFk3o0flMyDYkGmMaSNi/5NYKU8+hsAgAAJXYCAAAeNAIAAArMAgAAnnwA=
Date:   Sat, 3 Nov 2018 00:37:53 +0000
Message-ID: <e8a33848ef4708e36823bcdfa104417f89674c20.camel@mellanox.com>
References: <20181102153316.1492515-1-arnd@arndb.de>
         <9f214f12ec89020ceb14c1aec25b3a0d968507aa.camel@mellanox.com>
         <2727f37b-1742-5532-317e-3be8a984266b@gmail.com>
         <4ebfc3aeb5335a1f671602f9a906f948c39a30da.camel@mellanox.com>
         <20181102221552.GC17096@ziepe.ca>
In-Reply-To: <20181102221552.GC17096@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saeedm@mellanox.com; 
x-originating-ip: [73.15.39.150]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0502MB2869;6:/S91ule+c10KSZirlOtj+Os7qAUUnrM1an7f9nZlAZ3f0JTXbH/y7tj/Ln8eX/IOsrQ4J5FPJf7Q8a0G1aAVIH9x82sMXzb2uraAvzfFqmoKu0MG8JgFjG5V0ysfq4g2jURvH5S0CBlSWHb54Isvm6TlGW+XuHcbxRax5cbFnhlgW+47apRAt4pM5vc/5pQYlEQEBbsUacRSFBOmi96GEmLu6E1Pjp92fZAdm5YHzgDRXHZ+bJmuNgZTAcZ4CrAyx95dLha98TGNVAWgkd3sDeOaddU0BibpDi19+LmK4mkKiQqMFH1H2A5MJtoFqFaZ8p+xF6CECbH/i3XfZ6H+0ToWU6owjUBKKiLaouQCQEdaB1066v6U71S75y5lxbvCtFRURtsQId7WXAnvPA3YeCp1ElaYoVWqIeD19hzEluuwTIGeQRi+eJiZ6wa0+0oAWm6BeJn+iFgIeLUW3XAbKg==;5:2r3p1tRKqpGbExrjWoz1tTGZNaqIm8R3n8AM15wacT8IBC1eao80FBMVs7gwz27vws/R9New17Tx7xYBL0ottZMI35ezshFAxUDqyv3raTBx7kML0AnRLFHH4tcGOf2CCSxGaOnwrcxyLzokdGj1DWLUNf1+RzetbOUTS/qeEdc=;7:ow4eSPg5db5m8Ji9mx7twpJF8R7+zyikqPUn2tNeYpcUJG7pwqoOHv4N/YRZKHxl7nXkeIG4C5gnYM4NyV4uN22iqV9upmoqYRJeqSkPRhYJCmlbygApXIKmmcEcSOCYsCPr81LDOyViY1V/hbMxsQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c319f3d1-daf8-4455-a9bb-08d641249755
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB6PR0502MB2869;
x-ms-traffictypediagnostic: DB6PR0502MB2869:
x-ld-processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
x-microsoft-antispam-prvs: <DB6PR0502MB2869D2B6971F6C6A0E3D96A8BEC80@DB6PR0502MB2869.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB6PR0502MB2869;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0502MB2869;
x-forefront-prvs: 08457955C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(136003)(366004)(189003)(199004)(76176011)(118296001)(105586002)(2351001)(11346002)(446003)(486006)(106356001)(476003)(99286004)(186003)(26005)(36756003)(86362001)(2616005)(71200400001)(14444005)(2900100001)(256004)(25786009)(39060400002)(4326008)(66066001)(71190400001)(316002)(68736007)(54906003)(14454004)(93886005)(478600001)(3846002)(6512007)(6116002)(107886003)(7736002)(6246003)(53546011)(53936002)(229853002)(6506007)(6486002)(305945005)(97736004)(6916009)(6436002)(102836004)(2906002)(5640700003)(5660300001)(50226002)(8676002)(1730700003)(8936002)(81166006)(2501003)(81156014)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0502MB2869;H:DB6PR0502MB2901.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JDQdN+4SU2V2u7mi0U0hm9Qb8phMt1l2xyERjpkXAmmS4Ne9OEPuwHDqyR/O8wj6F7pFNWV8BqMvl0siiXfRr3HCoO0fNo0EZHd74a5XfqFq1UkkO0Y7stzB/PVDMuMqldMGBBFUHVqjtWrUVKGJZtly0AZ6j9m3YZyK9rp/Vb9qsyVuHILELaw87SercBUaZd27PsGcfItMZ2GKGqXSkIH3tHXFAg8CSNN+EGvTWZpj4aEGoIRjLebdmRmhjRMSNs2GqOlDRx/WE9QdwCq9Bp/V6cqcBmO7T+BGiZi5Cm2NDkaI93MzqdwPG0sh8ytvXdAQ3jkSYw3yvIfSWQ2z0sYZbj/fI+IND1Oz8/hIQZc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B00AAE2A688D9042B6C085081B9EBC74@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c319f3d1-daf8-4455-a9bb-08d641249755
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2018 00:37:53.0833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0502MB2869
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTExLTAyIGF0IDE2OjE1IC0wNjAwLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6
DQo+IE9uIEZyaSwgTm92IDAyLCAyMDE4IGF0IDEwOjA3OjAyUE0gKzAwMDAsIFNhZWVkIE1haGFt
ZWVkIHdyb3RlOg0KPiA+IE9uIEZyaSwgMjAxOC0xMS0wMiBhdCAxNDozOSAtMDcwMCwgRXJpYyBE
dW1hemV0IHdyb3RlOg0KPiA+ID4gDQo+ID4gPiBPbiAxMS8wMi8yMDE4IDAyOjA1IFBNLCBTYWVl
ZCBNYWhhbWVlZCB3cm90ZToNCj4gPiA+ICANCj4gPiA+ID4gdGVtcCB3aWxsIGJlIG1lbSBjb3Bp
ZWQgdG8gcHJpdi0+c3RhdHMuc3cgYXQgdGhlIGVuZCwNCj4gPiA+ID4gbWVtY3B5KCZwcml2LT5z
dGF0cy5zdywgJnMsIHNpemVvZihzKSk7IA0KPiA+ID4gPiANCj4gPiA+ID4gb25lIG90aGVyIHdh
eSB0byBzb2x2ZSB0aGlzIGFzIHN1Z2dlc3RlZCBieSBBbmRyZXcsIGlzIHRvIGdldA0KPiA+ID4g
PiByaWQNCj4gPiA+ID4gb2YNCj4gPiA+ID4gdGhlIHRlbXAgdmFyIGFuZCBtYWtlIGl0IHBvaW50
IGRpcmVjdGx5IHRvIHByaXYtPnN0YXRzLnN3IA0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gV2hh
dCBhYm91dCBjb25jdXJyZW5jeSA/DQo+ID4gPiANCj4gPiA+IFRoaXMgdGVtcCB2YXJpYWJsZSBp
cyB0aGVyZSB0byBtYWtlIHN1cmUgY29uY3VycmVudCByZWFkZXJzIG9mDQo+ID4gPiBzdGF0cw0K
PiA+ID4gbWlnaHQNCj4gPiA+IG5vdCBzZWUgbWFuZ2xlIGRhdGEgKGJlY2F1c2UgYW5vdGhlciAn
cmVhZGVyJyBqdXN0IGRpZCBhIG1lbXNldCgpDQo+ID4gPiBhbmQNCj4gPiA+IGlzIGRvaW5nIHRo
ZSBmb2xkaW5nKQ0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IG1seDVlX2dldF9zdGF0cygpIGNhbiBk
ZWZpbml0ZWx5IGJlIHJ1biBhdCB0aGUgc2FtZSB0aW1lIGJ5DQo+ID4gPiBtdWx0aXBsZQ0KPiA+
ID4gdGhyZWFkcy4NCj4gPiA+IA0KPiA+IA0KPiA+IGhtbSwgeW91IGFyZSByaWdodCwgaSB3YXMg
dGhpbmtpbmcgdGhhdCBtbHg1ZV9nZXRfU3RhdHMgd2lsbA0KPiA+IHRyaWdnZXIgYQ0KPiA+IHdv
cmsgdG8gdXBkYXRlIHN0YXRzIGFuZCBncmFiIHRoZSBzdGF0ZV9sb2NrLCBidXQgZm9yIHN3IHN0
YXRzIHRoaXMNCj4gPiBpcw0KPiA+IG5vdCB0aGUgY2FzZSBpdCBpcyBkb25lIGluIHBsYWNlLg0K
PiANCj4gVGhhdCB3YXMgbXkgZ3Vlc3Mgd2hlbiBJIHNhdyB0aGlzLi4gdGhlIGNvbmZ1c2luZyBi
aXQgaXMgd2h5IGlzIHRoZXJlDQo+IHMgYW5kIHRlbXAsIHdoeSBub3QganVzdCBzPw0KPiANCg0K
c2lsbHkgY3V0IGFuZCBwYXN0ZSBmcm9tIG1seDQgIQ0KDQo+ID4gQlRXIG1lbWNweSBpdHNlbGYg
aXMgbm90IHRocmVhZCBzYWZlLg0KPiANCj4gQXQgbGVhc3Qgb24gNjQgYml0IG1lbWNweSB3aWxs
IGRvID4gOCBieXRlIHN0b3JlcyB3aGVuIGNvcHlpbmcgc28gb24NCj4gbW9zdCBhcmNoaXRlY3R1
cmVzIGl0IHdpbGwgY2F1c2UgaW5kaXZpZHVhbCBuZXcgb3Igb2xkIHU2NCB0byBiZQ0KPiByZXR1
cm5lZCBhbmQgbm90IGEgbWVzcy4uDQo+IA0KPiAzMiBiaXQgd2lsbCBhbHdheXMgbWFrZSBhIG1l
c3MuDQo+IA0KPiBJZiB0aGUgc3RhdHMgZG9uJ3QgdXBkYXRlIHRoYXQgb2Z0ZW4gdGhlbiBrbWFs
bG9jJ2luZyBhIG5ldyBidWZmZXINCj4gYW5kDQo+IFJDVSdpbmcgaXQgaW50byB2aWV3IG1pZ2h0
IGJlIGEgcmVhc29uYWJsZSBhbHRlcm5hdGl2ZSB0byB0aGlzPw0KPiANCg0Ka21hbGxvYyBpcyBu
b3QgYW4gb3B0aW9uLCBzdGF0cyB1cGRhdGUgdG9vIG9mdGVuLCBwcml2LT5zdGF0cy5zdyBpcw0K
YWxyZWFkeSBhIHRlbXAsIGl0IGlzIG5lZWRlZCBvbmx5IHRvIGFjY3VtdWxhdGUgY2hhbm5lbHMg
c3RhdHMgaW50byBpdA0KYW5kIHRoZW4gcmVwb3J0IHRoZW0gdG8gZXRodG9vbCBidWZmZXIgb3Ig
bmRvX2dldF9zdGF0cyAsIGJvdGggd2lsbA0KY29weSB0aGUgcHJpdi0+c3RhdHMuc3cgdG8gdGhl
aXIgb3duIGJ1ZmZlcnMsIHNvIHRoZXJlIGNhbiBvbmx5IGJlIHR3bw0KdXNlIGNhc2VzICh0d28g
dGhyZWFkcyksIG1heWJlIGl0IGlzIGJlc3QgaWYgd2UgbWFpbnRhaW4gdHdvIHByaXYtDQo+c3Rh
dHMuc3cgb25lIGZvciBlYWNoIGNhc2UgYW5kIHVzZSBpdCBhcyBhIHRlbXAgZm9yIGVhY2ggdGhy
ZWFkLg0KDQo+IEphc29uDQo=
