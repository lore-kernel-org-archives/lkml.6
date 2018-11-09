Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546C8C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B8AA20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="CUZX8rcI";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="UOamMomE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B8AA20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbeKJE5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 23:57:15 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47358 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727961AbeKJE5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 23:57:14 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA9JEbt4005873;
        Fri, 9 Nov 2018 11:14:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=RDO77sB4Ewo2nd375t6v0jt9cfVFC6aoDetz33BrQ3Q=;
 b=CUZX8rcIRkzgkacFrMWjpyhbIaHgplVzw/l8t4UR9ourn9bKX0qOg/qzWg94QcZZdOZU
 mZK/krhPznIH+DvvLaIYEqA04k8Ki5TWIIse7CNzjfkfrl+2nELoHmM7fdlRy5hrYKrN
 HqhcoVtHxq3+0sn9eMka3eSjeEjgG0R0UAs= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2nnd5v0mep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 09 Nov 2018 11:14:42 -0800
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 9 Nov 2018 11:14:41 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Fri, 9 Nov 2018 11:14:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDO77sB4Ewo2nd375t6v0jt9cfVFC6aoDetz33BrQ3Q=;
 b=UOamMomEEEUIa4IMRnIEo7X+ZmkiPqn6V54bhHLkvANGy8YATY5jlEyo7shUdvQMHrKAHQF0QPaQjAz34/O30FHL1x7RChX7L8+BLdLE3wZ6hfK0KODd8E2fmHl3vngPV89P7psPSmVzhJ6fYDA06GtXvpdeEbvhc+Dp/dv+cNA=
Received: from BYAPR15MB2501.namprd15.prod.outlook.com (52.135.196.11) by
 BYAPR15MB2471.namprd15.prod.outlook.com (52.135.200.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Fri, 9 Nov 2018 19:14:39 +0000
Received: from BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::ed40:7ac9:3043:5bc1]) by BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::ed40:7ac9:3043:5bc1%2]) with mapi id 15.20.1294.034; Fri, 9 Nov 2018
 19:14:39 +0000
From:   Alexei Starovoitov <ast@fb.com>
To:     Song Liu <songliubraving@fb.com>, David Ahern <dsahern@gmail.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Netdev <netdev@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "acme@kernel.org" <acme@kernel.org>
Subject: Re: [RFC perf,bpf 1/5] perf, bpf: Introduce PERF_RECORD_BPF_EVENT
Thread-Topic: [RFC perf,bpf 1/5] perf, bpf: Introduce PERF_RECORD_BPF_EVENT
Thread-Index: AQHUdhLSV6iK7sNzcUuk1dX3c/N2KqVD/w6AgACjMwCAAVkrAIAAM3wAgAAF/wCAAAZ2gIABdg6AgAAcUICAAAcGgA==
Date:   Fri, 9 Nov 2018 19:14:39 +0000
Message-ID: <6907d1cd-b132-1aa4-c69e-5277d2d26262@fb.com>
References: <20181106205246.567448-1-songliubraving@fb.com>
 <20181106205246.567448-2-songliubraving@fb.com>
 <20181107084057.GG9781@hirez.programming.kicks-ass.net>
 <31067290-4B66-4AA1-8027-607397BC0264@fb.com>
 <20181108150028.GU9761@hirez.programming.kicks-ass.net>
 <C858C862-E523-4CE8-AB39-CC9B27BE2538@fb.com>
 <d5043aae-69b0-fd49-e82a-5a13834a3f32@gmail.com>
 <050ABAC6-6C3B-4B6B-BB68-727127E00B51@fb.com>
 <37d2c7a8-fe99-94bd-9b8f-24e9ca9fa39c@gmail.com>
 <74246BC0-EA66-407E-93E6-0D6E8645F486@fb.com>
In-Reply-To: <74246BC0-EA66-407E-93E6-0D6E8645F486@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0130.namprd04.prod.outlook.com
 (2603:10b6:104:7::32) To BYAPR15MB2501.namprd15.prod.outlook.com
 (2603:10b6:a02:88::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::6:5567]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2471;20:DHtBSigQx0QU8XxkU2cxxi1DdomcQFgQIYgEo61Wja8wVNj7cMSf46iHivj4s8v2YXyRRi/UoLu26cR1I9nZaIVXT6GX6i14zlDS8qZaQIczieT3v913zUI0w/Yi/KWyI0luWwWT6wPgmazZtyQ2U/+HTTKNKKfupmJtNEj19cg=
x-ms-office365-filtering-correlation-id: 7b2fe4ab-7355-4bf7-a431-08d64677982f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2471;
x-ms-traffictypediagnostic: BYAPR15MB2471:
x-microsoft-antispam-prvs: <BYAPR15MB2471104087F0D1040F1A3303D7C60@BYAPR15MB2471.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(93006095)(93001095)(10201501046)(3002001)(3231382)(11241501184)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR15MB2471;BCL:0;PCL:0;RULEID:;SRVR:BYAPR15MB2471;
x-forefront-prvs: 08512C5403
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(346002)(136003)(376002)(189003)(199004)(6246003)(106356001)(14454004)(105586002)(478600001)(53546011)(52116002)(99286004)(76176011)(102836004)(386003)(31686004)(25786009)(6506007)(229853002)(81156014)(6486002)(68736007)(8936002)(53936002)(5660300001)(6512007)(305945005)(8676002)(81166006)(97736004)(7736002)(6436002)(2900100001)(31696002)(86362001)(486006)(476003)(2616005)(256004)(46003)(186003)(11346002)(316002)(446003)(4326008)(71200400001)(6116002)(71190400001)(2906002)(39060400002)(93886005)(54906003)(110136005)(36756003)(142933001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2471;H:BYAPR15MB2501.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: o1eVPKvjx6uyPFqq4DtF0g7UQMTuXChwspQRalvs07pVPeKwoAHcVme2C8ouj4nmocGw5dgtyLDNcMnRsSZRZCNOwY5Xhs82ctXiBByVfdLDUcJsAR3nZs4LaWxFYlt+PnHsilxUMXDHqA+xQPmasmWb5H0f2ZLdvEbNQbfEzh+jzXMTlFeotHf7bX/ksvR78F+TnfmXt6r9rKMmg6+VUVmCGZTDQE2d+E1yStliSYUJiqELn6vy6kIAgLGrBmloUGdM1oarnhRMAOxZQoOhl6yxortoK/6KyBNFv/+NjTxpyj2pFCxt5y0qNEEoZtHA4F97JZEK/dHpG87oanqji0G/wMw/4//clc2/dBTxVOc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D170C676099DB46A0E742EBA25DC648@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2fe4ab-7355-4bf7-a431-08d64677982f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2018 19:14:39.2178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2471
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-09_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvOS8xOCAxMDo0OSBBTSwgU29uZyBMaXUgd3JvdGU6DQo+IA0KPiANCj4+IE9uIE5vdiA5
LCAyMDE4LCBhdCA5OjA4IEFNLCBEYXZpZCBBaGVybiA8ZHNhaGVybkBnbWFpbC5jb20+IHdyb3Rl
Og0KPj4NCj4+IE9uIDExLzgvMTggMTE6NDkgQU0sIFNvbmcgTGl1IHdyb3RlOg0KPj4+IENvdWxk
IHlvdSBwbGVhc2UgcG9pbnQgbWUgdG8gbW9yZSBpbmZvcm1hdGlvbiBhYm91dCB0aGUgdXNlIGNh
c2VzIHlvdSB3b3JyeQ0KPj4+IGFib3V0PyBJIGFtIG1vcmUgdGhhbiBoYXBweSB0byBvcHRpbWl6
ZSB0aGUgbG9naWMgZm9yIHRob3NlIHVzZSBjYXNlcy4NCj4+DQo+PiBicGYgbG9hZCBhbmQgdW5s
b2FkIGFzIGp1c3QgYW5vdGhlciB0cmFjZXBvaW50IHRvIHRocm93IGludG8gYSBzZXQgb2YNCj4+
IGV2ZW50cyB0aGF0IGFyZSBtb25pdG9yZWQuIEFzIG1lbnRpb25lZCBiZWZvcmUgYXVkaXRpbmcg
dGhlIGxvYWRzIGFuZA0KPj4gdW5sb2FkcyBpcyBvbmUgZXhhbXBsZS4NCj4gDQo+IEZvciB0aGUg
dHJhY2Vwb2ludCBhcHByb2FjaCwgd2UgbmVlZCBzaW1pbGFyIHN5bmNocm9ub3VzIGxvZ2ljIGlu
IHBlcmYgdG8NCj4gcHJvY2VzcyBCUEYgbG9hZC91bmxvYWQgZXZlbnRzLiBJZiB3ZSBhZ3JlZSB0
aGlzIGlzIHRoZSByaWdodCBkaXJlY3Rpb24sDQo+IEkgd2lsbCBtb2RpZnkgdGhlIHNldCB3aXRo
IHRyYWNlcG9pbnRzLg0KDQp3ZSBoYWQgdHJhY2Vwb2ludHMgaW4gYnBmIGNvcmUuIFdlIHJlbW92
ZWQgaXQuDQpJIGRvbid0IHRoaW5rIHdlJ2xsIGJlIGdvaW5nIGJhY2suDQo=
