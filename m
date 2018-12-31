Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BDCC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 05:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08C520815
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 05:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="GU634q24";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="jyMku1kV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbeLaFfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 00:35:23 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:47506 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725949AbeLaFfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 00:35:22 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBV5YGDU006441;
        Sun, 30 Dec 2018 21:35:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=yE8b2nrdJV+ShroLPb/8ngSDzdazJE0GupHpleJDgPU=;
 b=GU634q246Cep5FlEOZ0GLc7vTAOVbdCEgC9AiY93czN0OQPVd1Kcp53luXAfflw4VlDm
 qul5bp4BK5iF0eW5j3dvToyuNp6+HlZguqpBL+ZCh0R8awXSjBC1kCa2lYCtK2rZAVDS
 PL9G5b3YpfqtrHzZ4nRucE7In0HzDkzDKPSMpFrKTaHnfOAqQHhwqTIZoA4dgeCZ/NXB
 b9WRCF9Xq+rY8c5fRUoYvh3hNqRFBJTCw8rylzW4t2GPkTRdBAa8aOvPwS8HrGEv9tZK
 luCYHy4Vsc/jWmwLQHRpr3oIl5PtDH0NXsnCRr5oWDanG+ocvhfQ6n1IRVLesglk7ILQ BA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2055.outbound.protection.outlook.com [104.47.49.55])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2pp5d1f69e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 30 Dec 2018 21:35:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yE8b2nrdJV+ShroLPb/8ngSDzdazJE0GupHpleJDgPU=;
 b=jyMku1kV8NSv7WaB4eFpMZ8C4UljHW638uZyxuwS6oAhB10d8sDZKpvicY/HI6/km9SivQBPQLRyK2Vv8r9w+soItun8uUjFAhCASR5ZclJ5KCpveUkPfPqNqVgo7BKZ220WxdNJ1h0uOQSFchtT11gyV3Qac6T2pa/y2zTgr1Y=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4520.namprd07.prod.outlook.com (52.135.225.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Mon, 31 Dec 2018 05:35:10 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e97e:1c66:94bc:24ef]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e97e:1c66:94bc:24ef%3]) with mapi id 15.20.1471.019; Mon, 31 Dec 2018
 05:35:10 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Rob Herring <robh@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alan Douglas <adouglas@cadence.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v1 1/2] dt-bindings: add binding for USBSS-DRD controller.
Thread-Topic: [PATCH v1 1/2] dt-bindings: add binding for USBSS-DRD
 controller.
Thread-Index: AQHUkIWR9ZZRuTwCZUuVYkxzeBHYYqWIHHaAgANGl2CAB8qggIAFRbsw
Date:   Mon, 31 Dec 2018 05:35:10 +0000
Message-ID: <BYAPR07MB470979D3175F510A552CC015DDB20@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1544445555-17325-1-git-send-email-pawell@cadence.com>
 <1544445555-17325-2-git-send-email-pawell@cadence.com>
 <20181220200111.GA27998@bogus>
 <BYAPR07MB4709910A6EE4B54BA455E713DDB90@BYAPR07MB4709.namprd07.prod.outlook.com>
 <CAL_JsqLQ83f74kMRsRX=Bo+xwP05v+2dLQaPLVV3EU7k=QwvSQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLQ83f74kMRsRX=Bo+xwP05v+2dLQaPLVV3EU7k=QwvSQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZDQ3NDNlODUtMGNiZC0xMWU5LTg3MjktMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGQ0NzQzZTg3LTBjYmQtMTFlOS04NzI5LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iODc4IiB0PSIxMzE5MDcwODEwODU1OTc4NTQiIGg9IkxWNUZ4ZXVCOHIxMlRvNzlpSkpCb294Znovdz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4520;20:nFK2E4uXWphKgCj770ifvGASQzlXJlDMmsdE+ss7RyJhjbGfSAQ/zcPuyTA1VAZSeALMgRmMUGKMSCLMbGfWEccD8f90NYMjt46DN9hEYp/d9pSB9cG6TtKJ1b53OsR1oPJmeItv5UbFslarG0Tj9NIAu16rr9oZ0edS/O2w5hm8l6cJvvzAq9VZzRQiWTXmCXp/n3PdAp6V3/RRF8iNBzHw2DVZSAcgJZvbx6g41XFm7rEdZ5PwhLcR+wSvc2LX
x-ms-office365-filtering-correlation-id: 55d477cd-8561-4612-be84-08d66ee1bb0c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4520;
x-ms-traffictypediagnostic: BYAPR07MB4520:
x-microsoft-antispam-prvs: <BYAPR07MB4520A5F926DC17F06BD5921EDDB20@BYAPR07MB4520.namprd07.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220055)(2401047)(8121501046)(3002001)(3231475)(944501520)(52105112)(10201501046)(93006095)(93001095)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB4520;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4520;
x-forefront-prvs: 0903DD1D85
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(396003)(366004)(136003)(376002)(346002)(189003)(199004)(51914003)(36092001)(8936002)(14454004)(7736002)(99286004)(54906003)(316002)(478600001)(3846002)(7416002)(229853002)(305945005)(25786009)(6116002)(9686003)(81156014)(2906002)(74316002)(81166006)(8676002)(86362001)(6916009)(55016002)(5660300001)(53936002)(68736007)(107886003)(6436002)(106356001)(6246003)(486006)(7696005)(102836004)(4326008)(66066001)(476003)(6506007)(26005)(11346002)(76176011)(446003)(256004)(71190400001)(93886005)(71200400001)(33656002)(105586002)(97736004)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4520;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: m0k3YVq+tItO/Ve4i4TQcLYR9DVcOFsBlgQTCQkR7n71QmlVHunlf9o5BOMxhYqR1P7qDxCzf1ckU3PhPsdw7pIwhZUoPeWlLkXskpvQ1FQeBWdR0OUXGUoijnq6QzrwtfGMRMia0p5w9Piyu+bSrlNbjjXWkkQEybJ5wTNcCgK6CinyOV53JeOCZAM4Mk7tNUZtpSPLbPqOe23xORkbKqnzg5CI8S+woKk7jYnOCp7Nkr11fAykW4wTiPeN027jIjeDXmMsf/SjlBhyKvu+FAcxlA9o16lVPPFHXokbfFd9J7JiEeyKxm8tGUygbxU6
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d477cd-8561-4612-be84-08d66ee1bb0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2018 05:35:10.2243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4520
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-31_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812310051
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQm9iLA0KPj4NCj4+ID5PbiBNb24sIERlYyAxMCwgMjAxOCBhdCAxMjozOToxNFBNICswMDAw
LCBQYXdlbCBMYXN6Y3phayB3cm90ZToNCj4+ID4+IFRoaXMgcGF0Y2ggYWltIGF0IGRvY3VtZW50
aW5nIFVTQiByZWxhdGVkIGR0LWJpbmRpbmdzIGZvciB0aGUNCj4+ID4+IENhZGVuY2UgVVNCU1Mt
RFJEIGNvbnRyb2xsZXIuDQo+PiA+Pg0KPj4gPj4gU2lnbmVkLW9mZi1ieTogUGF3ZWwgTGFzemN6
YWsgPHBhd2VsbEBjYWRlbmNlLmNvbT4NCj4NCj5bLi4uXQ0KPg0KPj4gPj4gKyAtIHBoeXM6IHJl
ZmVyZW5jZSB0byB0aGUgVVNCIFBIWQ0KPj4gPj4gKyAtIHBoeS1uYW1lczogbmFtZSBvZiB0aGUg
VVNCIFBIWSwgc2hvdWxkIGJlICJjZG5zMyx1c2JwaHkiDQo+PiA+DQo+PiA+RG9uJ3QgbmVlZCAt
bmFtZXMgd2hlbiB0aGVyZSBpcyBvbmx5IG9uZS4NCj4+DQo+PiBCdXQgaW4gdGhlIGZ1dHVyZSBw
cm9iYWJseSB3ZSB3aWxsIG5lZWQgdG8gYWRkIG5leHQgcGh5IHZlcnNpb24uDQo+PiBTbyBtYXli
ZSBpdCdzIGJldHRlciB0byBsZWF2ZSB0aGlzIG5hbWUgPw0KPg0KPictbmFtZXMnIGFyZSBmb3Ig
d2hlbiB0aGVyZSBpcyBtb3JlIHRoYW4gb25lIHBoeSBjb25uZWN0ZWQsIG5vdA0KPmRpZmZlcmVu
dCBwaHkgdmVyc2lvbnMuIEZvciBleGFtcGxlLCBpZiB5b3UgaGFkIHNlcGFyYXRlIHBoeXMgZm9y
IEhTDQo+YW5kIFNTLg0KPg0KDQpUaGFua3MgZm9yIHRoZSBjbGFyaWZpY2F0aW9uLg0KSSB3aWxs
IHJlbW92ZSAgIi1uYW1lcyIgDQoNCkNoZWVycywNClBhd2VsDQo=
