Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73951C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF6720872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="DhEVXHY6";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="XmBNlMLs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbfAKGeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 01:34:08 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:40906 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728462AbfAKGeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 01:34:07 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0B6UiGF008514;
        Thu, 10 Jan 2019 22:33:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=AMFFFaVZ9Uex+nAfNs+B/VMOrBJBWrMSYuwSz+uW0sw=;
 b=DhEVXHY6BGnBFA/+Bq5MBML7RyabN2lgRvdehmnmMGXK87rIce+IfyyFcrAfdMetQSva
 U7v+xItvMKvwDOX8RT0Sq7r4Up5Mp6yStsE0/W9lRh3vXgB3KGbcNd4bFxfQA+6ME9N3
 TqV5HYPhFY1wjvLeARctjiFft5lC0YSCl2A6g5hkMXP/BIa/5qCbeCK49dy5tjQI7JG2
 pmp3gNdLpOU/oihPmn0XK9Jc3pA5EgFElcgmh015ZWTVMyKdqjBg4m2JRYx1PMJzfsYK
 vRaE0QHnKgvXAQIcUpU0jn0T78WZy5Yw4k/BMi0x3Ou0fmKfaWafxxTG8AVZFOY3rbbS 9Q== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2pxmx1rbfv-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 10 Jan 2019 22:33:52 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 10 Jan
 2019 22:33:51 -0800
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.52) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 10 Jan 2019 22:33:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMFFFaVZ9Uex+nAfNs+B/VMOrBJBWrMSYuwSz+uW0sw=;
 b=XmBNlMLsr9QcdHyzW79CDdJ1XK00ZmZPTneV1MguZOEEFYJIvcyyrl3Hfd5D4VrKLd9M5H3BEJwJ19Wd1tq+wqd1+NTOINATZVGWr1pixblRij4YNxti0Y0BNytYVVCorR1K4MIOr6Nwh1wJcKzzgOXFF7dJxclx1o2XTkcyH4E=
Received: from CY4PR18MB1253.namprd18.prod.outlook.com (10.172.176.11) by
 CY4PR18MB1640.namprd18.prod.outlook.com (10.173.64.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Fri, 11 Jan 2019 06:33:49 +0000
Received: from CY4PR18MB1253.namprd18.prod.outlook.com
 ([fe80::402d:1b84:1840:50ea]) by CY4PR18MB1253.namprd18.prod.outlook.com
 ([fe80::402d:1b84:1840:50ea%4]) with mapi id 15.20.1495.011; Fri, 11 Jan 2019
 06:33:49 +0000
From:   Sudarsana Reddy Kalluru <skalluru@marvell.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 11/41] scsi: bfa: bfa_fcs_rport: Mark expected switch
 fall-throughs
Thread-Topic: [PATCH 11/41] scsi: bfa: bfa_fcs_rport: Mark expected switch
 fall-throughs
Thread-Index: AQHUqSDJk2GnOenvzUOVom2FFb0k+qWpnOVQ
Date:   Fri, 11 Jan 2019 06:33:49 +0000
Message-ID: <CY4PR18MB1253DEBBCC169C26445F14F6D3850@CY4PR18MB1253.namprd18.prod.outlook.com>
References: <cover.1543374820.git.gustavo@embeddedor.com>
 <c2a6667094f80fd7f72c887b2e7844b6341ce961.1543374820.git.gustavo@embeddedor.com>
 <d81468df-1de5-8aaf-9c7b-ce490a358bea@embeddedor.com>
 <b20da67e-578a-341e-bb7c-d79fe096b573@embeddedor.com>
In-Reply-To: <b20da67e-578a-341e-bb7c-d79fe096b573@embeddedor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2402:3a80:53d:e7b:dda5:10df:c5f6:ce95]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR18MB1640;20:46/zRL4CRF3/3nGbrOk2xa6ptfGjWrOgdQn62bWf/SJQyM8HV7ZE3ZWqw1UXc+3CfqwTQHeEQJwexeNET7RrAh44iys+JVtc9ed3vp2e8bgPAyd+DR9MT51bBZyEQyAG/EpvA8Gb4IiHJsqydVT0zf/TIQEAcbE2+QGaRFtxuD8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 48908215-d0c2-4849-ed8f-08d6778ebf52
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR18MB1640;
x-ms-traffictypediagnostic: CY4PR18MB1640:
x-microsoft-antispam-prvs: <CY4PR18MB1640E58E0E77861E52A0D002D3850@CY4PR18MB1640.namprd18.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(39860400002)(366004)(199004)(189003)(13464003)(99286004)(81166006)(486006)(105586002)(86362001)(81156014)(106356001)(8676002)(316002)(93886005)(53546011)(6436002)(305945005)(478600001)(6506007)(55016002)(7696005)(476003)(76176011)(186003)(71200400001)(229853002)(71190400001)(102836004)(7736002)(54906003)(110136005)(11346002)(46003)(8936002)(2906002)(14444005)(256004)(446003)(25786009)(6246003)(5660300001)(4326008)(68736007)(9686003)(14454004)(97736004)(53936002)(33656002)(74316002)(6116002)(485434002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR18MB1640;H:CY4PR18MB1253.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: D1JGjHlv25iGc3c06JIG4A3HMaBJoegSw64jK6yjyD0NtvzGnffeunmXnvJov8jk1r7mKEdbXCN6+hXVwf8+KMXH7fpuvtMZP/p//q59EtUcMa4FKmx2LIL6BzZztixrTjQq9XJ4abcP5M0mKab3BzbPLHGcD6wbzgdVH5teFYidC4I4I0ka7foXSqsroD58kQ07MvfMFqRJDF6m86C2ONuHvZtNTB6nvD0SYagNcYiJPvEHr1jWDEfu+5AVfhyr3dfITZuoULP/q567l/2G2mlnk8J+iidXk2d0wqOfPo6zZMwCFSou43+t3iPqTD/58fCOxH8Du1pzYj/7yqf6DCjN88Zp6qVJxVBw2h/24/ik3z0Pc5ocyZpZIDuuYu4CMm/NfwDk/pdYMEYX3IdyYjbj9uIa2307W/yR+P7/zyc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 48908215-d0c2-4849-ed8f-08d6778ebf52
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 06:33:49.7354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB1640
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-11_04:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901110055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogR3VzdGF2byBBLiBSLiBTaWx2YSBb
bWFpbHRvOmd1c3Rhdm9AZW1iZWRkZWRvci5jb21dIA0KU2VudDogMTEgSmFudWFyeSAyMDE5IDAx
OjQyDQpUbzogQW5pbCBHdXJ1bXVydGh5IDxhbmlsLmd1cnVtdXJ0aHlAcWxvZ2ljLmNvbT47IFN1
ZGFyc2FuYSBLYWxsdXJ1IDxzdWRhcnNhbmEua2FsbHVydUBxbG9naWMuY29tPg0KQ2M6IEphbWVz
IEUuSi4gQm90dG9tbGV5IDxqZWpiQGxpbnV4LmlibS5jb20+OyBNYXJ0aW4gSy4gUGV0ZXJzZW4g
PG1hcnRpbi5wZXRlcnNlbkBvcmFjbGUuY29tPjsgbGludXgtc2NzaUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0ggMTEvNDFd
IHNjc2k6IGJmYTogYmZhX2Zjc19ycG9ydDogTWFyayBleHBlY3RlZCBzd2l0Y2ggZmFsbC10aHJv
dWdocw0KDQpFeHRlcm5hbCBFbWFpbA0KDQpIaSwNCg0KRnJpZW5kbHkgcGluZyAoc2Vjb25kIG9u
ZSk6DQoNCldobyBjYW4gYWNrL3Jldmlldy90YWtlIHRoaXMgcGF0Y2gsIHBsZWFzZT8NCg0KVGhh
bmtzDQotLQ0KR3VzdGF2bw0KDQpPbiAxMi8xOS8xOCA5OjM5IEFNLCBHdXN0YXZvIEEuIFIuIFNp
bHZhIHdyb3RlOg0KPiBIaSwNCj4NCj4gRnJpZW5kbHkgcGluZzoNCj4NCj4gV2hvIGNhbiBhY2sg
b3IgcmV2aWV3IHRoaXMgcGF0Y2gsIHBsZWFzZT8NCj4NCj4gVGhhbmtzDQo+IC0tDQo+IEd1c3Rh
dm8NCj4NCj4gT24gMTEvMjcvMTggMTA6MjcgUE0sIEd1c3Rhdm8gQS4gUi4gU2lsdmEgd3JvdGU6
DQo+PiBJbiBwcmVwYXJhdGlvbiB0byBlbmFibGluZyAtV2ltcGxpY2l0LWZhbGx0aHJvdWdoLCBt
YXJrIHN3aXRjaCBjYXNlcyANCj4+IHdoZXJlIHdlIGFyZSBleHBlY3RpbmcgdG8gZmFsbCB0aHJv
dWdoLg0KPj4NCj4+IE5vdGljZSB0aGF0IEkgcmVwbGFjZWQgIiEhIGZhbGwgdGhyb3VnaCAhISIg
YW5kICIhISEgZmFsbCB0aHJvdWdoICEhISINCj4+IGNvbW1lbnRzIHdpdGggImZhbGwgdGhyb3Vn
aCIgYW5ub3RhdGlvbnMsIHdoaWNoIGlzIHdoYXQgR0NDIGlzIA0KPj4gZXhwZWN0aW5nIHRvIGZp
bmQuDQo+Pg0KPj4gQWRkcmVzc2VzLUNvdmVyaXR5LUlEOiA3NDQ4OTkgKCJNaXNzaW5nIGJyZWFr
IGluIHN3aXRjaCIpDQo+PiBBZGRyZXNzZXMtQ292ZXJpdHktSUQ6IDc0NDkwMCAoIk1pc3Npbmcg
YnJlYWsgaW4gc3dpdGNoIikNCj4+IEFkZHJlc3Nlcy1Db3Zlcml0eS1JRDogNzQ0OTAxICgiTWlz
c2luZyBicmVhayBpbiBzd2l0Y2giKQ0KPj4gU2lnbmVkLW9mZi1ieTogR3VzdGF2byBBLiBSLiBT
aWx2YSA8Z3VzdGF2b0BlbWJlZGRlZG9yLmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL3Njc2kv
YmZhL2JmYV9mY3NfcnBvcnQuYyB8IDE5ICsrKysrKystLS0tLS0tLS0tLS0NCj4+ICAgMSBmaWxl
IGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvc2NzaS9iZmEvYmZhX2Zjc19ycG9ydC5jIA0KPj4gYi9kcml2ZXJzL3Nj
c2kvYmZhL2JmYV9mY3NfcnBvcnQuYw0KPj4gaW5kZXggZGU1MDM0OWEzOWNlLi4xZTQwMGYyYWFl
Y2UgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3Njc2kvYmZhL2JmYV9mY3NfcnBvcnQuYw0KPj4g
KysrIGIvZHJpdmVycy9zY3NpL2JmYS9iZmFfZmNzX3Jwb3J0LmMNCj4+IEBAIC00MjcsMTcgKzQy
NywxMyBAQCBiZmFfZmNzX3Jwb3J0X3NtX3Bsb2dpKHN0cnVjdCBiZmFfZmNzX3Jwb3J0X3MgKnJw
b3J0LCBlbnVtIHJwb3J0X2V2ZW50IGV2ZW50KQ0KPj4gICAgICAgY2FzZSBSUFNNX0VWRU5UX0xP
R09fUkNWRDoNCj4+ICAgICAgICAgICBiZmFfZmNzX3Jwb3J0X3NlbmRfbG9nb19hY2MocnBvcnQp
Ow0KPj4gLSAgICAgICAgLyoNCj4+IC0gICAgICAgICAqICEhIGZhbGwgdGhyb3VnaCAhIQ0KPj4g
LSAgICAgICAgICovDQo+PiArICAgICAgICAvKiBmYWxsIHRocm91Z2ggKi8NCj4+ICAgICAgIGNh
c2UgUlBTTV9FVkVOVF9QUkxPX1JDVkQ6DQo+PiAgICAgICAgICAgaWYgKHJwb3J0LT5wcmxvID09
IEJGQV9UUlVFKQ0KPj4gICAgICAgICAgICAgICBiZmFfZmNzX3Jwb3J0X3NlbmRfcHJsb19hY2Mo
cnBvcnQpOw0KPj4gICAgICAgICAgIGJmYV9mY3hwX2Rpc2NhcmQocnBvcnQtPmZjeHApOw0KPj4g
LSAgICAgICAgLyoNCj4+IC0gICAgICAgICAqICEhIGZhbGwgdGhyb3VnaCAhIQ0KPj4gLSAgICAg
ICAgICovDQo+PiArICAgICAgICAvKiBmYWxsIHRocm91Z2ggKi8NCj4+ICAgICAgIGNhc2UgUlBT
TV9FVkVOVF9GQUlMRUQ6DQo+PiAgICAgICAgICAgaWYgKHJwb3J0LT5wbG9naV9yZXRyaWVzIDwg
QkZBX0ZDU19SUE9SVF9NQVhfUkVUUklFUykgew0KPj4gICAgICAgICAgICAgICBycG9ydC0+cGxv
Z2lfcmV0cmllcysrOyBAQCAtODY4LDkgKzg2NCw3IEBAIA0KPj4gYmZhX2Zjc19ycG9ydF9zbV9h
ZGlzY19vbmxpbmUoc3RydWN0IGJmYV9mY3NfcnBvcnRfcyAqcnBvcnQsDQo+PiAgICAgICAgICAg
ICogQXQgbGVhc3QgZ28gb2ZmbGluZSB3aGVuIGEgUExPR0kgaXMgcmVjZWl2ZWQuDQo+PiAgICAg
ICAgICAgICovDQo+PiAgICAgICAgICAgYmZhX2ZjeHBfZGlzY2FyZChycG9ydC0+ZmN4cCk7DQo+
PiAtICAgICAgICAvKg0KPj4gLSAgICAgICAgICogISEhIGZhbGwgdGhyb3VnaCAhISENCj4+IC0g
ICAgICAgICAqLw0KPj4gKyAgICAgICAgLyogZmFsbCB0aHJvdWdoICovDQo+PiAgICAgICBjYXNl
IFJQU01fRVZFTlRfRkFJTEVEOg0KPj4gICAgICAgY2FzZSBSUFNNX0VWRU5UX0FERFJFU1NfQ0hB
TkdFOg0KPj4gQEAgLTEwNTYsNiArMTA1MCw3IEBAIGJmYV9mY3NfcnBvcnRfc21fZmM0X2xvZ29z
ZW5kKHN0cnVjdCBiZmFfZmNzX3Jwb3J0X3MgKnJwb3J0LA0KPj4gICAgICAgY2FzZSBSUFNNX0VW
RU5UX0xPR09fUkNWRDoNCj4+ICAgICAgICAgICBiZmFfZmNzX3Jwb3J0X3NlbmRfbG9nb19hY2Mo
cnBvcnQpOw0KPj4gKyAgICAgICAgLyogZmFsbCB0aHJvdWdoICovDQo+PiAgICAgICBjYXNlIFJQ
U01fRVZFTlRfUFJMT19SQ1ZEOg0KPj4gICAgICAgICAgIGlmIChycG9ydC0+cHJsbyA9PSBCRkFf
VFJVRSkNCj4+ICAgICAgICAgICAgICAgYmZhX2Zjc19ycG9ydF9zZW5kX3BybG9fYWNjKHJwb3J0
KTsNCj4+IEBAIC0xMTQ0LDkgKzExMzksNyBAQCBiZmFfZmNzX3Jwb3J0X3NtX2hjYl9vZmZsaW5l
KHN0cnVjdCBiZmFfZmNzX3Jwb3J0X3MgKnJwb3J0LA0KPj4gICAgICAgICAgICAgICBiZmFfZmNz
X3Jwb3J0X3NlbmRfcGxvZ2lhY2MocnBvcnQsIE5VTEwpOw0KPj4gICAgICAgICAgICAgICBicmVh
azsNCj4+ICAgICAgICAgICB9DQo+PiAtICAgICAgICAvKg0KPj4gLSAgICAgICAgICogISEgZmFs
bCB0aHJvdWdoICEhDQo+PiAtICAgICAgICAgKi8NCj4+ICsgICAgICAgIC8qIGZhbGwgdGhyb3Vn
aCAqLw0KPj4gICAgICAgY2FzZSBSUFNNX0VWRU5UX0FERFJFU1NfQ0hBTkdFOg0KPj4gICAgICAg
ICAgIGlmICghYmZhX2Zjc19scG9ydF9pc19vbmxpbmUocnBvcnQtPnBvcnQpKSB7IEBAIC0xMzAz
LDYgDQo+PiArMTI5Niw3IEBAIGJmYV9mY3NfcnBvcnRfc21faGNiX2xvZ29zZW5kKHN0cnVjdCBi
ZmFfZmNzX3Jwb3J0X3MgKnJwb3J0LA0KPj4gICAgICAgY2FzZSBSUFNNX0VWRU5UX0xPR09fUkNW
RDoNCj4+ICAgICAgICAgICBiZmFfZmNzX3Jwb3J0X3NlbmRfbG9nb19hY2MocnBvcnQpOw0KPj4g
KyAgICAgICAgLyogZmFsbCB0aHJvdWdoICovDQo+PiAgICAgICBjYXNlIFJQU01fRVZFTlRfUFJM
T19SQ1ZEOg0KPj4gICAgICAgICAgIGlmIChycG9ydC0+cHJsbyA9PSBCRkFfVFJVRSkNCj4+ICAg
ICAgICAgICAgICAgYmZhX2Zjc19ycG9ydF9zZW5kX3BybG9fYWNjKHJwb3J0KTsNCj4+IEBAIC0x
MzQ2LDYgKzEzNDAsNyBAQCBiZmFfZmNzX3Jwb3J0X3NtX2xvZ29fc2VuZGluZyhzdHJ1Y3QgYmZh
X2Zjc19ycG9ydF9zICpycG9ydCwNCj4+ICAgICAgIGNhc2UgUlBTTV9FVkVOVF9MT0dPX1JDVkQ6
DQo+PiAgICAgICAgICAgYmZhX2Zjc19ycG9ydF9zZW5kX2xvZ29fYWNjKHJwb3J0KTsNCj4+ICsg
ICAgICAgIC8qIGZhbGwgdGhyb3VnaCAqLw0KPj4gICAgICAgY2FzZSBSUFNNX0VWRU5UX1BSTE9f
UkNWRDoNCj4+ICAgICAgICAgICBpZiAocnBvcnQtPnBybG8gPT0gQkZBX1RSVUUpDQo+PiAgICAg
ICAgICAgICAgIGJmYV9mY3NfcnBvcnRfc2VuZF9wcmxvX2FjYyhycG9ydCk7DQo+Pg0KDQpBY2tl
ZC1ieTogU3VkYXJzYW5hIEthbGx1cnUgPFN1ZGFyc2FuYS5LYWxsdXJ1QHFsb2dpYy5jb20+DQo=
