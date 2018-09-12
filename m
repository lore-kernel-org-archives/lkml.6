Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9D4C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A3FC20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CFgy9WOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A3FC20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbeILSpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:45:41 -0400
Received: from mail-hk2apc01on0138.outbound.protection.outlook.com ([104.47.124.138]:11841
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726792AbeILSpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRJStOWpv/AP2nn7AneiKwENzAKNKKjq5dyB20Fg32Y=;
 b=CFgy9WOWj2EYBz/U5AvLPupCWv1BocRAz7qHBaWDgsn8VVpms5QUeGMGScmZ8RpjdrRRbjWNkghYjr8TIGqjwjVaXlDZuby4i8YiX43X42GQ/VrNGqMlcU+7/PHhfzr4+PykQ3xQPGL5xUS02rpZ8pyM4oivsbVlwBAZLwruhQ8=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0162.APCP153.PROD.OUTLOOK.COM (52.133.156.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.6; Wed, 12 Sep 2018 13:40:44 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::194c:c2f9:171:1890]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::194c:c2f9:171:1890%5]) with mapi id 15.20.1143.010; Wed, 12 Sep 2018
 13:40:44 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
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
Subject: Re: [PATCH 1/13] KVM: Add tlb_remote_flush_with_range callback in
 kvm_x86_ops
Thread-Topic: [PATCH 1/13] KVM: Add tlb_remote_flush_with_range callback in
 kvm_x86_ops
Thread-Index: AQHUSOGlPYk0dzaap0aJJdx4SZcp6qTpkT6AgAMZWYA=
Date:   Wed, 12 Sep 2018 13:40:44 +0000
Message-ID: <8423e06f-eecd-bdee-1e78-ecb107310c40@microsoft.com>
References: <20180910083806.65177-1-Tianyu.Lan@microsoft.com>
 <20180910083806.65177-2-Tianyu.Lan@microsoft.com>
 <1536589263.11460.59.camel@intel.com>
In-Reply-To: <1536589263.11460.59.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK0P153MB0162;6:RP5d0NnXFKzY3Bi87cPQRYuBMXqSzOE9en+nbkJY+m6h2iQYPTNoiTOtwMH3cOAvO6UI9F+MrIAaS5x+5xwoZ5jmGTGL4n9+sz4vxTfS3TB0jl9xKN8nVXeDCEmQ6x7x3+NI3/jiy8DcR2FIrNS4vHpEDoaFcRKqXIGCiPB8mbyQLZ2xuRdA/krJGBZTuKR+KY2APqJ4vzOkLNtpnkvWTSlLomRNw5fc8TjNbjLwdjGrgLRmhnwuj64ez8mBaes+H2IzirFRgY86quozvOxqKvC3CwqRXBT6lDHtaa7T81a65amY5TY/CmC+4WINyEL2vUpXzKJus3FeWI6HNv1PKEO4vspQwAwiBOYyWbnjmOAFa/KaCdxiROg0afUq56U4ksDlmBBijdaSj04oZ01a2FL9UN1uFf/Ru3RaChUVu/vhlrxkD6aFQVZnhWVZcaHhHWArPD2MutsBeOAOt98DCQ==;5:1RNAk9WodzHc118G0nXCmVgGkTNtqExnaMPrH4Uq1UNoARU7+WJAH4kWlQxAZOap11YCeCHRDOqZXQpI560IinQKHUh+o8RZMiLFuTCMdHIIF9T/D03ecP/pOrS2igVQPBwYMpcLbEL1I+ZBHmwlwtqiiNvjPiEQCDxu1BLV2uw=;7:6PoxL0k39BvcBiUWi/aa2kGAXSoutzvID1NzHfEQ0fJexAY/OaM2WTDMK3H2RUCo1vrZUH9bSHeEfgzfFA6giBdOESX73JIXlHU/Mr3x3GvW+FctfrEHEMtSeZ9VKVDFZsJJ1xRsoEQVn52gfpkkApiMxk6p/gs/UzGTa6KcBPUNKL2bbyoAySEC5aOdV3SsGj1xhB++oVA78DMjxz71M8xamtGf7PoMrEwrF+LgoE9gFuZmuFgV0CHjb7IdGaEM
x-ms-office365-filtering-correlation-id: 88702e8b-d8b5-4513-03dc-08d618b5571c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0162;
x-ms-traffictypediagnostic: HK0P153MB0162:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB0162A9B45209F71975C17C0E921B0@HK0P153MB0162.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:HK0P153MB0162;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0162;
x-forefront-prvs: 07935ACF08
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(366004)(346002)(39860400002)(189003)(199004)(486006)(7736002)(110136005)(22452003)(81166006)(68736007)(8676002)(81156014)(6486002)(2906002)(316002)(476003)(6436002)(5660300001)(2900100001)(446003)(5250100002)(2616005)(11346002)(97736004)(6506007)(1511001)(26005)(72206003)(14454004)(10290500003)(478600001)(256004)(102836004)(8936002)(10090500001)(229853002)(99286004)(66066001)(6512007)(53546011)(3846002)(53936002)(305945005)(106356001)(76176011)(25786009)(54906003)(6116002)(36756003)(86612001)(107886003)(4326008)(6246003)(31686004)(186003)(86362001)(7416002)(31696002)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0162;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5SONsDySLLRhy/9Z+hE/3IJ/aAfreCXwDA+hBeac7gjH3Fp0JxtARympHzmoB+JWyGb5JtSd/m1mlUcsYeLt8rrjZZN5aPsKSLd7msPO00MyRm7bj6ueaB6dt4NApMXWK01KEzOXX18PSecuJWn0GGtQQGoINTu8cAJzAG+G7WZmSEn2lPuaae08tNzB1jgJNBSd9FWed1Aopxv5gN3MT6s5oB2aKOLIiH0MOtHRZpEjPmi1hct+h9cW1qM50IvBJiR8z0AcbMNjWIKWBgUeCRkxwtFET09bGkTgGEo6RJJeY3sk1WaSJptK0ROHzk3UNWGmSktf5ceQZFGmCkvVglDORCJ7NFJ4oBM0BWEIep0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <866694BD02ADDB45B49E842394CF2CE6@APCP153.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88702e8b-d8b5-4513-03dc-08d618b5571c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2018 13:40:44.4691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2VhbjoNCglUaGFua3MgZm9yIHlvdXIgcmV2aWV3Lg0KDQpPbiA5LzEwLzIwMTggMTA6MjEg
UE0sIFNlYW4gQ2hyaXN0b3BoZXJzb24gd3JvdGU6DQo+IE9uIE1vbiwgMjAxOC0wOS0xMCBhdCAw
ODozOCArMDAwMCwgVGlhbnl1IExhbiB3cm90ZToNCj4+IEFkZCBmbHVzaCByYW5nZSBjYWxsIGJh
Y2sgaW4gdGhlIGt2bV94ODZfb3BzIGFuZCBwbGF0Zm9ybSBjYW4gdXNlIGl0DQo+PiB0byByZWdp
c3RlciBpdHMgYXNzb2NpYXRlZCBmdW5jdGlvbi4gVGhlIHBhcmFtZXRlciAia3ZtX3RsYl9yYW5n
ZSINCj4+IGFjY2VwdHMgYSBzaW5nbGUgcmFuZ2UgYW5kIGZsdXNoIGxpc3Qgd2hpY2ggY29udGFp
bnMgYSBsaXN0IG9mIHJhbmdlcy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBMYW4gVGlhbnl1IDxU
aWFueXUuTGFuQG1pY3Jvc29mdC5jb20+DQo+PiAtLS0NCj4+ICDCoGFyY2gveDg2L2luY2x1ZGUv
YXNtL2t2bV9ob3N0LmggfCA4ICsrKysrKysrDQo+PiAgwqAxIGZpbGUgY2hhbmdlZCwgOCBpbnNl
cnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bV9o
b3N0LmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oDQo+PiBpbmRleCBlMTI5MTZl
N2MyZmIuLmRjZGY4Y2MxNjM4OCAxMDA2NDQNCj4+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNt
L2t2bV9ob3N0LmgNCj4+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmgNCj4+
IEBAIC00MDIsNiArNDAyLDEyIEBAIHN0cnVjdCBrdm1fbW11IHsNCj4+ICDCoAl1NjQgcGRwdHJz
WzRdOyAvKiBwYWUgKi8NCj4+ICDCoH07DQo+PiAgIA0KPj4gK3N0cnVjdCBrdm1fdGxiX3Jhbmdl
IHsNCj4+ICsJdTY0IHN0YXJ0X2dmbjsNCj4+ICsJdTY0IGVuZF9nZm47DQo+IA0KPiBJTU8gdGhp
cyBzdHJ1Y3QgYW5kIGFsbCBmdW5jdGlvbnMgc2hvdWxkIHBhc3MgYXJvdW5kIHRoZSBudW1iZXIg
b2YgcGFnZXMNCj4gaW5zdGVhZCBvZiBlbmRfZ2ZuIHRvIGF2b2lkIGNvbmZ1c2lvbiBhcyB0byB3
aGV0aGVyIGVuZF9nZm4gaXMgaW5jbHVzaXZlDQo+IG9yIGV4bHVzaXZlLg0KDQpUaGF0J3MgZ29v
ZCBzdWdnZXN0aW9uLiBUaGFua3MuDQoNCj4gDQo+PiArCXN0cnVjdCBsaXN0X2hlYWQgKmZsdXNo
X2xpc3Q7DQo+PiArfTsNCj4+ICsNCj4+ICDCoGVudW0gcG1jX3R5cGUgew0KPj4gIMKgCUtWTV9Q
TUNfR1AgPSAwLA0KPj4gIMKgCUtWTV9QTUNfRklYRUQsDQo+PiBAQCAtOTkxLDYgKzk5Nyw4IEBA
IHN0cnVjdCBrdm1feDg2X29wcyB7DQo+PiAgIA0KPj4gIMKgCXZvaWQgKCp0bGJfZmx1c2gpKHN0
cnVjdCBrdm1fdmNwdSAqdmNwdSwgYm9vbCBpbnZhbGlkYXRlX2dwYSk7DQo+PiAgwqAJaW50wqDC
oCgqdGxiX3JlbW90ZV9mbHVzaCkoc3RydWN0IGt2bSAqa3ZtKTsNCj4+ICsJaW50wqDCoCgqdGxi
X3JlbW90ZV9mbHVzaF93aXRoX3JhbmdlKShzdHJ1Y3Qga3ZtICprdm0sDQo+PiArCQkJc3RydWN0
IGt2bV90bGJfcmFuZ2UgKnJhbmdlKTsNCj4+ICAgDQo+PiAgwqAJLyoNCj4+ICDCoAnCoCogRmx1
c2ggYW55IFRMQiBlbnRyaWVzIGFzc29jaWF0ZWQgd2l0aCB0aGUgZ2l2ZW4gR1ZBLg==
