Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FDCC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 05:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF59C2073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 05:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="HYnInGnX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF59C2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbeH3JXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 05:23:31 -0400
Received: from mail-eopbgr680077.outbound.protection.outlook.com ([40.107.68.77]:49072
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725836AbeH3JXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 05:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5wiB5OkBavJa96KTgls/tz724UZemo+d7FYAoFj5o0=;
 b=HYnInGnXagoMWoW1J7Q6NbXqtYn/DYkwkX0uFIR23krVbNT2rY1RQ4yPMRSbmbK7rmJPLu0qdI8bW/rbWTerH85yJZCWJEWZldarZakWp5yBWXgWePugX4dkjgUQ7nrqzskNCOXxr3wK4QZgzuWlpWmcF+NHjYaFSndgVleqZC0=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4744.namprd05.prod.outlook.com (52.135.233.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Thu, 30 Aug 2018 05:23:01 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::911b:395c:ce8a:38c3]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::911b:395c:ce8a:38c3%3]) with mapi id 15.20.1101.007; Thu, 30 Aug 2018
 05:23:01 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>
Subject: Re: [RFC PATCH 1/6] x86/alternative: assert text_mutex is taken
Thread-Topic: [RFC PATCH 1/6] x86/alternative: assert text_mutex is taken
Thread-Index: AQHUP3AveUOJQxVhiEqJKH9IYmSgsaTWblgAgACJiICAAChdgIAACkwAgAAI04CAAARKAIAAW0iAgAAxGoA=
Date:   Thu, 30 Aug 2018 05:23:01 +0000
Message-ID: <A729271C-5646-470D-B200-7C552EB18FC8@vmware.com>
References: <20180829081147.184610-1-namit@vmware.com>
 <20180829081147.184610-2-namit@vmware.com>
 <20180829175936.fb27b3bf13da819a9a971f07@kernel.org>
 <1F547CEE-B5D9-42A0-8093-2C5555BACE26@vmware.com>
 <2694AE6F-2212-46C6-A570-6BAF265364FB@vmware.com>
 <20180829201309.GA7142@linux.intel.com>
 <58345C1F-8FF3-4F49-AF2F-B4789DF50CC7@vmware.com>
 <20180829210006.GA7166@linux.intel.com>
 <20180830112649.4b774f401d99a8b98e12008c@kernel.org>
In-Reply-To: <20180830112649.4b774f401d99a8b98e12008c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:647:4580:b719:15d3:5cd8:3ca7:51f0]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4744;20:gsDDoHbtcgfyHNCPmyPOQymimw7amtGHwYQW1ibBkTEcRp39n2g07c39NkTiV4Kd39Cv3ypO4RTJ71WA74W/SuAliYieNLygbNBUqEwVpHS+dG8c0fGIREyY4WyIzeIAzxOshG5ajvcxo2AbfbCHsDaaWJAGM4Mue9mJl4nKEKE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d78c8bc0-f4f5-4f25-eb46-08d60e38a7b7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4744;
x-ms-traffictypediagnostic: BYAPR05MB4744:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB474499F6B00C0C79FE0D8E0ED0080@BYAPR05MB4744.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231340)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:BYAPR05MB4744;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4744;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(366004)(346002)(376002)(39860400002)(396003)(136003)(52314003)(43544003)(199004)(189003)(14444005)(256004)(8936002)(2616005)(476003)(99286004)(93886005)(33656002)(54906003)(4326008)(81156014)(2906002)(6246003)(36756003)(11346002)(81166006)(46003)(6512007)(105586002)(53936002)(97736004)(68736007)(8676002)(446003)(2900100001)(229853002)(486006)(76176011)(106356001)(5250100002)(6486002)(6436002)(5660300001)(14454004)(82746002)(6116002)(25786009)(102836004)(305945005)(7736002)(316002)(217873002)(86362001)(478600001)(186003)(6506007)(7416002)(83716003)(110136005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4744;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KjEvxAxpCxmyGCCUGt8XtIJ4RynK5+H1bh2ZH+OxRf2DUAPID199w205CSTjSvGoIc4VyJ4AUyzB5ljz9Iucxf7tmXsqsKmpBwF7u/jyLHQKWNyfGnRDWrxFu+H84oqXRhuyCgwAutUtBw6pK/yHu9sZTFNkYOrjgimSeSi0LOyzGuX0MpuXuB3vI9YeuvfK4ZoXii0H/S7wqmgkCTJW8s9RpB1CK0FoP79eP4oMfQg8zQ4AyuXsLJypDMilBylexzHcWyNXsVXB8bpvBR7+uKiM4te5PYY2g82qLL08ikRg2OW83rp1wM+QdmopKZc4UKxlauehXtdI64OIcmUB/XV3Lu3OLSWs9uOkQp6rBak=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8A06A81AAD89B41863DAE788D505729@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d78c8bc0-f4f5-4f25-eb46-08d60e38a7b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 05:23:01.2747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4744
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgNzoyNiBQTSwgTWFzYW1pIEhpcmFtYXRzdSA8bWhpcmFtYXRAa2VybmVsLm9yZz4gd3JvdGU6
DQoNCj4gT24gV2VkLCAyOSBBdWcgMjAxOCAxNDowMDowNiAtMDcwMA0KPiBTZWFuIENocmlzdG9w
aGVyc29uIDxzZWFuLmouY2hyaXN0b3BoZXJzb25AaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+PiBP
biBXZWQsIEF1ZyAyOSwgMjAxOCBhdCAwODo0NDo0N1BNICswMDAwLCBOYWRhdiBBbWl0IHdyb3Rl
Og0KPj4+IGF0IDE6MTMgUE0sIFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW4uai5jaHJpc3RvcGhl
cnNvbkBpbnRlbC5jb20+IHdyb3RlOg0KPj4+IA0KPj4+PiBPbiBXZWQsIEF1ZyAyOSwgMjAxOCBh
dCAwNzozNjoyMlBNICswMDAwLCBOYWRhdiBBbWl0IHdyb3RlOg0KPj4+Pj4gYXQgMTA6MTEgQU0s
IE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+IHdyb3RlOg0KPj4+Pj4gDQo+Pj4+Pj4gYXQg
MTo1OSBBTSwgTWFzYW1pIEhpcmFtYXRzdSA8bWhpcmFtYXRAa2VybmVsLm9yZz4gd3JvdGU6DQo+
Pj4+Pj4gDQo+Pj4+Pj4+IE9uIFdlZCwgMjkgQXVnIDIwMTggMDE6MTE6NDIgLTA3MDANCj4+Pj4+
Pj4gTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJlLmNvbT4gd3JvdGU6DQo+Pj4+Pj4+IA0KPj4+Pj4+
Pj4gVXNlIGxvY2tkZXAgdG8gZW5zdXJlIHRoYXQgdGV4dF9tdXRleCBpcyB0YWtlbiB3aGVuIHRl
eHRfcG9rZSgpIGlzDQo+Pj4+Pj4+PiBjYWxsZWQuDQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+IEFjdHVh
bGx5IGl0IGlzIG5vdCBhbHdheXMgdGFrZW4sIHNwZWNpZmljYWxseSB3aGVuIGl0IGlzIGNhbGxl
ZCBieSBrZ2RiLA0KPj4+Pj4+Pj4gc28gdGFrZSB0aGUgbG9jayBpbiB0aGVzZSBjYXNlcy4NCj4+
Pj4+Pj4gDQo+Pj4+Pj4+IENhbiB3ZSByZWFsbHkgdGFrZSBhIG11dGV4IGluIGtnZGIgY29udGV4
dD8NCj4+Pj4+Pj4gDQo+Pj4+Pj4+IGtnZGJfYXJjaF9yZW1vdmVfYnJlYWtwb2ludA0KPj4+Pj4+
PiA8LSBkYmdfZGVhY3RpdmF0ZV9zd19icmVha3BvaW50cw0KPj4+Pj4+PiA8LSBrZ2RiX3JlZW50
ZXJfY2hlY2sNCj4+Pj4+Pj4gICAgPC0ga2dkYl9oYW5kbGVfZXhjZXB0aW9uDQo+Pj4+Pj4+ICAg
ICAgIDwtIF9fa2dkYl9ub3RpZnkNCj4+Pj4+Pj4gICAgICAgICA8LSBrZ2RiX2xsX3RyYXANCj4+
Pj4+Pj4gICAgICAgICAgIDwtIGRvX2ludDMNCj4+Pj4+Pj4gICAgICAgICA8LSBrZ2RiX25vdGlm
eQ0KPj4+Pj4+PiAgICAgICAgICAgPC0gZGllIG5vdGlmaWVyDQo+Pj4+Pj4+IA0KPj4+Pj4+PiBr
Z2RiX2FyY2hfc2V0X2JyZWFrcG9pbnQNCj4+Pj4+Pj4gPC0gZGJnX2FjdGl2YXRlX3N3X2JyZWFr
cG9pbnRzDQo+Pj4+Pj4+IDwtIGtnZGJfcmVlbnRlcl9jaGVjaw0KPj4+Pj4+PiAgICA8LSBrZ2Ri
X2hhbmRsZV9leGNlcHRpb24NCj4+Pj4+Pj4gICAgICAgIC4uLg0KPj4+Pj4+PiANCj4+Pj4+Pj4g
Qm90aCBzZWVtcyBjYWxsZWQgaW4gZXhjZXB0aW9uIGNvbnRleHQsIHNvIHdlIGNhbiBub3QgdGFr
ZSBhIG11dGV4IGxvY2suDQo+Pj4+Pj4+IEkgdGhpbmsga2dkYiBuZWVkcyBhIHNwZWNpYWwgcGF0
aC4NCj4+Pj4+PiANCj4+Pj4+PiBZb3UgYXJlIGNvcnJlY3QsIGJ1dCBJIGRvbuKAmXQgd2FudCBh
IHNwZWNpYWwgcGF0aC4gUHJlc3VtYWJseSB0ZXh0X211dGV4IGlzDQo+Pj4+Pj4gZ3VhcmFudGVl
ZCBub3QgdG8gYmUgdGFrZW4gYWNjb3JkaW5nIHRvIHRoZSBjb2RlLg0KPj4+Pj4+IA0KPj4+Pj4+
IFNvIEkgZ3Vlc3MgdGhlIG9ubHkgY29uY2VybiBpcyBsb2NrZGVwLiBEbyB5b3Ugc2VlIGFueSBw
cm9ibGVtIGlmIEkgY2hhbmdlDQo+Pj4+Pj4gbXV0ZXhfbG9jaygpIGludG8gbXV0ZXhfdHJ5bG9j
aygpPyBJdCBzaG91bGQgYWx3YXlzIHN1Y2NlZWQsIGFuZCBJIGNhbiBhZGQgYQ0KPj4+Pj4+IHdh
cm5pbmcgYW5kIGEgZmFpbHVyZSBwYXRoIGlmIGl0IGZhaWxzIGZvciBzb21lIHJlYXNvbi4NCj4+
Pj4+IA0KPj4+Pj4gRXJyLi4gVGhpcyB3aWxsIG5vdCB3b3JrLiBJIHRoaW5rIEkgd2lsbCBkcm9w
IHRoaXMgcGF0Y2gsIHNpbmNlIEkgY2Fubm90DQo+Pj4+PiBmaW5kIGEgcHJvcGVyIHlldCBzaW1w
bGUgYXNzZXJ0aW9uLiBDcmVhdGluZyBzcGVjaWFsIHBhdGgganVzdCBmb3IgdGhlDQo+Pj4+PiBh
c3NlcnRpb24gc2VlbXMgd3JvbmcuDQo+Pj4+IA0KPj4+PiBJdCdzIHByb2JhYmx5IHdvcnRoIGV4
cGFuZGluZyB0aGUgY29tbWVudCBmb3IgdGV4dF9wb2tlKCkgdG8gY2FsbCBvdXQNCj4+Pj4gdGhl
IGtnZGIgY2FzZSBhbmQgcmVmZXJlbmNlIGtnZGJfYXJjaF97c2V0LHJlbW92ZX1fYnJlYWtwb2lu
dCgpLCB3aG9zZQ0KPj4+PiBjb2RlIGFuZCBjb21tZW50cyBtYWtlIGl0IGV4cGxpY2l0bHkgY2xl
YXIgd2h5IGl0cyBzYWZlIGZvciB0aGVtIHRvDQo+Pj4+IGNhbGwgdGV4dF9wb2tlKCkgd2l0aG91
dCBhY3F1aXJpbmcgdGhlIGxvY2suICBNaWdodCBwcmV2ZW50IHNvbWVvbmUNCj4+Pj4gZnJvbSBn
b2luZyBkb3duIHRoaXMgcGF0aCBhZ2FpbiBpbiB0aGUgZnV0dXJlLg0KPj4+IA0KPj4+IEkgdGhv
dWdodCB0aGF0IHRoZSB3aG9sZSBwb2ludCBvZiB0aGUgcGF0Y2ggd2FzIHRvIGF2b2lkIGNvbW1l
bnRzLCBhbmQNCj4+PiBpbnN0ZWFkIGVuZm9yY2UgdGhlIHJpZ2h0IGJlaGF2aW9yLiBJIGRvbuKA
mXQgdW5kZXJzdGFuZCB3ZWxsIGVub3VnaCBrZ2RiDQo+Pj4gY29kZSwgc28gSSBjYW5ub3QgYXR0
ZXN0IGl0IGRvZXMgdGhlIHJpZ2h0IHRoaW5nLiBXaGF0IGhhcHBlbnMgaWYNCj4+PiBrZ2RiX2Rv
X3JvdW5kdXA9PTA/DQo+PiANCj4+IEFzIGlzLCB0aGUgY29tbWVudCBpcyB3cm9uZyBiZWNhdXNl
IHRoZXJlIGFyZSBvYnZpb3VzbHkgY2FzZXMgd2hlcmUNCj4+IHRleHRfcG9rZSgpIGlzIGNhbGxl
ZCB3aXRob3V0IHRleHRfbXV0ZXggYmVpbmcgaGVsZC4gIEkgY2FuJ3QgYXR0ZXN0DQo+PiB0byB0
aGUga2dkYiBjb2RlIGVpdGhlci4gIE15IHRob3VnaHQgd2FzIHRvIGRvY3VtZW50IHRoZSBleGNl
cHRpb24gc28NCj4+IHRoYXQgaWYgc29tZW9uZSBkb2VzIHdhbnQgdG8gdHJ5IGFuZCBlbmZvcmNl
IHRoZSByaWdodCBiZWhhdmlvciB0aGV5DQo+PiBjYW4gZGl2ZSByaWdodCBpbnRvIHRoZSBwcm9i
bGVtIGluc3RlYWQgb2YgaGF2aW5nIHRvIGxlYXJuIG9mIHRoZSBrZ2RiDQo+PiBnb3RjaGEgdGhl
IGhhcmQgd2F5LiAgTWF5YmUgYSBGSVhNRSBpcyB0aGUgcmlnaHQgYXBwcm9hY2g/DQo+IA0KPiBO
bywga2dkYiBlbnN1cmVzIHRoYXQgdGhlIHRleHRfbXV0ZXggaGFzIG5vdCBiZWVuIGhlbGQgcmln
aHQgYmVmb3JlDQo+IGNhbGxpbmcgdGV4dF9wb2tlLiBTbyB0aGV5IGFsc28gdGFrZSBjYXJlIHRo
ZSB0ZXh0X211dGV4LiBJIGd1ZXNzDQo+IGtnZGJfYXJjaF97c2V0LHJlbW92ZX1fYnJlYWtwb2lu
dCgpIGlzIHN1cHBvc2VkIHRvIGJlIHJ1biB1bmRlcg0KPiBhIHNwZWNpYWwgY2lyY3Vtc3RhbmNl
LCBsaWtlIHN0b3BwaW5nIGFsbCBvdGhlciB0aHJlYWRzL2NvcmVzLg0KPiBJbiB0aGF0IGNhc2Us
IHdlIGNhbiBqdXN0IGNoZWNrIHRoZSB0ZXh0X211dGV4IGlzIG5vdCBsb2NrZWQuDQoNCkkgYXNz
dW1lZCBzbyB0b28sIGJ1dCBhZnRlciBsb29raW5nIGF0IHRoZSBjb2RlLCBJIGFtIG5vdCBzdXJl
IHRoYXQgdGhpcyBpcw0KdGhlIGNhc2Ugd2hlbiBnZGJfZG9fcm91bmR1cD09MC4NCg0KPiBBbnl3
YXksIGtnZGIgaXMgYSB2ZXJ5IHJhcmUgY291cm5lciBjYXNlLiBJIHRoaW5rIGlmIENPTkZJR19L
R0RCIGlzDQo+IGVuYWJsZWQsIGxvY2tkZXAgYW5kIGFueSBhc3NlcnRpb24gc2hvdWxkIGJlIGRp
c2FibGVkLCBzaW5jZSBrZ2RiDQo+IGNhbiB0d2VhayBhbnl0aGluZyBpbiB0aGUga2VybmVsIHdp
dGggdW5leHBlY3RlZCB3YXlzLi4uDQoNCkNhbGwgbWUgbGF6eSwgYnV0IEkgcmVhbGx5IGRvIG5v
dCB3YW50IHRvIGRlYnVnIHN5emthbGxlciBmYWlsdXJlcyBkdWUgdG8NCnRoaXMgaXNzdWUgKG5v
dyBvciBpbiB0aGUgZnV0dXJlKS4gSWYgdGhlIGFzc2VydGlvbiBpcyBrbm93biB0byBiZQ0KaW5j
b3JyZWN0LCBldmVuIGluIGEgY29ybmVyIGNhc2UsIEkgc2VlIG5vIHJlYXNvbiB0byBoYXZlIGl0
IGFuZCBJIGNlcnRhaW5seQ0KZG8gbm90IHdhbnQgdG8gYmUgdGhlIG9uZSB0aGF0IGFkZGVkIGl0
4oCmDQoNCg==
