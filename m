Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D30C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A869620872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="TscNQprq";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="ECO8wddC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbfAKGds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 01:33:48 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:40692 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725773AbfAKGds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 01:33:48 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0B6Uigm008525;
        Thu, 10 Jan 2019 22:33:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=NsmTbn2J+0WsAZnPH+wVQ9XEbNwGFh1swvmlb4osrqU=;
 b=TscNQprqHBmSv6WU3mWzbf2GwWqEBRjuR1LALuL9BSLcJ9M6LVCPiRNazvk0Tq9C/Rsb
 mcxXvvbhIkRRYMiSuyXCof2u7vbWeAdX5vC0tEV1XvJgVUP8vz+uII8TjNVpCQuG0cgP
 X0yb0rdpsHugCZtQypnrPdYu+BZZkZVux0bsyoKWPgARCc909FylSkaR//0Sr2wM3v3F
 RhsNoD+2GowNdTRQzjv7/ycE7kEoeujK5r6aBesSc37h9OnePlKXoIdTJMvT7GezhL5o
 t4101dKipPCx+YvXYbBISqtZpN9ue8dBjoyXI8hA8Gh0csuUxMe8BYdAh/e51T/wzWF4 2w== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2pxmx1rbf5-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 10 Jan 2019 22:33:34 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 10 Jan
 2019 22:33:33 -0800
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.58) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 10 Jan 2019 22:33:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsmTbn2J+0WsAZnPH+wVQ9XEbNwGFh1swvmlb4osrqU=;
 b=ECO8wddCONexInTvfjqRFCzEK6m2vRPmySssYFWRb+es8ojzXI0zXmMEvROPbUWT81QpBIqU0+0xxEJCDb5DGPmklqfQTr/ltqbhP6EEFZGlPsnbbbBvxso4u7ApZ5sdrMvbBRurYZcjPVIuWpUXa5Bnk7JwF3Cig9K3phAvSLk=
Received: from CY4PR18MB1253.namprd18.prod.outlook.com (10.172.176.11) by
 CY4PR18MB1640.namprd18.prod.outlook.com (10.173.64.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Fri, 11 Jan 2019 06:33:32 +0000
Received: from CY4PR18MB1253.namprd18.prod.outlook.com
 ([fe80::402d:1b84:1840:50ea]) by CY4PR18MB1253.namprd18.prod.outlook.com
 ([fe80::402d:1b84:1840:50ea%4]) with mapi id 15.20.1495.011; Fri, 11 Jan 2019
 06:33:32 +0000
From:   Sudarsana Reddy Kalluru <skalluru@marvell.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 12/41] scsi: bfa: bfa_ioc: Mark expected switch
 fall-throughs
Thread-Topic: [PATCH 12/41] scsi: bfa: bfa_ioc: Mark expected switch
 fall-throughs
Thread-Index: AQHUqSDNfDi1+IYsiUmzPnbPKrXIxKWpnNIA
Date:   Fri, 11 Jan 2019 06:33:32 +0000
Message-ID: <CY4PR18MB1253582A14CC764C4CF06592D3850@CY4PR18MB1253.namprd18.prod.outlook.com>
References: <cover.1543374820.git.gustavo@embeddedor.com>
 <520fb16cd3630d612c5768989e2ffa90f1a73f97.1543374820.git.gustavo@embeddedor.com>
 <b5f0c0bf-f671-65b0-dfed-39cefcd3fde1@embeddedor.com>
 <16aade69-ac0e-7d8c-0ffb-35564ee334cd@embeddedor.com>
In-Reply-To: <16aade69-ac0e-7d8c-0ffb-35564ee334cd@embeddedor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2402:3a80:53d:e7b:dda5:10df:c5f6:ce95]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR18MB1640;20:Brc/N+2pw+DP6Mc3SzgFBz5mu3jh2iqS+WAO+U6vIrYwgw2+PtoWMDJd1ve6GCEaYpn/QF+auXZMw1xHzozKs/5WUCAtTeZ1utUohY08JoSkKIQf7YiAp9cPNPiZAIPhRx0JRpLArPLkleNUbbNziX3lCpsxUnWfEUJn/c0ABtg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a04d7d65-9562-448f-2fe9-08d6778eb4dc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR18MB1640;
x-ms-traffictypediagnostic: CY4PR18MB1640:
x-microsoft-antispam-prvs: <CY4PR18MB1640C9AB670E361F9E170133D3850@CY4PR18MB1640.namprd18.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(39860400002)(366004)(199004)(189003)(13464003)(99286004)(81166006)(486006)(105586002)(86362001)(575784001)(81156014)(106356001)(8676002)(316002)(93886005)(53546011)(6436002)(305945005)(478600001)(6506007)(55016002)(7696005)(476003)(76176011)(186003)(71200400001)(229853002)(71190400001)(102836004)(7736002)(54906003)(110136005)(11346002)(46003)(8936002)(2906002)(14444005)(256004)(446003)(25786009)(6246003)(5660300001)(4326008)(68736007)(9686003)(14454004)(97736004)(53936002)(33656002)(74316002)(6116002)(485434002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR18MB1640;H:CY4PR18MB1253.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3Ktef3zPWJsFUvq8X3DWiXdteqpgZ3zJ2lz5d8G3F0UMB6gPhovV+tyshquA26qs0O1M157aWWH56DFKiI86CfXs+rzzH1avzYZHxompa4XwLbnql2avNgaBrk8xrYMNrhifpoqZQV4JbC0L+jXD5+zpQ9lc3hC4qIGdkkF7lLYY6p1KWAJkz2/mHdPkmb6Kvky+vNCWqMj4CVKoA5bMp4XBCEAtRDUu7Y1IJ1jHPlibyWW/2IMCJ6/bS66wTfD5epq6WUjRGcB6i2mRMPJzqZm4XjV+ZOMkgH5lHbXEURZIdQDkPTM5O1OY044yjXNuvTbWP0M+U7QccJrWdteF8vIj+eEa8MATHSTZLmPv9oroixABVmb/lv0utQ/rlmay1jsmo6+ElQKupHSrw+og0WYn9YUzr2I4P24orZZ3htE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a04d7d65-9562-448f-2fe9-08d6778eb4dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 06:33:32.2267
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

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBHdXN0YXZvIEEuIFIuIFNpbHZh
IFttYWlsdG86Z3VzdGF2b0BlbWJlZGRlZG9yLmNvbV0gDQpTZW50OiAxMSBKYW51YXJ5IDIwMTkg
MDE6NDENClRvOiBBbmlsIEd1cnVtdXJ0aHkgPGFuaWwuZ3VydW11cnRoeUBxbG9naWMuY29tPjsg
U3VkYXJzYW5hIEthbGx1cnUgPHN1ZGFyc2FuYS5rYWxsdXJ1QHFsb2dpYy5jb20+DQpDYzogSmFt
ZXMgRS5KLiBCb3R0b21sZXkgPGplamJAbGludXguaWJtLmNvbT47IE1hcnRpbiBLLiBQZXRlcnNl
biA8bWFydGluLnBldGVyc2VuQG9yYWNsZS5jb20+OyBsaW51eC1zY3NpQHZnZXIua2VybmVsLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSCAxMi80
MV0gc2NzaTogYmZhOiBiZmFfaW9jOiBNYXJrIGV4cGVjdGVkIHN3aXRjaCBmYWxsLXRocm91Z2hz
DQoNCkV4dGVybmFsIEVtYWlsDQoNCkhpLA0KDQpGcmllbmRseSBwaW5nIChzZWNvbmQgb25lKToN
Cg0KV2hvIGNhbiBhY2svcmV2aWV3L3Rha2UgdGhpcyBwYXRjaCwgcGxlYXNlPw0KDQpUaGFua3MN
Ci0tDQpHdXN0YXZvDQoNCk9uIDEyLzE5LzE4IDk6MzkgQU0sIEd1c3Rhdm8gQS4gUi4gU2lsdmEg
d3JvdGU6DQo+IEhpLA0KPg0KPiBGcmllbmRseSBwaW5nOg0KPg0KPiBXaG8gY2FuIGFjayBvciBy
ZXZpZXcgdGhpcyBwYXRjaCwgcGxlYXNlPw0KPg0KPiBUaGFua3MNCj4gLS0NCj4gR3VzdGF2bw0K
Pg0KPiBPbiAxMS8yNy8xOCAxMDoyNyBQTSwgR3VzdGF2byBBLiBSLiBTaWx2YSB3cm90ZToNCj4+
IEluIHByZXBhcmF0aW9uIHRvIGVuYWJsaW5nIC1XaW1wbGljaXQtZmFsbHRocm91Z2gsIG1hcmsg
c3dpdGNoIGNhc2VzIA0KPj4gd2hlcmUgd2UgYXJlIGV4cGVjdGluZyB0byBmYWxsIHRocm91Z2gu
DQo+Pg0KPj4gTm90aWNlIHRoYXQsIGluIHRoaXMgcGFydGljdWxhciBjYXNlLCBJIHJlcGxhY2Vk
ICIhISEgZmFsbCB0aHJvdWdoICEhISINCj4+IGNvbW1lbnQgd2l0aCAiZmFsbCB0aHJvdWdoIiBh
bm5vdGF0aW9ucywgd2hpY2ggaXMgd2hhdCBHQ0MgaXMgDQo+PiBleHBlY3RpbmcgdG8gZmluZC4N
Cj4+DQo+PiBBZGRyZXNzZXMtQ292ZXJpdHktSUQ6IDE0NjE1NSAoIk1pc3NpbmcgYnJlYWsgaW4g
c3dpdGNoIikNCj4+IFNpZ25lZC1vZmYtYnk6IEd1c3Rhdm8gQS4gUi4gU2lsdmEgPGd1c3Rhdm9A
ZW1iZWRkZWRvci5jb20+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9zY3NpL2JmYS9iZmFfaW9jLmMg
fCA5ICsrKy0tLS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA2IGRl
bGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kvYmZhL2JmYV9pb2Mu
YyBiL2RyaXZlcnMvc2NzaS9iZmEvYmZhX2lvYy5jIA0KPj4gaW5kZXggMTZkM2FlYjBlNTcyLi4z
MmIyNGU1MWNjZTYgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3Njc2kvYmZhL2JmYV9pb2MuYw0K
Pj4gKysrIGIvZHJpdmVycy9zY3NpL2JmYS9iZmFfaW9jLmMNCj4+IEBAIC05NzgsOSArOTc4LDcg
QEAgYmZhX2lvY3BmX3NtX2VuYWJsaW5nKHN0cnVjdCBiZmFfaW9jcGZfcyAqaW9jcGYsIGVudW0g
aW9jcGZfZXZlbnQgZXZlbnQpDQo+PiAgICAgICBjYXNlIElPQ1BGX0VfSU5JVEZBSUw6DQo+PiAg
ICAgICAgICAgYmZhX2lvY3BmX3RpbWVyX3N0b3AoaW9jKTsNCj4+IC0gICAgICAgIC8qDQo+PiAt
ICAgICAgICAgKiAhISEgZmFsbCB0aHJvdWdoICEhIQ0KPj4gLSAgICAgICAgICovDQo+PiArICAg
ICAgICAvKiBmYWxsIHRocm91Z2ggKi8NCj4+ICAgICAgIGNhc2UgSU9DUEZfRV9USU1FT1VUOg0K
Pj4gICAgICAgICAgIHdyaXRlbCgxLCBpb2MtPmlvY19yZWdzLmlvY19zZW1fcmVnKTsgQEAgLTEw
NTYsOSArMTA1NCw3IEBAIA0KPj4gYmZhX2lvY3BmX3NtX2Rpc2FibGluZyhzdHJ1Y3QgYmZhX2lv
Y3BmX3MgKmlvY3BmLCBlbnVtIGlvY3BmX2V2ZW50IGV2ZW50KQ0KPj4gICAgICAgY2FzZSBJT0NQ
Rl9FX0ZBSUw6DQo+PiAgICAgICAgICAgYmZhX2lvY3BmX3RpbWVyX3N0b3AoaW9jKTsNCj4+IC0g
ICAgICAgIC8qDQo+PiAtICAgICAgICAgKiAhISEgZmFsbCB0aHJvdWdoICEhIQ0KPj4gLSAgICAg
ICAgICovDQo+PiArICAgICAgICAvKiBmYWxsIHRocm91Z2ggKi8NCj4+ICAgICAgIGNhc2UgSU9D
UEZfRV9USU1FT1VUOg0KPj4gICAgICAgICAgIGJmYV9pb2Nfc2V0X2N1cl9pb2NfZndzdGF0ZShp
b2MsIEJGSV9JT0NfRkFJTCk7IEBAIC02MDA3LDYgDQo+PiArNjAwMyw3IEBAIGJmYV9kY29uZl9z
bV9maW5hbF9zeW5jKHN0cnVjdCBiZmFfZGNvbmZfbW9kX3MgKmRjb25mLA0KPj4gICAgICAgY2Fz
ZSBCRkFfRENPTkZfU01fSU9DRElTQUJMRToNCj4+ICAgICAgIGNhc2UgQkZBX0RDT05GX1NNX0ZM
QVNIX0NPTVA6DQo+PiAgICAgICAgICAgYmZhX3RpbWVyX3N0b3AoJmRjb25mLT50aW1lcik7DQo+
PiArICAgICAgICAvKiBmYWxsIHRocm91Z2ggKi8NCj4+ICAgICAgIGNhc2UgQkZBX0RDT05GX1NN
X1RJTUVPVVQ6DQo+PiAgICAgICAgICAgYmZhX3NtX3NldF9zdGF0ZShkY29uZiwgYmZhX2Rjb25m
X3NtX3VuaW5pdCk7DQo+PiAgICAgICAgICAgYmZhX2ZzbV9zZW5kX2V2ZW50KCZkY29uZi0+YmZh
LT5pb2NmYywgSU9DRkNfRV9EQ09ORl9ET05FKTsNCj4+DQoNCkFja2VkLWJ5OiBTdWRhcnNhbmEg
S2FsbHVydSA8U3VkYXJzYW5hLkthbGx1cnVAcWxvZ2ljLmNvbT4NCg==
