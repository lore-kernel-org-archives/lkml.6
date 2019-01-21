Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8FAC31D64
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A6820880
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nRbMqtf3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbfAUHNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:13:42 -0500
Received: from mail-eopbgr820122.outbound.protection.outlook.com ([40.107.82.122]:19003
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728143AbfAUHNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:13:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQv7JthSMTjrqEZ1WlF5HyVOEVSCMeK8YzxLTv2G7dM=;
 b=nRbMqtf3ju2nC4Y7W9HJLNVTVb8XkYy6e9HYg4yW42H4eAb7+Pyd0kaFx1sRH0NpOWMrCELiQLx3PqywjPOreuLZ1U2hx1UJnwKFyH/IsMAbji0FyGtRaELAKyjl49z0HRq6hGIptc4d0dXVixhB5mS6XdTAV7ITMvSgQfI8Lzk=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.4; Mon, 21 Jan 2019 04:38:44 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::e596:e32f:3aa3:2461]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::e596:e32f:3aa3:2461%7]) with mapi id 15.20.1580.003; Mon, 21 Jan 2019
 04:38:44 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        KY Srinivasan <kys@microsoft.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
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
Thread-Index: AQHUghEnmAHBKrXmHkmtduFUzC9VJqVzciwAgAb8qWCAAjmMgIAX6uiAgCTrELA=
Date:   Mon, 21 Jan 2019 04:38:44 +0000
Message-ID: <CY4PR21MB07733F173EDDEA6B83458EFED79F0@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20181122030914.16274-1-kys@linuxonhyperv.com>
 <20181122031059.16338-1-kys@linuxonhyperv.com>
 <20181122031059.16338-2-kys@linuxonhyperv.com>
 <39e47e32-2738-e39a-4ddb-9d27d2513beb@arm.com>
 <CY4PR21MB0773002BFD385052A830A979D7A70@CY4PR21MB0773.namprd21.prod.outlook.com>
 <e0374a07-809c-cabd-2eb6-e6b5ad84742e@arm.com>
 <CY4PR21MB077301ECE13325F8C75EE941D78E0@CY4PR21MB0773.namprd21.prod.outlook.com>
In-Reply-To: <CY4PR21MB077301ECE13325F8C75EE941D78E0@CY4PR21MB0773.namprd21.prod.outlook.com>
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
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:OyrIvhOXEaBJSkqHb76wro9m/mF9x1JCMMCHPb8/goG9NXhi1Ac3C8v25XEppvTUeuZGlUVy7oFjf5CTdx1VZIPriyxpbMXBNXNe050b8mNgWJR1eHnxkCDDSACEvr+fMb2cwV2/BysWPBsJlP3xIMGKd4McyY2BYrdeeo2rmox7POyj+k/++YA63qB8mwnhHI9MSJ0WQ4l6KiGi1m9kS8CCFGQfkU/0g8/Sd6HqZx1IWvbwmejgHbCUUMqknulkDLXBQIFIUoP4WYnzX6f83c6QyDetUcFSlmnQRsAtsUM3UET05wqLkG3vFZA5YmP20GHN8X6+2Fd5eRm+D7N0el3rkbwxhkSplzr4rMsBWJaNW1IG5AZK6vMIuRDurYdtUaDVKS+K564B0583ILERxFjnKR3oAWipz387TmoMvgt6ulCvgyQeV2UHiDqXGwHEuFxVyW1ZgnLdC0RtI1xqiA==;5:/f+PAznvQGQ1cIltTz6yS5F/rfWHZjj5SXx3yT1d9er1I8K1iHq6X+ao//pdwlwYlOlQaVDebQhvENXD4IhaoSLzzUejNsvLzBApsJU/CYEg8H3dwv9bvblxtK6d8MYxoOxVA7mgthIRczYfepMQ9V55GSAjYCy8vr2rwN5TXXz3/q1dRT68JN8lNghKDbtfK91+OQZMnS8nDf0lNZEVrg==;7:QYRDaVlKl44rcYaxerlQZLF9gHlObEBeBaJUkDzlILIk09tRkei6iB7gYDtGAvYd0oxkOol2H6aeG8jXGmCVCrovubzeu81Ucyefwi/pBQjdbyiHiQ4RHzU3JhgDf2UhC6ai+W6i0pA77HDZhfsjzg==
x-ms-office365-filtering-correlation-id: 299e930d-757e-473f-8a2d-08d67f5a5384
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-ms-exchange-purlcount: -3
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB0821D3BD8C1E4020959E40BFD79F0@CY4PR21MB0821.namprd21.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(376002)(366004)(396003)(199004)(189003)(14454004)(9686003)(26005)(6346003)(186003)(7416002)(74316002)(6246003)(81166006)(81156014)(2201001)(53936002)(14444005)(8936002)(86612001)(7696005)(256004)(76176011)(2906002)(305945005)(2501003)(86362001)(105586002)(106356001)(486006)(1511001)(93886005)(11346002)(316002)(25786009)(97736004)(476003)(110136005)(6116002)(6506007)(102836004)(71200400001)(22452003)(6436002)(71190400001)(7736002)(68736007)(10290500003)(478600001)(8990500004)(99286004)(8676002)(66066001)(3846002)(55016002)(446003)(229853002)(33656002)(10090500001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: e4gx+a2cvxb5/B6NiFgSLyv2dw1I3g0C7B/NOYujejp5RpVzSTSzkbLMc7/WlsULIwf05pdyfh82+rlKNFfIplBOC+zXVDBCjYpShiwHlCMVD49gKNRyNtP73142KpPhp5R8RZbylKi3Hxm0umz3flnN6q2KJaN3ODmz7J6bYVR2ozK+f5AiymtEVJCttz2NBQnsEubl9ugN8CscNi5IMBu6wD8m+fKaJtTkyyciF2F9tDCglsqASNi41dCeIDbX3LCnMkgeaGjkxklnQYD3tWNdBsn+Vj+NltwTAxerLiKsQ3hZBnYEWVAwuSS+cs115SMLa+o8eCbKabGpq9xeEJnnGcqfYPILmB+vGBrqKWhKdRfbkAXfOPDpCAC5JQ4opuA7+RwwsOo6jHbctZ+V93lL9C6XWPercXU86DsyDgY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 299e930d-757e-473f-8a2d-08d67f5a5384
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 04:38:44.2601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWljaGFlbCBLZWxsZXkgIFNlbnQ6IEZyaWRheSwgSmFudWFyeSA0LCAyMDE5IDEyOjA1
IFBNDQo+IA0KPiA+ID4+IEFzIFdpbGwgc2FpZCwgdGhpcyBpc24ndCBhIHZpYWJsZSBvcHRpb24u
IFBsZWFzZSBmb2xsb3cgU01DQ0MgMS4xLg0KPiA+ID4NCj4gPiA+IEknbGwgaGF2ZSB0byBzdGFy
dCBhIGNvbnZlcnNhdGlvbiB3aXRoIHRoZSBIeXBlci1WIHRlYW0gYWJvdXQgdGhpcy4NCj4gPiA+
IEkgZG9uJ3Qga25vdyB3aHkgdGhleSBjaG9zZSB0byB1c2UgSFZDICMxIG9yIHRoaXMgcmVnaXN0
ZXIgc2NoZW1lDQo+ID4gPiBmb3Igb3V0cHV0IHZhbHVlcy4gIEl0IG1heSBiZSB0b3VnaCB0byBj
aGFuZ2UgYXQgdGhpcyBwb2ludCBiZWNhdXNlDQo+ID4gPiB0aGVyZSBhcmUgV2luZG93cyBndWVz
dHMgb24gSHlwZXItViBmb3IgQVJNNjQgdGhhdCBhcmUgYWxyZWFkeQ0KPiA+ID4gdXNpbmcgdGhp
cyBhcHByb2FjaC4NCj4gPg0KPiA+IEkgYXBwcmVjaWF0ZSB5b3UgYWxyZWFkeSBoYXZlIHN0dWZm
IGluIHRoZSB3aWxkLCBidXQgdGhlcmUgaXMgZGVmaW5pdGVseQ0KPiA+IGEgY2FzZSB0byBiZSBt
YWRlIGZvciBzdXBwb3J0aW5nIGFyY2hpdGVjdHVyYWxseSBzcGVjaWZpZWQgbWVjaGFuaXNtcyBp
bg0KPiA+IGEgaHlwZXJ2aXNvciwgYW5kIFNNQ0NDIGlzIGRlZmluaXRlbHkgcGFydCBvZiBpdCAo
SSdtIGNlcnRhaW5seSBjdXJpb3VzDQo+ID4gb2YgaG93IHlvdSBzdXBwb3J0IHRoZSBTcGVjdHJl
IG1pdGlnYXRpb24gb3RoZXJ3aXNlKS4NCj4gPg0KPiANCj4gVGhlIEh5cGVyLVYgZ3V5cyBJIG5l
ZWQgdG8gZGlzY3VzcyB0aGlzIHdpdGggYXJlIG5vdCBiYWNrIGZyb20gdGhlDQo+IGhvbGlkYXlz
IHVudGlsIEphbnVhcnkgN3RoLiAgSSdsbCBmb2xsb3cgdXAgb24gdGhpcyB0aHJlYWQgb25jZSBJ
J3ZlDQo+IGhhZCB0aGF0IGNvbnZlcnNhdGlvbi4NCj4gDQoNCkZlZWRiYWNrIGZyb20gdGhlIEh5
cGVyLVYgZ3V5cyBpcyB0aGF0IHRoZXkgYmVsaWV2ZSB0aGUgSHlwZXItVg0Kc3BlY2lmaWMgaHlw
ZXJjYWxsIHNlcXVlbmNlICppcyogY29tcGxpYW50IHdpdGggU01DQ0MgMS4xLCBpbiB0aGUNCnNl
bnNlIG9mIGJlaW5nIG91dHNpZGUgdGhlIHJlcXVpcmVtZW50cyBwZXIgU2VjdGlvbiAyLjkgc2lu
Y2UgdGhlDQpIeXBlci1WIGh5cGVyY2FsbCBzZXF1ZW5jZSB1c2VzIEhWQyAjMS4gIEh5cGVyLVYg
d2FudGVkIHRvIHVzZSBhDQpzaW1wbGVyIGNhbGxpbmcgc2VxdWVuY2UgdGhhdCBkb2Vzbid0IGhh
dmUgdGhlIGZ1bGwgcmVnaXN0ZXINCnNhdmUvcmVzdG9yZSByZXF1aXJlbWVudHMsIGZvciBiZXR0
ZXIgcGVyZm9ybWFuY2UuICBUaGUgZGV0YWlscw0Kb2YgdGhlIEh5cGVyLVYgaHlwZXJjYWxsIHNl
cXVlbmNlIGFyZSBkb2N1bWVudGVkIGludGVybmFsbHksDQpidXQgd2UgZG8gc3RpbGwgbmVlZCB0
byBnZXQgaXQgcHVibGlzaGVkIGV4dGVybmFsbHkgYXMgcGFydCBvZiBhDQpIeXBlci1WIFRMRlMg
dmVyc2lvbiB0aGF0IGluY2x1ZGVzIEFSTTY0Lg0KDQpIeXBlci1WIHVzZXMgdGhlIGZ1bGwgU01D
IENhbGxpbmcgQ29udmVudGlvbnMgaW4gb3RoZXIgcGxhY2VzLA0Kc3VjaCBhcyBmb3IgUFNDSSBj
YWxscywgZm9yIFNNQ3MgdG8gRUwzLCBhbmQgZm9yIHRoZSBTcGVjdHJlDQptaXRpZ2F0aW9uIHJl
bGF0ZWQgY2FsbHMuDQoNCk1pY2hhZWwNCg==
