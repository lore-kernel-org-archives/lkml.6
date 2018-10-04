Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2F9C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ADD12082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="c8eBpSvx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ADD12082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbeJDXZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:25:03 -0400
Received: from mail-bn3nam01on0057.outbound.protection.outlook.com ([104.47.33.57]:4224
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727415AbeJDXZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 19:25:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exKj6/2sLvQ5xAQuPs7BH8Or7vBsOhp49Omfz9y0WeY=;
 b=c8eBpSvxUqYeLMywPnnB1OsXKuftmhdrOcneEXCWic5aQjFIX8K6hm+MXOU7mX6Qr6ndo9j/LPX2TL82eRXDSvnnb8gkDeS0Gea2Gv5+iqtizY9MAzMjHayOMSPNm3/if/mOXYL+IFYmmvGeghVxLv8tvVYwHygmUjtggwRA/6A=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4551.namprd05.prod.outlook.com (52.135.203.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.16; Thu, 4 Oct 2018 16:30:57 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2%3]) with mapi id 15.20.1207.018; Thu, 4 Oct 2018
 16:30:57 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@amacapital.net>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC] x86/cpu_entry_area: move part of it back to fixmap
Thread-Topic: [RFC] x86/cpu_entry_area: move part of it back to fixmap
Thread-Index: AQHUW5+DYNLMbTMpOU+l0vSyUa8/DKUPISmAgAAmpQA=
Date:   Thu, 4 Oct 2018 16:30:57 +0000
Message-ID: <CE9C4B9C-3B11-45D0-812A-F074D687084D@vmware.com>
References: <20181004045948.129142-1-namit@vmware.com>
 <72B0B378-9515-47C4-8937-9F1E823DD236@amacapital.net>
In-Reply-To: <72B0B378-9515-47C4-8937-9F1E823DD236@amacapital.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4551;20:mGmvbs1VwWWxzSQ/KYPWO3b2p4+F2cGFcGI5nHOSiI/dDmavlwSR8r+cKzzPogM4s8xU7cK6kiY/wXxRvWhHGUrS/ePkT72hcknDgqPGYq1dn7UxWpLvmz/zAS/zp1njyhXDFJ6C0z5DxQiAGD+eIW6w4Y+umYuPeyUlzBc1UoE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1792c9e9-7687-41c4-86e9-08d62a16c381
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4551;
x-ms-traffictypediagnostic: BYAPR05MB4551:
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB455136E1A78C55B26B3BC7CCD0EA0@BYAPR05MB4551.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150)(61668805478150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BYAPR05MB4551;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4551;
x-forefront-prvs: 0815F8251E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(366004)(136003)(396003)(54534003)(189003)(199004)(316002)(7736002)(6916009)(186003)(305945005)(53936002)(5660300001)(4326008)(66066001)(5250100002)(14454004)(6306002)(478600001)(6512007)(8936002)(81166006)(81156014)(486006)(8676002)(966005)(33656002)(26005)(25786009)(446003)(97736004)(68736007)(36756003)(11346002)(476003)(2616005)(6486002)(256004)(54906003)(99286004)(86362001)(6506007)(53546011)(3846002)(2900100001)(105586002)(6116002)(71200400001)(76176011)(71190400001)(83716004)(102836004)(82746002)(106356001)(6246003)(6436002)(2906002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4551;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RKSt/UHgmnHiN42Qmhk68kVHYi5Q9r4vCTXBlP/+6rG3qOtzZG6DpeaSrkLBALTlihlQgCWSFvbC/0MOWGhjVNWIvfQ8dpGEuA4VQCRFppD8YP8Z23krNLFP7vIZYCV9uOQ00dL9mcTPMtyS31bFFj4rkarqI9Nz2V6CUWdmAsm3CtJHQlyfTXsdMfZNCgwofKB0BjW/R0K6EKhjcGf2Lf5N3Qwp/xSa/LfdoG+PPIXIuRAv/eXLcTFDNzuPIu299jpJeXDcmzqw975kQ353843XbW2ce58ocv/Z6qq1AfElcZ1Bg2xP/8zKCiCA7pdJ1mcDdDDdCvx1FRsYXBvF5i+wbOyCOgSBmQprFSldzeU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <32B4E5AD388C1248A40583F716BA80CD@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1792c9e9-7687-41c4-86e9-08d62a16c381
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2018 16:30:57.5478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4551
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgNzoxMSBBTSwgQW5keSBMdXRvbWlyc2tpIDxsdXRvQGFtYWNhcGl0YWwubmV0PiB3cm90ZToN
Cg0KPiANCj4gDQo+IE9uIE9jdCAzLCAyMDE4LCBhdCA5OjU5IFBNLCBOYWRhdiBBbWl0IDxuYW1p
dEB2bXdhcmUuY29tPiB3cm90ZToNCj4gDQo+PiBUaGlzIFJGQyBwcm9wb3NlcyB0byByZXR1cm4g
cGFydCBvZiB0aGUgZW50cnktYXJlYSBiYWNrIHRvIHRoZSBmaXhtYXAgdG8NCj4+IGltcHJvdmUg
c3lzdGVtLWNhbGwgcGVyZm9ybWFuY2UuIEN1cnJlbnRseSwgc2luY2UgdGhlIGVudHJ5LWFyZWEg
aXMNCj4+IG1hcHBlZCBmYXIgKG1vcmUgdGhhbiAyR0IpIGF3YXkgZnJvbSB0aGUga2VybmVsIHRl
eHQsIGFuIGluZGlyZWN0IGJyYW5jaA0KPj4gaXMgbmVlZGVkIHRvIGp1bXAgZnJvbSB0aGUgdHJh
bXBvbGluZSBpbnRvIHRoZSBrZXJuZWwuIER1ZSB0byBTcGVjdHJlDQo+PiB2MiwgdnVsbmVyYWJs
ZSBDUFVzIG5lZWQgdG8gdXNlIGEgcmV0cG9saW5lLCB3aGljaCBpbnRyb2R1Y2VzIGFuDQo+PiBv
dmVyaGVhZCBvZiA+MjAgY3ljbGVzLg0KPiANCj4gVGhhdCByZXRwb2xpbmUgaXMgZ29uZSBpbiAt
dGlwLiBDYW4geW91IHNlZSBob3cgeW91ciBjb2RlIHN0YWNrcyB1cCBhZ2FpbnN0IC10aXA/ICBJ
ZiBpdOKAmXMgZW5vdWdoIG9mIGEgd2luIHRvIGp1c3RpZnkgdGhlIGFkZGVkIGNvbXBsZXhpdHks
IHdlIGNhbiB0cnkgaXQuIA0KPiANCj4gWW91IGNhbiBzZWUgc29tZSBwcm9zIGFuZCBjb25zIGlu
IHRoZSBjaGFuZ2Vsb2c6DQo+IA0KPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3RpcC9iZjkwNGQy
NzYyZWU2ZmMxZTRhY2ZjYjA3NzJiYmZiNGEyN2FkOGE2DQoNCkVyci4uIFRoYXTigJlzIHdoYXQg
SSBnZXQgZm9yIG5vdCBmb2xsb3dpbmcgbGttbC4gVmVyeSBuaWNlIGRpc2N1c3Npb24uDQpCYXNl
ZCBvbiBpdCwgSSBtYXkgYmUgYWJsZSB0byBkbyBhbiBhZGRpdGlvbmFsIG1pY3JvLW9wdGltaXph
dGlvbnMgb3INCnR3by4gTGV0IG1lIGdpdmUgaXQgYSB0cnkuDQoNCg==
