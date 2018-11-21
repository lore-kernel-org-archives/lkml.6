Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E911AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD882080F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="iPWWE25C";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="O9YZ/5om"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD882080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390310AbeKVJ0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 04:26:43 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50944 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731554AbeKVJ0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 04:26:43 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wALMiBQG001729;
        Wed, 21 Nov 2018 14:49:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=tc/CsZ2JZNPNIGjhKyT3KSs7P9ML4pncs3AFTNLHLkI=;
 b=iPWWE25CdAepbWVqvTb64kY/07Azx87ezP9f931Vx3qg6nFmnun/jiWV6havg+bXcBdU
 dIKWP9tTQv/NCQL47dzQ43+a3Wzpyi+RXJNQC0OY4cWQVkjYmDaBjqHW98ysEb2FVJqz
 1/1qFnqBWcMQmkATBoI6l2eGVnepM6ouUWs= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2nweap0dme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 21 Nov 2018 14:49:40 -0800
Received: from frc-mbx06.TheFacebook.com (2620:10d:c0a1:f82::30) by
 frc-hub01.TheFacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 21 Nov 2018 14:49:39 -0800
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-mbx06.TheFacebook.com (2620:10d:c0a1:f82::30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 21 Nov 2018 14:49:39 -0800
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Wed, 21 Nov 2018 14:49:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tc/CsZ2JZNPNIGjhKyT3KSs7P9ML4pncs3AFTNLHLkI=;
 b=O9YZ/5omHYm6NE9cYAh0OQKPrJcJVjxqS2rTwRBWu5bmRJ/XCHXgGw6HqHkqCed2Z66YEWY0S78uKzV80+v+GLUUpJa46Pucc0TjeqLR26hyyf3NI61TJE0S0wPFCTrnLt3thVZ7pP7yNFOiEo/SYkCeS087di8ElHUXqtdec8k=
Received: from BYAPR15MB2501.namprd15.prod.outlook.com (52.135.196.11) by
 BYAPR15MB2328.namprd15.prod.outlook.com (52.135.197.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.25; Wed, 21 Nov 2018 22:49:37 +0000
Received: from BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::c50c:be46:74f6:622a]) by BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::c50c:be46:74f6:622a%3]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 22:49:37 +0000
From:   Alexei Starovoitov <ast@fb.com>
To:     Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "acme@kernel.org" <acme@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH perf,bpf 5/5] perf util: generate bpf_prog_info_event for
 short living bpf programs
Thread-Topic: [PATCH perf,bpf 5/5] perf util: generate bpf_prog_info_event for
 short living bpf programs
Thread-Index: AQHUgdQ9i/pAXoYS2Eyse+BQV/qwWKVayrqAgAAGp4CAAAPoAA==
Date:   Wed, 21 Nov 2018 22:49:37 +0000
Message-ID: <36f98237-30bf-d01d-cff1-de8a9add77b8@fb.com>
References: <20181121195502.3259930-1-songliubraving@fb.com>
 <20181121195502.3259930-6-songliubraving@fb.com>
 <20181121221145.2cxph7zv27x7lbg6@ast-mbp>
 <67063BF9-6237-4CF4-A0EB-0B14C5CA8A21@fb.com>
In-Reply-To: <67063BF9-6237-4CF4-A0EB-0B14C5CA8A21@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR17CA0057.namprd17.prod.outlook.com
 (2603:10b6:300:93::19) To BYAPR15MB2501.namprd15.prod.outlook.com
 (2603:10b6:a02:88::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:6a9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2328;20:cS2hc6+uYHKVNtC4k5gQkLeA3ICORjvY33hPx25uOdVs/hbsAdUTz+SpmmTxrulpaQrqcPJXYsk/ViNYpEpxl4I3/3ZSMSB6X0o4KIQRY6KMoulryemRAVm8E0JlRpsNF+gCZ9RE+2pIjJdm4jXJmfm0iD5KH2znyYgY1JOsfjQ=
x-ms-office365-filtering-correlation-id: 798ed311-0b86-44f8-9fc0-08d650039d30
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2328;
x-ms-traffictypediagnostic: BYAPR15MB2328:
x-microsoft-antispam-prvs: <BYAPR15MB23289FEB83FDF601BCE65CD5D7DA0@BYAPR15MB2328.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(11241501184)(944501410)(52105112)(10201501046)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR15MB2328;BCL:0;PCL:0;RULEID:;SRVR:BYAPR15MB2328;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39860400002)(366004)(396003)(199004)(189003)(36756003)(99286004)(2900100001)(52116002)(186003)(110136005)(386003)(6506007)(53546011)(54906003)(6486002)(102836004)(6346003)(76176011)(97736004)(7736002)(5660300001)(6116002)(86362001)(8936002)(81166006)(81156014)(305945005)(2906002)(8676002)(71200400001)(71190400001)(316002)(93886005)(31696002)(105586002)(4326008)(6512007)(31686004)(11346002)(39060400002)(446003)(6246003)(106356001)(476003)(46003)(478600001)(25786009)(2616005)(5024004)(256004)(486006)(68736007)(229853002)(6436002)(53936002)(14454004)(142933001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2328;H:BYAPR15MB2501.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0egy97+VAwJEjj11JFORfKphsWZW8zkp4dwovm1U7YZsEW8XYSMP/1MvR1bPhqFEhWtCYnHJYgxKt8B0ast7foBdBpzD083p4Cxpp1sJm0vCJAvgtTZnvp4BUMXH5Rvi6ZW9L124c1NvQWRrKxqYI9GU1ezc+zykIrJN3YLPOtsbAo+cAzXI5sAsfkRhTtAE2pEkKwsmtNaULHmhYugPOl5mpvp+aFEVjDAIUuC5CTqwy8IsmASOCD3NGDP/k0exX1F7qvE6ZX1o1JPoOEeEM4S8P1CjWEDAoQpYJGngNVCLcUP9mSaoXO+SiXq/8lqkoke1A10+rREzpgvezSDHswOA+BfM8Grtol1P1E/yfsQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <91F82054EB726F498CCC3E692971ED78@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 798ed311-0b86-44f8-9fc0-08d650039d30
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 22:49:37.6837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2328
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-21_16:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMjEvMTggMjozNSBQTSwgU29uZyBMaXUgd3JvdGU6DQo+IA0KPiANCj4+IE9uIE5vdiAy
MSwgMjAxOCwgYXQgMjoxMSBQTSwgQWxleGVpIFN0YXJvdm9pdG92IDxhbGV4ZWkuc3Rhcm92b2l0
b3ZAZ21haWwuY29tPiB3cm90ZToNCj4+DQo+PiBPbiBXZWQsIE5vdiAyMSwgMjAxOCBhdCAxMTo1
NTowMkFNIC0wODAwLCBTb25nIExpdSB3cm90ZToNCj4+PiBUaGlzIHBhdGNoIGVuYWJsZXMgcGVy
Zi1yZWNvcmQgdG8gbGlzdGVuIHRvIGJwZl9ldmVudCBhbmQgZ2VuZXJhdGUNCj4+PiBicGZfcHJv
Z19pbmZvX2V2ZW50IGZvciBicGYgcHJvZ3JhbXMgbG9hZGVkIGFuZCB1bmxvYWRlZCBkdXJpbmcN
Cj4+PiBwZXJmLXJlY29yZCBydW4uDQo+Pj4NCj4+PiBUbyBtaW5pbWl6ZSBsYXRlbmN5IGJldHdl
ZW4gYnBmX2V2ZW50IGFuZCBmb2xsb3dpbmcgYnBmIGNhbGxzLCBzZXBhcmF0ZQ0KPj4+IG1tYXAg
d2l0aCB3YXRlcm1hcmsgb2YgMSBpcyBjcmVhdGVkIHRvIHByb2Nlc3MgdGhlc2UgdmlwIGV2ZW50
cy4gVGhlbg0KPj4+IGEgc2VwYXJhdGUgZHVtbXkgZXZlbnQgaXMgYXR0YWNoZWQgdG8gdGhlIHNw
ZWNpYWwgbW1hcC4gQSBzZXBhcmF0ZSB0aHJlYWQNCj4+PiBpcyB1c2VkIHRvIG9ubHkgcG9sbCBi
cGYgZXZlbnRzLg0KPj4+DQo+Pj4gQnkgZGVmYXVsdCwgcGVyZi1yZWNvcmQgd2lsbCBsaXN0ZW4g
dG8gYnBmX2V2ZW50LiBPcHRpb24gbm8tYnBmLWV2ZW50IGlzDQo+Pj4gYWRkZWQgaW4gY2FzZSB0
aGUgdXNlciB3b3VsZCBvcHQgb3V0Lg0KPj4NCj4+IEkgdGhpbmsgb25seSBkZWZhdWx0IHBlcmYt
cmVjb3JkIGZvciBzYW1wbGluZyBzaG91bGQgaW5jbHVkZSBpdC4NCj4+IHBlcmYgcmVjb3JkIC1l
IGZvciB0cmFjZXBvaW50cywga3Byb2JlcyBhbmQgYW55dGhpbmcgZWxzZSBzaG91bGQgaW1wbHkg
bm8tYnBmLWV2ZW50Lg0KPj4NCj4gDQo+IE1heWJlIHNvbWV0aGluZyBsaWtlDQo+ICAgIA0KPiAg
ICAgaWYgKHNvZnR3YXJlX2V2ZW50ICYmICEgLWcpDQo+ICAgICAgICAgIG5vX2JwZl9ldmVudCA9
IHRydWU7DQo+IA0KPiA/DQo+IA0KPiBUaGlzIHdpbGwgYWxsb3cgYXR0YWNoaW5nIGtwcm9iZSBv
biBicGYgaGVscGVyIGFuZCBzZWUgd2hpY2ggYnBmIHByb2dyYW0NCj4gY2FsbHMgaXQuDQoNCnJp
Z2h0LiBnb29kIHBvaW50IGFib3V0IC1nIChJIGFzc3VtZSB5b3UgbWVhbiBjYWxsZ3JhcGggY29s
bGVjdGlvbikuDQpJbmRlZWQsIGlmIGJwZiBwcm9ncyB1bmxvYWQgYmVmb3JlIHBlcmYtcmVwb3J0
IHRoZXkgd29uJ3QgYmUgc2VlbiBpbg0KY2FsbGdyYXBocyB0b28gZXZlbiBmb3Igc3cgZXZlbnRz
LCBzbyB3ZSBoYXZlIHRvIGVuYWJsZSBicGZfZXZlbnRzDQp0byBzZWUgdGhlbS4NCg==
