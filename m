Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBEAC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 13:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D78F2184C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 13:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="NgHJ4pBC";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="nfy060F3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbeLPNcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 08:32:05 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:56548 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729822AbeLPNcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 08:32:05 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBGDNrXB021013;
        Sun, 16 Dec 2018 05:31:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=egqB3ktK42YB++K6ZUP4JUHPZ3YVSAyPCd08pgGqZSE=;
 b=NgHJ4pBCeH/DxnyAJYIDaFzbur7p2tgviOFwJ1SBX4flYRdDZg1Nkv1JTB3St05OQClK
 EjAtKuaxQmwiJg7soTPQN765FDFGCGmRQIDrVUJH0y85q1c2GfBDIIo9WmnS6eeF48iW
 nCM+H7llb2ccsDVjVArnw6O6orU4sZxlG2rbhzVjuuhkP17Lm7fp36wU6wU8CrSt/Srk
 2/SkFCfpwSZy247cCov2gBgOE6AZurPVxdusoFzVdjn4+9AlsB3Mc65lRl4CwryaGdCq
 +HA5QKH4xd02Y4Qsc1ZCVuxGWx0pNyh+b4V0d+8aLmT8dkacTDb4t8wmERTZwxD9hgOs SQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2057.outbound.protection.outlook.com [104.47.46.57])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2pde961qbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 16 Dec 2018 05:31:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egqB3ktK42YB++K6ZUP4JUHPZ3YVSAyPCd08pgGqZSE=;
 b=nfy060F3CZcXbMXEoVfMp6VFMq9iCVHH5EA2cdaz/w9h0vESa4zX2gMwZ87JCEZX0sK8dGdjYZozq3N6uETFGFGSoUf4N6h0RLlHOSnFeRAuas8AmE4LMu9ZqH9b8jR8eXromy71laGVky7X3wDEQmNGkOp4YQGU2kHsE/48m2U=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4391.namprd07.prod.outlook.com (52.135.224.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Sun, 16 Dec 2018 13:31:47 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e97e:1c66:94bc:24ef]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e97e:1c66:94bc:24ef%2]) with mapi id 15.20.1425.021; Sun, 16 Dec 2018
 13:31:47 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Sekhar Nori <nsekhar@ti.com>, Felipe Balbi <balbi@kernel.org>,
        Peter Chen <hzpeterchen@gmail.com>
CC:     "rogerq@ti.com" <rogerq@ti.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alan Douglas <adouglas@cadence.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
Subject: RE: [RFC PATCH v2 08/15] usb:cdns3: Implements device operations part
 of the API
Thread-Topic: [RFC PATCH v2 08/15] usb:cdns3: Implements device operations
 part of the API
Thread-Index: AQHUfycXLoLM1JyA10aQRtXGNL+S26VlK76AgBIxmACAAi01gIAAgGeQgAORBYCAAJhZgIAAAkwAgAAHJACAAAOIAIAAD1WAgAM0wDA=
Date:   Sun, 16 Dec 2018 13:31:47 +0000
Message-ID: <BYAPR07MB4709122D890CEA548523752FDDA30@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
 <1542535751-16079-9-git-send-email-pawell@cadence.com>
 <5BFE8883.7090802@ti.com>
 <CAL411-oKvu3EADStit=JtbcxVzM_fFGF2uPn67-wmXxPzUK6GQ@mail.gmail.com>
 <6b19b55c-66d7-439e-df8f-7b311b45af5e@ti.com>
 <BYAPR07MB470972A525D85B03C3037D3BDDA60@BYAPR07MB4709.namprd07.prod.outlook.com>
 <CAL411-oc-_0H88egpHsc06ptL12UsaE63rWwjN7novuFFx_qbA@mail.gmail.com>
 <5a41de27-cd1f-0cfd-ccdc-dccbf0854fcb@ti.com>
 <87bm5ol6zt.fsf@linux.intel.com>
 <d5623e70-7971-d729-f395-7259ab0efdb0@ti.com>
 <875zvwl585.fsf@linux.intel.com>
 <7e6ac47e-61e4-ecd3-73d3-9b1be2d81479@ti.com>
In-Reply-To: <7e6ac47e-61e4-ecd3-73d3-9b1be2d81479@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZWVmMTllYTctMDEzNi0xMWU5LTg3MjgtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGVlZjE5ZWE4LTAxMzYtMTFlOS04NzI4LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMzk0MSIgdD0iMTMxODk0NDA3MDcxNDg5OTAyIiBoPSJoWWM3VUF6Qk4zZEJNTEhRdDY0a3M4RXNiSjg9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4391;20:flwHK4z45AWbs2gYMBb/TK3r4vGH6h5xHJ9qWuEgs/U5myo4AZG5r2tN34ZJtWTeybcFsPcZVTjGh5zbgDLwEIvSsjuWqa5zPDkfSX6M9DbBdmCYom8I/X0GpJ0Hz2H0DPftvXpZSrNWDNOPxQPgWNva4gK4f4odQXa76brclkRdc2gc/wMOqtONNvEpx2znV3M6uFBcW/gKSH1iUacvC7WpRRYrxxVUo8/DO8YgQidHmtKPnlgadQmRUT6SUWAk
x-ms-office365-filtering-correlation-id: d9e2cd98-b003-42d2-fe30-08d6635ad44d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4391;
x-ms-traffictypediagnostic: BYAPR07MB4391:
x-microsoft-antispam-prvs: <BYAPR07MB4391164F216669661C801403DDA30@BYAPR07MB4391.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(93006095)(93001095)(10201501046)(3231475)(944501520)(52105112)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB4391;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4391;
x-forefront-prvs: 0888B1D284
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(346002)(39860400002)(396003)(199004)(189003)(36092001)(305945005)(6246003)(105586002)(478600001)(8676002)(107886003)(14454004)(53936002)(7736002)(71200400001)(71190400001)(9686003)(26005)(39060400002)(4326008)(2906002)(74316002)(476003)(186003)(99286004)(5660300001)(486006)(66066001)(86362001)(25786009)(81156014)(81166006)(7416002)(217873002)(55016002)(6436002)(3846002)(6116002)(229853002)(8936002)(68736007)(6506007)(14444005)(33656002)(76176011)(93886005)(106356001)(316002)(446003)(97736004)(102836004)(110136005)(11346002)(256004)(7696005)(54906003)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4391;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0gdG2mIvVmW4KM9F8iwIrV/jFHtJ79/cf4Ze0o9DWRO4mC6R2HrsOUXOKc3zy/K7MY3yAz6fNc5Swt11qrFu3jM2ANpeOiN1jTdW0TS+y0w3WBGkdzv4XbNlNegnAA98FAp0m9enHrAlpvEQiwOWJj91Y/pmJg5cj9BgZK0QHeN6Pi8UJXKHBRmfUj5UiniUrIbmqFd3yfm3IRVfrlf7nsqJbwH1S50QDqknp6ivo/n7YGn49rpYCLAnkhEwyTRhzVcMv57jdU3ZQ5j2fI+fYxT1g3l+kPIcmz9pufkc3rctTzmnorxlV3LSlzWyV9Us
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e2cd98-b003-42d2-fe30-08d6635ad44d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2018 13:31:47.7872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4391
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-16_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812160127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkNCg0KPg0KPk9uIDE0LzEyLzE4IDQ6NTYgUE0sIEZlbGlwZSBCYWxiaSB3cm90ZToNCj4+IEhp
LA0KPj4NCj4+IFNla2hhciBOb3JpIDxuc2VraGFyQHRpLmNvbT4gd3JpdGVzOg0KPj4+Pj4+Pj4g
QWxsIHRoaXMgc2hvdWxkIGJlIHBhcnQgb2YgY29tbWVudHMgaW4gY29kZSBhbG9uZyB3aXRoIGlu
Zm9ybWF0aW9uIGFib3V0DQo+Pj4+Pj4+PiBjb250cm9sbGVyIHZlcnNpb25zIHdoaWNoIHN1ZmZl
ciBmcm9tIHRoZSBlcnJhdGEuDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gSXMgdGhlcmUgYSB2ZXJzaW9u
IG9mIGNvbnRyb2xsZXIgYXZhaWxhYmxlIHdoaWNoIGRvZXMgbm90IGhhdmUgdGhlDQo+Pj4+Pj4+
PiBkZWZlY3Q/IElzIHRoZXJlIGEgZnV0dXJlIHBsYW4gdG8gZml4IHRoaXM/DQo+Pj4+Pj4+Pg0K
Pj4+Pj4+Pj4gSWYgYW55IG9mIHRoYXQgaXMgeWVzLCB5b3UgcHJvYmFibHkgd2FudCB0byBoYW5k
bGUgdGhpcyB3aXRoIHJ1bnRpbWUNCj4+Pj4+Pj4+IGRldGVjdGlvbiBvZiB2ZXJzaW9uIChsaWtl
IGRvbmUgd2l0aCBEV0MzX1JFVklTSU9OX1hYWCBtYWNyb3MpLg0KPj4+Pj4+Pj4gU29tZXRpbWVz
IHRoZSBoYXJkd2FyZS1yZWFkIHZlcnNpb25zIHRoZW1zZWx2ZXMgYXJlIGluY29ycmVjdCwgc28g
aXRzDQo+Pj4+Pj4+PiBiZXR0ZXIgdG8gaW50cm9kdWNlIGEgdmVyc2lvbiBzcGVjaWZpYyBjb21w
YXRpYmxlIHRvbyBsaWtlDQo+Pj4+Pj4+PiAiY2Rucyx1c2ItMS4wLjAiIChhcyBoaW50ZWQgdG8g
YnkgUm9iIEhlcnJpbmcgYXMgd2VsbCkuDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pg0KPj4+Pj4+PiBjdXN0
b20gbWF0Y2hfZXAgaXMgdXNlZCBhbmQgd29ya3Mgd2l0aCBhbGwgdmVyc2lvbnMgb2YgdGhlIGdl
bjENCj4+Pj4+Pj4gY29udHJvbGxlci4gRnV0dXJlIChnZW4yKSByZWxlYXNlcyBvZiB0aGUgY29u
dHJvbGxlciB3b27igJl0IGhhdmUgc3VjaA0KPj4+Pj4+PiBsaW1pdGF0aW9uIGJ1dCB0aGVyZSBp
cyBubyBwbGFuIHRvIGNoYW5nZSBjdXJyZW50IChnZW4xKSBmdW5jdGlvbmFsaXR5DQo+Pj4+Pj4+
IG9mIHRoZSBjb250cm9sbGVyLg0KPj4+Pj4+Pg0KPj4+Pj4+PiBJIHdpbGwgYWRkIGNvbW1lbnQg
YmVmb3JlIGNkbnMzX2dhZGdldF9tYXRjaF9lcCBmdW5jdGlvbi4NCj4+Pj4+Pj4gQWxzbyBJIHdp
bGwgY2hhbmdlIGNkbnMsdXNiMyB0byBjZG5zLHVzYjMtMS4wLjAgYW5kIGFkZCBhZGRpdGlvbmFs
DQo+Pj4+Pj4+IGNkbnMsdXNiMy0xLjAuMSBjb21wYXRpYmxlLg0KPj4+Pj4+Pg0KPj4+Pj4+PiBj
ZG5zLHVzYjMtMS4wLjEgd2lsbCBiZSBmb3IgY3VycmVudCB2ZXJzaW9uIG9mIGNvbnRyb2xsZXIg
d2hpY2ggSSB1c2UuDQo+Pj4+Pj4+IGNkbnMsdXNiMy0xLjAuMCB3aWxsIGJlIGZvciBvbGRlciB2
ZXJzaW9uIC0gUGV0ZXIgQ2hhbiBwbGF0Zm9ybS4NCj4+Pj4+Pj4gSSBub3cgdGhhdCBJIGhhdmUg
c29tZSBjaGFuZ2VzIGluIGNvbnRyb2xsZXIsIGFuZCBvbmUgb2YgdGhlbSByZXF1aXJlDQo+Pj4+
Pj4+IHNvbWUgY2hhbmdlcyBpbiBEUkQgZHJpdmVyLiBJdCB3aWxsIGJlIHNhZmVyIHRvIGFkZCB0
d28gc2VwYXJhdGUNCj4+Pj4+Pj4gdmVyc2lvbiBpbiBjb21wYXRpYmxlcy4NCj4+Pj4+Pj4NCj4+
Pj4+Pg0KPj4+Pj4+IFBhd2VsLCBjb3VsZCB3ZSBoYXZlIGNvcnJlY3QgcmVnaXN0ZXIgdG8gc2hv
dyBjb250cm9sbGVyIHZlcnNpb24/IEl0IGlzDQo+Pj4+Pj4gYmV0dGVyIHdlIGNvdWxkIHZlcnNp
b24ganVkZ2VtZW50IGF0IHJ1bnRpbWUgaW5zdGVhZCBvZiBzdGF0aWMgY29tcGF0aWJsZS4NCj4+
Pj4+DQo+Pj4+PiBBZ3JlZSB3aXRoIGRldGVjdGluZyBJUCB2ZXJzaW9uIGF0IHJ1bnRpbWUuDQo+
Pj4+Pg0KPj4+Pj4gQnV0IHBsZWFzZSBoYXZlIHNvbWUgaW5kaWNhdGlvbiBvZiB2ZXJzaW9uIGlu
IGNvbXBhdGlibGUgc3RyaW5nIHRvbywNCj4+Pj4NCj4+Pj4gd2h5PyBSdW50aW1lIGRldGVjdGlv
biBieSByZXZpc2lvbiByZWdpc3RlciBzaG91bGQgYmUgdGhlIHdheSB0byBnbyBpZg0KPj4+PiB0
aGUgSFcgcHJvdmlkZXMgaXQuIFdoeSBkdXBsaWNhdGUgdGhlIGluZm9ybWF0aW9uIGluIGNvbXBh
dGlibGUgc3RyaW5nPw0KPj4+Pg0KPj4+Pj4gZXNwZWNpYWxseSBzaW5jZSB5b3UgYWxyZWFkeSBr
bm93IHRoZXJlIGlzIGdvaW5nIHRvIGJlIGFub3RoZXIgcmV2aXNpb24NCj4+Pj4+IG9mIGhhcmR3
YXJlLiBJdCBoYXMgdGhlIGFkdmFudGFnZSB0aGF0IG9uZSBjYW4gZWFzaWx5IGdyZXAgdG8gc2Vl
IHdoaWNoDQo+Pj4+PiBoYXJkd2FyZSBpcyBydW5uaW5nIGN1cnJlbnQgdmVyc2lvbiBvZiBjb250
cm9sbGVyIHdpdGhvdXQgaGF2aW5nIGFjY2Vzcw0KPj4+Pj4gdG8gdGhlIGhhcmR3YXJlIGl0c2Vs
Zi4gQmVjb21lcyB1c2VmdWwgbGF0ZXIgb24gd2hlbiBpdHMgdGltZSB0bw0KPj4+Pj4gY2xlYW4t
dXAgdW51c2VkIGNvZGUgd2hlbiBib2FyZHMgYmVjb21lIG9ic29sZXRlIG9yIGZvciByZXF1ZXN0
aW5nDQo+Pj4+PiB0ZXN0aW5nIGhlbHAuDQo+Pj4+DQo+Pj4+IFRoaXMgZG9lc24ndCBzb3VuZCBs
aWtlIGEgdmVyeSBzdHJvbmcgYXJndW1lbnQsIGFjdHVhbGx5LiBTcGVjaWFsbHkgd2hlbg0KPj4+
PiB5b3UgY29uc2lkZXIgdGhhdCwgc2luY2UgZHJpdmVyIHdpbGwgZG8gcmV2aXNpb24gY2hlY2tp
bmcgYmFzZWQgb24NCj4+Pj4gcmV2aXNpb24gcmVnaXN0ZXIsIHlvdSBhbHJlYWR5IGhhdmUgc3Ry
aW5ncyB0byBncmVwLiBNb3Jlb3Zlciwgd2UgZG9uJ3QNCj4+Pj4gdXN1YWxseSBkcm9wIHN1cHBv
cnQganVzdCBsaWtlIHRoYXQuDQo+Pj4NCj4+PiBBRkFJQ1MsIGl0IGlzIGltcG9zc2libGUgdG8g
a25vdyBqdXN0IGJ5IGdyZXAnaW5nIGlmIHRoZXJlIGlzIGFueQ0KPj4+IGhhcmR3YXJlIHN0aWxs
IHN1cHBvcnRlZCBpbiBrZXJuZWwgYW5kIHVzaW5nIERXQzNfUkVWSVNJT05fMTk0QSwgZm9yDQo+
Pj4gZXhhbXBsZS4NCj4+DQo+PiBidXQgd2h5IGRvIHlvdSBldmVuIGNhcmU/DQo+DQo+V2hlbiwg
Zm9yIGV4YW1wbGUsIGl0cyBjb21pbmcgaW4gdGhlIHdheSBvZiBzb21lIGNsZWFuLXVwIEkgYW0N
Cj5hdHRlbXB0aW5nIHRvIGRvLg0KPg0KPj4NCj4+PiBJZiB3ZSBhcmUgbmV2ZXIgZ29pbmcgdG8g
ZHJvcCBzdXBwb3J0IGZvciBhbnkgcmV2aXNpb24sIHRoaXMgZG9lcyBub3QNCj4+PiBtYXR0ZXIg
bXVjaC4NCj4+Pg0KPj4+IEFsc28sIG9uY2UgeW91IGhhdmUgdGhlIGNvbnRyb2xsZXIgc3VwcG9y
dGVkIGJlaGluZCBQQ0ksIHRoZW4gSSBndWVzcw0KPj4+IHlvdSBhcmUgcHJldHR5IG11Y2ggdGll
ZCB0byBoYXZpbmcgdG8gcmVhZCBoYXJkd2FyZSByZXZpc2lvbiBhdCBydW50aW1lLg0KPj4NCj4+
IHRoYXQncyBhbm90aGVyIGFyZ3VtZW50ICpmb3IqIHVzaW5nIHJ1bnRpbWUgZGV0ZWN0aW9uLCBu
b3QgYWdhaW5zdCBpdC4NCj4NCj5JIGtub3cgOikuIEkgc2hvdWxkIGhhdmUgc3RhdGVkIHRoYXQg
aW4gbGFzdCBlLW1haWwgaXRzZWxmLCBJIGFtIG9rYXkNCj53aXRoIGp1c3QgcnVudGltZSBkZXRl
Y3Rpb24uDQoNCkkgYWdyZWUgd2l0aCB5b3UuIENvbnRyb2xsZXIgaGFzIHVzYl9jYXA2IHJlZ2lz
dGVyIHRoYXQga2VlcCANCmRldmljZSBjb250cm9sbGVyIHZlcnNpb24uIEl0J3Mgbm90IGEgcHJv
YmxlbSBkb2luZyBzdWNoIGRldGVjdGlvbg0KYXQgcnVudGltZS4gSSB3aWxsIGRvIGl0IGluIHRo
aXMgd2F5Lg0KDQpCdXQgYWxzbyBJIHdpbGwgYWRkIGV4dHJhIGNvbXBhdGlibGUgIHRvIGR0LWJp
bmRpbmcuIEV2ZW4gaWYgdGhpcyB3aWxsIG5vdCBiZSB1c2VkIA0KaW4gZHJpdmVyLCBpdCBpbmZv
cm1zIHRoYXQgdGhlcmUgYXJlIHNldmVyYWwgdmVyc2lvbnMgb2YgY29udHJvbGxlci4gDQoNClRo
YW5rcywNClBhd2VsDQo=
