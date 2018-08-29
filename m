Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19151C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5DEA205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="PntclEX7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5DEA205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbeH3Ank (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:43:40 -0400
Received: from mail-eopbgr730070.outbound.protection.outlook.com ([40.107.73.70]:29472
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727743AbeH3Anj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbj89//1pSDHDFDmXq2ZjgggZvA3aPCY3Pp00IrT7S4=;
 b=PntclEX7f2qYSNGx87/5zbP51IMbpWen9VqRJkU/Idl/QjhlKQvFCzm0yHrS6OK1lluU+HsLOOy0m0lmM3B+1uPunoY2rSTJ+fSzhrC5c2yTcfHwylRnGjuhgbjXu16A96HDkkZCQpjPfIIetO/PDrHoQ8GizZKe5Zl905cQCZI=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4520.namprd05.prod.outlook.com (52.135.203.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.12; Wed, 29 Aug 2018 20:44:48 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::911b:395c:ce8a:38c3]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::911b:395c:ce8a:38c3%3]) with mapi id 15.20.1101.007; Wed, 29 Aug 2018
 20:44:48 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
CC:     Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH 1/6] x86/alternative: assert text_mutex is taken
Thread-Topic: [RFC PATCH 1/6] x86/alternative: assert text_mutex is taken
Thread-Index: AQHUP3AveUOJQxVhiEqJKH9IYmSgsaTWblgAgACJiICAAChdgIAACkwAgAAI04A=
Date:   Wed, 29 Aug 2018 20:44:47 +0000
Message-ID: <58345C1F-8FF3-4F49-AF2F-B4789DF50CC7@vmware.com>
References: <20180829081147.184610-1-namit@vmware.com>
 <20180829081147.184610-2-namit@vmware.com>
 <20180829175936.fb27b3bf13da819a9a971f07@kernel.org>
 <1F547CEE-B5D9-42A0-8093-2C5555BACE26@vmware.com>
 <2694AE6F-2212-46C6-A570-6BAF265364FB@vmware.com>
 <20180829201309.GA7142@linux.intel.com>
In-Reply-To: <20180829201309.GA7142@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4520;20:X0P4eyzwFxxlETPxzDzVwILm4fzliE9aWwnpinulAuB/6+gXUMqni5bZZCahLsvN0juQDnhD7Fc9AgSfQ0OMZGaB53EBI8kxXdQagVZ3YCdGNX8Jsfa7EaHd2iU99bOewHsxgbWjQLK916InWeQafHFH7Rwfp/nrrPBkP1gOBtw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0bb45ee9-31ad-42fe-cdcb-08d60df04297
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4520;
x-ms-traffictypediagnostic: BYAPR05MB4520:
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB45203B19EFF1FD49395D7F8DD0090@BYAPR05MB4520.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699016);SRVR:BYAPR05MB4520;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4520;
x-forefront-prvs: 077929D941
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(39860400002)(346002)(376002)(199004)(189003)(99286004)(11346002)(446003)(54906003)(81166006)(81156014)(66066001)(68736007)(3846002)(6116002)(36756003)(6916009)(476003)(486006)(6512007)(86362001)(93886005)(316002)(25786009)(6506007)(2616005)(76176011)(4326008)(102836004)(6246003)(26005)(53936002)(186003)(5660300001)(14444005)(305945005)(7416002)(33656002)(7736002)(217873002)(8676002)(229853002)(97736004)(6436002)(256004)(5250100002)(6486002)(2900100001)(106356001)(105586002)(478600001)(8936002)(2906002)(82746002)(14454004)(83716003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4520;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8GEn7msVLanU7f2k7+75tN7WBV80NhuF6ArpVAs6Tb2TCLqJ+pbnFmb8zZZLf7r580Cuf9WQJcxKWe6vCjMuP5Nu8zUCdRblAc60X5ATyr4LHejrR7rvqsWYfoNezAAgbhHt/tJ5e3kpobv5p8nxQpnW5d3nprv7zvPElt2BC1iiSu0QGkqbuPZUTHBws4RNNk0EY+LoMUgJJho4Afc4zWHS2SlS99Qeqh3KRWQ30c7eX3qR2dmLSkwqj/hkjoSPlmdaC3Ycz+3v83KvwpKhvblNplbc2jts9Y6bbGqPWEdsrtP7esRcTTnla6E/aFAB7NoxGcIYaNH86vIiMPrjSW495Ic9iE33y21KZF3tA04=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <85D59516B8C2B74CB6642023BF9AFF72@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb45ee9-31ad-42fe-cdcb-08d60df04297
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2018 20:44:47.7716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4520
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgMToxMyBQTSwgU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2Vhbi5qLmNocmlzdG9waGVyc29uQGlu
dGVsLmNvbT4gd3JvdGU6DQoNCj4gT24gV2VkLCBBdWcgMjksIDIwMTggYXQgMDc6MzY6MjJQTSAr
MDAwMCwgTmFkYXYgQW1pdCB3cm90ZToNCj4+IGF0IDEwOjExIEFNLCBOYWRhdiBBbWl0IDxuYW1p
dEB2bXdhcmUuY29tPiB3cm90ZToNCj4+IA0KPj4+IGF0IDE6NTkgQU0sIE1hc2FtaSBIaXJhbWF0
c3UgPG1oaXJhbWF0QGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+IA0KPj4+PiBPbiBXZWQsIDI5IEF1
ZyAyMDE4IDAxOjExOjQyIC0wNzAwDQo+Pj4+IE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+
IHdyb3RlOg0KPj4+PiANCj4+Pj4+IFVzZSBsb2NrZGVwIHRvIGVuc3VyZSB0aGF0IHRleHRfbXV0
ZXggaXMgdGFrZW4gd2hlbiB0ZXh0X3Bva2UoKSBpcw0KPj4+Pj4gY2FsbGVkLg0KPj4+Pj4gDQo+
Pj4+PiBBY3R1YWxseSBpdCBpcyBub3QgYWx3YXlzIHRha2VuLCBzcGVjaWZpY2FsbHkgd2hlbiBp
dCBpcyBjYWxsZWQgYnkga2dkYiwNCj4+Pj4+IHNvIHRha2UgdGhlIGxvY2sgaW4gdGhlc2UgY2Fz
ZXMuDQo+Pj4+IA0KPj4+PiBDYW4gd2UgcmVhbGx5IHRha2UgYSBtdXRleCBpbiBrZ2RiIGNvbnRl
eHQ/DQo+Pj4+IA0KPj4+PiBrZ2RiX2FyY2hfcmVtb3ZlX2JyZWFrcG9pbnQNCj4+Pj4gPC0gZGJn
X2RlYWN0aXZhdGVfc3dfYnJlYWtwb2ludHMNCj4+Pj4gIDwtIGtnZGJfcmVlbnRlcl9jaGVjaw0K
Pj4+PiAgICAgPC0ga2dkYl9oYW5kbGVfZXhjZXB0aW9uDQo+Pj4+ICAgICAgICA8LSBfX2tnZGJf
bm90aWZ5DQo+Pj4+ICAgICAgICAgIDwtIGtnZGJfbGxfdHJhcA0KPj4+PiAgICAgICAgICAgIDwt
IGRvX2ludDMNCj4+Pj4gICAgICAgICAgPC0ga2dkYl9ub3RpZnkNCj4+Pj4gICAgICAgICAgICA8
LSBkaWUgbm90aWZpZXINCj4+Pj4gDQo+Pj4+IGtnZGJfYXJjaF9zZXRfYnJlYWtwb2ludA0KPj4+
PiA8LSBkYmdfYWN0aXZhdGVfc3dfYnJlYWtwb2ludHMNCj4+Pj4gIDwtIGtnZGJfcmVlbnRlcl9j
aGVjaw0KPj4+PiAgICAgPC0ga2dkYl9oYW5kbGVfZXhjZXB0aW9uDQo+Pj4+ICAgICAgICAgLi4u
DQo+Pj4+IA0KPj4+PiBCb3RoIHNlZW1zIGNhbGxlZCBpbiBleGNlcHRpb24gY29udGV4dCwgc28g
d2UgY2FuIG5vdCB0YWtlIGEgbXV0ZXggbG9jay4NCj4+Pj4gSSB0aGluayBrZ2RiIG5lZWRzIGEg
c3BlY2lhbCBwYXRoLg0KPj4+IA0KPj4+IFlvdSBhcmUgY29ycmVjdCwgYnV0IEkgZG9u4oCZdCB3
YW50IGEgc3BlY2lhbCBwYXRoLiBQcmVzdW1hYmx5IHRleHRfbXV0ZXggaXMNCj4+PiBndWFyYW50
ZWVkIG5vdCB0byBiZSB0YWtlbiBhY2NvcmRpbmcgdG8gdGhlIGNvZGUuDQo+Pj4gDQo+Pj4gU28g
SSBndWVzcyB0aGUgb25seSBjb25jZXJuIGlzIGxvY2tkZXAuIERvIHlvdSBzZWUgYW55IHByb2Js
ZW0gaWYgSSBjaGFuZ2UNCj4+PiBtdXRleF9sb2NrKCkgaW50byBtdXRleF90cnlsb2NrKCk/IEl0
IHNob3VsZCBhbHdheXMgc3VjY2VlZCwgYW5kIEkgY2FuIGFkZCBhDQo+Pj4gd2FybmluZyBhbmQg
YSBmYWlsdXJlIHBhdGggaWYgaXQgZmFpbHMgZm9yIHNvbWUgcmVhc29uLg0KPj4gDQo+PiBFcnIu
LiBUaGlzIHdpbGwgbm90IHdvcmsuIEkgdGhpbmsgSSB3aWxsIGRyb3AgdGhpcyBwYXRjaCwgc2lu
Y2UgSSBjYW5ub3QNCj4+IGZpbmQgYSBwcm9wZXIgeWV0IHNpbXBsZSBhc3NlcnRpb24uIENyZWF0
aW5nIHNwZWNpYWwgcGF0aCBqdXN0IGZvciB0aGUNCj4+IGFzc2VydGlvbiBzZWVtcyB3cm9uZy4N
Cj4gDQo+IEl0J3MgcHJvYmFibHkgd29ydGggZXhwYW5kaW5nIHRoZSBjb21tZW50IGZvciB0ZXh0
X3Bva2UoKSB0byBjYWxsIG91dA0KPiB0aGUga2dkYiBjYXNlIGFuZCByZWZlcmVuY2Uga2dkYl9h
cmNoX3tzZXQscmVtb3ZlfV9icmVha3BvaW50KCksIHdob3NlDQo+IGNvZGUgYW5kIGNvbW1lbnRz
IG1ha2UgaXQgZXhwbGljaXRseSBjbGVhciB3aHkgaXRzIHNhZmUgZm9yIHRoZW0gdG8NCj4gY2Fs
bCB0ZXh0X3Bva2UoKSB3aXRob3V0IGFjcXVpcmluZyB0aGUgbG9jay4gIE1pZ2h0IHByZXZlbnQg
c29tZW9uZQ0KPiBmcm9tIGdvaW5nIGRvd24gdGhpcyBwYXRoIGFnYWluIGluIHRoZSBmdXR1cmUu
DQoNCkkgdGhvdWdodCB0aGF0IHRoZSB3aG9sZSBwb2ludCBvZiB0aGUgcGF0Y2ggd2FzIHRvIGF2
b2lkIGNvbW1lbnRzLCBhbmQNCmluc3RlYWQgZW5mb3JjZSB0aGUgcmlnaHQgYmVoYXZpb3IuIEkg
ZG9u4oCZdCB1bmRlcnN0YW5kIHdlbGwgZW5vdWdoIGtnZGINCmNvZGUsIHNvIEkgY2Fubm90IGF0
dGVzdCBpdCBkb2VzIHRoZSByaWdodCB0aGluZy4gV2hhdCBoYXBwZW5zIGlmDQprZ2RiX2RvX3Jv
dW5kdXA9PTA/DQoNCg0K
