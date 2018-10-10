Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614C1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF022077C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=catalogicsoftware.com header.i=@catalogicsoftware.com header.b="c3cR9Fpg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF022077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=catalogicsoftware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeJJL1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 07:27:14 -0400
Received: from us-smtp-delivery-107.mimecast.com ([216.205.24.107]:57883 "EHLO
        us-smtp-delivery-107.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726725AbeJJL1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 07:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=catalogicsoftware.com; s=mimecast20180821; t=1539144423; h=from:from:sender:reply-to:subject:subject:date:date: message-id:message-id:to:to:cc:cc:mime-version:mime-version: content-type:content-type: content-transfer-encoding:content-transfer-encoding: in-reply-to:in-reply-to:references:references; bh=9hnsC8ugBmsrU+XHra92WfEZg/Vxr2SfvuAu+4LQbmI=; b=c3cR9Fpgel6wWZet/71njDpqYEHKnKPTSSEZvvscl6kl7x8hrBuYRIkSsj5u0SjQfdUnZVocidddzCANMWVIKNW0JruLv9Rp9Eo6tjC5j0lF7MDR2+uQr87YUU1wxhjmp4ivzhd/eilo2M5xB4W2+JD5FvaAGMfxvO/1aQgV0vE=
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01lp0112.outbound.protection.outlook.com [207.46.163.112])
 (Using TLS) by us-smtp-1.mimecast.com with ESMTP id
 us-mta-193--N_QxkuvMoyAXYr-eP64GA-1; Wed, 10 Oct 2018 00:00:04 -0400
Received: from DM5PR01MB2348.prod.exchangelabs.com (10.168.192.138) by
 DM5PR01MB2444.prod.exchangelabs.com (10.168.193.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.26; Wed, 10 Oct 2018 03:59:59 +0000
Received: from DM5PR01MB2348.prod.exchangelabs.com
 ([fe80::a16f:30df:2f13:edb1]) by DM5PR01MB2348.prod.exchangelabs.com
 ([fe80::a16f:30df:2f13:edb1%3]) with mapi id 15.20.1228.020; Wed, 10 Oct 2018
 03:59:59 +0000
From:   "Ly, Bryant" <bly@catalogicsoftware.com>
To:     "Nicholas A. Bellinger" <nab@linux-iscsi.org>
CC:     target-devel <target-devel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Christie <mchristi@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 1/2] sched/wait: Add wait_event_lock_irq_timeout for
 TASK_UNINTERRUPTIBLE usage
Thread-Topic: [PATCH 1/2] sched/wait: Add wait_event_lock_irq_timeout for
 TASK_UNINTERRUPTIBLE usage
Thread-Index: AQHUYEiZscDApEuApUSjgpZpGBCNa6UX2toA
Date:   Wed, 10 Oct 2018 03:59:59 +0000
Message-ID: <B75B7DAA-69CB-4507-974E-FCB04D5D986B@catalogicsoftware.com>
References: <1539141790-13557-1-git-send-email-nab@linux-iscsi.org>
 <1539141790-13557-2-git-send-email-nab@linux-iscsi.org>
In-Reply-To: <1539141790-13557-2-git-send-email-nab@linux-iscsi.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [96.42.214.145]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR01MB2444;20:2q6+1cMCufkki5SXG+ikJJpi9m+Sq5IVdqrS1obY6gGOHGzfhiL/Jf9kWk0kUHNfS/CZafSx6JctWPtBsqs2e0MTsNAcYVRQdO+L6w6i6tw68BOCXyQdw08zWahL6punyP3V/0Xq8lWWfOlqS24EHva9nTCQ7JlJuOeYY5hjbGg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b4927904-aeac-4374-d082-08d62e64d93b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR01MB2444;
x-ms-traffictypediagnostic: DM5PR01MB2444:
x-microsoft-antispam-prvs: <DM5PR01MB24441321AB74EED6C6A4CC21B4E00@DM5PR01MB2444.prod.exchangelabs.com>
x-exchange-antispam-report-test: UriScan:(213716511872227)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991055);SRVR:DM5PR01MB2444;BCL:0;PCL:0;RULEID:;SRVR:DM5PR01MB2444;
x-forefront-prvs: 08213D42D3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(136003)(376002)(366004)(39850400004)(199004)(189003)(51914003)(36756003)(33656002)(2900100001)(71190400001)(4326008)(53936002)(97736004)(102836004)(71200400001)(106356001)(6512007)(105586002)(68736007)(6916009)(229853002)(82746002)(5660300001)(6506007)(76176011)(26005)(83716004)(6436002)(53546011)(66066001)(99286004)(6486002)(186003)(5250100002)(7736002)(8676002)(3846002)(476003)(2616005)(81166006)(11346002)(25786009)(8936002)(446003)(14444005)(14454004)(81156014)(256004)(2906002)(86362001)(6116002)(6246003)(316002)(486006)(7416002)(478600001)(54906003)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR01MB2444;H:DM5PR01MB2348.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: qtqsxJfL6Hore6aMZAD6VgWa/U5TesKP8ppoYexU+HUExhIdh3nQNcD03D5AwpPPZfvkNR5o0ZBPUnadwzF0rahWAiXw0Xaig6IU6Ayi088mHVRf90qKRaLrRt3pM4BfhDB1lWYei/YD+en05/P7v2r8QPz4M33Bg8Yzj+y7Ji7G2i7C6qDII+NfB857SzJeixHXhbqAsCLUIFEjxLu80M3sLrJwsPfwZFCeVco7ZQ1Z7bG87Du3Nx+/TVvC4CqUGY2rNFTZs9jpXM1/xpZ1Jvd5BJZLZt0MKnwMDMadnKH7zrpHLNG9IMDutZ3tgdbMGBXUSUjxArWbKRuk+/GHUyDncRyRQ/5WVvoE41wOozU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <71127BA7DA5E4A4DB35B1DBA2833390D@prod.exchangelabs.com>
MIME-Version: 1.0
X-OriginatorOrg: catalogicsoftware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4927904-aeac-4374-d082-08d62e64d93b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2018 03:59:59.4055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ea3d63e8-dd40-410b-9496-d2ee49ccddc3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR01MB2444
X-MC-Unique: -N_QxkuvMoyAXYr-eP64GA-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTmljLCANCg0KR29vZCB0byBzZWUgeW91IGJhY2shDQoNCj4gT24gT2N0IDksIDIwMTgsIGF0
IDEwOjIzIFBNLCBOaWNob2xhcyBBLiBCZWxsaW5nZXIgPG5hYkBsaW51eC1pc2NzaS5vcmc+IHdy
b3RlOg0KPiANCj4gRnJvbTogTmljaG9sYXMgQmVsbGluZ2VyIDxuYWJAbGludXgtaXNjc2kub3Jn
Pg0KPiANCj4gU2hvcnQgb2YgcmV2ZXJ0aW5nIGNvbW1pdCAwMGQ5MDlhMTA3IGZvciB2NC4xOSwg
dGFyZ2V0LWNvcmUgbmVlZHMgYQ0KPiB3YWl0X2V2ZW50X3QgbWFyY28gY2FuIGJlIGV4ZWN1dGVk
IHVzaW5nIFRBU0tfVU5JTlRFUlJVUFRJQkxFIHRvDQo+IGZ1bmN0aW9uIGNvcnJlY3RseSB3aXRo
IGV4aXN0aW5nIGZhYnJpYyBkcml2ZXJzIHRoYXQgZXhwZWN0IHRvIHJ1bg0KPiB3aXRoIHNpZ25h
bHMgcGVuZGluZyBkdXJpbmcgc2Vzc2lvbiBzaHV0ZG93biBhbmQgYWN0aXZlIHNlX2NtZCBJL08N
Cj4gcXVpZXNjZS4NCj4gDQo+IFRoZSBtb3N0IG5vdGFibGUgaXMgaXNjc2ktdGFyZ2V0L2lzZXIt
dGFyZ2V0LCB3aGlsZSBpYm12c2NzaV90Z3QgaW52b2tlcw0KPiBzZXNzaW9uIHNodXRkb3duIGxv
Z2ljIGZyb20gdXNlcnNwYWNlIHZpYSBjb25maWdmcyBhdHRyaWJ1dGUgdGhhdCBjb3VsZA0KPiBh
bHNvIHBvdGVudGlhbGx5IGhhdmUgc2lnbmFscyBwZW5kaW5nLg0KPiANCj4gU28gZ28gYWhlYWQg
YW5kIGludHJvZHVjZSB3YWl0X2V2ZW50X2xvY2tfaXJxX3RpbWVvdXQoKSB0byBhY2hpZXZlIHRo
aXMsDQo+IGFuZCB1cGRhdGUgKyByZW5hbWUgX193YWl0X2V2ZW50X2xvY2tfaXJxX3RpbWVvdXQo
KSB0byBtYWtlIGl0IGFjY2VwdA0KPiAnc3RhdGUnIGFzIGEgcGFyYW1ldGVyLg0KPiANCj4gRml4
ZXM6IDAwZDkwOWExMDcgKCJzY3NpOiB0YXJnZXQ6IE1ha2UgdGhlIHNlc3Npb24gc2h1dGRvd24g
Y29kZSBhbHNvIHdhaXQgZm9yIGNvbW1hbmRzIHRoYXQgYXJlIGJlaW5nIGFib3J0ZWQiKQ0KPiBD
YzogQmFydCBWYW4gQXNzY2hlIDxidmFuYXNzY2hlQGFjbS5vcmc+DQo+IENjOiBNaWtlIENocmlz
dGllIDxtY2hyaXN0aUByZWRoYXQuY29tPg0KPiBDYzogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1
c2UuY29tPg0KPiBDYzogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IENjOiBTYWdp
IEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPg0KPiBDYzogQnJ5YW50IEcuIEx5IDxicnlhbnRs
eUBsaW51eC52bmV0LmlibS5jb20+DQo+IENjOiBQZXRlciBaaWpsc3RyYSAoSW50ZWwpIDxwZXRl
cnpAaW5mcmFkZWFkLm9yZz4NCj4gVGVzdGVkLWJ5OiBOaWNob2xhcyBCZWxsaW5nZXIgPG5hYkBs
aW51eC1pc2NzaS5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IE5pY2hvbGFzIEJlbGxpbmdlciA8bmFi
QGxpbnV4LWlzY3NpLm9yZz4NCj4gLS0tDQo+IGluY2x1ZGUvbGludXgvd2FpdC5oIHwgMjAgKysr
KysrKysrKysrKysrLS0tLS0NCj4gMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDUg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC93YWl0LmggYi9p
bmNsdWRlL2xpbnV4L3dhaXQuaA0KPiBpbmRleCBkOWYxMzFlLi5lZDdjMTIyIDEwMDY0NA0KPiAt
LS0gYS9pbmNsdWRlL2xpbnV4L3dhaXQuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L3dhaXQuaA0K
PiBAQCAtMTA1MiwxMCArMTA1Miw5IEBAIHZvaWQgX193YWtlX3VwX2xvY2tlZF9rZXlfYm9va21h
cmsoc3RydWN0IHdhaXRfcXVldWVfaGVhZCAqd3FfaGVhZCwNCj4gCV9fcmV0OwkJCQkJCQkJCVwN
Cj4gfSkNCj4gDQo+ICANCg0KSSBkbyBub3QgdGVjaG5pY2FsbHkgd29yayBmb3IgSUJNIGFueW1v
cmUgYXMgb2YgMyB3ZWVrcyBhZ28sIGJ1dCBteSBuZXcgY29tcGFueSBpcyBhIHBhcnRuZXLigKYg
QW55d2F5cywNCklCTSBkb2VzIGludm9rZSBzaHV0ZG93biBsb2dpYyBmcm9tIHVzZXJzcGFjZS4g
VGhhbmtzIGZvciB0aGUgcGF0Y2ghDQoNClJldmlld2VkLWJ5OiBCcnlhbnQgRy4gTHkgPGJseUBj
YXRhbG9naWNzb2Z0d2FyZS5jb20+DQoNCi1CcnlhbnQgTHkNCg0KDQoNCg==

