Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97778C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 457C32081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="XvYDeDCg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 457C32081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeK2NJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 08:09:52 -0500
Received: from mail-eopbgr800053.outbound.protection.outlook.com ([40.107.80.53]:58720
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726929AbeK2NJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 08:09:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3A7+BGCqkAFeu1xRhL/YWPCRxsokaInRcOoD9ODYJPk=;
 b=XvYDeDCggkRrwa2tucslvOnLGWQbSkgqfyia8EG6O3dGGl//6OaJQBwvcIjGzG+N1moFGaxIpsp8/2PpZPl0MGBjg9R9hqz3yAT7gkS4JFvwpNL2qQI6o9rWlsYNRBT8VTp4u6kPhis9IBOEHFLS2a+BHjB7AYmBXLDZa4Myb04=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4983.namprd05.prod.outlook.com (20.177.230.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.13; Thu, 29 Nov 2018 02:06:05 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d%4]) with mapi id 15.20.1404.008; Thu, 29 Nov 2018
 02:06:05 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
Subject: Re: [RFC PATCH 0/5] x86: dynamic indirect call promotion
Thread-Topic: [RFC PATCH 0/5] x86: dynamic indirect call promotion
Thread-Index: AQHUZn1la/DbvW2wT0Gh22Ko/9s6YqVlnFCAgAA5kgCAAFTegIAAEToAgAAHNQA=
Date:   Thu, 29 Nov 2018 02:06:05 +0000
Message-ID: <0E75C656-18BF-4967-98A3-35E0BD83D603@vmware.com>
References: <20181018005420.82993-1-namit@vmware.com>
 <20181128160849.epmoto4o5jaxxxol@treble>
 <9EACED43-EC21-41FB-BFAC-4E98C3842FD9@vmware.com>
 <20181129003837.6lgxsnhoyipkebmz@treble>
 <CALCETrUfC37TxuYLgqbN3_pZ1RzfpV03byKMpSt87o+JHtk6FQ@mail.gmail.com>
In-Reply-To: <CALCETrUfC37TxuYLgqbN3_pZ1RzfpV03byKMpSt87o+JHtk6FQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4983;20:Rufau3pwWXx4svmw0dduzFCOLKRrIK22kiq3dX1CdcVL7xkbtoq5jKQ2dJsDep6UfGEKXynJs92w6H/gWMrRe5k8WtSqZ+uSQTfDQ5kJlVXhejK7rA6p7GPWOGpimvtrslG7xvoV6Vosm/3tC27alTHzIJRb7s+4NvC/D89QTSg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 08b68c59-de31-44f9-1579-08d6559f38b0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4983;
x-ms-traffictypediagnostic: BYAPR05MB4983:
x-microsoft-antispam-prvs: <BYAPR05MB49834A8A9BDF937A51152039D0D20@BYAPR05MB4983.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231453)(999002)(944501410)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB4983;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4983;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(396003)(376002)(39860400002)(199004)(189003)(76176011)(53546011)(106356001)(2906002)(105586002)(486006)(14454004)(99286004)(6116002)(82746002)(217873002)(6506007)(256004)(11346002)(102836004)(26005)(14444005)(186003)(93886005)(305945005)(2616005)(5660300001)(36756003)(66066001)(81156014)(68736007)(25786009)(6512007)(97736004)(8676002)(8936002)(478600001)(6486002)(7736002)(4326008)(81166006)(53936002)(33656002)(229853002)(3846002)(6916009)(446003)(54906003)(86362001)(71200400001)(476003)(6436002)(83716004)(71190400001)(7416002)(316002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4983;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NdWwhypP8AwPQL7lDpNBhCxe+1jAviWJr7dfcY7lX/wuf2x2XE0g8A7vfHqBqt6LCv+32/EonXxpmjr3sqFFvrHCOAJ1e6hGIPE05ETiWJN9Sv46Lpl2e9ZP+68nj5vtIWImSRZ+c10fogW3YkAoxlMv81pPlbjses4YKTGURtUUKluddE4G1Sr6tBSBn/aKRaLdO4mVoMXTqt5wCBiGiCdCrrxSDcNrhN+VRBv4mvq4pFlypqwxdS28hZg86NFg+N8iFSjsU6MDRgOW4fqsrTMUW5JzhsBL6db0RuSePTwTOQmrgmEArovyCBJPHPmIBrWbmlCJe9piZrDkIJqIrvWbAM89gifuzDQndvoWckg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9294B2DE1B634243B20DEE3701173A51@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b68c59-de31-44f9-1579-08d6559f38b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 02:06:05.7007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4983
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBOb3YgMjgsIDIwMTgsIGF0IDU6NDAgUE0sIEFuZHkgTHV0b21pcnNraSA8bHV0b0BrZXJu
ZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgTm92IDI4LCAyMDE4IGF0IDQ6MzggUE0gSm9z
aCBQb2ltYm9ldWYgPGpwb2ltYm9lQHJlZGhhdC5jb20+IHdyb3RlOg0KPj4gT24gV2VkLCBOb3Yg
MjgsIDIwMTggYXQgMDc6MzQ6NTJQTSArMDAwMCwgTmFkYXYgQW1pdCB3cm90ZToNCj4+Pj4gT24g
Tm92IDI4LCAyMDE4LCBhdCA4OjA4IEFNLCBKb3NoIFBvaW1ib2V1ZiA8anBvaW1ib2VAcmVkaGF0
LmNvbT4gd3JvdGU6DQo+Pj4+IA0KPj4+PiBPbiBXZWQsIE9jdCAxNywgMjAxOCBhdCAwNTo1NDox
NVBNIC0wNzAwLCBOYWRhdiBBbWl0IHdyb3RlOg0KPj4+Pj4gVGhpcyBSRkMgaW50cm9kdWNlcyBp
bmRpcmVjdCBjYWxsIHByb21vdGlvbiBpbiBydW50aW1lLCB3aGljaCBmb3IgdGhlDQo+Pj4+PiBt
YXR0ZXIgb2Ygc2ltcGxpZmljYXRpb24gKGFuZCBicmFuZGluZykgd2lsbCBiZSBjYWxsZWQgaGVy
ZSAicmVscG9saW5lcyINCj4+Pj4+IChyZWxhdGl2ZSBjYWxsICsgdHJhbXBvbGluZSkuIFJlbHBv
bGluZXMgYXJlIG1haW5seSBpbnRlbmRlZCBhcyBhIHdheQ0KPj4+Pj4gb2YgcmVkdWNpbmcgcmV0
cG9saW5lIG92ZXJoZWFkcyBkdWUgdG8gU3BlY3RyZSB2Mi4NCj4+Pj4+IA0KPj4+Pj4gVW5saWtl
IGluZGlyZWN0IGNhbGwgcHJvbW90aW9uIHRocm91Z2ggcHJvZmlsZSBndWlkZWQgb3B0aW1pemF0
aW9uLCB0aGUNCj4+Pj4+IHByb3Bvc2VkIGFwcHJvYWNoIGRvZXMgbm90IHJlcXVpcmUgYSBwcm9m
aWxpbmcgc3RhZ2UsIHdvcmtzIHdlbGwgd2l0aA0KPj4+Pj4gbW9kdWxlcyB3aG9zZSBhZGRyZXNz
IGlzIHVua25vd24gYW5kIGNhbiBhZGFwdCB0byBjaGFuZ2luZyB3b3JrbG9hZHMuDQo+Pj4+PiAN
Cj4+Pj4+IFRoZSBtYWluIGlkZWEgaXMgc2ltcGxlOiBmb3IgZXZlcnkgaW5kaXJlY3QgY2FsbCwg
d2UgaW5qZWN0IGEgcGllY2Ugb2YNCj4+Pj4+IGNvZGUgd2l0aCBmYXN0LSBhbmQgc2xvdy1wYXRo
IGNhbGxzLiBUaGUgZmFzdCBwYXRoIGlzIHVzZWQgaWYgdGhlIHRhcmdldA0KPj4+Pj4gbWF0Y2hl
cyB0aGUgZXhwZWN0ZWQgKGhvdCkgdGFyZ2V0LiBUaGUgc2xvdy1wYXRoIHVzZXMgYSByZXRwb2xp
bmUuDQo+Pj4+PiBEdXJpbmcgdHJhaW5pbmcsIHRoZSBzbG93LXBhdGggaXMgc2V0IHRvIGNhbGwg
YSBmdW5jdGlvbiB0aGF0IHNhdmVzIHRoZQ0KPj4+Pj4gY2FsbCBzb3VyY2UgYW5kIHRhcmdldCBp
biBhIGhhc2gtdGFibGUgYW5kIGtlZXAgY291bnQgZm9yIGNhbGwNCj4+Pj4+IGZyZXF1ZW5jeS4g
VGhlIG1vc3QgY29tbW9uIHRhcmdldCBpcyB0aGVuIHBhdGNoZWQgaW50byB0aGUgaG90IHBhdGgu
DQo+Pj4+PiANCj4+Pj4+IFRoZSBwYXRjaGluZyBpcyBkb25lIG9uLXRoZS1mbHkgYnkgcGF0Y2hp
bmcgdGhlIGNvbmRpdGlvbmFsIGJyYW5jaA0KPj4+Pj4gKG9wY29kZSBhbmQgb2Zmc2V0KSB0aGF0
IGlzIHVzZWQgdG8gY29tcGFyZSB0aGUgdGFyZ2V0IHRvIHRoZSBob3QNCj4+Pj4+IHRhcmdldC4g
VGhpcyBhbGxvd3MgdG8gZGlyZWN0IGFsbCBjb3JlcyB0byB0aGUgZmFzdC1wYXRoLCB3aGlsZSBw
YXRjaGluZw0KPj4+Pj4gdGhlIHNsb3ctcGF0aCBhbmQgdmljZS12ZXJzYS4gUGF0Y2hpbmcgZm9s
bG93cyAyIG1vcmUgcnVsZXM6ICgxKSBPbmx5DQo+Pj4+PiBwYXRjaCBhIHNpbmdsZSBieXRlIHdo
ZW4gdGhlIGNvZGUgbWlnaHQgYmUgZXhlY3V0ZWQgYnkgYW55IGNvcmUuICgyKQ0KPj4+Pj4gV2hl
biBwYXRjaGluZyBtb3JlIHRoYW4gb25lIGJ5dGUsIGVuc3VyZSB0aGF0IGFsbCBjb3JlcyBkbyBu
b3QgcnVuIHRoZQ0KPj4+Pj4gdG8tYmUtcGF0Y2hlZC1jb2RlIGJ5IHByZXZlbnRpbmcgdGhpcyBj
b2RlIGZyb20gYmVpbmcgcHJlZW1wdGVkLCBhbmQNCj4+Pj4+IHVzaW5nIHN5bmNocm9uaXplX3Nj
aGVkKCkgYWZ0ZXIgcGF0Y2hpbmcgdGhlIGJyYW5jaCB0aGF0IGp1bXBzIG92ZXIgdGhpcw0KPj4+
Pj4gY29kZS4NCj4+Pj4+IA0KPj4+Pj4gQ2hhbmdpbmcgYWxsIHRoZSBpbmRpcmVjdCBjYWxscyB0
byB1c2UgcmVscG9saW5lcyBpcyBkb25lIHVzaW5nIGFzc2VtYmx5DQo+Pj4+PiBtYWNybyBtYWdp
Yy4gVGhlcmUgYXJlIGFsdGVybmF0aXZlIHNvbHV0aW9ucywgYnV0IHRoaXMgb25lIGlzDQo+Pj4+
PiByZWxhdGl2ZWx5IHNpbXBsZSBhbmQgdHJhbnNwYXJlbnQuIFRoZXJlIGlzIGFsc28gbG9naWMg
dG8gcmV0cmFpbiB0aGUNCj4+Pj4+IHNvZnR3YXJlIHByZWRpY3RvciwgYnV0IHRoZSBwb2xpY3kg
aXQgdXNlcyBtYXkgbmVlZCB0byBiZSByZWZpbmVkLg0KPj4+Pj4gDQo+Pj4+PiBFdmVudHVhbGx5
IHRoZSByZXN1bHRzIGFyZSBub3QgYmFkICgyIFZDUFUgVk0sIHRocm91Z2hwdXQgcmVwb3J0ZWQp
Og0KPj4+Pj4gDQo+Pj4+PiAgICAgICAgICAgYmFzZSAgICAgICAgICAgIHJlbHBvbGluZQ0KPj4+
Pj4gICAgICAgICAgIC0tLS0gICAgICAgICAgICAtLS0tLS0tLS0NCj4+Pj4+IG5naW54ICAgICAg
MjI4OTggICAgICAgICAgIDI1MTc4ICgrMTAlKQ0KPj4+Pj4gcmVkaXMteWNzYiAyNDUyMyAgICAg
ICAgICAgMjU0ODYgKCs0JSkNCj4+Pj4+IGRiZW5jaCAgICAgMjE0NCAgICAgICAgICAgIDIxMDMg
KCsyJSkNCj4+Pj4+IA0KPj4+Pj4gV2hlbiByZXRwb2xpbmVzIGFyZSBkaXNhYmxlZCwgYW5kIGlm
IHJldHJhaW5pbmcgaXMgb2ZmLCBwZXJmb3JtYW5jZQ0KPj4+Pj4gYmVuZWZpdHMgYXJlIHVwIHRv
IDIlIChuZ2lueCksIGJ1dCBhcmUgbXVjaCBsZXNzIGltcHJlc3NpdmUuDQo+Pj4+IA0KPj4+PiBI
aSBOYWRhdiwNCj4+Pj4gDQo+Pj4+IFBldGVyIHBvaW50ZWQgbWUgdG8gdGhlc2UgcGF0Y2hlcyBk
dXJpbmcgYSBkaXNjdXNzaW9uIGFib3V0IHJldHBvbGluZQ0KPj4+PiBwcm9maWxpbmcuICBQZXJz
b25hbGx5LCBJIHRoaW5rIHRoaXMgaXMgYnJpbGxpYW50LiAgVGhpcyBjb3VsZCBoZWxwDQo+Pj4+
IG5ldHdvcmtpbmcgYW5kIGZpbGVzeXN0ZW0gaW50ZW5zaXZlIHdvcmtsb2FkcyBhIGxvdC4NCj4+
PiANCj4+PiBUaGFua3MhIEkgd2FzIGEgYml0IGhlbGQtYmFjayBieSB0aGUgcmVsYXRpdmVseSBs
aW1pdGVkIG51bWJlciBvZiByZXNwb25zZXMuDQo+PiANCj4+IEl0IGlzIGEgcmF0aGVyLCBlcm0s
IGFtYml0aW91cyBpZGVhLCBtYXliZSB0aGV5IHdlcmUgc3BlZWNobGVzcyA6LSkNCj4+IA0KPj4+
IEkgZmluaXNoZWQgYW5vdGhlciB2ZXJzaW9uIHR3byB3ZWVrcyBhZ28sIGFuZCBldmVyeSBkYXkg
SSB0aGluazogInNob3VsZCBpdA0KPj4+IGJlIFJGQ3YyIG9yIHYx4oCdLCBlbmRpbmcgdXAgbm90
IHNlbmRpbmcgaXTigKYNCj4+PiANCj4+PiBUaGVyZSBpcyBvbmUgaXNzdWUgdGhhdCBJIHJlYWxp
emVkIHdoaWxlIHdvcmtpbmcgb24gdGhlIG5ldyB2ZXJzaW9uOiBJ4oCZbSBub3QNCj4+PiBzdXJl
IGl0IGlzIHdlbGwtZGVmaW5lZCB3aGF0IGFuIG91dGxpbmUgcmV0cG9saW5lIGlzIGFsbG93ZWQg
dG8gZG8uIFRoZQ0KPj4+IGluZGlyZWN0IGJyYW5jaCBwcm9tb3Rpb24gY29kZSBjYW4gY2hhbmdl
IHJmbGFncywgd2hpY2ggbWlnaHQgY2F1c2UNCj4+PiBjb3JyZWN0aW9uIGlzc3Vlcy4gSW4gcHJh
Y3RpY2UsIHVzaW5nIGdjYywgaXQgaXMgbm90IGEgcHJvYmxlbS4NCj4+IA0KPj4gQ2FsbGVlcyBj
YW4gY2xvYmJlciBmbGFncywgc28gaXQgc2VlbXMgZmluZSB0byBtZS4NCj4gDQo+IEp1c3QgdG8g
Y2hlY2sgSSB1bmRlcnN0YW5kIHlvdXIgYXBwcm9hY2ggcmlnaHQ6IHlvdSBtYWRlIGEgbWFjcm8N
Cj4gY2FsbGVkICJjYWxsIiwgYW5kIHlvdSdyZSB0aGVyZWZvcmUgY2F1c2luZyBhbGwgaW5zdGFu
Y2VzIG9mICJjYWxsIiB0bw0KPiBiZWNvbWUgbWFnaWM/ICBUaGlzIGlzLi4uIHRlcnJpZnlpbmcu
ICBJdCdzIGV2ZW4gcGxhdXNpYmx5IHdvcnNlIHRoYW4NCj4gIiNkZWZpbmUgaWYiIDopICBUaGUg
c2Nhcmllc3QgYml0IGlzIHRoYXQgaXQgd2lsbCBpbXBhY3QgaW5saW5lIGFzbSBhcw0KPiB3ZWxs
LiAgTWF5YmUgYSBnY2MgcGx1Z2luIHdvdWxkIGJlIGxlc3MgYWxhcm1pbmc/DQoNCkl0IGlzIGxp
a2VseSB0byBsb29rIGxlc3MgYWxhcm1pbmcuIFdoZW4gSSBsb29rZWQgYXQgdGhlIGlubGluZSBy
ZXRwb2xpbmUNCmltcGxlbWVudGF0aW9uIG9mIGdjYywgaXQgZGlkbuKAmXQgbG9vayBtdWNoIGJl
dHRlciB0aGFuIHdoYXQgSSBkaWQgLSBpdA0KYmFzaWNhbGx5IGp1c3QgZW1pdHMgYXNzZW1ibHkg
aW5zdHJ1Y3Rpb25zLg0KDQpBbnlob3csIEkgbG9vayAoYWdhaW4pIGludG8gdXNpbmcgZ2NjLXBs
dWdpbnMuDQoNCj4+PiAxLiBBbiBpbmRpcmVjdCBicmFuY2ggaW5zaWRlIHRoZSBCUCBoYW5kbGVy
IG1pZ2h0IGJlIHRoZSBvbmUgd2UgcGF0Y2gNCj4+IA0KPj4gSSBfdGhpbmtfIG5lc3RlZCBJTlQz
cyBzaG91bGQgYmUgZG9hYmxlLCBiZWNhdXNlIHRoZXkgZG9uJ3QgdXNlIElTVC4NCj4+IE1heWJl
IEFuZHkgY2FuIGNsYXJpZnkuDQo+IA0KPiBpbnQzIHNob3VsZCBzdXJ2aXZlIHJlY3Vyc2lvbiB0
aGVzZSBkYXlzLiAgQWx0aG91Z2ggSSBhZG1pdCBJJ20NCj4gY3VycmVudGx5IHdvbmRlcmluZyB3
aGF0IGhhcHBlbnMgaWYgb25lIHRocmVhZCBwdXRzIGEga3Byb2JlIG9uIGFuDQo+IGFkZHJlc3Mg
dGhhdCBhbm90aGVyIHRocmVhZCB0cmllcyB0byB0ZXh0X3Bva2UuDQoNClRoZSBpc3N1ZSBJIHJl
Z2FyZGVkIGlzIGhhdmluZyBhbiBpbmRpcmVjdCBjYWxsICppbnNpZGUqIHRoZSB0aGUgaGFuZGxl
ci4NCkZvciBleGFtcGxlLCB5b3UgdHJ5IHRvIHBhdGNoIHRoZSBjYWxsIHRvIGJwX2ludDNfaGFu
ZGxlciBhbmQgdGhlbiBnZXQgYW4NCmludDMuIFRoZXkgY2FuIGJlIGFubm90YXRlZCB0byBwcmV2
ZW50IHRoZW0gZnJvbSBiZWluZyBwYXRjaGVkLiBUaGVuIGFnYWluLA0KSSBuZWVkIHRvIHNlZSBo
b3cgZ2NjIHBsdWdpbnMgY2FuIGdldCB0aGVzZSBhbm5vdGF0aW9ucy4NCg0KPiANCj4gQWxzbywg
dGhpcyByZWxwb2xpbmUgbWFnaWMgaXMgbGlrZWx5IHRvIHN0YXJ0IHBhdGNoaW5nIHRleHQgYXQg
cnVudGltZQ0KPiBvbiBhIHNlbWktcmVndWxhciBiYXNpcy4gIFRoaXMgdHlwZSBvZiBwYXRjaGlu
ZyBpcyAqc2xvdyouICBJcyBpdCBhDQo+IHByb2JsZW0/DQoNCkl0IGRpZG7igJl0IGFwcGVhciBz
by4gQWx0aG91Z2ggdGhlcmUgYXJlID4xMDAwMCBpbmRpcmVjdCBicmFuY2hlcyBpbiB0aGUNCmtl
cm5lbCwgeW91IGRvbuKAmXQgcGF0Y2ggdG9vIG1hbnkgb2YgdGhlbSBldmVuIHlvdSBhcmUgZG9p
bmcgcmVsZWFybmluZy4NCg0KPiANCj4+PiAyLiBBbiBpbmRpcmVjdCBicmFuY2ggaW5zaWRlIGFu
IGludGVycnVwdCBvciBOTUkgaGFuZGxlciBtaWdodCBiZSB0aGUNCj4+PiAgIG9uZSB3ZSBwYXRj
aA0KPj4gDQo+PiBCdXQgSU5UM3MganVzdCB1c2UgdGhlIGV4aXN0aW5nIHN0YWNrLCBhbmQgTk1J
cyBzdXBwb3J0IG5lc3RpbmcsIHNvIEknbQ0KPj4gdGhpbmtpbmcgdGhhdCBzaG91bGQgYWxzbyBi
ZSBkb2FibGUuICBBbmR5Pw0KPiANCj4gSW4gcHJpbmNpcGxlLCBhcyBsb25nIGFzIHRoZSBjb2Rl
IGlzbid0IE5PS1BST0JFX1NZTUJPTC1pZmllZCwgd2UNCj4gc2hvdWxkIGJlIGZpbmUsIHJpZ2h0
PyAgSSdkIGJlIGEgbGl0dGxlIG5lcnZvdXMgaWYgd2UgZ2V0IGFuIGludDMgaW4NCj4gdGhlIEMg
Y29kZSB0aGF0IGhhbmRsZXMgdGhlIGVhcmx5IHBhcnQgb2YgYW4gTk1JIGZyb20gdXNlciBtb2Rl
LiAgSXQncw0KPiAqcHJvYmFibHkqIG9rYXksIGJ1dCBvbmUgb2YgdGhlIGFsYXJtaW5nIGlzc3Vl
cyBpcyB0aGF0IHRoZSBpbnQzDQo+IHJldHVybiBwYXRoIHdpbGwgaW1wbGljaXRseSB1bm1hc2sg
Tk1JLCB3aGljaCBpc24ndCBmYW50YXN0aWMuICBNYXliZQ0KPiB3ZSBmaW5hbGx5IG5lZWQgdG8g
ZHVzdCBvZmYgbXkgb2xkICJyZXR1cm4gdXNpbmcgUkVUIiBjb2RlIHRvIGdldCByaWQNCj4gb2Yg
dGhhdCBwcm9ibGVtLg0KDQpTbyBpdCBtYXkgYmUgcG9zc2libGUuIEl0IHdvdWxkIHJlcXVpcmUg
aGF2aW5nIGEgbmV3IHRleHRfcG9rZV9icCgpIHZhcmlhbnQNCmZvciBtdWx0aXBsZSBpbnN0cnVj
dGlvbnMuIHRleHRfcG9rZV9icCgpIG1pZ2h0IGJlIHNsb3dlciB0aG91Z2guDQoNCg0K
