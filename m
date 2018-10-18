Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF65ECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 03:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B95F21470
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 03:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="NLZjBh7F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B95F21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbeJRLLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 07:11:01 -0400
Received: from mail-eopbgr730082.outbound.protection.outlook.com ([40.107.73.82]:51988
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727247AbeJRLLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 07:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORFdnwX3fHNY2mTDhxmaSKBsjdigadHEYL74WvoyMWs=;
 b=NLZjBh7Fjfzx6cuK4nvhjh64Y3M+qybFHt9YqMMrUR/gmmIpdY/D9dUAmfk1cevh/279kT7AsgAzXKUDr48eGw30Fq62dEHAv2FjVwIw9LUi4Pv+3lBTkUq/Z8jXNXb8waRY41JxSyWSwJvK2h3NoY66XJtbMBbCZ88im/BZCGQ=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5590.namprd05.prod.outlook.com (20.177.186.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.19; Thu, 18 Oct 2018 03:12:07 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2%5]) with mapi id 15.20.1250.020; Thu, 18 Oct 2018
 03:12:07 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@amacapital.net>
CC:     Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [RFC PATCH 1/5] x86: introduce preemption disable prefix
Thread-Topic: [RFC PATCH 1/5] x86: introduce preemption disable prefix
Thread-Index: AQHUZn1pCzXLEno8kUGEBsbCNoIC6KUkNS4AgAAefQA=
Date:   Thu, 18 Oct 2018 03:12:07 +0000
Message-ID: <07255D2B-0243-4254-B62A-37050C44207E@vmware.com>
References: <20181018005420.82993-1-namit@vmware.com>
 <20181018005420.82993-2-namit@vmware.com>
 <D247AB7C-2890-49CE-B102-163E5B368FC2@amacapital.net>
In-Reply-To: <D247AB7C-2890-49CE-B102-163E5B368FC2@amacapital.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [2601:647:4580:b719:fcb2:910c:4ac5:85aa]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5590;20:ItzMCj7d9ZRYgmL0Aly1k0vmTP7vo9KzHjYZrNrEedFjRX9KFs2hxbz2FW2+5IT2G08j7JPFxssBR+oPrJxagfy0BFJircteb7x8Ob/PlfuxI1hFiNkdoFWlsU+3sStoLVbIaPN8+d0JRYAC9whzQoVfbAtLtRK/Y/RPsVnI3QQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 05c0b9e7-c68c-4464-adee-08d634a77c96
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5590;
x-ms-traffictypediagnostic: BYAPR05MB5590:
x-microsoft-antispam-prvs: <BYAPR05MB559046C5722301768A9AB17ED0F80@BYAPR05MB5590.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB5590;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB5590;
x-forefront-prvs: 08296C9B35
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(366004)(346002)(51444003)(199004)(189003)(83716004)(86362001)(229853002)(14444005)(256004)(6506007)(186003)(53936002)(6512007)(106356001)(33656002)(2900100001)(6486002)(6436002)(6916009)(5250100002)(6246003)(81156014)(54906003)(68736007)(36756003)(6116002)(53546011)(14454004)(105586002)(8676002)(8936002)(478600001)(81166006)(5660300001)(316002)(76176011)(82746002)(7416002)(7736002)(71200400001)(486006)(2906002)(305945005)(25786009)(476003)(11346002)(446003)(71190400001)(97736004)(99286004)(46003)(102836004)(2616005)(217873002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5590;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8mEWxj0vdUTw5u8VNjU5LyU7S8zHxcVJ+NJKOsHHurGmjAYran6+qxljIX3MPZXeSXbVnNFbRDYXzAECR45dAVg9p3uArhgyw5xlyQi2x31ncN604zAqWI0z8fP/vGUJA1Dfe/RoHRaXFRjqplroIvfLzywVA395ixT1fN7/+2p/IkglkkoOBiLun94Z4ziRb45YudTu7gCZ3KQLWAsc2RhM7NVxBb3qmQMQ2ovKQmeSZF0otBK1J6CoGbyJNYGyCvq93tV94UYNs7E/QMtsoXvPqzl982CC0aHsuD6UT5QJj+LhpbIccWWiQ/Np4BE4BCJrpdSZXRI3KyhxKYv0wMaHQYaKigz61a+9GgJdFvo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCCEF4B4AFAB794990C61D13394A2BEE@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c0b9e7-c68c-4464-adee-08d634a77c96
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2018 03:12:07.1604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5590
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgNjoyMiBQTSwgQW5keSBMdXRvbWlyc2tpIDxsdXRvQGFtYWNhcGl0YWwubmV0PiB3cm90ZToN
Cg0KPiANCj4+IE9uIE9jdCAxNywgMjAxOCwgYXQgNTo1NCBQTSwgTmFkYXYgQW1pdCA8bmFtaXRA
dm13YXJlLmNvbT4gd3JvdGU6DQo+PiANCj4+IEl0IGlzIHNvbWV0aW1lcyBiZW5lZmljaWFsIHRv
IHByZXZlbnQgcHJlZW1wdGlvbiBmb3IgdmVyeSBmZXcNCj4+IGluc3RydWN0aW9ucywgb3IgcHJl
dmVudCBwcmVlbXB0aW9uIGZvciBzb21lIGluc3RydWN0aW9ucyB0aGF0IHByZWNlZGUNCj4+IGEg
YnJhbmNoICh0aGlzIGxhdHRlciBjYXNlIHdpbGwgYmUgaW50cm9kdWNlZCBpbiB0aGUgbmV4dCBw
YXRjaGVzKS4NCj4+IA0KPj4gVG8gcHJvdmlkZSBzdWNoIGZ1bmN0aW9uYWxpdHkgb24geDg2LTY0
LCB3ZSB1c2UgYW4gZW1wdHkgUkVYLXByZWZpeA0KPj4gKG9wY29kZSAweDQwKSBhcyBhbiBpbmRp
Y2F0aW9uIHRoYXQgcHJlZW1wdGlvbiBpcyBkaXNhYmxlZCBmb3IgdGhlDQo+PiBmb2xsb3dpbmcg
aW5zdHJ1Y3Rpb24uDQo+IA0KPiBOaWZ0eSENCj4gDQo+IFRoYXQgYmVpbmcgc2FpZCwgSSB0aGlu
ayB5b3UgaGF2ZSBhIGZldyBidWdzLiBGaXJzdCwgeW91IGNhbuKAmXQganVzdCBpZ25vcmUNCj4g
YSByZXNjaGVkdWxpbmcgaW50ZXJydXB0LCBhcyB5b3UgaW50cm9kdWNlIHVuYm91bmRlZCBsYXRl
bmN5IHdoZW4gdGhpcw0KPiBoYXBwZW5zIOKAlCB5b3XigJlyZSBlZmZlY3RpdmVseSBlbXVsYXRp
bmcgcHJlZW1wdF9lbmFibGVfbm9fcmVzY2hlZCgpLCB3aGljaA0KPiBpcyBub3QgYSBkcm9wLWlu
IHJlcGxhY2VtZW50IGZvciBwcmVlbXB0X2VuYWJsZSgpLiBUbyBmaXggdGhpcywgeW91IG1heQ0K
PiBuZWVkIHRvIGp1bXAgdG8gYSBzbG93LXBhdGggdHJhbXBvbGluZSB0aGF0IGNhbGxzIHNjaGVk
dWxlKCkgYXQgdGhlIGVuZCBvcg0KPiBjb25zaWRlciByZXdpbmRpbmcgb25lIGluc3RydWN0aW9u
IGluc3RlYWQuIE9yIHVzZSBURiwgd2hpY2ggaXMgb25seSBhDQo+IGxpdHRsZSBiaXQgdGVycmlm
eWluZ+KApg0KDQpZZXMsIEkgZGlkbuKAmXQgcGF5IGVub3VnaCBhdHRlbnRpb24gaGVyZS4gRm9y
IG15IHVzZS1jYXNlLCBJIHRoaW5rIHRoYXQgdGhlDQplYXNpZXN0IHNvbHV0aW9uIHdvdWxkIGJl
IHRvIG1ha2Ugc3luY2hyb25pemVfc2NoZWQoKSBpZ25vcmUgcHJlZW1wdGlvbnMNCnRoYXQgaGFw
cGVuIHdoaWxlIHRoZSBwcmVmaXggaXMgZGV0ZWN0ZWQuIEl0IHdvdWxkIHNsaWdodGx5IGNoYW5n
ZSB0aGUNCm1lYW5pbmcgb2YgdGhlIHByZWZpeC4NCg0KPiBZb3UgYWxzbyBhcmVu4oCZdCBhY2Nv
dW50aW5nIGZvciB0aGUgY2FzZSB3aGVyZSB5b3UgZ2V0IGFuIGV4Y2VwdGlvbiB0aGF0DQo+IGlz
LCBpbiB0dXJuLCBwcmVlbXB0ZWQuDQoNCkhtbS4uIENhbiB5b3UgZ2l2ZSBtZSBhbiBleGFtcGxl
IGZvciBzdWNoIGFuIGV4Y2VwdGlvbiBpbiBteSB1c2UtY2FzZT8gSQ0KY2Fubm90IHRoaW5rIG9m
IGFuIGV4Y2VwdGlvbiB0aGF0IG1pZ2h0IGJlIHByZWVtcHRlZCAoYXNzdW1pbmcgI0JQLCAjTUMN
CmNhbm5vdCBiZSBwcmVlbXB0ZWQpLg0KDQpJIGFncmVlIHRoYXQgZm9yIHN1cGVyLWdlbmVyYWwg
Y2FzZSB0aGlzIG1pZ2h0IGJlIGluYXBwcm9wcmlhdGUuDQoNCg==
