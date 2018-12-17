Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7427AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 05:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D64E20645
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 05:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="AysMozld";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="GE0n5snL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbeLQFq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 00:46:57 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:53846 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726324AbeLQFq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 00:46:57 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBH5b91s017851;
        Sun, 16 Dec 2018 21:46:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=12kgEVYeQexaTfmDFBo+tZD0l4g6s0EMeCSsmnYmUZ0=;
 b=AysMozldvu6EmybkQXev3mG/57hW+CTKPI3IibI6nu6SXsyzmcBIY77wJLYkMXytazeR
 LRfcJpAsnnqJO6QV34oGByyFVLEEc3j121ZrcZ5fxNJV8e0v+eV9moqo/44A7GbG2zDJ
 TwrqqeesyS7SnM8RllZk7E3QMGmFzgrPFYd250Dgt9jF0bjGcDQzC4SOfsIl4MpSURNz
 xIPcWVL3xMYlLhz4WzPS99Hs+Lf5/kVbk3XoUPlZeGs7FWG8L4LmXDdJgxRlz3zflyUY
 +4B5RoxjJ6gH9Ct+3rCS+Cd+gmzLPDf1eGhVCWeU2sCh2HZEv3+fUj/5kjivhJb1URs5 lw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2057.outbound.protection.outlook.com [104.47.32.57])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2pdbx6cqtw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Dec 2018 21:46:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12kgEVYeQexaTfmDFBo+tZD0l4g6s0EMeCSsmnYmUZ0=;
 b=GE0n5snLzAdJolJJdvhTESoy5r3NiCsftUC5iPZEK8lUpE8hnVkAklJcKnQE3V2eePJROdv1+k7S6VJw3OGHv3T39VD78d9sV9TRDV0LW6FND+VSutLqxm7GTJ7tQV6roBxR8ytUN8u35MgXMo5iIfkqHFdFw78mZDWOUl25Q/c=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4680.namprd07.prod.outlook.com (52.135.204.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Mon, 17 Dec 2018 05:46:44 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e97e:1c66:94bc:24ef]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e97e:1c66:94bc:24ef%2]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 05:46:44 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Felipe Balbi <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alan Douglas <adouglas@cadence.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v1 2/2] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Topic: [PATCH v1 2/2] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Index: AQHUkIWTYw8ZmuofoE+7Ba9cSOLyP6V5dPgAgAAFtpCAATKygIAC8LgAgATXe6A=
Date:   Mon, 17 Dec 2018 05:46:43 +0000
Message-ID: <BYAPR07MB47093D9B4AFA4BFAF11C43AFDDBC0@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1544445555-17325-1-git-send-email-pawell@cadence.com>
 <1544445555-17325-3-git-send-email-pawell@cadence.com>
 <87h8fkmfar.fsf@linux.intel.com>
 <BYAPR07MB47095110AF28CC11B4C9E144DDA60@BYAPR07MB4709.namprd07.prod.outlook.com>
 <87a7lbme3m.fsf@linux.intel.com>
 <d77b4083-6641-4a60-1629-b8edacc36c26@ti.com>
In-Reply-To: <d77b4083-6641-4a60-1629-b8edacc36c26@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMjA0MGI5ZTItMDFiZi0xMWU5LTg3MjgtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDIwNDBiOWU0LTAxYmYtMTFlOS04NzI4LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTAyOCIgdD0iMTMxODk0OTkyMDMzODc1NzYzIiBoPSJoYk9WeWlCR2dHWWpsWWh3MDVNVGhnZUV1UjQ9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4680;20:tah+VUHPVhts4ByoUM6iWk7dXECtPDzvt8HD5OcTmb071Utk+OfUVtM7Ny5N0uw2EV9L8qOATOVszb6UdNdqS9o1aTCJWiQTkDM0VNQHMnIL94YvDmGQRwOTS0MBO2NYKljhIk11DqwwOVMonZ679V5C42p7E5Ge9ZKp1+TT9RWWj1ubnCDgMbas2dtpLDPxCeWCd/GpynV3tJos6Xzzto39rb3FjI68u/1obPF5YLXy7+e/5mseeXUNgYqXnHWL
x-ms-office365-filtering-correlation-id: 90f84ca1-d9e5-45d1-ffe4-08d663e306b6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4680;
x-ms-traffictypediagnostic: BYAPR07MB4680:
x-microsoft-antispam-prvs: <BYAPR07MB46807F40B0F69142160C960ADDBC0@BYAPR07MB4680.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB4680;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4680;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(346002)(396003)(39860400002)(189003)(199004)(36092001)(2501003)(106356001)(71190400001)(229853002)(68736007)(8676002)(256004)(305945005)(105586002)(74316002)(86362001)(81156014)(316002)(4326008)(14454004)(53936002)(33656002)(8936002)(6246003)(107886003)(81166006)(99286004)(9686003)(486006)(11346002)(476003)(7416002)(5660300001)(14444005)(71200400001)(76176011)(186003)(26005)(6116002)(3846002)(6506007)(55016002)(97736004)(7696005)(2906002)(6436002)(25786009)(54906003)(102836004)(66066001)(7736002)(93886005)(110136005)(446003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4680;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wmjf5mhh+/uab3ON76AXfbxiQvUqrs7kt71dINYinvLSKt6z7jOFX4bH6GOkdVRAF7mQSNADdSbOjPSqq9Xx4u/L8NfdSgcXAtcUhEgPou0MVh95sAEGxUPknxYpbayQsgx797zvPApKmH12maWPKnlDCFtihkpi9TmKihMHmwNXppZolTwsJ4WZYN3UY4uev945TjgW0Ed+4Gad+sUrolO44aQtCoUIYnhzdF4MPlRWy6dqVSdrnrHt3hnTfDWJOZ8ninyRg1xqcpykega+NO1meMUTS+OTDbHThgyWNWXYQIgyDeHLPn23uJY+3LAM
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f84ca1-d9e5-45d1-ffe4-08d663e306b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 05:46:43.9323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4680
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-17_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=696 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812170053
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4NCj5PbiAxMi8xMi8xOCAxMjoyMiBQTSwgRmVsaXBlIEJhbGJpIHdyb3RlOg0KPj4N
Cj4+IEhpDQo+Pg0KPj4gUGF3ZWwgTGFzemN6YWsgPHBhd2VsbEBjYWRlbmNlLmNvbT4gd3JpdGVz
Og0KPj4+Pj4gKwljZG5zLT5waHkgPSBkZXZtX3BoeV9nZXQoZGV2LCAiY2RuczMsdXNicGh5Iik7
DQo+Pj4+PiArCWlmIChJU19FUlIoY2Rucy0+cGh5KSkgew0KPj4+Pj4gKwkJcmV0ID0gUFRSX0VS
UihjZG5zLT5waHkpOw0KPj4+Pj4gKwkJaWYgKHJldCA9PSAtRU5PU1lTIHx8IHJldCA9PSAtRU5P
REVWKSB7DQo+Pj4+DQo+Pj4+IEFyZSB5b3Ugc3VyZSB5b3UgY2FuIGdldCBFTk9TWVMgaGVyZT8g
SGF2ZSB5b3UgY2hlY2tlZCBvdXRwdXQgb2YNCj4+Pj4gY2hlY2twYXRjaCAtLXN0cmljdD8NCj4+
Pj4gLTo4NTI6IFdBUk5JTkc6IEVOT1NZUyBtZWFucyAnaW52YWxpZCBzeXNjYWxsIG5yJyBhbmQg
bm90aGluZyBlbHNlDQo+Pj4NCj4+PiBZZXMgdGhpcyBlcnJvciBjb2RlIGNhbiBiZSByZXR1cm5l
ZCBieSByZWxhdGVkIHRvIHBoeSBmdW5jdGlvbiBpZg0KPj4+IENPTkZJR19HRU5FUklDX1BIWSBp
cyBkaXNhYmxlZC4NCj4+Pg0KPj4+IEkgaGF2ZSBzZWVuIHRoaXMgd2FybmluZyBpbiBvdXRwdXQg
b2YgY2hlY2twYXRjaCAtLXN0cmljdCAuDQo+Pg0KPj4gS2lzaG9uLCBzZWVtcyBsaWtlIHlvdSBz
aG91bGRuJ3QgYmUgdXNpbmcgdGhhdCBlcnJvciB2YWx1ZS4NCj4NCj5obW0sIHllYWggc2hvdWxk
IGNoYW5nZSB0aGUgcmV0dXJuIHZhbHVlIHRvIC1FTk9ERVYgd2hlbiBHRU5FUklDX1BIWSBpcyBk
aXNhYmxlZC4NCj4NCg0KU28gSSB3aWxsIHJlbW92ZSB0aGlzIEVOT1NZUyBmcm9tIG5leHQgcGF0
Y2guIEkgYXNzdW1lIHRoYXQgaXQgd2lsbCBiZSByZW1vdmVkIGFsc28gZnJvbSBnZW5lcmljIHBo
eSBkcml2ZXIuIA0KDQpUaGFua3MsDQpQYXdlbA0K
