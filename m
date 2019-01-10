Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE615C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DEFD20874
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="lwhB4b8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbfAJVrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 16:47:49 -0500
Received: from mail-eopbgr690051.outbound.protection.outlook.com ([40.107.69.51]:8849
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728742AbfAJVrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 16:47:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgLQAZ4bEZVVeZoaLhwiCCAMkjitpLyqMdR1gWKjpX4=;
 b=lwhB4b8BjBkOTHFAn2tbazfc11LOWCUQDVNlEpjmHXwKUCp+mXDAxj2yJbcBuTt1ITN6HDP1gRm6FMv/dvfxRbJ/QE6GKlqgwdPNEPmVcCa344WnUWMmrxqVuMBZ9EjQDiDynM8X0fJIOcVF2ceezGfNWfIDyDBRJ7i6kgRxNBc=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5656.namprd05.prod.outlook.com (20.177.186.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.4; Thu, 10 Jan 2019 21:47:04 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732%2]) with mapi id 15.20.1516.010; Thu, 10 Jan 2019
 21:47:04 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
CC:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v3 0/6] Static calls
Thread-Topic: [PATCH v3 0/6] Static calls
Thread-Index: AQHUqG8IuMNefdUVHE69woqiOXvtzqWntJ6AgAEB5ICAAA1xgIAADNqAgAAYZICAAA0MgIAABJWAgAACigCAAA3QAA==
Date:   Thu, 10 Jan 2019 21:47:03 +0000
Message-ID: <669424BA-97CE-472A-8A72-7D8059D6B36F@vmware.com>
References: <cover.1547073843.git.jpoimboe@redhat.com>
 <A42784EF-3215-4ED9-8D35-1A2C38A0711F@vmware.com>
 <20190110164401.g747vifrppbhbo3o@treble>
 <D8481FBB-4873-43B2-9187-C0896E859191@vmware.com>
 <20190110181807.irh2b7fk6at43rdl@treble>
 <3F89FB6B-DA8B-4C71-B825-2B7EB86F274E@vmware.com>
 <20190110203207.3k43gt4kcvry7us7@treble>
 <F773CB3F-992B-4BC9-9376-72300BBA550B@vmware.com>
 <20190110205736.pv3bt5chkgpep4kq@treble>
In-Reply-To: <20190110205736.pv3bt5chkgpep4kq@treble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5656;20:+Wqrj/MwkHWv9a2idi5D+Y89Ge3sWIRhJp7rVYLRSsrXjpRUqRenBz+/sKSaSWmkw1qCJWOcw5b6cgFWyf23n9Ci/dejFA9k3hOniV7C6sHpmsNShptDIKdMTW2H0qe184S1iEoyVbte8IySTCsXArDboJaLRLF/CS5fPjzM/XA=
x-ms-office365-filtering-correlation-id: 8dd50a7f-6f0b-41e8-d6a1-08d6774528e0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5656;
x-ms-traffictypediagnostic: BYAPR05MB5656:
x-microsoft-antispam-prvs: <BYAPR05MB5656EA114E27DF30491731E1D0840@BYAPR05MB5656.namprd05.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(376002)(39860400002)(136003)(199004)(189003)(14454004)(71190400001)(256004)(99286004)(83716004)(102836004)(6116002)(71200400001)(6486002)(6306002)(86362001)(575784001)(186003)(25786009)(6512007)(7736002)(26005)(3846002)(105586002)(53546011)(6506007)(6916009)(54906003)(478600001)(2906002)(45080400002)(966005)(2616005)(97736004)(486006)(6436002)(81156014)(81166006)(316002)(76176011)(93886005)(11346002)(6246003)(446003)(5660300001)(33656002)(7416002)(8936002)(305945005)(66066001)(4326008)(82746002)(68736007)(106356001)(8676002)(53936002)(476003)(229853002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5656;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eyPYOoRDYh5Hd8Iw4cIwmz1nJvvhHA8c42fWT3PfUzwB+EH2qStGKQZoEFRc4bdR+oVlyOTjYWwxz/vgqvC6VwGhf6rsNw0pICgFCcLjGq3gUI07+ikF5XH9M6RH2y3bGSpawjukaMXa4OYnY5p9/DygShXAzqf+RTCjiJRJl+bXRb2w+2NU8sgeb9qoey1jHW7c/jRvKxlZ6YLx423idAOayZNJIdNYN9A/CBdTpHKFhrZt+CgFB6vgmMiHx2xBBvsP4MnxfGboPchOvfdyR3vb89POBPewSMv9Vfb7lbLCXQ/9wN0Lq0MyTGyMLEANZRvjV+oroTnCP8v1hznyViaKGhnPugFd/P4UyOtcF0Btq0/T4O+SPfzY0gG5vqp8wuXH9cRrH+CWwzlOpDoMz+K+d2GSoW66lQv5EorKE6M6rU0/VewA0Zf6pZBIjMQ6cfB9SPX1SYSm8oT6luf21Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <881280A71D2D944F8125C83A3FAE6D53@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd50a7f-6f0b-41e8-d6a1-08d6774528e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 21:47:03.9745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5656
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKYW4gMTAsIDIwMTksIGF0IDEyOjU3IFBNLCBKb3NoIFBvaW1ib2V1ZiA8anBvaW1ib2VA
cmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIEphbiAxMCwgMjAxOSBhdCAwODo0ODoz
MVBNICswMDAwLCBOYWRhdiBBbWl0IHdyb3RlOg0KPj4+IE9uIEphbiAxMCwgMjAxOSwgYXQgMTI6
MzIgUE0sIEpvc2ggUG9pbWJvZXVmIDxqcG9pbWJvZUByZWRoYXQuY29tPiB3cm90ZToNCj4+PiAN
Cj4+PiBPbiBUaHUsIEphbiAxMCwgMjAxOSBhdCAwNzo0NToyNlBNICswMDAwLCBOYWRhdiBBbWl0
IHdyb3RlOg0KPj4+Pj4+IEnigJltIG5vdCBHQ0MgZXhwZXJ0IGVpdGhlciBhbmQgd3JpdGluZyB0
aGlzIGNvZGUgd2FzIG5vdCBtYWtpbmcgbWUgZnVsbCBvZg0KPj4+Pj4+IGpveSwgZXRjLi4gSeKA
mWxsIGJlIGhhcHB5IHRoYXQgbXkgY29kZSB3b3VsZCBiZSByZXZpZXdlZCwgYnV0IGl0IGRvZXMg
d29yay4gSQ0KPj4+Pj4+IGRvbuKAmXQgdGhpbmsgYW4gZWFybHkgcGFzcyBpcyBuZWVkZWQsIGFz
IGxvbmcgYXMgaGFyZHdhcmUgcmVnaXN0ZXJzIHdlcmUgbm90DQo+Pj4+Pj4gYWxsb2NhdGVkLg0K
Pj4+Pj4+IA0KPj4+Pj4+PiBXb3VsZCBpdCB3b3JrIHdpdGggbW9yZSB0aGFuIDUgYXJndW1lbnRz
LCB3aGVyZSBhcmdzIGdldCBwYXNzZWQgb24gdGhlDQo+Pj4+Pj4+IHN0YWNrPw0KPj4+Pj4+IA0K
Pj4+Pj4+IEl0IGRvZXMuDQo+Pj4+Pj4gDQo+Pj4+Pj4+IEF0IHRoZSB2ZXJ5IGxlYXN0LCBpdCB3
b3VsZCAoYXQgbGVhc3QgcGFydGlhbGx5KSBkZWZlYXQgdGhlIHBvaW50IG9mIHRoZQ0KPj4+Pj4+
PiBjYWxsZWUtc2F2ZWQgcGFyYXZpcnQgb3BzLg0KPj4+Pj4+IA0KPj4+Pj4+IEFjdHVhbGx5LCBJ
IHRoaW5rIHlvdSBjYW4gZXZlbiBkZWFsIHdpdGggY2FsbGVlLXNhdmVkIGZ1bmN0aW9ucyBhbmQg
cmVtb3ZlDQo+Pj4+Pj4gYWxsIHRoZSAodGVycmlibGUpIG1hY3Jvcy4gWW91IHdvdWxkIG5lZWQg
dG8gdGVsbCB0aGUgZXh0ZW5zaW9uIG5vdCB0bw0KPj4+Pj4+IGNsb2JiZXIgdGhlIHJlZ2lzdGVy
cyB0aHJvdWdoIGEgbmV3IGF0dHJpYnV0ZS4NCj4+Pj4+IA0KPj4+Pj4gT2ssIGl0IGRvZXMgc291
bmQgaW50ZXJlc3RpbmcgdGhlbi4gIEkgYXNzdW1lIHlvdSdsbCBiZSBzaGFyaW5nIHRoZQ0KPj4+
Pj4gY29kZT8NCj4+Pj4gDQo+Pj4+IE9mIGNvdXJzZS4gSWYgdGhpcyB3aGF0IGlzIGdvaW5nIHRv
IGNvbnZpbmNlLCBJ4oCZbGwgbWFrZSBhIHNtYWxsIHZlcnNpb24gZm9yDQo+Pj4+IFBWIGNhbGxl
ZS1zYXZlZCBmaXJzdC4NCj4+PiANCj4+PiBJdCB3YXNuJ3QgKm9ubHkqIHRoZSBQViBjYWxsZWUt
c2F2ZWQgcGFydCB3aGljaCBpbnRlcmVzdGVkIG1lLCBzbyBpZiB5b3UNCj4+PiBhbHJlYWR5IGhh
dmUgc29tZXRoaW5nIHdoaWNoIGltcGxlbWVudHMgdGhlIG90aGVyIHBhcnRzLCBJJ2Qgc3RpbGwg
bGlrZQ0KPj4+IHRvIHNlZSBpdC4NCj4+IA0KPj4gRGlkIHlvdSBoYXZlIGEgbG9vayBhdCBodHRw
czovL25hMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUy
RiUyRmxvcmUua2VybmVsLm9yZyUyRmxrbWwlMkYyMDE4MTIzMTA3MjExMi4yMTA1MS00LW5hbWl0
JTQwdm13YXJlLmNvbSUyRiZhbXA7ZGF0YT0wMiU3QzAxJTdDbmFtaXQlNDB2bXdhcmUuY29tJTdD
MTY5YjczNzc5MjEzNGZjODUyZDgwOGQ2NzczZTQ1NGIlN0NiMzkxMzhjYTNjZWU0YjRhYTRkNmNk
ODNkOWRkNjJmMCU3QzAlN0MwJTdDNjM2ODI3NTA2NjgzODE5NDQyJmFtcDtzZGF0YT1GaE0lMkY1
T0QlMkZOSHg5SnI5N2lQSUJOeW4wQm9MQWx5aVN2JTJCVDRYSUNCVWRnJTNEJmFtcDtyZXNlcnZl
ZD0wID8NCj4+IA0KPj4gU2VlIHRoZSBjaGFuZ2VzIHRvIHg4Nl9jYWxsX21hcmt1cF9wbHVnaW4u
YyAuDQo+PiANCj4+IFRoZSBtaXNzaW5nIHBhcnQgKHRoYXQgSSBqdXN0IGZpbmlzaGVkIGJ1dCBu
ZWVkIHRvIGNsZWFudXApIGlzIGF0dHJpYnV0ZXMNCj4+IHRoYXQgYWxsb3cgeW91IHRvIHByb3Zp
ZGUga2V5IGFuZCBkeW5hbWljYWxseSBlbmFibGUgdGhlIHBhdGNoaW5nLg0KPiANCj4gQWhhLCBz
byBpdCdzIHRoZSBiYXNpY2FsbHkgdGhlIHNhbWUgcGx1Z2luIHlvdSBoYWQgZm9yIG9wdHBvbGlu
ZXMuICBJDQo+IG1pc3NlZCB0aGF0LiAgSSdsbCBuZWVkIHRvIHN0YXJlIGF0IHRoZSBjb2RlIGZv
ciBhIGxpdHRsZSBiaXQuDQoNClByZXR0eSBtdWNoLiBZb3Ugd291bGQgd2FudCB0byBjaGFuZ2Ug
dGhlIGFzc2VtYmx5IGNvZGUgYmxvY2ssIGFuZCBiYXNlZCBvbg0KdGhlIHVzZS1jYXNlIChlLmcu
LCBjYWxsZWUtc2F2ZWQsIHN0YXRpYy1jYWxscykgY2xvYmJlciBvciBzZXQgYXMgYW4gaW5wdXQN
Cm1vcmUgb3IgZmV3ZXIgcmVnaXN0ZXJzLg0KDQo=
