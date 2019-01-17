Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E7EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B87820657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="LitW/m0o";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="mUM3PuK8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfAQKrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:47:24 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:47854 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726917AbfAQKrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:47:23 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0HAkkTI003078;
        Thu, 17 Jan 2019 02:46:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=proofpoint;
 bh=JyDDDXmvmRvEeu8EzUiMGQ02FCyNqGq/5y86oyDAxrY=;
 b=LitW/m0oerwFp8zDE1O00v4aAMwawavvKRyKtU12OJGUM8TBgDCosKp3yFq1qgaavFdE
 uo0MHEWoaTJELIcQEuoquP4uH6S478qsBXjp0wZ65kcHSzUyWnVF2mRz3TCJRQXvlI9G
 aXp9+x3rN9Xondawi1bIMZ76Hmvdvbr82RiD4kgx2eHHg+FWPydFT8Nhzb3jeOTSHVFc
 wEq1pIijQ7hcoZqU0wyDWKN1gVPoWMS+8zCTn62Ar1g2mK9/8B/O5ZRMtrPBJwPB0AE3
 gUupNELWvvXTprfhC79CeW5v+0kxOuycHDc+RcOJy60LBCOFKVwQKJOipD4JBNLh4Gng cw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=jank@cadence.com
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2055.outbound.protection.outlook.com [104.47.41.55])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2pydnvv8s0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 17 Jan 2019 02:46:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyDDDXmvmRvEeu8EzUiMGQ02FCyNqGq/5y86oyDAxrY=;
 b=mUM3PuK8I5X51EdV9WPEnZR38/CBuvfu7EmA3NCa/DTOp8AUSt0HxTW3Y1Y+4E3ot+JMbjz4YHIjgkd+Ebu5+qGCqSvgI4BOMhT+dCars8ErAQg35rjngyFy8UoKVyfV6Lg+DgX7bbm7KpO2xXTb+bLhPWYYl8bD9EzVtXFkkwE=
Received: from CY1PR07MB2521.namprd07.prod.outlook.com (10.167.16.12) by
 CY1PR07MB2346.namprd07.prod.outlook.com (10.166.194.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.27; Thu, 17 Jan 2019 10:46:50 +0000
Received: from CY1PR07MB2521.namprd07.prod.outlook.com
 ([fe80::3943:964b:fb0b:ae91]) by CY1PR07MB2521.namprd07.prod.outlook.com
 ([fe80::3943:964b:fb0b:ae91%5]) with mapi id 15.20.1537.018; Thu, 17 Jan 2019
 10:46:50 +0000
From:   Jan Kotas <jank@cadence.com>
To:     Rob Herring <robh@kernel.org>
CC:     Jan Kotas <jank@cadence.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: rtc: Add bindings for Cadence RTC
Thread-Topic: [PATCH v2 1/2] dt-bindings: rtc: Add bindings for Cadence RTC
Thread-Index: AQHUqcBYGlDbfw3xWEeNgMJSC0Vnj6Wya6UAgADkv4A=
Date:   Thu, 17 Jan 2019 10:46:50 +0000
Message-ID: <46BA7224-B229-4594-B039-8801A806657E@global.cadence.com>
References: <20190111151401.25047-1-jank@cadence.com>
 <20190111151401.25047-2-jank@cadence.com> <20190116210806.GA21535@bogus>
In-Reply-To: <20190116210806.GA21535@bogus>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR07MB2346;20:8TrTQgrZRqTG+uIymcAhiWMALwSyGcTxspS1ze/5P28HRT4ApehA6Ad5hb/pvzvfksvSFMey+LhzpkrVWlqc8X/cChtNug6d2PCU1zTcdP57/xqRUpZD7Dz9FPKTSMQRnGyhzSxl93zP9q53i1Q8X4iJb2bu/G7cYlzf5wQW/WGsrKiJa8svIDg5Dd6eAKu9eTV4d0AbPV6OWD+7Qwwp1Ot1fQJXUMyB3jgvIldwrJwSXaNp5QCvV+iDg0WoqfOf
x-ms-office365-filtering-correlation-id: 143c4542-1466-4fc9-5ae9-08d67c69163d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR07MB2346;
x-ms-traffictypediagnostic: CY1PR07MB2346:
x-microsoft-antispam-prvs: <CY1PR07MB23467766A5AB867E4FD67E29D0830@CY1PR07MB2346.namprd07.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(376002)(136003)(346002)(366004)(36092001)(189003)(199004)(305945005)(6436002)(7736002)(26005)(66066001)(14454004)(6506007)(102836004)(82746002)(81156014)(81166006)(4744005)(4326008)(53546011)(186003)(53936002)(6246003)(8676002)(25786009)(478600001)(86362001)(2906002)(68736007)(106356001)(97736004)(83716004)(71190400001)(105586002)(71200400001)(76176011)(99286004)(6116002)(3846002)(33656002)(54906003)(316002)(5660300001)(256004)(6916009)(229853002)(6512007)(8936002)(11346002)(6486002)(446003)(486006)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2346;H:CY1PR07MB2521.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MM1g5oSMKXmstWK2r5XExvRI7SI5uIAbLY57m/cDC3xcb+b744Av72rkzbwIsCMSvzaWlTIB6tpTX/LOSHrAcL8SQbtei38Eh/1ulByXOTAjiH0PnVdVDCknTsdhlwiXB9MZADAfK6c/n4W1U3DLoKDQV+1FfRGCa/hVrqre4vs3b/mtrXHpszTLLulSytXlKic4XhxJlFceL2SuEzWLfhebrZlpRYmvugqkewhElm2AK6YVgNyWj3wwYSolMHM4x5pjlUN9WBL0akoFrZF9hcPRpYrzTRsllnOmbuzpgZ9J5vmT7tFizWkkfB9Y3xB7UDj8EjxQPzc14FxgzbSGHi9ldK2huzX7P0Fho0IcG23PPI7v6xufkTHEkM+IGeP8gVJs6dPzIeIf9xHF2eD6TBvzx6HF5to2+NJn3kH+lNU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD0E85CDC7D69644A830DE0B82855FF1@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 143c4542-1466-4fc9-5ae9-08d67c69163d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 10:46:50.4342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2346
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-17_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=826 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901170079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIDE2IEphbiAyMDE5LCBhdCAyMjowOCwgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9y
Zz4gd3JvdGU6DQo+IA0KPiANCj4gT24gRnJpLCBKYW4gMTEsIDIwMTkgYXQgMDM6MTQ6MDBQTSAr
MDAwMCwgSmFuIEtvdGFzIHdyb3RlOg0KPj4gVGhpcyBwYXRjaCBhZGRzIGEgRFQgYmluZGluZyBk
b2N1bWVudGF0aW9uIGZvcg0KPj4gQ2FkZW5jZSBSVEMgY29udHJvbGxlci4NCj4+ICtSZXF1aXJl
ZCBwcm9wZXJ0aWVzOg0KPj4gKy0gY29tcGF0aWJsZTogU2hvdWxkIGJlICJjZG5zLHJ0Yy1yMTA5
djMiDQo+PiArLSByZWc6IFNwZWNpZmllcyBiYXNlIHBoeXNpY2FsIGFkZHJlc3MgYW5kIHNpemUg
b2YgdGhlIHJlZ2lzdGVyIGFyZWEuDQo+PiArLSBpbnRlcnJ1cHRzOiBBIHNpbmdsZSBpbnRlcnJ1
cHQgc3BlY2lmaWVyLg0KPj4gKy0gY2xvY2tzOiBNdXN0IGNvbnRhaW4gdHdvIGVudHJpZXM6DQo+
PiArCS0gcGNsazogQVBCIHJlZ2lzdGVycyBjbG9jaw0KPj4gKwktIHJlZl9jbGs6IHJlZmVyZW5j
ZSAxSHogb2YgMTAwSHogY2xvY2ssIGRlcGVuZGluZyBvbiBJUCBjb25maWd1cmF0aW9uDQo+IA0K
PiAxSHogT1IgMTAwSHo/DQoNCkhpLA0KDQpUaGUgSVAgaGFzIGEgY29uZmlndXJhdGlvbiBwYXJh
bWV0ZXIgYXQgYnVpbGQgdGltZSwNCndoaWNoIHNlbGVjdHMgdGhlIHJlZmVyZW5jZSBjbG9jayBm
cmVxdWVuY3kuDQoNCkl0IGNhbm5vdCBiZSBjaGFuZ2VkIGxhdGVyLCBhbmQgdGhlcmXigJlzIG5v
IHJlZ2lzdGVyIHdoaWNoDQp0ZWxscyB0aGUgc29mdHdhcmUgd2hpY2ggb3B0aW9uIHdhcyBzZWxl
Y3RlZC4NCg0KSW4gdGhpcyB2ZXJzaW9uIG9mIHRoZSBwYXRjaCwgYm90aCB2YWx1ZXMgYXJlIGFj
Y2VwdGVkLg0KSWYgaXQgbWFrZXMgc2Vuc2UgSSBjYW4gYWRkIGEgYm9vbCBwcm9wZXJ0eSwgbGlr
ZQ0KcmVmY2xvY2stMTAwaHosIHdoaWNoIGNhbiBiZSB1c2VkIHRvIGNoZWNrIHRoZSBjbG9jayBm
cmVxdWVuY3kuDQoNClJlZ2FyZHMsDQpKYW4NCg0K
