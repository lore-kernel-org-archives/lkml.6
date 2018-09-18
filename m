Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7645DECE563
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A25214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WvGo9tWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A25214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbeIRItx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 04:49:53 -0400
Received: from mail-hk2apc01on0134.outbound.protection.outlook.com ([104.47.124.134]:26991
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729423AbeIRItw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 04:49:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVpmtfU8wjS+Cu8+DmBMnI45GEn3ZQrFdtue46elr+A=;
 b=WvGo9tWw5XEckOZBRE+caDexgYuBeoEtWnzO8e9ovvZsD6SVPKI/Rz4fZmN7ckc8YuHTVaRo+jVd8OTWip06uBzTMwTfTBqdJG034KlA9oHUpIf3KS5fo+ihN+5vQs3beInswf6mFZqRe9UEIaAUUtIkhHyPr5/c/m5zD3ua6/c=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0130.APCP153.PROD.OUTLOOK.COM (52.133.156.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Tue, 18 Sep 2018 03:19:15 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267%3]) with mapi id 15.20.1185.006; Tue, 18 Sep 2018
 03:19:15 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>
Subject: [PATCH V2 10/13] x86/hyper-v: Add HvFlushGuestAddressList hypercall
 support
Thread-Topic: [PATCH V2 10/13] x86/hyper-v: Add HvFlushGuestAddressList
 hypercall support
Thread-Index: AQHUTv5g4r9T3NuYAU+4IddbeE1g5A==
Date:   Tue, 18 Sep 2018 03:19:14 +0000
Message-ID: <20180918031754.113013-11-Tianyu.Lan@microsoft.com>
References: <20180918031754.113013-1-Tianyu.Lan@microsoft.com>
In-Reply-To: <20180918031754.113013-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK0P153MB0130;6:Ie1K8vIMXYZZUqTbEpmvAvV3gfuNU2/UykAiulzInNZES0qoIEf8HY91aK7xdoLVyp6LesFwGRdJA3G9HaSc9IpnNx9TqVSIOV+cgzlvQBlkP+j1PUgXZMyHEZXY+wwVR91ls/dVoL/iOJoO9M3LS1OcbU5DGtuQV9cStZ5xLZAY6kOnMNQHFEc+zsa1C3H+pCP3qU2fpzVHksfz0zrxrcuL5UehwsQa6sfIMfj1GhsqyALClCiTLetnsQNeBFv7vm7tS0CsV28oZnd3qPG2E9ZPPLZpEJN3G7UK+gZIoP5lCyLhX6mWUjEWDXzsHyNlqjH0+qhpOUxrbzGAXTE+WYKVm9RGx4UUA8tFWXPbBVzewGEsKskri9LKXl59H5ekqUk82l3sQHtVxtBKKchxjkUM2zwep5UUZ+R+Tn2RY1yRqnW59WZegJMd0aJmIFWnzUyxVySEm4x0NQShqY46jQ==;5:aHfLSjLKYgCxgHs169Kj6WLFMGiSHPVS2pwGwJ3USBVhRWc6QfI+ENgLRcjJXz2+9kR7Qg0w7JRTd8bWndTemnd5FzCNx5UYpVC7MWqdl4UrfWmf0s72iHHDt9Dh6OhBzUlQZyLdSZo7e38YIUOVtg3B0vYxujtQ7+HUjoUZ1AU=;7:ZXuaDiU5Hcq1rGPLxHkbRLmPSSiIxbL0l8+Hifj6Z0Y9NTei3jdZyQ1X0oJ9cY9qUK9mlmCnEeXiAnry8Oma/+Y948aUDs9R6dbzVd9/+oIfKPPhwU5PhcdvRGzQciD8l/RmTRaWPitOCjYzAsqHBabb8KOdIEPSBWPPf6t8dmdUZMaxJDhSVriVd5Z1tg6aVoBUFXtx/V6o9FUVVi0WfjCI7IcgRLy5RY4Rs819iWgNZ1idegrpUWf56xTyJUwk
x-ms-office365-filtering-correlation-id: d1096772-7211-4e09-d5a6-08d61d158354
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0130;
x-ms-traffictypediagnostic: HK0P153MB0130:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB0130D58F7BD50D5BA6B36279921D0@HK0P153MB0130.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:HK0P153MB0130;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0130;
x-forefront-prvs: 0799B1B2D7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6029001)(376002)(346002)(39860400002)(366004)(396003)(136003)(199004)(189003)(6486002)(36756003)(59246006)(68736007)(25786009)(2900100001)(5660300001)(22452003)(11346002)(53936002)(316002)(446003)(305945005)(5250100002)(107886003)(109986005)(86362001)(575784001)(7736002)(476003)(2616005)(7416002)(86612001)(486006)(14454004)(256004)(6512007)(72206003)(8936002)(4326008)(6506007)(478600001)(97736004)(26005)(3846002)(102836004)(8676002)(6116002)(10090500001)(81156014)(6436002)(14444005)(81166006)(106356001)(76176011)(2906002)(105586002)(1076002)(1671002)(54906003)(66066001)(99286004)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0130;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6Z1G9gSq21BvG6Q97qVqONvg8xWfnxoWr1+PdO1BF1vElBCJ9/DmwMekouhWazIePOLz1YB/UDtJNCKnFu5GdVqht/vGtMDDveL3rVxJMcy/P4Rft1vX57bFpbegaGw3KaU6d7eLYHjg+XpJFZ6vOHMMrXjDQQFXTtf46iTa9Y07S5exw/wpn8c3BtgD5/weXfcNpViJFQdlbxuy0cSFkTbuUJ7K6VYx0PFE2QPmF2EP7hjf/XTbao/KLfKl5vLX4dhJTk2z8RnCdZJl1kYN6+AorkaAR+X3u30UNKMsKylWIt4rDxDI0F7HkG/4bC5BQhp+v/rFQzgzv5oZY9uua2QYovObmqDQ01k7U2Uewkc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <62F86B30E9210443B05D6C5475683C9C@APCP153.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1096772-7211-4e09-d5a6-08d61d158354
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2018 03:19:14.9944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0130
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SHlwZXItViBwcm92aWRlcyBIdkZsdXNoR3Vlc3RBZGRyZXNzTGlzdCgpIGh5cGVyY2FsbCB0byBm
bHVzaCBFUFQgdGxiDQp3aXRoIHNwZWNpZmllZCByYW5nZXMuIFRoaXMgcGF0Y2ggaXMgdG8gYWRk
IHRoZSBoeXBlcmNhbGwgc3VwcG9ydC4NCg0KU2lnbmVkLW9mZi1ieTogTGFuIFRpYW55dSA8VGlh
bnl1LkxhbkBtaWNyb3NvZnQuY29tPg0KLS0tDQpDaGFuZ2Ugc2luY2UgdjE6DQogICAgICAgQWRk
IGh5cGVydiB0bGIgZmx1c2ggc3RydWN0IHRvIGF2b2lkIHVzZSBrdm0gdGxiIGZsdXNoIHN0cnVj
dA0KaW4gdGhlIGh5cGVydiBmaWxlLg0KLS0tDQogYXJjaC94ODYvaHlwZXJ2L25lc3RlZC5jICAg
ICAgICAgICB8IDEwMyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogYXJj
aC94ODYvaW5jbHVkZS9hc20vaHlwZXJ2LXRsZnMuaCB8ICAxNyArKysrKysNCiBhcmNoL3g4Ni9p
bmNsdWRlL2FzbS9tc2h5cGVydi5oICAgIHwgIDE2ICsrKysrKw0KIDMgZmlsZXMgY2hhbmdlZCwg
MTM2IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2h5cGVydi9uZXN0ZWQu
YyBiL2FyY2gveDg2L2h5cGVydi9uZXN0ZWQuYw0KaW5kZXggYjhlNjBjYzUwNDYxLi40MGRkYmZk
NTQ1NzMgMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9oeXBlcnYvbmVzdGVkLmMNCisrKyBiL2FyY2gv
eDg2L2h5cGVydi9uZXN0ZWQuYw0KQEAgLTcsMTUgKzcsMzIgQEANCiAgKg0KICAqIEF1dGhvciA6
IExhbiBUaWFueXUgPFRpYW55dS5MYW5AbWljcm9zb2Z0LmNvbT4NCiAgKi8NCisjZGVmaW5lIHBy
X2ZtdChmbXQpICAiSHlwZXItVjogIiBmbXQNCiANCiANCiAjaW5jbHVkZSA8bGludXgvdHlwZXMu
aD4NCiAjaW5jbHVkZSA8YXNtL2h5cGVydi10bGZzLmg+DQogI2luY2x1ZGUgPGFzbS9tc2h5cGVy
di5oPg0KICNpbmNsdWRlIDxhc20vdGxiZmx1c2guaD4NCisjaW5jbHVkZSA8YXNtL2t2bV9ob3N0
Lmg+DQogDQogI2luY2x1ZGUgPGFzbS90cmFjZS9oeXBlcnYuaD4NCiANCisvKg0KKyAqICBNQVhf
RkxVU0hfUEFHRVMgPSAiYWRkaXRpb25hbF9wYWdlcyIgKyAxLiBJdCdzIGxpbWl0ZWQNCisgKiAg
YnkgdGhlIGJpdHdpZHRoIG9mICJhZGRpdGlvbmFsX3BhZ2VzIiBpbiB1bmlvbiBodl9ncGFfcGFn
ZV9yYW5nZS4NCisgKi8NCisjZGVmaW5lIE1BWF9GTFVTSF9QQUdFUyAoMjA0OCkNCisNCisvKg0K
KyAqIEFsbCBpbnB1dCBmbHVzaCBwYXJhbWV0ZXJzIGFyZSBpbiBzaW5nbGUgcGFnZS4gVGhlIG1h
eCBmbHVzaCBjb3VudA0KKyAqIGlzIGVxdWFsIHdpdGggaG93IG1hbnkgZW50cmllcyBvZiB1bmlv
biBodl9ncGFfcGFnZV9yYW5nZSBjYW4gYmUNCisgKiBwb3B1bGF0ZWQgaW4gdGhlIGlucHV0IHBh
cmFtZXRlciBwYWdlLiBNQVhfRkxVU0hfUkVQX0NPVU5UDQorICogPSAoNDA5NiAtIDE2KSAvIDgu
ICjigJxQYWdlIFNpemXigJ0gLSAiQWRkcmVzcyBTcGFjZSIgLSAiRmxhZ3MiKSAvDQorICogIkdQ
QSBSYW5nZSIuDQorICovDQorI2RlZmluZSBNQVhfRkxVU0hfUkVQX0NPVU5UICg1MTApDQorDQog
aW50IGh5cGVydl9mbHVzaF9ndWVzdF9tYXBwaW5nKHU2NCBhcykNCiB7DQogCXN0cnVjdCBodl9n
dWVzdF9tYXBwaW5nX2ZsdXNoICoqZmx1c2hfcGNwdTsNCkBAIC01NCwzICs3MSw4OSBAQCBpbnQg
aHlwZXJ2X2ZsdXNoX2d1ZXN0X21hcHBpbmcodTY0IGFzKQ0KIAlyZXR1cm4gcmV0Ow0KIH0NCiBF
WFBPUlRfU1lNQk9MX0dQTChoeXBlcnZfZmx1c2hfZ3Vlc3RfbWFwcGluZyk7DQorDQorc3RhdGlj
IGludCBmaWxsX2ZsdXNoX2xpc3QodW5pb24gaHZfZ3BhX3BhZ2VfcmFuZ2UgZ3BhX2xpc3RbXSwN
CisJCWludCBvZmZzZXQsIHU2NCBzdGFydF9nZm4sIHU2NCBwYWdlcykNCit7DQorCWludCBncGFf
biA9IG9mZnNldDsNCisJdTY0IGN1ciA9IHN0YXJ0X2dmbjsNCisJdTY0IGFkZGl0aW9uYWxfcGFn
ZXM7DQorDQorCWRvIHsNCisJCWlmIChncGFfbiA+PSBNQVhfRkxVU0hfUkVQX0NPVU5UKSB7DQor
CQkJcHJfd2FybigiUmVxdWVzdCBleGNlZWRzIEh2Rmx1c2hHdWVzdExpc3QgbWF4IGZsdXNoIGNv
dW50LiIpOw0KKwkJCXJldHVybiAtRU5PU1BDOw0KKwkJfQ0KKw0KKwkJaWYgKHBhZ2VzID4gTUFY
X0ZMVVNIX1BBR0VTKSB7DQorCQkJYWRkaXRpb25hbF9wYWdlcyA9IE1BWF9GTFVTSF9QQUdFUyAt
IDE7DQorCQkJcGFnZXMgLT0gTUFYX0ZMVVNIX1BBR0VTOw0KKwkJfSBlbHNlIHsNCisJCQlhZGRp
dGlvbmFsX3BhZ2VzID0gcGFnZXMgLSAxOw0KKwkJCXBhZ2VzID0gMDsNCisJCX0NCisNCisJCWdw
YV9saXN0W2dwYV9uXS5wYWdlLmFkZGl0aW9uYWxfcGFnZXMgPSBhZGRpdGlvbmFsX3BhZ2VzOw0K
KwkJZ3BhX2xpc3RbZ3BhX25dLnBhZ2UubGFyZ2VwYWdlID0gZmFsc2U7DQorCQlncGFfbGlzdFtn
cGFfbl0ucGFnZS5iYXNlcGZuID0gY3VyOw0KKw0KKwkJY3VyICs9IGFkZGl0aW9uYWxfcGFnZXMg
KyAxOw0KKwkJZ3BhX24rKzsNCisJfSB3aGlsZSAocGFnZXMgPiAwKTsNCisNCisJcmV0dXJuIGdw
YV9uOw0KK30NCisNCitpbnQgaHlwZXJ2X2ZsdXNoX2d1ZXN0X21hcHBpbmdfcmFuZ2UodTY0IGFz
LCBzdHJ1Y3QgaHlwZXJ2X3RsYl9yYW5nZSAqcmFuZ2UpDQorew0KKwlzdHJ1Y3QgaHZfZ3Vlc3Rf
bWFwcGluZ19mbHVzaF9saXN0ICoqZmx1c2hfcGNwdTsNCisJc3RydWN0IGh2X2d1ZXN0X21hcHBp
bmdfZmx1c2hfbGlzdCAqZmx1c2g7DQorCXU2NCBzdGF0dXMgPSAwOw0KKwl1bnNpZ25lZCBsb25n
IGZsYWdzOw0KKwlpbnQgcmV0ID0gLUVOT1RTVVBQOw0KKwlpbnQgZ3BhX24gPSAwOw0KKw0KKwlp
ZiAoIWh2X2h5cGVyY2FsbF9wZykNCisJCWdvdG8gZmF1bHQ7DQorDQorCWxvY2FsX2lycV9zYXZl
KGZsYWdzKTsNCisNCisJZmx1c2hfcGNwdSA9IChzdHJ1Y3QgaHZfZ3Vlc3RfbWFwcGluZ19mbHVz
aF9saXN0ICoqKQ0KKwkJdGhpc19jcHVfcHRyKGh5cGVydl9wY3B1X2lucHV0X2FyZyk7DQorDQor
CWZsdXNoID0gKmZsdXNoX3BjcHU7DQorCWlmICh1bmxpa2VseSghZmx1c2gpKSB7DQorCQlsb2Nh
bF9pcnFfcmVzdG9yZShmbGFncyk7DQorCQlnb3RvIGZhdWx0Ow0KKwl9DQorDQorCWZsdXNoLT5h
ZGRyZXNzX3NwYWNlID0gYXM7DQorCWZsdXNoLT5mbGFncyA9IDA7DQorDQorCWlmICghcmFuZ2Ut
PmZsdXNoX2xpc3QpDQorCQlncGFfbiA9IGZpbGxfZmx1c2hfbGlzdChmbHVzaC0+Z3BhX2xpc3Qs
IGdwYV9uLA0KKwkJCQlyYW5nZS0+c3RhcnRfZ2ZuLCByYW5nZS0+cGFnZXMpOw0KKwllbHNlIGlm
IChyYW5nZS0+cGFyc2VfZmx1c2hfbGlzdF9mdW5jKQ0KKwkJZ3BhX24gPSByYW5nZS0+cGFyc2Vf
Zmx1c2hfbGlzdF9mdW5jKGZsdXNoLT5ncGFfbGlzdCwgZ3BhX24sDQorCQkJCXJhbmdlLT5mbHVz
aF9saXN0LCBmaWxsX2ZsdXNoX2xpc3QpOw0KKwllbHNlDQorCQlncGFfbiA9IC0xOw0KKw0KKwlp
ZiAoZ3BhX24gPCAwKSB7DQorCQlsb2NhbF9pcnFfcmVzdG9yZShmbGFncyk7DQorCQlnb3RvIGZh
dWx0Ow0KKwl9DQorDQorCXN0YXR1cyA9IGh2X2RvX3JlcF9oeXBlcmNhbGwoSFZDQUxMX0ZMVVNI
X0dVRVNUX1BIWVNJQ0FMX0FERFJFU1NfTElTVCwNCisJCQkJICAgICBncGFfbiwgMCwgZmx1c2gs
IE5VTEwpOw0KKw0KKwlsb2NhbF9pcnFfcmVzdG9yZShmbGFncyk7DQorDQorCWlmICghKHN0YXR1
cyAmIEhWX0hZUEVSQ0FMTF9SRVNVTFRfTUFTSykpDQorCQlyZXQgPSAwOw0KKwllbHNlDQorCQly
ZXQgPSBzdGF0dXM7DQorZmF1bHQ6DQorCXJldHVybiByZXQ7DQorfQ0KK0VYUE9SVF9TWU1CT0xf
R1BMKGh5cGVydl9mbHVzaF9ndWVzdF9tYXBwaW5nX3JhbmdlKTsNCmRpZmYgLS1naXQgYS9hcmNo
L3g4Ni9pbmNsdWRlL2FzbS9oeXBlcnYtdGxmcy5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vaHlw
ZXJ2LXRsZnMuaA0KaW5kZXggZTk3N2I2YjNhNTM4Li41MTJmMjJiNDk5OTkgMTAwNjQ0DQotLS0g
YS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9oeXBlcnYtdGxmcy5oDQorKysgYi9hcmNoL3g4Ni9pbmNs
dWRlL2FzbS9oeXBlcnYtdGxmcy5oDQpAQCAtMzUzLDYgKzM1Myw3IEBAIHN0cnVjdCBodl90c2Nf
ZW11bGF0aW9uX3N0YXR1cyB7DQogI2RlZmluZSBIVkNBTExfUE9TVF9NRVNTQUdFCQkJMHgwMDVj
DQogI2RlZmluZSBIVkNBTExfU0lHTkFMX0VWRU5UCQkJMHgwMDVkDQogI2RlZmluZSBIVkNBTExf
RkxVU0hfR1VFU1RfUEhZU0lDQUxfQUREUkVTU19TUEFDRSAweDAwYWYNCisjZGVmaW5lIEhWQ0FM
TF9GTFVTSF9HVUVTVF9QSFlTSUNBTF9BRERSRVNTX0xJU1QgMHgwMGIwDQogDQogI2RlZmluZSBI
Vl9YNjRfTVNSX1ZQX0FTU0lTVF9QQUdFX0VOQUJMRQkweDAwMDAwMDAxDQogI2RlZmluZSBIVl9Y
NjRfTVNSX1ZQX0FTU0lTVF9QQUdFX0FERFJFU1NfU0hJRlQJMTINCkBAIC03NTAsNiArNzUxLDIy
IEBAIHN0cnVjdCBodl9ndWVzdF9tYXBwaW5nX2ZsdXNoIHsNCiAJdTY0IGZsYWdzOw0KIH07DQog
DQorLyogSHZGbHVzaEd1ZXN0UGh5c2ljYWxBZGRyZXNzTGlzdCBoeXBlcmNhbGwgKi8NCit1bmlv
biBodl9ncGFfcGFnZV9yYW5nZSB7DQorCXU2NCBhZGRyZXNzX3NwYWNlOw0KKwlzdHJ1Y3Qgew0K
KwkJdTY0IGFkZGl0aW9uYWxfcGFnZXM6MTE7DQorCQl1NjQgbGFyZ2VwYWdlOjE7DQorCQl1NjQg
YmFzZXBmbjo1MjsNCisJfSBwYWdlOw0KK307DQorDQorc3RydWN0IGh2X2d1ZXN0X21hcHBpbmdf
Zmx1c2hfbGlzdCB7DQorCXU2NCBhZGRyZXNzX3NwYWNlOw0KKwl1NjQgZmxhZ3M7DQorCXVuaW9u
IGh2X2dwYV9wYWdlX3JhbmdlIGdwYV9saXN0W107DQorfTsNCisNCiAvKiBIdkZsdXNoVmlydHVh
bEFkZHJlc3NTcGFjZSwgSHZGbHVzaFZpcnR1YWxBZGRyZXNzTGlzdCBoeXBlcmNhbGxzICovDQog
c3RydWN0IGh2X3RsYl9mbHVzaCB7DQogCXU2NCBhZGRyZXNzX3NwYWNlOw0KZGlmZiAtLWdpdCBh
L2FyY2gveDg2L2luY2x1ZGUvYXNtL21zaHlwZXJ2LmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9t
c2h5cGVydi5oDQppbmRleCBmMzc3MDQ0OTdkOGYuLjE5ZjQ5ZmJjZjk0ZCAxMDA2NDQNCi0tLSBh
L2FyY2gveDg2L2luY2x1ZGUvYXNtL21zaHlwZXJ2LmgNCisrKyBiL2FyY2gveDg2L2luY2x1ZGUv
YXNtL21zaHlwZXJ2LmgNCkBAIC0yMiw2ICsyMiwxNiBAQCBzdHJ1Y3QgbXNfaHlwZXJ2X2luZm8g
ew0KIA0KIGV4dGVybiBzdHJ1Y3QgbXNfaHlwZXJ2X2luZm8gbXNfaHlwZXJ2Ow0KIA0KK3N0cnVj
dCBoeXBlcnZfdGxiX3JhbmdlIHsNCisJdTY0IHN0YXJ0X2dmbjsNCisJdTY0IHBhZ2VzOw0KKwlz
dHJ1Y3QgbGlzdF9oZWFkICpmbHVzaF9saXN0Ow0KKwlpbnQgKCpwYXJzZV9mbHVzaF9saXN0X2Z1
bmMpKHVuaW9uIGh2X2dwYV9wYWdlX3JhbmdlIGdwYV9saXN0W10sDQorCQlpbnQgb2Zmc2V0LCBz
dHJ1Y3QgbGlzdF9oZWFkICpmbHVzaF9saXN0LA0KKwkJaW50ICgqZmlsbF9mbHVzaF9saXN0KSh1
bmlvbiBodl9ncGFfcGFnZV9yYW5nZSBncGFfbGlzdFtdLA0KKwkJaW50IG9mZnNldCwgdTY0IHN0
YXJ0X2dmbiwgdTY0IGVuZF9nZm4pKTsNCit9Ow0KKw0KIC8qDQogICogR2VuZXJhdGUgdGhlIGd1
ZXN0IElELg0KICAqLw0KQEAgLTM0OCw2ICszNTgsNyBAQCB2b2lkIHNldF9odl90c2NjaGFuZ2Vf
Y2Iodm9pZCAoKmNiKSh2b2lkKSk7DQogdm9pZCBjbGVhcl9odl90c2NjaGFuZ2VfY2Iodm9pZCk7
DQogdm9pZCBoeXBlcnZfc3RvcF90c2NfZW11bGF0aW9uKHZvaWQpOw0KIGludCBoeXBlcnZfZmx1
c2hfZ3Vlc3RfbWFwcGluZyh1NjQgYXMpOw0KK2ludCBoeXBlcnZfZmx1c2hfZ3Vlc3RfbWFwcGlu
Z19yYW5nZSh1NjQgYXMsIHN0cnVjdCBoeXBlcnZfdGxiX3JhbmdlICpyYW5nZSk7DQogDQogI2lm
ZGVmIENPTkZJR19YODZfNjQNCiB2b2lkIGh2X2FwaWNfaW5pdCh2b2lkKTsNCkBAIC0zNjgsNiAr
Mzc5LDExIEBAIHN0YXRpYyBpbmxpbmUgc3RydWN0IGh2X3ZwX2Fzc2lzdF9wYWdlICpodl9nZXRf
dnBfYXNzaXN0X3BhZ2UodW5zaWduZWQgaW50IGNwdSkNCiAJcmV0dXJuIE5VTEw7DQogfQ0KIHN0
YXRpYyBpbmxpbmUgaW50IGh5cGVydl9mbHVzaF9ndWVzdF9tYXBwaW5nKHU2NCBhcykgeyByZXR1
cm4gLTE7IH0NCitzdGF0aWMgaW5saW5lIGludCBoeXBlcnZfZmx1c2hfZ3Vlc3RfbWFwcGluZ19y
YW5nZSh1NjQgYXMsDQorCQlzdHJ1Y3QgaHlwZXJ2X3RsYl9yYW5nZSAqcmFuZ2UpDQorew0KKwly
ZXR1cm4gLTE7DQorfQ0KICNlbmRpZiAvKiBDT05GSUdfSFlQRVJWICovDQogDQogI2lmZGVmIENP
TkZJR19IWVBFUlZfVFNDUEFHRQ0KLS0gDQoyLjE0LjQNCg==
