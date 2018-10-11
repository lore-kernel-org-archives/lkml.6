Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641A7C677FF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1637C2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="gx98H+h7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1637C2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730826AbeJLAcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:32:41 -0400
Received: from mail-eopbgr40040.outbound.protection.outlook.com ([40.107.4.40]:24672
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728360AbeJLAcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 20:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAgQXINg1ZtGNQyFSGrSeNi5o/TU4W4iEJN/KuZ2vdo=;
 b=gx98H+h7cEAoYp/VS3dyH7HtRnGSSfQtBn81WzZcnyNgKk2/hBHfiQcawSP239lEWz6KoOUMNfq7cS2SbeVsqy55UYla9VPP1X8xFAyxh0UHZTMcBTZH+w5/I4w/Ho/qwKhNaFmY+RdFsOAy0VcbcIP4fAKFD9JhLX0dHtc9ZmM=
Received: from VI1PR08MB3294.eurprd08.prod.outlook.com (52.134.31.11) by
 VI1PR08MB3661.eurprd08.prod.outlook.com (20.177.61.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.28; Thu, 11 Oct 2018 17:04:28 +0000
Received: from VI1PR08MB3294.eurprd08.prod.outlook.com
 ([fe80::71c4:7004:818f:2d71]) by VI1PR08MB3294.eurprd08.prod.outlook.com
 ([fe80::71c4:7004:818f:2d71%3]) with mapi id 15.20.1207.029; Thu, 11 Oct 2018
 17:04:28 +0000
From:   Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     nd <nd@arm.com>, Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>, shuah <shuah@kernel.org>,
        carlos <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>
Subject: Re: [RFC PATCH for 4.21 01/16] rseq/selftests: Add reference counter
 to coexist with glibc
Thread-Topic: [RFC PATCH for 4.21 01/16] rseq/selftests: Add reference counter
 to coexist with glibc
Thread-Index: AQHUYM5AJL7p/dPuu0ud+WbMPMG0kKUZ6+eAgAA8aQCAABKZANa4sq5ZqUdZuAA=
Date:   Thu, 11 Oct 2018 17:04:28 +0000
Message-ID: <f22ef029-2f30-6bd9-e46a-9e7b0a1e9225@arm.com>
References: <20181010191936.7495-1-mathieu.desnoyers@efficios.com>
 <20181010191936.7495-2-mathieu.desnoyers@efficios.com>
 <38596780-30f7-0763-0c17-7517dbf0bf59@arm.com>
 <1917048565.2402.1539270808972.JavaMail.zimbra@efficios.com>
 <3896e4f5-aab1-ae79-5360-088fd15ed380@arm.com>
 <1680616760.2469.1539275846360.JavaMail.zimbra@efficios.com>
In-Reply-To: <1680616760.2469.1539275846360.JavaMail.zimbra@efficios.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
x-originating-ip: [217.140.106.49]
x-clientproxiedby: DB7PR03CA0061.eurprd03.prod.outlook.com
 (2603:10a6:5:2a::38) To VI1PR08MB3294.eurprd08.prod.outlook.com
 (2603:10a6:803:3e::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR08MB3661;6:IHwBH5ER9Pta9Kqc7etNKdXroP/6wxBLRDWYM4w9RMpLz21lIFSBtM2DAJx3SRPh0gpJaFqLq/RyTXtqzuaayoZoYjP2IhNTRB4hRUPLiCt8JAHt7QSCpqZaG3BQgxpntrF1C1iPVm5UfNYNHigsJRB7qs9EUsqFrEmxB7M//Ik+BKIM/Ko7VtUcr/0bTdSNcpO0bhzOmng66cEPgX7R9tKvSsefOOyfWxmq78SYoBPu5BeH0QoxN0PqQ2YM4z4wBb5EJAJgE96OhcfTWQ9OL/L1q1ASHg5RXSXJarTkjc7h6iaLxt+OemyTa8dmnr+jrifyN5aU7wUXMd9vPgWcwqEXaYtBbYETEATY3yFDtL3zg82dOv1QHrU1Ks4Z2b//Rbz/aFgljfI0mVOp05YNXHPuwwW94hmEXUphNaCBcEWsotsqrCN9o1JVhxib2GaJ9szuj67OTwkDc2C3dCDr5A==;5:Uk6JrYqcHlSHIWaBf4vpk4LDj409oMOz/UlyyXiTMMi5Y3fGzSJJ4Iv41j4IL1euKpcK/0fhaJnU029ciA0X0rM0XSni6Yl9r4EfISQgnUFR9sq5yqSM+E6lHw8iNesL/iq1SdxrWLVNrApdlDfFiGqZMfsKdOUC6jtCnptKvz4=;7:RGhKV8t/lZM/m1c/j9rcgl4Wmj+/UPyQpqVeXjLM74tqnPrjtaz1tCsUGGKWV1bEPqGYJpbKwp6l9SRhMyMPiydgVor7xrngUAYCNTT5c3SHbFNQGmVviR2HeYEZEyxHkWdnsP0B90poQn/VoRf7hAwcCUSK3QICIgq8SWntAO+AZCMGqNXRnDG4hHAeYuarmZZtvgqYHNca0rc2JHGCErJbjqF8zbyQUJ4bJHjdffLbHoS7n38F5UyIqSaMgarf
x-ms-office365-filtering-correlation-id: feecfc4d-89cc-4a33-cb0e-08d62f9b9a7f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3661;
x-ms-traffictypediagnostic: VI1PR08MB3661:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR08MB3661A78DBD6CE7082340DBCEEDE10@VI1PR08MB3661.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051);SRVR:VI1PR08MB3661;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3661;
x-forefront-prvs: 08220FA8D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(366004)(39860400002)(346002)(189003)(199004)(476003)(31696002)(81166006)(6246003)(72206003)(71200400001)(86362001)(5660300001)(316002)(7736002)(66066001)(81156014)(65956001)(71190400001)(102836004)(31686004)(106356001)(486006)(4326008)(44832011)(39060400002)(8936002)(478600001)(65826007)(25786009)(14454004)(26005)(256004)(186003)(105586002)(65806001)(305945005)(7416002)(93886005)(2616005)(8676002)(76176011)(97736004)(386003)(6116002)(217873002)(6512007)(11346002)(5250100002)(36756003)(446003)(3846002)(99286004)(229853002)(6916009)(64126003)(53546011)(6506007)(68736007)(52116002)(54906003)(2900100001)(6436002)(6486002)(58126008)(2906002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3661;H:VI1PR08MB3294.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0zyYthuBJ3ZA2dTujaxpIVCSFrH+rye/qcbyNrwck2omihL17xijVunJO36KfLp/Fy/RgFPYMlj0WRp7wXDxKH4ZN67QIQBTrhyV4cTrpfPJy3r9MmRrOVWriJgs5cjYTOTdrryW/t6rA0npeeetNtfP78oe2Ffb3+H+vTtLqOObKj35dkKAFiUplvIgtUAzGzdL3RqHEhfTBIK5reB4/qINPnzjEhSzCx8rrhIERNW8Z8JvlRfJYlxto3uafQRKRrN5YQptL4taCNSujrSFp7PQZUBWwa7nrrw0uvWCLyqTlUdU+HAsgWTz9xJe0K04H6xyykNkTjC4Xfe0umJtvcT3Ay05/SwcwRpSBsX4gpE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <64087B4148EC8346BD3D59C1397425D5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feecfc4d-89cc-4a33-cb0e-08d62f9b9a7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2018 17:04:28.2960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3661
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMTAvMTggMTc6MzcsIE1hdGhpZXUgRGVzbm95ZXJzIHdyb3RlOg0KPiAtLS0tLSBPbiBP
Y3QgMTEsIDIwMTgsIGF0IDEyOjIwIFBNLCBTemFib2xjcyBOYWd5IFN6YWJvbGNzLk5hZ3lAYXJt
LmNvbSB3cm90ZToNCj4+IE9uIDExLzEwLzE4IDE2OjEzLCBNYXRoaWV1IERlc25veWVycyB3cm90
ZToNCj4+PiAtLS0tLSBPbiBPY3QgMTEsIDIwMTgsIGF0IDY6MzcgQU0sIFN6YWJvbGNzIE5hZ3kg
U3phYm9sY3MuTmFneUBhcm0uY29tIHdyb3RlOg0KPj4+PiBPbiAxMC8xMC8xOCAyMDoxOSwgTWF0
aGlldSBEZXNub3llcnMgd3JvdGU6DQo+Pj4+PiArX19hdHRyaWJ1dGVfXygodmlzaWJpbGl0eSgi
aGlkZGVuIikpKSBfX3RocmVhZA0KPj4+Pj4gK3ZvbGF0aWxlIHN0cnVjdCBsaWJjX3JzZXEgX19s
aWJfcnNlcV9hYmkgPSB7DQo+Pj4+IC4uLg0KPj4gYnV0IGl0J3MgaW4gYSBtYWdpYyBzdHJ1Y3Qg
dGhhdCdzIGNhbGxlZCAiYWJpIiB3aGljaCBpcyBjb25mdXNpbmcsDQo+PiB0aGUgY291bnRlciBp
cyBub3QgYWJpLCBpdCdzIGluIGEgaGlkZGVuIG9iamVjdC4NCj4gDQo+IE5vLCBpdCBpcyByZWFs
bHkgYW4gQUJJIGJldHdlZW4gdXNlci1zcGFjZSBhcHBzL2xpYnMuIEl0J3Mgbm90IG1lYW50IHRv
IGJlDQo+IGhpZGRlbi4gZ2xpYmMgaW1wbGVtZW50cyBpdHMgb3duIHJlZ2lzdGVyL3VucmVnaXN0
ZXIgZnVuY3Rpb25zIChpdCBkb2VzIG5vdA0KPiBsaW5rIGFnYWluc3QgbGlicnNlcSkuIGxpYnJz
ZXEgZXhwb3NlcyByZWdpc3Rlci91bnJlZ2lzdGVyIGZ1bmN0aW9ucyBhcyBwdWJsaWMNCj4gQVBJ
cy4gVGhvc2UgYWxzbyB1c2UgdGhlIHJlZmNvdW50LiBJIGFsc28gcGxhbiB0byBoYXZlIGV4aXN0
aW5nIGxpYnJhcmllcywgZS5nLg0KPiBsaWJsdHRuZy11c3QgYW5kIHBvc3NpYmx5IGxpYnVyY3Ug
Zmxhdm9ycywgaW1wbGVtZW50IHRoZQ0KPiByZWdpc3RyYXRpb24vdW5yZWdpc3RyYXRpb24gYW5k
IHJlZmNvdW50IGhhbmRsaW5nIG9uIHRoZWlyIG93biwgc28gd2UgZG9uJ3QNCj4gaGF2ZSB0byBh
ZGQgYSByZXF1aXJlbWVudCBvbiBhZGRpdGlvbmFsIGxpbmtpbmcgb24gbGlicnNlcSBmb3IgcHJl
LWV4aXN0aW5nDQo+IGxpYnJhcmllcy4NCj4gDQo+IFNvIHRoYXQgcmVmY291bnQgaXMgbm90IGFu
IEFCSSBiZXR3ZWVuIGtlcm5lbCBhbmQgdXNlci1zcGFjZSwgYnV0IGl0J3MgYQ0KPiB1c2VyLXNw
YWNlIEFCSSBuZXZlcnRoZWxlc3MgKGJldHdlZW4gcHJvZ3JhbSBhbmQgc2hhcmVkIG9iamVjdHMp
Lg0KPiANCg0KaWYgdGhhdCdzIHdoYXQgeW91IHdhbnQsIHRoZW4geW91ciBkZWNsYXJhdGlvbiBp
cyB3cm9uZy4NCnRoZSBvYmplY3Qgc2hvdWxkIG5vdCBoYXZlIGhpZGRlbiB2aXNpYmlsaXR5Lg0K
DQp0aGVuIGVhY2ggbGlicmFyeSAoZ2xpYmMgZXRjKSB3aWxsIGhhdmUgaXRzIG93biBzZXBhcmF0
ZQ0KdGxzIG9iamVjdCB3aXRoIHRoZWlyIG93biBzZXBhcmF0ZSByZWZjb3VudGVyIChhbmQgdGhl
eQ0Kd2lsbCB1bnJlZ2lzdGVyIHdoZW4gdGhlaXIgb3duIHJlZmNvdW50ZXIgaGl0cyAwKQ0KDQpl
aXRoZXIgdGhlIHN0cnVjdCBzaG91bGQgYmUgcHVibGljIGFiaSAoZXh0ZXJuIHRscw0Kc3ltYm9s
KSBvciB0aGUgcmVnaXN0ZXIvdW5yZWdpc3RlciBmdW5jdGlvbnMgc2hvdWxkDQpiZSBwdWJsaWMg
YWJpIChzbyB3aGVuIG11bHRpcGxlIGltcGxlbWVudGF0aW9ucyBhcmUNCnByZXNlbnQgaW4gdGhl
IHNhbWUgcHJvY2VzcyBvbmx5IG9uZSBvZiB0aGVtIHdpbGwNCnByb3ZpZGUgZGVmaW5pdGlvbiBm
b3IgdGhlIHB1YmxpYyBhYmkgc3ltYm9sIGFuZA0KdGh1cyB0aGVyZSB3aWxsIGJlIG9uZSByZWZj
b3VudGVyKS4NCg==
