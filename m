Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C72C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 06:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3479320BEC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 06:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="M8Xc2cXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3479320BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbeGKGED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 02:04:03 -0400
Received: from mail-sg2apc01on0114.outbound.protection.outlook.com ([104.47.125.114]:23734
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726294AbeGKGED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 02:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJWR7AjZzywO//bDbEvlnWwVdY5mazb2ar0FOrdkAnI=;
 b=M8Xc2cXJ92kOFlVEbbUCxklMFx8HQzGJpbAIwtK+EihRWx0Kq44r3wH8K7UqtHLXCHyccSgVw9nz4Zu+Eg/cPhveoLxdLHEd90HpVyj1kJe237+UGfQMZrfDIwC1mm65WW4EIXabvV+Fn+YnJaWA2wRXIhv8Yn2iXL6DharldQc=
Received: from SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM (10.170.136.145) by
 SG2P15301MB0013.APCP153.PROD.OUTLOOK.COM (10.170.135.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Wed, 11 Jul 2018 06:01:17 +0000
Received: from SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM
 ([fe80::f916:a637:8730:be25]) by SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM
 ([fe80::f916:a637:8730:be25%4]) with mapi id 15.20.0952.017; Wed, 11 Jul 2018
 06:01:17 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
To:     "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
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
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: Re: [PATCH V2 1/5] X86/Hyper-V: Add flush
 HvFlushGuestPhysicalAddressSpace hypercall support
Thread-Topic: [PATCH V2 1/5] X86/Hyper-V: Add flush
 HvFlushGuestPhysicalAddressSpace hypercall support
Thread-Index: AQHUF2OTueZcpG5JbkW4yjhT+Jne3aSI+10AgACO8wA=
Date:   Wed, 11 Jul 2018 06:01:16 +0000
Message-ID: <c41ce53f-cf6a-2b0e-4a9c-da01839094c1@microsoft.com>
References: <20180709090218.15342-1-Tianyu.Lan@microsoft.com>
 <20180709090218.15342-2-Tianyu.Lan@microsoft.com>
 <SN6PR2101MB11202EAE0D5C623EC0CF8273DC5B0@SN6PR2101MB1120.namprd21.prod.outlook.com>
In-Reply-To: <SN6PR2101MB11202EAE0D5C623EC0CF8273DC5B0@SN6PR2101MB1120.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SG2P15301MB0013;7:kAusRvDgpiX3l3dwiLRpE5j2ySC8f05dhu+t5KQcm3wf+lUnyhvIv00vPUzvSTm0rsVwdJNu2HN8KD30+xwGBcO/iarkICrDYpLbwcSSxq+2VMSh1LQbseeFZ8BD5U0xLjECo7pWRUY23y6H24VGY+66lT70E9QAaM1+iwOdKhhgYNvJ+BlgLYeptuogI2GWJycionHOYtmfWh84GRpyHuB6c5TjXfWMbC6EQitIp9erFVLAFkhPznmOSvKJhxak
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8cd4e3c6-6cb2-451e-bb86-08d5e6f3b798
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(48565401081)(5600053)(711020)(2017052603328)(7193020);SRVR:SG2P15301MB0013;
x-ms-traffictypediagnostic: SG2P15301MB0013:
x-microsoft-antispam-prvs: <SG2P15301MB0013BF6F71C538A2C5DC3DE6925A0@SG2P15301MB0013.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SG2P15301MB0013;BCL:0;PCL:0;RULEID:;SRVR:SG2P15301MB0013;
x-forefront-prvs: 0730093765
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6029001)(376002)(366004)(396003)(39860400002)(346002)(136003)(199004)(189003)(5250100002)(31696002)(5660300001)(1511001)(106356001)(25786009)(54906003)(110136005)(97736004)(316002)(53936002)(22452003)(68736007)(86612001)(446003)(6246003)(86362001)(14454004)(72206003)(10290500003)(36756003)(4326008)(7416002)(478600001)(31686004)(105586002)(81156014)(6436002)(14444005)(8676002)(81166006)(6512007)(8936002)(3846002)(6116002)(229853002)(2906002)(10090500001)(99286004)(2900100001)(76176011)(85306007)(2616005)(476003)(6486002)(11346002)(6506007)(256004)(305945005)(102836004)(53546011)(26005)(486006)(66066001)(7736002)(49343001)(213903007);DIR:OUT;SFP:1102;SCL:1;SRVR:SG2P15301MB0013;H:SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GyUiZ1wWMEhMCuXFU4pOuwJcmK7LGwtqU9/Drf8VHqmWYsOJkIY3mPXMZUc8NVTROeXzpYBJZBqDjYwS1C2aS/6X8X7E8BKKZA9QStAxteq+vJ85kLq+QV0wwZxqBuhDZGfPjdpOgxwhXb5a3cM8h2QVk1++c7W8LBbjRhNN1QsyiigkuJ93lKaazVd15FQ60VJr8fApM/CfSSpdyplDU0r+RFnIUNwjqT4iyQLTQQQGpOamMs+6LECupp/+Tb9YiGwfeH9XGw4Jr7JCYICPkLZ+8WWCrdMncs77+hPnUvElzleTdIEB0Ji+Oo0Oa4RLtREtKYOHDdvUkC4qBQylvTfGdzNotKrg1VWCWyqL+lc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BEDD0C1FA27F774CACEEA0FAAAC9D82C@APCP153.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd4e3c6-6cb2-451e-bb86-08d5e6f3b798
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2018 06:01:16.9020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0013
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWljaGFlbDoNCglUaGFua3MgZm9yIHlvdXIgcmV2aWV3Lg0KDQpPbiA3LzExLzIwMTggNToy
OSBBTSwgTWljaGFlbCBLZWxsZXkgKEVPU0cpIHdyb3RlOg0KPiBGcm9tOiBUaWFueXUgTGFuIDxU
aWFueXUuTGFuQG1pY3Jvc29mdC5jb20+IE1vbmRheSwgSnVseSA5LCAyMDE4IDI6MDMgQU0NCj4+
IEh5cGVyLVYgc3VwcG9ydHMgYSBwdiBoeXBlcmNhbGwgSHZGbHVzaEd1ZXN0UGh5c2ljYWxBZGRy
ZXNzU3BhY2UgdG8NCj4+IGZsdXNoIG5lc3RlZCBWTSBhZGRyZXNzIHNwYWNlIG1hcHBpbmcgaW4g
bDEgaHlwZXJ2aXNvciBhbmQgaXQncyB0bw0KPj4gcmVkdWNlIG92ZXJoZWFkIG9mIGZsdXNoaW5n
IGVwdCB0bGIgYW1vbmcgdmNwdXMuIFRoaXMgcGF0Y2ggaXMgdG8NCj4+IGltcGxlbWVudCBpdC4N
Cj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBMYW4gVGlhbnl1IDxUaWFueXUuTGFuQG1pY3Jvc29mdC5j
b20+DQo+PiAtLS0NCj4+ICAgYXJjaC94ODYvaHlwZXJ2L01ha2VmaWxlICAgICAgICAgICB8ICAy
ICstDQo+PiAgIGFyY2gveDg2L2h5cGVydi9uZXN0ZWQuYyAgICAgICAgICAgfCA2NCArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICBhcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9oeXBlcnYtdGxmcy5oIHwgIDggKysrKysNCj4+ICAgYXJjaC94ODYvaW5jbHVkZS9hc20vbXNo
eXBlcnYuaCAgICB8ICAyICsrDQo+PiAgIDQgZmlsZXMgY2hhbmdlZCwgNzUgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC94ODYvaHlwZXJ2
L25lc3RlZC5jDQo+PiArI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+DQo+PiArI2luY2x1ZGUgPGFz
bS9oeXBlcnYtdGxmcy5oPg0KPj4gKyNpbmNsdWRlIDxhc20vbXNoeXBlcnYuaD4NCj4+ICsjaW5j
bHVkZSA8YXNtL3RsYmZsdXNoLmg+DQo+PiArDQo+PiAraW50IGh5cGVydl9mbHVzaF9ndWVzdF9t
YXBwaW5nKHU2NCBhcykNCj4+ICt7DQo+PiArCXN0cnVjdCBodl9ndWVzdF9tYXBwaW5nX2ZsdXNo
ICoqZmx1c2hfcGNwdTsNCj4+ICsJc3RydWN0IGh2X2d1ZXN0X21hcHBpbmdfZmx1c2ggKmZsdXNo
Ow0KPj4gKwl1NjQgc3RhdHVzOw0KPj4gKwl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPj4gKwlpbnQg
cmV0ID0gLUVGQVVMVDsNCj4+ICsNCj4+ICsJaWYgKCFodl9oeXBlcmNhbGxfcGcpDQo+PiArCQln
b3RvIGZhdWx0Ow0KPj4gKw0KPj4gKwlsb2NhbF9pcnFfc2F2ZShmbGFncyk7DQo+PiArDQo+PiAr
CWZsdXNoX3BjcHUgPSAoc3RydWN0IGh2X2d1ZXN0X21hcHBpbmdfZmx1c2ggKiopDQo+PiArCQl0
aGlzX2NwdV9wdHIoaHlwZXJ2X3BjcHVfaW5wdXRfYXJnKTsNCj4+ICsNCj4+ICsJZmx1c2ggPSAq
Zmx1c2hfcGNwdTsNCj4+ICsNCj4+ICsJaWYgKHVubGlrZWx5KCFmbHVzaCkpIHsNCj4+ICsJCWxv
Y2FsX2lycV9yZXN0b3JlKGZsYWdzKTsNCj4+ICsJCWdvdG8gZmF1bHQ7DQo+PiArCX0NCj4+ICsN
Cj4+ICsJZmx1c2gtPmFkZHJlc3Nfc3BhY2UgPSBhczsNCj4+ICsJZmx1c2gtPmZsYWdzID0gMDsN
Cj4+ICsNCj4+ICsJc3RhdHVzID0gaHZfZG9faHlwZXJjYWxsKEhWQ0FMTF9GTFVTSF9HVUVTVF9Q
SFlTSUNBTF9BRERSRVNTX1NQQUNFLA0KPj4gKwkJCQkgZmx1c2gsIE5VTEwpOw0KPiANCj4gRGlk
IHlvdSBjb25zaWRlciB1c2luZyBhICJmYXN0IiBoeXBlcmNhbGw/ICBVbmxlc3MgdGhlcmUncyBz
b21lIHJlYXNvbiBJJ20NCj4gbm90IGF3YXJlIG9mLCBhICJmYXN0IiBoeXBlcmNhbGwgd291bGQg
YmUgcGVyZmVjdCBoZXJlIGFzIHRoZXJlIGFyZSAxNiBieXRlcw0KPiBvZiBpbnB1dCBhbmQgbm8g
b3V0cHV0LiBWaXRhbHkgcmVjZW50bHkgYWRkZWQgaHZfZG9fZmFzdF9oeXBlcmNhbGwxNigpDQo+
IGluIHRoZSBsaW51eC1uZXh0IHRyZWUuIFNlZSBfX3NlbmRfaXBpX21hc2soKSBpbiBodl9hcGlj
LmMgaW4gbGludXgtbmV4dA0KPiBmb3IgYW4gZXhhbXBsZSBvZiB1c2FnZS4gIFdpdGggYSBmYXN0
IGh5cGVyY2FsbCwgeW91IGRvbid0IG5lZWQgdGhlIGNvZGUgZm9yDQo+IGdldHRpbmcgdGhlIHBl
ci1jcHUgaW5wdXQgYXJnIG9yIHRoZSBjb2RlIGZvciBsb2NhbCBpcnEgc2F2ZS9yZXN0b3JlLCBz
byB0aGUNCj4gY29kZSB0aGF0IGlzIGxlZnQgaXMgYSBsb3QgZmFzdGVyIGFuZCBzaW1wbGVyLg0K
PiANCj4gTWljaGFlbA0KPiANCg0KR29vZCBzdWdnZXN0aW9uLiBCdXQgdGhlICJmYXN0IiBoeXBl
cmNhbGwgc3RpbGwgaXMgbm90IGF2YWlsYWJsZSBpbiANCmt2bS1uZXh0IGJyYW5jaCBhbmQgaXQn
cyBpbiB0aGUgeDg2IHRpcCByZXBvLiBXZSBtYXkgcmV3b3JrIHRoaXMgd2l0aCANCiJmYXN0IiBo
eXBlcmNhbGwgaW4gdGhlIG5leHQga2VybmVsIGRldmVsb3BtZW50IGN5Y2xlIGlmIHRoaXMgcGF0
Y2hzZXQgDQppcyBhY2NlcHRlZCBpbiBmb3IgNC4xOS4NCg0KPj4gKwlsb2NhbF9pcnFfcmVzdG9y
ZShmbGFncyk7DQo+PiArDQo+PiArCWlmICghKHN0YXR1cyAmIEhWX0hZUEVSQ0FMTF9SRVNVTFRf
TUFTSykpDQo+PiArCQlyZXQgPSAwOw0KPj4gKw0KPj4gK2ZhdWx0Og0KPj4gKwlyZXR1cm4gcmV0
Ow0KPj4gK30NCj4+ICtFWFBPUlRfU1lNQk9MX0dQTChoeXBlcnZfZmx1c2hfZ3Vlc3RfbWFwcGlu
Zyk7
