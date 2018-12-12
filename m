Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDD8C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA69720851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="dAqP2SeS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA69720851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbeLLVRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 16:17:37 -0500
Received: from mail-eopbgr800087.outbound.protection.outlook.com ([40.107.80.87]:35360
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728012AbeLLVRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 16:17:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9ZBj1sPQWi5G4dvHPGCpbnKYU30mdikPBDFlvkCqFg=;
 b=dAqP2SeSddXQUJC/GUhGbYGHFgFD4TcDGPpq0G2xB7ugGmIXI0Ju5U/uNcd0EStyZctxsf07d6R7fq8clKzY8SMaqg9Njtz5AnvPT+/8wQDzb8MYMMILMzdFWcLDXMOzs6yFCK6V6+XHpxlsAcjcYb2FjzXPKr6uLoJd0WjB7LE=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4920.namprd05.prod.outlook.com (52.135.235.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.9; Wed, 12 Dec 2018 21:16:51 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::9155:fea7:9c0c:68c7]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::9155:fea7:9c0c:68c7%4]) with mapi id 15.20.1446.006; Wed, 12 Dec 2018
 21:16:51 +0000
From:   Nadav Amit <namit@vmware.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jannh@google.com" <jannh@google.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH v2 4/4] x86/vmalloc: Add TLB efficient x86 arch_vunmap
Thread-Topic: [PATCH v2 4/4] x86/vmalloc: Add TLB efficient x86 arch_vunmap
Thread-Index: AQHUka9WxGYYYvHGvUG9E8loVoLjfqV6pRmAgAD0dgCAAAMOAA==
Date:   Wed, 12 Dec 2018 21:16:50 +0000
Message-ID: <C555A142-AA07-465C-AC9B-6DF3683A8F42@vmware.com>
References: <20181212000354.31955-1-rick.p.edgecombe@intel.com>
 <20181212000354.31955-5-rick.p.edgecombe@intel.com>
 <90B10050-0CF1-48B2-B671-508FB092C2FE@vmware.com>
 <2604df8fb817d8f0c38f572f4fb184db36554bed.camel@intel.com>
In-Reply-To: <2604df8fb817d8f0c38f572f4fb184db36554bed.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4920;20:ZAZXWq7zHbGvIT+UcPu+gsPmEi7zvHNPsE9aOBabm1cyHyDG6pXSFX99HZZHdLphpKSiB03EVns3JksNjsDN6tJbbF1GAYbTYWv5fdhUTgMggmcQV4oQA1ajNc0egv4XwwYXhcKkE+nK6Jtsygl9XNemKbEjWeoiWcqoAFhwoUI=
x-ms-office365-filtering-correlation-id: f10ffd68-ba64-4d0f-f51b-08d66077225d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4920;
x-ms-traffictypediagnostic: BYAPR05MB4920:
x-microsoft-antispam-prvs: <BYAPR05MB492051C57176B42DF4ED21BCD0A70@BYAPR05MB4920.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230020)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231475)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB4920;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4920;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(366004)(39860400002)(396003)(199004)(189003)(54094003)(51444003)(106356001)(76176011)(54906003)(316002)(446003)(6486002)(93886005)(11346002)(486006)(66066001)(2616005)(105586002)(6246003)(305945005)(5660300001)(7416002)(86362001)(6436002)(36756003)(4326008)(71190400001)(71200400001)(97736004)(33656002)(25786009)(82746002)(14444005)(256004)(6512007)(53936002)(14454004)(478600001)(7736002)(6506007)(26005)(8936002)(6116002)(102836004)(6346003)(3846002)(229853002)(53546011)(99286004)(476003)(6916009)(81166006)(81156014)(68736007)(2906002)(8676002)(83716004)(186003)(4001150100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4920;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-microsoft-antispam-message-info: na079twKLY4PcrGsDg+JO1npwm+G0bKz9HHV8YPGJ7SuVoCK5Ee5GKg6CLBWb5F62FyxDnJXKwuB483voI3wGMaWM5Hn1rVybF8TdH6mO9/KsogDOI1sO15zYZFhkXs4UeshlHrFP9wV2iLKzSO2DbYlWsP+vbbqWOrsP2lFM/laXNQQC/kQCaWr6sFQ1i8M6KdlU9m7dqVFHQ/jpAmayNzaXa5LT68tvbW4o8dVbOv+OLhFljZ+v9dZDKPPve01uzMmCcSKW4dgzXLM2KWjASPepl+n0lm+eqdXAmOeDNNgxbu7JFPDe8rmfpqLxyax
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <02BAECB73A3B174FB12C4382C97AF68F@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f10ffd68-ba64-4d0f-f51b-08d66077225d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 21:16:50.9989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4920
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBEZWMgMTIsIDIwMTgsIGF0IDE6MDUgUE0sIEVkZ2Vjb21iZSwgUmljayBQIDxyaWNrLnAu
ZWRnZWNvbWJlQGludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIDIwMTgtMTItMTIgYXQg
MDY6MzAgKzAwMDAsIE5hZGF2IEFtaXQgd3JvdGU6DQo+Pj4gT24gRGVjIDExLCAyMDE4LCBhdCA0
OjAzIFBNLCBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+DQo+Pj4g
d3JvdGU6DQo+Pj4gDQo+Pj4gVGhpcyBhZGRzIGEgbW9yZSBlZmZpY2llbnQgeDg2IGFyY2hpdGVj
dHVyZSBzcGVjaWZpYyBpbXBsZW1lbnRhdGlvbiBvZg0KPj4+IGFyY2hfdnVubWFwLCB0aGF0IGNh
biBmcmVlIGFueSB0eXBlIG9mIHNwZWNpYWwgcGVybWlzc2lvbiBtZW1vcnkgd2l0aCBvbmx5IDEN
Cj4+PiBUTEINCj4+PiBmbHVzaC4NCj4+PiANCj4+PiBJbiBvcmRlciB0byBlbmFibGUgdGhpcywg
X3NldF9wYWdlc19wIGFuZCBfc2V0X3BhZ2VzX25wIGFyZSBtYWRlIG5vbi1zdGF0aWMNCj4+PiBh
bmQNCj4+PiByZW5hbWVkIHNldF9wYWdlc19wX25vZmx1c2ggYW5kIHNldF9wYWdlc19ucF9ub2Zs
dXNoIHRvIGJldHRlciBjb21tdW5pY2F0ZQ0KPj4+IHRoZWlyIGRpZmZlcmVudCAobm9uLWZsdXNo
aW5nKSBiZWhhdmlvciBmcm9tIHRoZSByZXN0IG9mIHRoZSBzZXRfcGFnZXNfKg0KPj4+IGZ1bmN0
aW9ucy4NCj4+PiANCj4+PiBUaGUgbWV0aG9kIGZvciBkb2luZyB0aGlzIHdpdGggb25seSAxIFRM
QiBmbHVzaCB3YXMgc3VnZ2VzdGVkIGJ5IEFuZHkNCj4+PiBMdXRvbWlyc2tpLg0KPj4gDQo+PiBb
c25pcF0NCj4+IA0KPj4+ICsJLyoNCj4+PiArCSAqIElmIHRoZSB2bSBiZWluZyBmcmVlZCBoYXMg
c2VjdXJpdHkgc2Vuc2l0aXZlIGNhcGFiaWxpdGllcyBzdWNoIGFzDQo+Pj4gKwkgKiBleGVjdXRh
YmxlIHdlIG5lZWQgdG8gbWFrZSBzdXJlIHRoZXJlIGlzIG5vIFcgd2luZG93IG9uIHRoZSBkaXJl
Y3RtYXANCj4+PiArCSAqIGJlZm9yZSByZW1vdmluZyB0aGUgWCBpbiB0aGUgVExCLiBTbyB3ZSBz
ZXQgbm90IHByZXNlbnQgZmlyc3Qgc28gd2UNCj4+PiArCSAqIGNhbiBmbHVzaCB3aXRob3V0IGFu
eSBvdGhlciBDUFUgcGlja2luZyB1cCB0aGUgbWFwcGluZy4gVGhlbiB3ZSByZXNldA0KPj4+ICsJ
ICogUlcrUCB3aXRob3V0IGEgZmx1c2gsIHNpbmNlIE5QIHByZXZlbnRlZCBpdCBmcm9tIGJlaW5n
IGNhY2hlZCBieQ0KPj4+ICsJICogb3RoZXIgY3B1cy4NCj4+PiArCSAqLw0KPj4+ICsJc2V0X2Fy
ZWFfZGlyZWN0X25wKGFyZWEpOw0KPj4+ICsJdm1fdW5tYXBfYWxpYXNlcygpOw0KPj4gDQo+PiBE
b2VzIHZtX3VubWFwX2FsaWFzZXMoKSBmbHVzaCBpbiB0aGUgVExCIHRoZSBkaXJlY3QgbWFwcGlu
ZyByYW5nZSBhcyB3ZWxsPyBJDQo+PiBjYW4gb25seSBmaW5kIHRoZSBmbHVzaCBvZiB0aGUgdm1h
bGxvYyByYW5nZS4NCj4gSG1tbS4gSXQgc2hvdWxkIHVzdWFsbHkgKEkgdGVzdGVkKSwgYnV0IG5v
dyBJIHdvbmRlciBpZiB0aGVyZSBhcmUgY2FzZXMgd2hlcmUgaXQNCj4gZG9lc24ndCBhbmQgaXQg
Y291bGQgZGVwZW5kIG9uIGFyY2hpdGVjdHVyZSBhcyB3ZWxsLiBJJ2xsIGhhdmUgdG8gdHJhY2Ug
dGhyb3VnaA0KPiB0aGlzIHRvIHZlcmlmeSwgdGhhbmtzLg0KDQpJIHRoaW5rIHRoYXQgaXQgbW9z
dGx5IGRvZXMsIHNpbmNlIHlvdSB0cnkgdG8gZmx1c2ggbW9yZSB0aGFuIDMzIFBURXMgKHRoZQ0K
dGhyZXNob2xkIHRvIGZsdXNoIHRoZSB3aG9sZSBUTEIgaW5zdGVhZCBvZiBpbmRpdmlkdWFsIGVu
dHJpZXMpLiBCdXQgeW91DQpzaG91bGRu4oCZdCBjb3VudCBvbiBpdC4gRXZlbiB0aGlzIHRocmVz
aG9sZCBpcyBjb25maWd1cmFibGUuDQoNCg==
