Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCCCC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 10:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE80220861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 10:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="li4fK3Jr";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="a0dnn7CM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE80220861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbeIMP6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 11:58:01 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:52482 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726450AbeIMP6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 11:58:01 -0400
X-Greylist: delayed 1984 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Sep 2018 11:57:59 EDT
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8DAEfWw024854;
        Thu, 13 Sep 2018 03:15:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=CpiOWnkpiD9NnFmhImzw8x/rp0583kqRROJD25W9eMU=;
 b=li4fK3JrggOckggoxo9UkvYVxdGXjx2xU8WJQtwDf0ypbtvpyVpdFcm9k14+eeTicH//
 8Xl4lFsQozEwOpLy7oWPQi8fOdB7VO9HihGC8ByNmQ0HgXLsMIE96vVfWDhZmmDAuZPH
 rCkdm7BX5hAOq2GmBjyuQ2leZQ8chbtrhcDEYX5L0qDW7yUmELtH5X0fw70XJdrasNQw
 A9ZWHEYZRTkPpf/214WoMcF5yUljOa/XzrgAo+2hLaZ2nokLWH35eLAOQ7RAeLKp63Ok
 qtWbzL5hl2OM09uyhpnzax1dKBuZ3oZkm5cyXYabPcKLrmmuxUMob6uKVLb+hfqoQIah 6g== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=dkos@cadence.com
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp0080.outbound.protection.outlook.com [207.46.163.80])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2mf803udth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 13 Sep 2018 03:15:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpiOWnkpiD9NnFmhImzw8x/rp0583kqRROJD25W9eMU=;
 b=a0dnn7CMGku3rDg6ymQ9v38zHFtSVdG8fCIY/YrlG2iQvFZcSLqmcE54VHnFP9+9Mwb7ZH+C2uuidRqxGXNzpQiAlA7meqmPGFbfaO82eWupSTpbItcTC0UfNbc/2t7L8ZKS2qZjuo/Tljl8qM4jv6MIo5OOwLLj0rX5Qo2JiTM=
Received: from CO2PR07MB2551.namprd07.prod.outlook.com (10.166.201.14) by
 CO2PR07MB555.namprd07.prod.outlook.com (10.141.199.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.16; Thu, 13 Sep 2018 10:15:19 +0000
Received: from CO2PR07MB2551.namprd07.prod.outlook.com
 ([fe80::4141:269b:f160:2dfd]) by CO2PR07MB2551.namprd07.prod.outlook.com
 ([fe80::4141:269b:f160:2dfd%4]) with mapi id 15.20.1122.019; Thu, 13 Sep 2018
 10:15:19 +0000
From:   Damian Kos <dkos@cadence.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        =?utf-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
CC:     Przemyslaw Gaj <pgaj@cadence.com>,
        Lukasz Tyrala <ltyrala@cadence.com>,
        Scott Telford <stelford@cadence.com>,
        Artur Jedrysek <jartur@cadence.com>,
        Piotr Sroka <piotrs@cadence.com>
Subject: RE: [PATCH v3 1/5] drm/rockchip: prepare common code for cdns and rk
 dpi/dp driver
Thread-Topic: [PATCH v3 1/5] drm/rockchip: prepare common code for cdns and rk
 dpi/dp driver
Thread-Index: AQHUPrmCfEjX0h6EcEC2L/yxd9bqRaTuE+GAgAABaEA=
Date:   Thu, 13 Sep 2018 10:15:19 +0000
Message-ID: <CO2PR07MB255146DAA1B87BB046E64BAECD1A0@CO2PR07MB2551.namprd07.prod.outlook.com>
References: <1535451894-2518-1-git-send-email-dkos@cadence.com>
        <CGME20180828102612epcas2p376fa6f21ce57f4753a8d0f80f5359842@epcas2p3.samsung.com>
        <1535451894-2518-2-git-send-email-dkos@cadence.com>
 <20180913100100eucas1p23e7e33035b6cba51d6219a58b34eea92~T7VgDpN8L3204732047eucas1p2_@eucas1p2.samsung.com>
In-Reply-To: <20180913100100eucas1p23e7e33035b6cba51d6219a58b34eea92~T7VgDpN8L3204732047eucas1p2_@eucas1p2.samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZGtvc1xhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLWVkOWI5MzM0LWI3M2QtMTFlOC04NzFiLWNjMmY3MTZkYzIzZFxhbWUtdGVzdFxlZDliOTMzNi1iNzNkLTExZTgtODcxYi1jYzJmNzE2ZGMyM2Rib2R5LnR4dCIgc3o9IjIzMDUiIHQ9IjEzMTgxMzA3MzI1MjIyNjA4MCIgaD0iZGpjOGc1TU5hNjZkdnQxTkpRZWQvTDNUcTJnPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR07MB555;20:zRiuFy9U2coZzdwAhtQtwagt/+Evo7ufpe1tLfzbiP1pkae4qBLM8UUcF9ZorOuKV4kMotqU74vqNmFziwbfrLYL3mrhxCXPri53K5hJoQplCt9ED35UJ8CCF6zFQgJWoglcTW9QxBMbJ468K/tEt6FJfMddYH1pRHMn7+AxIPgyNw+peA4fWvir+OoS3DhFklL1e9VBi3a1CwP8eNksfbB3bPuW40/yyKeBK1R8IOH4BiF5spaTcN8nwjn0jPOe
x-ms-office365-filtering-correlation-id: baa29221-44d2-4f2a-b492-08d61961ceee
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR07MB555;
x-ms-traffictypediagnostic: CO2PR07MB555:
x-microsoft-antispam-prvs: <CO2PR07MB5559F1ECD0F0B8F1F53E168CD1A0@CO2PR07MB555.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(258649278758335)(217544274631240)(7411616537696)(72806322054110)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:CO2PR07MB555;BCL:0;PCL:0;RULEID:;SRVR:CO2PR07MB555;
x-forefront-prvs: 07943272E1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(366004)(39860400002)(52314003)(36092001)(13464003)(189003)(199004)(6246003)(53546011)(102836004)(14454004)(8936002)(6436002)(107886003)(106356001)(53936002)(6116002)(81156014)(68736007)(9686003)(105586002)(2201001)(86362001)(81166006)(2906002)(93886005)(478600001)(55016002)(3846002)(229853002)(5660300001)(54906003)(256004)(2900100001)(99286004)(7736002)(11346002)(8676002)(74316002)(7696005)(305945005)(5250100002)(33656002)(2501003)(316002)(7416002)(4326008)(25786009)(6506007)(186003)(26005)(76176011)(476003)(66066001)(486006)(446003)(110136005)(97736004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR07MB555;H:CO2PR07MB2551.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MMHWRonQS/8s8BbXzKUc+diQLEYodPApK85K2YzUxs8XOj6yiPmNCL37o+RQeF17oYvCE5J4UGUEvvgpwimfh/V/c5dag8RI3SRpwTDljTLoeJgchio4loa3BEOdQdBiquKUMGbNd6InV362Cs5Rmf1dgs3GAaWtxFh/hNc8HpWI4FcXYu4YuyXACv47lqe2C3QTGNsqvnG5s1Awx8TJmj9iyaf61nZsRlGdsb0tAT/o/1X61vXaCpwqRy8ZK7r0f4Aq8f2RHrJg+2pxNLxlqLwxtsEzpeUEPh9Ux62KMeCWsKTQ8Bs5frwpsH/GtTXdX6fGV6w+guZm0ppFgaDzASufzVFpGMiMofSUJLRH7cw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baa29221-44d2-4f2a-b492-08d61961ceee
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2018 10:15:19.1744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR07MB555
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-13_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=917 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1809130105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmsgeW91LCBBbmRyemVqISBJIHdhcyBhIGJpdCBhZnJhaWQgdGhhdCBvdXIgcGF0Y2hlcyBh
cmUgYSBiaXQgdG9vIG1lc3N5IGFuZCB0aHVzIGlnbm9yZWQg8J+Yig0KQW55d2F5LCB0aGlzIHBh
dGNoICgxLzUpIHNob3VsZCBiZSB0aGUgbGFzdCBvbmUgdGhhdCB3aWxsIGNhdXNlIHN1Y2ggY2hh
b3MgaW4gdGhlIERSTSBhcmVhLg0KDQpSZWdhcmRzLA0KRGFtaWFuDQoNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBBbmRyemVqIEhhamRhIDxhLmhhamRhQHNhbXN1bmcuY29tPiAN
ClNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgMTMsIDIwMTggMTI6MDENClRvOiBEYW1pYW4gS29z
IDxka29zQGNhZGVuY2UuY29tPjsgRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPjsgUm9i
IEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRsYW5k
QGFybS5jb20+OyBBcmNoaXQgVGFuZWphIDxhcmNoaXR0QGNvZGVhdXJvcmEub3JnPjsgTGF1cmVu
dCBQaW5jaGFydCA8TGF1cmVudC5waW5jaGFydEBpZGVhc29uYm9hcmQuY29tPjsgR3VzdGF2byBQ
YWRvdmFuIDxndXN0YXZvQHBhZG92YW4ub3JnPjsgTWFhcnRlbiBMYW5raG9yc3QgPG1hYXJ0ZW4u
bGFua2hvcnN0QGxpbnV4LmludGVsLmNvbT47IFNlYW4gUGF1bCA8c2VhbkBwb29ybHkucnVuPjsg
U2FuZHkgSHVhbmcgPGhqY0Byb2NrLWNoaXBzLmNvbT47IEhlaWtvIFN0w7xibmVyIDxoZWlrb0Bz
bnRlY2guZGU+OyBRdWVudGluIFNjaHVseiA8cXVlbnRpbi5zY2h1bHpAYm9vdGxpbi5jb20+OyBk
cmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnOyBsaW51eC1yb2NrY2hpcEBsaXN0cy5pbmZyYWRlYWQub3JnDQpDYzogUHJ6
ZW15c2xhdyBHYWogPHBnYWpAY2FkZW5jZS5jb20+OyBMdWthc3ogVHlyYWxhIDxsdHlyYWxhQGNh
ZGVuY2UuY29tPjsgU2NvdHQgVGVsZm9yZCA8c3RlbGZvcmRAY2FkZW5jZS5jb20+OyBBcnR1ciBK
ZWRyeXNlayA8amFydHVyQGNhZGVuY2UuY29tPjsgUGlvdHIgU3Jva2EgPHBpb3Ryc0BjYWRlbmNl
LmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMS81XSBkcm0vcm9ja2NoaXA6IHByZXBhcmUg
Y29tbW9uIGNvZGUgZm9yIGNkbnMgYW5kIHJrIGRwaS9kcCBkcml2ZXINCg0KRVhURVJOQUwgTUFJ
TA0KDQoNCkhpIERhbWlhbiwNCg0KUXVpdGUgbGF0ZSBidXQuDQoNCk9uIDI4LjA4LjIwMTggMTI6
MjQsIERhbWlhbiBLb3Mgd3JvdGU6DQo+IC0gRXh0cmFjdGVkIGNvbW1vbiBmaWVsZHMgZnJvbSBj
ZG5fZHBfZGV2aWNlIHRvIGEgbmV3IGNkbnNfbWhkcF9kZXZpY2UNCj4gICBzdHJ1Y3R1cmUgd2hp
Y2ggd2lsbCBiZSB1c2VkIGJ5IHR3byBzZXBhcmF0ZSBkcml2ZXJzIGxhdGVyIG9uLg0KPiAtIE1v
dmVkIHNvbWUgZGF0YXR5cGVzIChhdWRpb19mb3JtYXQsIGF1ZGlvX2luZm8sIHZpY19weGxfZW5j
b2RpbmdfZm9ybWF0LA0KPiAgIHZpZGVvX2luZm8pIGZyb20gY2RuLWRwLWNvcmUuYyB0byBjZG4t
ZHAtcmVnLmguDQo+IC0gQ2hhbmdlZCBwcmVmaXhlcyBmcm9tIGNkbl9kcCB0byBjZG5zX21oZHAN
Cj4gICAgIGNkbiAtPiBjZG5zIHRvIG1hdGNoIHRoZSBvdGhlciBDYWRlbmNlJ3MgZHJpdmVycw0K
PiAgICAgZHAgLT4gbWhkcCB0byBkaXN0aW5ndWlzaCBpdCBmcm9tIGEgImp1c3QgYSBEUCIgYXMg
dGhlIElQIHVuZGVybmVhdGgNCj4gICAgICAgdGhpcyByZWdpc3RlcnMgbWFwIGNhbiBiZSBhIEhE
TUkgKHdoaWNoIGlzIGludGVybmFsbHkgZGlmZmVyZW50LA0KPiAgICAgICBidXQgdGhlIGludGVy
ZmFjZSBmb3IgY29tbWFuZHMsIGV2ZW50cyBpcyBwcmV0dHkgbXVjaCB0aGUgc2FtZSkuDQo+IC0g
TW9kaWZpZWQgY2RuLWRwLWNvcmUuYyB0byB1c2UgdGhlIG5ldyBkcml2ZXIgc3RydWN0dXJlIGFu
ZCBuZXcgZnVuY3Rpb24NCj4gICBuYW1lcy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogRGFtaWFuIEtv
cyA8ZGtvc0BjYWRlbmNlLmNvbT4NCg0KTWFueSBjaGFuZ2VzLCBoYXJkIHRvIHJldmlldy4gQW55
d2F5Og0KDQpSZXZpZXdlZC1ieTogQW5kcnplaiBIYWpkYSA8YS5oYWpkYUBzYW1zdW5nLmNvbT4N
Cg0KwqAtLQ0KUmVnYXJkcw0KQW5kcnplag0KDQoNCg==
