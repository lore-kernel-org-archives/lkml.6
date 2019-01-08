Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13705C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B307820651
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="IuyXudAd";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="athIkEBj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbfAHU50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:57:26 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45708 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729297AbfAHU50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 15:57:26 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x08KtPgS026264;
        Tue, 8 Jan 2019 12:56:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ltxOhMu7Q8QmtXRja4auv6TzHQr9Imj2siVFs8M+p4A=;
 b=IuyXudAdCLrHimu8Qr4lHE26FDLTpXV3aAqAsgEUfqonfpszG2LmakLjGdiw1afu5LEQ
 iD+daCu6Ktlzy/3bA2il5IBf6oNEDJQ35q26gpkxdVdFPnLgWa+GvtiCLsQsYgEBCyD5
 mtJHHsSnsnQl6ZekB2jJHX8dEloet6LUe+s= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2pw33u01k1-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 08 Jan 2019 12:56:59 -0800
Received: from frc-mbx03.TheFacebook.com (2620:10d:c0a1:f82::27) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 8 Jan 2019 12:56:58 -0800
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-mbx03.TheFacebook.com (2620:10d:c0a1:f82::27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 8 Jan 2019 12:56:57 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Tue, 8 Jan 2019 12:56:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltxOhMu7Q8QmtXRja4auv6TzHQr9Imj2siVFs8M+p4A=;
 b=athIkEBjwbykBNAHdzVq1wZ4w+n/Qyea3aKkqES7UjFsgUuEJTA+og/h7uuqnP4vxOSOiN5qRwxjfLspJxRjuB2DV8LpBWx6UGGN+ezLUptxr3TwYM3Hpl5umn6d5/SO/BUUPQIoaOKrR8hO0LPPAhCRQr1ytcA0YJ594PDZ2KI=
Received: from BYAPR15MB2501.namprd15.prod.outlook.com (52.135.196.11) by
 BYAPR15MB2902.namprd15.prod.outlook.com (20.178.206.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Tue, 8 Jan 2019 20:56:55 +0000
Received: from BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::e12c:c450:3e9f:4ef6]) by BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::e12c:c450:3e9f:4ef6%4]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 20:56:55 +0000
From:   Alexei Starovoitov <ast@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v5 perf, bpf-next 3/7] perf, bpf: introduce
 PERF_RECORD_BPF_EVENT
Thread-Topic: [PATCH v5 perf, bpf-next 3/7] perf, bpf: introduce
 PERF_RECORD_BPF_EVENT
Thread-Index: AQHUmJHzTcneBvFiJEmnpKLooFaM96Wl0lUAgAAl4wA=
Date:   Tue, 8 Jan 2019 20:56:54 +0000
Message-ID: <10039e93-a0a5-a712-4051-20f5c5d79fab@fb.com>
References: <20181220182904.4193196-1-songliubraving@fb.com>
 <20181220182904.4193196-4-songliubraving@fb.com>
 <20190108184116.GC30894@hirez.programming.kicks-ass.net>
In-Reply-To: <20190108184116.GC30894@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR15CA0072.namprd15.prod.outlook.com
 (2603:10b6:301:4c::34) To BYAPR15MB2501.namprd15.prod.outlook.com
 (2603:10b6:a02:88::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::7:958e]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2902;20:jF4ep1kicvUQlvEWGNp7WiNfnBKChPBWq/Xf3nHtVAA0LzKzsdTAJPoFtuoJzI5dzepVTnM1etqhp0rjzfakeT9kU6tAa/+HHRmpo5wRnUenzmJLKe48nqbi1+JeazEFWMcwA87WMEhllTuWwZkbvtaVegnSpjIxoQQNDP5ZEEM=
x-ms-office365-filtering-correlation-id: c45ce96d-d332-41f5-e7c0-08d675abd227
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2902;
x-ms-traffictypediagnostic: BYAPR15MB2902:
x-microsoft-antispam-prvs: <BYAPR15MB2902DAC01C23CADE38A376CAD78A0@BYAPR15MB2902.namprd15.prod.outlook.com>
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39860400002)(396003)(136003)(199004)(189003)(14454004)(6116002)(386003)(6636002)(2906002)(76176011)(229853002)(8676002)(6512007)(5660300001)(53546011)(186003)(446003)(102836004)(486006)(305945005)(11346002)(7736002)(476003)(81166006)(99286004)(105586002)(2616005)(46003)(52116002)(6246003)(53936002)(110136005)(86362001)(81156014)(31686004)(6436002)(6506007)(8936002)(54906003)(478600001)(6486002)(97736004)(106356001)(68736007)(36756003)(4326008)(31696002)(71200400001)(256004)(71190400001)(316002)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2902;H:BYAPR15MB2501.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QoCbTl+ffOsakbDgj4tnjmoDFyy432tKWr9/cxzhW++sp117025b+Hy48qhmt8hwcaiMyaW2DPUSoGFvZYh+om8GqsnN9Xs32WjHiYg2K+aIfACOfxQbcQBHR44kE+lqII9cm7DJTZvrw1TxZfm8jgYJJYms1y/I2w8YA3n6/991jEWZIHpbFx3NymbFur11qJ738+r1uAFGu9W+1Oqmtdo6rpgIAxBMWGAO8l3bHQpHOj1KfC/BZxqikDzvnuMAONTD/lDcEqFLiA+VkB30ZxtOUg/S3hQbGLE6J6G67qGeBFh4MR8NI0z6O6DQtuKV
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E39F36BD4A7613429CCB1BC959707FF1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c45ce96d-d332-41f5-e7c0-08d675abd227
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 20:56:54.9567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2902
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-08_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS84LzE5IDEwOjQxIEFNLCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4gT24gVGh1LCBEZWMg
MjAsIDIwMTggYXQgMTA6Mjk6MDBBTSAtMDgwMCwgU29uZyBMaXUgd3JvdGU6DQo+PiBAQCAtOTg2
LDkgKzk4NywzNSBAQCBlbnVtIHBlcmZfZXZlbnRfdHlwZSB7DQo+PiAgIAkgKi8NCj4+ICAgCVBF
UkZfUkVDT1JEX0tTWU1CT0wJCQk9IDE3LA0KPj4gICANCj4+ICsJLyoNCj4+ICsJICogUmVjb3Jk
IGJwZiBldmVudHM6DQo+PiArCSAqICBlbnVtIHBlcmZfYnBmX2V2ZW50X3R5cGUgew0KPj4gKwkg
KglQRVJGX0JQRl9FVkVOVF9VTktOT1dOCQk9IDAsDQo+PiArCSAqCVBFUkZfQlBGX0VWRU5UX1BS
T0dfTE9BRAk9IDEsDQo+PiArCSAqCVBFUkZfQlBGX0VWRU5UX1BST0dfVU5MT0FECT0gMiwNCj4+
ICsJICogIH07DQo+PiArCSAqDQo+PiArCSAqIHN0cnVjdCB7DQo+PiArCSAqCXN0cnVjdCBwZXJm
X2V2ZW50X2hlYWRlcgloZWFkZXI7DQo+PiArCSAqCXUxNgkJCQl0eXBlOw0KPj4gKwkgKgl1MTYJ
CQkJZmxhZ3M7DQo+PiArCSAqCXUzMgkJCQlpZDsNCj4+ICsJICoJdTgJCQkJdGFnW0JQRl9UQUdf
U0laRV07DQo+PiArCSAqCXN0cnVjdCBzYW1wbGVfaWQJCXNhbXBsZV9pZDsNCj4+ICsJICogfTsN
Cj4+ICsJICovDQo+PiArCVBFUkZfUkVDT1JEX0JQRl9FVkVOVAkJCT0gMTgsDQo+PiArDQo+IA0K
PiBFbHNld2hlcmUgdG9kYXksIEkgcmFpc2VkIHRoZSBwb2ludCB0aGF0IGJ5IHRoZSB0aW1lICho
b3dldmVyIHNob3J0DQo+IGludGVydmFsKSB1c2Vyc3BhY2UgZ2V0cyBhcm91bmQgdG8gcmVhZGlu
ZyB0aGlzIGV2ZW50LCB0aGUgYWN0dWFsDQo+IHByb2dyYW0gY291bGQgYmUgZ29uZSBhZ2Fpbi4N
Cj4gDQo+IEluIHRoaXMgY2FzZSB0aGUgcHJvZ3JhbSBoYXMgYmVlbiB3aXRoIHVzIGZvciBhIHZl
cnkgc2hvcnQgcGVyaW9kDQo+IGluZGVlZDsgYnV0IGl0IGNvdWxkIHN0aWxsIGhhdmUgZ2VuZXJh
dGVkIHNvbWUgc2FtcGxlcyBvciBvdGhlcndpc2UNCj4gZ2VuZXJhdGVkIHRyYWNlIGRhdGEuDQo+
IA0KPiBJdCB3YXMgc3VnZ2VzdGVkIHRvIGFsbG93IHBpbm5pbmcgbW9kdWxlcy9wcm9ncmFtcyB0
byBhdm9pZCB0aGlzDQo+IHNpdHVhdGlvbiwgYnV0IHRoYXQgb2YgY291cnNlIGhhcyBvdGhlciB1
bmRlc2lyYWJsZSBlZmZlY3RzLCBzdWNoIGFzIGENCj4gdHJpdmlhbCBEb1MuDQo+IA0KPiBBIHRy
dWx5IGhvcnJpYmxlIGhhY2sgd291bGQgYmUgdG8gaW5jbHVkZSBhbiBvcGVuIGZpbGVkZXNjIGlu
IHRoZSBldmVudA0KPiB0aGF0IG5lZWRzIGNsb3NpbmcgdG8gcmVsZWFzZSB0aGUgcmVzb3VyY2Us
IGJ1dCBJJ20gc29ycnkgZm9yIGV2ZW4NCj4gc3VnZ2VzdGluZyB0aGF0ICoqc2h1ZGRlcioqLg0K
PiANCj4gRG8gd2UgaGF2ZSBhbnkgc2FuZSBpZGVhcz8NCg0KSSB0aGluayB3ZSBzaG91bGQgbWlz
cyBzdWNoIHVsdHJhIHNob3J0IGxpdmVkIHByb2dzLg0KSWYgcGVyZiByZWNvcmQgaXMgc2xvd2Vy
IHRoYW4gc29tZSB1c2VyIGRvaW5nIGZvcig7Oykge2xvYWQgcHJvZzsgDQp1bmxvYWQ7fSB0aGFu
IGl0J3MgYSBnb29kIHRoaW5nLg0KSSBmcmFua2x5IGRvbid0IHRoaW5rIGl0J3MgcHJhY3RpY2Fs
bHkgcG9zc2libGUgdG8gbWlzcyBhIHByb2cuDQpwZXJmIHJpbmcgYnVmZmVyIGlzIHdheSBmYXN0
ZXIgdGhhbiBwcm9nIGxvYWQvdW5sb2FkLg0KRXZlbiB3aGVuIGFsbCBzY2hlZHVsaW5nIGFydGlm
YWN0cyBvZiBwZXJmIHVzZXIgc3BhY2UgYXJlIGZhY3RvcmVkIGluLg0KRG9pbmcgYmFycmllcnMg
aXMgRG9TLWFibGUuDQpTZW5kaW5nIEZEIHZpYSByaW5nIGJ1ZmZlciBpcyBub3QgcG9zc2libGUu
DQpJZiB0aGVyZSB3YXMgYSBub24tc2h1ZGRlciBzb2x1dGlvbiB0byB0aGlzIHdlIGNvdWxkIGRv
IGl0LA0KYnV0IGFsbCBjb21wbGljYXRpb25zIHBvaW50aW5nIG91dCB0aGF0IHRoaXMgaXMgbm90
IGEgcHJvYmxlbQ0Kd29ydGggc29sdmluZy4NCkF0IGxlYXN0IHNpbmNlIHJpZ2h0IG5vdyBub25l
IG9mIHVzIHNlZSBhIGNsZWFuIGZpeCBJIHByb3Bvc2UNCnRvIG1vdmUgYWhlYWQgd2l0aCB3aGF0
IHdlIGhhdmUgYW5kIGFkZHJlc3MgaXQgbGF0ZXIgaWYgYmV0dGVyIGlkZWFzDQpjb21lIHVwLiBX
ZSd2ZSBiZWVuIG1pc3Npbmcgc2hvcnQgbGl2ZWQgcHJvZ3MgYW5kIHByb2cgbm90aWZpY2F0aW9u
cw0KYWxsIHRoaXMgdGltZSBhbmQgdXNlcnMgY29tcGxhaW4uIFRoYXQgaXMgdGhlIHByb2JsZW0g
dG8gYWRkcmVzcy4NCg==
