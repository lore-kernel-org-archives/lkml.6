Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E25CC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB15E2159B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="gv6ZpmRw";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="TZbjH7ki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB15E2159B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeI0QuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 12:50:14 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:56022 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727112AbeI0QuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 12:50:14 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8RAT5gi026099;
        Thu, 27 Sep 2018 03:32:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=16q1t0QtCVM6GH9RGVmDCJCApV/nM3FVHEyQtw47Yns=;
 b=gv6ZpmRwcIO/lWbaUHxn5GsOM30EpTNaGJrctdvTMDPmUhGaeIvxVGM6DrysiPrQtFK3
 IRQPpUGiFhg15e8FITegHqxvwoaRylOLRYGIeb6xUesAwdZMYfenI3vabUe8fPpkyltD
 F2eS84BkYIFuLP7fc5WW1aDLyZ8JiZgV3a0TlTqAcpsoHOxHq3cZrHripxKbsYiBbj1W
 FHo8aBOxRi//RFNnxnWtUMZTZclHJSWqPjFQDBUO5XvzgHUJPPiQ7r08WVCvo2PMgt2U
 vYfbLi35vluThUEz+PmrP6gsDSoAirwfzA9PznegJxqXRWzFdJG32atUIMVxgVTBJgOB Og== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=adouglas@cadence.com
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp0116.outbound.protection.outlook.com [216.32.181.116])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2mnhaxgb9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 27 Sep 2018 03:32:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16q1t0QtCVM6GH9RGVmDCJCApV/nM3FVHEyQtw47Yns=;
 b=TZbjH7kixGTcLNnjexKLv5Aj6Lsu/Nwx0ko9XBovhrMGnroLSAfz/DhzolVSYk76qWQf/JGLrZwUJyKcu2cIQz12DkfQjdTSlcCgs76RjM1fUkVlCji2Gwg/UOLAE+oERnyl6SPQzWYvc9v1MTJ6zW2ikqm0QQicEnuXff6uSSA=
Received: from MWHPR07MB3502.namprd07.prod.outlook.com (10.164.192.29) by
 MWHPR07MB3055.namprd07.prod.outlook.com (10.172.97.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.25; Thu, 27 Sep 2018 10:32:12 +0000
Received: from MWHPR07MB3502.namprd07.prod.outlook.com
 ([fe80::8d72:9288:d100:975b]) by MWHPR07MB3502.namprd07.prod.outlook.com
 ([fe80::8d72:9288:d100:975b%2]) with mapi id 15.20.1164.024; Thu, 27 Sep 2018
 10:32:12 +0000
From:   Alan Douglas <adouglas@cadence.com>
To:     Rob Herring <robh@kernel.org>
CC:     "kishon@ti.com" <kishon@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [RFC PATCH v2 1/2] dt-bindings: phy: Document cadence Sierra PHY
 bindings
Thread-Topic: [RFC PATCH v2 1/2] dt-bindings: phy: Document cadence Sierra PHY
 bindings
Thread-Index: AQHURe/cfEZjBQ4HFkWmU1Vw5uTIbKUBmhkAgAC8nKA=
Date:   Thu, 27 Sep 2018 10:32:12 +0000
Message-ID: <MWHPR07MB3502ADDB075E158C486B15E6D8140@MWHPR07MB3502.namprd07.prod.outlook.com>
References: <1536244949-25892-1-git-send-email-adouglas@cadence.com>
 <20180925210154.GA21444@bogus>
In-Reply-To: <20180925210154.GA21444@bogus>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYWRvdWdsYXNcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy05YWNiMzI5Mi1jMjQwLTExZTgtYWI4Yi1hNDRjYzhlYzVlY2RcYW1lLXRlc3RcOWFjYjMyOTMtYzI0MC0xMWU4LWFiOGItYTQ0Y2M4ZWM1ZWNkYm9keS50eHQiIHN6PSI0NzczIiB0PSIxMzE4MjUxNzkzNzU4MTY0MzEiIGg9Ild6Z1NLY1VCKzRPVjIyODhRcVFadEZFcU5taz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR07MB3055;20:+MXfr/4uIMx5qhGU1qYSOTI0Fn3bPBWPYQmi02vmNS/Mtmp2NE8AqBzB/oVM6k/S2suMR2clhbRLLSrash9qDw1hgJ3dDvJyxipykqm8YDpf3NFIJ8vhhfuJTZfI3r2FLBiwY+3sFJPTG2NIkPJe/UzgE2JQ/AKiJcbwNX66bvYcZ+egU1biEY9fXffWO5fmL+u7LVH+TS4AInK8W8YclNuuTwQKGYvW2VC7swrUhyeNnGuBiE910VSsNQlC29Zp
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 49d9a1c5-a078-4ce1-e6fe-08d624647cb0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR07MB3055;
x-ms-traffictypediagnostic: MWHPR07MB3055:
x-microsoft-antispam-prvs: <MWHPR07MB305574B4396826DE55A1CC70D8140@MWHPR07MB3055.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72806322054110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:MWHPR07MB3055;BCL:0;PCL:0;RULEID:;SRVR:MWHPR07MB3055;
x-forefront-prvs: 0808323E97
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(396003)(376002)(346002)(199004)(36092001)(189003)(81156014)(486006)(5660300001)(11346002)(446003)(478600001)(476003)(25786009)(55016002)(6436002)(9686003)(5250100002)(53936002)(3846002)(14454004)(6116002)(71190400001)(76176011)(102836004)(105586002)(81166006)(71200400001)(7696005)(6246003)(8676002)(66066001)(106356001)(68736007)(186003)(8936002)(74316002)(54906003)(26005)(229853002)(6506007)(4326008)(99286004)(53546011)(316002)(6916009)(2900100001)(7736002)(305945005)(217873002)(256004)(14444005)(2906002)(86362001)(97736004)(33656002)(34290500001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3055;H:MWHPR07MB3502.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: X5cyErfFPWIFCyy+cqvxq38D8MkFVLJXXp0jiZx2LIEIa7s7ZUXEyM0fK3VEig7UrQWAUtbfDwHzm5Ua9RvhS9uV5N49N8H3mdt2veJkHLG8I0fxqKgZ4PZYuVZ8wA26rd4mTpKUKEw3jdcIEs9WvdEvbV6xR3/payxE+1z7O9x3h77KT2i+c2sSJ6Xznk5XYPVTJAMftMYMf4oa+hXN0n61mBdR+KYiWGpOresPNOlD10HP1tghX+9kgDNMnh9B4xprcbplOxJABotMNp8Xax8/0xOL1IFKF7qmIXYts4OXWN6sgPjsMOl837A+8foNpkjjjf+o8lgl0MXxfLainjssDpksoXv263rplRQPscU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d9a1c5-a078-4ce1-e6fe-08d624647cb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2018 10:32:12.4770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3055
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-27_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1809270108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjUgU2VwdGVtYmVyIDIwMTggMjI6MDIsIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiBPbiBUaHUs
IFNlcCAwNiwgMjAxOCBhdCAwMzo0MjoyOVBNICswMTAwLCBBbGFuIERvdWdsYXMgd3JvdGU6DQo+
ID4gQWRkIERUIGJpbmRpbmcgZG9jdW1lbnRhdGlvbiBmb3IgU2llcnJhIFBIWS4gIFRoZSBQSFkg
c3VwcG9ydHMNCj4gPiBhIG51bWJlciBvZiBkaWZmZXJlbnQgcHJvdG9jb2xzLCBpbmNsdWRpbmcg
UENJZSBhbmQgVVNCLg0KPiA+DQo+ID4gVGhlIFBIWSBsYW5lcyBtYXkgYmUgY29uZmlndXJlZCBh
cyBzaW5nbGUgb3IgbXVsdGktbGFuZSBsaW5rcy4NCj4gPiBFYWNoIGxpbmsgaXMgdHJlYXRlZCBh
cyBhIHNlcGFyYXRlIHN1Ym5vZGUuICBGb3IgZXhhbXBsZSwgaWYNCj4gPiB0aGVyZSBhcmUgNCBs
YW5lcyBpbiB0b3RhbCB0aGUgZmlyc3QgMiBtYXkgYmUgY29uZmlndXJlZCBhcw0KPiA+IGEgbXVs
dGktbGFuZSBQQ0llIGxpbmsgd2hpbGUgdGhlIG90aGVyIHR3byBhcmUgc2luZ2xlIGxhbmUNCj4g
PiBVU0IgbGlua3MsIGFuZCBpbiB0aGlzIGNhc2UgdGhlcmUgd291bGQgYmUgMyBzdWJub2Rlcy4N
Cj4gPg0KPiA+IFRoZXJlIGFyZSB0d28gcmVzZXRzIGZvciB0aGUgUEhZIGJsb2NrLCBhbmQgYWRk
aXRpb25hbCByZXNldHMsDQo+ID4gb25lIGZvciBlYWNoIGxhbmUuICBGb3IgbXVsdGktbGFuZSBs
aW5rcywgb25seSB0aGUgcmVzZXQgZm9yDQo+ID4gdGhlIG1hc3RlciBsYW5lIGlzIHJlcXVpcmVk
LCB0aGUgcmVzZXRzIG9uIG90aGVyIGxhbmVzIGhhdmUgbm8NCj4gPiBlZmZlY3QuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBBbGFuIERvdWdsYXMgPGFkb3VnbGFzQGNhZGVuY2UuY29tPg0KPiA+
IC0tLQ0KPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvY2Rucy1zaWVycmEtcGh5LnR4
dCAgICB8IDY1ICsrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDY1
IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9waHkvY2Rucy1zaWVycmEtcGh5LnR4dA0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvY2Rucy1zaWVycmEt
cGh5LnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvY2Rucy1zaWVy
cmEtDQo+IHBoeS50eHQNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAw
MDAuLjk0YThhN2YNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9jZG5zLXNpZXJyYS1waHkudHh0DQo+ID4gQEAgLTAsMCAr
MSw2NSBAQA0KPiA+ICtDYWRlbmNlIFNpZXJyYSBQSFkNCj4gPiArLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCj4gPiArDQo+ID4gK1JlcXVpcmVkIHByb3BlcnRpZXM6DQo+ID4gKy0gY29tcGF0aWJs
ZToJY2RucyxzaWVycmEtcGh5LXQwDQo+ID4gKy0gY2xvY2tzOglNdXN0IGNvbnRhaW4gYW4gZW50
cnkgaW4gY2xvY2stbmFtZXMuDQo+ID4gKwkJU2VlIC4uL2Nsb2Nrcy9jbG9jay1iaW5kaW5ncy50
eHQgZm9yIGRldGFpbHMuDQo+ID4gKy0gY2xvY2stbmFtZXM6CU11c3QgYmUgInBoeV9jbGsiDQo+
ID4gKy0gcmVzZXRzOglNdXN0IGNvbnRhaW4gYW4gZW50cnkgZm9yIGVhY2ggaW4gcmVzZXQtbmFt
ZXMuDQo+ID4gKwkJU2VlIC4uL3Jlc2V0L3Jlc2V0LnR4dCBmb3IgZGV0YWlscy4NCj4gPiArLSBy
ZXNldC1uYW1lczoJTXVzdCBpbmNsdWRlICJzaWVycmFfcmVzZXQiIGFuZCAic2llcnJhX2FwYiIg
YW5kIG9uZSBmb3IgZWFjaA0KPiA+ICsJCXN1Yi1ub2RlLg0KPiA+ICsJCSJzaWVycmFfcmVzZXQi
IG11c3QgY29udHJvbCB0aGUgcmVzZXQgbGluZSB0byB0aGUgUEhZLg0KPiA+ICsJCSJzaWVycmFf
YXBiIiBtdXN0IGNvbnRyb2wgdGhlIHJlc2V0IGxpbmUgdG8gdGhlIEFQQiBQSFkNCj4gPiArCQlp
bnRlcmZhY2UuDQo+ID4gKwkJUmVzZXRzIGZvciBlYWNoIHN1Ym5vZGUgbXVzdCBjb250cm9sIHRo
ZSBtYXN0ZXIgbGFuZSBmb3IgdGhlDQo+ID4gKwkJc3Vibm9kZSBsYW5lIGdyb3VwLg0KPiANCj4g
V2hhdCBhcmUgdGhlIG5hbWVzPw0KPiANCkknbGwgdXBkYXRlIHRoaXMgdG8gdXNlIHRoZSBmdWxs
IG5hbWUgb2YgdGhlIHN1Ym5vZGUsIGUuZy4gZm9yIHN1Ym5vZGVzOg0KICBwY2llMF9waHkwOiBw
Y2llLXBoeUAwDQogIHBjaWUwX3BoeTE6IHBjaWUtcGh5QDINCnRoZW4gdGhlIHJlc2V0IG5hbWVz
IHdvdWxkIGJlOiAicGNpZS1waHlAMCIgYW5kICJwY2llLXBoeUAyIg0KDQo+ID4gKy0gcmVnOgkJ
cmVnaXN0ZXIgcmFuZ2UgZm9yIHRoZSBQSFkuDQo+ID4gKy0gcmVnLW5hbWVzOglNdXN0IGJlICJy
ZWciLg0KPiANCj4gS2luZCBvZiBwb2ludGxlc3Mgd2l0aCBvbmx5IDEuDQo+IA0KSSB3aWxsIHJl
bW92ZSByZWctbmFtZXMuDQoNCj4gPiArLSAjYWRkcmVzcy1jZWxsczogU2hvdWxkIGJlIDENCj4g
PiArLSAjc2l6ZS1jZWxsczoJU2hvdWxkIGJlIDANCj4gPiArDQo+ID4gK09wdGlvbmFsIHByb3Bl
cnRpZXM6DQo+ID4gKy0gY2RucyxhdXRvY29uZjoJSWYgcHJlc2VudCwgaW5kaWNhdGVzIHRoYXQg
dGhlIFBIWSByZWdpc3RlcnMgd2lsbA0KPiA+ICsJCQliZSBjb25maWd1cmVkIGJ5IGhhcmR3YXJl
LiAgSWYgbm90IHByZXNlbnQsIGFsbA0KPiA+ICsJCQlzdWItbm9kZSBvcHRpb25hbCBwcm9wZXJ0
aWVzIG11c3QgYmUgcHJvdmlkZWQuDQo+IA0KPiBib29sZWFuPw0KWWVzLCB3aWxsIHVwZGF0ZSB0
aGUgZGVzY3JpcHRpb24NCg0KPiANCj4gPiArDQo+ID4gK1N1Yi1ub2RlczoNCj4gPiArICBFYWNo
IGdyb3VwIG9mIFBIWSBsYW5lcyB3aXRoIGEgc2luZ2xlIG1hc3RlciBsYW5lIHNob3VsZCBiZSBy
ZXByZXNlbnRlZCBhcw0KPiA+ICsgIGEgc3ViLW5vZGUuIE5vdGUgdGhhdCB0aGUgYWN0dWFsIGNv
bmZpZ3VyYXRpb24gb2YgZWFjaCBsYW5lIGlzIGRldGVybWluZWQgYnkNCj4gPiArICBoYXJkd2Fy
ZSBzdHJhcHBpbmcsIGFuZCBtdXN0IG1hdGNoIHRoZSBjb25maWd1cmF0aW9uIHNwZWNpZmllZCBo
ZXJlLg0KPiA+ICsNCj4gPiArU3ViLW5vZGUgcmVxdWlyZWQgcHJvcGVydGllczoNCj4gPiArLSAj
cGh5LWNlbGxzOglHZW5lcmljIFBIWSBiaW5kaW5nOyBtdXN0IGJlIDAuDQo+ID4gKw0KPiA+ICtT
dWItbm9kZSBvcHRpb25hbCBwcm9wZXJ0aWVzOg0KPiA+ICstIHJlZzoJCQlUaGUgbWFzdGVyIGxh
bmUgbnVtYmVyLg0KPiA+ICstIGNkbnMsbnVtLWxhbmVzOglOdW1iZXIgb2YgbGFuZXMgaW4gdGhp
cyBncm91cC4gIEZyb20gMSB0byA0Lg0KPiA+ICstIGNkbnMscGh5LXR5cGU6CUNhbiBiZSBQSFlf
VFlQRV9QQ0lFIG9yIFBIWV9UWVBFX1VTQjMsIGRlcGVuZGluZyBvbg0KPiA+ICsJCQljb25maWd1
cmF0aW9uIG9mIGxhbmVzLg0KPiA+ICsNCj4gPiArRXhhbXBsZToNCj4gPiArCXBjaWVfcGh5NDog
cGNpZS1waHk0QGZkMjQwMDAwIHsNCj4gDQo+IHBjaWUtcGh5QGZkMjQwMDAwDQo+IA0KSSdsbCBj
aGFuZ2UgYXMgc3VnZ2VzdGVkLg0KDQo+ID4gKwkJY29tcGF0aWJsZSA9ICJjZG5zLHNpZXJyYS1w
aHktdDAiOw0KPiA+ICsJCXJlZyA9IDwweDAgMHhmZDI0MDAwMCAweDAgMHg0MDAwMD47DQo+ID4g
KwkJcmVnLW5hbWVzID0gInJlZyI7DQo+ID4gKwkJcmVzZXRzID0gPCZwaHlyc3QgMD4sIDwmcGh5
cnN0IDE+LDwmcGh5cnN0IDI+LDwmcGh5cnN0IDQ+Ow0KPiA+ICsJCXJlc2V0LW5hbWVzID0gInNp
ZXJyYV9yZXNldCIsInNpZXJyYV9hcGIiLCJwY2llX3BoeTAiLHBjaWVfcGh5MTsNCj4gDQo+IHNw
YWNlcyBhbmQgcXVvdGVzIG1pc3NpbmcuDQo+IA0KSSdsbCByZWZvcm1hdC4NCg0KPiA+ICsJCWNs
b2NrcyA9IDwmcGh5Y2xvY2s+Ow0KPiA+ICsJCWNsb2NrLW5hbWVzID0gInBoeV9jbGsiOw0KPiA+
ICsJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICsJCSNzaXplLWNlbGxzID0gPDA+Ow0KPiA+
ICsJCXBjaWUwX3BoeTA6IHBjaWUtcGh5MEAwIHsNCj4gDQo+IHBjaWUtcGh5QDANCj4gDQpJJ2xs
IGNoYW5nZSBhcyBzdWdnZXN0ZWQuDQoNCj4gPiArCQkJCXJlZyA9IDwwPjsNCj4gPiArCQkJCWNk
bnMsbnVtLWxhbmVzID0gPDI+Ow0KPiA+ICsJCQkJI3BoeS1jZWxscyA9IDwwPjsNCj4gPiArCQkJ
CWNkbnMscGh5LXR5cGUgPSA8UEhZX1RZUEVfUENJRT47DQo+ID4gKwkJfTsNCj4gPiArCQlwY2ll
MF9waHkxOiBwY2llLXBoeTFAMCB7DQo+IA0KPiBwY2llLXBoeUAyDQo+IA0KPiBPciByZWcgc2hv
dWxkIGJlIDE/DQo+IA0KcmVnIGlzIHRoZSBtYXN0ZXIgbGFuZSBudW1iZXIsIGFuZCBpbiB0aGlz
IGNhc2UgbXVzdCBiZSAyIG9yIGhpZ2hlciwNCnNpbmNlIHRoZSBzdWJub2RlIHdpdGggbWFzdGVy
IGxhbmUgbnVtYmVyIDAgaGFzIDIgbGFuZXMuDQpJJ2xsIGNoYW5nZSB0byBwY2llLXBoeUAyLCBh
bmQgYWRkIGFuIGV4cGxhbmF0aW9uLg0KDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMNCg0KPiA+
ICsJCQkJcmVnID0gPDI+Ow0KPiA+ICsJCQkJY2RucyxudW0tbGFuZXMgPSA8MT47DQo+ID4gKwkJ
CQkjcGh5LWNlbGxzID0gPDA+Ow0KPiA+ICsJCQkJY2RucyxwaHktdHlwZSA9IDxQSFlfVFlQRV9Q
Q0lFPjsNCj4gPiArCQl9Ow0KPiA+ICsNCj4gPiAtLQ0KPiA+IDEuOS4wDQo+ID4NCg==
