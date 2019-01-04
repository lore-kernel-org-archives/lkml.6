Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E479DC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8996121872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Gd7WvbjL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbfADUFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 15:05:16 -0500
Received: from mail-eopbgr690112.outbound.protection.outlook.com ([40.107.69.112]:37521
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725930AbfADUFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 15:05:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ov4QoRJ+5fC76+F5V68rtx0wk+4ImJZAeeG4nAilmb4=;
 b=Gd7WvbjL2snpJrE43vzB86LlRbkyiJO7o/OE1pUEJp5O0oErVa/iZPAzmeTUtrr6oz1wLarKtUe8Bsv+RdssBYeGZKD4v1hjOghTGbFr+mUAGw8lpDA8MoNAehmOWCgc4bS9rA5ntOl770N+YRPlKWnf7sgMDGlH27kIRAzaPtA=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0165.namprd21.prod.outlook.com (10.173.192.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.1; Fri, 4 Jan 2019 20:05:10 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::704f:14f3:5d34:cf6]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::704f:14f3:5d34:cf6%3]) with mapi id 15.20.1516.000; Fri, 4 Jan 2019
 20:05:10 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        KY Srinivasan <kys@microsoft.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "catalin.marinas@armm.com" <catalin.marinas@armm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH 2/4] arm64: hyperv: Add support for Hyper-V as a
 hypervisor
Thread-Topic: [PATCH 2/4] arm64: hyperv: Add support for Hyper-V as a
 hypervisor
Thread-Index: AQHUghEnmAHBKrXmHkmtduFUzC9VJqVzciwAgAb8qWCAAjmMgIAX6uiA
Date:   Fri, 4 Jan 2019 20:05:10 +0000
Message-ID: <CY4PR21MB077301ECE13325F8C75EE941D78E0@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20181122030914.16274-1-kys@linuxonhyperv.com>
 <20181122031059.16338-1-kys@linuxonhyperv.com>
 <20181122031059.16338-2-kys@linuxonhyperv.com>
 <39e47e32-2738-e39a-4ddb-9d27d2513beb@arm.com>
 <CY4PR21MB0773002BFD385052A830A979D7A70@CY4PR21MB0773.namprd21.prod.outlook.com>
 <e0374a07-809c-cabd-2eb6-e6b5ad84742e@arm.com>
In-Reply-To: <e0374a07-809c-cabd-2eb6-e6b5ad84742e@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-01-04T20:05:07.5544968Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2605:e000:ccc4:8800:dcbf:42e7:5afa:6bf3]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0165;6:8IjsLOousmngWUs1TS0UulcIeu0fYTqCfPllx6G1OPURLHoOxkDUmUHSxpHCp2DaojkQ5zg/sAzx8gUKGl+HbwZ8n/0kM8jg0q/Nl4ATVl8gmBtbQIjSX7POduLwbNPBRzoZdJDhUs84m4/pNlEMjezxHmURfvBZMspfLgNtlkaU64KIHL97/I8SSHtSqqVS6//Sr+0WnIDLSJA1cxe8AOQILqu0F91vdTfS0IIc0uW00T8fPPakWfQSmNx2q701syHE0JAsJ/vwinpdOEmdYugKjYi5nwtc6HlcHtr1SVPqKghYa2V0O1tkImDiRNk0tM5IHi8jgGlzG7ACFUeJ9Fm0AIq29wfIh0thoSm1Vw1tL2zpAltMgZsLaflbkKwF/MSov9i3tMnIoERm8Voxvi9z3gl3GtEMDuLmzngIjP7Y4ioFLs/88xHhFyFJhSaRdPsTAKHRL3hsbrOHOwpfrA==;5:hLxAL2FkWQFpLz0BoWgInyXo2RM9DT+xhfyS1OTIxNOfROnUMm+MbRQzD2mJQd6tVKLNn0AyCbHwvj8AsmjkiR/Ef+Apj/d55E9BVsp0mFBkUhns4OMZcMLLzYCNN6fJpMIroVdaOt5wbW8Ffm1mNJfZ6tIIUnpCQURCoUxbUEpGwSKLlWZwDQ3ARAoonv1PFayyg/v1IwAFrAnfYFFNbw==;7:stvFVhqyjb1j1YJjScvcFcrY+MFmWXIeS93lMGCWQHlEj4sz4NQgInPKgJ57LiDa/qnENeuS4qmWwDcMLlI8KIBms05hNUECMmqWsfv9yRLlrA8JYWXH38s/Z2o4SmhWV/71CdCWszNSmchQW/6Ahw==
x-ms-office365-filtering-correlation-id: 40cdba9f-ed53-4b86-7bdc-08d6727fee8c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0165;
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-ms-exchange-purlcount: -3
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB016506CCC02E9F75FD5212B8D78E0@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231475)(944501520)(2018427008)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:CY4PR21MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0165;
x-forefront-prvs: 0907F58A24
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(366004)(136003)(376002)(396003)(199004)(189003)(186003)(486006)(53936002)(97736004)(68736007)(22452003)(76176011)(2201001)(74316002)(25786009)(7416002)(86362001)(305945005)(7736002)(5660300001)(86612001)(81166006)(8676002)(81156014)(256004)(8936002)(478600001)(9686003)(7696005)(71190400001)(8990500004)(71200400001)(10090500001)(55016002)(2906002)(99286004)(1511001)(93886005)(6116002)(229853002)(110136005)(46003)(6346003)(316002)(105586002)(10290500003)(33656002)(106356001)(6436002)(2501003)(102836004)(446003)(14454004)(6246003)(476003)(6506007)(11346002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0165;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Tpoew6110lno1p09bRQ4LaJCI2e9xNhr1iixlhdRSbkKOi0bim/6qd8wA7ZUUKj8ViMIU0TcgZEiNy3ux1GX2NYI9YJQs9cqF+OiX1+6zH9aWJWaMamheD3CuQnJCDdqXCRBlKytmmBXDoBUjIjZmxfio90ZCD/ha/Qa1BgEN690BVHt2E0GPxWTJHKfeiFOiTO8hF9EbqrVA74iay3+3htQRFGfmFoHXpwtHymCF6uWK5uxNitGYmush4E1fVKuqJarETaAlZ9fPHKbNZhvKkjlAzQd6TWYMIrkARQJNUqGu+e4ULl0nS/mZQy6WSiX
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40cdba9f-ed53-4b86-7bdc-08d6727fee8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2019 20:05:10.5889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWFyYyBaeW5naWVyIDxtYXJjLnp5bmdpZXJAYXJtLmNvbT4gU2VudDogVGh1cnNkYXks
IERlY2VtYmVyIDEzLCAyMDE4IDM6MjMgQU0NCg0KPiA+PiBBcyBXaWxsIHNhaWQsIHRoaXMgaXNu
J3QgYSB2aWFibGUgb3B0aW9uLiBQbGVhc2UgZm9sbG93IFNNQ0NDIDEuMS4NCj4gPg0KPiA+IEkn
bGwgaGF2ZSB0byBzdGFydCBhIGNvbnZlcnNhdGlvbiB3aXRoIHRoZSBIeXBlci1WIHRlYW0gYWJv
dXQgdGhpcy4NCj4gPiBJIGRvbid0IGtub3cgd2h5IHRoZXkgY2hvc2UgdG8gdXNlIEhWQyAjMSBv
ciB0aGlzIHJlZ2lzdGVyIHNjaGVtZQ0KPiA+IGZvciBvdXRwdXQgdmFsdWVzLiAgSXQgbWF5IGJl
IHRvdWdoIHRvIGNoYW5nZSBhdCB0aGlzIHBvaW50IGJlY2F1c2UNCj4gPiB0aGVyZSBhcmUgV2lu
ZG93cyBndWVzdHMgb24gSHlwZXItViBmb3IgQVJNNjQgdGhhdCBhcmUgYWxyZWFkeQ0KPiA+IHVz
aW5nIHRoaXMgYXBwcm9hY2guDQo+IA0KPiBJIGFwcHJlY2lhdGUgeW91IGFscmVhZHkgaGF2ZSBz
dHVmZiBpbiB0aGUgd2lsZCwgYnV0IHRoZXJlIGlzIGRlZmluaXRlbHkNCj4gYSBjYXNlIHRvIGJl
IG1hZGUgZm9yIHN1cHBvcnRpbmcgYXJjaGl0ZWN0dXJhbGx5IHNwZWNpZmllZCBtZWNoYW5pc21z
IGluDQo+IGEgaHlwZXJ2aXNvciwgYW5kIFNNQ0NDIGlzIGRlZmluaXRlbHkgcGFydCBvZiBpdCAo
SSdtIGNlcnRhaW5seSBjdXJpb3VzDQo+IG9mIGhvdyB5b3Ugc3VwcG9ydCB0aGUgU3BlY3RyZSBt
aXRpZ2F0aW9uIG90aGVyd2lzZSkuDQo+DQoNClRoZSBIeXBlci1WIGd1eXMgSSBuZWVkIHRvIGRp
c2N1c3MgdGhpcyB3aXRoIGFyZSBub3QgYmFjayBmcm9tIHRoZQ0KaG9saWRheXMgdW50aWwgSmFu
dWFyeSA3dGguICBJJ2xsIGZvbGxvdyB1cCBvbiB0aGlzIHRocmVhZCBvbmNlIEkndmUNCmhhZCB0
aGF0IGNvbnZlcnNhdGlvbi4NCg0KPiA+Pj4gK3N0YXRpYyBpbnQgaHZfY3B1X2luaXQodW5zaWdu
ZWQgaW50IGNwdSkNCj4gPj4+ICt7DQo+ID4+PiArCXU2NCBtc3JfdnBfaW5kZXg7DQo+ID4+PiAr
DQo+ID4+PiArCWh2X2dldF92cF9pbmRleChtc3JfdnBfaW5kZXgpOw0KPiA+Pj4gKw0KPiA+Pj4g
Kwlodl92cF9pbmRleFtzbXBfcHJvY2Vzc29yX2lkKCldID0gbXNyX3ZwX2luZGV4Ow0KPiA+Pj4g
Kw0KPiA+Pj4gKwlpZiAobXNyX3ZwX2luZGV4ID4gaHZfbWF4X3ZwX2luZGV4KQ0KPiA+Pj4gKwkJ
aHZfbWF4X3ZwX2luZGV4ID0gbXNyX3ZwX2luZGV4Ow0KPiA+Pj4gKw0KPiA+Pj4gKwlyZXR1cm4g
MDsNCj4gPj4+ICt9DQo+ID4+DQo+ID4+IElzIHRoYXQgc29tZSBuZXcgd2F5IHRvIGRlc2NyaWJl
IGEgQ1BVIHRvcG9sb2d5PyBJZiBzbywgd2h5IGlzbid0IHRoYXQNCj4gPj4gZXhwb3NlZCB2aWEg
dGhlIEFDUEkgdGFibGVzIHRoYXQgdGhlIGtlcm5lbCBhbHJlYWR5IHBhcnNlcz8NCj4gPg0KPiA+
IEh5cGVyLVYncyBoeXBlcmNhbGwgaW50ZXJmYWNlIHVzZXMgdkNQVSBpZGVudGlmaWVycyB0aGF0
IGFyZSBub3QNCj4gPiBndWFyYW50ZWVkIHRvIGJlIGNvbnNlY3V0aXZlIGludGVnZXJzIG9yIHRv
IG1hdGNoIHdoYXQgQUNQSSBzaG93cy4NCj4gPiBObyB0b3BvbG9neSBpbmZvcm1hdGlvbiBpcyBp
bXBsaWVkIC0tIGl0J3MganVzdCB1bmlxdWUgaWRlbnRpZmllcnMuICBUaGUNCj4gPiBodl92cF9p
bmRleCBhcnJheSBwcm92aWRlcyBlYXN5IG1hcHBpbmcgZnJvbSBMaW51eCdzIGNvbnNlY3V0aXZl
DQo+ID4gaW50ZWdlciBJRHMgZm9yIENQVXMgd2hlbiBuZWVkZWQgdG8gY29uc3RydWN0IGh5cGVy
Y2FsbCBhcmd1bWVudHMuDQo+IA0KPiBUaGF0J3MgZXh0cmVtZWx5IG9kZC4gVGhlIGh5cGVydmlz
b3Igb2J2aW91c2x5IGtub3dzIHdoaWNoIHZDUFUgaXMgZG9pbmcNCj4gYSBoeXBlcmNhbGwsIGFu
ZCBpZiByZWZlcmVuY2luZyBhbm90aGVyIHZDUFUsIHRoZSB2aXJ0dWFsaXplZCBNUElEUl9FTDEN
Cj4gdmFsdWUgc2hvdWxkIGJlIHVzZWQuIEkgZG9uJ3QgdGhpbmsgZGV2aWF0aW5nIGZyb20gdGhl
IGFyY2hpdGVjdHVyZSBpcyBhDQo+IGdvb2QgaWRlYSAoYnV0IEkgYXBwcmVjaWF0ZSB0aGlzIGlz
IG5vbmUgb2YgeW91ciBkb2luZykuIEZvbGxvd2luZyB0aGUNCj4gYXJjaGl0ZWN0dXJlIHdvdWxk
IGFsbG93IHRoaXMgY29kZSB0byBkaXJlY3RseSB1c2UgdGhlIGNwdV9sb2dpY2FsX21hcA0KPiBp
bmZyYXN0cnVjdHVyZSB3ZSBhbHJlYWR5IGhhdmUuDQoNCkkgc2VlIHdoYXQgeW91IGFyZSBnZXR0
aW5nIGF0LiAgSG93ZXZlciwgc29tZSBIeXBlci1WIGh5cGVyY2FsbHMgYWxsb3cNCnNwZWNpZnlp
bmcgYXJiaXRyYXJ5IHNldHMgb2YgdkNQVXMuICBUaGVzZSBoeXBlcmNhbGxzIGFyZSB1c2VkIHRv
IGRlZmluZQ0KdGFyZ2V0IHByb2Nlc3NvcnMgaW4gdGhlIHZpcnR1YWwgUENJIGNvZGUgKHdoaWNo
IEkgaGF2ZSBub3QgeWV0IGJyb3VnaHQgb3Zlcg0KdG8gQVJNNjQpIGFuZCBpbiBlbmxpZ2h0ZW5t
ZW50cyBmb3IgSVBJcyBhbmQgVExCIGZsdXNoZXMgKHVzZWQgYnkNCldpbmRvd3MgZ3Vlc3RzIGFu
ZCBMaW51eCBndWVzdHMgb24geDg2LCBidXQgbm90IHlldCBicm91Z2h0IG92ZXIgdG8gTGludXgN
CkFSTTY0LCBpZiB0aGV5IGV2ZXIgd2lsbCBiZSkuICBUaGVzZSBoeXBlcmNhbGxzIHRha2UgYml0
bWFwcyBhcyBhcmd1bWVudHMsDQpzaW1pbGFyIHRvIGEgTGludXggY3B1bWFzaywgYXMgZGVmaW5l
ZCBpbiBTZWN0aW9ucyA3LjguNy4zIHRocnUgNy44LjcuNSBpbiB0aGUNCkh5cGVyLVYgVExGUy4g
IFNvIEh5cGVyLVYgZGVmaW5lcyBpdHMgb3duIFZQIGluZGV4IHRoYXQgaXMgYWtpbiB0byB0aGUg
aW5kZXggDQppbnRvIHRoZSBjcHVfbG9naWNhbF9tYXAsIHRob3VnaCBpdCBtYXkgbm90IGJlIHRo
ZSBzYW1lIG1hcHBpbmcuICBNeSBlYXJsaWVyDQpjb21tZW50cyBtYXkgaGF2ZSBiZWVuIG1pc2xl
YWRpbmcgLS0gdGhlIEh5cGVyLVYgVlAgaW5kZXggaXMgYW4gaW50ZWdlcg0KcmFuZ2luZyBmcm9t
IDAgdGhydSAoIyB2Q1BVcyAtIDEpLg0KDQpXaXRoIHRoZXNlIHJlcXVpcmVtZW50cywgSHlwZXIt
ViBkZWZpbmluZyBpdHMgb3duIFZQIGluZGV4IHNlZW1zIGxpa2UNCmEgcmVhc29uYWJsZSB0aGlu
ZyB0byBkby4gIEFuZCBzaW5jZSBIeXBlci1WIHByb3ZpZGVzIHRoZSBzYW1lIGh5cGVyY2FsbA0K
aW50ZXJmYWNlcyBmb3IgYm90aCB4ODYgYW5kIEFSTTY0IGltcGxlbWVudGF0aW9ucywgYW5kIGZv
ciBXaW5kb3dzDQpndWVzdHMsIHRoZXJlJ3Mgbm90IG11Y2ggY2hvaWNlIGJ1dCB0byB1c2UgdGhl
IEh5cGVyLVYgVlAgaW5kZXggYXMgc3BlY2lmaWVkLg0KDQpNaWNoYWVsDQoNCg0K
