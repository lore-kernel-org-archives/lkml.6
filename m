Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB08C67838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499FB20868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="j6Xy78WX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 499FB20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbeLFS4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:56:20 -0500
Received: from mail-eopbgr800071.outbound.protection.outlook.com ([40.107.80.71]:53152
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725908AbeLFS4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:56:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrw7TZRi2J4aeGLogDH8fBlRcTU8fsNZuZ8fgl5rR4U=;
 b=j6Xy78WXSjIBnp+HynMyNpEMz9Mc2qyPihJQW64gmC07uPxXGIvAnSvrRWXqRFT0yJg8CmI2Kb6TPst6wLCuVzVYxXJvjpLic3kkTxOZA598EYK/3m3m+uKTZ4peDnVZP/o8VU+wcDbqX/foVWZR8udZZG4oTaOjDj2R1I9K2c4=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4325.namprd05.prod.outlook.com (52.135.202.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.13; Thu, 6 Dec 2018 18:56:14 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::9155:fea7:9c0c:68c7]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::9155:fea7:9c0c:68c7%3]) with mapi id 15.20.1425.006; Thu, 6 Dec 2018
 18:56:14 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux_dti@icloud.com" <linux_dti@icloud.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v7 13/14] module: Do not set nx for module memory before
 freeing
Thread-Topic: [PATCH v7 13/14] module: Do not set nx for module memory before
 freeing
Thread-Index: AQHUjHgCm5HQo9wG+kmVhMEM5+sZ86VyEK8AgAABGIA=
Date:   Thu, 6 Dec 2018 18:56:14 +0000
Message-ID: <7B410C6F-A811-41DB-ADCE-4E4BF07CA96A@vmware.com>
References: <20181205013408.47725-1-namit@vmware.com>
 <20181205013408.47725-14-namit@vmware.com>
 <CALCETrWZf5sNmXU=yP1ZHxiBi=Z9d3G5FnWH08PasniG1hs26g@mail.gmail.com>
In-Reply-To: <CALCETrWZf5sNmXU=yP1ZHxiBi=Z9d3G5FnWH08PasniG1hs26g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4325;20:3rjaTuoqu+A0QLzAAkouoF0mdJCUV8KWB3ij0nEDpFvpaEg48q5xz7sQLyQtymG048MZkpCIAYLIkKLPZ30QkFr1MFJV5k9V5FVmymF8OuMeHG8sgZZ1QzzhhVdS9mkiKUDbpinOG1O4bNzCOmuT8c5pxD1ncH2GJcUHGVENjog=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a5cc12e5-8ece-4295-20a0-08d65bac7f61
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4325;
x-ms-traffictypediagnostic: BYAPR05MB4325:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-microsoft-antispam-prvs: <BYAPR05MB4325C95EA6FFED139BECE0A8D0A90@BYAPR05MB4325.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB4325;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4325;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(366004)(346002)(39860400002)(199004)(189003)(82746002)(7416002)(186003)(76176011)(102836004)(71200400001)(8936002)(81166006)(81156014)(8676002)(66066001)(33656002)(316002)(6486002)(5660300001)(71190400001)(53546011)(86362001)(26005)(68736007)(99286004)(14454004)(11346002)(256004)(3846002)(478600001)(229853002)(6116002)(6506007)(446003)(83716004)(4326008)(6916009)(2616005)(476003)(7736002)(36756003)(2906002)(486006)(305945005)(39060400002)(25786009)(53936002)(54906003)(6246003)(106356001)(6512007)(6436002)(97736004)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4325;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lrpYzDVK+DX1krpJW4FvOiRlt2M+zufONeh86s6B4vdzxPiiMJubCAs7YJfkD62+58clr8QiI6jCijEAq4zYbjp0rIfT/VTLtutInK0UqSx/OksSS+w/ZVv+DfL3MclWfu0TZJphgikVc5ZFufOKx8wFZpgbaDWPzyA3rL3nCM07UlD2aHRXEWii89ALZKyPSGvDZSezVtDdbtExq015pNCfmXF4gbaIKIJFETK11/aq9Cp4mKk+AHxjNDfxc6NnuhDKGe5NboZIh0Odt7Fkh2LZKYQ0XE2wLIZhWNeUldgZ3BgUpuG2gV3+SehPYOyJu150VaeayQeYuN+DYPpAnhLHoh5A6U5NEKtW9xJp7To=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <0183567F9F5D6A44A513C76E780FED2A@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5cc12e5-8ece-4295-20a0-08d65bac7f61
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 18:56:14.7359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4325
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBEZWMgNiwgMjAxOCwgYXQgMTA6NTIgQU0sIEFuZHkgTHV0b21pcnNraSA8bHV0b0BrZXJu
ZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgRGVjIDUsIDIwMTggYXQgMTI6NTIgQU0gTmFk
YXYgQW1pdCA8bmFtaXRAdm13YXJlLmNvbT4gd3JvdGU6DQo+PiBXaGVuIG1vZHVsZSBtZW1vcnkg
aXMgYWJvdXQgdG8gYmUgZnJlZWQsIHRoZXJlIGlzIG5vIGFwcGFyZW50IHJlYXNvbiB0bw0KPj4g
bWFrZSBpdCAoYW5kIGl0cyBkYXRhKSBleGVjdXRhYmxlLCBidXQgdGhhdCdzIGV4YWN0bHkgd2hh
dCBpcyBkb25lDQo+PiB0b2RheS4gVGhpcyBpcyBub3QgZWZmaWNpZW50IGFuZCBub3Qgc2VjdXJl
Lg0KPj4gDQo+PiBUaGVyZSBhcmUgdmFyaW91cyB0aGVvcmllcyB3aHkgaXQgd2FzIGRvbmUsIGJ1
dCBub25lIG9mIHRoZW0gc2VlbSBhcw0KPj4gc29tZXRoaW5nIHRoYXQgcmVhbGx5IHJlcXVpcmUg
aXQgdG9kYXkuIG5pb3MyIHVzZXMga21hbGxvYyBmb3IgbW9kdWxlDQo+PiBtZW1vcnksIGJ1dCBh
bnlob3cgaXQgZG9lcyBub3QgY2hhbmdlIHRoZSBQVEVzIG9mIHRoZSBtb2R1bGUgbWVtb3J5LiAg
SW4NCj4+IHg4NiwgY2hhbmdpbmcgdm1hbGxvYydkIG1lbW9yeSBtYXBwaW5ncyBhbHNvIG1vZGlm
aWVzIHRoZSBkaXJlY3QgbWFwcGluZw0KPj4gYWxpYXMsIGJ1dCB0aGUgTlgtYml0IGlzIG5vdCBt
b2RpZmllZCBpbiBzdWNoIHdheS4NCj4+IA0KPj4gU28gbGV0J3MgcmVtb3ZlIGl0LiBBbmR5IHN1
Z2dlc3RlZCB0aGF0IHRoZSBjaGFuZ2VzIG9mIHRoZSBQVEVzIGNhbiBiZQ0KPj4gYXZvaWRlZCAo
ZXhjbHVkaW5nIHRoZSBkaXJlY3QtbWFwcGluZyBhbGlhcyksIHdoaWNoIGlzIHRydWUuIEhvd2V2
ZXIsDQo+PiBpbiB4ODYgaXQgcmVxdWlyZXMgc29tZSBjbGVhbnVwIG9mIHRoZSBjb250aWd1b3Vz
IHBhZ2UgYWxsb2NhdG9yLCB3aGljaA0KPj4gaXMgb3V0c2lkZSBvZiB0aGUgc2NvcGUgb2YgdGhp
cyBwYXRjaC1zZXQuDQo+IA0KPiANCj4gSSdtIG9rYXkgd2l0aCB0aGlzLCBidXQgSSdkIGxpa2Ug
dG8gc2VlIFJpY2sncyBzdHVmZiBnZXQgcmViYXNlZCBvbg0KPiB0b3Agb2YgaXQgYW5kIGNsZWFu
IGl0IHVwIGZvciByZWFsLg0KDQpTb3JyeSBmb3IgbXkgbGF6aW5lc3MuIEl0IGp1c3Qgc2VlbXMg
dGhhdCBldmVyeSBzbWFsbCB0aGluZyBJIHRvdWNoIGluDQpyZWdhcmQgdG8gV15YIG9yIHRleHRf
cG9rZSgpIGlzIGJyb2tlbiwgYW5kIEkgbmVlZCB0byBmaW5pc2ggc29tZSBvdGhlcg0K4oCcY2hv
cmVz4oCdIGZpcnN0Lg0KDQo=
