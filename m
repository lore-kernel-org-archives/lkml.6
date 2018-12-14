Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58655C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F299F204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="GvN+ctCm";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="WtwKM7BU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F299F204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbeLNGuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 01:50:15 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:53690 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726437AbeLNGuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 01:50:14 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBE6mlV0019107;
        Thu, 13 Dec 2018 22:49:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=LMBTj/qa37n10AZX2vLz9Fcc81qeqNETvKqZsv2voXQ=;
 b=GvN+ctCm2mDl66MCosMPsBFvQG4nJYqxbs3Uw4wDBbvVexYRAHAqYqKxDE54wdISe/Bh
 yGuu6vI5cTEMvMDbHiSlsFpIeO5gRiEYfJDPSAWgjBAFOUr8NNZp5Jv3HnnJ1nK+cM5j
 ikr2nM9HWDde8U+1oRWR67tB2NJwx6p10Tofug2RMolaFmuTugOPRa/ZGSdwEsNyIuat
 /6WLFDegN+QINkpbLUIu9SxmWS+ZbfdvJV4pDUNloBH2jCSG5en1QZnx4g3lXdKzso2n
 0qbeg7Eh8TIa7UsYLl7oKbnIlCt2rAFaZIpJhWYsXmmo/QiMVoBRfZCxi166K5Vr+HPx gA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2054.outbound.protection.outlook.com [104.47.44.54])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2pc7ctg2wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 13 Dec 2018 22:49:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMBTj/qa37n10AZX2vLz9Fcc81qeqNETvKqZsv2voXQ=;
 b=WtwKM7BUL0jnZ8+CDvxcelTcKeCXuBSZwDhkbMBMMPDG+OT0+g3JhJTCFN1FxadIafxkjW2mDszc7E6rmjjX01KedHkEOtEmZtUD6rOZpuqVUSqZ3ipenlX8aBC/GKsrCYue4pls6PwUl8reSAcqhVYSUmwYoF7ckj+2AWGlJaw=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4664.namprd07.prod.outlook.com (52.135.204.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Fri, 14 Dec 2018 06:49:52 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e0dc:ebd5:e248:d644]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e0dc:ebd5:e248:d644%6]) with mapi id 15.20.1404.026; Fri, 14 Dec 2018
 06:49:52 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Peter Chen <hzpeterchen@gmail.com>
CC:     "nsekhar@ti.com" <nsekhar@ti.com>, "rogerq@ti.com" <rogerq@ti.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alan Douglas <adouglas@cadence.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Pawel Jez <pjez@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        "balbi@kernel.org" <balbi@kernel.org>
Subject: RE: [RFC PATCH v2 08/15] usb:cdns3: Implements device operations part
 of the API
Thread-Topic: [RFC PATCH v2 08/15] usb:cdns3: Implements device operations
 part of the API
Thread-Index: AQHUfycXLoLM1JyA10aQRtXGNL+S26VlK76AgBIxmACAAi01gIAAgGeQgAORBYCAAFa40A==
Date:   Fri, 14 Dec 2018 06:49:52 +0000
Message-ID: <BYAPR07MB4709A69213098DDCD618D973DDA10@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
 <1542535751-16079-9-git-send-email-pawell@cadence.com>
 <5BFE8883.7090802@ti.com>
 <CAL411-oKvu3EADStit=JtbcxVzM_fFGF2uPn67-wmXxPzUK6GQ@mail.gmail.com>
 <6b19b55c-66d7-439e-df8f-7b311b45af5e@ti.com>
 <BYAPR07MB470972A525D85B03C3037D3BDDA60@BYAPR07MB4709.namprd07.prod.outlook.com>
 <CAL411-oc-_0H88egpHsc06ptL12UsaE63rWwjN7novuFFx_qbA@mail.gmail.com>
In-Reply-To: <CAL411-oc-_0H88egpHsc06ptL12UsaE63rWwjN7novuFFx_qbA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNzQ0NzI0ZTYtZmY2Yy0xMWU4LTg3MjctMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDc0NDcyNGU3LWZmNmMtMTFlOC04NzI3LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iNDM4OSIgdD0iMTMxODkyNDM3OTE4NzQ1NjQ5IiBoPSJ2aytSWlJxQjYyb1U1eFRFYm9XT0tUY2dlUDQ9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4664;20:ctPqtKLdGb8oUsykgRLPCtTtillWDKce7Ppk/336t4gcVFkoGiCKoZCAglinkRut0bpBc9LZmLeMNUNc7O60rulUm6KTRaBVESbLBtStY1nGaMVNdBqDRpnKqyCpCjWnECjVagewoFzAKZGizESQEoFT8s0vEMZJTWPkUNVg1a3wG8WgoceJrO8WcCtlnitw+VtTylxvjM/uN4JHcImDjG8v051nEjtUGCSxsOANQgbhkxJQuHheuQxGzDUGpyTN
x-ms-office365-filtering-correlation-id: f523b1aa-66a4-4303-bd73-08d661905977
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4664;
x-ms-traffictypediagnostic: BYAPR07MB4664:
x-microsoft-antispam-prvs: <BYAPR07MB46643C03045A47482CB22B3EDDA10@BYAPR07MB4664.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB4664;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4664;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(366004)(136003)(36092001)(189003)(199004)(7736002)(305945005)(71200400001)(71190400001)(8936002)(229853002)(33656002)(81166006)(8676002)(97736004)(81156014)(66066001)(5660300001)(102836004)(68736007)(6506007)(76176011)(99286004)(25786009)(186003)(53936002)(26005)(93886005)(217873002)(4326008)(6116002)(14454004)(3846002)(316002)(6246003)(39060400002)(1411001)(14444005)(256004)(478600001)(106356001)(105586002)(6436002)(6916009)(86362001)(11346002)(446003)(74316002)(486006)(7696005)(55016002)(9686003)(7416002)(2906002)(54906003)(476003)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4664;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4Y1qg3DMHi2LRNyMV6eCUNI1KF29jhA5oTconcx1kmRjaOc/WAJmjv4URT1P3HatmD2Flbz5iGuPTABfhvGKL0pacAN7DKp+ugZqzdxaHHQ+I1lf0xXhCkpp6g2MiaARvwS46JhdZ8iL/MFWmuFzdYlrNm4ww+f0uBJR5grIBtDPPTVNzgWrRTa1GfEQVAYe6BytxTbnr30TE/9lCpf3AtR+mCMdsMOlqD87XOw8EXFdCaDo6rJipPvEsoqRBlp5J/Z2pL7vPLqgogO/TcbJbKJsNythL/YELcE5RyHZmQM6DiOHCWvlsCksbJA6hGXz
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f523b1aa-66a4-4303-bd73-08d661905977
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 06:49:52.2607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4664
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-14_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812140062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQo+DQo+T24gV2VkLCBEZWMgMTIsIDIwMTggYXQgMzo0OSBBTSBQYXdlbCBMYXN6Y3phayA8
cGF3ZWxsQGNhZGVuY2UuY29tPiB3cm90ZToNCj4+DQo+PiBIaSwNCj4+DQo+PiA+T24gMTAvMTIv
MTggNzo0MiBBTSwgUGV0ZXIgQ2hlbiB3cm90ZToNCj4+ID4+Pj4gK3N0YXRpYyBzdHJ1Y3QgdXNi
X2VwICpjZG5zM19nYWRnZXRfbWF0Y2hfZXAoc3RydWN0IHVzYl9nYWRnZXQgKmdhZGdldCwNCj4+
ID4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHVz
Yl9lbmRwb2ludF9kZXNjcmlwdG9yICpkZXNjLA0KPj4gPj4+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdXNiX3NzX2VwX2NvbXBfZGVzY3JpcHRvciAq
Y29tcF9kZXNjKQ0KPj4gPj4+PiArew0KPj4gPj4+PiArICAgICBzdHJ1Y3QgY2RuczNfZGV2aWNl
ICpwcml2X2RldiA9IGdhZGdldF90b19jZG5zM19kZXZpY2UoZ2FkZ2V0KTsNCj4+ID4+Pj4gKyAg
ICAgc3RydWN0IGNkbnMzX2VuZHBvaW50ICpwcml2X2VwOw0KPj4gPj4+PiArICAgICB1bnNpZ25l
ZCBsb25nIGZsYWdzOw0KPj4gPj4+PiArDQo+PiA+Pj4+ICsgICAgIHByaXZfZXAgPSBjZG5zM19m
aW5kX2F2YWlsYWJsZV9zc19lcChwcml2X2RldiwgZGVzYyk7DQo+PiA+Pj4+ICsgICAgIGlmIChJ
U19FUlIocHJpdl9lcCkpIHsNCj4+ID4+Pj4gKyAgICAgICAgICAgICBkZXZfZXJyKCZwcml2X2Rl
di0+ZGV2LCAibm8gYXZhaWxhYmxlIGVwXG4iKTsNCj4+ID4+Pj4gKyAgICAgICAgICAgICByZXR1
cm4gTlVMTDsNCj4+ID4+Pj4gKyAgICAgfQ0KPj4gPj4+PiArDQo+PiA+Pj4+ICsgICAgIGRldl9k
YmcoJnByaXZfZGV2LT5kZXYsICJtYXRjaCBlbmRwb2ludDogJXNcbiIsIHByaXZfZXAtPm5hbWUp
Ow0KPj4gPj4+PiArDQo+PiA+Pj4+ICsgICAgIHNwaW5fbG9ja19pcnFzYXZlKCZwcml2X2Rldi0+
bG9jaywgZmxhZ3MpOw0KPj4gPj4+PiArICAgICBwcml2X2VwLT5lbmRwb2ludC5kZXNjID0gZGVz
YzsNCj4+ID4+Pj4gKyAgICAgcHJpdl9lcC0+ZGlyICA9IHVzYl9lbmRwb2ludF9kaXJfaW4oZGVz
YykgPyBVU0JfRElSX0lOIDogVVNCX0RJUl9PVVQ7DQo+PiA+Pj4+ICsgICAgIHByaXZfZXAtPnR5
cGUgPSB1c2JfZW5kcG9pbnRfdHlwZShkZXNjKTsNCj4+ID4+Pj4gKw0KPj4gPj4+PiArICAgICBs
aXN0X2FkZF90YWlsKCZwcml2X2VwLT5lcF9tYXRjaF9wZW5kaW5nX2xpc3QsDQo+PiA+Pj4+ICsg
ICAgICAgICAgICAgICAgICAgJnByaXZfZGV2LT5lcF9tYXRjaF9saXN0KTsNCj4+ID4+Pj4gKyAg
ICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcHJpdl9kZXYtPmxvY2ssIGZsYWdzKTsNCj4+ID4+
Pj4gKyAgICAgcmV0dXJuICZwcml2X2VwLT5lbmRwb2ludDsNCj4+ID4+Pj4gK30NCj4+ID4+PiBX
aHkgZG8geW91IG5lZWQgYSBjdXN0b20gbWF0Y2hfZXA/DQo+PiA+Pj4gZG9lc24ndCB1c2JfZXBf
YXV0b2NvbmZpZyBzdWZmaWNlPw0KPj4gPj4+DQo+PiA+Pj4gWW91IGNhbiBjaGVjayBpZiBFUCBp
cyBjbGFpbWVkIG9yIG5vdCBieSBjaGVja2luZyB0aGUgZXAtPmNsYWltZWQgZmxhZy4NCj4+ID4+
Pg0KPj4gPj4gSXQgaXMgYSBzcGVjaWFsIHJlcXVpcmVtZW50IGZvciB0aGlzIElQLCB0aGUgRVAg
dHlwZSBhbmQgTWF4UGFja2V0U2l6ZQ0KPj4gPj4gY2hhbmdpbmcgY2FuJ3QgYmUgZG9uZSBhdCBy
dW50aW1lLCBlZywgYXQgZXAtPmVuYWJsZS4gU2VlIGJlbG93IGNvbW1pdA0KPj4gPj4gZm9yIGRl
dGFpbC4NCj4+ID4+DQo+PiA+PiAgICAgdXNiOiBjZG5zMzogZ2FkZ2V0OiBjb25maWd1cmUgYWxs
IGVuZHBvaW50cyBiZWZvcmUgc2V0IGNvbmZpZ3VyYXRpb24NCj4+ID4+DQo+PiA+PiAgICAgQ2Fk
ZW5jZSBJUCBoYXMgb25lIGxpbWl0YXRpb24gdGhhdCBhbGwgZW5kcG9pbnRzIG11c3QgYmUgY29u
ZmlndXJlZA0KPj4gPj4gICAgIChUeXBlICYgTWF4UGFja2V0U2l6ZSkgYmVmb3JlIHNldHRpbmcg
Y29uZmlndXJhdGlvbiB0aHJvdWdoIGhhcmR3YXJlDQo+PiA+PiAgICAgcmVnaXN0ZXIsIGl0IG1l
YW5zIHdlIGNhbid0IGNoYW5nZSBlbmRwb2ludHMgY29uZmlndXJhdGlvbiBhZnRlcg0KPj4gPj4g
ICAgIHNldF9jb25maWd1cmF0aW9uLg0KPj4gPj4NCj4+ID4+ICAgICBJbiB0aGlzIHBhdGNoLCB3
ZSBhZGQgbm9uLWNvbnRyb2wgZW5kcG9pbnQgdGhyb3VnaCB1c2Jfc3MtPmVwX21hdGNoX2xpc3Qs
DQo+PiA+PiAgICAgd2hpY2ggaXMgYWRkZWQgd2hlbiB0aGUgZ2FkZ2V0IGRyaXZlciB1c2VzIHVz
Yl9lcF9hdXRvY29uZmlnIHRvIGNvbmZpZ3VyZQ0KPj4gPj4gICAgIHNwZWNpZmljIGVuZHBvaW50
OyBXaGVuIHRoZSB1ZGMgZHJpdmVyIHJlY2VpdmVzIHNldF9jb25maWd1cmlvbiByZXF1ZXN0LA0K
Pj4gPj4gICAgIGl0IGdvZXMgdGhyb3VnaCB1c2Jfc3MtPmVwX21hdGNoX2xpc3QsIGFuZCBjb25m
aWd1cmUgYWxsIGVuZHBvaW50cw0KPj4gPj4gICAgIGFjY29yZGluZ2x5Lg0KPj4gPj4NCj4+ID4+
ICAgICBBdCB1c2JfZXBfb3BzLmVuYWJsZS9kaXNhYmxlLCB3ZSBvbmx5IGVuYWJsZSBhbmQgZGlz
YWJsZSBlbmRwb2ludCB0aHJvdWdoDQo+PiA+PiAgICAgZXBfY2ZnIHJlZ2lzdGVyIHdoaWNoIGNh
biBiZSBjaGFuZ2VkIGFmdGVyIHNldF9jb25maWd1cmF0aW9uLCBhbmQgZG8NCj4+ID4+ICAgICBz
b21lIHNvZnR3YXJlIG9wZXJhdGlvbiBhY2NvcmRpbmdseS4NCj4+ID4NCj4+ID5BbGwgdGhpcyBz
aG91bGQgYmUgcGFydCBvZiBjb21tZW50cyBpbiBjb2RlIGFsb25nIHdpdGggaW5mb3JtYXRpb24g
YWJvdXQNCj4+ID5jb250cm9sbGVyIHZlcnNpb25zIHdoaWNoIHN1ZmZlciBmcm9tIHRoZSBlcnJh
dGEuDQo+PiA+DQo+PiA+SXMgdGhlcmUgYSB2ZXJzaW9uIG9mIGNvbnRyb2xsZXIgYXZhaWxhYmxl
IHdoaWNoIGRvZXMgbm90IGhhdmUgdGhlDQo+PiA+ZGVmZWN0PyBJcyB0aGVyZSBhIGZ1dHVyZSBw
bGFuIHRvIGZpeCB0aGlzPw0KPj4gPg0KPj4gPklmIGFueSBvZiB0aGF0IGlzIHllcywgeW91IHBy
b2JhYmx5IHdhbnQgdG8gaGFuZGxlIHRoaXMgd2l0aCBydW50aW1lDQo+PiA+ZGV0ZWN0aW9uIG9m
IHZlcnNpb24gKGxpa2UgZG9uZSB3aXRoIERXQzNfUkVWSVNJT05fWFhYIG1hY3JvcykuDQo+PiA+
U29tZXRpbWVzIHRoZSBoYXJkd2FyZS1yZWFkIHZlcnNpb25zIHRoZW1zZWx2ZXMgYXJlIGluY29y
cmVjdCwgc28gaXRzDQo+PiA+YmV0dGVyIHRvIGludHJvZHVjZSBhIHZlcnNpb24gc3BlY2lmaWMg
Y29tcGF0aWJsZSB0b28gbGlrZQ0KPj4gPiJjZG5zLHVzYi0xLjAuMCIgKGFzIGhpbnRlZCB0byBi
eSBSb2IgSGVycmluZyBhcyB3ZWxsKS4NCj4+ID4NCj4+DQo+PiBjdXN0b20gbWF0Y2hfZXAgaXMg
dXNlZCBhbmQgd29ya3Mgd2l0aCBhbGwgdmVyc2lvbnMgb2YgdGhlIGdlbjENCj4+IGNvbnRyb2xs
ZXIuIEZ1dHVyZSAoZ2VuMikgcmVsZWFzZXMgb2YgdGhlIGNvbnRyb2xsZXIgd29u4oCZdCBoYXZl
IHN1Y2gNCj4+IGxpbWl0YXRpb24gYnV0IHRoZXJlIGlzIG5vIHBsYW4gdG8gY2hhbmdlIGN1cnJl
bnQgKGdlbjEpIGZ1bmN0aW9uYWxpdHkNCj4+IG9mIHRoZSBjb250cm9sbGVyLg0KPj4NCj4+IEkg
d2lsbCBhZGQgY29tbWVudCBiZWZvcmUgY2RuczNfZ2FkZ2V0X21hdGNoX2VwIGZ1bmN0aW9uLg0K
Pj4gQWxzbyBJIHdpbGwgY2hhbmdlIGNkbnMsdXNiMyB0byBjZG5zLHVzYjMtMS4wLjAgYW5kIGFk
ZCBhZGRpdGlvbmFsDQo+PiBjZG5zLHVzYjMtMS4wLjEgY29tcGF0aWJsZS4NCj4+DQo+PiBjZG5z
LHVzYjMtMS4wLjEgd2lsbCBiZSBmb3IgY3VycmVudCB2ZXJzaW9uIG9mIGNvbnRyb2xsZXIgd2hp
Y2ggSSB1c2UuDQo+PiBjZG5zLHVzYjMtMS4wLjAgd2lsbCBiZSBmb3Igb2xkZXIgdmVyc2lvbiAt
IFBldGVyIENoYW4gcGxhdGZvcm0uDQo+PiBJIG5vdyB0aGF0IEkgaGF2ZSBzb21lIGNoYW5nZXMg
aW4gY29udHJvbGxlciwgYW5kIG9uZSBvZiB0aGVtIHJlcXVpcmUNCj4+IHNvbWUgY2hhbmdlcyBp
biBEUkQgZHJpdmVyLiBJdCB3aWxsIGJlIHNhZmVyIHRvIGFkZCB0d28gc2VwYXJhdGUNCj4+IHZl
cnNpb24gaW4gY29tcGF0aWJsZXMuDQo+Pg0KPg0KPlBhd2VsLCBjb3VsZCB3ZSBoYXZlIGNvcnJl
Y3QgcmVnaXN0ZXIgdG8gc2hvdyBjb250cm9sbGVyIHZlcnNpb24/IEl0IGlzDQo+YmV0dGVyIHdl
IGNvdWxkIHZlcnNpb24ganVkZ2VtZW50IGF0IHJ1bnRpbWUgaW5zdGVhZCBvZiBzdGF0aWMgY29t
cGF0aWJsZS4NCj4NCg0KT2ssIEkgd2lsbCB0cmF5IGRvIHRoaXMgaW4gdGhpcyB3YXkuDQoNClBh
d2VsIA0K
