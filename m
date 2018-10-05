Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03DEC65BBA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A268D21473
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="hC1cJxIA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A268D21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbeJFBfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 21:35:21 -0400
Received: from mail-eopbgr700062.outbound.protection.outlook.com ([40.107.70.62]:27520
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729133AbeJFBfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 21:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgSWpQP9+8LQU/Atnuyime1FxnGTt2Q6ZMEyKEdAyFY=;
 b=hC1cJxIA0vzfUCm/z4l+4S1qIwODl5d/jj+o+xPHG1E8f3k8mjK+WR8oPxAt5r6i/aChWbX48zu7fT/FE1LMwXouVEP3x7R9dQodgiFbT43z6rkgFq4XRIW76/AYduXVInXdQYD6MUZ485xCo+o16ELy0IAokqiHXlqxJNTimQ8=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4391.namprd05.prod.outlook.com (52.135.202.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.11; Fri, 5 Oct 2018 18:35:18 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2%3]) with mapi id 15.20.1207.018; Fri, 5 Oct 2018
 18:35:18 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC] x86/cpu_entry_area: move part of it back to fixmap
Thread-Topic: [RFC] x86/cpu_entry_area: move part of it back to fixmap
Thread-Index: AQHUW5+DYNLMbTMpOU+l0vSyUa8/DKUPISmAgAAmpQCAAAkaAIABrCoA
Date:   Fri, 5 Oct 2018 18:35:18 +0000
Message-ID: <2A4D16C3-CBE2-490F-8C7A-F5FE437ACC34@vmware.com>
References: <20181004045948.129142-1-namit@vmware.com>
 <72B0B378-9515-47C4-8937-9F1E823DD236@amacapital.net>
 <CE9C4B9C-3B11-45D0-812A-F074D687084D@vmware.com>
 <CALCETrVkE9eV0b2-wfq4Y9iK+YVJ4JBL7_rk_A8-7EhtuBbncA@mail.gmail.com>
In-Reply-To: <CALCETrVkE9eV0b2-wfq4Y9iK+YVJ4JBL7_rk_A8-7EhtuBbncA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4391;20:PpJd8PZtROjSL4kiXz9UVfHlKA2SUAgLGataZl7S+KHydqSL+JE1lwtXi2V27IB7DXq/IVoQA24sCDOHmrRmR85AUk9gLCw/PAMg/Z8XkZr8I49NHtiqQLNfXNXdKMGTT7T1Oi+jPCFKVrFaZ8hNCnQO/nicW9Vp7riLzslKJdE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6b9b37be-7bb7-470c-dd56-08d62af14d12
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4391;
x-ms-traffictypediagnostic: BYAPR05MB4391:
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB43917A093588E4A961287649D0EB0@BYAPR05MB4391.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(219752817060721)(189930954265078)(61668805478150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991048);SRVR:BYAPR05MB4391;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4391;
x-forefront-prvs: 0816F1D86E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(376002)(366004)(136003)(189003)(199004)(54534003)(102836004)(66066001)(25786009)(54906003)(45080400002)(81156014)(81166006)(486006)(8676002)(6346003)(478600001)(2906002)(26005)(8936002)(82746002)(476003)(446003)(11346002)(6486002)(2616005)(36756003)(229853002)(83716004)(6436002)(71200400001)(71190400001)(76176011)(99286004)(97736004)(6916009)(5250100002)(53936002)(68736007)(53546011)(6506007)(6246003)(575784001)(86362001)(6116002)(7736002)(3846002)(105586002)(305945005)(6512007)(106356001)(33656002)(316002)(966005)(6306002)(5660300001)(2900100001)(256004)(93886005)(186003)(14454004)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4391;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-microsoft-antispam-message-info: LRcu557wvhshgxr99MXsNYQ4O+2aL8bdNKC69mWCkznW7NN/02hzciVdy9hy4uY0sA83MBjmmVsBy7ktLmD1y8gPKDby9hiKy6L3h9C8OiOPmlZVeTiAwz/BjeM3x2lhBQoQpUoaMM3ygVTSZ4Q4NR3o1pxTzEOalMSmdoJVouZyOehgYLcxBM4EA5MULijUpVyDDlvJuy7rqxPM/CiikLnGMZIolEyuB/svBdPQqDbfKnZPaXMJANwNfGlLJmwcrc1oeTg0a6BEf/0TX1CMGJtXL3ZoScOnWLlUMdAV8H+o6Vv1U+hbSRfRJc/U0oLk3bUOut6nc+EfDVQjX6eUvr5/wgcqKXzrtxdCzi8hB5E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DA7C31CBCDEEF4FB84FEBAAF7D04F06@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9b37be-7bb7-470c-dd56-08d62af14d12
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2018 18:35:18.7289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4391
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgMTA6MDIgQU0sIEFuZHkgTHV0b21pcnNraSA8bHV0b0BrZXJuZWwub3JnPiB3cm90ZToNCg0K
PiBPbiBUaHUsIE9jdCA0LCAyMDE4IGF0IDk6MzEgQU0gTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJl
LmNvbT4gd3JvdGU6DQo+PiBhdCA3OjExIEFNLCBBbmR5IEx1dG9taXJza2kgPGx1dG9AYW1hY2Fw
aXRhbC5uZXQ+IHdyb3RlOg0KPj4gDQo+Pj4gT24gT2N0IDMsIDIwMTgsIGF0IDk6NTkgUE0sIE5h
ZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+IHdyb3RlOg0KPj4+IA0KPj4+PiBUaGlzIFJGQyBw
cm9wb3NlcyB0byByZXR1cm4gcGFydCBvZiB0aGUgZW50cnktYXJlYSBiYWNrIHRvIHRoZSBmaXht
YXAgdG8NCj4+Pj4gaW1wcm92ZSBzeXN0ZW0tY2FsbCBwZXJmb3JtYW5jZS4gQ3VycmVudGx5LCBz
aW5jZSB0aGUgZW50cnktYXJlYSBpcw0KPj4+PiBtYXBwZWQgZmFyIChtb3JlIHRoYW4gMkdCKSBh
d2F5IGZyb20gdGhlIGtlcm5lbCB0ZXh0LCBhbiBpbmRpcmVjdCBicmFuY2gNCj4+Pj4gaXMgbmVl
ZGVkIHRvIGp1bXAgZnJvbSB0aGUgdHJhbXBvbGluZSBpbnRvIHRoZSBrZXJuZWwuIER1ZSB0byBT
cGVjdHJlDQo+Pj4+IHYyLCB2dWxuZXJhYmxlIENQVXMgbmVlZCB0byB1c2UgYSByZXRwb2xpbmUs
IHdoaWNoIGludHJvZHVjZXMgYW4NCj4+Pj4gb3ZlcmhlYWQgb2YgPjIwIGN5Y2xlcy4NCj4+PiAN
Cj4+PiBUaGF0IHJldHBvbGluZSBpcyBnb25lIGluIC10aXAuIENhbiB5b3Ugc2VlIGhvdyB5b3Vy
IGNvZGUgc3RhY2tzIHVwIGFnYWluc3QgLXRpcD8gIElmIGl04oCZcyBlbm91Z2ggb2YgYSB3aW4g
dG8ganVzdGlmeSB0aGUgYWRkZWQgY29tcGxleGl0eSwgd2UgY2FuIHRyeSBpdC4NCj4+PiANCj4+
PiBZb3UgY2FuIHNlZSBzb21lIHByb3MgYW5kIGNvbnMgaW4gdGhlIGNoYW5nZWxvZzoNCj4+PiAN
Cj4+PiBodHRwczovL25hMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1o
dHRwcyUzQSUyRiUyRmdpdC5rZXJuZWwub3JnJTJGdGlwJTJGYmY5MDRkMjc2MmVlNmZjMWU0YWNm
Y2IwNzcyYmJmYjRhMjdhZDhhNiZhbXA7ZGF0YT0wMiU3QzAxJTdDbmFtaXQlNDB2bXdhcmUuY29t
JTdDOTk5NmIyZGQ2ZjE3NDVkY2UxMGIwOGQ2MmExYjNmM2UlN0NiMzkxMzhjYTNjZWU0YjRhYTRk
NmNkODNkOWRkNjJmMCU3QzElN0MwJTdDNjM2NzQyNjkzODY0ODc4Nzg3JmFtcDtzZGF0YT1OVzBS
JTJGdjVPYWhabFRiYk5nbkZrMjBzRjRXdDFXME1EanR2OWcxayUyQldkZyUzRCZhbXA7cmVzZXJ2
ZWQ9MA0KPj4gDQo+PiBFcnIuLiBUaGF04oCZcyB3aGF0IEkgZ2V0IGZvciBub3QgZm9sbG93aW5n
IGxrbWwuIFZlcnkgbmljZSBkaXNjdXNzaW9uLg0KPj4gQmFzZWQgb24gaXQsIEkgbWF5IGJlIGFi
bGUgdG8gZG8gYW4gYWRkaXRpb25hbCBtaWNyby1vcHRpbWl6YXRpb25zIG9yDQo+PiB0d28uIExl
dCBtZSBnaXZlIGl0IGEgdHJ5Lg0KPiANCj4gSSB0aGluayB5b3Ugc2hvdWxkIGF0IGxlYXN0IHRy
eSB0byBiZW5jaG1hcmsgeW91ciBjb2RlIGFnYWluc3QgbWluZSwNCj4gc2luY2UgeW91IG1vcmUg
b3IgbGVzcyBpbXBsZW1lbnRlZCB0aGUgYWx0ZXJuYXRpdmUgSSBzdWdnZXN0ZWQuIDopDQoNClRo
YXTigJlzIHdoYXQgSSBtZWFudC4gU28gSSBtYWRlIGEgY291cGxlIG9mIHR3ZWFrc2luIG15IGlt
cGxlbWVudGF0aW9uIHRvDQptYWtlIGFzIHBlcmZvcm1hbnQgYXMgcG9zc2libGUuIEV2ZW50dWFs
bHksIHRoZXJlIGlzIGEgMm5zIGJlbmVmaXQgZm9yIHRoZQ0KdHJhbXBvbGluZSBvdmVyIHRoZSB1
bmlmaWVkIGVudHJ5LXBhdGggb24gYXZlcmFnZSBvbiBteSBIYXN3ZWxsIFZNICgyNTRucyB2cw0K
MjU2bnMpLCB5ZXQgdGhlcmUgaXMgc29tZSB2YXJpYW5jZSAoMS4yICYgMS41bnMgc3RkZXYgY29y
cmVzcG9uZGluZ2x5KS4NCg0KSSBkb27igJl0IGtub3cgd2hldGhlciBzdWNoIGEgZGlmZmVyZW5j
ZSBzaG91bGQgbWFrZSBvbmUgb3B0aW9uIHRvIGJlIHByZWZlcnJlZA0Kb3ZlciB0aGUgb3RoZXIu
IEkgdGhpbmsgaXQgYm9pbHMgZG93biB0byB3aGV0aGVyOg0KDQoxLiBLQVNMUiBpcyBuZWVkZWQu
DQogDQoyLiBDYW4geW91IHNwZWNpYWxpemUgdGhlIGNvZGUtcGF0aHMgb2YgdHJhbXBvbGluZS9u
b24tdHJhbXBvbGluZSB0byBnYWluDQpiZXR0ZXIgcGVyZm9ybWFuY2UuIEZvciBleGFtcGxlLCBi
eSByZW1vdmluZyB0aGUgQUxURVJOQVRJVkUgZnJvbQ0KU1dJVENIX1RPX0tFUk5FTF9DUjMgYW5k
IG5vdCByZWxvYWQgQ1IzIG9uIHRoZSBub24tdHJhbXBvbGluZSBwYXRoLCB5b3UgY2FuDQphdm9p
ZCBhbiB1bmNvbmRpdGlvbmFsIGptcCBvbiBtYWNoaW5lcyB3aGljaCBhcmUgbm90IHZ1bG5lcmFi
bGUgdG8gTWVsdGRvd24uDQoNClNvIEkgY2FuIGd1ZXNzIHdoYXQgeW914oCZZCBwcmVmZXIuIExl
dOKAmXMgc2VlIGlmIEnigJltIHJpZ2h0Lg0KDQo=
