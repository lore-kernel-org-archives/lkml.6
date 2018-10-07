Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526C7C65C1B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 19:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F622084D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 19:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="lZHfJqpa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87F622084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbeJHCOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 22:14:32 -0400
Received: from mail-bl2nam02on0084.outbound.protection.outlook.com ([104.47.38.84]:40864
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726986AbeJHCOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 22:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CzrYimpaNLwHCbbkuJwR9y1Z2fMvA6D94xrkmXCYfM=;
 b=lZHfJqpabeCgwNyL6+FoVEeotBReH0+Lfy2zkN4wXVIw1nOn1CM7AIoPUw7WnOGzYVsbNnXsWm3cldfpZgG0CSuEVGpG6Z00AuFd1sj5lo+ZZMB2BlpRk/caiK4vUVtgRK9ZnssjRVXX2Gsz283k0bZlAJFpC8rWrekjmfPNTdw=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4232.namprd05.prod.outlook.com (52.135.200.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.13; Sun, 7 Oct 2018 19:06:07 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2%3]) with mapi id 15.20.1207.018; Sun, 7 Oct 2018
 19:06:07 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Richard Biener <rguenther@suse.de>, Borislav Petkov <bp@alien8.de>,
        "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, Michael Matz <matz@suse.de>
CC:     Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alok Kataria <akataria@vmware.com>,
        Christopher Li <sparse@chrisli.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Thread-Topic: PROPOSAL: Extend inline asm syntax with size spec
Thread-Index: AQHUXh6xHKcwa4kgSkWbM7cjy/hJdqUT9AEAgAAKUgCAACbpAA==
Date:   Sun, 7 Oct 2018 19:06:07 +0000
Message-ID: <56EB8A07-8D24-40F1-8CCE-614D7B712519@vmware.com>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181007091805.GA30687@zn.tnic>
 <4F2F1BCE-7875-4160-9E1E-9F8EF962D989@vmware.com>
 <FC56B15B-0D4A-4A4A-81DA-A5093B56A210@suse.de>
In-Reply-To: <FC56B15B-0D4A-4A4A-81DA-A5093B56A210@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [216.9.110.10]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4232;20:GKze0TJGb2m2nHFFtaibllkTXx+6JEyMxmTtwoc6mx2EujV2BfJY5xqKtPpD61ZE4N081STM2LvIAItKTY7+FCdmm4UEyNuJoOZvDOAfvxBDaXMZKphPLh7KFVJ24watX5OOQqK1fKNTydtzZUWkKa7kSt9xNChTXVYNT2epukk=
x-ms-office365-filtering-correlation-id: 387f3198-b569-4dbb-6a08-08d62c87efe2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4232;
x-ms-traffictypediagnostic: BYAPR05MB4232:
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB42324F2C2E75BB954978F35AD0E50@BYAPR05MB4232.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(219752817060721)(189930954265078)(61668805478150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:BYAPR05MB4232;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4232;
x-forefront-prvs: 0818724663
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(376002)(396003)(39860400002)(199004)(189003)(476003)(11346002)(2616005)(446003)(486006)(8936002)(966005)(36756003)(99286004)(45080400002)(93886005)(6306002)(6246003)(316002)(39060400002)(68736007)(66066001)(71190400001)(71200400001)(2906002)(256004)(76176011)(97736004)(25786009)(7736002)(229853002)(8676002)(81166006)(4326008)(81156014)(575784001)(86362001)(54906003)(5250100002)(110136005)(53936002)(6116002)(6436002)(2900100001)(478600001)(105586002)(2501003)(14454004)(6506007)(186003)(3846002)(83716004)(106356001)(26005)(5660300001)(33656002)(82746002)(6486002)(6512007)(102836004)(7416002)(305945005)(200143003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4232;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bH1a6qkwXZiCXqCeBQyzzz2gFfQ8BMmkb5BlK8lOC0CzK4QQFKNx7GwEqTQ3QxlJT35LIu18IuZ3KsyRIdyBbaTXvKc2DvUk5Joe8dovJaWRHHSknafQ+yxBwygkLaKz/lPAQBYrXCaJssMMLWPrSeCF6nudLIE2sxK0sJ/Pv1BRgnyCsG9Zs5ux5rDLYRIlNuR+cLSwQZC0RAlNPwYjM3X+8VABUQZeZEJHMzpU+w4GpI821G18nzwKZRhzmYjrj588pQN0ZzppapL9oAqV7VUbS07oMvW4LeVPSxRNl9I7B+SS0/PY6Xk2xnMXwr4ZZqDH3+2QMmPHINJAcLFwRbWk8mLGQpG1PRXVNXfl/Bc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <532B9101F22F2E4AA27F598B71C4CBAC@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 387f3198-b569-4dbb-6a08-08d62c87efe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2018 19:06:07.4116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4232
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgOTo0NiBBTSwgUmljaGFyZCBCaWVuZXIgPHJndWVudGhlckBzdXNlLmRlPiB3cm90ZToNCg0K
PiBPbiBPY3RvYmVyIDcsIDIwMTggNjowOTozMCBQTSBHTVQrMDI6MDAsIE5hZGF2IEFtaXQgPG5h
bWl0QHZtd2FyZS5jb20+IHdyb3RlOg0KPj4gYXQgMjoxOCBBTSwgQm9yaXNsYXYgUGV0a292IDxi
cEBhbGllbjguZGU+IHdyb3RlOg0KPj4gDQo+Pj4gSGkgcGVvcGxlLA0KPj4+IA0KPj4+IHRoaXMg
aXMgYW4gYXR0ZW1wdCB0byBzZWUgd2hldGhlciBnY2MncyBpbmxpbmUgYXNtIGhldXJpc3RpYyB3
aGVuDQo+Pj4gZXN0aW1hdGluZyBpbmxpbmUgYXNtIHN0YXRlbWVudHMnIGNvc3QgZm9yIGJldHRl
ciBpbmxpbmluZyBjYW4gYmUNCj4+PiBpbXByb3ZlZC4NCj4+PiANCj4+PiBBRkFJVSwgdGhlIHBy
b2JsZW1hdGljIGFyaXNlcyB3aGVuIG9uZSBlbmRzIHVwIHVzaW5nIGEgbG90IG9mIGlubGluZQ0K
Pj4+IGFzbSBzdGF0ZW1lbnRzIGluIHRoZSBrZXJuZWwgYnV0IGR1ZSB0byB0aGUgaW5saW5lIGFz
bSBjb3N0DQo+PiBlc3RpbWF0aW9uDQo+Pj4gaGV1cmlzdGljIHdoaWNoIGNvdW50cyBsaW5lcywg
SSB0aGluaywgZm9yIGV4YW1wbGUgbGlrZSBpbiB0aGlzIGhlcmUNCj4+PiBtYWNybzoNCj4+IGh0
dHBzOi8vbmEwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNB
JTJGJTJGZ2l0Lmtlcm5lbC5vcmclMkZwdWIlMkZzY20lMkZsaW51eCUyRmtlcm5lbCUyRmdpdCUy
RnRvcnZhbGRzJTJGbGludXguZ2l0JTJGdHJlZSUyRmFyY2glMkZ4ODYlMkZpbmNsdWRlJTJGYXNt
JTJGY3B1ZmVhdHVyZS5oJTIzbjE2MiZhbXA7ZGF0YT0wMiU3QzAxJTdDbmFtaXQlNDB2bXdhcmUu
Y29tJTdDODYwNDAzY2VjYjg3NGRiNjRiN2UwOGQ2MmM3NDZmNDYlN0NiMzkxMzhjYTNjZWU0YjRh
YTRkNmNkODNkOWRkNjJmMCU3QzElN0MwJTdDNjM2NzQ1Mjc1OTc1NTA1MzgxJmFtcDtzZGF0YT1O
ZDA2MzZLOVoxSXNVczFSV1NSQWhWdVZib0x4bEJDQjRwZWlBTWZtUXpRJTNEJmFtcDtyZXNlcnZl
ZD0wDQo+Pj4gdGhlIHJlc3VsdGluZyBjb2RlIGVuZHMgdXAgbm90IGlubGluaW5nIHRoZSBmdW5j
dGlvbnMgdGhlbXNlbHZlcw0KPj4gd2hpY2gNCj4+PiB1c2UgdGhpcyBtYWNyby4gSS5lLiwgeW91
IHNlZSBhIENBTEwgPGZ1bmN0aW9uPiBpbnN0ZWFkIG9mIGl0cyBib2R5DQo+Pj4gZ2V0dGluZyBp
bmxpbmVkIGRpcmVjdGx5Lg0KPj4+IA0KPj4+IEV2ZW4gdGhvdWdoIGl0IHNob3VsZCBiZSBiZWNh
dXNlIHRoZSBhY3R1YWwgaW5zdHJ1Y3Rpb25zIGFyZSBvbmx5IGENCj4+PiBjb3VwbGUgaW4gbW9z
dCBjYXNlcyBhbmQgYWxsIHRob3NlIG90aGVyIGRpcmVjdGl2ZXMgZW5kIHVwIGluIGFub3RoZXIN
Cj4+PiBzZWN0aW9uIGFueXdheS4NCj4+PiANCj4+PiBUaGUgaXNzdWUgaXMgZXhwbGFpbmVkIGJl
bG93IGluIHRoZSBmb3J3YXJkZWQgbWFpbCBpbiBhIGxhcmdlciBkZXRhaWwNCj4+PiB0b28uDQo+
Pj4gDQo+Pj4gTm93LCBSaWNoYXJkIHN1Z2dlc3RlZCBkb2luZyBzb21ldGhpbmcgbGlrZToNCj4+
PiANCj4+PiAxKSBpbmxpbmUgYXNtICgiLi4uIikNCj4+PiAyKSBhc20gKCIuLi4iIDogOiA6IDog
PHNpemUtZXhwcj4pDQo+Pj4gMykgYXNtICgiLi4uIikgX19hdHRyaWJ1dGVfXygoYXNtX3NpemUo
PHNpemUtZXhwcj4pKSk7DQo+Pj4gDQo+Pj4gd2l0aCB3aGljaCB1c2VyIGNhbiB0ZWxsIGdjYyB3
aGF0IHRoZSBzaXplIG9mIHRoYXQgaW5saW5lIGFzbQ0KPj4gc3RhdGVtZW50DQo+Pj4gaXMgYW5k
IHRodXMgYWxsb3cgZm9yIG1vcmUgcHJlY2lzZSBjb3N0IGVzdGltYXRpb24gYW5kIGluIHRoZSBl
bmQNCj4+IGJldHRlcg0KPj4+IGlubGluaW5nLg0KPj4+IA0KPj4+IEFuZCBGV0lXIDMpIGxvb2tz
IHByZXR0eSBzdHJhaWdodC1mb3J3YXJkIHRvIG1lIGJlY2F1c2UgYXR0cmlidXRlcw0KPj4gYXJl
DQo+Pj4gcHJldHR5IGNvbW1vbiBhbnl3YXlzLg0KPj4+IA0KPj4+IEJ1dCBJJ20gc3VyZSB0aGVy
ZSBhcmUgb3RoZXIgb3B0aW9ucyBhbmQgSSdtIHN1cmUgcGVvcGxlIHdpbGwgaGF2ZQ0KPj4+IGJl
dHRlci9kaWZmZXJlbnQgaWRlYXMgc28gZmVlbCBmcmVlIHRvIGNoaW1lIGluLg0KPj4gDQo+PiBU
aGFua3MgZm9yIHRha2luZyBjYXJlIG9mIGl0LiBJIHdvdWxkIGxpa2UgdG8gbWVudGlvbiBhIHNl
Y29uZCBpc3N1ZSwNCj4+IHNpbmNlDQo+PiB5b3UgbWF5IHdhbnQgdG8gcmVzb2x2ZSBib3RoIHdp
dGggYSBzaW5nbGUgc29sdXRpb246IG5vdCBpbmxpbmluZw0KPj4gY29uZGl0aW9uYWwgX19idWls
dGluX2NvbnN0YW50X3AoKSwgaW4gd2hpY2ggdGhlcmUgYXJlIHR3byBjb2RlLXBhdGhzIC0NCj4+
IG9uZQ0KPj4gZm9yIGNvbnN0YW50cyBhbmQgb25lIGZvciB2YXJpYWJsZXMuDQo+PiANCj4+IENv
bnNpZGVyIGZvciBleGFtcGxlIHRoZSBMaW51eCBrZXJuZWwgaWxvZzIgbWFjcm8sIHdoaWNoIGhh
cyBhDQo+PiBjb25kaXRpb24NCj4+IGJhc2VkIG9uIF9fYnVpbHRpbl9jb25zdGFudF9wKCkgKA0K
Pj4gaHR0cHM6Ly9uYTAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0
cHMlM0ElMkYlMkZlbGl4aXIuYm9vdGxpbi5jb20lMkZsaW51eCUyRnY0LjE5LXJjNyUyRnNvdXJj
ZSUyRmluY2x1ZGUlMkZsaW51eCUyRmxvZzIuaCUyM0wxNjAmYW1wO2RhdGE9MDIlN0MwMSU3Q25h
bWl0JTQwdm13YXJlLmNvbSU3Qzg2MDQwM2NlY2I4NzRkYjY0YjdlMDhkNjJjNzQ2ZjQ2JTdDYjM5
MTM4Y2EzY2VlNGI0YWE0ZDZjZDgzZDlkZDYyZjAlN0MxJTdDMCU3QzYzNjc0NTI3NTk3NTUxNTM4
NiZhbXA7c2RhdGE9SGszOVphOSUyRnhjRnlLMHNHRU5CMjRkNlF5U2pzREd6RiUyRndxam5VRU1p
R2slM0QmYW1wO3Jlc2VydmVkPTANCj4+ICkuIFRoZSBjb21waWxlciBtaXN0YWtlbmx5IGNvbnNp
ZGVycyB0aGUg4oCcaGVhdnnigJ0gY29kZS1wYXRoIHRoYXQgaXMNCj4+IHN1cHBvc2VkDQo+PiB0
byBiZSBldmFsdWF0ZWQgb25seSBpbiBjb21waWxhdGlvbiB0aW1lIHRvIGV2YWx1YXRlIHRoZSBj
b2RlIHNpemUuDQo+IA0KPiBCdXQgdGhpcyBpcyBhIG1pc2NvbmNlcHRpb24gYWJvdXQgX19idWls
dGluX2NvbnN0YW50X3AuIEl0IGRvZXNuJ3QgZ3VhcmQgc3RoIGxpa2UgJ2NvbnN0ZXhwcicgcmVn
aW9ucy4gSWYgeW91IHRyeSB0byB1c2UgaXQgd2l0aCB0aG9zZSBzZW1hbnRpY3MgeW91J2xsIGZh
aWwgKGFwcGVhcmFudGx5IHlvdSBkbykuIA0KPiANCj4gT2YgY291cnNlIElQQSBDUCBjb2RlIHNp
emUgZXN0aW1hdGVzIHdoZW4gc2VlaW5nIGEgY29uc3RhbnQgZmVkIHRvIGJjcCBtaWdodCBiZSBu
b3Qgb3B0aW1hbCwgdGhhdCdzIGFub3RoZXIgaXNzdWUgb2YgY291cnNlLiANCg0KSSB1bmRlcnN0
YW5kIHRoYXQgdGhpcyBpcyBtaWdodCBub3QgYmUgdGhlIHJpZ2h0IHdheSB0byBpbXBsZW1lbnQg
bWFjcm9zDQpzdWNoIGFzIGlsb2cyKCkgYW5kIHRlc3RfYml0KCksIGJ1dCB0aGlzIGNvZGUgaXMg
YXJvdW5kIGZvciBzb21lIHRpbWUuDQoNCkkgdGhvdWdodCBvZiB1c2luZyBfX2J1aWx0aW5fY2hv
b3NlX2V4cHIoKSBpbnN0ZWFkIG9mIHRlcm5hcnkgb3BlcmF0b3IsIGJ1dA0KdGhpcyBpbnRyb2R1
Y2VzIGEgZGlmZmVyZW50IHByb2JsZW0sIGFzIHRoZSB2YXJpYWJsZSB2ZXJzaW9uIGlzIHVzZWQg
aW5zdGVhZA0Kb2YgdGhlIGNvbnN0YW50IG9uZSBpbiBtYW55IGNhc2VzLiBGcm9tIG15IGJyaWVm
IGV4cGVyaW1lbnRzIHdpdGggbGx2bSwgaXQNCmFwcGVhcnMgdGhhdCBsbHZtIGRvZXMgbm90IGhh
dmUgYm90aCBvZiB0aGVzZSBpc3N1ZXMgKHdyb25nIGNvc3QgYXR0cmlidXRlZA0KdG8gaW5saW5l
IGFzbSBhbmQgY29uZGl0aW9ucyBiYXNlZCBvbiBfX2J1aWx0aW5fY29uc3RhbnRfcCgpKS4NCg0K
U28gd2hhdCBhbHRlcm5hdGl2ZSBkbyB5b3UgcHJvcG9zZSB0byBpbXBsZW1lbnQgaWxvZzIoKSBs
aWtlIGJlaGF2aW9yPyBJIHdhcw0KZGlnZ2luZyB0aHJvdWdoIHRoZSBnY2MgY29kZSB0byBmaW5k
IGEgd29ya2Fyb3VuZCB3aXRoIG5vIHN1Y2Nlc3MuDQoNClRoYW5rcywNCk5hZGF2DQoNCg==
