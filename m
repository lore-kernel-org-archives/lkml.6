Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5AFC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6072064E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="abgumS44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C6072064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbeJKXvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:51:00 -0400
Received: from mail-eopbgr60061.outbound.protection.outlook.com ([40.107.6.61]:4672
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729055AbeJKXvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdGgxfxP5g7BNLnlSUKnCcd/yeZa5vn50u8FqNKEysQ=;
 b=abgumS44TA1GlsXaxmG9yoLKH8RBely7G6dOb39k8xPtpYd0AvOnLD6mYj2X2/X0qC/1eF+j2hVioP0aaMXB/EvIgjb//HVyYn5nFlRBvYf4zQ9b58BofBu8Ta5fiBbqPh9+mFFpHX8t2nz9idVUjDx5mstyjvBbwLZJxSdtSZ8=
Received: from VI1PR08MB3294.eurprd08.prod.outlook.com (52.134.31.11) by
 VI1PR08MB0910.eurprd08.prod.outlook.com (10.166.143.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Thu, 11 Oct 2018 16:20:06 +0000
Received: from VI1PR08MB3294.eurprd08.prod.outlook.com
 ([fe80::71c4:7004:818f:2d71]) by VI1PR08MB3294.eurprd08.prod.outlook.com
 ([fe80::71c4:7004:818f:2d71%3]) with mapi id 15.20.1207.029; Thu, 11 Oct 2018
 16:20:06 +0000
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
Thread-Index: AQHUYM5AJL7p/dPuu0ud+WbMPMG0kKUZ6+eAgAA8aQCAABKZAA==
Date:   Thu, 11 Oct 2018 16:20:05 +0000
Message-ID: <3896e4f5-aab1-ae79-5360-088fd15ed380@arm.com>
References: <20181010191936.7495-1-mathieu.desnoyers@efficios.com>
 <20181010191936.7495-2-mathieu.desnoyers@efficios.com>
 <38596780-30f7-0763-0c17-7517dbf0bf59@arm.com>
 <1917048565.2402.1539270808972.JavaMail.zimbra@efficios.com>
In-Reply-To: <1917048565.2402.1539270808972.JavaMail.zimbra@efficios.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
x-originating-ip: [217.140.106.49]
x-clientproxiedby: AM0PR05CA0041.eurprd05.prod.outlook.com
 (2603:10a6:208:be::18) To VI1PR08MB3294.eurprd08.prod.outlook.com
 (2603:10a6:803:3e::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR08MB0910;6:GvYPKl8Zxn+R42cmErVRIlRZtGvBaZHQxtpZPPS6D1L2BOTn+IJSIGnVusmhtognU0PeMoHnsF8fmGk//gkRmsc7fo0eiXK5Uck/zG9AjPjoSeWZ1qzal3dhul1NOiUfWPD2fe79smlK7I+oEPb1iVWT5iuoKp4YY7vHQyRbwex+nhJw1xHg39Hg3hfJOzGEfrZb6TjcloBPuCpL34NuEGht4YviYOHegmVBBebntlEgCc9Sq4gA71Zs8JWXGUfdQg1GYMbq7aSvbAWBURc+4phcMLYcZADVuWOqQIs20BQKDyOP9cal67Upi3lwOauleG1fNKbdXsvC2DpD4XSmhgpP/pbq4UH1P/ciKzb6XW4pyf7+RrauG6WZmDcJx0h0O4J+6stI6vaemy3VaAC6xg7MsodZ6l4LKnmUNjfkLcBC3xzisHOmIcMUz1e28L2n0uLee98JZ8jdMUA+fQCVVg==;5:dpNVPJMqgAd0mkxpgRmzXnQdMjlMlZEyIKZZsKRyZdYWAZH32Ld9FEynNRnmiLKyW9HZd7lyw6fuFksE568IH3QFBCJU70UuiSc0w0fqAbaZ2dvJn5NKr9geTWgDZtINE3L+iwLI30QpgcjoT/DajmrqamxtJ65am1h/N59e0Kk=;7:tpuFF0C7I7Anx/BTkssHthXkBVoCm3Xj/GzkmOwM8cvlpL9azNfu+eoR+2RlIErBQiSAaWta+UYrVSd9/t9pbbBK8HofpxGnyKMz9LWGNNC5pcpZlkMvdRqaxNXUNKk6iBJR/RqxLqhKicX+FDaKzKFlgfHbQmWU29hxQpbcd1Q4TIwczdthJ2/QaTwzsMwauBcH+SX5xS9pnnfq+sy6zif88Y1IHb+n493g+Fxbta24jf5L90pYU0WAIvr42f6x
x-ms-office365-filtering-correlation-id: fcaeaeac-6484-412b-581c-08d62f956791
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB0910;
x-ms-traffictypediagnostic: VI1PR08MB0910:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR08MB0910494FD35C434867327458EDE10@VI1PR08MB0910.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(278428928389397);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991055);SRVR:VI1PR08MB0910;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB0910;
x-forefront-prvs: 08220FA8D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(346002)(136003)(396003)(199004)(189003)(31696002)(76176011)(68736007)(11346002)(5660300001)(2616005)(86362001)(99286004)(58126008)(2900100001)(6512007)(25786009)(54906003)(71190400001)(71200400001)(6916009)(64126003)(52116002)(65806001)(217873002)(39060400002)(66066001)(65956001)(486006)(44832011)(14444005)(446003)(65826007)(256004)(476003)(53546011)(6506007)(386003)(105586002)(36756003)(7416002)(8676002)(316002)(14454004)(2906002)(5250100002)(106356001)(186003)(4326008)(229853002)(3846002)(97736004)(6116002)(31686004)(26005)(102836004)(6436002)(6486002)(6246003)(93886005)(305945005)(81156014)(478600001)(7736002)(81166006)(53936002)(72206003)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB0910;H:VI1PR08MB3294.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FYTeeLtXdHHdSF8Kw0Ega6N/S4L8+rz3cTZYxdiJL+Z34PSwBhzGR6ukQWUxqcGO2JPeWE3bsCJV0/bJD/IHf98eX5CPDBiWYbc6OHWf+tOMGxDYFFcfj6e5HixUMOUaSdy6Zlng5S8h5zczXQCKJtaEZ/aHt3U1yEyYbCKf63RIX+fm0KOf3beTTEG2/EuEQ1LAjOg2s7tQrHC3hLSGW92+N1TMOFe2IE9ZPDCoQDF1Un6dsz7nOyfOOc/8DXh+AjZ2fZ5ZdOAMAAFrBkRoGIdNf8NH2CAjbv8dZhr0TmG/2P8WIL5cBtm/mc907i24wDVYNwHC0YDGGdmhYJpY7TeFfkZfL68BoztPtT05Y1s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC55997B59EB584AA9C8E212923066E9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcaeaeac-6484-412b-581c-08d62f956791
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2018 16:20:05.9719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB0910
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMTAvMTggMTY6MTMsIE1hdGhpZXUgRGVzbm95ZXJzIHdyb3RlOg0KPiAtLS0tLSBPbiBP
Y3QgMTEsIDIwMTgsIGF0IDY6MzcgQU0sIFN6YWJvbGNzIE5hZ3kgU3phYm9sY3MuTmFneUBhcm0u
Y29tIHdyb3RlOg0KPiANCj4+IE9uIDEwLzEwLzE4IDIwOjE5LCBNYXRoaWV1IERlc25veWVycyB3
cm90ZToNCj4+PiBJbiBvcmRlciB0byBpbnRlZ3JhdGUgcnNlcSBpbnRvIHVzZXItc3BhY2UgYXBw
bGljYXRpb25zLCBhZGQgYSByZWZlcmVuY2UNCj4+PiBjb3VudGVyIGZpZWxkIGFmdGVyIHRoZSBz
dHJ1Y3QgcnNlcSBUTFMgQUJJIHNvIG1hbnkgcnNlcSB1c2VycyBjYW4gYmUNCj4+PiBsaW5rZWQg
aW50byB0aGUgc2FtZSBhcHBsaWNhdGlvbiAoZS5nLiBsaWJyc2VxIGFuZCBnbGliYykuIFRoZQ0K
Pj4+IHJlZmVyZW5jZSBjb3VudCBlbnN1cmVzIHRoYXQgcnNlcSBzeXNjYWxsIHJlZ2lzdHJhdGlv
bi91bnJlZ2lzdHJhdGlvbg0KPj4+IGhhcHBlbnMgb25seSBmb3IgdGhlIG1vc3QgZWFybHkvbGF0
ZSB1c2VyIGZvciBlYWNoIHRocmVhZCwgdGh1cyBlbnN1cmluZw0KPj4+IHRoYXQgcnNlcSBpcyBy
ZWdpc3RlcmVkIGFjcm9zcyB0aGUgbGlmZXRpbWUgb2YgYWxsIHJzZXEgdXNlcnMgZm9yIGENCj4+
PiBnaXZlbiB0aHJlYWQuDQo+PiAuLi4NCj4+PiArX19hdHRyaWJ1dGVfXygodmlzaWJpbGl0eSgi
aGlkZGVuIikpKSBfX3RocmVhZA0KPj4+ICt2b2xhdGlsZSBzdHJ1Y3QgbGliY19yc2VxIF9fbGli
X3JzZXFfYWJpID0gew0KPj4gLi4uDQo+Pj4gK2V4dGVybiBfX2F0dHJpYnV0ZV9fKCh3ZWFrLCBh
bGlhcygiX19saWJfcnNlcV9hYmkiKSkpIF9fdGhyZWFkDQo+Pj4gK3ZvbGF0aWxlIHN0cnVjdCBy
c2VxIF9fcnNlcV9hYmk7DQo+PiAuLi4NCj4+PiBAQCAtNzAsNyArODYsNyBAQCBpbnQgcnNlcV9y
ZWdpc3Rlcl9jdXJyZW50X3RocmVhZCh2b2lkKQ0KPj4+ICAJc2lnc2V0X3Qgb2xkc2V0Ow0KPj4+
ICANCj4+PiAgCXNpZ25hbF9vZmZfc2F2ZSgmb2xkc2V0KTsNCj4+PiAtCWlmIChyZWZjb3VudCsr
KQ0KPj4+ICsJaWYgKF9fbGliX3JzZXFfYWJpLnJlZmNvdW50KyspDQo+Pj4gIAkJZ290byBlbmQ7
DQo+Pj4gIAlyYyA9IHN5c19yc2VxKCZfX3JzZXFfYWJpLCBzaXplb2Yoc3RydWN0IHJzZXEpLCAw
LCBSU0VRX1NJRyk7DQo+Pg0KPj4gd2h5IGRvIHlvdSB1c2UgYSBsb2NhbCByZWZjb3VudGVyIGlu
c3RlYWQgb2YgdGhlIF9fcnNlcV9hYmkgb25lPw0KPiANCj4gVGhlcmUgaXMgbm8gcmVmY291bnQg
aW4gc3RydWN0IHJzZXEgKHRoZSBBQkkgYmV0d2VlbiBrZXJuZWwgYW5kIHVzZXItc3BhY2UpLg0K
PiBUaGUgcmVnaXN0cmF0aW9uIHJlZmNvdW50IHdhcyBwYXJ0IG9mIGFuIGVhcmxpZXIgdmVyc2lv
biBvZiB0aGUgcnNlcSBzeXN0ZW0gY2FsbCwNCj4gYnV0IHdlIGRlY2lkZWQgYWdhaW5zdCBrZWVw
aW5nIGl0IGluIHRoZSBrZXJuZWwuDQo+IA0KPiBTbyBJJ20gYWRkaW5nIG9uZSBfYWZ0ZXJfIHN0
cnVjdCByc2VxLCBwdXJlbHkgdG8gYWxsb3cgaW50ZXJhY3Rpb24gYmV0d2Vlbg0KPiB2YXJpb3Vz
IHVzZXItc3BhY2UgY29tcG9uZW50cyAocHJvZ3JhbS9saWJyYXJpZXMpLg0KDQp0aGVuIGFsbCB0
aG9zZSBjb21wb25lbnRzIG11c3QgdXNlIHRoZSBzYW1lDQoNCiAgcnNlcV9yZWdpc3Rlcl9jdXJy
ZW50X3RocmVhZA0KICByc2VxX3VucmVnaXN0ZXJfY3VycmVudF90aHJlYWQNCg0KZnVuY3Rpb25z
IGFuZCBub3QgY2FsbCB0aGUgc3lzY2FsbCBvbiB0aGVpciBvd24uDQoNCmluIHdoaWNoIGNhc2Ug
dGhlIHJlZmNvdW50IGNvdWxkIGJlIGEgc3RhdGljIF9fdGhyZWFkIHZhcmlhYmxlLg0KDQpidXQg
aXQncyBpbiBhIG1hZ2ljIHN0cnVjdCB0aGF0J3MgY2FsbGVkICJhYmkiIHdoaWNoIGlzIGNvbmZ1
c2luZywNCnRoZSBjb3VudGVyIGlzIG5vdCBhYmksIGl0J3MgaW4gYSBoaWRkZW4gb2JqZWN0Lg0K
DQo+PiB3aGF0IHByZXZlbnRzIGNhbGxpbmcgcnNlcV9yZWdpc3Rlcl9jdXJyZW50X3RocmVhZCBt
b3JlIHRoYW4gNEcgdGltZXM/DQo+IA0KPiBOb3RoaW5nLiBJdCB3b3VsZCBpbmRlZWQgYmUgY2xl
YW5lciB0byBlcnJvciBvdXQgaWYgd2UgZGV0ZWN0IHRoYXQgcmVmY291bnQgaXMgYXQNCj4gSU5U
X01BWC4gSXMgdGhhdCB3aGF0IHlvdSBoYXZlIGluIG1pbmQgPw0KDQp5ZXMNCg0KPj4gd2h5IGNh
bnQgdGhlIGtlcm5lbCBzZWUgdGhhdCB0aGUgc2FtZSBhZGRyZXNzIGlzIHJlZ2lzdGVyZWQgYWdh
aW4gYW5kIHN1Y2NlZWQ/DQo+IA0KPiBJdCBjYW4sIGFuZCBpdCBkb2VzLiBIb3dldmVyLCByZWZj
b3VudGluZyBhdCB1c2VyLWxldmVsIGlzIG5lZWRlZCB0byBlbnN1cmUNCj4gdGhlIHJlZ2lzdHJh
dGlvbiAibGlmZXRpbWUiIGZvciByc2VxIGNvdmVycyBpdHMgZW50aXJlIHVzZS4gSWYgd2UgaGF2
ZSB0d28gbGlicmFyaWVzDQo+IHVzaW5nIHJzZXEsIHdlIGVuZCB1cCB3aXRoIHRoZSBmb2xsb3dp
bmcgc2NlbmFyaW86DQo+IA0KPiBUaHJlYWQgMQ0KPiANCj4gICBsaWJBIHJlZ2lzdGVycyByc2Vx
DQo+ICAgbGliQiByZWdpc3RlcnMgcnNlcQ0KPiAgIGxpYkIgdW5yZWdpc3RlcnMgcnNlcQ0KPiAg
IGxpYkEgdXNlcyByc2VxIC0+IGJ1ZyEgaXQncyBiZWVuIHVucmVnaXN0ZXJlZCBieSBsaWJCLg0K
PiAgIGxpYkEgdW5yZWdpc3RlcnMgcnNlcSAtPiB1bmV4cGVjdGVkLCBpdCdzIGFscmVhZHkgYmVl
biB1bnJlZ2lzdGVyZWQuDQo+ICANCj4gc2FtZSBhcHBsaWVzIGlmIGxpYkEgdW5yZWdpc3RlcnMg
cnNlcSBiZWZvcmUgbGliQiAoYW5kIGxpYkIgdHJ5IHRvIHVzZSByc2VxDQo+IGFmdGVyIGxpYkEg
aGFzIHVucmVnaXN0ZXJlZCkuDQo+IA0KPiBUaGUgcmVmY291bnQgaW4gdXNlci1zcGFjZSBmaXhl
cyB0aGlzLg0KDQppIHNlZS4NCg0KPiBUaG91Z2h0cyA/DQo+IA0KPiBUaGFua3MsDQo+IA0KPiBN
YXRoaWV1DQo+IA0KDQo=
