Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCBFC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 05:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E2D20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 05:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E2D20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbeGYGMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 02:12:45 -0400
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:53940 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbeGYGMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 02:12:45 -0400
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g2t1383g.austin.hpe.com (Postfix) with ESMTPS id 2CFB0437
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 05:02:50 +0000 (UTC)
Received: from G2W6309.americas.hpqcorp.net (g2w6309.austin.hp.com [16.197.64.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3425.houston.hpe.com (Postfix) with ESMTPS id 23C40B4;
        Wed, 25 Jul 2018 05:02:49 +0000 (UTC)
Received: from G1W8108.americas.hpqcorp.net (2002:10c1:483c::10c1:483c) by
 G2W6309.americas.hpqcorp.net (2002:10c5:4033::10c5:4033) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Wed, 25 Jul 2018 05:02:48 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (15.241.52.13) by
 G1W8108.americas.hpqcorp.net (16.193.72.60) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Wed, 25 Jul 2018 05:02:49 +0000
Received: from DF4PR8401MB1180.NAMPRD84.PROD.OUTLOOK.COM (10.169.92.146) by
 DF4PR8401MB0841.NAMPRD84.PROD.OUTLOOK.COM (10.169.86.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.16; Wed, 25 Jul 2018 05:02:46 +0000
Received: from DF4PR8401MB1180.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8864:396b:153a:4fd5]) by DF4PR8401MB1180.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8864:396b:153a:4fd5%6]) with mapi id 15.20.0973.022; Wed, 25 Jul 2018
 05:02:46 +0000
From:   "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
To:     Cannon Matthews <cannonmatthews@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andres Lagar-Cavilla <andreslc@google.com>,
        Salman Qazi <sqazi@google.com>, Paul Turner <pjt@google.com>,
        David Matlack <dmatlack@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Alain Trinh <nullptr@google.com>
Subject: RE: [PATCH v2] RFC: clear 1G pages with streaming stores on x86
Thread-Topic: [PATCH v2] RFC: clear 1G pages with streaming stores on x86
Thread-Index: AQHUI8CAknpRY+zySUyxhmKlqnVjMaSfSV6g
Date:   Wed, 25 Jul 2018 05:02:46 +0000
Message-ID: <DF4PR8401MB11806B9D2A7FE04B1F5ECBF8AB540@DF4PR8401MB1180.NAMPRD84.PROD.OUTLOOK.COM>
References: <20180724210923.GA20168@bombadil.infradead.org>
 <20180725023728.44630-1-cannonmatthews@google.com>
In-Reply-To: <20180725023728.44630-1-cannonmatthews@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=elliott@hpe.com; 
x-originating-ip: [2601:2c3:877f:e23c:89a8:bb21:4484:d3c8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DF4PR8401MB0841;6:lFFFVJKee5LfOv5fULkvIdz6uSyfaB3lFBHhl7y5QguaAQfRYF86Qh+fYOV2VuuVYpRQtN2EvsUKrKRzhltksVJOMn7QeIMLjZAJwLSRK1B21jauRABQ4gb1FqgFfXUcoMmVNODvY6kSx68efuqGXhMkpon7+IH/diPT5+63uRIcO8WEw+7GHASM/LzKSXDLGUuY1f9Xod/floUO9+KJPWdAXr6SJINfc877Ea1cVySzZAxVRF+/b/jtBjR/qAcYPeho9MrBG6S+86X0nh7c1cUidE8oMK4Ig2CGEHWMRGSm9dhP7Sbk8EnH4FejECYuIFDyqSPw35VJkphyK1/TDEbcRiO3A2Bgcxu6620AiVvTlcZ2gG6wOQnON7bintfvXiWGr2GQxtMZVESzJvao1aKOnjDG5kw/brwqQco/sopSPoCL27WTILUlsv2+wwE4Ojep2a3LJ01WHtSshpY/qw==;5:fq58puoh5wpLuOnKDunFRLbQbcDciln8dyPkT3s1/Ds2GuRsZjh1EXWJlXrGYG8WHUIHb2NqDvSs7V2WInYUyl/FRi+mCaA5Ze2M2nP/IF6YGY0HfjIx7g8pHSfMFPzJD7b8dJf8+RU6+1u6buR0Eh/rDGfYzEZJ/43qV2fWo2g=;7:FmhIEAp52dQxX4c78CS55EGKTlDOZeReDNz8KcgOPoqKpXgqd4CVbpQT5lydjC/Z4af1h67wm0iLJ0YDBNgtL4EzpajpjwlCG0arEuwDvriRYGZ4LD0Vp6z6XyWYyHEc3BBnzYTNR+zL3YOYLIj6CP2pMHt6imeay8UzamoTwDpjVnGjzzWwdO96kJHYVZVuCDmTtOC7T15lMknz5jh/MffxO3y6Gpqe50tvltAiciJniQSIZFBqOKrTJBvhnfLE
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9b66108d-acc0-4b6f-9ce5-08d5f1ebdcdf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DF4PR8401MB0841;
x-ms-traffictypediagnostic: DF4PR8401MB0841:
x-microsoft-antispam-prvs: <DF4PR8401MB0841E688CF189BCFD7A367FEAB540@DF4PR8401MB0841.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DF4PR8401MB0841;BCL:0;PCL:0;RULEID:;SRVR:DF4PR8401MB0841;
x-forefront-prvs: 0744CFB5E8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39860400002)(376002)(346002)(199004)(189003)(13464003)(6436002)(6506007)(68736007)(97736004)(102836004)(53546011)(2900100001)(186003)(54906003)(6306002)(55016002)(9686003)(478600001)(256004)(76176011)(25786009)(4326008)(14454004)(74316002)(966005)(7416002)(46003)(5660300001)(305945005)(99286004)(7696005)(6116002)(7736002)(229853002)(5250100002)(8936002)(316002)(6246003)(105586002)(86362001)(33656002)(8676002)(81166006)(81156014)(106356001)(2906002)(486006)(446003)(110136005)(11346002)(476003)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:DF4PR8401MB0841;H:DF4PR8401MB1180.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JK0U8D2xv0ZH8iUQEX/4Ml/bV1UT6Dt60cv3AoLfTBvdHjKHbUm3z2BDiiiW5DnVM54aWEcq4HO16wE/csyXmtcFSzSXuTCCBv+fQpBOCDsAaTA9VWI2FlUHE8D8LquuBpn335BrwnND6cgIUhSBsxXiv5JvjoK2x3uek9ZNFRPEP7t5u+qknZVWfXT/fHp9C6/O/E+t3wcg7HycPq/CccIKQWe6MJK21fdo+l6RoGyBY7U9XP85StKrR+bYFw6MzgmY2u+1EmYPkIWUkO8EWWAPdJY9HEiCbd8re9rrPJ/HZqYUJhEutqYAwcMQbBfkE5Y4CKAwrpTa+f2LhafiywaXTtNjuSFbYpJoT3sw6E4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b66108d-acc0-4b6f-9ce5-08d5f1ebdcdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2018 05:02:46.6732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DF4PR8401MB0841
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgta2VybmVsLW93
bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgta2VybmVsLQ0KPiBvd25lckB2Z2VyLmtlcm5lbC5v
cmc+IE9uIEJlaGFsZiBPZiBDYW5ub24gTWF0dGhld3MNCj4gU2VudDogVHVlc2RheSwgSnVseSAy
NCwgMjAxOCA5OjM3IFBNDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIFJGQzogY2xlYXIgMUcg
cGFnZXMgd2l0aCBzdHJlYW1pbmcgc3RvcmVzIG9uDQo+IHg4Ng0KPiANCj4gUmVpbXBsZW1lbnQg
Y2xlYXJfZ2lnYW50aWNfcGFnZSgpIHRvIGNsZWFyIGdpZ2FieXRlcyBwYWdlcyB1c2luZyB0aGUN
Cj4gbm9uLXRlbXBvcmFsIHN0cmVhbWluZyBzdG9yZSBpbnN0cnVjdGlvbnMgdGhhdCBieXBhc3Mg
dGhlIGNhY2hlDQo+IChtb3ZudGkpLCBzaW5jZSBhbiBlbnRpcmUgMUdpQiByZWdpb24gd2lsbCBu
b3QgZml0IGluIHRoZSBjYWNoZQ0KPiBhbnl3YXkuDQo+DQo+IERvaW5nIGFuIG1sb2NrKCkgb24g
YSA1MTJHaUIgMUctaHVnZXRsYiByZWdpb24gcHJldmlvdXNseSB3b3VsZCB0YWtlDQo+IG9uIGF2
ZXJhZ2UgMTM0IHNlY29uZHMsIGFib3V0IDI2MG1zL0dpQiB3aGljaCBpcyBxdWl0ZSBzbG93LiBV
c2luZw0KPiBgbW92bnRpYCBhbmQgb3B0aW1pemluZyB0aGUgY29udHJvbCBmbG93IG92ZXIgdGhl
IGNvbnN0aXR1ZW50IHNtYWxsDQo+IHBhZ2VzLCB0aGlzIGNhbiBiZSBpbXByb3ZlZCByb3VnaGx5
IGJ5IGEgZmFjdG9yIG9mIDMtNHgsIHdpdGggdGhlDQo+IDUxMkdpQiBtbG9jaygpIHRha2luZyBv
bmx5IDM0IHNlY29uZHMgb24gYXZlcmFnZSwgb3IgNjdtcy9HaUIuDQoNCi4uLg0KPiAtIEFyZSB0
aGVyZSBhbnkgb2J2aW91cyBwaXRmYWxscyBvciBjYXZlYXRzIHRoYXQgaGF2ZSBub3QgYmVlbg0K
PiBjb25zaWRlcmVkPyANCg0KTm90ZSB0aGF0IEtpcmlsbCBhdHRlbXB0ZWQgc29tZXRoaW5nIGxp
a2UgdGhpcyBpbiAyMDEyIC0gc2VlDQpodHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9saW51
eC1tbS9tc2c0MDU3NS5odG1sDQoNCi4uLg0KPiArKysgYi9hcmNoL3g4Ni9saWIvY2xlYXJfZ2ln
YW50aWNfcGFnZS5jDQo+IEBAIC0wLDAgKzEsMjkgQEANCj4gKyNpbmNsdWRlIDxhc20vcGFnZS5o
Pg0KPiArDQo+ICsjaW5jbHVkZSA8bGludXgva2VybmVsLmg+DQo+ICsjaW5jbHVkZSA8bGludXgv
bW0uaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9zY2hlZC5oPg0KPiArDQo+ICsjaWYgZGVmaW5lZChD
T05GSUdfVFJBTlNQQVJFTlRfSFVHRVBBR0UpIHx8DQo+IGRlZmluZWQoQ09ORklHX0hVR0VUTEJG
UykNCj4gKyNkZWZpbmUgUEFHRVNfQkVUV0VFTl9SRVNDSEVEIDY0DQo+ICt2b2lkIGNsZWFyX2dp
Z2FudGljX3BhZ2Uoc3RydWN0IHBhZ2UgKnBhZ2UsDQo+ICsJCQkJdW5zaWduZWQgbG9uZyBhZGRy
LA0KDQpUaGUgcHJldmlvdXMgYXR0ZW1wdCB1c2VkIGNhY2hlYWJsZSBzdG9yZXMgaW4gdGhlIHBh
Z2UgY29udGFpbmluZw0KYWRkciB0byBwcmV2ZW50IGFuIGluZXZpdGFibGUgY2FjaGUgbWlzcyBh
ZnRlciB0aGUgY2xlYXJpbmcgY29tcGxldGVzLg0KVGhpcyBmdW5jdGlvbiBpcyBub3QgdXNpbmcg
YWRkciBhdCBhbGwuDQoNCj4gKwkJCQl1bnNpZ25lZCBpbnQgcGFnZXNfcGVyX2h1Z2VfcGFnZSkN
Cj4gK3sNCj4gKwlpbnQgaTsNCj4gKwl2b2lkICpkZXN0ID0gcGFnZV90b192aXJ0KHBhZ2UpOw0K
PiArCWludCByZXNjaGVkX2NvdW50ID0gMDsNCj4gKw0KPiArCUJVR19PTihwYWdlc19wZXJfaHVn
ZV9wYWdlICUgUEFHRVNfQkVUV0VFTl9SRVNDSEVEICE9IDApOw0KPiArCUJVR19PTighZGVzdCk7
DQoNCkFyZSB0aG9zZSByZWFsbHkgcG9zc2libGUgY29uZGl0aW9ucz8gIElzIHRoZXJlIGEgc2Fm
ZXIgZmFsbGJhY2sNCnRoYW4gY3Jhc2hpbmcgdGhlIHdob2xlIGtlcm5lbD8NCg0KPiArDQo+ICsJ
Zm9yIChpID0gMDsgaSA8IHBhZ2VzX3Blcl9odWdlX3BhZ2U7IGkgKz0NCj4gUEFHRVNfQkVUV0VF
Tl9SRVNDSEVEKSB7DQo+ICsJCV9fY2xlYXJfcGFnZV9udChkZXN0ICsgKGkgKiBQQUdFX1NJWkUp
LA0KPiArCQkJCVBBR0VTX0JFVFdFRU5fUkVTQ0hFRCAqIFBBR0VfU0laRSk7DQo+ICsJCXJlc2No
ZWRfY291bnQgKz0gY29uZF9yZXNjaGVkKCk7DQo+ICsJfQ0KPiArCS8qIF9fY2xlYXJfcGFnZV9u
dCByZXF1cmlyZXMgYW5kIGBzZmVuY2VgIGJhcnJpZXIuICovDQoNCnJlcXVpcmVzIGFuDQoNCi4u
Lg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvbGliL2NsZWFyX3BhZ2VfNjQuUw0KLi4uDQo+ICsv
Kg0KPiArICogWmVybyBtZW1vcnkgdXNpbmcgbm9uIHRlbXBvcmFsIHN0b3JlcywgYnlwYXNzaW5n
IHRoZSBjYWNoZS4NCj4gKyAqIFJlcXVpcmVzIGFuIGBzZmVuY2VgICh3bWIoKSkgYWZ0ZXJ3YXJk
cy4NCj4gKyAqICVyZGkgLSBkZXN0aW5hdGlvbi4NCj4gKyAqICVyc2kgLSBwYWdlIHNpemUuIE11
c3QgYmUgNjQgYml0IGFsaWduZWQuDQo+ICsqLw0KPiArRU5UUlkoX19jbGVhcl9wYWdlX250KQ0K
PiArCWxlYXEJKCVyZGksJXJzaSksICVyZHgNCj4gKwl4b3JsCSVlYXgsICVlYXgNCj4gKwkucDJh
bGlnbiA0LCwxMA0KPiArCS5wMmFsaWduIDMNCj4gKy5MMjoNCj4gKwltb3ZudGkJJXJheCwgKCVy
ZGkpDQo+ICsJYWRkcQkkOCwgJXJkaQ0KDQpBbHNvIGNvbnNpZGVyIHVzaW5nIHRoZSBBVlggdm1v
dm50ZHEgaW5zdHJ1Y3Rpb24gKGlmIGF2YWlsYWJsZSksIHRoZQ0KbW9zdCByZWNlbnQgb2Ygd2hp
Y2ggZG9lcyA2NC1ieXRlIChjYWNoZSBsaW5lKSBzaXplZCB0cmFuc2ZlcnMgdG8NCnptbSByZWdp
c3RlcnMuIFRoZXJlJ3MgYSBoZWZ0eSBjb250ZXh0IHN3aXRjaGluZyBvdmVyaGVhZCAoZS5nLiwN
CjMwNCBjbG9ja3MpLCBidXQgaXQgbWlnaHQgYmUgd29ydGh3aGlsZSBmb3IgMSBHaUIgKHdoaWNo
DQppcyAxNiw3NzcsMjE2IGNhY2hlIGxpbmVzKS4NCg0KZ2xpYmMgbWVtY3B5KCkgbWFrZXMgdGhh
dCBjaG9pY2UgZm9yIHRyYW5zZmVycyA+IDc1JSBvZiB0aGUgTDMgY2FjaGUNCnNpemUgZGl2aWRl
ZCBieSB0aGUgbnVtYmVyIG9mIGNvcmVzLiAgKGxhc3QgSSB0cmllZCwgaXQgd2FzIHN0aWxsDQpz
ZWxlY3RpbmcgInJlcCBzdG9zYiIgZm9yIGxhcmdlIG1lbXNldCgpcywgYWx0aG91Z2ggaXQgaGFz
IGFuDQpBVlgtNTEyIGZ1bmN0aW9uIGF2YWlsYWJsZSkNCg0KRXZlbiB3aXRoIHRoYXQsIG9uZSBD
UFUgY29yZSB3b24ndCBzYXR1cmF0ZSB0aGUgbWVtb3J5IGJ1czsgbXVsdGlwbGUNCkNQVSBjb3Jl
cyAocHJlZmVyYWJseSBvbiB0aGUgc2FtZSBOVU1BIG5vZGUgYXMgdGhlIG1lbW9yeSkgbmVlZCB0
bw0Kc2hhcmUgdGhlIHdvcmsuDQoNCi0tLQ0KUm9iZXJ0IEVsbGlvdHQsIEhQRSBQZXJzaXN0ZW50
IE1lbW9yeQ0KDQoNCg0K
