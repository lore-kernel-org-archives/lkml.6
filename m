Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5012BC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E515F208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="NxoRzjkS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E515F208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeKLGnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:43:00 -0500
Received: from mail-eopbgr760089.outbound.protection.outlook.com ([40.107.76.89]:39154
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726809AbeKLGnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:43:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GEQMRGkYYv2qgrgdPB4gkC0ATUBD8+hZxo2U8hvQko=;
 b=NxoRzjkS+u4fK+LAoIwsVGvOXkydcFYW4u9ph2HBL4s4yNCEUmQDB5CrPi6ZnnnHjqBI4izAMnwqLXs1rfWBvV/T/CzNut6ekTJqcd8A7YZZYKZDDKhvj0ZeJwIO+lHaPzCjr2utAhdhR40YIjSFwRzBHkCXP0MIc0zx8vjs1Eg=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4855.namprd05.prod.outlook.com (52.135.235.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.10; Sun, 11 Nov 2018 20:53:08 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d%4]) with mapi id 15.20.1339.018; Sun, 11 Nov 2018
 20:53:07 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v4 06/10] x86/alternative: use temporary mm for text
 poking
Thread-Topic: [PATCH v4 06/10] x86/alternative: use temporary mm for text
 poking
Thread-Index: AQHUeYjbLsK1w/h4IEOngRVarOSwtaVKq0EAgABiwQA=
Date:   Sun, 11 Nov 2018 20:53:07 +0000
Message-ID: <43C8C690-F079-4513-82CD-46A62DBA5A3B@vmware.com>
References: <20181110231732.15060-1-namit@vmware.com>
 <20181110231732.15060-7-namit@vmware.com> <20181111145936.GA3021@worktop>
In-Reply-To: <20181111145936.GA3021@worktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4855;20:TUNpLfDCIsSZEVMAxI0FFL7eK7LH1A6tsqtCZGXTKgPCk/Gi0WrVHJJGurTn2eass7gsU3PJp17AuVnJ9d5u3ta5X49lf9kkXOjvJ2/t25OUq/vyeeR30ZTu4NjGBfZxtFYwv+H8M1aRRGDxtAbjsMiUUeDlAvzhZ6PbFgHlOWQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c083051a-dc4d-48a5-3b3c-08d64817af1c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4855;
x-ms-traffictypediagnostic: BYAPR05MB4855:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-microsoft-antispam-prvs: <BYAPR05MB485528453C4B7177CAA726E7D0C00@BYAPR05MB4855.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231402)(944501410)(52105112)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB4855;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4855;
x-forefront-prvs: 08534B37A7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(136003)(346002)(376002)(199004)(189003)(305945005)(11346002)(7736002)(476003)(2616005)(36756003)(6916009)(486006)(7416002)(68736007)(256004)(6512007)(14444005)(53546011)(6506007)(316002)(82746002)(83716004)(71190400001)(229853002)(8676002)(8936002)(2900100001)(97736004)(71200400001)(81156014)(81166006)(446003)(5660300001)(66066001)(6436002)(14454004)(26005)(33656002)(186003)(86362001)(2906002)(25786009)(4326008)(3846002)(6116002)(54906003)(99286004)(53936002)(102836004)(478600001)(6246003)(6486002)(105586002)(76176011)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4855;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0KYcrQjo21iMjHOOJcSVrj3aUGEgDHbd5MUEJVt61K1+4zJfA3fvrLXTo49vmR/n4ztBOQt2FbvvfzvbZ4nN0yKyMUNFkVEGVZXwzCHorFOkjj+beY3aKeY5meVi65n3QOiIVkQQPId0XQlmGom9rqtggoUpZR0UBRhfOOg3W3roQh4sb6Y7sEim7gPvbbTIk6L7FU6jXxYASYSScZ1lkQTSQehrmTEEplF/0fkf4SOuY74Z7V0cNZ8ssdUovpZu963ikZjfPkpzYXRT/gSUIb2HGLZI3SgZcWItJO38Pige49zNJtZuVkcvO3tSxy+LOke9PQxm7eAWIJ5hVJH3k8kyBKxhj4v3EEn+Cs6YysY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C52B0DA49A5E2E4FB8B0FE9A8BC519D9@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c083051a-dc4d-48a5-3b3c-08d64817af1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2018 20:53:07.5064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUGV0ZXIgWmlqbHN0cmENClNlbnQ6IE5vdmVtYmVyIDExLCAyMDE4IGF0IDI6NTk6MzYg
UE0gR01UDQo+IFRvOiBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPg0KPiBDYzogSW5nbyBN
b2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+LCBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnLCB4
ODZAa2VybmVsLm9yZywgSC4gUGV0ZXIgQW52aW4gPGhwYUB6eXRvci5jb20+LCBUaG9tYXMgR2xl
aXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4sIEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRl
PiwgRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT4sIEFuZHkgTHV0b21p
cnNraSA8bHV0b0BrZXJuZWwub3JnPiwgS2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1bS5vcmc+
LCBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AaW50ZWwuY29tPiwgTWFzYW1pIEhpcmFtYXRzdSA8
bWhpcmFtYXRAa2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAwNi8xMF0geDg2
L2FsdGVybmF0aXZlOiB1c2UgdGVtcG9yYXJ5IG1tIGZvciB0ZXh0IHBva2luZw0KPiANCj4gDQo+
IE9uIFNhdCwgTm92IDEwLCAyMDE4IGF0IDAzOjE3OjI4UE0gLTA4MDAsIE5hZGF2IEFtaXQgd3Jv
dGU6DQo+PiBAQCAtNjgzLDQzICs2ODQsMTA4IEBAIF9fcm9fYWZ0ZXJfaW5pdCB1bnNpZ25lZCBs
b25nIHBva2luZ19hZGRyOw0KPj4gDQo+PiBzdGF0aWMgaW50IF9fdGV4dF9wb2tlKHZvaWQgKmFk
ZHIsIGNvbnN0IHZvaWQgKm9wY29kZSwgc2l6ZV90IGxlbikNCj4+IHsNCj4+ICsJYm9vbCBjcm9z
c19wYWdlX2JvdW5kYXJ5ID0gb2Zmc2V0X2luX3BhZ2UoYWRkcikgKyBsZW4gPiBQQUdFX1NJWkU7
DQo+PiArCXRlbXBvcmFyeV9tbV9zdGF0ZV90IHByZXY7DQo+PiArCXN0cnVjdCBwYWdlICpwYWdl
c1syXSA9IHtOVUxMfTsNCj4+IAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPj4gKwlwdGVfdCBwdGUs
ICpwdGVwOw0KPj4gKwlzcGlubG9ja190ICpwdGw7DQo+PiArCWludCByID0gMDsNCj4+IA0KPj4g
CS8qDQo+PiArCSAqIFdoaWxlIGJvb3QgbWVtb3J5IGFsbG9jYXRvciBpcyBydW5uaW5nIHdlIGNh
bm5vdCB1c2Ugc3RydWN0IHBhZ2VzIGFzDQo+PiArCSAqIHRoZXkgYXJlIG5vdCB5ZXQgaW5pdGlh
bGl6ZWQuDQo+PiAJICovDQo+PiAJQlVHX09OKCFhZnRlcl9ib290bWVtKTsNCj4+IA0KPj4gCWlm
ICghY29yZV9rZXJuZWxfdGV4dCgodW5zaWduZWQgbG9uZylhZGRyKSkgew0KPj4gCQlwYWdlc1sw
XSA9IHZtYWxsb2NfdG9fcGFnZShhZGRyKTsNCj4+ICsJCWlmIChjcm9zc19wYWdlX2JvdW5kYXJ5
KQ0KPj4gKwkJCXBhZ2VzWzFdID0gdm1hbGxvY190b19wYWdlKGFkZHIgKyBQQUdFX1NJWkUpOw0K
Pj4gCX0gZWxzZSB7DQo+PiAJCXBhZ2VzWzBdID0gdmlydF90b19wYWdlKGFkZHIpOw0KPj4gCQlX
QVJOX09OKCFQYWdlUmVzZXJ2ZWQocGFnZXNbMF0pKTsNCj4+ICsJCWlmIChjcm9zc19wYWdlX2Jv
dW5kYXJ5KQ0KPj4gKwkJCXBhZ2VzWzFdID0gdmlydF90b19wYWdlKGFkZHIgKyBQQUdFX1NJWkUp
Ow0KPj4gCX0NCj4+ICsNCj4+ICsJaWYgKCFwYWdlc1swXSB8fCAoY3Jvc3NfcGFnZV9ib3VuZGFy
eSAmJiAhcGFnZXNbMV0pKQ0KPj4gCQlyZXR1cm4gLUVGQVVMVDsNCj4+ICsNCj4+IAlsb2NhbF9p
cnFfc2F2ZShmbGFncyk7DQo+PiArDQo+PiArCS8qDQo+PiArCSAqIFRoZSBsb2NrIGlzIG5vdCBy
ZWFsbHkgbmVlZGVkLCBidXQgdGhpcyBhbGxvd3MgdG8gYXZvaWQgb3Blbi1jb2RpbmcuDQo+PiAr
CSAqLw0KPj4gKwlwdGVwID0gZ2V0X2xvY2tlZF9wdGUocG9raW5nX21tLCBwb2tpbmdfYWRkciwg
JnB0bCk7DQo+PiArDQo+PiArCS8qDQo+PiArCSAqIElmIHdlIGZhaWxlZCB0byBhbGxvY2F0ZSBh
IFBURSwgZmFpbC4gVGhpcyBzaG91bGQgKm5ldmVyKiBoYXBwZW4sDQo+PiArCSAqIHNpbmNlIHdl
IHByZWFsbG9jYXRlIHRoZSBQVEUuDQo+PiArCSAqLw0KPj4gKwlpZiAoV0FSTl9PTl9PTkNFKCFw
dGVwKSkNCj4+ICsJCWdvdG8gb3V0Ow0KPiANCj4gU2luY2Ugd2UgaGFyZCByZWx5IG9uIGluaXQg
Z2V0dGluZyB0aGF0IHJpZ2h0OyBjYW4ndCB3ZSBzaW1wbHkgZ2V0IHJpZA0KPiBvZiB0aGlzPw0K
DQpUaGlzIGlzIGEgcmVwZWF0ZWQgY29tcGxhaW50IG9mIHlvdXJzLCB3aGljaCBJIGRvIG5vdCBm
ZWVsIGNvbWZvcnRhYmxlIHdpdGguDQpPbmUgZGF5IHNvbWVvbmUgd2lsbCBydW4gc29tZSBzdGF0
aWMgYW5hbHlzaXMgdG9vbCBhbmQgc3RhcnQgZmluZGluZyB0aGF0DQphbGwgdGhlc2UgY2hlY2tz
IGFyZSBtaXNzaW5nLg0KDQpUaGUgcXVlc3Rpb24gaXMgd2h5IGRvIHlvdSBjYXJlIGFib3V0IHRo
ZW0uIElmIGl0IGlzIGJlY2F1c2UgdGhleSBhZmZlY3QgdGhlDQpnZW5lcmF0ZWQgY29kZSBhbmQg
bWFrZSBpdCBsZXNzIGVmZmljaWVudCwgSSBjYW4gZnVsbHkgdW5kZXJzdGFuZCBhbmQgcGVyaGFw
cw0Kd2Ugc2hvdWxkIGhhdmUgc29tZXRoaW5nIGxpa2UgUEFSQU5PSURfV0FSTl9PTl9PTkNFKCkg
d2hpY2ggY29tcGlsZXMgaW50byBub3RoaW5nDQp1bmxlc3MgYSBjZXJ0YWluIGRlYnVnIG9wdGlv
biBpcyBzZXQuDQoNCklmIGl0IGlzIGFib3V0IHRoZSB3YXkgdGhlIHNvdXJjZSBjb2RlIGxvb2tz
IC0gSSBndWVzcyBpdCBkb2VzbuKAmXQgc29yZSBteQ0KZXllcyBhcyBoYXJkIGFzIHNvbWUgb3Ro
ZXIgc3R1ZmYsIGFuZCBJIGNhbm5vdCBkbyBtdWNoIGFib3V0IGl0IChvdGhlciB0aGFuDQpyZW1v
dmluZyBpdCBhcyB5b3UgYXNrZWQpLg0KDQo+PiArDQo+PiArCXB0ZSA9IG1rX3B0ZShwYWdlc1sw
XSwgUEFHRV9LRVJORUwpOw0KPj4gKwlzZXRfcHRlX2F0KHBva2luZ19tbSwgcG9raW5nX2FkZHIs
IHB0ZXAsIHB0ZSk7DQo+PiArDQo+PiArCWlmIChjcm9zc19wYWdlX2JvdW5kYXJ5KSB7DQo+PiAr
CQlwdGUgPSBta19wdGUocGFnZXNbMV0sIFBBR0VfS0VSTkVMKTsNCj4+ICsJCXNldF9wdGVfYXQo
cG9raW5nX21tLCBwb2tpbmdfYWRkciArIFBBR0VfU0laRSwgcHRlcCArIDEsIHB0ZSk7DQo+PiAr
CX0NCj4+ICsNCj4+ICsJLyoNCj4+ICsJICogTG9hZGluZyB0aGUgdGVtcG9yYXJ5IG1tIGJlaGF2
ZXMgYXMgYSBjb21waWxlciBiYXJyaWVyLCB3aGljaA0KPj4gKwkgKiBndWFyYW50ZWVzIHRoYXQg
dGhlIFBURSB3aWxsIGJlIHNldCBhdCB0aGUgdGltZSBtZW1jcHkoKSBpcyBkb25lLg0KPj4gKwkg
Ki8NCj4+ICsJcHJldiA9IHVzZV90ZW1wb3JhcnlfbW0ocG9raW5nX21tKTsNCj4+ICsNCj4+ICsJ
a2FzYW5fZGlzYWJsZV9jdXJyZW50KCk7DQo+PiArCW1lbWNweSgodTggKilwb2tpbmdfYWRkciAr
IG9mZnNldF9pbl9wYWdlKGFkZHIpLCBvcGNvZGUsIGxlbik7DQo+PiArCWthc2FuX2VuYWJsZV9j
dXJyZW50KCk7DQo+PiArDQo+PiArCS8qDQo+PiArCSAqIEVuc3VyZSB0aGF0IHRoZSBQVEUgaXMg
b25seSBjbGVhcmVkIGFmdGVyIHRoZSBpbnN0cnVjdGlvbnMgb2YgbWVtY3B5DQo+PiArCSAqIHdl
cmUgaXNzdWVkIGJ5IHVzaW5nIGEgY29tcGlsZXIgYmFycmllci4NCj4+ICsJICovDQo+PiArCWJh
cnJpZXIoKTsNCj4+ICsNCj4+ICsJcHRlX2NsZWFyKHBva2luZ19tbSwgcG9raW5nX2FkZHIsIHB0
ZXApOw0KPj4gKw0KPj4gKwkvKg0KPj4gKwkgKiBfX2ZsdXNoX3RsYl9vbmVfdXNlcigpIHBlcmZv
cm1zIGEgcmVkdW5kYW50IFRMQiBmbHVzaCB3aGVuIFBUSSBpcyBvbiwNCj4+ICsJICogYXMgaXQg
YWxzbyBmbHVzaGVzIHRoZSBjb3JyZXNwb25kaW5nICJ1c2VyIiBhZGRyZXNzIHNwYWNlcywgd2hp
Y2gNCj4+ICsJICogZG9lcyBub3QgZXhpc3QuDQo+PiArCSAqDQo+PiArCSAqIFBva2luZywgaG93
ZXZlciwgaXMgYWxyZWFkeSB2ZXJ5IGluZWZmaWNpZW50IHNpbmNlIGl0IGRvZXMgbm90IHRyeSB0
bw0KPj4gKwkgKiBiYXRjaCB1cGRhdGVzLCBzbyB3ZSBpZ25vcmUgdGhpcyBwcm9ibGVtIGZvciB0
aGUgdGltZSBiZWluZy4NCj4+ICsJICoNCj4+ICsJICogU2luY2UgdGhlIFBURXMgZG8gbm90IGV4
aXN0IGluIG90aGVyIGtlcm5lbCBhZGRyZXNzLXNwYWNlcywgd2UgZG8NCj4+ICsJICogbm90IHVz
ZSBfX2ZsdXNoX3RsYl9vbmVfa2VybmVsKCksIHdoaWNoIHdoZW4gUFRJIGlzIG9uIHdvdWxkIGNh
dXNlDQo+PiArCSAqIG1vcmUgdW53YXJyYW50ZWQgVExCIGZsdXNoZXMuDQo+PiArCSAqDQo+PiAr
CSAqIFRoZXJlIGlzIGEgc2xpZ2h0IGFub21hbHkgaGVyZTogdGhlIFBURSBpcyBhIHN1cGVydmlz
b3Itb25seSBhbmQNCj4+ICsJICogKHBvdGVudGlhbGx5KSBnbG9iYWwgYW5kIHdlIHVzZSBfX2Zs
dXNoX3RsYl9vbmVfdXNlcigpIGJ1dCB0aGlzDQo+PiArCSAqIHNob3VsZCBiZSBmaW5lLg0KPj4g
KwkgKi8NCj4+ICsJX19mbHVzaF90bGJfb25lX3VzZXIocG9raW5nX2FkZHIpOw0KPj4gKwlpZiAo
Y3Jvc3NfcGFnZV9ib3VuZGFyeSkgew0KPj4gKwkJcHRlX2NsZWFyKHBva2luZ19tbSwgcG9raW5n
X2FkZHIgKyBQQUdFX1NJWkUsIHB0ZXAgKyAxKTsNCj4+ICsJCV9fZmx1c2hfdGxiX29uZV91c2Vy
KHBva2luZ19hZGRyICsgUEFHRV9TSVpFKTsNCj4+ICsJfQ0KPj4gKw0KPj4gKwkvKg0KPj4gKwkg
KiBMb2FkaW5nIHRoZSBwcmV2aW91cyBwYWdlLXRhYmxlIGhpZXJhcmNoeSByZXF1aXJlcyBhIHNl
cmlhbGl6aW5nDQo+PiArCSAqIGluc3RydWN0aW9uIHRoYXQgYWxyZWFkeSBhbGxvd3MgdGhlIGNv
cmUgdG8gc2VlIHRoZSB1cGRhdGVkIHZlcnNpb24uDQo+PiArCSAqIFhlbi1QViBpcyBhc3N1bWVk
IHRvIHNlcmlhbGl6ZSBleGVjdXRpb24gaW4gYSBzaW1pbGFyIG1hbm5lci4NCj4+ICsJICovDQo+
PiArCXVudXNlX3RlbXBvcmFyeV9tbShwcmV2KTsNCj4+ICsNCj4+ICsJcHRlX3VubWFwX3VubG9j
ayhwdGVwLCBwdGwpOw0KPj4gK291dDoNCj4+ICsJaWYgKG1lbWNtcChhZGRyLCBvcGNvZGUsIGxl
bikpDQo+PiArCQlyID0gLUVGQVVMVDsNCj4gDQo+IEhvdyBjb3VsZCB0aGlzIGV2ZXIgZmFpbD8g
QW5kIGhvdyBjYW4gd2UgcmVsaWFibHkgcmVjb3ZlciBmcm9tIHRoYXQ/DQoNClRoaXMgY29kZSBo
YXMgYmVlbiB0aGVyZSBiZWZvcmUgKHdpdGggc2xpZ2h0bHkgdWdsaWVyIGNvZGUpLiBCZWZvcmUg
dGhpcw0KcGF0Y2gsIGEgQlVHX09OKCkgd2FzIHVzZWQgaGVyZS4gSG93ZXZlciwgSSBub3RpY2Vk
IHRoYXQga2dkYiBhY3R1YWxseQ0KY2hlY2tzIHRoYXQgdGV4dF9wb2tlKCkgc3VjY2VlZGVkIGFm
dGVyIGNhbGxpbmcgaXQgYW5kIGdyYWNlZnVsbHkgZmFpbC4NCkhvd2V2ZXIsIHRoaXMgd2FzIHVz
ZWxlc3MsIHNpbmNlIHRleHRfcG9rZSgpIHdvdWxkIHBhbmljIGJlZm9yZSBrZ2RiIGdldHMNCnRo
ZSBjaGFuY2UgdG8gZG8gYW55dGhpbmcgKHNlZSBwYXRjaCA3KS4NCg0KPiBJIG1lYW4sIHdlIGNh
biBtb3ZlIHRoYXQgQlVHX09OKCkgd2UgaGF2ZSBpbiB0ZXh0X3Bva2UoKSBkb3duIGEgbGV2ZWws
DQo+IGJ1dCBmb3IgZXhhbXBsZSB0aGUgc3RhdGljX2tleS9qdW1wX2xhYmVsIGNvZGUgaGFzIG5v
IHJlYWwgb3B0aW9uIG9uDQo+IGZhaWxpbmcgdGhpcy4NCj4gDQo+PiArDQo+PiAJbG9jYWxfaXJx
X3Jlc3RvcmUoZmxhZ3MpOw0KPj4gCXJldHVybiByOw0KPj4gfQ0KPiANCj4gT3RoZXIgdGhhbiB0
aGF0LCB0aGlzIGxvb2tzIHJlYWxseSBnb29kIQ0KDQoNCg==
