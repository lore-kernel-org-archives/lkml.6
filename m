Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8878ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640EC20869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="NfsRx+3W";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="foq4fljp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640EC20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeJSXhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 19:37:19 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:45016 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726667AbeJSXhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 19:37:19 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w9JFO1Eo031699;
        Fri, 19 Oct 2018 08:30:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=Q/ZWjAW+rXKYCE8aBHU6alf+5rqzkrnm7eWDSnXagq4=;
 b=NfsRx+3W58LaYvBNnFnyYPht0BCQTo64b2zIQT5CIRXk3eUxr7ijV9a5vmjIJrb3Uj9a
 dN6Hl/rt3MttC3MSmDJg6hHFKTSU0UkaJsaCg5OHp3oy7TwDTtm24OvImK2NX1/235rL
 rcYwDZ+idxu0COHWmhON+QNR31ddQFqBnE3B0enT//asCzBtlbvFK+X5T4ikekUIFART
 2hj3IRn8nT2KnqM1wb1fGSBjCMIOgu3K+w/louC5QYJCtE9JWLQQ3UpQSANog30r0jz4
 HtPoiAXM0zjMm/5zjzNQ+zMIW19i+QeGfwJcBy2hLbwAKzOYXsJqE4CChVHiKJWikx86 jw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=adouglas@cadence.com
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp0112.outbound.protection.outlook.com [207.46.163.112])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2n6qrf6p1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 19 Oct 2018 08:30:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/ZWjAW+rXKYCE8aBHU6alf+5rqzkrnm7eWDSnXagq4=;
 b=foq4fljpwjvF+aDZG4wmBavDi6xBpJCn5Lsi1Vr3cfguTrF3VP5x+kVbl9/p+DmMVAxOqj4YrfQGG6ZS99bYjvIb7YB9GvtMq9Fd1znWWfOArcOKPCXOk9NOWxwoL/hNEvzEJ+BLuOfH/2AvwetUYhJbNSxD/po3DYcyPROAskY=
Received: from MWHPR07MB3502.namprd07.prod.outlook.com (10.164.192.29) by
 MWHPR07MB3021.namprd07.prod.outlook.com (10.172.96.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.25; Fri, 19 Oct 2018 15:30:33 +0000
Received: from MWHPR07MB3502.namprd07.prod.outlook.com
 ([fe80::807b:c33e:bee7:ecd9]) by MWHPR07MB3502.namprd07.prod.outlook.com
 ([fe80::807b:c33e:bee7:ecd9%4]) with mapi id 15.20.1228.033; Fri, 19 Oct 2018
 15:30:33 +0000
From:   Alan Douglas <adouglas@cadence.com>
To:     Rob Herring <robh@kernel.org>
CC:     "kishon@ti.com" <kishon@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: phy: Document cadence Sierra PHY
 bindings
Thread-Topic: [PATCH 1/2] dt-bindings: phy: Document cadence Sierra PHY
 bindings
Thread-Index: AQHUWzJ+W1xP79ZrU0GuEYYnTzKjMqUgvsyAgAYKF7A=
Date:   Fri, 19 Oct 2018 15:30:33 +0000
Message-ID: <MWHPR07MB3502E5AD55EE63D83AA640E2D8F90@MWHPR07MB3502.namprd07.prod.outlook.com>
References: <1538582545-22041-1-git-send-email-adouglas@cadence.com>
 <20181015190929.GA22554@bogus>
In-Reply-To: <20181015190929.GA22554@bogus>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYWRvdWdsYXNcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1lY2VhMTc3ZS1kM2IzLTExZTgtYWI4Yy1mNDk2MzQ4NmY0ZWNcYW1lLXRlc3RcZWNlYTE3N2YtZDNiMy0xMWU4LWFiOGMtZjQ5NjM0ODZmNGVjYm9keS50eHQiIHN6PSI0NTk0IiB0PSIxMzE4NDQzNjYzNzI2NDAzODMiIGg9IlgwbGluVlZ3eGg0V3VtSmkrRFV5QnVVdUZoVT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR07MB3021;20:TfsUlNOv3qHxrkjZwnHZxxsyYw484f+ONdayQALmob8dGi0vN3H0FcrLo9Sf7LYMTRCjLWsy6ADhVcXQG+jcHKMEyV95Zwoe2Rnh8udslcT+WKP+lPawFx8iakcrKbz5csAFyPj96cuhYfWcZLfJ3YPH0vNdrLp9O8YCpzvhfTnpZA4LRWAoPMpM+d/oJvmE1Xqs+uqazG9y7Y0FzwHBjTlGtOCKp8abD8JlYT2gWJwimc1347SDkouQfnhD82A9
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1d9a8ab9-c84e-4230-996a-08d635d7cf7d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR07MB3021;
x-ms-traffictypediagnostic: MWHPR07MB3021:
x-microsoft-antispam-prvs: <MWHPR07MB30216F794B397744664DB518D8F90@MWHPR07MB3021.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72806322054110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR07MB3021;BCL:0;PCL:0;RULEID:;SRVR:MWHPR07MB3021;
x-forefront-prvs: 0830866D19
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(376002)(39860400002)(366004)(199004)(189003)(36092001)(71200400001)(7736002)(2900100001)(76176011)(478600001)(256004)(74316002)(7696005)(106356001)(186003)(102836004)(316002)(305945005)(86362001)(33656002)(54906003)(26005)(14454004)(105586002)(14444005)(486006)(8936002)(81156014)(53546011)(5660300001)(81166006)(6506007)(99286004)(8676002)(11346002)(476003)(97736004)(68736007)(6916009)(6436002)(9686003)(3846002)(53936002)(446003)(6246003)(6116002)(4326008)(66066001)(55016002)(71190400001)(5250100002)(2906002)(25786009)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3021;H:MWHPR07MB3502.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LWZ/cpqyKCd1BT2sFepd/hgFFcNOLl+Nrbl2CnKr0CD8h39m89nWuGv6j+sbmCluVJS4KBzNjFb6CpDtsTxNunKzSFgvwQX47EU+YrwJx+B/Ea5/lYavQqYbfXhrL++L0HSFdLJv2JOYCSQgslowahfVOp9VdB7Ouet/NbT+zNbueohBg4cRSzevx1GN034aCL5NL3Dy8Bjb9sc+VCSE+w7flegXRhnk8y4TUgl20ZkmnuuVLhetaYIVKjHNjgVOxEWwbSAXkFf7YXudDD/sdckwq5jHt1adHkl4C5wJs/N56fi2vWhgdrzbEMpGmdMCscsxpv3Cwt5hXnW+3yeFTALeRywVYC1xv54hinRiWEk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9a8ab9-c84e-4230-996a-08d635d7cf7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2018 15:30:33.3765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3021
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-19_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810190136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTUgT2N0b2JlciAyMDE4IDIwOjA5LCBSb2IgSGVycmluZyB3cm90ZToNCj4gT24gV2VkLCBP
Y3QgMDMsIDIwMTggYXQgMDU6MDI6MjVQTSArMDEwMCwgQWxhbiBEb3VnbGFzIHdyb3RlOg0KPiA+
IEFkZCBEVCBiaW5kaW5nIGRvY3VtZW50YXRpb24gZm9yIFNpZXJyYSBQSFkuICBUaGUgUEhZIHN1
cHBvcnRzDQo+ID4gYSBudW1iZXIgb2YgZGlmZmVyZW50IHByb3RvY29scywgaW5jbHVkaW5nIFBD
SWUgYW5kIFVTQi4NCj4gPg0KPiA+IFRoZSBQSFkgbGFuZXMgbWF5IGJlIGNvbmZpZ3VyZWQgYXMg
c2luZ2xlIG9yIG11bHRpLWxhbmUgbGlua3MuDQo+ID4gRWFjaCBsaW5rIGlzIHRyZWF0ZWQgYXMg
YSBzZXBhcmF0ZSBzdWItbm9kZS4gIEZvciBleGFtcGxlLCBpZg0KPiA+IHRoZXJlIGFyZSA0IGxh
bmVzIGluIHRvdGFsIHRoZSBmaXJzdCAyIG1pZ2h0IGJlIGNvbmZpZ3VyZWQgYXMNCj4gPiBhIG11
bHRpLWxhbmUgUENJZSBsaW5rIHdoaWxlIHRoZSBvdGhlciB0d28gYXJlIHNpbmdsZSBsYW5lDQo+
ID4gVVNCIGxpbmtzLCBhbmQgaW4gdGhpcyBjYXNlIHRoZXJlIHdvdWxkIGJlIDMgc3ViLW5vZGVz
Lg0KPiA+DQo+ID4gVGhlcmUgYXJlIHR3byByZXNldHMgZm9yIHRoZSBQSFkgYmxvY2sgKG9uZSBm
b3IgQVBCIHJlZ2lzdGVyDQo+ID4gYWNjZXNzLCBvbmUgZm9yIHRoZSBQSFkgbGluaykgYW5kIHNl
cGFyYXRlIHJlc2V0cyBmb3IgZWFjaA0KPiA+IGxpbmsuICBGb3IgbXVsdGktbGFuZSBsaW5rcywg
dGhlIHJlc2V0IGNvcnJlc3BvbmRzIHRvIHRoZQ0KPiA+IHJlc2V0IGxpbmUgb24gdGhlIG1hc3Rl
ciBsYW5lLCB0aGUgcmVzZXRzIG9uIG90aGVyIGxhbmVzDQo+ID4gaGF2ZSBubyBlZmZlY3QuDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGFuIERvdWdsYXMgPGFkb3VnbGFzQGNhZGVuY2UuY29t
Pg0KPiA+IC0tLQ0KPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvY2Rucy1zaWVycmEt
cGh5LnR4dCAgICB8IDY4ICsrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDY4IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvY2Rucy1zaWVycmEtcGh5LnR4dA0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvY2Rucy1z
aWVycmEtcGh5LnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvY2Ru
cy1zaWVycmEtDQo+IHBoeS50eHQNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4
IDAwMDAwMDAuLjBlMmYzZTMNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9jZG5zLXNpZXJyYS1waHkudHh0DQo+ID4gQEAg
LTAsMCArMSw2OCBAQA0KPiA+ICtDYWRlbmNlIFNpZXJyYSBQSFkNCj4gPiArLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCj4gPiArDQo+ID4gK1JlcXVpcmVkIHByb3BlcnRpZXM6DQo+ID4gKy0gY29t
cGF0aWJsZToJY2RucyxzaWVycmEtcGh5LXQwDQo+ID4gKy0gY2xvY2tzOglNdXN0IGNvbnRhaW4g
YW4gZW50cnkgaW4gY2xvY2stbmFtZXMuDQo+ID4gKwkJU2VlIC4uL2Nsb2Nrcy9jbG9jay1iaW5k
aW5ncy50eHQgZm9yIGRldGFpbHMuDQo+ID4gKy0gY2xvY2stbmFtZXM6CU11c3QgYmUgInBoeV9j
bGsiDQo+ID4gKy0gcmVzZXRzOglNdXN0IGNvbnRhaW4gYW4gZW50cnkgZm9yIGVhY2ggaW4gcmVz
ZXQtbmFtZXMuDQo+ID4gKwkJU2VlIC4uL3Jlc2V0L3Jlc2V0LnR4dCBmb3IgZGV0YWlscy4NCj4g
PiArLSByZXNldC1uYW1lczoJTXVzdCBpbmNsdWRlICJzaWVycmFfcmVzZXQiIGFuZCAic2llcnJh
X2FwYiIgYW5kIG9uZSBmb3IgZWFjaA0KPiA+ICsJCXN1Yi1ub2RlLg0KPiA+ICsJCSJzaWVycmFf
cmVzZXQiIG11c3QgY29udHJvbCB0aGUgcmVzZXQgbGluZSB0byB0aGUgUEhZLg0KPiA+ICsJCSJz
aWVycmFfYXBiIiBtdXN0IGNvbnRyb2wgdGhlIHJlc2V0IGxpbmUgdG8gdGhlIEFQQiBQSFkNCj4g
PiArCQlpbnRlcmZhY2UuDQo+ID4gKwkJVGhlIG5hbWUgb2YgdGhlIHJlc2V0IGZvciBlYWNoIHN1
Yi1ub2RlIHNob3VsZCBtYXRjaCB0aGUgZnVsbA0KPiA+ICsJCW5hbWUgb2YgdGhlIHN1Yi1ub2Rl
LiAgVGhlIHN1Yi1ub2RlIHJlc2V0cyBtdXN0IGNvbnRyb2wgdGhlDQo+ID4gKwkJcmVzZXQgbGlu
ZSBmb3IgdGhlIG1hc3RlciBsYW5lIG9mIHRoZSBzdWItbm9kZS4NCj4gDQo+IEFkZCBhIHJlc2V0
cyBwcm9wZXJ0eSB0byB0aGUgc3ViLW5vZGVzIGluc3RlYWQuDQo+IA0KV2lsbCBkby4gIEFzIGZh
ciBhcyBJIGNhbiBzZWUgaXQgcHJldmVudHMgbWUgdXNpbmcgZGV2bV9yZXNldF9jb250cm9sX2dl
dCgpDQp0aG91Z2gsIHNvIEkgbmVlZCB0byB3b3JrIG91dCB0aGUgYmVzdCB3YXkgdG8gcHV0IHRo
ZXNlIHJlc2V0cyBvbiByZW1vdmUoKQ0KDQo+ID4gKy0gcmVnOgkJcmVnaXN0ZXIgcmFuZ2UgZm9y
IHRoZSBQSFkuDQo+ID4gKy0gI2FkZHJlc3MtY2VsbHM6IE11c3QgYmUgMQ0KPiA+ICstICNzaXpl
LWNlbGxzOglNdXN0IGJlIDANCj4gPiArDQo+ID4gK09wdGlvbmFsIHByb3BlcnRpZXM6DQo+ID4g
Ky0gY2RucyxhdXRvY29uZjoJQSBib29sZWFuIHByb3BlcnR5IHdob3NlIHByZXNlbmNlIGluZGlj
YXRlcyB0aGF0IHRoZQ0KPiA+ICsJCQlQSFkgcmVnaXN0ZXJzIHdpbGwgYmUgY29uZmlndXJlZCBi
eSBoYXJkd2FyZS4gSWYgbm90DQo+ID4gKwkJCXByZXNlbnQsIGFsbCBzdWItbm9kZSBvcHRpb25h
bCBwcm9wZXJ0aWVzIG11c3QgYmUNCj4gPiArCQkJcHJvdmlkZWQuDQo+ID4gKw0KPiA+ICtTdWIt
bm9kZXM6DQo+ID4gKyAgRWFjaCBncm91cCBvZiBQSFkgbGFuZXMgd2l0aCBhIHNpbmdsZSBtYXN0
ZXIgbGFuZSBzaG91bGQgYmUgcmVwcmVzZW50ZWQgYXMNCj4gPiArICBhIHN1Yi1ub2RlLiBOb3Rl
IHRoYXQgdGhlIGFjdHVhbCBjb25maWd1cmF0aW9uIG9mIGVhY2ggbGFuZSBpcyBkZXRlcm1pbmVk
IGJ5DQo+ID4gKyAgaGFyZHdhcmUgc3RyYXBwaW5nLCBhbmQgbXVzdCBtYXRjaCB0aGUgY29uZmln
dXJhdGlvbiBzcGVjaWZpZWQgaGVyZS4NCj4gPiArDQo+ID4gK1N1Yi1ub2RlIHJlcXVpcmVkIHBy
b3BlcnRpZXM6DQo+ID4gKy0gI3BoeS1jZWxsczoJR2VuZXJpYyBQSFkgYmluZGluZzsgbXVzdCBi
ZSAwLg0KPiA+ICsNCj4gPiArU3ViLW5vZGUgb3B0aW9uYWwgcHJvcGVydGllczoNCj4gPiArLSBy
ZWc6CQkJVGhlIG1hc3RlciBsYW5lIG51bWJlci4gIFRoaXMgaXMgdGhlIGxvd2VzdCBudW1iZXJl
ZA0KPiA+ICsJCQlsYW5lIGluIHRoZSBsYW5lIGdyb3VwLg0KPiANCj4gSG93IGRvIHlvdSBuYW1l
IHRoZSBub2RlcyBpZiB0aGlzIGlzIG9wdGlvbmFsPw0KPiANCkknbGwgY2hhbmdlIHRoaXMgdG8g
YmUgcmVxdWlyZWQuDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50cywNCkFsYW4NCg0KPiA+ICst
IGNkbnMsbnVtLWxhbmVzOglOdW1iZXIgb2YgbGFuZXMgaW4gdGhpcyBncm91cC4gIEZyb20gMSB0
byA0LiAgVGhlDQo+ID4gKwkJCWdyb3VwIGlzIG1hZGUgdXAgb2YgY29uc2VjdXRpdmUgbGFuZXMu
DQo+ID4gKy0gY2RucyxwaHktdHlwZToJQ2FuIGJlIFBIWV9UWVBFX1BDSUUgb3IgUEhZX1RZUEVf
VVNCMywgZGVwZW5kaW5nIG9uDQo+ID4gKwkJCWNvbmZpZ3VyYXRpb24gb2YgbGFuZXMuDQo+ID4g
Kw0KPiA+ICtFeGFtcGxlOg0KPiA+ICsJcGNpZV9waHk0OiBwY2llLXBoeUBmZDI0MDAwMCB7DQo+
ID4gKwkJY29tcGF0aWJsZSA9ICJjZG5zLHNpZXJyYS1waHktdDAiOw0KPiA+ICsJCXJlZyA9IDww
eDAgMHhmZDI0MDAwMCAweDAgMHg0MDAwMD47DQo+ID4gKwkJcmVzZXRzID0gPCZwaHlyc3QgMD4s
IDwmcGh5cnN0IDE+LCA8JnBoeXJzdCAyPiwgPCZwaHlyc3QgND47DQo+ID4gKwkJcmVzZXQtbmFt
ZXMgPSAic2llcnJhX3Jlc2V0IiwgInNpZXJyYV9hcGIiLA0KPiA+ICsJCQkJInBjaWVfcGh5QDAi
LCAicGNpZV9waHlAMiI7DQo+ID4gKwkJY2xvY2tzID0gPCZwaHljbG9jaz47DQo+ID4gKwkJY2xv
Y2stbmFtZXMgPSAicGh5X2NsayI7DQo+ID4gKwkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4g
KwkJI3NpemUtY2VsbHMgPSA8MD47DQo+ID4gKwkJcGNpZTBfcGh5MDogcGNpZS1waHlAMCB7DQo+
ID4gKwkJCQlyZWcgPSA8MD47DQo+ID4gKwkJCQljZG5zLG51bS1sYW5lcyA9IDwyPjsNCj4gPiAr
CQkJCSNwaHktY2VsbHMgPSA8MD47DQo+ID4gKwkJCQljZG5zLHBoeS10eXBlID0gPFBIWV9UWVBF
X1BDSUU+Ow0KPiA+ICsJCX07DQo+ID4gKwkJcGNpZTBfcGh5MTogcGNpZS1waHlAMiB7DQo+ID4g
KwkJCQlyZWcgPSA8Mj47DQo+ID4gKwkJCQljZG5zLG51bS1sYW5lcyA9IDwxPjsNCj4gPiArCQkJ
CSNwaHktY2VsbHMgPSA8MD47DQo+ID4gKwkJCQljZG5zLHBoeS10eXBlID0gPFBIWV9UWVBFX1BD
SUU+Ow0KPiA+ICsJCX07DQo+ID4gKw0KPiA+IC0tDQo+ID4gMS45LjANCj4gPg0K
