Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0267BC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4BB220815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JiA1yAs5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729884AbfBDTXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 14:23:01 -0500
Received: from mail-eopbgr820080.outbound.protection.outlook.com ([40.107.82.80]:39648
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727490AbfBDTXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 14:23:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhxvMMJIv1P1rAIPTTyycYlvTpJEzstlvN3zwDLw+Gk=;
 b=JiA1yAs5iMrR1S2CAYe4P9E33VUUTaV4PA0SBsCaLuOeseDRi/l2m5MMiusfc/H/7Ic2IkCosCgfWIRWuuGeoYqUY6yUTPiWPGUnDom0rnzuTnqRKqtYp0dj7pA6LQosc7NUYpkHEn1YFj/CGnN93CPKO9wq2Ias+xOg8Q+2DuE=
Received: from SN6PR12MB2688.namprd12.prod.outlook.com (52.135.103.29) by
 SN6PR12MB2670.namprd12.prod.outlook.com (52.135.103.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.20; Mon, 4 Feb 2019 19:22:56 +0000
Received: from SN6PR12MB2688.namprd12.prod.outlook.com
 ([fe80::2cbf:7ce2:83f5:851c]) by SN6PR12MB2688.namprd12.prod.outlook.com
 ([fe80::2cbf:7ce2:83f5:851c%5]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 19:22:56 +0000
From:   "Singh, Brijesh" <brijesh.singh@amd.com>
To:     Jim Mattson <jmattson@google.com>
CC:     "Singh, Brijesh" <brijesh.singh@amd.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@suse.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [Part2 PATCH v9 38/38] KVM: X86: Restart the guest when insn_len
 is zero and SEV is enabled
Thread-Topic: [Part2 PATCH v9 38/38] KVM: X86: Restart the guest when insn_len
 is zero and SEV is enabled
Thread-Index: AQHTbWVTqHolkxEizUexrT9103pfo6XN/JUAgASmrgA=
Date:   Mon, 4 Feb 2019 19:22:56 +0000
Message-ID: <f69e911d-0884-39bd-0aab-e775a005331f@amd.com>
References: <20171205010616.5958-1-brijesh.singh@amd.com>
 <20171205010616.5958-9-brijesh.singh@amd.com>
 <CALMp9eTpMm4qpNCUj00qk8CA7BmW-uq4YRwHzKa_GAwON2kgyQ@mail.gmail.com>
In-Reply-To: <CALMp9eTpMm4qpNCUj00qk8CA7BmW-uq4YRwHzKa_GAwON2kgyQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0006.prod.exchangelabs.com (2603:10b6:804:2::16)
 To SN6PR12MB2688.namprd12.prod.outlook.com (2603:10b6:805:6f::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR12MB2670;20:O7hdJ+o7LX6wS53r3kwslBfu4J1bsXB6zUpzp9WDYnuNN7JOwtz4zvafh7y/VIHzse/xBlCBbXU56BKLNpP5z9asR1HdQebJ30OTLcq5hnyZL4TItPpDBjwxVOfD9sN+nWFa0V+bToCA9N+cTn8lDy4R+imlt20lqqmsHSVZWWicNWLByJL7/Elj6R7DXI04t0whBXwts50wErgDzc3chR9UWbnrdBHaAlJ2W9So3jHVTFf/wcMmuXf4dV5bs12A
x-ms-office365-filtering-correlation-id: 5707443e-053d-48d5-99ea-08d68ad62a7d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2670;
x-ms-traffictypediagnostic: SN6PR12MB2670:
x-microsoft-antispam-prvs: <SN6PR12MB26700A5FA28AA8E6F9F37234E56D0@SN6PR12MB2670.namprd12.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(39860400002)(346002)(376002)(189003)(199004)(71190400001)(71200400001)(25786009)(6246003)(6916009)(6116002)(97736004)(186003)(2906002)(446003)(2616005)(476003)(26005)(4326008)(31686004)(31696002)(86362001)(8936002)(11346002)(486006)(81166006)(81156014)(8676002)(105586002)(14444005)(106356001)(256004)(68736007)(7736002)(316002)(229853002)(54906003)(99286004)(52116002)(6436002)(66066001)(305945005)(6486002)(53936002)(478600001)(7416002)(966005)(14454004)(36756003)(6506007)(386003)(53546011)(102836004)(6512007)(66574012)(6306002)(76176011)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2670;H:SN6PR12MB2688.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pZhKtnaoBeQWrH/nAlC1LMgCKKQFx6x2HT6JcU5tu+tCC6U+3RyvH52BT+TjU67XByb80j95WHKide3UneRW+upXt2+opFtS2YAQj7KXUPHzI/A/663ABsRJ6WfQdKDcL1rq9FuGOzdelWZ+niJwRn7jvPQtxiZA1WoDuoUP0tgsG33Oqbi3axj4OmfHW6/gEN8wCo3R9qRWENsgnwmwLKUKuqhs4gL9RYvK6/qTQ+21lEVT3HCwJchkX54ynBjXeF1wf4ew6nfBsuQOuWeXIINyZD5P1ep0WV1dgNLr+wBezQCIVjbpua4+PQxIwSYMQlx9qPIlsznD7MoeDKrXLf8dAhak62W7YV2Maccl4+VjIC5gEroWv9DQJxO3UgHoEgyzO5OCrO6lbJsvpRxyPmSzRkU5wttDrbPB0PRvlM8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ADC5F49CA2E1714A84F9874C258A811B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5707443e-053d-48d5-99ea-08d68ad62a7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 19:22:55.5009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2670
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIvMS8xOSAyOjIxIFBNLCBKaW0gTWF0dHNvbiB3cm90ZToNCj4gT24gTW9uLCBEZWMg
NCwgMjAxNyBhdCA1OjA3IFBNIEJyaWplc2ggU2luZ2ggPGJyaWplc2guc2luZ2hAYW1kLmNvbT4g
d3JvdGU6DQo+Pg0KPj4gT24gQU1EIHBsYXRmb3JtcywgdW5kZXIgY2VydGFpbiBjb25kaXRpb25z
IGluc25fbGVuIG1heSBiZSB6ZXJvIG9uICNOUEYuDQo+PiBUaGlzIGNhbiBoYXBwZW4gaWYgYSBn
dWVzdCBnZXRzIGEgcGFnZS1mYXVsdCBvbiBkYXRhIGFjY2VzcyBidXQgdGhlIEhXDQo+PiB0YWJs
ZSB3YWxrZXIgaXMgbm90IGFibGUgdG8gcmVhZCB0aGUgaW5zdHJ1Y3Rpb24gcGFnZSAoZS5nIGlu
c3RydWN0aW9uDQo+PiBwYWdlIGlzIG5vdCBwcmVzZW50IGluIG1lbW9yeSkuDQo+Pg0KPj4gVHlw
aWNhbGx5LCB3aGVuIGluc25fbGVuIGlzIHplcm8sIHg4Nl9lbXVsYXRlX2luc3RydWN0aW9uKCkg
d2Fsa3MgdGhlDQo+PiBndWVzdCBwYWdlIHRhYmxlIGFuZCBmZXRjaGVzIHRoZSBpbnN0cnVjdGlv
biBieXRlcyBmcm9tIGd1ZXN0IG1lbW9yeS4NCj4+IFdoZW4gU0VWIGlzIGVuYWJsZWQsIHRoZSBn
dWVzdCBtZW1vcnkgaXMgZW5jcnlwdGVkIHdpdGggZ3Vlc3Qtc3BlY2lmaWMNCj4+IGtleSBoZW5j
ZSBoeXBlcnZpc29yIHdpbGwgbm90IGFibGUgdG8gZmV0Y2ggdGhlIGluc3RydWN0aW9uIGJ5dGVz
Lg0KPj4gSW4gdGhvc2UgY2FzZXMgd2Ugc2ltcGx5IHJlc3RhcnQgdGhlIGd1ZXN0Lg0KPj4NCj4+
IEkgaGF2ZSBlbmNvdW50ZXJlZCB0aGlzIGlzc3VlIHdoZW4gcnVubmluZyBrZXJuYmVuY2ggaW5z
aWRlIHRoZSBndWVzdC4NCj4+DQo+PiBDYzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9u
aXguZGU+DQo+PiBDYzogSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+DQo+PiBDYzogIkgu
IFBldGVyIEFudmluIiA8aHBhQHp5dG9yLmNvbT4NCj4+IENjOiBQYW9sbyBCb256aW5pIDxwYm9u
emluaUByZWRoYXQuY29tPg0KPj4gQ2M6ICJSYWRpbSBLcsSNbcOhxZkiIDxya3JjbWFyQHJlZGhh
dC5jb20+DQo+PiBDYzogSm9lcmcgUm9lZGVsIDxqb3JvQDhieXRlcy5vcmc+DQo+PiBDYzogQm9y
aXNsYXYgUGV0a292IDxicEBzdXNlLmRlPg0KPj4gQ2M6IFRvbSBMZW5kYWNreSA8dGhvbWFzLmxl
bmRhY2t5QGFtZC5jb20+DQo+PiBDYzogeDg2QGtlcm5lbC5vcmcNCj4+IENjOiBrdm1Admdlci5r
ZXJuZWwub3JnDQo+PiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPj4gU2lnbmVk
LW9mZi1ieTogQnJpamVzaCBTaW5naCA8YnJpamVzaC5zaW5naEBhbWQuY29tPg0KPj4gLS0tDQo+
PiAgIGFyY2gveDg2L2t2bS9tbXUuYyB8IDEwICsrKysrKysrKysNCj4+ICAgYXJjaC94ODYva3Zt
L3N2bS5jIHwgIDYgKysrKy0tDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL21tdS5j
IGIvYXJjaC94ODYva3ZtL21tdS5jDQo+PiBpbmRleCBlNWU2NmU1YzY2NDAuLmQ1ZTVkYmQwZTVh
ZCAxMDA2NDQNCj4+IC0tLSBhL2FyY2gveDg2L2t2bS9tbXUuYw0KPj4gKysrIGIvYXJjaC94ODYv
a3ZtL21tdS5jDQo+PiBAQCAtNDk1MCw2ICs0OTUwLDE2IEBAIGludCBrdm1fbW11X3BhZ2VfZmF1
bHQoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBndmFfdCBjcjIsIHU2NCBlcnJvcl9jb2RlLA0KPj4g
ICAgICAgICAgaWYgKG1taW9faW5mb19pbl9jYWNoZSh2Y3B1LCBjcjIsIGRpcmVjdCkpDQo+PiAg
ICAgICAgICAgICAgICAgIGVtdWxhdGlvbl90eXBlID0gMDsNCj4+ICAgZW11bGF0ZToNCj4+ICsg
ICAgICAgLyoNCj4+ICsgICAgICAgICogT24gQU1EIHBsYXRmb3JtcywgdW5kZXIgY2VydGFpbiBj
b25kaXRpb25zIGluc25fbGVuIG1heSBiZSB6ZXJvIG9uICNOUEYuDQo+PiArICAgICAgICAqIFRo
aXMgY2FuIGhhcHBlbiBpZiBhIGd1ZXN0IGdldHMgYSBwYWdlLWZhdWx0IG9uIGRhdGEgYWNjZXNz
IGJ1dCB0aGUgSFcNCj4+ICsgICAgICAgICogdGFibGUgd2Fsa2VyIGlzIG5vdCBhYmxlIHRvIHJl
YWQgdGhlIGluc3RydWN0aW9uIHBhZ2UgKGUuZyBpbnN0cnVjdGlvbg0KPj4gKyAgICAgICAgKiBw
YWdlIGlzIG5vdCBwcmVzZW50IGluIG1lbW9yeSkuIEluIHRob3NlIGNhc2VzIHdlIHNpbXBseSBy
ZXN0YXJ0IHRoZQ0KPj4gKyAgICAgICAgKiBndWVzdC4NCj4+ICsgICAgICAgICovDQo+PiArICAg
ICAgIGlmICh1bmxpa2VseShpbnNuICYmICFpbnNuX2xlbikpDQo+PiArICAgICAgICAgICAgICAg
cmV0dXJuIDE7DQo+PiArDQo+IA0KPiBIb3cgZG9lcyB0aGlzIHdvcmssIGZvciBpbnN0YW5jZSwg
d2l0aCBNTUlPIGF0IENQTDMgd2l0aCBTTUFQIGVuYWJsZWQ/DQo+IA0KDQoNClRoZSBwcm9jZXNz
b3Igd2lsbCBzdGlsbCBhdHRlbXB0IHRvIHN1cHBseSBjb3JyZWN0IGluc3RydWN0aW9uDQpieXRl
cyBpbiB0aGlzIGNhc2UgKGJhc2ljYWxseSBpdCBkaXNhYmxlcyBTTUFQIHRlbXBvcmFyaWx5IGR1
cmluZw0KdGhpcyByZWFkKS4gKkhPV0VWRVIqLCBsb29raW5nIHRocm91Z2ggWmVuIGRvY3MsIHRo
ZXJlIGlzIGFuDQplcnJhdGEgYWJvdXQgdGhpcyBvbiBaZW4uIFNlZSBlcnJhdGEgMTA5NiBpbg0K
aHR0cHM6Ly93d3cuYW1kLmNvbS9zeXN0ZW0vZmlsZXMvVGVjaERvY3MvNTU0NDlfRmFtXzE3aF9N
XzAwaDBGaF9SZXZfR3VpZGUucGRmDQoNCkxvb2tpbmcgYXQgZXJyYXRhIGl0IHNlZW1zIG9uIFpl
biBwcm9jZXNzb3JzLCB0aGUgQ1BVIHdpbGwgbm90DQpzdXBwbHkgaW5zdHJ1Y3Rpb24gYnl0ZXMg
aW4gdGhpcyBzY2VuYXJpbyAoTU1JTyBhdCBDUEwzIHdpdGgNClNNQVA9MSkuIEkgd2lsbCByZWFj
aCBvdXQgdG8gSFcgZm9sa3MgdG8gc2VlIGlmIHRoZXJlIGlzIGFueQ0KcGxhbnMgdG8gZml4IGlu
IHVwY29taW5nIENQVSBjb3Jlcy4NCg0KV2UgcHJvYmFibHkgbmVlZCB0byB3b3JrYXJvdW5kIGZv
ciB0aGlzIGVycmF0YS4gSW4gbm9uIFNFViBjYXNlDQp3ZSBjYW4gbGV0IHRoZSBob3N0IHJlYWQg
dGhlIGluc3RydWN0aW9uIGJ5dGVzIGJ1dCBpbiBTRVYgY2FzZQ0Kd2UgY2FuIGRpc2FibGUgU01B
UCB0ZW1wb3JhcmlseSBpbiBDUjQsIHRoZW4gcmV0cnkgdGhlIGd1ZXN0LA0KYW5kIHRoZW4gcmVz
dG9yZSB0aGUgQ1I0LlNNQVAgc2V0dGluZ3MuIEkgd2lsbCB3b3JrIG9uIHBhdGNoDQphbmQgcG9z
dCBvbiBtYWlsaW5nIGxpc3QuDQoNCi1CcmlqZXNoDQo=
