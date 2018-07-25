Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97EBC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3278620852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NqL0DCpu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3278620852
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbeGYDoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 23:44:54 -0400
Received: from mail-hk2apc01on0139.outbound.protection.outlook.com ([104.47.124.139]:10659
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727504AbeGYDoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 23:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSso47uDSKrelERE73yFGmso90ak7JwiSaO2PMFiXmw=;
 b=NqL0DCpuNKSoEfKJfN5MB6yIrPX9gQ5B5VHT5t4HAHF679ER7CFf6HDqin9Dsnz62WzJh6aeZabWt4/xgjUgVE0vE4Y4CPHZu4JtZ1DJUTaNK4FspduLd3cmkN+l3oxgfvAMegKf91klKxT4KSA2is+Vs6QEf1hQU9dK5nJ9yoI=
Received: from SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM (10.170.136.145) by
 SG2P15301MB0061.APCP153.PROD.OUTLOOK.COM (10.170.136.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.1; Wed, 25 Jul 2018 02:35:16 +0000
Received: from SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM
 ([fe80::f916:a637:8730:be25]) by SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM
 ([fe80::f916:a637:8730:be25%4]) with mapi id 15.20.1017.000; Wed, 25 Jul 2018
 02:35:16 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
To:     Junaid Shahid <junaids@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Subject: Re: [PATCH] KVM/MMU: Combine flushing remote tlb in mmu_set_spte()
Thread-Topic: [PATCH] KVM/MMU: Combine flushing remote tlb in mmu_set_spte()
Thread-Index: AQHUIya2sfSO0xmUGUuqak4mr618F6SecMuAgADGxQCAAAJWAA==
Date:   Wed, 25 Jul 2018 02:35:16 +0000
Message-ID: <69a525da-32d0-71c3-78e6-f8f8e8d8abb5@microsoft.com>
References: <1532420205-29930-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1aaaecab-0e18-f504-5465-06db9d852cc5@redhat.com>
 <8b07e487-0d7c-a8c5-5109-461ffea6e0a5@google.com>
In-Reply-To: <8b07e487-0d7c-a8c5-5109-461ffea6e0a5@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SG2P15301MB0061;6:YVhvdWc/CPfCTAdv9b9RwyllTM5ks9DkweVs0IwNa+ws0lm7c6kqk9ZrTDVKF1+A+syw9f76mLUSpVdKeWl8E2KVtCrMUY/hafKo5QNUcscg6hOly+8aRPIQn76u6c6UT3uMHNg+B2znLzO0oEtvEZdwiblLxGxTZaTP1ymeNzOlhhJ8E9f612Xrbqn+9Ysn0QYMdUynfYRMK9IStzukaXHYUcKVLEaQzPlt0fbWkbYlUIbyn0s1DPubsDzDWV4wsdxw9nDJ/8mrOJD4ulwJznymo4h70F5qBz6lFCOIhi9SW8h2vSD03AvINUTS7JaMIPjSsxx78nQqX+IVIiJfFlGv3YuJ5T6InH983CQKGBdxj5ZxxctEvk8o9axsZSboFNNJedaTFKB+Mk6IpmlbpoxuQpHsltqT/6meOotWbCdCvJAyUrYedHDSEryPAjUubcp2KSdpB6dNkmUxJYGkFQ==;5:WDrLli+zqgPv4kioq8bzBzZNmKnt1G0bDG67axXZotquJDjAQkhc/1wcVRXtEJzdyN8iVfEotcdgz6ybX2unChZS1aobfPU1ENsfbR+fTx56qphJFnLGaHcsE6BeuBzxOwkKp932qkR+73p5x8Ywg3x/Zv8w/uwJmDnn92Dy2aU=;7:iaP/WTFvxQjqSTFoSfdRnEaERr9pUV9T+OJZ2hxIDfwjc7/zMBSExRFOkzJk2wMq2GjcfsTvbU2/Vj8G/sdgeifnb8JESUFecbjq3K8850U+Gj2JiukbvMVVD5CVhkLjSEjI1S390ZsMh3h1Cn/s5oub0t0xNb0ssLBZzrYbYq0mqX0yl8PcXqPNXI7QAOgYJD8JacJXS5iFvFNguCePAv6969JeNQtf5YQfBq/VSyDcPqIOsi+f50Joc43PmOC/
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3e275a1e-ccec-4a02-329c-08d5f1d741c9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(4618075)(2017052603328)(7193020);SRVR:SG2P15301MB0061;
x-ms-traffictypediagnostic: SG2P15301MB0061:
x-microsoft-antispam-prvs: <SG2P15301MB0061BAAADA6F9398A07E134792540@SG2P15301MB0061.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SG2P15301MB0061;BCL:0;PCL:0;RULEID:;SRVR:SG2P15301MB0061;
x-forefront-prvs: 0744CFB5E8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(136003)(396003)(39860400002)(189003)(199004)(2616005)(25786009)(6486002)(53936002)(4326008)(86612001)(10290500003)(446003)(11346002)(97736004)(6512007)(476003)(99286004)(26005)(6246003)(72206003)(102836004)(31696002)(66066001)(1511001)(478600001)(81156014)(81166006)(8936002)(10090500001)(8676002)(5660300001)(7416002)(229853002)(2900100001)(105586002)(106356001)(486006)(2906002)(31686004)(86362001)(110136005)(6116002)(3846002)(68736007)(305945005)(186003)(7736002)(256004)(14444005)(14454004)(316002)(5250100002)(76176011)(53546011)(54906003)(22452003)(36756003)(6506007)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:SG2P15301MB0061;H:SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8+LaqYhQNVEs4BKFv0fIAGnKsHtUv+DWGmn+LaUnWEyCFDyLC8jDkBgxnrMLFw9gwgplhmrnEEASrH66CFddydW90K9HIYGkiNbzglzS4iQxH4qii72mpz7CF2EI6DYROJN5Ahd/O+For/gilChTcBck+bYlLzzYULxwJ8VIC9/gy+pUPTayRsVNId8/DeaYJBzzNpmMHRJt1uJdbE8nxA6yh6pQSBMFSBYA9pw6pBqNlpVt19XDLvXUR+XjVybGqEY1ZaSF6NARYK23s++/slKzJoZlWVK7ka57TNccjYv3VSPO1aPCJ6Ud/oRhcN7XPevX/dVbiwCM+yQZtWYp1jHj0k93tBbJiyT5R83KGNs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6A86F919BCF00439616D65AF32A5110@APCP153.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e275a1e-ccec-4a02-329c-08d5f1d741c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2018 02:35:16.2066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSnVuYWlkOg0KCVRoYW5rcyBmb3IgeW91ciByZXZpZXcuDQoNCk9uIDcvMjUvMjAxOCAxMDoy
NiBBTSwgSnVuYWlkIFNoYWhpZCB3cm90ZToNCj4gT24gMDcvMjQvMjAxOCAwNzozNSBBTSwgUGFv
bG8gQm9uemluaSB3cm90ZToNCj4+IE9uIDI0LzA3LzIwMTggMTA6MTcsIFRpYW55dSBMYW4gd3Jv
dGU6DQo+Pj4gbW11X3NldF9zcHRlKCkgZmx1c2hlcyByZW1vdGUgdGxicyBmb3IgZHJvcF9wYXJl
bnRfcHRlL2Ryb3Bfc3B0ZSgpDQo+Pj4gYW5kIHNldF9zcHRlKCkgc2VwYXJhdGVseS4gVGhpcyBt
YXkgaW50cm9kdWNlIHJlZHVuZGFudCBmbHVzaC4gVGhpcw0KPj4+IHBhdGNoIGlzIHRvIGNvbWJp
bmUgdGhlc2UgZmx1c2hlcyBhbmQgY2hlY2sgZmx1c2ggcmVxdWVzdCBhZnRlcg0KPj4+IGNhbGxp
bmcgc2V0X3NwdGUoKS4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IExhbiBUaWFueXUgPFRpYW55
dS5MYW5AbWljcm9zb2Z0LmNvbT4NCj4+DQo+PiBMb29rcyBnb29kLCBidXQgSSdkIGxpa2UgYSBz
ZWNvbmQgb3Bpbmlvbi4gIEd1YW5ncm9uZywgSnVuYWlkLCBjYW4geW91DQo+PiByZXZpZXcgdGhp
cz8NCj4+DQo+PiBUaGFua3MsDQo+Pg0KPj4gUGFvbG8NCj4+DQo+Pj4gLS0tDQo+Pj4gICBhcmNo
L3g4Ni9rdm0vbW11LmMgfCA3ICsrKystLS0NCj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYv
a3ZtL21tdS5jIGIvYXJjaC94ODYva3ZtL21tdS5jDQo+Pj4gaW5kZXggMjJhNzk4NC4uOGYyMTYz
MiAxMDA2NDQNCj4+PiAtLS0gYS9hcmNoL3g4Ni9rdm0vbW11LmMNCj4+PiArKysgYi9hcmNoL3g4
Ni9rdm0vbW11LmMNCj4+PiBAQCAtMjkwMSw2ICsyOTAxLDcgQEAgc3RhdGljIGludCBtbXVfc2V0
X3NwdGUoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCB1NjQgKnNwdGVwLCB1bnNpZ25lZCBwdGVfYWNj
ZXNzLA0KPj4+ICAgCWludCBybWFwX2NvdW50Ow0KPj4+ICAgCWludCBzZXRfc3B0ZV9yZXQ7DQo+
Pj4gICAJaW50IHJldCA9IFJFVF9QRl9SRVRSWTsNCj4+PiArCWJvb2wgZmx1c2ggPSBmYWxzZTsN
Cj4+PiAgIA0KPj4+ICAgCXBncHJpbnRrKCIlczogc3B0ZSAlbGx4IHdyaXRlX2ZhdWx0ICVkIGdm
biAlbGx4XG4iLCBfX2Z1bmNfXywNCj4+PiAgIAkJICpzcHRlcCwgd3JpdGVfZmF1bHQsIGdmbik7
DQo+Pj4gQEAgLTI5MTcsMTIgKzI5MTgsMTIgQEAgc3RhdGljIGludCBtbXVfc2V0X3NwdGUoc3Ry
dWN0IGt2bV92Y3B1ICp2Y3B1LCB1NjQgKnNwdGVwLCB1bnNpZ25lZCBwdGVfYWNjZXNzLA0KPj4+
ICAgDQo+Pj4gICAJCQljaGlsZCA9IHBhZ2VfaGVhZGVyKHB0ZSAmIFBUNjRfQkFTRV9BRERSX01B
U0spOw0KPj4+ICAgCQkJZHJvcF9wYXJlbnRfcHRlKGNoaWxkLCBzcHRlcCk7DQo+Pj4gLQkJCWt2
bV9mbHVzaF9yZW1vdGVfdGxicyh2Y3B1LT5rdm0pOw0KPj4+ICsJCQlmbHVzaCA9IHRydWU7DQo+
Pj4gICAJCX0gZWxzZSBpZiAocGZuICE9IHNwdGVfdG9fcGZuKCpzcHRlcCkpIHsNCj4+PiAgIAkJ
CXBncHJpbnRrKCJoZm4gb2xkICVsbHggbmV3ICVsbHhcbiIsDQo+Pj4gICAJCQkJIHNwdGVfdG9f
cGZuKCpzcHRlcCksIHBmbik7DQo+Pj4gICAJCQlkcm9wX3NwdGUodmNwdS0+a3ZtLCBzcHRlcCk7
DQo+Pj4gLQkJCWt2bV9mbHVzaF9yZW1vdGVfdGxicyh2Y3B1LT5rdm0pOw0KPj4+ICsJCQlmbHVz
aCA9IHRydWU7DQo+Pj4gICAJCX0gZWxzZQ0KPj4+ICAgCQkJd2FzX3JtYXBwZWQgPSAxOw0KPj4+
ICAgCX0NCj4+PiBAQCAtMjkzNCw3ICsyOTM1LDcgQEAgc3RhdGljIGludCBtbXVfc2V0X3NwdGUo
c3RydWN0IGt2bV92Y3B1ICp2Y3B1LCB1NjQgKnNwdGVwLCB1bnNpZ25lZCBwdGVfYWNjZXNzLA0K
Pj4+ICAgCQkJcmV0ID0gUkVUX1BGX0VNVUxBVEU7DQo+Pj4gICAJCWt2bV9tYWtlX3JlcXVlc3Qo
S1ZNX1JFUV9UTEJfRkxVU0gsIHZjcHUpOw0KPj4+ICAgCX0NCj4+PiAtCWlmIChzZXRfc3B0ZV9y
ZXQgJiBTRVRfU1BURV9ORUVEX1JFTU9URV9UTEJfRkxVU0gpDQo+Pj4gKwlpZiAoc2V0X3NwdGVf
cmV0ICYgU0VUX1NQVEVfTkVFRF9SRU1PVEVfVExCX0ZMVVNIIHx8IGZsdXNoKQ0KPj4+ICAgCQlr
dm1fZmx1c2hfcmVtb3RlX3RsYnModmNwdS0+a3ZtKTsNCj4+PiAgIA0KPj4+ICAgCWlmICh1bmxp
a2VseShpc19tbWlvX3NwdGUoKnNwdGVwKSkpDQo+Pj4NCj4+DQo+IA0KPiBSZXZpZXdlZC1ieTog
SnVuYWlkIFNoYWhpZCA8anVuYWlkc0Bnb29nbGUuY29tPg0KPiA=
