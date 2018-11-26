Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68E2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711A120663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="Lrk9Mezi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 711A120663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbeK0BLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:11:36 -0500
Received: from mail-eopbgr40119.outbound.protection.outlook.com ([40.107.4.119]:48865
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726176AbeK0BLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:11:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2mXO3OqTwXWFUObDbDbboBoUtZzZm7fbcGzhPqzDzc=;
 b=Lrk9Mezik0kiSoukTmebG0t2Lznayyhby1wW2A7Qk9v4dVXByWruiqJCeuqVmCtnspMLXayYvX+aVzqk+AHTkJe3sfXPJDkHw2f7ek2Gqj8ZxWSltjEn8f2aNBBQbCIJkFFTAojpBl4t0w7hwLv4j/UzGQ63YjH/ykScOEccoDY=
Received: from VI1PR0201MB2464.eurprd02.prod.outlook.com (10.168.64.135) by
 VI1PR0201MB2063.eurprd02.prod.outlook.com (10.169.131.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Mon, 26 Nov 2018 14:16:37 +0000
Received: from VI1PR0201MB2464.eurprd02.prod.outlook.com
 ([fe80::8de8:73c4:92c8:6c22]) by VI1PR0201MB2464.eurprd02.prod.outlook.com
 ([fe80::8de8:73c4:92c8:6c22%8]) with mapi id 15.20.1361.019; Mon, 26 Nov 2018
 14:16:37 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Fabian Frederick <ffrederick@users.sourceforge.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Geoff Levand <geoff@infradead.org>,
        James Simmons <jsimmons@users.sf.net>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
Subject: Re: [REGRESSION PATCH] fbdev: fbmem: behave better with small rotated
 displays and many CPUs
Thread-Topic: [REGRESSION PATCH] fbdev: fbmem: behave better with small
 rotated displays and many CPUs
Thread-Index: AQHUd0kJeMKk7GNIpUCu5UKgc0OKYKViNrMA
Date:   Mon, 26 Nov 2018 14:16:37 +0000
Message-ID: <8faae5c6-ce11-99b4-4fc7-7a8925aad3e4@axentia.se>
References: <20181108095347.19326-1-peda@axentia.se>
In-Reply-To: <20181108095347.19326-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR0902CA0045.eurprd09.prod.outlook.com
 (2603:10a6:7:15::34) To VI1PR0201MB2464.eurprd02.prod.outlook.com
 (2603:10a6:800:55::7)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0201MB2063;6:G8bGR30csCGgA0muHSF8xI7ifIBp4qIgMpffcszX3SIueXbisX+MVETirp5WgUkJHmEFNk0IndqG1vB+Jf+h1i5IxANn1atTshgt3BDZCoa2IsLrXQC4RQA9bSPIu9o2GKzO0xQWje2M1dm/dXOuvYngPgbl/bQUdDirAVOoRlsV+BhPrI/E/XouljJVpREVdiDHAoWTrjt5v8ROWgIEd/AWGts2CFg60/5xh9YO9IG9gJaCAtB/u8vWJkzAX+9z7LX8wNHPHCTpBxcnjvZPf72Z+8Sp+YimGl3ceC3gabK1PAmSWXJmkLxRpIOBFi2jAjPSJ4+Golx5BjjDpD1X7xXOLe/NVW0BX2K9wqoXveVhO3Nb8JyUgK6WKM77pNFY/am81X17FD0i5T5zVIQ87GdJYg/T60arYwsu0C19lpIgQ9zppkcJ3jcVnSd55L2+7DBTvLWBb04jVNV2BOTSqw==;5:nHgWyetdibcNjV7qAbu2IawElWtkaem2mc6iMtg8mOusyAuFSpqapoRfacbbtAAInp8Cj6ViFXEIeyClj+KpEO74mEhfdfkqydzeC/zowHtr9GhSATxwlTANblnODua6hPU/i5Y7cJYmZUFDG2V93D0bNSOHrDrGIO8SDnsT+fQ=;7:EXFI2r1nZ3/TRotp5+2TzavPmfcz+ScEishbyIGbIAA6dfUotQ1imlpZXggZ//Q83LxwRxEnkILLLDdPnaDhCATLKDIcD4BCiHK6LUvyjbsKFG2jBwpAhwJW09TlckLbWOmWRhO6o1CnJCPTXmxo9Q==
x-ms-office365-filtering-correlation-id: e17c7b45-c4f3-4474-e658-08d653a9c693
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2063;
x-ms-traffictypediagnostic: VI1PR0201MB2063:
x-microsoft-antispam-prvs: <VI1PR0201MB2063DF8DEC29FC05D428D85FBCD70@VI1PR0201MB2063.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231443)(944501410)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6043046)(201708071742011)(7699051)(76991095);SRVR:VI1PR0201MB2063;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2063;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39830400003)(396003)(346002)(366004)(376002)(199004)(189003)(74482002)(53936002)(6916009)(6486002)(14444005)(102836004)(2906002)(256004)(76176011)(31686004)(6436002)(36756003)(386003)(66066001)(8676002)(476003)(105586002)(26005)(99286004)(81166006)(53546011)(81156014)(97736004)(6506007)(508600001)(6512007)(6246003)(52116002)(3846002)(86362001)(446003)(575784001)(25786009)(54906003)(71200400001)(71190400001)(14454004)(2616005)(65826007)(186003)(64126003)(31696002)(5660300001)(4326008)(6116002)(11346002)(229853002)(305945005)(486006)(8936002)(7736002)(316002)(65956001)(65806001)(58126008)(68736007)(106356001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2063;H:VI1PR0201MB2464.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dI2CNsZhyNY2PmcG0ILWRDqNZLCB38V0TDmgHPlz5lbuy3W0M/fjxoKg6Y+4J1BGu2quXPamKhptkCJXcy5eY3yc6K1ngbrhJoIU+McHSTZqKJjPUEEJRfPbxZoplqKgghVrQESwqvu8TTec2JjnLDO5/u9fm7HCqmYCh4DZEe6DL95qUsUoiRJtz5xXZ9JomoY26Na7VnRC6U0LbhEJ4FKWL8VoXTXA7U1ca5Dfjs+K/YxFgnlQs+KD11AulzcMcv7mvjoJMr881NYLtzMfU9gAsGD6QQ7fteTbkieV/k8tmRIucTpztEWAlFnerbAoUfRcC4q1HA0oBAzYs6JkePSGkHd5MuCvNkbyRpUAvv8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <407A13034CE30E4DBFAF7BE22AFBED41@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: e17c7b45-c4f3-4474-e658-08d653a9c693
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 14:16:37.2509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGluZz8hDQoNCkNoZWVycywNClBldGVyDQoNCk9uIDIwMTgtMTEtMDggMTA6NTQsIFBldGVyIFJv
c2luIHdyb3RlOg0KPiBCbGl0dGluZyBhbiBpbWFnZSB3aXRoICJuZWdhdGl2ZSIgb2Zmc2V0cyBp
cyBub3Qgd29ya2luZyBzaW5jZSB0aGVyZQ0KPiBpcyBubyBjbGlwcGluZy4gSXQgaG9wZWZ1bGx5
IGp1c3QgY3Jhc2hlcy4gRm9yIHRoZSBib290dXAgbG9nbywgdGhlcmUNCj4gaXMgcHJvdGVjdGlv
biBzbyB0aGF0IGJsaXR0aW5nIGRvZXMgbm90IGhhcHBlbiBhcyB0aGUgaW1hZ2UgaXMgZHJhd24N
Cj4gZnVydGhlciBhbmQgZnVydGhlciB0byB0aGUgcmlnaHQgKFJPVEFURV9VUikgb3IgZnVydGhl
ciBhbmQgZnVydGhlcg0KPiBkb3duIChST1RBVEVfQ1cpLiBUaGVyZSBpcyBob3dldmVyIG5vIHBy
b3RlY3Rpb24gd2hlbiBkcmF3aW5nIGluIHRoZQ0KPiBvcHBvc2l0ZSBkaXJlY3Rpb25zIChST1RB
VEVfVUQgYW5kIFJPVEFURV9DQ1cpLg0KPiANCj4gQWRkIGJhY2sgdGhpcyBwcm90ZWN0aW9uLg0K
PiANCj4gVGhlIHJlZ3Jlc3Npb24gaXMgMjAtb2RkIHllYXJzIG9sZCBidXQgdGhlIG1pbmRsZXNz
IHdhcm5pbmcta2lsbGluZw0KPiBtZW50YWxpdHkgZGlzcGxheWVkIGluIGNvbW1pdCAzNGJkYjY2
NmY0YjIgKCJmYmRldjogZmJtZW06IHJlbW92ZQ0KPiBwb3NpdGl2ZSB0ZXN0IG9uIHVuc2lnbmVk
IHZhbHVlcyIpIGlzIGFsc28gdG8gYmxhbWUsIG1ldGhpbmtzLg0KPiANCj4gRml4ZXM6IDQ0OGQ0
Nzk3NDdiOCAoImZiZGV2OiBmYl9kb19zaG93X2xvZ28oKSB1cGRhdGVzIikNCj4gU2lnbmVkLW9m
Zi1ieTogUGV0ZXIgUm9zaW4gPHBlZGFAYXhlbnRpYS5zZT4NCj4gLS0tDQo+ICBkcml2ZXJzL3Zp
ZGVvL2ZiZGV2L2NvcmUvZmJtZW0uYyB8IDggKysrKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA2
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy92aWRlby9mYmRldi9jb3JlL2ZibWVtLmMgYi9kcml2ZXJzL3ZpZGVvL2ZiZGV2L2NvcmUvZmJt
ZW0uYw0KPiBpbmRleCBiYjdmNWYyM2UzNDcuLjFhYmViMGI3MjQ1NSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy92aWRlby9mYmRldi9jb3JlL2ZibWVtLmMNCj4gKysrIGIvZHJpdmVycy92aWRlby9m
YmRldi9jb3JlL2ZibWVtLmMNCj4gQEAgLTQzNSw3ICs0MzUsOSBAQCBzdGF0aWMgdm9pZCBmYl9k
b19zaG93X2xvZ28oc3RydWN0IGZiX2luZm8gKmluZm8sIHN0cnVjdCBmYl9pbWFnZSAqaW1hZ2Us
DQo+ICAJCQlpbWFnZS0+ZHggKz0gaW1hZ2UtPndpZHRoICsgODsNCj4gIAkJfQ0KPiAgCX0gZWxz
ZSBpZiAocm90YXRlID09IEZCX1JPVEFURV9VRCkgew0KPiAtCQlmb3IgKHggPSAwOyB4IDwgbnVt
OyB4KyspIHsNCj4gKwkJdTMyIGR4ID0gaW1hZ2UtPmR4Ow0KPiArDQo+ICsJCWZvciAoeCA9IDA7
IHggPCBudW0gJiYgaW1hZ2UtPmR4IDw9IGR4OyB4KyspIHsNCj4gIAkJCWluZm8tPmZib3BzLT5m
Yl9pbWFnZWJsaXQoaW5mbywgaW1hZ2UpOw0KPiAgCQkJaW1hZ2UtPmR4IC09IGltYWdlLT53aWR0
aCArIDg7DQo+ICAJCX0NCj4gQEAgLTQ0Nyw3ICs0NDksOSBAQCBzdGF0aWMgdm9pZCBmYl9kb19z
aG93X2xvZ28oc3RydWN0IGZiX2luZm8gKmluZm8sIHN0cnVjdCBmYl9pbWFnZSAqaW1hZ2UsDQo+
ICAJCQlpbWFnZS0+ZHkgKz0gaW1hZ2UtPmhlaWdodCArIDg7DQo+ICAJCX0NCj4gIAl9IGVsc2Ug
aWYgKHJvdGF0ZSA9PSBGQl9ST1RBVEVfQ0NXKSB7DQo+IC0JCWZvciAoeCA9IDA7IHggPCBudW07
IHgrKykgew0KPiArCQl1MzIgZHkgPSBpbWFnZS0+ZHk7DQo+ICsNCj4gKwkJZm9yICh4ID0gMDsg
eCA8IG51bSAmJiBpbWFnZS0+ZHkgPD0gZHk7IHgrKykgew0KPiAgCQkJaW5mby0+ZmJvcHMtPmZi
X2ltYWdlYmxpdChpbmZvLCBpbWFnZSk7DQo+ICAJCQlpbWFnZS0+ZHkgLT0gaW1hZ2UtPmhlaWdo
dCArIDg7DQo+ICAJCX0NCj4gDQoNCg==
