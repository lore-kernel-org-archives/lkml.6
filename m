Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13029C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 05:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E02A24B41
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 05:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=MicroFocusInternational.onmicrosoft.com header.i=@MicroFocusInternational.onmicrosoft.com header.b="MlymeaJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E02A24B41
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751338AbeFWFxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 01:53:47 -0400
Received: from prvmx02.microfocus.com ([130.57.1.217]:17182 "EHLO
        prvmx02.microfocus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751098AbeFWFxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 01:53:45 -0400
Received: from prvxcaht03.microfocus.com (Not Verified[137.65.248.137]) by prvmx02.microfocus.com with Trustwave SEG (v7,5,8,10121) (using TLS: TLSv1.2, AES256-SHA256)
        id <B5b2de0790000>; Fri, 22 Jun 2018 23:54:01 -0600
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (137.65.224.21)
 by mail.microfocus.com (137.65.248.137) with Microsoft SMTP Server (TLS) id
 14.3.339.0; Fri, 22 Jun 2018 23:53:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=MicroFocusInternational.onmicrosoft.com; s=selector1-suse-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLL9IgBmCVilazcG2HRZTmY8mBFG8PWh4LgwLZvsuoE=;
 b=MlymeaJOYLZt8sunGHYsCYRj3W1fRtOVMhVhMxCtug++4MKIf7+i0kXJXQoFtORry7Zs5fCVW3y2ZwA1LRok2REBz5sNQNfaSHLaDCTE1mcr4v9cNIgJU5kZM2JUKGekgINsRxwyiY5WacJNttQOgqhyQ4ne+pKJF5vn/yVOgMQ=
Received: from SN1PR18MB2143.namprd18.prod.outlook.com (52.132.197.14) by
 SN1PR18MB0525.namprd18.prod.outlook.com (10.165.30.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Sat, 23 Jun 2018 05:53:40 +0000
Received: from SN1PR18MB2143.namprd18.prod.outlook.com
 ([fe80::dc8a:26c5:6c72:88fc]) by SN1PR18MB2143.namprd18.prod.outlook.com
 ([fe80::dc8a:26c5:6c72:88fc%2]) with mapi id 15.20.0884.010; Sat, 23 Jun 2018
 05:53:40 +0000
From:   Guomin Chen <guomin.chen@suse.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Joey Lee <JLee@suse.com>, Borislav Petkov <bp@suse.de>,
        Takashi Iwai <tiwai@suse.de>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] resource: Fixed iomem resource release failed on
 release_mem_region_adjustable() when memory node or cpu node hot-remove.
Thread-Topic: [PATCH 1/1] resource: Fixed iomem resource release failed on
 release_mem_region_adjustable() when memory node or cpu node hot-remove.
Thread-Index: AQHUCiEKcTPx3XGobUmybR5M4UYpSqRs6q4AgABr56A=
Date:   Sat, 23 Jun 2018 05:53:40 +0000
Message-ID: <SN1PR18MB2143CB9E209AC070DB0EC8029C740@SN1PR18MB2143.namprd18.prod.outlook.com>
References: <20180622120138.5411-1-guomin.chen@suse.com>
 <20180622231930.GA2834@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180622231930.GA2834@bhelgaas-glaptop.roam.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=guomin.chen@suse.com; 
x-originating-ip: [113.116.122.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR18MB0525;7:d7f6CLPwI/5vXgcNB8VSh/RidP8+NrcXvlLbtUaJSuDyoRm/hclKOwBQ2xnu+LNKpSuH9AOY7ZQQ5rrYfQnINW5yQZzoa1yPLr1ad4vpoBXo1H/4TmCm/OgQ8te2HBOCbMHoPSQ9oXxpsS26E0F64g7dOzJXLE0kaU0AqViaX/qfqJC6pcmTox+KSbeOmJYF75XqyQfTpIz9StXdM59OwPLV+9NWVYNgnYmX2OhjaD84lyElg1eJjzZnMZbolubx
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4421c338-733b-41e2-b326-08d5d8cdabad
x-microsoft-antispam: UriScan:(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR18MB0525;
x-ms-traffictypediagnostic: SN1PR18MB0525:
x-ld-processed: 856b813c-16e5-49a5-85ec-6f081e13b527,ExtAddr
x-microsoft-antispam-prvs: <SN1PR18MB05252E8D503E375FDF05B4639C740@SN1PR18MB0525.namprd18.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(227479698468861)(173505980823694)(9452136761055)(767451399110)(211936372134217)(153496737603132)(222181515654134)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SN1PR18MB0525;BCL:0;PCL:0;RULEID:;SRVR:SN1PR18MB0525;
x-forefront-prvs: 07126E493C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(396003)(376002)(39380400002)(366004)(199004)(13464003)(189003)(9686003)(966005)(55016002)(66066001)(6916009)(44832011)(6436002)(33656002)(2906002)(8676002)(11346002)(486006)(7416002)(446003)(81166006)(74316002)(6306002)(5660300001)(76176011)(68736007)(81156014)(229853002)(478600001)(7696005)(14454004)(7736002)(476003)(305945005)(102836004)(6246003)(54906003)(6116002)(97736004)(99286004)(8936002)(6506007)(3660700001)(5250100002)(53936002)(2900100001)(575784001)(3846002)(3280700002)(25786009)(86362001)(316002)(26005)(106356001)(186003)(4326008)(53546011)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR18MB0525;H:SN1PR18MB2143.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Kdkm87nZ5ds5qqTRHEXy9NELN17MiR3D7Bkp4l/feCvE0IoyWmgq70T0L6ZNQGQta5HgjS8sBDm+XSAWJvMmC7HO4GeADRg77W7ybTdDz95naPtaBxxVNNcff2AE90gYwYHV0SiJMuPvVf3A+5b0ktfRCnc7cZt/Yi0oTDqBF9DronkuzwSPyVrF8R5krNZfwSN7lj5prFOpmVYYG1quzTYXbGgk2P/KBsH1oPz3V+kYFgOxfAcbajp/BxuW7IqdsLXO4DHGlBNP+E/39Vuuvet6Ql0pqDSW88Eln0XialB7elwol+E/36DNDFzktJXlH75rUvjgGldO3a94hczdVw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4421c338-733b-41e2-b326-08d5d8cdabad
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2018 05:53:40.1726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR18MB0525
X-OriginatorOrg: suse.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgDQoJVGhlIHJlcG9ydCBsaW5rIGZvciB0aGlzIGlzc3VlIGlzOiBodHRwczovL2J1Z3ppbGxh
LnN1c2UuY29tL3Nob3dfYnVnLmNnaT9pZD0xMDkyNjg3DQoNClRoYW5rcyBhbmQgcmVnYXJkcw0K
DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJqb3JuIEhlbGdhYXMgW21h
aWx0bzpoZWxnYWFzQGtlcm5lbC5vcmddDQo+IFNlbnQ6IDIwMTjE6jbUwjIzyNUgNzoyMA0KPiBU
bzogR3VvbWluIENoZW4gPGd1b21pbi5jaGVuQHN1c2UuY29tPg0KPiBDYzogQnJpamVzaCBTaW5n
aCA8YnJpamVzaC5zaW5naEBhbWQuY29tPjsgVG9tIExlbmRhY2t5DQo+IDx0aG9tYXMubGVuZGFj
a3lAYW1kLmNvbT47IFlhb3dlaSBCYWkNCj4gPGJhaXlhb3dlaUBjbXNzLmNoaW5hbW9iaWxlLmNv
bT47IEJqb3JuIEhlbGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+Ow0KPiBUb3NoaSBLYW5pIDx0
b3NoaS5rYW5pQGhwZS5jb20+OyBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNv
bT47DQo+IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPjsgQW5kcmV3IE1vcnRv
bg0KPiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz47IEpvZXkgTGVlIDxKTGVlQHN1c2UuY29t
PjsgQm9yaXNsYXYgUGV0a292DQo+IDxicEBzdXNlLmRlPjsgVGFrYXNoaSBJd2FpIDx0aXdhaUBz
dXNlLmRlPjsgbGludXgtZWZpQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMV0gcmVzb3VyY2U6IEZpeGVkIGlv
bWVtIHJlc291cmNlIHJlbGVhc2UgZmFpbGVkIG9uDQo+IHJlbGVhc2VfbWVtX3JlZ2lvbl9hZGp1
c3RhYmxlKCkgd2hlbiBtZW1vcnkgbm9kZSBvciBjcHUgbm9kZQ0KPiBob3QtcmVtb3ZlLg0KPiAN
Cj4gWytjYyBUb3NoaV0NCj4gDQo+IE9uIEZyaSwgSnVuIDIyLCAyMDE4IGF0IDA4OjAxOjM4UE0g
KzA4MDAsIGd1b21pbiBjaGVuIHdyb3RlOg0KPiA+IFdlJ3ZlIGdvdCBhIGJ1ZyByZXBvcnQgaW5k
aWNhdGluZyB0aGUgaG90LXJlbW92ZSBub2RlIHJlc291cmNlIHJlbGVhc2UNCj4gPiBmYWlsZWQs
d2hlbiB0aGUgbWVtb3J5IG9uIHRoaXMgbm9kZSBpcyBkaXZpZGVkIGludG8gc2V2ZXJhbA0KPiA+
IHNlY3Rpb25zLmJlY2F1c2UgdGhlIHJlbGVhc2VfbWVtX3JlZ2lvbl9hZGp1c3RhYmxlKCkgY2Fu
IG9ubHkgcmVsZWFzZQ0KPiA+IG9uZSByZXNvdXJjZSB0aGF0IG11c3QgYmUgW3N0YXJ0LGVuZF0u
DQo+IA0KPiBDYW4geW91IHBsZWFzZSBpbmNsdWRlIGEgVVJMIGZvciB0aGUgYnVnIHJlcG9ydD8g
IFRoYXQncyB1c2VmdWwgZm9yIGFkZGl0aW9uYWwNCj4gZGV0YWlscyBhbmQgZ2l2ZXMgaGludHMg
YWJvdXQgaG93IGZ1dHVyZSBjaGFuZ2VzIGluIHRoaXMgYXJlYSBtaWdodCBiZSB0ZXN0ZWQuDQo+
IA0KPiByZWxlYXNlX21lbV9yZWdpb25fYWRqdXN0YWJsZSgpIGFuZCB0aGUgb25seSBjYWxsIHRv
IGl0IHdlcmUgYWRkZWQgYnkgVG9zaGkNCj4gKGNjJ2QpOg0KPiANCj4gICA4MjVmNzg3YmI0OTYg
KCJyZXNvdXJjZTogYWRkIHJlbGVhc2VfbWVtX3JlZ2lvbl9hZGp1c3RhYmxlKCkiKQ0KPiAgIGZl
NzRlYmIxMDZhNSAoIm1tOiBjaGFuZ2UgX19yZW1vdmVfcGFnZXMoKSB0byBjYWxsDQo+IHJlbGVh
c2VfbWVtX3JlZ2lvbl9hZGp1c3RhYmxlKCkiKQ0KPiANCj4gPiBJbiBteSBjYXNlLCB0aGUgQklP
UyBzdXBwb3J0cyBmYXVsdHkgbWVtb3J5IGlzb2xhdGlvbi4gaWYgQklPUw0KPiA+IGRldGVjdGVk
IGJhZCBtZW1vcnkgYmxvY2ssIHRoZSBCSU9TIHdpbGwgaXNvbGF0ZXMgdGhpcyBiYWRibG9jay4N
Cj4gPiBBbmQgc2V0IHRoaXMgYmFkYmxvY2sgbWVtb3J5IHRvIEVmaVVudXNhYmxlTWVtb3J5IGlu
IEVGSSBtZW1vcnkgbWFwDQo+ID4gYmFzZSBvbiBVRUZJIDIuNyBzcGVjLkZvciBleGFtcGxlIGlu
IG15IHN5c3RlbSwgdGhlIG1lbW9yeSByYW5nZSBvbg0KPiA+IG5vZGUyIGlzIFttZW0gMHgwMDAw
MDgwMDAwMDAwMDAwLTB4MDAwMDA4MDdmZmZmZmZmZl0uYnV0IHRoZSBCSU9TDQo+ID4gZGV0ZWN0
ZWQgdGhlIFs4MDA0ZTAwMDAwMC04MDA0ZTBmZmZmZl0gaXMgYSBiYWRibG9jayBtZW1vcnkuDQo+
ID4gU28gdGhlIG1lbW9yeSBvbiBub2RlMiBzZWVtIGxpa2UgdGhpczoNCj4gPiAgICAJCTgwMDAw
MDAwMDAwLTgwMDRkZmZmZmZmIDogU3lzdGVtIFJBTQ0KPiA+IAkJODAwNGUwMDAwMDAtODAwNGUw
ZmZmZmYgOiBVbnVzYWJsZSBtZW1vcnkNCj4gPiAJCTgwMDRlMTAwMDAwLTgwN2ZmZmZmZmZmIDog
U3lzdGVtIFJBTQ0KPiA+DQo+ID4gTm93LCB3aGVuIG9mZmxpbmUgdGhlIGNwdSBub2RlMix0aGUg
a2VybmVsIHdpbGwgdHJ5IHRvIHJlbGVhc2UNCj4gPiBpb3Jlc291cmNlIFttZW0gMHgwMDAwMDgw
MDAwMDAwMDAwLTB4MDAwMDA4MDdmZmZmZmZmZl0uIGF0IHRoaXMgdGltZSwNCj4gPiB0aGUga2Vy
bmVsIHdpbGwgcmVsZWFzZSBmYWlsZWQsYW5kIG91dHB1dCBlcnJvciBtZXNzYWdlOg0KPiA+ICJV
bmFibGUgdG8gcmVsZWFzZSByZXNvdXJjZSA8MHgwMDAwMDgwMDAwMDAwMDAwLTB4MDAwMDA4MDdm
ZmZmZmZmZj4NCj4gPiAoLTIyKSIuDQo+ID4gQmVjYXVzZSB0aGUgcmVsZWFzZV9tZW1fcmVnaW9u
X2FkanVzdGFibGUoKSBjYW4gb25seSByZWxlYXNlIG9uZQ0KPiA+IHJlc291cmNlIHRoYXQgbXVz
dCBiZSBbMHgwMDAwMDgwMDAwMDAwMDAwICwgMHgwMDAwMDgwN2ZmZmZmZmZmXS4NCj4gPiBidXQg
bm93LHRoZSBpb21lbSByZXNvdXJjZSBvbiBub2RlMiBbMHgwMDAwMDgwMDAwMDAwMDAwLA0KPiA+
IDB4MDAwMDA4MDdmZmZmZmZmZl0gYXJlIGRpdmlkZWQgaW50byB0aHJlZSByZXNvdXJjZXMgWzgw
MDAwMDAwMDAwLQ0KPiA+IDgwMDRkZmZmZmZmXSxbODAwNGUwMDAwMDAtODAwNGUwZmZmZmZdYW5k
WzgwMDRlMTAwMDAwLTgwN2ZmZmZmZmZmXS4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggaGVscCB0byBS
ZWxlYXNlIG11bHRpcGxlIGlvbWVtIHJlc291cmNlcyBhdCBvbmNlIHdoZW4gbm9kZQ0KPiA+IGhv
dC1yZW1vdmUuIFN1Y2ggYXMgaW4gYWJvdmUgY2FzZSwgd2hlbiBob3QtcmVtb3ZlIHRoZSBjcHUg
bm9kZTIsdGhlDQo+ID4ga2VybmVsIHdpbGwgdHJ5IHRvIHJlbGVhc2UgcmVzb3VyY2UgWzB4MDAw
MDA4MDAwMDAwMDAwMC0NCj4gPiAweDAwMDAwODA3ZmZmZmZmZmZdLkFuZCB0aGlzIHBhdGNoIHdp
bGwgcmVsZWFzZSB0aHJlZSByZXNvdXJjZXMNCj4gPiBbODAwMDAwMDAwMDAtODAwNGRmZmZmZmZd
LFs4MDA0ZTAwMDAwMC04MDA0ZTBmZmZmZl0gYW5kDQo+ID4gWzgwMDRlMTAwMDAwLTgwN2ZmZmZm
ZmZmXS4NCj4gPg0KPiA+IENjOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4N
Cj4gPiBDYzogQnJpamVzaCBTaW5naCA8YnJpamVzaC5zaW5naEBhbWQuY29tPg0KPiA+IENjOiBC
b3Jpc2xhdiBQZXRrb3YgPGJwQHN1c2UuZGU+DQo+ID4gQ2M6IEFuZHJldyBNb3J0b24gPGFrcG1A
bGludXgtZm91bmRhdGlvbi5vcmc+DQo+ID4gQ2M6IFRvbSBMZW5kYWNreSA8dGhvbWFzLmxlbmRh
Y2t5QGFtZC5jb20+DQo+ID4gQ2M6IEJqb3JuIEhlbGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+
DQo+ID4gQ2M6IFlhb3dlaSBCYWkgPGJhaXlhb3dlaUBjbXNzLmNoaW5hbW9iaWxlLmNvbT4NCj4g
PiBDYzogVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRlPg0KPiA+IENjOiBEYW4gV2lsbGlhbXMg
PGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCj4gPiBDYzogbGludXgtZWZpQHZnZXIua2VybmVs
Lm9yZw0KPiA+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4gQ2M6IExlZSBD
aHVuLVlpIDxKTGVlQHN1c2UuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IGd1b21pbiBjaGVuIDxn
dW9taW4uY2hlbkBzdXNlLmNvbT4NCj4gPiAtLS0NCj4gPiAga2VybmVsL3Jlc291cmNlLmMgfCA3
Mw0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQzIGluc2VydGlvbnMoKyksIDMwIGRlbGV0aW9u
cygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2tlcm5lbC9yZXNvdXJjZS5jIGIva2VybmVsL3Jl
c291cmNlLmMgaW5kZXgNCj4gPiAzMGUxYmM2ODUwM2IuLjk1OWJjY2U0YzQwNSAxMDA2NDQNCj4g
PiAtLS0gYS9rZXJuZWwvcmVzb3VyY2UuYw0KPiA+ICsrKyBiL2tlcm5lbC9yZXNvdXJjZS5jDQo+
ID4gQEAgLTEyNDAsNiArMTI0MCw3IEBAIGludCByZWxlYXNlX21lbV9yZWdpb25fYWRqdXN0YWJs
ZShzdHJ1Y3QNCj4gcmVzb3VyY2UgKnBhcmVudCwNCj4gPiAgCXN0cnVjdCByZXNvdXJjZSAqcmVz
Ow0KPiA+ICAJc3RydWN0IHJlc291cmNlICpuZXdfcmVzOw0KPiA+ICAJcmVzb3VyY2Vfc2l6ZV90
IGVuZDsNCj4gPiArCXJlc291cmNlX3NpemVfdCBuZXdfc3RhcnQgPSBzdGFydDsNCj4gPiAgCWlu
dCByZXQgPSAtRUlOVkFMOw0KPiA+DQo+ID4gIAllbmQgPSBzdGFydCArIHNpemUgLSAxOw0KPiA+
IEBAIC0xMjU3LDcgKzEyNTgsNyBAQCBpbnQgcmVsZWFzZV9tZW1fcmVnaW9uX2FkanVzdGFibGUo
c3RydWN0DQo+IHJlc291cmNlICpwYXJlbnQsDQo+ID4gIAkJCWJyZWFrOw0KPiA+DQo+ID4gIAkJ
LyogbG9vayBmb3IgdGhlIG5leHQgcmVzb3VyY2UgaWYgaXQgZG9lcyBub3QgZml0IGludG8gKi8N
Cj4gPiAtCQlpZiAocmVzLT5zdGFydCA+IHN0YXJ0IHx8IHJlcy0+ZW5kIDwgZW5kKSB7DQo+ID4g
KwkJaWYgKHJlcy0+ZW5kIDwgbmV3X3N0YXJ0KSB7DQo+ID4gIAkJCXAgPSAmcmVzLT5zaWJsaW5n
Ow0KPiA+ICAJCQljb250aW51ZTsNCj4gPiAgCQl9DQo+ID4gQEAgLTEyNzEsNDIgKzEyNzIsNTQg
QEAgaW50IHJlbGVhc2VfbWVtX3JlZ2lvbl9hZGp1c3RhYmxlKHN0cnVjdA0KPiByZXNvdXJjZSAq
cGFyZW50LA0KPiA+ICAJCX0NCj4gPg0KPiA+ICAJCS8qIGZvdW5kIHRoZSB0YXJnZXQgcmVzb3Vy
Y2U7IGxldCdzIGFkanVzdCBhY2NvcmRpbmdseSAqLw0KPiA+IC0JCWlmIChyZXMtPnN0YXJ0ID09
IHN0YXJ0ICYmIHJlcy0+ZW5kID09IGVuZCkgew0KPiA+ICsJCWlmIChyZXMtPnN0YXJ0ID09IG5l
d19zdGFydCAmJiByZXMtPmVuZCA9PSBlbmQpIHsNCj4gPiAgCQkJLyogZnJlZSB0aGUgd2hvbGUg
ZW50cnkgKi8NCj4gPiAgCQkJKnAgPSByZXMtPnNpYmxpbmc7DQo+ID4gIAkJCWZyZWVfcmVzb3Vy
Y2UocmVzKTsNCj4gPiAgCQkJcmV0ID0gMDsNCj4gPiAtCQl9IGVsc2UgaWYgKHJlcy0+c3RhcnQg
PT0gc3RhcnQgJiYgcmVzLT5lbmQgIT0gZW5kKSB7DQo+ID4gLQkJCS8qIGFkanVzdCB0aGUgc3Rh
cnQgKi8NCj4gPiAtCQkJcmV0ID0gX19hZGp1c3RfcmVzb3VyY2UocmVzLCBlbmQgKyAxLA0KPiA+
IC0JCQkJCQlyZXMtPmVuZCAtIGVuZCk7DQo+ID4gLQkJfSBlbHNlIGlmIChyZXMtPnN0YXJ0ICE9
IHN0YXJ0ICYmIHJlcy0+ZW5kID09IGVuZCkgew0KPiA+IC0JCQkvKiBhZGp1c3QgdGhlIGVuZCAq
Lw0KPiA+IC0JCQlyZXQgPSBfX2FkanVzdF9yZXNvdXJjZShyZXMsIHJlcy0+c3RhcnQsDQo+ID4g
LQkJCQkJCXN0YXJ0IC0gcmVzLT5zdGFydCk7DQo+ID4gKwkJfSBlbHNlIGlmIChyZXMtPmVuZCA+
IGVuZCkgew0KPiA+ICsJCQlpZiAocmVzLT5zdGFydCA+PSBuZXdfc3RhcnQpIHsNCj4gPiArCQkJ
CS8qIGFkanVzdCB0aGUgc3RhcnQgKi8NCj4gPiArCQkJCXJldCA9IF9fYWRqdXN0X3Jlc291cmNl
KHJlcywgZW5kICsgMSwNCj4gPiArCQkJCQkJCXJlcy0+ZW5kIC0gZW5kKTsNCj4gPiArCQkJfSBl
bHNlIHsNCj4gPiArCQkJCS8qIHNwbGl0IGludG8gdHdvIGVudHJpZXMgKi8NCj4gPiArCQkJCWlm
ICghbmV3X3Jlcykgew0KPiA+ICsJCQkJCXJldCA9IC1FTk9NRU07DQo+ID4gKwkJCQkJYnJlYWs7
DQo+ID4gKwkJCQl9DQo+ID4gKwkJCQluZXdfcmVzLT5uYW1lID0gcmVzLT5uYW1lOw0KPiA+ICsJ
CQkJbmV3X3Jlcy0+c3RhcnQgPSBlbmQgKyAxOw0KPiA+ICsJCQkJbmV3X3Jlcy0+ZW5kID0gcmVz
LT5lbmQ7DQo+ID4gKwkJCQluZXdfcmVzLT5mbGFncyA9IHJlcy0+ZmxhZ3M7DQo+ID4gKwkJCQlu
ZXdfcmVzLT5kZXNjID0gcmVzLT5kZXNjOw0KPiA+ICsJCQkJbmV3X3Jlcy0+cGFyZW50ID0gcmVz
LT5wYXJlbnQ7DQo+ID4gKwkJCQluZXdfcmVzLT5zaWJsaW5nID0gcmVzLT5zaWJsaW5nOw0KPiA+
ICsJCQkJbmV3X3Jlcy0+Y2hpbGQgPSBOVUxMOw0KPiA+ICsNCj4gPiArCQkJCXJldCA9IF9fYWRq
dXN0X3Jlc291cmNlKHJlcywgcmVzLT5zdGFydCwNCj4gPiArCQkJCQkJCW5ld19zdGFydCAtIHJl
cy0+c3RhcnQpOw0KPiA+ICsJCQkJaWYgKHJldCkNCj4gPiArCQkJCQlicmVhazsNCj4gPiArCQkJ
CXJlcy0+c2libGluZyA9IG5ld19yZXM7DQo+ID4gKwkJCQluZXdfcmVzID0gTlVMTDsNCj4gPiAr
CQkJfQ0KPiA+ICAJCX0gZWxzZSB7DQo+ID4gLQkJCS8qIHNwbGl0IGludG8gdHdvIGVudHJpZXMg
Ki8NCj4gPiAtCQkJaWYgKCFuZXdfcmVzKSB7DQo+ID4gLQkJCQlyZXQgPSAtRU5PTUVNOw0KPiA+
IC0JCQkJYnJlYWs7DQo+ID4gKwkJCWlmIChyZXMtPnN0YXJ0IDwgbmV3X3N0YXJ0KSB7DQo+ID4g
KwkJCQkvKiBhZGp1c3QgdGhlIGVuZCAqLw0KPiA+ICsJCQkJcmV0ID0gX19hZGp1c3RfcmVzb3Vy
Y2UocmVzLCByZXMtPnN0YXJ0LA0KPiA+ICsJCQkJCQkJbmV3X3N0YXJ0IC0gcmVzLT5zdGFydCk7
DQo+ID4gKwkJCQluZXdfc3RhcnQgPSByZXMtPmVuZCsxOw0KPiA+ICsJCQkJcCA9ICZyZXMtPnNp
Ymxpbmc7DQo+ID4gKwkJCX0gZWxzZSB7DQo+ID4gKwkJCQluZXdfc3RhcnQgPSByZXMtPmVuZCsx
Ow0KPiA+ICsJCQkJKnAgPSByZXMtPnNpYmxpbmc7DQo+ID4gKwkJCQlmcmVlX3Jlc291cmNlKHJl
cyk7DQo+ID4gKwkJCQlyZXQgPSAwOw0KPiA+ICAJCQl9DQo+ID4gLQkJCW5ld19yZXMtPm5hbWUg
PSByZXMtPm5hbWU7DQo+ID4gLQkJCW5ld19yZXMtPnN0YXJ0ID0gZW5kICsgMTsNCj4gPiAtCQkJ
bmV3X3Jlcy0+ZW5kID0gcmVzLT5lbmQ7DQo+ID4gLQkJCW5ld19yZXMtPmZsYWdzID0gcmVzLT5m
bGFnczsNCj4gPiAtCQkJbmV3X3Jlcy0+ZGVzYyA9IHJlcy0+ZGVzYzsNCj4gPiAtCQkJbmV3X3Jl
cy0+cGFyZW50ID0gcmVzLT5wYXJlbnQ7DQo+ID4gLQkJCW5ld19yZXMtPnNpYmxpbmcgPSByZXMt
PnNpYmxpbmc7DQo+ID4gLQkJCW5ld19yZXMtPmNoaWxkID0gTlVMTDsNCj4gPiAtDQo+ID4gLQkJ
CXJldCA9IF9fYWRqdXN0X3Jlc291cmNlKHJlcywgcmVzLT5zdGFydCwNCj4gPiAtCQkJCQkJc3Rh
cnQgLSByZXMtPnN0YXJ0KTsNCj4gPiAtCQkJaWYgKHJldCkNCj4gPiAtCQkJCWJyZWFrOw0KPiA+
IC0JCQlyZXMtPnNpYmxpbmcgPSBuZXdfcmVzOw0KPiA+IC0JCQluZXdfcmVzID0gTlVMTDsNCj4g
PiArCQkJaWYgKHJlcy0+ZW5kIDwgZW5kKQ0KPiA+ICsJCQkJY29udGludWU7DQo+ID4gIAkJfQ0K
PiA+IC0NCj4gPiAgCQlicmVhazsNCj4gPiAgCX0NCj4gPg0KPiA+IC0tDQo+ID4gMi4xMi4zDQo+
ID4NCg0K
