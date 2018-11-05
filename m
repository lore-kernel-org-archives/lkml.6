Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB09C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2034F2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="hsjTCQTG";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="QtvCrp5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2034F2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbeKEUym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:54:42 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:42178 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726319AbeKEUym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:54:42 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wA5BWwlT018364;
        Mon, 5 Nov 2018 03:34:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=LJUlQDmWNIxRBVNCRBKxbAWIwNf5yPI5Uf5FU42sux0=;
 b=hsjTCQTGuuKe2uZgfmM6Tl7ZtB+iNH0c9ENa9hfTT0No5CPkbbP3AFSUo76OFGXL9u4t
 X9jX1Szq4m0ajiQhtQkbmqIsNpE5OWwzfYyFw3qeNAatsnM5VkLm/mLB5ysOw3eZ9TQ6
 YjhAF1xdtzt2RMuHDuP7iXRl8VdHMedmcf31rAtaJo2OV8MNWt6Wr9L2TZxJyCJuydx5
 LtAD9A3vw1QQZGdsLbldVQwgxjS6XkVq/AiCkDI93aCK+8BPDm+tbFH5ZavnxZ6nim0W
 6oKs4BoxRkt7IUf4eo1LRsrSvMcZz4qVJNXsTe+fh/A3IFcA8mFDji0GswsO/SmPwrt8 bw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=dkos@cadence.com
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp0114.outbound.protection.outlook.com [216.32.180.114])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2nh87rrgyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 05 Nov 2018 03:34:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJUlQDmWNIxRBVNCRBKxbAWIwNf5yPI5Uf5FU42sux0=;
 b=QtvCrp5OO+kG6IRaTppyuUAhE7YwarIrpVqVspthHO4Gko9OdS1OfwW41GsSNi2c3LVhwZ90CyWtanLGPrWH//2nTJ3ek8YTO9G3NrKeSfTEDcxhsrHjAp3uSQL7jHI8DiyXUCfs3ly/eA9fN+DCGEiHi5LCA3/63zB1ajf+mW8=
Received: from CY1PR0701MB1664.namprd07.prod.outlook.com (10.163.20.22) by
 CY1PR0701MB1710.namprd07.prod.outlook.com (10.163.21.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Mon, 5 Nov 2018 11:34:31 +0000
Received: from CY1PR0701MB1664.namprd07.prod.outlook.com
 ([fe80::59a0:1638:ccd6:ad87]) by CY1PR0701MB1664.namprd07.prod.outlook.com
 ([fe80::59a0:1638:ccd6:ad87%2]) with mapi id 15.20.1294.028; Mon, 5 Nov 2018
 11:34:31 +0000
From:   Damian Kos <dkos@cadence.com>
To:     Andrzej Hajda <a.hajda@samsung.com>
CC:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Archit Taneja <architt@codeaurora.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        =?utf-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Piotr Sroka <piotrs@cadence.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Rafal Ciepiela <rafalc@cadence.com>,
        "quentin.schulz@bootlin.com" <quentin.schulz@bootlin.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>
Subject: RE: [PATCH v6 0/6] drm: add support for Cadence MHDP DPI/DP bridge.
Thread-Topic: [PATCH v6 0/6] drm: add support for Cadence MHDP DPI/DP bridge.
Thread-Index: AQHUX0/e2PllWSvZiEqVG0HuQ+ejRqVBF/BwgAAOeICAAACgAIAACmmAgAAG2/A=
Date:   Mon, 5 Nov 2018 11:34:31 +0000
Message-ID: <CY1PR0701MB16643016AC6D9D3901CA6786CDCA0@CY1PR0701MB1664.namprd07.prod.outlook.com>
References: <1539034953-11274-1-git-send-email-dkos@cadence.com>
        <CY1PR0701MB166434BBB71DB76593E0F513CDCA0@CY1PR0701MB1664.namprd07.prod.outlook.com>
        <3056496.a8qoricJmv@avalon>
        <CGME20181105103448epcas1p29a9889a9a19fc56629dcc7e24785556c@epcas1p2.samsung.com>
        <CY1PR0701MB16644A2C7EF670F5AC732BF8CDCA0@CY1PR0701MB1664.namprd07.prod.outlook.com>
 <d6db03aa-6f61-f902-85f6-2245547186bc@samsung.com>
In-Reply-To: <d6db03aa-6f61-f902-85f6-2245547186bc@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZGtvc1xhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLWM0MGIwMDFhLWUwZWUtMTFlOC04NzJkLWE0NGNjOGNjMTI3Y1xhbWUtdGVzdFxjNDBiMDAxYy1lMGVlLTExZTgtODcyZC1hNDRjYzhjYzEyN2Nib2R5LnR4dCIgc3o9IjI4ODIiIHQ9IjEzMTg1ODkxMjc0MTAwNzIzNyIgaD0iSDNvb0Z0WlN2T3RjeFJNN0tkYzNuajdyUWQ4PSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR0701MB1710;20:BCmrCsMw5R5BlvwienXvxXAXxyQyJXw5WCfzTOUugHSitjkD54YGMQcvNazdKBIzQbQI+RyLRzt3iWKR5qI1rLmz0G93yDs9CeakjFGzUZItYZhdhc27mBj6ZQ6kcEyM5uYRiVQYlloA2UJc1+togPvKXyg4yDCri/xEv23Ml8A6f04edyhL6vZtclskjv7aeBBKIQqymakoxMJ/CiZnM4GidSmxNPPTiDvguFmIKWRAz1llr+inWMXK8XC9eejQ
x-ms-office365-filtering-correlation-id: 1975f140-2f05-4599-b5ce-08d64312a756
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY1PR0701MB1710;
x-ms-traffictypediagnostic: CY1PR0701MB1710:
x-microsoft-antispam-prvs: <CY1PR0701MB1710CC1295837F306D117540CDCA0@CY1PR0701MB1710.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(217544274631240)(9452136761055)(258649278758335)(31051911155226)(7411616537696)(72806322054110)(180628864354917)(228905959029699)(58145275503218);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:CY1PR0701MB1710;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1710;
x-forefront-prvs: 08476BC6EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(396003)(136003)(39860400002)(376002)(346002)(366004)(199004)(189003)(13464003)(36092001)(93886005)(2900100001)(99286004)(76176011)(33656002)(4326008)(446003)(11346002)(486006)(316002)(476003)(7696005)(66574009)(53936002)(71190400001)(71200400001)(9686003)(86362001)(305945005)(55016002)(6246003)(25786009)(54906003)(6436002)(74316002)(7736002)(6116002)(3846002)(7416002)(66066001)(105586002)(106356001)(97736004)(6916009)(478600001)(26005)(6506007)(53546011)(102836004)(68736007)(229853002)(5660300001)(2906002)(14454004)(8936002)(256004)(81156014)(8676002)(186003)(81166006)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB1710;H:CY1PR0701MB1664.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CJuC85EGep7+SYfqtaZ+k3Wy5I282PED5dmxQwtOn9ckCDnszMCIg8NW5np80Zi1/N3YR5lpj8MIVP9LdxshJgF3Hx4n16ehppc4WhC6Dt+M2xlmwOdm2gQjG8FQdL0QcakAHyL1jKMVwND+N04iIsBbbqvXkQdDsIyCVJExJbjjWt7Xq2w+wfHTOaHQOxRQAKHwyVl18gd5CKEu6qnZX1AJqCV/qYBQqBbeJdnU7rEg6N1ODkEf4IBd9wZXcAFKlfZ6EkyOzpOEBQXR0aRafcY6YPTwJdtI+tLdE4A6MzVE0Sap1F9W5aVemfpPaHQSGHbBXwqgYqawO6jqWlHs+AUq9gEp7zECKRSdGYRwJTo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1975f140-2f05-4599-b5ce-08d64312a756
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2018 11:34:31.4112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB1710
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811050108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcnplaiwNCg0KVGhhbmtzIQ0KDQpEYW1pYW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IEFuZHJ6ZWogSGFqZGEgPGEuaGFqZGFAc2Ftc3VuZy5jb20+IA0KU2VudDog
TW9uZGF5LCBOb3ZlbWJlciA1LCAyMDE4IDEyOjEwDQpUbzogRGFtaWFuIEtvcyA8ZGtvc0BjYWRl
bmNlLmNvbT47IExhdXJlbnQgUGluY2hhcnQgPGxhdXJlbnQucGluY2hhcnRAaWRlYXNvbmJvYXJk
LmNvbT4NCkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+OyBSb2IgSGVycmluZyA8
cm9iaCtkdEBrZXJuZWwub3JnPjsgTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT47
IEFyY2hpdCBUYW5lamEgPGFyY2hpdHRAY29kZWF1cm9yYS5vcmc+OyBHdXN0YXZvIFBhZG92YW4g
PGd1c3Rhdm9AcGFkb3Zhbi5vcmc+OyBNYWFydGVuIExhbmtob3JzdCA8bWFhcnRlbi5sYW5raG9y
c3RAbGludXguaW50ZWwuY29tPjsgU2VhbiBQYXVsIDxzZWFuQHBvb3JseS5ydW4+OyBTYW5keSBI
dWFuZyA8aGpjQHJvY2stY2hpcHMuY29tPjsgSGVpa28gU3TDvGJuZXIgPGhlaWtvQHNudGVjaC5k
ZT47IFF1ZW50aW4gU2NodWx6IDxxdWVudGluLnNjaHVsekBmcmVlLWVsZWN0cm9ucy5jb20+OyBQ
aW90ciBTcm9rYSA8cGlvdHJzQGNhZGVuY2UuY29tPjsgZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtcm9j
a2NoaXBAbGlzdHMuaW5mcmFkZWFkLm9yZzsgUmFmYWwgQ2llcGllbGEgPHJhZmFsY0BjYWRlbmNl
LmNvbT47IHF1ZW50aW4uc2NodWx6QGJvb3RsaW4uY29tOyBqYmVyZ3NhZ2VsQHRpLmNvbQ0KU3Vi
amVjdDogUmU6IFtQQVRDSCB2NiAwLzZdIGRybTogYWRkIHN1cHBvcnQgZm9yIENhZGVuY2UgTUhE
UCBEUEkvRFAgYnJpZGdlLg0KDQpFWFRFUk5BTCBNQUlMDQoNCg0KT24gMDUuMTEuMjAxOCAxMToz
MywgRGFtaWFuIEtvcyB3cm90ZToNCj4gSGkgTGF1cmVudCwNCj4NCj4gVW5kZXJzdG9vZC4gVGhh
bmtzLg0KDQoNCkkgd2lsbCBsb29rIGF0IGl0IHRvZGF5IG9yIHRvbW9ycm93Lg0KDQoNClJlZ2Fy
ZHMNCg0KQW5kcnplag0KDQoNCj4NCj4gRGFtaWFuDQo+DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IExhdXJlbnQgUGluY2hhcnQgPGxhdXJlbnQucGluY2hhcnRAaWRlYXNv
bmJvYXJkLmNvbT4NCj4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciA1LCAyMDE4IDExOjMwDQo+IFRv
OiBEYW1pYW4gS29zIDxka29zQGNhZGVuY2UuY29tPg0KPiBDYzogRGF2aWQgQWlybGllIDxhaXJs
aWVkQGxpbnV4LmllPjsgUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IA0KPiBNYXJr
IFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPjsgQXJjaGl0IFRhbmVqYSANCj4gPGFyY2hp
dHRAY29kZWF1cm9yYS5vcmc+OyBBbmRyemVqIEhhamRhIDxhLmhhamRhQHNhbXN1bmcuY29tPjsg
R3VzdGF2byANCj4gUGFkb3ZhbiA8Z3VzdGF2b0BwYWRvdmFuLm9yZz47IE1hYXJ0ZW4gTGFua2hv
cnN0IA0KPiA8bWFhcnRlbi5sYW5raG9yc3RAbGludXguaW50ZWwuY29tPjsgU2VhbiBQYXVsIDxz
ZWFuQHBvb3JseS5ydW4+OyANCj4gU2FuZHkgSHVhbmcgPGhqY0Byb2NrLWNoaXBzLmNvbT47IEhl
aWtvIFN0w7xibmVyIDxoZWlrb0BzbnRlY2guZGU+OyANCj4gUXVlbnRpbiBTY2h1bHogPHF1ZW50
aW4uc2NodWx6QGZyZWUtZWxlY3Ryb25zLmNvbT47IFBpb3RyIFNyb2thIA0KPiA8cGlvdHJzQGNh
ZGVuY2UuY29tPjsgZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgDQo+IGRldmljZXRy
ZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyANCj4gbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyANCj4gbGludXgtcm9ja2NoaXBAbGlz
dHMuaW5mcmFkZWFkLm9yZzsgUmFmYWwgQ2llcGllbGEgDQo+IDxyYWZhbGNAY2FkZW5jZS5jb20+
OyBxdWVudGluLnNjaHVsekBib290bGluLmNvbTsgamJlcmdzYWdlbEB0aS5jb20NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2NiAwLzZdIGRybTogYWRkIHN1cHBvcnQgZm9yIENhZGVuY2UgTUhEUCBE
UEkvRFAgYnJpZGdlLg0KPg0KPiBFWFRFUk5BTCBNQUlMDQo+DQo+DQo+IEhpIERhbWlhbiwNCj4N
Cj4gT24gTW9uZGF5LCA1IE5vdmVtYmVyIDIwMTggMTE6NDQ6NTMgRUVUIERhbWlhbiBLb3Mgd3Jv
dGU6DQo+PiBIaSBHdXlzLA0KPj4NCj4+IEknbSB3b25kZXJpbmcgaWYgdGhpcyB0aW1lIHBhdGNo
IGlzIHNvIGdvb2QgdGhhdCB0aGVyZSdyZSBubyBjaGFuZ2UgDQo+PiByZXF1ZXN0cywgb3IgaXMg
aXQgc28gYmFkIHRoYXQgaXQgd2FzIHJlamVjdGVkIHdpdGhvdXQgYSBjb21tZW50IDogKSANCj4+
IFBsZWFzZSBsZXQgbWUga25vdyBpZiB0aGlzIHBhdGNoIGlzIGJlaW5nIGluIHJldmlldyBvciB3
YXMgcmVqZWN0ZWQgDQo+PiBhbmQsIGlmIHNvLCB3aGF0IG5lZWRzIHRvIGJlIGNoYW5nZWQuDQo+
IEkgdW5mb3J0dW5hdGVseSBkb24ndCBoYXZlIHRpbWUgdG8gcmV2aWV3IHlvdXIgc2VyaWVzIGZv
ciB0aGUgdGltZSBiZWluZy4gDQo+IEhvcGVmdWxseSBzb21lb25lIGVsc2Ugd2lsbCBoYXZlIGEg
YmV0dGVyIHJldmlldyBiYW5kd2lkdGggOi0pIFNvcnJ5IGFib3V0IHRoYXQuDQo+DQo+IC0tDQo+
IFJlZ2FyZHMsDQo+DQo+IExhdXJlbnQgUGluY2hhcnQNCj4NCj4NCj4NCj4NCj4NCg0K
