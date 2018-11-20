Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCEBC4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68F5213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="Zlr8rCn5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E68F5213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbeKUFXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 00:23:07 -0500
Received: from mail-eopbgr790089.outbound.protection.outlook.com ([40.107.79.89]:47021
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725885AbeKUFXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 00:23:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsWRxGU91O8CYZ7zL9rGyKpiORdPpAPFbys5/pKXYBA=;
 b=Zlr8rCn5VVlApoMe/ZroTu92GU8KsX+jvEWdTaJMpHmlgI28w3FdJXXSOrAwOwaB70MphVEf6vSZXGZqbquG8s+V13CDXIUo6gKWaxqkeNRb04rgnRTgk9e0NgqvU+mLSIlMz2nP4ylKpykNsg3PN1DsgHSt1ORBGBPr14tH0VI=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4966.namprd05.prod.outlook.com (20.177.229.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Tue, 20 Nov 2018 18:52:26 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d%4]) with mapi id 15.20.1361.013; Tue, 20 Nov 2018
 18:52:26 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux_dti@icloud.com" <linux_dti@icloud.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v5 00/10] x86/alternative: text_poke() fixes
Thread-Topic: [PATCH v5 00/10] x86/alternative: text_poke() fixes
Thread-Index: AQHUe48LR19TRX3+q0WdrGHXr4DmHKVYpeQAgABnWIA=
Date:   Tue, 20 Nov 2018 18:52:25 +0000
Message-ID: <05F89744-E7B7-4670-82E8-161CB84821A7@vmware.com>
References: <20181113130730.44844-1-namit@vmware.com>
 <20181120124232.GK2131@hirez.programming.kicks-ass.net>
In-Reply-To: <20181120124232.GK2131@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4966;20:faYVM143eadIDJ7QKdT1sj4iK/PBWk4UkxCwD/jUiYzGND+tEhV2GR1fyYMig0Tcdgl4il9p/7dhXWhOnjaU2BANAhFjPF+cOxTTtqF2bF5QztfuEAt6/d4XnHvAHKNISuJkXSQk6vTCsCYy9dbkl7urKihB/LnWZ+BMotkKnhE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e73ece9a-40d6-4a62-0786-08d64f195067
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4966;
x-ms-traffictypediagnostic: BYAPR05MB4966:
x-microsoft-antispam-prvs: <BYAPR05MB496603393C529331CAF31AE5D0D90@BYAPR05MB4966.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231442)(944501410)(52105112)(10201501046)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB4966;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4966;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(366004)(199004)(189003)(68736007)(476003)(6916009)(2616005)(305945005)(486006)(229853002)(33656002)(6436002)(6486002)(256004)(14444005)(97736004)(8936002)(8676002)(7416002)(82746002)(106356001)(81166006)(105586002)(25786009)(4326008)(2900100001)(5660300001)(478600001)(53546011)(66066001)(186003)(11346002)(446003)(7736002)(76176011)(6506007)(14454004)(2906002)(99286004)(102836004)(26005)(54906003)(86362001)(53936002)(81156014)(36756003)(39060400002)(3846002)(6512007)(6116002)(316002)(83716004)(6246003)(71200400001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4966;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3NAwqN7G90R74vrpt1PgFN2OUqyWZItoryhiFh3VFIYVNK+pE4zclqIt5f4V7w0CpzB/QUC6A45kalczjdVpAkpqmJKCfZtmsw7o8rC28IDGxULrwaBdwNeoeCFAUL5UYziK1RobHLMPfkLwRnapJODmkgkKlOzK0f9yrHn24TAk43N0cqwZJvJQnqEkHopLhp6ZQWS3ASbunmZdeNFXP0i7lBSaenPvNjDMheCjRMMPWImptj1brLF/9kLpymmQPnS1KRa6aSzorHCgoSXBT0BdZse6VgfPpwErZeFAY+p/Q29BZwT0a5yh12tbwmjwd3I1I/8LPooBVI/lVhFNloAUeIEiMvvW4K9KyIDvJTE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1A2F4FAC8D5094A9AF9F7E6C9ADD548@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e73ece9a-40d6-4a62-0786-08d64f195067
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 18:52:25.9538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4966
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBOb3YgMjAsIDIwMTgsIGF0IDQ6NDIgQU0sIFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5m
cmFkZWFkLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBUdWUsIE5vdiAxMywgMjAxOCBhdCAwNTowNzoy
MEFNIC0wODAwLCBOYWRhdiBBbWl0IHdyb3RlOg0KPj4gdjQtPnY1Og0KPj4gLSBGaXggWGVuIGJy
ZWFrYWdlIFtEYW1pYW4gVG9tZXR6a2ldDQo+PiAtIEJVR19PTigpIHdoZW4gcG9raW5nX21tIGlu
aXRpYWxpemF0aW9uIGZhaWxzIFtQZXRlclpdDQo+PiAtIEJldHRlciBjb21tZW50cyBvbiAieDg2
L21tOiB0ZW1wb3JhcnkgbW0gc3RydWN0Ig0KPj4gLSBDbGVhbmVyIHJlbW92YWwgb2YgdGhlIGN1
c3RvbSBwb2tlcg0KPiANCj4gSSdsbCByZS1pdGVyYXRlIG15IHBvc2l0aW9uOiBpdCBpcyBpbXBv
c3NpYmxlIGZvciB0aGUgdGV4dCBub3QgdG8gbWF0Y2gsDQo+IGFuZCBpZiBpdCBzb21laG93IGRv
ZXMgbm90IG1hdGNoLCBzb21ldGhpbmcgd2VudCBzaWRld2F5cyBpbiBhbg0KPiB1bnJlY292ZXJh
Ymx5IGZhc2hpb24uDQo+IA0KPiB0ZXh0X3Bva2UoKSBtdXN0IG5vdCBmYWlsLCBldmVyLiBJZiBp
dCBkb2VzLCBvdXIgdGV4dCBpcyBpbmNvbnNpc3RlbnQNCj4gYW5kIHdlIG11c3QgYWJvcnQvcGFu
aWMvYnVnLg0KPiANCj4gVGhlIG9ubHkgd2F5IEkgd2lsbCBhY2NlcHQgYW55dGhpbmcgZWxzZSBp
cyBpZiBzb21lb25lIGNhbiBjb21lIHVwIHdpdGgNCj4gYSBzZW5zaWJsZSBzY2VuYXJpbyBvZiB0
ZXh0X3Bva2UoKSBmYWlsaW5nIGFuZCByZWNvdmVyaW5nIGZyb20gaXQuDQo+IEFGQUlDVCB0aGVy
ZSBpcyBubyBwb3NzaWJsZSB3YXkgdG8gZ3JhY2VmdWxseSByZWNvdmVyLg0KPiANCj4gQ29uc2lk
ZXIgYSBqdW1wIGxhYmVsIHdpdGggbXVsdGlwbGUgcGF0Y2ggc2l0ZXM7IHdlIHBhdGNoIHRoZSBm
aXJzdCwNCj4gdGhlbiBmYWlsLiBJbiBvcmRlciB0byByZXN0b3JlIHRvIGEgc2FuZSBzdGF0ZSwg
d2UgbXVzdCB1bmRvIHRoZQ0KPiBwYXRjaGluZyBvZiB0aGUgZmlyc3QsIGJ1dCB1bmRvaW5nIHRl
eHRfcG9rZSgpIGZhaWxzIGFnYWluLiBUaGVuDQo+IHdoYXQ/DQo+IA0KPiBBbGxvd2luZyB0ZXh0
X3Bva2UoKSB0byBmYWlsIG9ubHkgY3JlYXRlcyBhbiB1bmZpeGFibGUgbWVzcy4gRXNwLiBzaW5j
ZQ0KPiB0aGVyZSBpcyBubyBzYW5lIHNjZW5hcmlvIHVuZGVyIHdoaWNoIGlzIGNhbiBmYWlsLg0K
DQpPaywgb2suLi4gSSB0cmllZCB0byBzdGFuZCBteSBncm91bmQsIGJ1dCBJIGd1ZXNzIEkgZmFp
bGVkLiBJIGRvbuKAmXQgZmVlbA0KdGhhdCBzdHJvbmdseSBhYm91dCB0aGlzIGFzc2VydGlvbiB0
byBhcmd1ZSB3aXRoIHlvdS4gSeKAmW0ganVzdCB0aGUg4oCcY2hpY2tlbuKAnQ0Ka2luZCBvZiBn
dXkuDQoNCllldCwgdGFrZSBpbnRvIGNvbnNpZGVyYXRpb24gdGhhdCBJIHdpbGwgbmVlZCB0byB1
c2UgeW91IGFzIG15IOKAnHZlc3TigJ0gb25jZSBJDQpnZXQgYmVpbmcg4oCcc2hvdOKAnSBmb3Ig
YWRkaW5nIEJVR19PTigpLiA7LSkNCg0KSSB3aWxsIHNlbmQgYW5vdGhlciB2ZXJzaW9uIHRvbmln
aHQsIGFzc3VtaW5nIG5vIG5ldyBpc3N1ZXMgYXJlIHJhaXNlZC4NCg0KUmVnYXJkcywNCk5BZGF2
