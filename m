Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14B7C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E852064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="CMKqNPEu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80E852064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbeH2Xer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 19:34:47 -0400
Received: from mail-by2nam03on0045.outbound.protection.outlook.com ([104.47.42.45]:4640
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727399AbeH2Xer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 19:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqTrkh2iPA6FzghHQsQzD7u4EG1NXT8k6jlN+wIRlgM=;
 b=CMKqNPEuA/6kwkeyoTISicpOGaInYQNw5QAWffTFCU0eogI8/s6D+AVUtRNJXW8t88h4O8nkJTPzy6vnxo/Mg0L2FZwu1AVgu5/qqHWC96Vfr70iC8qpho4Sn+A7LNRdJjl5YysECqm2pTINrLmyVH0ERhRXG4GbmcjglcMQ9jg=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB3960.namprd05.prod.outlook.com (52.135.196.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.12; Wed, 29 Aug 2018 19:36:22 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::911b:395c:ce8a:38c3]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::911b:395c:ce8a:38c3%3]) with mapi id 15.20.1101.007; Wed, 29 Aug 2018
 19:36:22 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH 1/6] x86/alternative: assert text_mutex is taken
Thread-Topic: [RFC PATCH 1/6] x86/alternative: assert text_mutex is taken
Thread-Index: AQHUP3AveUOJQxVhiEqJKH9IYmSgsaTWblgAgACJiICAAChdgA==
Date:   Wed, 29 Aug 2018 19:36:22 +0000
Message-ID: <2694AE6F-2212-46C6-A570-6BAF265364FB@vmware.com>
References: <20180829081147.184610-1-namit@vmware.com>
 <20180829081147.184610-2-namit@vmware.com>
 <20180829175936.fb27b3bf13da819a9a971f07@kernel.org>
 <1F547CEE-B5D9-42A0-8093-2C5555BACE26@vmware.com>
In-Reply-To: <1F547CEE-B5D9-42A0-8093-2C5555BACE26@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB3960;20:UHzUM5qEeZhWlGqmGZZDSgjNaj0mo4uLMhGLZwqpNfjkckTeNxRVBv9DPCMm2IfmiqX2dN/R2gqsADaeATY4cHQJBZnIjBOgBNPmn/dXWolxZI0XPSc0Q3DPfT/ZM6H6c82arkODuEwEEyEwVGfWoJ2WfASFOhal6OvYAoFvPBc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b916362c-e49f-4020-60ca-08d60de6b37a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB3960;
x-ms-traffictypediagnostic: BYAPR05MB3960:
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB3960A0C3CC500ACB79C6322AD0090@BYAPR05MB3960.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:BYAPR05MB3960;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB3960;
x-forefront-prvs: 077929D941
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(396003)(376002)(39860400002)(199004)(189003)(14444005)(2906002)(54906003)(2900100001)(229853002)(99286004)(76176011)(6436002)(6486002)(2616005)(6246003)(305945005)(446003)(7736002)(25786009)(4326008)(5250100002)(486006)(8676002)(81156014)(68736007)(83716003)(93886005)(82746002)(81166006)(8936002)(11346002)(6916009)(476003)(6512007)(5660300001)(53936002)(97736004)(26005)(186003)(102836004)(106356001)(316002)(105586002)(6116002)(3846002)(33656002)(6506007)(14454004)(256004)(217873002)(36756003)(86362001)(66066001)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB3960;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +ChtVGe5Xx2qVPwUHQFA7BpSpbHDL+B8bFHKH7woS8rT/kasLpkIIi7lUGvp9da9lMGOAAxjfAoEceOfz+gXevhUsl19omywvrq1guaYkTpyM5PxLZI4yN/Wkxe7q8Ac4dCGIBEZrOfnTuUUNqVcntsHI9IO51lIVf2m+j3alAViAZ7RT7PFJxBWRlT+XAYeLMjGXKQyRpLHHurXEPODAoM27/OGSwIBSCz7GabXwm2dGweUwamFdH/UdovKVBF2gvillYYFYZK03TOmA96UhuG+yUJZX6Cv30XHM1AwRDiCmWY8CJJ6oQqoXaWJLglOSz9DDXoDKVOTFgVn1/hkqGlfVLgi91wLQ52D2LuUs5U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5EB384EFAAD5E143B8B5DF9F349AB8AB@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b916362c-e49f-4020-60ca-08d60de6b37a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2018 19:36:22.3034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB3960
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgMTA6MTEgQU0sIE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+IHdyb3RlOg0KDQo+IGF0
IDE6NTkgQU0sIE1hc2FtaSBIaXJhbWF0c3UgPG1oaXJhbWF0QGtlcm5lbC5vcmc+IHdyb3RlOg0K
PiANCj4+IE9uIFdlZCwgMjkgQXVnIDIwMTggMDE6MTE6NDIgLTA3MDANCj4+IE5hZGF2IEFtaXQg
PG5hbWl0QHZtd2FyZS5jb20+IHdyb3RlOg0KPj4gDQo+Pj4gVXNlIGxvY2tkZXAgdG8gZW5zdXJl
IHRoYXQgdGV4dF9tdXRleCBpcyB0YWtlbiB3aGVuIHRleHRfcG9rZSgpIGlzDQo+Pj4gY2FsbGVk
Lg0KPj4+IA0KPj4+IEFjdHVhbGx5IGl0IGlzIG5vdCBhbHdheXMgdGFrZW4sIHNwZWNpZmljYWxs
eSB3aGVuIGl0IGlzIGNhbGxlZCBieSBrZ2RiLA0KPj4+IHNvIHRha2UgdGhlIGxvY2sgaW4gdGhl
c2UgY2FzZXMuDQo+PiANCj4+IENhbiB3ZSByZWFsbHkgdGFrZSBhIG11dGV4IGluIGtnZGIgY29u
dGV4dD8NCj4+IA0KPj4ga2dkYl9hcmNoX3JlbW92ZV9icmVha3BvaW50DQo+PiA8LSBkYmdfZGVh
Y3RpdmF0ZV9zd19icmVha3BvaW50cw0KPj4gICA8LSBrZ2RiX3JlZW50ZXJfY2hlY2sNCj4+ICAg
ICAgPC0ga2dkYl9oYW5kbGVfZXhjZXB0aW9uDQo+PiAgICAgICAgIDwtIF9fa2dkYl9ub3RpZnkN
Cj4+ICAgICAgICAgICA8LSBrZ2RiX2xsX3RyYXANCj4+ICAgICAgICAgICAgIDwtIGRvX2ludDMN
Cj4+ICAgICAgICAgICA8LSBrZ2RiX25vdGlmeQ0KPj4gICAgICAgICAgICAgPC0gZGllIG5vdGlm
aWVyDQo+PiANCj4+IGtnZGJfYXJjaF9zZXRfYnJlYWtwb2ludA0KPj4gPC0gZGJnX2FjdGl2YXRl
X3N3X2JyZWFrcG9pbnRzDQo+PiAgIDwtIGtnZGJfcmVlbnRlcl9jaGVjaw0KPj4gICAgICA8LSBr
Z2RiX2hhbmRsZV9leGNlcHRpb24NCj4+ICAgICAgICAgIC4uLg0KPj4gDQo+PiBCb3RoIHNlZW1z
IGNhbGxlZCBpbiBleGNlcHRpb24gY29udGV4dCwgc28gd2UgY2FuIG5vdCB0YWtlIGEgbXV0ZXgg
bG9jay4NCj4+IEkgdGhpbmsga2dkYiBuZWVkcyBhIHNwZWNpYWwgcGF0aC4NCj4gDQo+IFlvdSBh
cmUgY29ycmVjdCwgYnV0IEkgZG9u4oCZdCB3YW50IGEgc3BlY2lhbCBwYXRoLiBQcmVzdW1hYmx5
IHRleHRfbXV0ZXggaXMNCj4gZ3VhcmFudGVlZCBub3QgdG8gYmUgdGFrZW4gYWNjb3JkaW5nIHRv
IHRoZSBjb2RlLg0KPiANCj4gU28gSSBndWVzcyB0aGUgb25seSBjb25jZXJuIGlzIGxvY2tkZXAu
IERvIHlvdSBzZWUgYW55IHByb2JsZW0gaWYgSSBjaGFuZ2UNCj4gbXV0ZXhfbG9jaygpIGludG8g
bXV0ZXhfdHJ5bG9jaygpPyBJdCBzaG91bGQgYWx3YXlzIHN1Y2NlZWQsIGFuZCBJIGNhbiBhZGQg
YQ0KPiB3YXJuaW5nIGFuZCBhIGZhaWx1cmUgcGF0aCBpZiBpdCBmYWlscyBmb3Igc29tZSByZWFz
b24uDQoNCkVyci4uIFRoaXMgd2lsbCBub3Qgd29yay4gSSB0aGluayBJIHdpbGwgZHJvcCB0aGlz
IHBhdGNoLCBzaW5jZSBJIGNhbm5vdA0KZmluZCBhIHByb3BlciB5ZXQgc2ltcGxlIGFzc2VydGlv
bi4gQ3JlYXRpbmcgc3BlY2lhbCBwYXRoIGp1c3QgZm9yIHRoZQ0KYXNzZXJ0aW9uIHNlZW1zIHdy
b25nLg==
