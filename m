Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C42C00449
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 16:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A91252088F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 16:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="l47NTo/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A91252088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbeJGXRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 19:17:22 -0400
Received: from mail-bn3nam01on0083.outbound.protection.outlook.com ([104.47.33.83]:13371
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726448AbeJGXRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 19:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVK77SHQnu9CtD7dzBxYg4Jym8gbgoJOu0JlrvXW9P8=;
 b=l47NTo/4fkTNm7SzX3akugirNwUJbgWBJNFkBzp2r0OsQzVCyVXaTKcG9uO/dFeIIukUH97tEX02gAhTJlYveRaKhiz3CqWSPOlFjqfMoTYocqIwqW1CG7HdJn6Qak8ph7BKB1+0Do61PIL6WO+1qV/nXQeY+GrSv3KNHlQsGTA=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5222.namprd05.prod.outlook.com (20.177.231.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.8; Sun, 7 Oct 2018 16:09:30 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2%3]) with mapi id 15.20.1207.018; Sun, 7 Oct 2018
 16:09:30 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Borislav Petkov <bp@alien8.de>,
        "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>,
        Richard Biener <rguenther@suse.de>, Michael Matz <matz@suse.de>
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
Thread-Index: AQHUXh6xHKcwa4kgSkWbM7cjy/hJdqUT9AEA
Date:   Sun, 7 Oct 2018 16:09:30 +0000
Message-ID: <4F2F1BCE-7875-4160-9E1E-9F8EF962D989@vmware.com>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181007091805.GA30687@zn.tnic>
In-Reply-To: <20181007091805.GA30687@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:647:4580:b719:b1a8:53e8:5777:92c5]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5222;20:HOMRvJtDF1sjmbeNvdLx7k9wfzFNz0KD2EOYQOiuzcgnHUgWN/8F9lmjNjht8Utgy0Bu1lsmexkntwuyT7fwsLkaYZufILiSqpRMGZh+ycM2U+djvD2FY7coT2v0lOYa74jxeub14Sbz08asNZltN1LulJPISOVOAtFlo3OUcXQ=
x-ms-office365-filtering-correlation-id: 6243efcc-6ab5-4d45-9b9c-08d62c6f43cb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5222;
x-ms-traffictypediagnostic: BYAPR05MB5222:
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB522241EE51F97B42167E7E35D0E50@BYAPR05MB5222.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(219752817060721)(189930954265078);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991055);SRVR:BYAPR05MB5222;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB5222;
x-forefront-prvs: 0818724663
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(86362001)(76176011)(2906002)(256004)(39060400002)(25786009)(6506007)(82746002)(4326008)(478600001)(8936002)(99286004)(6512007)(45080400002)(97736004)(106356001)(102836004)(5250100002)(316002)(476003)(7416002)(6116002)(966005)(6246003)(110136005)(486006)(14454004)(54906003)(2616005)(2501003)(46003)(6346003)(229853002)(6486002)(11346002)(6436002)(2900100001)(305945005)(186003)(7736002)(83716004)(71190400001)(105586002)(446003)(71200400001)(5660300001)(8676002)(33656002)(81166006)(81156014)(53936002)(6306002)(68736007)(36756003)(200143003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5222;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-microsoft-antispam-message-info: 9exe5Gf3m21Wq0nuKZ8GIKf2PosM0+1+X6wBgDHuA8DrUkl7UI7TJSV1DxURG+rEqG7EvWc6I2RJF6dMFt1t/p28M9jtUUbex21/FerKBsyqcYe4NGrht5wSm4K6M0Y2+G6JhqUxue/ks/+PIw0y+uD6KCdU5wGrBefLaR/9rnb3BRnA/5F3429HN8HHDGJq6RTnPKg1BycU5+jB+KEziYtaOY96QkmbXU5q7mO6DZVlFdNqWE1fkxmRZZIYaFdV6e2mxCEoysqeNW4vucUSOGxY0xHCKZlUiGOpvB+H+i2IbNFkwUM7bg/zD1FYDnLPYh6TZAccjweCp175QaI6Ar/PTp1fWmsSmka0ScsqTCc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <94027636BB8A334E9165C9BF3FF18CC7@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6243efcc-6ab5-4d45-9b9c-08d62c6f43cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2018 16:09:30.7881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5222
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgMjoxOCBBTSwgQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+IHdyb3RlOg0KDQo+IEhp
IHBlb3BsZSwNCj4gDQo+IHRoaXMgaXMgYW4gYXR0ZW1wdCB0byBzZWUgd2hldGhlciBnY2MncyBp
bmxpbmUgYXNtIGhldXJpc3RpYyB3aGVuDQo+IGVzdGltYXRpbmcgaW5saW5lIGFzbSBzdGF0ZW1l
bnRzJyBjb3N0IGZvciBiZXR0ZXIgaW5saW5pbmcgY2FuIGJlDQo+IGltcHJvdmVkLg0KPiANCj4g
QUZBSVUsIHRoZSBwcm9ibGVtYXRpYyBhcmlzZXMgd2hlbiBvbmUgZW5kcyB1cCB1c2luZyBhIGxv
dCBvZiBpbmxpbmUNCj4gYXNtIHN0YXRlbWVudHMgaW4gdGhlIGtlcm5lbCBidXQgZHVlIHRvIHRo
ZSBpbmxpbmUgYXNtIGNvc3QgZXN0aW1hdGlvbg0KPiBoZXVyaXN0aWMgd2hpY2ggY291bnRzIGxp
bmVzLCBJIHRoaW5rLCBmb3IgZXhhbXBsZSBsaWtlIGluIHRoaXMgaGVyZQ0KPiBtYWNybzoNCj4g
DQo+IGh0dHBzOi8vbmEwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0
dHBzJTNBJTJGJTJGZ2l0Lmtlcm5lbC5vcmclMkZwdWIlMkZzY20lMkZsaW51eCUyRmtlcm5lbCUy
RmdpdCUyRnRvcnZhbGRzJTJGbGludXguZ2l0JTJGdHJlZSUyRmFyY2glMkZ4ODYlMkZpbmNsdWRl
JTJGYXNtJTJGY3B1ZmVhdHVyZS5oJTIzbjE2MiZhbXA7ZGF0YT0wMiU3QzAxJTdDbmFtaXQlNDB2
bXdhcmUuY29tJTdDNmRiMTI1OGM2NWVhNDViYmU0ZWEwOGQ2MmMzNWNlZWMlN0NiMzkxMzhjYTNj
ZWU0YjRhYTRkNmNkODNkOWRkNjJmMCU3QzElN0MwJTdDNjM2NzQ1MDA3MDA2ODM4Mjk5JmFtcDtz
ZGF0YT1pZWhsJTJGYjhoJTJCWkUlMkZycWI0cWphYzE5V2VrU2dPT2JjOSUyQk0xSnRvMVZnRjQl
M0QmYW1wO3Jlc2VydmVkPTANCj4gDQo+IHRoZSByZXN1bHRpbmcgY29kZSBlbmRzIHVwIG5vdCBp
bmxpbmluZyB0aGUgZnVuY3Rpb25zIHRoZW1zZWx2ZXMgd2hpY2gNCj4gdXNlIHRoaXMgbWFjcm8u
IEkuZS4sIHlvdSBzZWUgYSBDQUxMIDxmdW5jdGlvbj4gaW5zdGVhZCBvZiBpdHMgYm9keQ0KPiBn
ZXR0aW5nIGlubGluZWQgZGlyZWN0bHkuDQo+IA0KPiBFdmVuIHRob3VnaCBpdCBzaG91bGQgYmUg
YmVjYXVzZSB0aGUgYWN0dWFsIGluc3RydWN0aW9ucyBhcmUgb25seSBhDQo+IGNvdXBsZSBpbiBt
b3N0IGNhc2VzIGFuZCBhbGwgdGhvc2Ugb3RoZXIgZGlyZWN0aXZlcyBlbmQgdXAgaW4gYW5vdGhl
cg0KPiBzZWN0aW9uIGFueXdheS4NCj4gDQo+IFRoZSBpc3N1ZSBpcyBleHBsYWluZWQgYmVsb3cg
aW4gdGhlIGZvcndhcmRlZCBtYWlsIGluIGEgbGFyZ2VyIGRldGFpbA0KPiB0b28uDQo+IA0KPiBO
b3csIFJpY2hhcmQgc3VnZ2VzdGVkIGRvaW5nIHNvbWV0aGluZyBsaWtlOg0KPiANCj4gMSkgaW5s
aW5lIGFzbSAoIi4uLiIpDQo+IDIpIGFzbSAoIi4uLiIgOiA6IDogOiA8c2l6ZS1leHByPikNCj4g
MykgYXNtICgiLi4uIikgX19hdHRyaWJ1dGVfXygoYXNtX3NpemUoPHNpemUtZXhwcj4pKSk7DQo+
IA0KPiB3aXRoIHdoaWNoIHVzZXIgY2FuIHRlbGwgZ2NjIHdoYXQgdGhlIHNpemUgb2YgdGhhdCBp
bmxpbmUgYXNtIHN0YXRlbWVudA0KPiBpcyBhbmQgdGh1cyBhbGxvdyBmb3IgbW9yZSBwcmVjaXNl
IGNvc3QgZXN0aW1hdGlvbiBhbmQgaW4gdGhlIGVuZCBiZXR0ZXINCj4gaW5saW5pbmcuDQo+IA0K
PiBBbmQgRldJVyAzKSBsb29rcyBwcmV0dHkgc3RyYWlnaHQtZm9yd2FyZCB0byBtZSBiZWNhdXNl
IGF0dHJpYnV0ZXMgYXJlDQo+IHByZXR0eSBjb21tb24gYW55d2F5cy4NCj4gDQo+IEJ1dCBJJ20g
c3VyZSB0aGVyZSBhcmUgb3RoZXIgb3B0aW9ucyBhbmQgSSdtIHN1cmUgcGVvcGxlIHdpbGwgaGF2
ZQ0KPiBiZXR0ZXIvZGlmZmVyZW50IGlkZWFzIHNvIGZlZWwgZnJlZSB0byBjaGltZSBpbi4NCg0K
VGhhbmtzIGZvciB0YWtpbmcgY2FyZSBvZiBpdC4gSSB3b3VsZCBsaWtlIHRvIG1lbnRpb24gYSBz
ZWNvbmQgaXNzdWUsIHNpbmNlDQp5b3UgbWF5IHdhbnQgdG8gcmVzb2x2ZSBib3RoIHdpdGggYSBz
aW5nbGUgc29sdXRpb246IG5vdCBpbmxpbmluZw0KY29uZGl0aW9uYWwgX19idWlsdGluX2NvbnN0
YW50X3AoKSwgaW4gd2hpY2ggdGhlcmUgYXJlIHR3byBjb2RlLXBhdGhzIC0gb25lDQpmb3IgY29u
c3RhbnRzIGFuZCBvbmUgZm9yIHZhcmlhYmxlcy4NCg0KQ29uc2lkZXIgZm9yIGV4YW1wbGUgdGhl
IExpbnV4IGtlcm5lbCBpbG9nMiBtYWNybywgd2hpY2ggaGFzIGEgY29uZGl0aW9uDQpiYXNlZCBv
biBfX2J1aWx0aW5fY29uc3RhbnRfcCgpICgNCmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xp
bnV4L3Y0LjE5LXJjNy9zb3VyY2UvaW5jbHVkZS9saW51eC9sb2cyLmgjTDE2MA0KKS4gVGhlIGNv
bXBpbGVyIG1pc3Rha2VubHkgY29uc2lkZXJzIHRoZSDigJxoZWF2eeKAnSBjb2RlLXBhdGggdGhh
dCBpcyBzdXBwb3NlZA0KdG8gYmUgZXZhbHVhdGVkIG9ubHkgaW4gY29tcGlsYXRpb24gdGltZSB0
byBldmFsdWF0ZSB0aGUgY29kZSBzaXplLiBUaGlzDQpjYXVzZXMgdGhlIGtlcm5lbCB0byBjb25z
aWRlciBmdW5jdGlvbnMgc3VjaCBhcyBrbWFsbG9jKCkgYXMg4oCcYmln4oCdLg0Ka21hbGxvYygp
IGlzIG1hcmtlZCB3aXRoIGFsd2F5c19pbmxpbmUgYXR0cmlidXRlLCBzbyBpbnN0ZWFkIHRoZSBj
YWxsaW5nDQpmdW5jdGlvbnMsIHN1Y2ggYXMga3phbGxvYygpIGFyZSBub3QgaW5saW5lZC4NCg0K
V2hlbiBJIHRob3VnaHQgYWJvdXQgaGFja2luZyBnY2MgdG8gc29sdmUgdGhpcyBpc3N1ZSwgSSBj
b25zaWRlcmVkIGFuDQppbnRyaW5zaWMgdGhhdCB3b3VsZCBvdmVycmlkZSB0aGUgY29zdCBvZiBh
IGdpdmVuIHN0YXRlbWVudC4gVGhpcyBzb2x1dGlvbg0KaXMgbm90IHRvbyBuaWNlLCBidXQgbWF5
IHNvbHZlIGJvdGggaXNzdWVzLg0KDQpJbiBhZGRpdGlvbiwgbm90ZSB0aGF0IEFGQUlVIHRoZSBp
bXBhY3Qgb2YgYSB3cm9uZyBjb3N0IG9mIGNvZGUgZXN0aW1hdGlvbg0KY2FuIGFsc28gaW1wYWN0
IGxvb3AgYW5kIG90aGVyIG9wdGltaXphdGlvbnMuDQoNClJlZ2FyZHMsDQpOYWRhdg==
