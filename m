Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE66C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 01:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ACF62054F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 01:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="DAktGse7";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="TaSLg2pP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ACF62054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbeJJIXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 04:23:38 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32976 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725775AbeJJIXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 04:23:38 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9A0wwJl017182;
        Tue, 9 Oct 2018 18:03:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=xrqbYg17qgn/Qvb92xxBDKf45m4/YSXtOdwq6FuPSfA=;
 b=DAktGse75csX3ZVzVu90MlrK6kpBM9O6XwHCFx0rFsASdHPFzyS6B5Pu+Sd8f2V2rUQy
 Dr07km+0l1z5WLoGu7r8Qzq6kgec4TrYyuU4Bf3UckqipgIH66WiW45t0rbOYlgekG4X
 T+l9PX2a/I1bgf5ARIyRdfcJeyAqfEUO+h0= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2n16ds859v-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 09 Oct 2018 18:03:54 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.21) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 9 Oct 2018 21:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrqbYg17qgn/Qvb92xxBDKf45m4/YSXtOdwq6FuPSfA=;
 b=TaSLg2pPLDrzKZVGegcwl36ggat0O2nPop+UWM8zEgThMrl24GOZW7+rNS0iLp7CuJdjBZ1pljCUUOGYOL+eEq3OWN0WrQHVizJ4cXcnDO2wgGkS5u92aQcxNxLrDbgz7Eql+/9cYEhcU7LazMYRQDJ4rKF1IKW0kplR0l3BTYw=
Received: from BN3PR15MB0708.namprd15.prod.outlook.com (10.165.79.146) by
 BN3PR15MB0770.namprd15.prod.outlook.com (10.165.80.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.26; Wed, 10 Oct 2018 01:03:50 +0000
Received: from BN3PR15MB0708.namprd15.prod.outlook.com
 ([fe80::7584:5268:e41f:306e]) by BN3PR15MB0708.namprd15.prod.outlook.com
 ([fe80::7584:5268:e41f:306e%4]) with mapi id 15.20.1207.024; Wed, 10 Oct 2018
 01:03:50 +0000
From:   Rik van Riel <riel@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Rik van Riel <riel@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 4/4] mm: zero-seek shrinkers
Thread-Topic: [PATCH 4/4] mm: zero-seek shrinkers
Thread-Index: AQHUYAC8Yd4fgTq9V0O4Q9U31e7CcaUXqi8A
Date:   Wed, 10 Oct 2018 01:03:50 +0000
Message-ID: <e01c4f441e24bb31816a3080389dcae7b49cc1ff.camel@fb.com>
References: <20181009184732.762-1-hannes@cmpxchg.org>
         <20181009184732.762-5-hannes@cmpxchg.org>
In-Reply-To: <20181009184732.762-5-hannes@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR20CA0059.namprd20.prod.outlook.com
 (2603:10b6:404:151::21) To BN3PR15MB0708.namprd15.prod.outlook.com
 (2a01:111:e400:c491::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:180::1:7dc]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3PR15MB0770;20:TVD4h0G+0BAoamTVW6DhqhnZrQ7RZQf2OCJkqQdqYQIh1gtv95jBbwlCNEMNnyN7/1G9ZrFyTftN/+qn0PH2f6fmaAEYwMgIvoa6zd9ITfS20MfZlGnFkHvJs5SfuIsikaRTC6+SVbkcFk4ux0Cl6bWaP9sDav8l1VKz0eT2LDM=
x-ms-office365-filtering-correlation-id: 39ed94b6-bff0-49b5-5ae5-08d62e4c3ce0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN3PR15MB0770;
x-ms-traffictypediagnostic: BN3PR15MB0770:
x-microsoft-antispam-prvs: <BN3PR15MB0770E9EE10257C1FEFE460E0A3E00@BN3PR15MB0770.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(3231355)(11241501184)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051);SRVR:BN3PR15MB0770;BCL:0;PCL:0;RULEID:;SRVR:BN3PR15MB0770;
x-forefront-prvs: 08213D42D3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(136003)(396003)(366004)(199004)(189003)(105586002)(76176011)(6506007)(186003)(81166006)(81156014)(2906002)(118296001)(102836004)(99286004)(52116002)(106356001)(5250100002)(6246003)(46003)(8676002)(25786009)(316002)(386003)(8936002)(2900100001)(5660300001)(36756003)(7736002)(53936002)(2616005)(256004)(229853002)(97736004)(4326008)(486006)(6512007)(71190400001)(71200400001)(11346002)(86362001)(305945005)(446003)(6486002)(110136005)(68736007)(14454004)(6116002)(478600001)(54906003)(476003)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR15MB0770;H:BN3PR15MB0708.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vuEw9e9OnSeIDgELE9mY9YtM5ozvfYRHTJMXZDwhPAN7NrNBv2IN0xHkzdX+RXmIZrf3IPnV/QalTmI49DI2cTgo/tjRkbzeWTN2ulwdhPVk1W1rrWH/uJcntoF1CcK4IlWbxq5i5+56xbsHXQd5IPosTTB+w4UItesRjHqm7eH4nPV4r12bhbcbEvV9YitGP6yyeFo9Yh0zRIKLlN0UU1hd3Xc/EMkMGDTs6vdhszCTkefmAohDtBQZYia2qiNn4voSwJwmGG8ueCyhfpIKXEqL5jqWyB/F9NKbuV6Cln3SchbXwSmtY2RVtP4aMUhAn9kPILCIY9NPNSh8lr1+3vN5HTfBT7n7fgtl8L7sRAA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C63FB951EA41CE49847DF2A2363D056C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ed94b6-bff0-49b5-5ae5-08d62e4c3ce0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2018 01:03:50.2764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR15MB0770
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-09_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTEwLTA5IGF0IDE0OjQ3IC0wNDAwLCBKb2hhbm5lcyBXZWluZXIgd3JvdGU6
DQoNCj4gVGhlc2Ugd29ya2xvYWRzIGFsc28gZGVhbCB3aXRoIHRlbnMgb2YgdGhvdXNhbmRzIG9m
IG9wZW4gZmlsZXMgYW5kDQo+IHVzZQ0KPiAvcHJvYyBmb3IgaW50cm9zcGVjdGlvbiwgd2hpY2gg
ZW5kcyB1cCBncm93aW5nIHRoZSBwcm9jX2lub2RlX2NhY2hlDQo+IHRvDQo+IGFic3VyZGx5IGxh
cmdlIHNpemVzIC0gYWdhaW4gYXQgdGhlIGNvc3Qgb2YgdmFsdWFibGUgY2FjaGUgc3BhY2UsDQo+
IHdoaWNoIGlzbid0IGEgcmVhc29uYWJsZSB0cmFkZS1vZmYsIGdpdmVuIHRoYXQgcHJvYyBpbm9k
ZXMgY2FuIGJlDQo+IHJlLWNyZWF0ZWQgd2l0aG91dCBpbnZvbHZpbmcgdGhlIGRpc2suDQo+IA0K
PiBUaGlzIHBhdGNoIGltcGxlbWVudHMgYSAiemVyby1zZWVrIiBzZXR0aW5nIGZvciBzaHJpbmtl
cnMgdGhhdA0KPiByZXN1bHRzDQo+IGluIGEgdGFyZ2V0IHJhdGlvIG9mIDA6MSBiZXR3ZWVuIHRo
ZWlyIG9iamVjdHMgYW5kIElPLWJhY2tlZA0KPiBjYWNoZXMuIFRoaXMgYWxsb3dzIHN1Y2ggdmly
dHVhbCBjYWNoZXMgdG8gZ3JvdyB3aGVuIG1lbW9yeSBpcw0KPiBhdmFpbGFibGUgKHRoZXkgZG8g
Y2FjaGUvYXZvaWQgQ1BVIHdvcmsgYWZ0ZXIgYWxsKSwgYnV0IGVmZmVjdGl2ZWx5DQo+IGRpc2Fi
bGVzIHRoZW0gYXMgc29vbiBhcyBJTy1iYWNrZWQgb2JqZWN0cyBhcmUgdW5kZXIgcHJlc3N1cmUu
DQo+IA0KPiBJdCB0aGVuIHN3aXRjaGVzIHRoZSBzaHJpbmtlcnMgZm9yIHByb2NmcyBhbmQgc3lz
ZnMgbWV0YWRhdGEsIGFzIHdlbGwNCj4gYXMgZXhjZXNzIHBhZ2UgY2FjaGUgc2hhZG93IG5vZGVz
LCB0byB0aGUgbmV3IHplcm8tc2VlayBzZXR0aW5nLg0KDQpUaGlzIHBhdGNoIGxvb2tzIGxpa2Ug
YSBncmVhdCBzdGVwIGluIHRoZSByaWdodA0KZGlyZWN0aW9uLCB0aG91Z2ggSSBkbyBub3Qga25v
dyB3aGV0aGVyIGl0IGlzDQphZ2dyZXNzaXZlIGVub3VnaC4NCg0KR2l2ZW4gdGhhdCBpbnRlcm5h
bCBzbGFiIGZyYWdtZW50YXRpb24gd2lsbA0KcHJldmVudCB0aGUgc2xhYiBjYWNoZSBmcm9tIHJl
dHVybmluZyBhIHNsYWIgdG8NCnRoZSBWTSBpZiBqdXN0IG9uZSBvYmplY3QgaW4gdGhhdCBzbGFi
IGlzIHN0aWxsDQppbiB1c2UsIHRoZXJlIG1heSB3ZWxsIGJlIHdvcmtsb2FkcyB3aGVyZSB3ZQ0K
c2hvdWxkIGp1c3QgcHV0IGEgaGFyZCBjYXAgb24gdGhlIG51bWJlciBvZg0KZnJlZWFibGUgaXRl
bXMgdGhlc2Ugc2xhYnMsIGFuZCByZWNsYWltIHRoZW0NCnByZWVtcHRpdmVseS4NCg0KSG93ZXZl
ciwgSSBkbyBub3Qga25vdyBmb3Igc3VyZSwgYW5kIHRoaXMgcGF0Y2gNCnNlZW1zIGxpa2UgYSBi
aWcgaW1wcm92ZW1lbnQgb3ZlciB3aGF0IHdlIGhhZA0KYmVmb3JlLCBzbyAuLi4NCg0KPiBSZXBv
cnRlZC1ieTogRG9tYXMgTWl0dXphcyA8ZG1pdHV6YXNAZmIuY29tPg0KPiBTaWduZWQtb2ZmLWJ5
OiBKb2hhbm5lcyBXZWluZXIgPGhhbm5lc0BjbXB4Y2hnLm9yZz4NCg0KUmV2aWV3ZWQtYnk6IFJp
ayB2YW4gUmllbCA8cmllbEBzdXJyaWVsLmNvbT4NCg0K
