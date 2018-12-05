Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E46FC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0425D20892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="hhpu3Z+g";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="hD0fnG+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0425D20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbeLETmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:42:18 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:49792 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727297AbeLETmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:42:18 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB5JWkQD019550;
        Wed, 5 Dec 2018 11:42:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=5zoppQgM3roJodJeqLq8MtNgjtgiwTQqnBtuTKgp/S4=;
 b=hhpu3Z+gnmEc+cJ7+QPaAz92D3PJ1HslWP7k9i0DgCvqO7B7/5w/aNluR0mKQ7jTDu3l
 IUIcCYTnaJtIRRB5f8w9NDs4hCIjPK24ISc3WpADoI1cRWe72ZUUa2zW0PWoHBX3Oqxf
 BB04fcVUHpjafeN2NwGgw5tKEm0He6NyycmL+I2DWnUKb4lY+6OIrvp3V8v+0l8Bmb7d
 Dds4hUIfT6DKlblLos0Qy7JdTXPc8//23NypIohaymeKpVgq44tjsDv3PeU3Mq1O30tO
 W5FxsOGLUFJIxG6KdK7hq9eYAwaLkjNOHWWNIAAh9PndTmb3Jhsg2yUtNOM8C6yiFvtZ Lw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2057.outbound.protection.outlook.com [104.47.40.57])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2p5scbqj9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 05 Dec 2018 11:42:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zoppQgM3roJodJeqLq8MtNgjtgiwTQqnBtuTKgp/S4=;
 b=hD0fnG+0cLsrU4VeNvhrXvuxJB/jhHwFDYqWI1ATs1xXQBOJcMnwGwlJ/V4K50XJZtfqoX4vlFoMaR4yrvHk3edAEYV7TG1WmKBvS8FaJBR9seufJxO0zs+rGYICOugL5S493TUQWJR3SSMqZkMVBAkpjd3C4e6J6kIDcrKKGVo=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4886.namprd07.prod.outlook.com (52.135.205.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Wed, 5 Dec 2018 19:42:01 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e0dc:ebd5:e248:d644]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e0dc:ebd5:e248:d644%6]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 19:42:01 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Peter Chen <hzpeterchen@gmail.com>, "rogerq@ti.com" <rogerq@ti.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alan Douglas <adouglas@cadence.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Pawel Jez <pjez@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Tomasz Klimek <tklimek@cadence.com>
Subject: RE: [RFC PATCH v2 04/15] usb:cdns3: Driver initialization code.
Thread-Topic: [RFC PATCH v2 04/15] usb:cdns3: Driver initialization code.
Thread-Index: AQHUfycKfg2nmnNwYkGzkCY+37gGkqVdQtkAgBEbpICAAkOqMA==
Date:   Wed, 5 Dec 2018 19:42:01 +0000
Message-ID: <BYAPR07MB47095578C205570DD97EBFE0DDA80@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
 <1542535751-16079-5-git-send-email-pawell@cadence.com>
 <5BF7E5E8.3090406@ti.com>
 <CAL411-rWc23fbP0Ny9Kfdpe9ESUSVt5X00G1uFjJf+rj-2jWzg@mail.gmail.com>
In-Reply-To: <CAL411-rWc23fbP0Ny9Kfdpe9ESUSVt5X00G1uFjJf+rj-2jWzg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZDRmNDNmZjMtZjhjNS0xMWU4LTg3MjYtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGQ0ZjQzZmY0LWY4YzUtMTFlOC04NzI2LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMjUwNyIgdD0iMTMxODg1MTI1MjExMjk4MjI0IiBoPSJPSnRmYUtVSzhrZkYyeUV5L2tUUnBSbHZ1UTQ9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4886;20:b7a+Wk8BRKyzqZsNqAgwyDXiPFXFI0nZ4CvXvwvfwqgkRAw4LrcfX6KmBTch1jj3A40/tUr0N8czyTRjWBcYvjcWaXwkdwhXXd8AN9A5bMh72IUUx5C1AWEhE89BxrHxxTaeNZePOMYjgfu1f/brpXJvHoD2bUbVEpXq9aew9qv3UD+VIbXBb+hdev2jjSZuma48hmjV6QBG13Kk7L6dSl3AEBPZQpDVDDf+0Fpqm4GLOR1lBRTYQoHpu7Ft4XMq
x-ms-office365-filtering-correlation-id: 3d87cb53-0e63-47c8-ee45-08d65ae9ba04
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4886;
x-ms-traffictypediagnostic: BYAPR07MB4886:
x-microsoft-antispam-prvs: <BYAPR07MB488673848308B7DAFE93F62CDDA80@BYAPR07MB4886.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB4886;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4886;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(396003)(366004)(136003)(346002)(39860400002)(36092001)(199004)(189003)(14444005)(93886005)(105586002)(256004)(54906003)(107886003)(186003)(26005)(6246003)(4326008)(102836004)(316002)(7696005)(76176011)(217873002)(110136005)(6506007)(106356001)(305945005)(53936002)(476003)(11346002)(99286004)(486006)(446003)(229853002)(9686003)(39060400002)(55016002)(6436002)(7736002)(74316002)(2501003)(7416002)(478600001)(8936002)(25786009)(68736007)(5660300001)(575784001)(14454004)(97736004)(86362001)(2906002)(81156014)(81166006)(8676002)(6116002)(3846002)(71200400001)(71190400001)(33656002)(66066001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4886;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Pu+ulMaRbZbR51bo040c81Vavs9Y1mwLTxWqiAVOYXLVd/uQIVdh8EOrWZLCw3/B4S2A5aAjqFj32z5t2a2pdTqBzjpVWGMk7G/8WFosx7tRzVyF72yirMAynycSSW6B8vsrzRPnJmdEs4LNUsFTAuKtaNoCkPUYXdxYV/qf4qdMRN0i6hSwHB1Ia2lqzsu3XpZ7qtRGxknNFmFLvvhIYU/F5Jp1grlTg9Sig95IkwlFw72XsgSMVNbgPwHR8FWPI5GEJ54BDaOMygJparga/1QcsYTcafwSC54u6L5SWP1DV62JbTs3ztJKKD9+9/DnNVcXB8EeKUFa1LolYphs2QqVHF9cZQ3KKgWjiN2rlXE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d87cb53-0e63-47c8-ee45-08d65ae9ba04
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 19:42:01.1947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4886
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=603 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812050171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KyBUb21layBLbGltZWsgDQoNCj4+ID4gKw0KPj4gPiArc3RhdGljIGlubGluZSB2b2lkIGNkbnMz
X3JvbGVfc3RvcChzdHJ1Y3QgY2RuczMgKmNkbnMpDQo+PiA+ICt7DQo+PiA+ICsgICAgIGVudW0g
Y2RuczNfcm9sZXMgcm9sZSA9IGNkbnMtPnJvbGU7DQo+PiA+ICsNCj4+ID4gKyAgICAgaWYgKHJv
bGUgPT0gQ0ROUzNfUk9MRV9FTkQpDQo+Pg0KPj4gV0FSTl9PTihyb2xlID49IENORFMzX1JPTEVf
RU5EKSA/DQo+Pg0KPj4gPiArICAgICAgICAgICAgIHJldHVybjsNCj4+ID4gKw0KPj4gPiArICAg
ICBtdXRleF9sb2NrKCZjZG5zLT5tdXRleCk7DQo+PiA+ICsgICAgIGNkbnMtPnJvbGVzW3JvbGVd
LT5zdG9wKGNkbnMpOw0KPj4gPiArICAgICBjZG5zLT5yb2xlID0gQ0ROUzNfUk9MRV9FTkQ7DQo+
Pg0KPj4gV2h5IGNoYW5nZSB0aGUgcm9sZSBoZXJlPyBZb3UgYXJlIGp1c3Qgc3RvcHBpbmcgdGhl
IHJvbGUgbm90IGNoYW5naW5nIGl0Lg0KPj4gSSB0aGluayBjZG5zLT5yb2xlIHNob3VsZCByZW1h
aW4gdW5jaGFuZ2VkLCBzbyB3ZSBjYW4gY2FsbCBjZG5zM19yb2xlX3N0YXJ0KCkNCj4+IGlmIHJl
cXVpcmVkIHdpdGhvdXQgZXJyb3IuDQo+Pg0KPg0KPlRoZSBjdXJyZW50IHZlcnNpb24gb2YgdGhp
cyBJUCBoYXMgc29tZSBpc3N1ZXMgdG8gZGV0ZWN0IHZidXMgc3RhdHVzIGNvcnJlY3RseSwNCj53
ZSBoYXZlIHRvIGZvcmNlIHZidXMgc3RhdHVzIGFjY29yZGluZ2x5LCBzbyB3ZSBuZWVkIGEgc3Rh
dHVzIHRvIGluZGljYXRlDQo+dmJ1cyBkaXNjb25uZWN0aW9uLCBhbmQgYWRkIHNvbWUgY29kZSB0
byBsZXQgY29udHJvbGxlciBrbm93IHZidXMNCj5yZW1vdmFsLCBpbiB0aGF0IGNhc2UsIHRoZSBj
b250cm9sbGVyJ3Mgc3RhdGUgbWFjaGluZSBjYW4gYmUgY29ycmVjdC4NCj5Tbywgd2UgaW5jcmVh
c2Ugb25lIHJvbGUgJ0NETlMzX1JPTEVfRU5EJyB0byBmb3IgdGhpcyBwdXJwb3NlLg0KDQpIaSwg
VG9tZWsgZG8geW91IGhhdmUgYW55IGNvbW1lbnQgZm9yIHRoaXMuDQpXZSBoYXZlIGluIFJUTCB3
aG9sZSBPVEcgbWFjaGluZSBhbmQgd2UgY2FuIHJlYWQgYWxsIHN0YXRlcy4gDQoNCkZyb20gb3Rn
IHNwZWNpZmljYXRpb24gd2UgaGF2ZSBpbiBvdGdfc3RhdGUgc3VjaCBiaXRzOg0KNTozCWhvc3Rf
b3RnX3N0YXRlCSJDdXJyZW50IHN0YXRlIG9mIHRoZSBPVEcgSG9zdCBGU00uDQozJ2IwMDAgOiBI
X0lETEUNCjMnYjAwMSA6IEhfVkJVU19PTg0KMydiMDEwIDogSF9WQlVTX0ZBSUxFRA0KMydiMDEx
IDogSF9PVEdfSE9TVF9NT0RFDQozJ2IxMDAgOiBIX0hPU1RfTU9ERQ0KMydiMTAxIDogSF9TV0lU
Q0hfVE9fREVWSUNFDQozJ2IxMTAgOiBIX0FfU1VTUEVORA0KMydiMTExIDogSF9XQUlUX1ZCVVNf
RkFMTCIJUk8JMHgwDQoyOjAJZGV2X290Z19zdGF0ZQkiQ3VycmVudCBzdGF0ZSBvZiB0aGUgT1RH
IERldmljZSBGU00uDQozJ2IwMDAgOiBERVZfSURMRQ0KMydiMDAxIDogREVWX01PREUNCjMnYjAx
MCA6IERFVl9TUlANCjMnYjAxMSA6IERFVl9XQUlUX1ZCVVNfRkFMTA0KMydiMTAwIDogREVWX1NX
SVRDSF9UT19IT1NUDQozJ2IxMDEgOiBERVZfV0FJVF9GT1JfQ09OTiINCg0KPg0KPkNETlMzX1JP
TEVfR0FER0VUOiBnYWRnZXQgbW9kZSBhbmQgVkJVUyBvbg0KPkNETlMzX1JPTEVfSE9TVDogaG9z
dCBtb2RlIGFuZCBWQlVTIG9uDQo+Q0ROUzNfUk9MRV9FTkQ6IFZCVVMgb2ZmLCBlZyBlaXRoZXIg
aG9zdCBvciBkZXZpY2UgY2FibGUgb24gdGhlIHBvcnQuDQo+DQo+U28sIHdlIG1heSBzdGFydCBy
b2xlIGZyb20gQ0ROUzNfUk9MRV9FTkQgYXQgcHJvYmUgd2hlbiBub3RoaW5nIGlzIGNvbm5lY3Rl
ZCwNCj5hbmQgbmVlZCB0byBzZXQgcm9sZSBhcyBDRE5TM19ST0xFX0VORCBhdCAtPnN0b3AgZm9y
IGZ1cnRoZXIgaGFuZGxpbmcgYXQNCj5yb2xlIHN3aXRjaCByb3V0aW5lLg0KPg0KDQo+PiA+ICsg
ICAgIG11dGV4X3VubG9jaygmY2Rucy0+bXV0ZXgpOw0KPj4gPiArfQ0KPj4gPiArDQo+PiA+ICtz
dGF0aWMgZW51bSBjZG5zM19yb2xlcyBjZG5zM19nZXRfcm9sZShzdHJ1Y3QgY2RuczMgKmNkbnMp
DQo+PiA+ICt7DQo+PiA+ICsgICAgIGlmIChjZG5zLT5yb2xlc1tDRE5TM19ST0xFX0hPU1RdICYm
IGNkbnMtPnJvbGVzW0NETlMzX1JPTEVfR0FER0VUXSkgew0KPj4gPiArICAgICAgICAgICAgIC8v
VE9ETzogaW1wbGVtZW50cyBzZWxlY3RpbmcgZGV2aWNlL2hvc3QgbW9kZQ0KPj4gPiArICAgICAg
ICAgICAgIHJldHVybiBDRE5TM19ST0xFX0hPU1Q7DQo+PiA+ICsgICAgIH0NCj4+ID4gKyAgICAg
cmV0dXJuIGNkbnMtPnJvbGVzW0NETlMzX1JPTEVfSE9TVF0NCj4+ID4gKyAgICAgICAgICAgICA/
IENETlMzX1JPTEVfSE9TVA0KPj4gPiArICAgICAgICAgICAgIDogQ0ROUzNfUk9MRV9HQURHRVQ7
DQoNCkNoZWVycw0KUGF3ZWwsDQo=
