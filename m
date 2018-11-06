Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F03C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A8B2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ULA5WDJL";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="GeN6eDrn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3A8B2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731035AbeKGI50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 03:57:26 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35122 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730409AbeKGI5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 03:57:25 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.22/8.16.0.22) with SMTP id wA6NRTKG026850;
        Tue, 6 Nov 2018 15:29:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ckCaaNPjUkOpHccZJcsh32U8UjU2hyIOM5m3Yi07irg=;
 b=ULA5WDJL2ouazsfDPPiwwB30w4M87zgM2WiuAMuKahHSzRUb3qctrb+Rsnf0qh6iOhqm
 Nkk+oiQE1tRyRhZc3m4tfHK8oXJ0F85Qq04xoyF7lZRxQ+wsTS1+2yl7vMiQQZfP7TsG
 /0W+6xlFc7TPe7nhijmeAS7jFfwrKt9YZFk= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2nkjua0bqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 06 Nov 2018 15:29:11 -0800
Received: from frc-hub02.TheFacebook.com (2620:10d:c021:18::172) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 6 Nov 2018 15:29:09 -0800
Received: from FRC-CHUB09.TheFacebook.com (2620:10d:c021:18::28) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Tue, 6 Nov 2018 15:29:09 -0800
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.29) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 6 Nov 2018 18:29:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckCaaNPjUkOpHccZJcsh32U8UjU2hyIOM5m3Yi07irg=;
 b=GeN6eDrnTrrQZN+ExfQXIQ/SuXjHaDfHYoI6VAR2HTqD3a4K5rScC7UiAyTuF8E4B+p4ZlIWvxbWGHxbAoai6GiH8wtwCIDSttDbaV80dB91QCsD9IVfz1+B4H6TsJCaRdrzD3ekJJ/gtrUAYLypjhdgeHuXpOArMdBc/fo/9oQ=
Received: from BYAPR15MB2501.namprd15.prod.outlook.com (52.135.196.11) by
 BYAPR15MB2328.namprd15.prod.outlook.com (52.135.197.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Tue, 6 Nov 2018 23:29:07 +0000
Received: from BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::ed40:7ac9:3043:5bc1]) by BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::ed40:7ac9:3043:5bc1%2]) with mapi id 15.20.1294.034; Tue, 6 Nov 2018
 23:29:07 +0000
From:   Alexei Starovoitov <ast@fb.com>
To:     Song Liu <songliubraving@fb.com>, David Ahern <dsahern@gmail.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@kernel.org" <acme@kernel.org>
Subject: Re: [RFC perf,bpf 5/5] perf util: generate bpf_prog_info_event for
 short living bpf programs
Thread-Topic: [RFC perf,bpf 5/5] perf util: generate bpf_prog_info_event for
 short living bpf programs
Thread-Index: AQHUdhL1gT1g6kXc4U+H9DJqSIZu3qVDSleAgAAXY4CAAAMiAA==
Date:   Tue, 6 Nov 2018 23:29:07 +0000
Message-ID: <27fc8327-3390-ba5a-6063-89c9e7165e7b@fb.com>
References: <20181106205246.567448-1-songliubraving@fb.com>
 <20181106205246.567448-6-songliubraving@fb.com>
 <b984776a-ce69-ab16-ed87-1cea89c9d79a@gmail.com>
 <6C5A9FBD-F50D-444C-9038-E9557EC850D2@fb.com>
In-Reply-To: <6C5A9FBD-F50D-444C-9038-E9557EC850D2@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR10CA0064.namprd10.prod.outlook.com
 (2603:10b6:300:2c::26) To BYAPR15MB2501.namprd15.prod.outlook.com
 (2603:10b6:a02:88::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::7:62d8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2328;20:WyTF6F78Vspq2xdV0bwXgPoRkUcb3xcDX6RDmF16MOFfp8mwlKQQmjW0ub4It1IyxFfU7f+x3b29vFPF36Cgv0rb+WKApIDP/H9OZhRSX9mLMnDvsb0pzl9W2s4jPy4khyvmgXD3Q12E1ypZsKKM7V+HxORyRNljlQkzFR2yUW4=
x-ms-office365-filtering-correlation-id: a56138ef-604c-4f67-c158-08d6443fa571
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2328;
x-ms-traffictypediagnostic: BYAPR15MB2328:
x-microsoft-antispam-prvs: <BYAPR15MB232846EADCD55367EBDE8569D7CB0@BYAPR15MB2328.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231382)(11241501184)(944501410)(52105095)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BYAPR15MB2328;BCL:0;PCL:0;RULEID:;SRVR:BYAPR15MB2328;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(396003)(346002)(366004)(39860400002)(199004)(189003)(52116002)(97736004)(53546011)(2900100001)(478600001)(6506007)(36756003)(102836004)(86362001)(71190400001)(71200400001)(53936002)(5660300001)(76176011)(386003)(6116002)(68736007)(186003)(256004)(6246003)(31696002)(446003)(11346002)(486006)(7736002)(2616005)(476003)(229853002)(6436002)(2906002)(6486002)(8676002)(81156014)(8936002)(81166006)(6512007)(46003)(305945005)(39060400002)(31686004)(106356001)(105586002)(99286004)(4326008)(93886005)(14454004)(25786009)(110136005)(54906003)(316002)(142933001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2328;H:BYAPR15MB2501.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2+518YVgwDf6o/LbkRCWn5HWbf0DPNhcXu/JuM+a8joIlhEgL1/5adS1y9kuTvm9VbmFjHHjnhMYpJCkauCcMJSmnRb33NsGx9VPAYgvoZn+dNqusc5W8rU21fXqJNL2VoxhyZ/qhlp87hPqd5D9CQyhb5RLhspCDUoJ9/7wT74j7KvyPi87CUjg1jVy4ZXiGtkMva31wWgrMfBnJu53q2IykCBEmWzAheZyvk60HYFVG1SIQQuZF0LTKmp3F+Fy0HVuQDeY8a+09RDCYj9kcEb3wFrq3uv4hz3I+A3f2nlBkBHugO1mj0OrSqgDFwn8Ag21a4fJm7icMGfXV3nSoSbiV8/7SipcMbrdIilfJXg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <85E2B6C0720FAA4EA429ECF80B658C8E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a56138ef-604c-4f67-c158-08d6443fa571
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 23:29:07.4772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2328
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-06_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvNi8xOCAzOjE3IFBNLCBTb25nIExpdSB3cm90ZToNCj4gDQo+IA0KPj4gT24gTm92IDYs
IDIwMTgsIGF0IDE6NTQgUE0sIERhdmlkIEFoZXJuIDxkc2FoZXJuQGdtYWlsLmNvbT4gd3JvdGU6
DQo+Pg0KPj4gT24gMTEvNi8xOCAxOjUyIFBNLCBTb25nIExpdSB3cm90ZToNCj4+PiArDQo+Pj4g
c3RhdGljIGludCByZWNvcmRfX21tYXBfcmVhZF9hbGwoc3RydWN0IHJlY29yZCAqcmVjKQ0KPj4+
IHsNCj4+PiAJaW50IGVycjsNCj4+Pg0KPj4+ICsJZXJyID0gcmVjb3JkX19tbWFwX3Byb2Nlc3Nf
dmlwX2V2ZW50cyhyZWMpOw0KPj4+ICsJaWYgKGVycikNCj4+PiArCQlyZXR1cm4gZXJyOw0KPj4+
ICsNCj4+PiAJZXJyID0gcmVjb3JkX19tbWFwX3JlYWRfZXZsaXN0KHJlYywgcmVjLT5ldmxpc3Qs
IGZhbHNlKTsNCj4+PiAJaWYgKGVycikNCj4+PiAJCXJldHVybiBlcnI7DQo+Pg0KPj4gU2VlbXMg
dG8gbWUgdGhhdCBpcyBnb2luZyB0byBpbmNyZWFzZSB0aGUgb3ZlcmhlYWQgb2YgcGVyZiBvbiBh
bnkgc3lzdGVtDQo+PiBkb2luZyBCUEYgdXBkYXRlcy4gVGhlIEJQRiBldmVudHMgY2F1c2UgYSB3
YWtldXAgZXZlcnkgbG9hZCBhbmQgdW5sb2FkLA0KPj4gYW5kIHBlcmYgcHJvY2Vzc2VzIG5vdCBv
bmx5IHRoZSBWSVAgZXZlbnRzIGJ1dCB0aGVuIHdhbGtzIGFsbCBvZiB0aGUNCj4+IG90aGVyIG1h
cHMuDQo+IA0KPiBCUEYgcHJvZyBsb2FkL3VubG9hZCBldmVudHMgc2hvdWxkIGJlIHJhcmUgZXZl
bnRzIGluIHJlYWwgd29ybGQgdXNlIGNhc2VzLg0KPiBTbyBJIHRoaW5rIHRoZSBvdmVyaGVhZCBp
cyBPSy4gQWxzbywgSSBkb24ndCBzZWUgYW4gZWFzeSB3YXkgdG8gaW1wcm92ZQ0KPiB0aGlzLg0K
PiANCj4+DQo+Pj4gQEAgLTE2ODYsNiArMTczNCw4IEBAIHN0YXRpYyBzdHJ1Y3Qgb3B0aW9uIF9f
cmVjb3JkX29wdGlvbnNbXSA9IHsNCj4+PiAJCQkgICJzaWduYWwiKSwNCj4+PiAJT1BUX0JPT0xF
QU4oMCwgImRyeS1ydW4iLCAmZHJ5X3J1biwNCj4+PiAJCSAgICAiUGFyc2Ugb3B0aW9ucyB0aGVu
IGV4aXQiKSwNCj4+PiArCU9QVF9CT09MRUFOKDAsICJuby1icGYtZXZlbnQiLCAmcmVjb3JkLm5v
X2JwZl9ldmVudCwNCj4+PiArCQkgICAgImRvIG5vdCByZWNvcmQgZXZlbnQgb24gYnBmIHByb2dy
YW0gbG9hZC91bmxvYWQiKSwNCj4+DQo+PiBXaHkgc2hvdWxkIHRoaXMgZGVmYXVsdCBvbj8gSWYg
YW0gcmVjb3JkaW5nIEZJQiBldmVudHMsIEkgZG9uJ3QgY2FyZQ0KPj4gYWJvdXQgQlBGIGV2ZW50
cy4NCj4+DQo+IA0KPiBJIGFtIE9LIHdpdGggZGVmYXVsdCBvZmYgaWYgdGhhdCdzIHRoZSBwcmVm
ZXJyZWQgd2F5Lg0KDQpJIHRoaW5rIGNvbmNlcm5zIHdpdGggcGVyZiBvdmVyaGVhZCBmcm9tIGNv
bGxlY3RpbmcgYnBmIGV2ZW50cw0KYXJlIHVuZm91bmRlZC4NCkkgd291bGQgcHJlZmVyIGZvciB0
aGlzIGZsYWcgdG8gYmUgb24gYnkgZGVmYXVsdC4NCg==
