Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5C7C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 22:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 426B0208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 22:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="rvtgZe9H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 426B0208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbeJFFSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 01:18:35 -0400
Received: from mail-by2nam03on0054.outbound.protection.outlook.com ([104.47.42.54]:58362
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726240AbeJFFSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 01:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUUyWUZcpTE8dD/W5JJzGf2+uhENhGGfPOLYDKm8hK4=;
 b=rvtgZe9HnCI31UfYFtxyqR/DpsdXkE8qzaiK3E2rAud4VpTcqNJNfeSkwoMA337r+vcB70GfHt6GNf8YotnS67+9iPI9j8wWJHtJYSPtkFjMeTYah5qw/INp/YjNZtbHoDC8uqUSPREjNfpGm8zMMU7jWJU/BNj5bLMGn5Qi5eg=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4869.namprd05.prod.outlook.com (52.135.235.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.12; Fri, 5 Oct 2018 22:17:46 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2%3]) with mapi id 15.20.1207.018; Fri, 5 Oct 2018
 22:17:46 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC] x86/cpu_entry_area: move part of it back to fixmap
Thread-Topic: [RFC] x86/cpu_entry_area: move part of it back to fixmap
Thread-Index: AQHUW5+DYNLMbTMpOU+l0vSyUa8/DKUPISmAgAAmpQCAAAkaAIABrCoAgAA8LQCAAAH7AA==
Date:   Fri, 5 Oct 2018 22:17:46 +0000
Message-ID: <6471C8EA-B0E9-4AB0-BD19-DA4307B089C9@vmware.com>
References: <20181004045948.129142-1-namit@vmware.com>
 <72B0B378-9515-47C4-8937-9F1E823DD236@amacapital.net>
 <CE9C4B9C-3B11-45D0-812A-F074D687084D@vmware.com>
 <CALCETrVkE9eV0b2-wfq4Y9iK+YVJ4JBL7_rk_A8-7EhtuBbncA@mail.gmail.com>
 <2A4D16C3-CBE2-490F-8C7A-F5FE437ACC34@vmware.com>
 <CALCETrUnN-sQErp+q=RZU-9Gwg6GaDaoQzSjNv2=hcLej3NfsQ@mail.gmail.com>
In-Reply-To: <CALCETrUnN-sQErp+q=RZU-9Gwg6GaDaoQzSjNv2=hcLej3NfsQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4869;20:IQF8lBLcq+IdzmiNeLOEJy8o3USWIxxZ3QByOnglR6y9WOFei0u8bjmkWjVaqtBins3+eNR3qrYIvxitkBXmwSuN4fs53Of3wL8aqCYm69l57F/5ijLqE5kD0wjluX4y0BC8ex5pELDVep2eeh+4VYundOCDaNnbriR2Wz48pRI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8d408d01-7db8-482a-eb12-08d62b1060cd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4869;
x-ms-traffictypediagnostic: BYAPR05MB4869:
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB4869428D08BD42289394BC63D0EB0@BYAPR05MB4869.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(219752817060721)(189930954265078)(61668805478150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BYAPR05MB4869;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4869;
x-forefront-prvs: 0816F1D86E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(396003)(346002)(136003)(54534003)(189003)(199004)(5250100002)(105586002)(33656002)(66066001)(82746002)(81156014)(81166006)(186003)(106356001)(83716004)(8676002)(71200400001)(966005)(71190400001)(6916009)(26005)(316002)(76176011)(14454004)(102836004)(97736004)(6486002)(2906002)(6306002)(6512007)(53936002)(11346002)(2616005)(446003)(6246003)(486006)(4326008)(476003)(6436002)(54906003)(53546011)(256004)(6506007)(99286004)(25786009)(478600001)(36756003)(86362001)(575784001)(93886005)(6116002)(3846002)(5660300001)(305945005)(68736007)(7736002)(45080400002)(2900100001)(8936002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4869;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kRLk6KhD3msBsW861WnFuy2eDuqH8uJ9jmbFfRqBpGIjY33os+Ol3HhoSAiqOXOfAutaFnG+ZNXCjD4a14ZEwIfS/lLc/YVRwWOXK0xRAQ27EZt6JIomzAleXEnxOxvq8kkH9Txq9+M4k8bB22/8Jng+gNoKfeNDOYGt2q0UNvqKqrw86guKzb/GnrN/F6jEiKfmmxyQDJacmepK2h6hS6lDnR+Kzq9VrancPsio5BK4XVS0jlrMlgC8VpG4xuqHMKnVPwPmy5RX2gFYcyTaBV0RHivGz2nOdQGyGZfDYhHqxBtiPwO4aan5fkkdj0dijRi5sG8eNvK+avP2Kj0HfI2+EMSHIXPkvS73P2mR4TI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C0A05D449AFB04AB8156F11F7C46FDF@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d408d01-7db8-482a-eb12-08d62b1060cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2018 22:17:46.2145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4869
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgMzoxMCBQTSwgQW5keSBMdXRvbWlyc2tpIDxsdXRvQGtlcm5lbC5vcmc+IHdyb3RlOg0KDQo+
IE9uIEZyaSwgT2N0IDUsIDIwMTggYXQgMzowOCBQTSBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUu
Y29tPiB3cm90ZToNCj4+IGF0IDEwOjAyIEFNLCBBbmR5IEx1dG9taXJza2kgPGx1dG9Aa2VybmVs
Lm9yZz4gd3JvdGU6DQo+PiANCj4+PiBPbiBUaHUsIE9jdCA0LCAyMDE4IGF0IDk6MzEgQU0gTmFk
YXYgQW1pdCA8bmFtaXRAdm13YXJlLmNvbT4gd3JvdGU6DQo+Pj4+IGF0IDc6MTEgQU0sIEFuZHkg
THV0b21pcnNraSA8bHV0b0BhbWFjYXBpdGFsLm5ldD4gd3JvdGU6DQo+Pj4+IA0KPj4+Pj4gT24g
T2N0IDMsIDIwMTgsIGF0IDk6NTkgUE0sIE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+IHdy
b3RlOg0KPj4+Pj4gDQo+Pj4+Pj4gVGhpcyBSRkMgcHJvcG9zZXMgdG8gcmV0dXJuIHBhcnQgb2Yg
dGhlIGVudHJ5LWFyZWEgYmFjayB0byB0aGUgZml4bWFwIHRvDQo+Pj4+Pj4gaW1wcm92ZSBzeXN0
ZW0tY2FsbCBwZXJmb3JtYW5jZS4gQ3VycmVudGx5LCBzaW5jZSB0aGUgZW50cnktYXJlYSBpcw0K
Pj4+Pj4+IG1hcHBlZCBmYXIgKG1vcmUgdGhhbiAyR0IpIGF3YXkgZnJvbSB0aGUga2VybmVsIHRl
eHQsIGFuIGluZGlyZWN0IGJyYW5jaA0KPj4+Pj4+IGlzIG5lZWRlZCB0byBqdW1wIGZyb20gdGhl
IHRyYW1wb2xpbmUgaW50byB0aGUga2VybmVsLiBEdWUgdG8gU3BlY3RyZQ0KPj4+Pj4+IHYyLCB2
dWxuZXJhYmxlIENQVXMgbmVlZCB0byB1c2UgYSByZXRwb2xpbmUsIHdoaWNoIGludHJvZHVjZXMg
YW4NCj4+Pj4+PiBvdmVyaGVhZCBvZiA+MjAgY3ljbGVzLg0KPj4+Pj4gDQo+Pj4+PiBUaGF0IHJl
dHBvbGluZSBpcyBnb25lIGluIC10aXAuIENhbiB5b3Ugc2VlIGhvdyB5b3VyIGNvZGUgc3RhY2tz
IHVwIGFnYWluc3QgLXRpcD8gIElmIGl04oCZcyBlbm91Z2ggb2YgYSB3aW4gdG8ganVzdGlmeSB0
aGUgYWRkZWQgY29tcGxleGl0eSwgd2UgY2FuIHRyeSBpdC4NCj4+Pj4+IA0KPj4+Pj4gWW91IGNh
biBzZWUgc29tZSBwcm9zIGFuZCBjb25zIGluIHRoZSBjaGFuZ2Vsb2c6DQo+Pj4+PiANCj4+Pj4+
IGh0dHBzOi8vbmEwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBz
JTNBJTJGJTJGZ2l0Lmtlcm5lbC5vcmclMkZ0aXAlMkZiZjkwNGQyNzYyZWU2ZmMxZTRhY2ZjYjA3
NzJiYmZiNGEyN2FkOGE2JmFtcDtkYXRhPTAyJTdDMDElN0NuYW1pdCU0MHZtd2FyZS5jb20lN0M0
ODFhODNmNTMyMzI0MjM5OWVmZDA4ZDYyYjBmNjliYSU3Q2IzOTEzOGNhM2NlZTRiNGFhNGQ2Y2Q4
M2Q5ZGQ2MmYwJTdDMSU3QzAlN0M2MzY3NDM3NDI1NDMxMTQ3NDImYW1wO3NkYXRhPXVJNVgzUElU
ekVWZVhIeWFmU0dOVjZvVk5rbHBIYm1oaFJidHlvSXVya2slM0QmYW1wO3Jlc2VydmVkPTANCj4+
Pj4gDQo+Pj4+IEVyci4uIFRoYXTigJlzIHdoYXQgSSBnZXQgZm9yIG5vdCBmb2xsb3dpbmcgbGtt
bC4gVmVyeSBuaWNlIGRpc2N1c3Npb24uDQo+Pj4+IEJhc2VkIG9uIGl0LCBJIG1heSBiZSBhYmxl
IHRvIGRvIGFuIGFkZGl0aW9uYWwgbWljcm8tb3B0aW1pemF0aW9ucyBvcg0KPj4+PiB0d28uIExl
dCBtZSBnaXZlIGl0IGEgdHJ5Lg0KPj4+IA0KPj4+IEkgdGhpbmsgeW91IHNob3VsZCBhdCBsZWFz
dCB0cnkgdG8gYmVuY2htYXJrIHlvdXIgY29kZSBhZ2FpbnN0IG1pbmUsDQo+Pj4gc2luY2UgeW91
IG1vcmUgb3IgbGVzcyBpbXBsZW1lbnRlZCB0aGUgYWx0ZXJuYXRpdmUgSSBzdWdnZXN0ZWQuIDop
DQo+PiANCj4+IFRoYXTigJlzIHdoYXQgSSBtZWFudC4gU28gSSBtYWRlIGEgY291cGxlIG9mIHR3
ZWFrc2luIG15IGltcGxlbWVudGF0aW9uIHRvDQo+PiBtYWtlIGFzIHBlcmZvcm1hbnQgYXMgcG9z
c2libGUuIEV2ZW50dWFsbHksIHRoZXJlIGlzIGEgMm5zIGJlbmVmaXQgZm9yIHRoZQ0KPj4gdHJh
bXBvbGluZSBvdmVyIHRoZSB1bmlmaWVkIGVudHJ5LXBhdGggb24gYXZlcmFnZSBvbiBteSBIYXN3
ZWxsIFZNICgyNTRucyB2cw0KPj4gMjU2bnMpLCB5ZXQgdGhlcmUgaXMgc29tZSB2YXJpYW5jZSAo
MS4yICYgMS41bnMgc3RkZXYgY29ycmVzcG9uZGluZ2x5KS4NCj4+IA0KPj4gSSBkb27igJl0IGtu
b3cgd2hldGhlciBzdWNoIGEgZGlmZmVyZW5jZSBzaG91bGQgbWFrZSBvbmUgb3B0aW9uIHRvIGJl
IHByZWZlcnJlZA0KPj4gb3ZlciB0aGUgb3RoZXIuIEkgdGhpbmsgaXQgYm9pbHMgZG93biB0byB3
aGV0aGVyOg0KPj4gDQo+PiAxLiBLQVNMUiBpcyBuZWVkZWQuDQo+IA0KPiBXaHk/ICBLQVNMUiBp
cyBiYXNpY2FsbHkgd29ydGhsZXNzIG9uIGFueSBleGlzdGluZyBDUFUgYWdhaW5zdA0KPiBhdHRh
Y2tlcnMgd2hvIGNhbiBydW4gbG9jYWwgY29kZS4NCj4gDQo+PiAyLiBDYW4geW91IHNwZWNpYWxp
emUgdGhlIGNvZGUtcGF0aHMgb2YgdHJhbXBvbGluZS9ub24tdHJhbXBvbGluZSB0byBnYWluDQo+
PiBiZXR0ZXIgcGVyZm9ybWFuY2UuIEZvciBleGFtcGxlLCBieSByZW1vdmluZyB0aGUgQUxURVJO
QVRJVkUgZnJvbQ0KPj4gU1dJVENIX1RPX0tFUk5FTF9DUjMgYW5kIG5vdCByZWxvYWQgQ1IzIG9u
IHRoZSBub24tdHJhbXBvbGluZSBwYXRoLCB5b3UgY2FuDQo+PiBhdm9pZCBhbiB1bmNvbmRpdGlv
bmFsIGptcCBvbiBtYWNoaW5lcyB3aGljaCBhcmUgbm90IHZ1bG5lcmFibGUgdG8gTWVsdGRvd24u
DQo+PiANCj4+IFNvIEkgY2FuIGd1ZXNzIHdoYXQgeW914oCZZCBwcmVmZXIuIExldOKAmXMgc2Vl
IGlmIEnigJltIHJpZ2h0Lg0KPiANCj4gMiBucyBpc24ndCBiYWQsIGF0IGxlYXN0IG9uIGEgbm9u
LVBUSSBzeXN0ZW0uICBXaGljaCwgSSBzdXBwb3NlLCBtZWFucw0KPiB0aGF0IHlvdSBzaG91bGQg
YmVuY2htYXJrIG9uIEFNRCA6KQ0KPiANCj4gSWYgdGhlIGNvZGUgaXMgcmVhc29uYWJseSBjbGVh
biwgSSBjb3VsZCBnZXQgb24gYm9hcmQuDQoNCkZhaXIgZW5vdWdoLiBJ4oCZbGwgY2xlYW4gaXQg
YW5kIHJlc2VuZC4NCg0KVGhhbmtzLA0KTmFkYXYNCg0K
