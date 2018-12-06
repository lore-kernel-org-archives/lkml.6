Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27241C65BAF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE17820850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="cpOkkGEy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE17820850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbeLFU3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:29:45 -0500
Received: from mail-eopbgr800057.outbound.protection.outlook.com ([40.107.80.57]:12320
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725994AbeLFU3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 15:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9ed/hUz8eb3D+zblBS2isNOzVGirA0w4iF6bw2cMqA=;
 b=cpOkkGEy/aUb799GfJzk2aqPy0O/Zh9RUpZUJTd6K2cDRSWwDhR4U4xj85m90yRXrS+ERhTynQnLoudw3D2NY8GYP7ivymeEgbmCaFGvInIcQMSPPe+px/57hNT2Smh95sVqIMaVEdexoBL1skXLi5x9WB9MCstOcOSeAKCuJhc=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5127.namprd05.prod.outlook.com (20.177.231.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.14; Thu, 6 Dec 2018 20:29:37 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::9155:fea7:9c0c:68c7]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::9155:fea7:9c0c:68c7%3]) with mapi id 15.20.1425.006; Thu, 6 Dec 2018
 20:29:37 +0000
From:   Nadav Amit <namit@vmware.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC:     "luto@kernel.org" <luto@kernel.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux_dti@icloud.com" <linux_dti@icloud.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH v7 13/14] module: Do not set nx for module memory before
 freeing
Thread-Topic: [PATCH v7 13/14] module: Do not set nx for module memory before
 freeing
Thread-Index: AQHUjHgCm5HQo9wG+kmVhMEM5+sZ86VyEK8AgAAZDICAAAIjAA==
Date:   Thu, 6 Dec 2018 20:29:37 +0000
Message-ID: <1B1C066C-04B2-4DD0-A28B-71BA7CDDD658@vmware.com>
References: <20181205013408.47725-1-namit@vmware.com>
 <20181205013408.47725-14-namit@vmware.com>
 <CALCETrWZf5sNmXU=yP1ZHxiBi=Z9d3G5FnWH08PasniG1hs26g@mail.gmail.com>
 <55a4fb61164d7ecf5950e29d1fa2aea52a1b958f.camel@intel.com>
In-Reply-To: <55a4fb61164d7ecf5950e29d1fa2aea52a1b958f.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5127;20:gzj0mEGqbs1HhU+NYhfKKwwVF7NChrSIS9MEOxTtqoc6Pgng7PLSU1LkKHVKgQHf1dirTjQEO6Pc3ReIoYsycWWykoVEMVV/BSPhs1K3S56JzyTooT09MZvv2DBn/UPz06zWQMC+jcXNt6k0ZUjtqS+SD+XtuwjOQBFY3/bapSU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fd3c22d5-4e0c-49b2-75a7-08d65bb98ae7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5127;
x-ms-traffictypediagnostic: BYAPR05MB5127:
x-microsoft-antispam-prvs: <BYAPR05MB51270DA8F1A4A6241CDD1EC0D0A90@BYAPR05MB5127.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501520)(52105112)(10201501046)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB5127;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB5127;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(376002)(346002)(136003)(199004)(189003)(6116002)(102836004)(11346002)(86362001)(82746002)(3846002)(6506007)(316002)(2906002)(68736007)(66066001)(53546011)(76176011)(33656002)(36756003)(99286004)(54906003)(83716004)(53936002)(6436002)(4326008)(71190400001)(106356001)(6512007)(6486002)(229853002)(39060400002)(105586002)(6246003)(14444005)(256004)(478600001)(2616005)(25786009)(6916009)(446003)(26005)(476003)(186003)(14454004)(486006)(8676002)(8936002)(81166006)(81156014)(71200400001)(305945005)(7736002)(5660300001)(93886005)(7416002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5127;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OOYIsDHF7gExtm9lZBfPLkOXTX8DDRUsRRTdORU6HTEDUwKefGYo7lAZUr/jQ0AS8PuadTWIMSTbtGFVRu+3oE3zBOJM40r7lrh7rYSsk+rQPQZ3WKFPP673j2T68ZRjGa0QrFeD8hQEYrXTFXQRDZ18imL5t/cWujM4UKip24fL1nelUqQIOHCn0EPI7YVHRxWLU3r70WEsIL5ItsgXsUqhYysX0BUpsA2VVVfIs7NTQn3sp7CUHhIEIXyHQZHtXN5x5d2X65sxPaarGMiqiOcEMRW6PoLl+73oEpvtCXFdyP/L3yJdNVLqvbxgi/SdWec6IX81MQ9aF171Cy1pQ+unvHurgfdHBa+4eADkf5o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B5CCE7B367EC949A3DE056C47FFFE00@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3c22d5-4e0c-49b2-75a7-08d65bb98ae7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 20:29:37.4974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBEZWMgNiwgMjAxOCwgYXQgMTI6MjEgUE0sIEVkZ2Vjb21iZSwgUmljayBQIDxyaWNrLnAu
ZWRnZWNvbWJlQGludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIDIwMTgtMTItMDYgYXQg
MTA6NTIgLTA4MDAsIEFuZHkgTHV0b21pcnNraSB3cm90ZToNCj4+IE9uIFdlZCwgRGVjIDUsIDIw
MTggYXQgMTI6NTIgQU0gTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJlLmNvbT4gd3JvdGU6DQo+Pj4g
V2hlbiBtb2R1bGUgbWVtb3J5IGlzIGFib3V0IHRvIGJlIGZyZWVkLCB0aGVyZSBpcyBubyBhcHBh
cmVudCByZWFzb24gdG8NCj4+PiBtYWtlIGl0IChhbmQgaXRzIGRhdGEpIGV4ZWN1dGFibGUsIGJ1
dCB0aGF0J3MgZXhhY3RseSB3aGF0IGlzIGRvbmUNCj4+PiB0b2RheS4gVGhpcyBpcyBub3QgZWZm
aWNpZW50IGFuZCBub3Qgc2VjdXJlLg0KPj4+IA0KPj4+IFRoZXJlIGFyZSB2YXJpb3VzIHRoZW9y
aWVzIHdoeSBpdCB3YXMgZG9uZSwgYnV0IG5vbmUgb2YgdGhlbSBzZWVtIGFzDQo+Pj4gc29tZXRo
aW5nIHRoYXQgcmVhbGx5IHJlcXVpcmUgaXQgdG9kYXkuIG5pb3MyIHVzZXMga21hbGxvYyBmb3Ig
bW9kdWxlDQo+Pj4gbWVtb3J5LCBidXQgYW55aG93IGl0IGRvZXMgbm90IGNoYW5nZSB0aGUgUFRF
cyBvZiB0aGUgbW9kdWxlIG1lbW9yeS4gIEluDQo+Pj4geDg2LCBjaGFuZ2luZyB2bWFsbG9jJ2Qg
bWVtb3J5IG1hcHBpbmdzIGFsc28gbW9kaWZpZXMgdGhlIGRpcmVjdCBtYXBwaW5nDQo+Pj4gYWxp
YXMsIGJ1dCB0aGUgTlgtYml0IGlzIG5vdCBtb2RpZmllZCBpbiBzdWNoIHdheS4NCj4+PiANCj4+
PiBTbyBsZXQncyByZW1vdmUgaXQuIEFuZHkgc3VnZ2VzdGVkIHRoYXQgdGhlIGNoYW5nZXMgb2Yg
dGhlIFBURXMgY2FuIGJlDQo+Pj4gYXZvaWRlZCAoZXhjbHVkaW5nIHRoZSBkaXJlY3QtbWFwcGlu
ZyBhbGlhcyksIHdoaWNoIGlzIHRydWUuIEhvd2V2ZXIsDQo+Pj4gaW4geDg2IGl0IHJlcXVpcmVz
IHNvbWUgY2xlYW51cCBvZiB0aGUgY29udGlndW91cyBwYWdlIGFsbG9jYXRvciwgd2hpY2gNCj4+
PiBpcyBvdXRzaWRlIG9mIHRoZSBzY29wZSBvZiB0aGlzIHBhdGNoLXNldC4NCj4+IA0KPj4gDQo+
PiBJJ20gb2theSB3aXRoIHRoaXMsIGJ1dCBJJ2QgbGlrZSB0byBzZWUgUmljaydzIHN0dWZmIGdl
dCByZWJhc2VkIG9uDQo+PiB0b3Agb2YgaXQgYW5kIGNsZWFuIGl0IHVwIGZvciByZWFsLg0KPiAN
Cj4gTmFkYXYsDQo+IA0KPiBIbW0sIHNpbmNlIHlvdSBhcmUgdHJ5aW5nIHRvIG1vdmUgdGhpbmdz
IGZvcndhcmQgYW5kIG5vdCBjbG9zZSBhbGwgY2FzZXMgaW4gb25lDQo+IHN3b29wLCB3b3VsZCBp
dCBtYWtlIHNlbnNlIHRvIHNwbGl0IHRoZSBtb2R1bGVzIFdeWCBtaXNzaW9uIGZyb20gdGhpcyBw
YXRjaHNldD8NCg0KVGhhdOKAmXMgd2hhdCBJIHRyaWVkIHRvIOKAnGhpbnTigJ0uIFRnbHggYXNr
ZWQgZm9yIHRoZSBtb2R1bGUgc3R1ZmYgaW4gb25lIG9mIHRoZQ0KcHJldmlvdXMgdmVyc2lvbnMu
DQoNCg==
