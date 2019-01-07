Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6ED6C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1302147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Xm1v+YQo";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="iTUFDZZ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfAGLB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 06:01:29 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:46574 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726849AbfAGLB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 06:01:28 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x07AtB1w010068;
        Mon, 7 Jan 2019 03:01:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=5i/+9zBcMckA5fMSQVu4eKR9nlM1/LSTCUPrKyFBquk=;
 b=Xm1v+YQoTHD+0Kxufm/gCdG8KlPuagHdt+D5xQt/xcJ4P/nC8LuRSB+uaFg9uhyiRM93
 6RtIcoKkqWfa0zuJbOhgh8TtjgeOHPyFdHbd86yuWs+sxmJfIq6nymy/gnzcWiFF480o
 XTRHUPizxX+hDnEQ+vaVIr4EJX1ELW5uk2oNQuATGRz/Dbg+I02C02ntam4DzuTiBBYC
 9j0y9YvGz1zD9vqES9PkWCRmwMPoXyDQFV98tuaM+Yla0YV/jDtG8VW0YBgksp9+0rZZ
 89/cYYJ3TKSHl/0xALykJtaZhOawsjB2B8xgyQdv7xJV21UcFFnrsVrxtnMU2QM+A5Xl vA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2pv58sr1n2-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 07 Jan 2019 03:01:21 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 7 Jan
 2019 03:01:20 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.55) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 7 Jan 2019 03:01:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5i/+9zBcMckA5fMSQVu4eKR9nlM1/LSTCUPrKyFBquk=;
 b=iTUFDZZ91tlSO27eQLDQdxSrQHIblPhsvwqaXI9807VHxUO6co6cjWSE2huomCJ/ME/2ElVmNeHBE/bSt/zZAE/9LDbD9WgWz0epbxrWwFIqhTvNNOx+GL9Ay5kjfqNw31qx+LmliKhcLlt1n83d8hpyMgTqe7WBHofVK14ReTU=
Received: from DM5PR18MB2134.namprd18.prod.outlook.com (52.132.143.31) by
 DM5PR18MB1625.namprd18.prod.outlook.com (10.175.224.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Mon, 7 Jan 2019 11:01:19 +0000
Received: from DM5PR18MB2134.namprd18.prod.outlook.com
 ([fe80::20ab:c3dc:2700:faf4]) by DM5PR18MB2134.namprd18.prod.outlook.com
 ([fe80::20ab:c3dc:2700:faf4%4]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 11:01:19 +0000
From:   Manish Rangankar <mrangankar@marvell.com>
To:     Colin King <colin.king@canonical.com>,
        "QLogic-Storage-Upstream@qlogic.com" 
        <QLogic-Storage-Upstream@qlogic.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH] scsi: bnx2i: fix indentation issue, remove a tab
Thread-Topic: [EXT] [PATCH] scsi: bnx2i: fix indentation issue, remove a tab
Thread-Index: AQHUpE9MHlLdamuo/0yjyj+MziVXaKWjp96A
Date:   Mon, 7 Jan 2019 11:01:19 +0000
Message-ID: <DM5PR18MB2134A42C00C81B9C2168AAEFD8890@DM5PR18MB2134.namprd18.prod.outlook.com>
References: <20190104170224.8147-1-colin.king@canonical.com>
In-Reply-To: <20190104170224.8147-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [116.75.181.57]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR18MB1625;20:Ei5JpAKbvKzrnspNK6h2S9i7F1r6H0N8QujzgBPKIIDT73jooBhZ9nJplOr6Ugr9Pao4KueJQP2avi+AE3yHz4mYVq/B18tEkVtgiathjgAhYULGuscFa7FhXYhaGvYGoastzG3Y84WpEtxmHQLDbWYQMAATXfwMAWU3JJTFOM4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d663284e-0972-4d3c-c79f-08d6748f73d9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR18MB1625;
x-ms-traffictypediagnostic: DM5PR18MB1625:
x-microsoft-antispam-prvs: <DM5PR18MB162536A28040B828DABDA620D8890@DM5PR18MB1625.namprd18.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DM5PR18MB1625;BCL:0;PCL:0;RULEID:;SRVR:DM5PR18MB1625;
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(366004)(39860400002)(189003)(199004)(13464003)(33656002)(106356001)(105586002)(66066001)(14444005)(71200400001)(71190400001)(5660300001)(446003)(486006)(68736007)(6116002)(3846002)(74316002)(2906002)(476003)(11346002)(110136005)(186003)(55016002)(9686003)(76176011)(316002)(55236004)(256004)(54906003)(102836004)(6506007)(7696005)(53546011)(26005)(53936002)(478600001)(2501003)(8676002)(81156014)(81166006)(8936002)(7736002)(99286004)(305945005)(229853002)(25786009)(6436002)(14454004)(97736004)(6246003)(4326008)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR18MB1625;H:DM5PR18MB2134.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Cs3mrG/RqeMbrWC2f/0gtgGDgi3u+B0SsU4ZpQ6f8dI6P+zbmGk6ch0PXsFZM8H7ceFTaxvTgfVEoULyC5DMygLFWOh386uEzAvgxXxBoAdVZy3jPYqs+P2ZqZt+ZxVT4BrZ6UyA8Wbjji9w18LMACssoZ4ix3fZu3eUTV8rwHu6/xSTOLcpaQqdvv3hDQJTtC/wOYqG6KN+BDIia26Yn7Yj0FAtb+VWu5INsp4WtBvaTiqR8e3vA82MYv7IO08r6VI8Esr1YfSO+iUkwY3v6hCTJLmmrnu2ym5ktK9sB7fEkpAcipwXoKbXejnxk5zB
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d663284e-0972-4d3c-c79f-08d6748f73d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 11:01:19.1207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB1625
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-07_04:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901070098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDb2xpbiBLaW5nIDxjb2xpbi5r
aW5nQGNhbm9uaWNhbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgSmFudWFyeSA0LCAyMDE5IDEwOjMy
IFBNDQo+IFRvOiBRTG9naWMtU3RvcmFnZS1VcHN0cmVhbUBxbG9naWMuY29tOyBKYW1lcyBFIC4g
SiAuIEJvdHRvbWxleQ0KPiA8amVqYkBsaW51eC5pYm0uY29tPjsgTWFydGluIEsgLiBQZXRlcnNl
biA8bWFydGluLnBldGVyc2VuQG9yYWNsZS5jb20+Ow0KPiBsaW51eC1zY3NpQHZnZXIua2VybmVs
Lm9yZw0KPiBDYzoga2VybmVsLWphbml0b3JzQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbRVhUXSBbUEFUQ0hdIHNjc2k6IGJueDJpOiBm
aXggaW5kZW50YXRpb24gaXNzdWUsIHJlbW92ZSBhIHRhYg0KPiANCj4gRXh0ZXJuYWwgRW1haWwN
Cj4gDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gRXh0ZXJuYWwgRW1haWwNCj4gDQo+IEZyb206IENvbGlu
IElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+DQo+IA0KPiBUaGUgcmV0dXJuIHN0
YXRlbWVudCBpcyBpbmRlbnRlZCBpbmNvcnJlY3RseSwgZml4IHRoaXMgYnkgcmVtb3ZpbmcgYSBz
aW5nbGUgdGFiLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtp
bmdAY2Fub25pY2FsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3Njc2kvYm54MmkvYm54MmlfaXNj
c2kuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9ibngyaS9ibngyaV9pc2NzaS5j
IGIvZHJpdmVycy9zY3NpL2JueDJpL2JueDJpX2lzY3NpLmMNCj4gaW5kZXggNjljNzU0MjZjNWVi
Li5jNWZhNWYzYjAwZTkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc2NzaS9ibngyaS9ibngyaV9p
c2NzaS5jDQo+ICsrKyBiL2RyaXZlcnMvc2NzaS9ibngyaS9ibngyaV9pc2NzaS5jDQo+IEBAIC01
NzcsNyArNTc3LDcgQEAgc3RhdGljIHZvaWQgYm54MmlfZnJlZV9tcF9iZHQoc3RydWN0IGJueDJp
X2hiYSAqaGJhKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaGJhLT5kdW1t
eV9idWZmZXIsIGhiYS0+ZHVtbXlfYnVmX2RtYSk7DQo+ICAgICAgICAgICAgICAgICBoYmEtPmR1
bW15X2J1ZmZlciA9IE5VTEw7DQo+ICAgICAgICAgfQ0KPiAtICAgICAgICAgICAgICAgcmV0dXJu
Ow0KPiArICAgICAgIHJldHVybjsNCj4gIH0NCj4gDQo+ICAvKioNCj4gLS0NCj4gMi4xOS4xDQoN
ClRoYW5rcw0KQWNrZWQtYnk6IE1hbmlzaCBSYW5nYW5rYXIgPG1yYW5nYW5rYXJAbWFydmVsbC5j
b20+DQoNCg==
