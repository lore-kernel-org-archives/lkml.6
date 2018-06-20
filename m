Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94088C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF2120846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="d3BFYiNo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF2120846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932628AbeFTQrZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 12:47:25 -0400
Received: from mail-eopbgr720070.outbound.protection.outlook.com ([40.107.72.70]:64640
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932082AbeFTQrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 12:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/BPpXpT0PtKTohJDufNw0Q1V+oLHeliwsVDLBoIbCI=;
 b=d3BFYiNoPmBc+STrZrxddfr7oBKs2aL2kjOrkJguftnLgK4zwI8avRVXk6mLo7v3S0iuJEJLhRrzk2qaPsSshI/AzztXJrGLieIbYqOc8VUfhc79K2P3HXOiWaLIL7R+lcXd7i9WIms+6w5kscIvhfy7H8L7vpu7b/UGofoBiJI=
Received: from BL0PR05MB4772.namprd05.prod.outlook.com (20.177.145.81) by
 BL0PR05MB4836.namprd05.prod.outlook.com (52.132.15.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.15; Wed, 20 Jun 2018 16:47:18 +0000
Received: from BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::9cb3:7cc0:9f85:b1c7]) by BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::9cb3:7cc0:9f85:b1c7%2]) with mapi id 15.20.0884.010; Wed, 20 Jun 2018
 16:47:18 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alok Kataria <akataria@vmware.com>,
        Christopher Li <sparse@chrisli.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v5 0/9] x86: macrofying inline asm for better compilation
Thread-Topic: [PATCH v5 0/9] x86: macrofying inline asm for better compilation
Thread-Index: AQHUCENUf7+CLXMRGUm2psuBIQhIHaRo7XSAgABut4A=
Date:   Wed, 20 Jun 2018 16:47:18 +0000
Message-ID: <AEBE7B6B-0E78-4018-A347-8DCFE4C60E0D@vmware.com>
References: <20180619194854.69486-1-namit@vmware.com>
 <20180620101101.GB2530@hirez.programming.kicks-ass.net>
In-Reply-To: <20180620101101.GB2530@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR05MB4836;7:+BP6cxUI1F4YvAceA4V2Z6jd+C38NjVV6GKHtI/ix1xUx/iYOC1hIfz/+tHhZFk0qR0NZkGT+7eh7tFPwtSBa6yodaHI/2kR/G/i1Nt0YCfGwuFhrUIwVb0IAdu0DD+dCRhSawresRgWDNENCY+m7BDkBX2wvICxHwLpNOUABIfZ/OOVpnknpvzE6uqHilnCpFT3BhHsvmj+FJNtB5ATVOOZ8z4ImRFIBGT9OPBky2pZPQRfWre1R2+fZv+jqV6q;20:FDnaCH3YiPLatV1TrePKCAGcB13RrUS32TwiDzucz07iv+G7gwNPCyNP6OxOSvvw94QXa6XnoLgr5+wO00jx0q2KMFWzuKpT6nRYdooaeeOLOqU78hdYDFvsXoQRVKLfCB/yLuKLiXhGSThDIwlwMCp6WbxX50ZNFxki3PE4bDQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 51d29270-935d-4d5e-a01d-08d5d6cd7c72
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:BL0PR05MB4836;
x-ms-traffictypediagnostic: BL0PR05MB4836:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-microsoft-antispam-prvs: <BL0PR05MB48360327C534465C7FD82A20D0770@BL0PR05MB4836.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR05MB4836;BCL:0;PCL:0;RULEID:;SRVR:BL0PR05MB4836;
x-forefront-prvs: 070912876F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(39380400002)(396003)(366004)(189003)(199004)(5250100002)(2900100001)(7736002)(186003)(36756003)(14454004)(3660700001)(478600001)(26005)(6506007)(316002)(54906003)(305945005)(229853002)(5660300001)(3846002)(102836004)(76176011)(2906002)(8936002)(99286004)(81156014)(81166006)(3280700002)(6116002)(6916009)(8676002)(7416002)(82746002)(33656002)(106356001)(105586002)(6512007)(11346002)(446003)(2616005)(53936002)(476003)(4326008)(6486002)(25786009)(6246003)(6436002)(83716003)(68736007)(97736004)(86362001)(486006)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR05MB4836;H:BL0PR05MB4772.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: M4PyTgQMjCL2RycHOWPMn/ELuV4HdGOEu71QQjLpju1GSEH0lZiB3y1KkqDT/oeXvZV9CyOkYJkv0MfVhfMvW4Tmt34gvx0yqQi2cPrroIIYS/HOa+6dHP/d9tNEMxCTJZ8jyKrprK6pSbMyV/JoC/9VNUXiLlY673+c6Qh5hqTABQXXLFj07Rhn3BOzypdjn+n8E8dyCXXC04DixJkwRlQJDDtUMKk0LG7krKhofoeEwsToVPxypJtSPH3ymRl6b+CE7uj5+1vzQEAMc7d0fAL/rxaTVGWG0meJiEf1mjRkuSAUnE4hM3Ym59qSu251
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8D911AD57C47E4CBDD83B14BD4672F1@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d29270-935d-4d5e-a01d-08d5d6cd7c72
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2018 16:47:18.5198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR05MB4836
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgMzoxMSBBTSwgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPiB3cm90ZToN
Cg0KPiBPbiBUdWUsIEp1biAxOSwgMjAxOCBhdCAxMjo0ODo0NVBNIC0wNzAwLCBOYWRhdiBBbWl0
IHdyb3RlOg0KPj4gTmFkYXYgQW1pdCAoOSk6DQo+PiAgTWFrZWZpbGU6IFByZXBhcmUgZm9yIHVz
aW5nIG1hY3JvcyBmb3IgaW5saW5lIGFzbQ0KPj4gIHg4Njogb2JqdG9vbDogdXNlIGFzbSBtYWNy
byBmb3IgYmV0dGVyIGNvbXBpbGVyIGRlY2lzaW9ucw0KPj4gIHg4NjogcmVmY291bnQ6IHByZXZl
bnQgZ2NjIGRpc3RvcnRpb25zDQo+PiAgeDg2OiBhbHRlcm5hdGl2ZXM6IG1hY3JvZnkgbG9ja3Mg
Zm9yIGJldHRlciBpbmxpbmluZw0KPj4gIHg4NjogYnVnOiBwcmV2ZW50IGdjYyBkaXN0b3J0aW9u
cw0KPj4gIHg4NjogcHJldmVudCBpbmxpbmUgZGlzdG9ydGlvbiBieSBwYXJhdmlydCBvcHMNCj4+
ICB4ODY6IGV4dGFibGU6IHVzZSBtYWNyb3MgaW5zdGVhZCBvZiBpbmxpbmUgYXNzZW1ibHkNCj4+
ICB4ODY6IGNwdWZlYXR1cmU6IHVzZSBtYWNyb3MgaW5zdGVhZCBvZiBpbmxpbmUgYXNzZW1ibHkN
Cj4+ICB4ODY6IGp1bXAtbGFiZWxzOiB1c2UgbWFjcm9zIGluc3RlYWQgb2YgaW5saW5lIGFzc2Vt
Ymx5DQo+PiANCj4+IE1ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDkg
KystDQo+PiBhcmNoL3g4Ni9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICB8IDExICsrLQ0K
Pj4gYXJjaC94ODYvaW5jbHVkZS9hc20vYWx0ZXJuYXRpdmUtYXNtLmggfCAyMCArKysrLS0NCj4+
IGFyY2gveDg2L2luY2x1ZGUvYXNtL2FsdGVybmF0aXZlLmggICAgIHwgMTEgKy0tDQo+PiBhcmNo
L3g4Ni9pbmNsdWRlL2FzbS9hc20uaCAgICAgICAgICAgICB8IDYxICsrKysrKystLS0tLS0tLS0N
Cj4+IGFyY2gveDg2L2luY2x1ZGUvYXNtL2J1Zy5oICAgICAgICAgICAgIHwgOTggKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0NCj4+IGFyY2gveDg2L2luY2x1ZGUvYXNtL2NwdWZlYXR1cmUuaCAg
ICAgIHwgODIgKysrKysrKysrKysrLS0tLS0tLS0tDQo+PiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9q
dW1wX2xhYmVsLmggICAgICB8IDY1ICsrKysrKysrKystLS0tLS0tDQo+PiBhcmNoL3g4Ni9pbmNs
dWRlL2FzbS9wYXJhdmlydF90eXBlcy5oICB8IDU2ICsrKysrKystLS0tLS0tLQ0KPj4gYXJjaC94
ODYvaW5jbHVkZS9hc20vcmVmY291bnQuaCAgICAgICAgfCA3NCArKysrKysrKysrKy0tLS0tLS0t
DQo+PiBhcmNoL3g4Ni9rZXJuZWwvbWFjcm9zLlMgICAgICAgICAgICAgICB8IDE2ICsrKysrDQo+
PiBpbmNsdWRlL2FzbS1nZW5lcmljL2J1Zy5oICAgICAgICAgICAgICB8ICA4ICstLQ0KPj4gaW5j
bHVkZS9saW51eC9jb21waWxlci5oICAgICAgICAgICAgICAgfCA1NiArKysrKysrKysrKy0tLS0N
Cj4+IHNjcmlwdHMvS2J1aWxkLmluY2x1ZGUgICAgICAgICAgICAgICAgIHwgIDQgKy0NCj4+IHNj
cmlwdHMvbW9kL01ha2VmaWxlICAgICAgICAgICAgICAgICAgIHwgIDIgKw0KPj4gMTUgZmlsZXMg
Y2hhbmdlZCwgMzQwIGluc2VydGlvbnMoKyksIDIzMyBkZWxldGlvbnMoLSkNCj4+IGNyZWF0ZSBt
b2RlIDEwMDY0NCBhcmNoL3g4Ni9rZXJuZWwvbWFjcm9zLlMNCj4gDQo+IEFzaWRlIGZyb20gdGhl
IG9uZSBuaWdnbGU6DQo+IA0KPiBBY2tlZC1ieTogUGV0ZXIgWmlqbHN0cmEgKEludGVsKSA8cGV0
ZXJ6QGluZnJhZGVhZC5vcmc+DQoNClRoYW5rcyEgSSBhcHBsaWVkIHlvdXIgY29tbWVudHMgZm9y
IHBhdGNoZXMgNiAmIDkuIEkgd2lsbCBzZW5kIGFub3RoZXINCnZlcnNpb24gbGF0ZXIgdG9kYXku
DQoNCkkgaGF2ZSBzb21lIG90aGVyIHBhdGNoZXMgdGhhdCBhZGRyZXNzIGlubGluaW5nIGlzc3Vl
cyBhbmQgY29kZSByZWR1bmRhbmN5DQpmb3IgdGhlIGFsdGVybmF0aXZlIG1lY2hhbmlzbSBhbmQg
dGhlIFJTQiBzdHVmZmluZyBjb2RlLCBidXQgSeKAmWxsIHNlbmQgdGhlbQ0KYWZ0ZXIgdGhpcyBz
ZXQgaXMgYXBwbGllZC4NCg0KUmVnYXJkcywNCk5hZGF2
