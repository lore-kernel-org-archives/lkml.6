Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3E8C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F512150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="lEjuhiq/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F512150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732886AbeISW5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:57:03 -0400
Received: from mail-eopbgr680110.outbound.protection.outlook.com ([40.107.68.110]:56448
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731056AbeISW5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 18:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9spX1/+9qOSmNN1Xc45vWUJv5O+oMxN3OjZ+9SAv5U=;
 b=lEjuhiq/YcRNja30OiZRk4p5Lp0eknQ6MKQXWSxb3QfMZ2eniOSAgeec3ZMHh9lQrfe75U7oQ89pd4//K4wymkookUdJgmqG1OJ6Fc551pmFNO9yHpBhgs78XYN4Q40KYF5M3tyG/HDlcnQBRosJu/S1/DHhaLfqhGpM0B3QIF4=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0742.namprd21.prod.outlook.com (10.173.189.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Wed, 19 Sep 2018 17:00:01 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::d1f6:46cd:d8b4:880c]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::d1f6:46cd:d8b4:880c%5]) with mapi id 15.20.1185.003; Wed, 19 Sep 2018
 17:00:01 +0000
From:   "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To:     Tianyu Lan <Tianyu.Lan@microsoft.com>
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
        vkuznets <vkuznets@redhat.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>
Subject: RE: [PATCH V2 10/13] x86/hyper-v: Add HvFlushGuestAddressList
 hypercall support
Thread-Topic: [PATCH V2 10/13] x86/hyper-v: Add HvFlushGuestAddressList
 hypercall support
Thread-Index: AQHUTv5iRUCg6dTqP06Sa1KiD+PiLKT3yE+A
Date:   Wed, 19 Sep 2018 17:00:01 +0000
Message-ID: <CY4PR21MB07737E82C42696BA39A5DA31DC1C0@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20180918031754.113013-1-Tianyu.Lan@microsoft.com>
 <20180918031754.113013-11-Tianyu.Lan@microsoft.com>
In-Reply-To: <20180918031754.113013-11-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-09-19T16:59:58.3481369Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0742;6:2mddHqQS5mjLPxWI3Z87JdH7WcYnl1D6tYTy0rOsLgQ/pb3btrs1b9zyUenQnZ8mZcpYlc83Bwd7Np++byzBHCpQTxO9YflfzGMptIPn9q4UoWvaaByAh9qToD9CNxBCMfcZ3EC73EJfbZkRS7cHsYoc0yoTqqkoUa7n9Onphx7IVemLV3JPiElnR0Buugd3ytss5BdZpxlmnd2nvB4K582qQScCzXvlIfJ850dAM7OKZcOIko0fBOT0uXO1BnRe+EpK1pffUjFnCMI9rOe6+SnWtMscyr5272/KE9PNdFaWfLRYxhzKu92vennzQhi5NUPdkpY25/X093o8apVBYIF85vMBkMs96/Gg83w/074vRpP8mICCAo6NTWrFNunYEektcq/NB4X2CI+TwdDJs9TPONL3+Gn5jYLDdlR+iP+u8LSbAwNyulXBKRMsAvtot5tXyxjmVt2WILD3PzyGnQ==;5:aNH9B+ZxOaI+GarJ++q7q78Y/mGb9h05wFT+zIADaDPX4se5BNLZsMINfBktZvj8cKIjketOC7GBIBc/9qyczQQUs1ngqi0Fw/1ma/zomXNFxNR9mI9e90FUIsyfvhUJorqbx3rsX8NmP6LMQ3odkpFCt2TQGaEsBWWIpC3iS1Y=;7:mknDkDCCaMwv3fyWniNXB+9ZbjVsuz2oDaRK3wA8FEf/juSdWBgizbxCsQwBPgq28TpfMhdwY8omZ8BwHymAoXG+MakuqjEiw/2xWCdVQ4zSKQLqAlUyhhJ0sTS6Q3wmy+QbThxnNMq36tGZ9P4Xmag8wTqv8LOuLBJOjXuVpqVRVxNZpvULK/5DHfU+6FIlgeb/hVQSXwY0ImHIdES5OoSO+nJG1e7D5iYwSFJWX1TUPpnNudCBoUah6R9cOHr6
x-ms-office365-filtering-correlation-id: ded0ff8f-3cb3-4cd5-2a93-08d61e5156ba
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(2017052603328)(7193020);SRVR:CY4PR21MB0742;
x-ms-traffictypediagnostic: CY4PR21MB0742:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB07423D9FAEE3D1A9EBCD26A7DC1C0@CY4PR21MB0742.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0742;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0742;
x-forefront-prvs: 0800C0C167
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(6029001)(39860400002)(376002)(136003)(366004)(346002)(396003)(54094003)(199004)(189003)(22452003)(8936002)(68736007)(102836004)(3846002)(74316002)(6346003)(6246003)(8676002)(81156014)(81166006)(33656002)(10090500001)(8990500004)(11346002)(476003)(446003)(486006)(6506007)(305945005)(256004)(14454004)(14444005)(107886003)(7736002)(6116002)(25786009)(72206003)(4326008)(478600001)(7416002)(10290500003)(6862004)(26005)(1511001)(229853002)(53936002)(2900100001)(6436002)(66066001)(55016002)(105586002)(2906002)(106356001)(99286004)(54906003)(5660300001)(6636002)(316002)(76176011)(7696005)(575784001)(86612001)(86362001)(97736004)(5250100002)(9686003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0742;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com; 
x-microsoft-antispam-message-info: GpPx3IYoZTcwW3X8Ru2JdxRGt8Uo47F+kyFz2RhC6qzs6z94ZBw/NpiZRgbjk8Mg20jdzpcaL2wDHXXrq/8ern5YnPyKh6/+QCDOAAGehI79tYIXqMQDNhvFo2iqsqGly6aOHYyQE9Afx4VQw6kFH90HbPxvSx3zA7pg5X9bstagwHwuhugEf49TjsPEOAmCsXs4g4c9/t+eGsA1HEUfXaxXmlk3aVuXxTNJun1Xdt0/BmHo66WvcwQ8qQ1ZPObKixzew4iwjPCydO3pkYGKT5RQggm05cILZ/+aB68ZT0LUAnctU968YilfGzjMl4qr1sL8unijSMnVhwgfdDcowLUAeIhk7z2C0yXsAIdf3Mc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ded0ff8f-3cb3-4cd5-2a93-08d61e5156ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2018 17:00:01.3777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0742
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogVGlhbnl1IExhbiAgU2VudDogTW9uZGF5LCBTZXB0ZW1iZXIgMTcsIDIwMTggODoxOSBQ
TQ0KPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+DQo+ICAjaW5jbHVkZSA8YXNtL2h5cGVy
di10bGZzLmg+DQo+ICAjaW5jbHVkZSA8YXNtL21zaHlwZXJ2Lmg+DQo+ICAjaW5jbHVkZSA8YXNt
L3RsYmZsdXNoLmg+DQo+ICsjaW5jbHVkZSA8YXNtL2t2bV9ob3N0Lmg+DQoNCkhvcGVmdWxseSBh
c20va3ZtX2hvc3QuaCBkb2VzIG5vdCBuZWVkIHRvIGJlICNpbmNsdWRlZCwgZ2l2ZW4NCnRoZSBu
ZXcgY29kZSBzdHJ1Y3R1cmUuDQoNCj4gDQo+ICAjaW5jbHVkZSA8YXNtL3RyYWNlL2h5cGVydi5o
Pg0KPiANCj4gKy8qDQo+ICsgKiAgTUFYX0ZMVVNIX1BBR0VTID0gImFkZGl0aW9uYWxfcGFnZXMi
ICsgMS4gSXQncyBsaW1pdGVkDQo+ICsgKiAgYnkgdGhlIGJpdHdpZHRoIG9mICJhZGRpdGlvbmFs
X3BhZ2VzIiBpbiB1bmlvbiBodl9ncGFfcGFnZV9yYW5nZS4NCj4gKyAqLw0KPiArI2RlZmluZSBN
QVhfRkxVU0hfUEFHRVMgKDIwNDgpDQo+ICsNCj4gKy8qDQo+ICsgKiBBbGwgaW5wdXQgZmx1c2gg
cGFyYW1ldGVycyBhcmUgaW4gc2luZ2xlIHBhZ2UuIFRoZSBtYXggZmx1c2ggY291bnQNCj4gKyAq
IGlzIGVxdWFsIHdpdGggaG93IG1hbnkgZW50cmllcyBvZiB1bmlvbiBodl9ncGFfcGFnZV9yYW5n
ZSBjYW4gYmUNCj4gKyAqIHBvcHVsYXRlZCBpbiB0aGUgaW5wdXQgcGFyYW1ldGVyIHBhZ2UuIE1B
WF9GTFVTSF9SRVBfQ09VTlQNCj4gKyAqID0gKDQwOTYgLSAxNikgLyA4LiAo4oCcUGFnZSBTaXpl
4oCdIC0gIkFkZHJlc3MgU3BhY2UiIC0gIkZsYWdzIikgLw0KPiArICogIkdQQSBSYW5nZSIuDQo+
ICsgKi8NCj4gKyNkZWZpbmUgTUFYX0ZMVVNIX1JFUF9DT1VOVCAoNTEwKQ0KPiArDQoNCkkgd291
bGQgcmVjb21tZW5kIHB1dHRpbmcgdGhlIGFib3ZlIHR3byBkZWZpbml0aW9ucyBpbg0KaHlwZXJ2
LXRsZnMuaC4gIFRoZXkgYXJlIGRpcmVjdGx5IHRpZWQgdG8gdGhlIGRhdGEgc3RydWN0dXJlcyBk
ZWZpbmVkDQpieSBIeXBlci1WIGluIHRoZSBUTEZTLiAgUHV0IE1BWF9GTFVTSF9QQUdFUyBpbW1l
ZGlhdGVseSBhZnRlcg0KdGhlIGRlZmluaXRpb24gZm9yIGh2X2dwYV9wYWdlX3JhbmdlIHNvIHRo
YXQgdGhlIGRlcGVuZGVuY3kgaXMNCm9idmlvdXMuDQoNCkZvciBNQVhfRkxVU0hfUkVQX0NPVU5U
LCBjYW4geW91IGRvIHRoZSBjYWxjdWxhdGlvbiBpbg0KdGhlICNkZWZpbmUgcmF0aGVyIHRoYW4g
anVzdCBpbiB0aGUgY29tbWVudD8gIEFsdGVybmF0aXZlbHksIGRlZmluZQ0KdGhlIGdwYV9saXN0
W10gYXJyYXkgdG8gYmUgb2YgTUFYX0ZMVVNIX1JFUF9DT1VOVCBzaXplLCBhbmQgdGhlbg0KYWRk
IGEgY29tcGlsZSB0aW1lIGFzc2VydCB0aGF0IHRoZSBzaXplIG9mIHN0cnVjdA0KaHZfZ3Vlc3Rf
bWFwcGluZ19mbHVzaF9saXN0IGlzIGV4YWN0bHkgb25lIHBhZ2UgaW4gc2l6ZS4gICBJdCdzIGp1
c3QNCmEgZ29vZCB3YXkgdG8gdXNlIHRoZSBjb21waWxlciB0byBoZWxwIGNoZWNrIGZvciBtaXN0
YWtlcy4NCg0KQWxzbyBwcmVmaXggdGhlbSBib3RoIHdpdGggSFZfIHNpbmNlIHRoZXkgd2lsbCBi
ZSBtb3JlDQpnbG9iYWxseSB2aXNpYmxlIGFzIHBhcnQgb2YgaHlwZXJ2LXRsZnMuaC4NCg0KPiAg
aW50IGh5cGVydl9mbHVzaF9ndWVzdF9tYXBwaW5nKHU2NCBhcykNCj4gIHsNCj4gIAlzdHJ1Y3Qg
aHZfZ3Vlc3RfbWFwcGluZ19mbHVzaCAqKmZsdXNoX3BjcHU7DQo+IEBAIC01NCwzICs3MSw4OSBA
QCBpbnQgaHlwZXJ2X2ZsdXNoX2d1ZXN0X21hcHBpbmcodTY0IGFzKQ0KPiAgCXJldHVybiByZXQ7
DQo+ICB9DQo+ICBFWFBPUlRfU1lNQk9MX0dQTChoeXBlcnZfZmx1c2hfZ3Vlc3RfbWFwcGluZyk7
DQo+ICsNCj4gK3N0YXRpYyBpbnQgZmlsbF9mbHVzaF9saXN0KHVuaW9uIGh2X2dwYV9wYWdlX3Jh
bmdlIGdwYV9saXN0W10sDQo+ICsJCWludCBvZmZzZXQsIHU2NCBzdGFydF9nZm4sIHU2NCBwYWdl
cykNCj4gK3sNCj4gKwlpbnQgZ3BhX24gPSBvZmZzZXQ7DQo+ICsJdTY0IGN1ciA9IHN0YXJ0X2dm
bjsNCj4gKwl1NjQgYWRkaXRpb25hbF9wYWdlczsNCj4gKw0KPiArCWRvIHsNCj4gKwkJaWYgKGdw
YV9uID49IE1BWF9GTFVTSF9SRVBfQ09VTlQpIHsNCj4gKwkJCXByX3dhcm4oIlJlcXVlc3QgZXhj
ZWVkcyBIdkZsdXNoR3Vlc3RMaXN0IG1heCBmbHVzaCBjb3VudC4iKTsNCj4gKwkJCXJldHVybiAt
RU5PU1BDOw0KDQpJIHdvbmRlciBpZiB0aGUgd2FybmluZyBpcyByZWFsbHkgbmVlZGVkLiAgV2hl
biB0aGUgZXJyb3IgaXMgcmV0dXJuZWQgdXANCnRocm91Z2ggdGhlIGhpZ2hlciBsZXZlbHMgb2Yg
Y29kZSwgd29uJ3QgdGhlIGhpZ2hlciBsZXZlbHMganVzdCBmYWxsYmFjayB0bw0KdGhlIG5vbi1l
bmxpZ2h0ZW5lZCBmbHVzaCBjb2RlPyAgU28gbm90aGluZyBpcyBhY3R1YWxseSBnb2VzIHdyb25n
OyBpdCdzIGp1c3QNCnRoYXQgYSBzbG93ZXIgY29kZSBwYXRoIGdldHMgdGFrZW4uICBBIGNvbW1l
bnQgYWJvdXQgc3VjaCBleHBlY3RhdGlvbnMNCm1pZ2h0IGJlIGhlbHBmdWwuDQoNCj4gKwkJfQ0K
PiArDQo+ICsJCWlmIChwYWdlcyA+IE1BWF9GTFVTSF9QQUdFUykgew0KPiArCQkJYWRkaXRpb25h
bF9wYWdlcyA9IE1BWF9GTFVTSF9QQUdFUyAtIDE7DQo+ICsJCQlwYWdlcyAtPSBNQVhfRkxVU0hf
UEFHRVM7DQo+ICsJCX0gZWxzZSB7DQo+ICsJCQlhZGRpdGlvbmFsX3BhZ2VzID0gcGFnZXMgLSAx
Ow0KPiArCQkJcGFnZXMgPSAwOw0KPiArCQl9DQoNClRoZSBhYm92ZSBjb2RlIGlzIHJlYWxseSBk
b2luZzoNCg0KCQlhZGRpdGlvbmFsX3BhZ2VzID0gbWluKHBhZ2VzLCBNQVhfRkxVU0hfUEFHRVMp
IC0gMTsNCgkJcGFnZXMgLT0gYWRkaXRpb25hbF9wYWdlcyArIDE7DQoNCkFuZCB5b3UgbWlnaHQg
d2FudCB0byBtb3ZlIHRoZSBkZWNyZW1lbnQgb2YgJ3BhZ2VzJyBkb3duIHRvIHRoZQ0KYm90dG9t
IG9mIHRoZSBsb29wIHdoZXJlIHlvdSB1cGRhdGUgdGhlIG90aGVyIGxvb3AgdmFyaWFibGVzLg0K
DQo+ICsNCj4gKwkJZ3BhX2xpc3RbZ3BhX25dLnBhZ2UuYWRkaXRpb25hbF9wYWdlcyA9IGFkZGl0
aW9uYWxfcGFnZXM7DQo+ICsJCWdwYV9saXN0W2dwYV9uXS5wYWdlLmxhcmdlcGFnZSA9IGZhbHNl
Ow0KPiArCQlncGFfbGlzdFtncGFfbl0ucGFnZS5iYXNlcGZuID0gY3VyOw0KPiArDQo+ICsJCWN1
ciArPSBhZGRpdGlvbmFsX3BhZ2VzICsgMTsNCj4gKwkJZ3BhX24rKzsNCj4gKwl9IHdoaWxlIChw
YWdlcyA+IDApOw0KPiArDQo+ICsJcmV0dXJuIGdwYV9uOw0KPiArfQ0KPiArDQo+ICtpbnQgaHlw
ZXJ2X2ZsdXNoX2d1ZXN0X21hcHBpbmdfcmFuZ2UodTY0IGFzLCBzdHJ1Y3QgaHlwZXJ2X3RsYl9y
YW5nZSAqcmFuZ2UpDQo+ICt7DQo+ICsJc3RydWN0IGh2X2d1ZXN0X21hcHBpbmdfZmx1c2hfbGlz
dCAqKmZsdXNoX3BjcHU7DQo+ICsJc3RydWN0IGh2X2d1ZXN0X21hcHBpbmdfZmx1c2hfbGlzdCAq
Zmx1c2g7DQo+ICsJdTY0IHN0YXR1cyA9IDA7DQo+ICsJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4g
KwlpbnQgcmV0ID0gLUVOT1RTVVBQOw0KPiArCWludCBncGFfbiA9IDA7DQo+ICsNCj4gKwlpZiAo
IWh2X2h5cGVyY2FsbF9wZykNCj4gKwkJZ290byBmYXVsdDsNCj4gKw0KPiArCWxvY2FsX2lycV9z
YXZlKGZsYWdzKTsNCj4gKw0KPiArCWZsdXNoX3BjcHUgPSAoc3RydWN0IGh2X2d1ZXN0X21hcHBp
bmdfZmx1c2hfbGlzdCAqKikNCj4gKwkJdGhpc19jcHVfcHRyKGh5cGVydl9wY3B1X2lucHV0X2Fy
Zyk7DQo+ICsNCj4gKwlmbHVzaCA9ICpmbHVzaF9wY3B1Ow0KPiArCWlmICh1bmxpa2VseSghZmx1
c2gpKSB7DQo+ICsJCWxvY2FsX2lycV9yZXN0b3JlKGZsYWdzKTsNCj4gKwkJZ290byBmYXVsdDsN
Cj4gKwl9DQo+ICsNCj4gKwlmbHVzaC0+YWRkcmVzc19zcGFjZSA9IGFzOw0KPiArCWZsdXNoLT5m
bGFncyA9IDA7DQo+ICsNCj4gKwlpZiAoIXJhbmdlLT5mbHVzaF9saXN0KQ0KPiArCQlncGFfbiA9
IGZpbGxfZmx1c2hfbGlzdChmbHVzaC0+Z3BhX2xpc3QsIGdwYV9uLA0KPiArCQkJCXJhbmdlLT5z
dGFydF9nZm4sIHJhbmdlLT5wYWdlcyk7DQo+ICsJZWxzZSBpZiAocmFuZ2UtPnBhcnNlX2ZsdXNo
X2xpc3RfZnVuYykNCj4gKwkJZ3BhX24gPSByYW5nZS0+cGFyc2VfZmx1c2hfbGlzdF9mdW5jKGZs
dXNoLT5ncGFfbGlzdCwgZ3BhX24sDQo+ICsJCQkJcmFuZ2UtPmZsdXNoX2xpc3QsIGZpbGxfZmx1
c2hfbGlzdCk7DQo+ICsJZWxzZQ0KPiArCQlncGFfbiA9IC0xOw0KPiArDQo+ICsJaWYgKGdwYV9u
IDwgMCkgew0KPiArCQlsb2NhbF9pcnFfcmVzdG9yZShmbGFncyk7DQo+ICsJCWdvdG8gZmF1bHQ7
DQo+ICsJfQ0KPiArDQo+ICsJc3RhdHVzID0gaHZfZG9fcmVwX2h5cGVyY2FsbChIVkNBTExfRkxV
U0hfR1VFU1RfUEhZU0lDQUxfQUREUkVTU19MSVNULA0KPiArCQkJCSAgICAgZ3BhX24sIDAsIGZs
dXNoLCBOVUxMKTsNCj4gKw0KPiArCWxvY2FsX2lycV9yZXN0b3JlKGZsYWdzKTsNCj4gKw0KPiAr
CWlmICghKHN0YXR1cyAmIEhWX0hZUEVSQ0FMTF9SRVNVTFRfTUFTSykpDQo+ICsJCXJldCA9IDA7
DQo+ICsJZWxzZQ0KPiArCQlyZXQgPSBzdGF0dXM7DQo+ICtmYXVsdDoNCj4gKwlyZXR1cm4gcmV0
Ow0KPiArfQ0KPiArRVhQT1JUX1NZTUJPTF9HUEwoaHlwZXJ2X2ZsdXNoX2d1ZXN0X21hcHBpbmdf
cmFuZ2UpOw0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vaHlwZXJ2LXRsZnMu
aCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2h5cGVydi10bGZzLmgNCj4gaW5kZXggZTk3N2I2YjNh
NTM4Li41MTJmMjJiNDk5OTkgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2h5
cGVydi10bGZzLmgNCj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vaHlwZXJ2LXRsZnMuaA0K
PiBAQCAtMzUzLDYgKzM1Myw3IEBAIHN0cnVjdCBodl90c2NfZW11bGF0aW9uX3N0YXR1cyB7DQo+
ICAjZGVmaW5lIEhWQ0FMTF9QT1NUX01FU1NBR0UJCQkweDAwNWMNCj4gICNkZWZpbmUgSFZDQUxM
X1NJR05BTF9FVkVOVAkJCTB4MDA1ZA0KPiAgI2RlZmluZSBIVkNBTExfRkxVU0hfR1VFU1RfUEhZ
U0lDQUxfQUREUkVTU19TUEFDRSAweDAwYWYNCj4gKyNkZWZpbmUgSFZDQUxMX0ZMVVNIX0dVRVNU
X1BIWVNJQ0FMX0FERFJFU1NfTElTVCAweDAwYjANCj4gDQo+ICAjZGVmaW5lIEhWX1g2NF9NU1Jf
VlBfQVNTSVNUX1BBR0VfRU5BQkxFCTB4MDAwMDAwMDENCj4gICNkZWZpbmUgSFZfWDY0X01TUl9W
UF9BU1NJU1RfUEFHRV9BRERSRVNTX1NISUZUCTEyDQo+IEBAIC03NTAsNiArNzUxLDIyIEBAIHN0
cnVjdCBodl9ndWVzdF9tYXBwaW5nX2ZsdXNoIHsNCj4gIAl1NjQgZmxhZ3M7DQo+ICB9Ow0KPiAN
Cj4gKy8qIEh2Rmx1c2hHdWVzdFBoeXNpY2FsQWRkcmVzc0xpc3QgaHlwZXJjYWxsICovDQo+ICt1
bmlvbiBodl9ncGFfcGFnZV9yYW5nZSB7DQo+ICsJdTY0IGFkZHJlc3Nfc3BhY2U7DQo+ICsJc3Ry
dWN0IHsNCj4gKwkJdTY0IGFkZGl0aW9uYWxfcGFnZXM6MTE7DQo+ICsJCXU2NCBsYXJnZXBhZ2U6
MTsNCj4gKwkJdTY0IGJhc2VwZm46NTI7DQo+ICsJfSBwYWdlOw0KPiArfTsNCj4gKw0KPiArc3Ry
dWN0IGh2X2d1ZXN0X21hcHBpbmdfZmx1c2hfbGlzdCB7DQo+ICsJdTY0IGFkZHJlc3Nfc3BhY2U7
DQo+ICsJdTY0IGZsYWdzOw0KPiArCXVuaW9uIGh2X2dwYV9wYWdlX3JhbmdlIGdwYV9saXN0W107
DQo+ICt9Ow0KPiArDQo+ICAvKiBIdkZsdXNoVmlydHVhbEFkZHJlc3NTcGFjZSwgSHZGbHVzaFZp
cnR1YWxBZGRyZXNzTGlzdCBoeXBlcmNhbGxzICovDQo+ICBzdHJ1Y3QgaHZfdGxiX2ZsdXNoIHsN
Cj4gIAl1NjQgYWRkcmVzc19zcGFjZTsNCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUv
YXNtL21zaHlwZXJ2LmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc2h5cGVydi5oDQo+IGluZGV4
IGYzNzcwNDQ5N2Q4Zi4uMTlmNDlmYmNmOTRkIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9pbmNs
dWRlL2FzbS9tc2h5cGVydi5oDQo+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL21zaHlwZXJ2
LmgNCj4gQEAgLTIyLDYgKzIyLDE2IEBAIHN0cnVjdCBtc19oeXBlcnZfaW5mbyB7DQo+IA0KPiAg
ZXh0ZXJuIHN0cnVjdCBtc19oeXBlcnZfaW5mbyBtc19oeXBlcnY7DQo+IA0KPiArc3RydWN0IGh5
cGVydl90bGJfcmFuZ2Ugew0KPiArCXU2NCBzdGFydF9nZm47DQo+ICsJdTY0IHBhZ2VzOw0KPiAr
CXN0cnVjdCBsaXN0X2hlYWQgKmZsdXNoX2xpc3Q7DQo+ICsJaW50ICgqcGFyc2VfZmx1c2hfbGlz
dF9mdW5jKSh1bmlvbiBodl9ncGFfcGFnZV9yYW5nZSBncGFfbGlzdFtdLA0KPiArCQlpbnQgb2Zm
c2V0LCBzdHJ1Y3QgbGlzdF9oZWFkICpmbHVzaF9saXN0LA0KPiArCQlpbnQgKCpmaWxsX2ZsdXNo
X2xpc3QpKHVuaW9uIGh2X2dwYV9wYWdlX3JhbmdlIGdwYV9saXN0W10sDQo+ICsJCWludCBvZmZz
ZXQsIHU2NCBzdGFydF9nZm4sIHU2NCBlbmRfZ2ZuKSk7DQo+ICt9Ow0KPiArDQo+ICAvKg0KPiAg
ICogR2VuZXJhdGUgdGhlIGd1ZXN0IElELg0KPiAgICovDQo+IEBAIC0zNDgsNiArMzU4LDcgQEAg
dm9pZCBzZXRfaHZfdHNjY2hhbmdlX2NiKHZvaWQgKCpjYikodm9pZCkpOw0KPiAgdm9pZCBjbGVh
cl9odl90c2NjaGFuZ2VfY2Iodm9pZCk7DQo+ICB2b2lkIGh5cGVydl9zdG9wX3RzY19lbXVsYXRp
b24odm9pZCk7DQo+ICBpbnQgaHlwZXJ2X2ZsdXNoX2d1ZXN0X21hcHBpbmcodTY0IGFzKTsNCj4g
K2ludCBoeXBlcnZfZmx1c2hfZ3Vlc3RfbWFwcGluZ19yYW5nZSh1NjQgYXMsIHN0cnVjdCBoeXBl
cnZfdGxiX3JhbmdlICpyYW5nZSk7DQo+IA0KPiAgI2lmZGVmIENPTkZJR19YODZfNjQNCj4gIHZv
aWQgaHZfYXBpY19pbml0KHZvaWQpOw0KPiBAQCAtMzY4LDYgKzM3OSwxMSBAQCBzdGF0aWMgaW5s
aW5lIHN0cnVjdCBodl92cF9hc3Npc3RfcGFnZQ0KPiAqaHZfZ2V0X3ZwX2Fzc2lzdF9wYWdlKHVu
c2lnbmVkIGludCBjcHUpDQo+ICAJcmV0dXJuIE5VTEw7DQo+ICB9DQo+ICBzdGF0aWMgaW5saW5l
IGludCBoeXBlcnZfZmx1c2hfZ3Vlc3RfbWFwcGluZyh1NjQgYXMpIHsgcmV0dXJuIC0xOyB9DQo+
ICtzdGF0aWMgaW5saW5lIGludCBoeXBlcnZfZmx1c2hfZ3Vlc3RfbWFwcGluZ19yYW5nZSh1NjQg
YXMsDQo+ICsJCXN0cnVjdCBoeXBlcnZfdGxiX3JhbmdlICpyYW5nZSkNCj4gK3sNCj4gKwlyZXR1
cm4gLTE7DQo+ICt9DQo+ICAjZW5kaWYgLyogQ09ORklHX0hZUEVSViAqLw0KPiANCj4gICNpZmRl
ZiBDT05GSUdfSFlQRVJWX1RTQ1BBR0UNCj4gLS0NCj4gMi4xNC40DQo=
