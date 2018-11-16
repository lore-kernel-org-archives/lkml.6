Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D8CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B072C2087C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Byd4xNxi";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="rdbJbwKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B072C2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389736AbeKPXDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 18:03:36 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:39730 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727999AbeKPXDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 18:03:36 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAGCnBYn027860;
        Fri, 16 Nov 2018 04:50:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=proofpoint;
 bh=dgpr7gucIyWPs5Ax7uoNcxJ17Cq+neSI5syqrTM4E2M=;
 b=Byd4xNxiJzl3SJiAr/izBLV7u0Uf5pi5gqrliX5KfKK6lXCrvZOVqr8elIEaSdaLqLq/
 fsSIetqEbFf1DbtwGhSUdZzn9hTWukfrYSkVop1h/p78NtjjwRLFUQCsfk2YufK9zzs1
 EmgquUXh+WN2r/SE+bJG/FLjtifrHVbPAkvl/QEuiREDnlkNty1Kr4Dk8hcfepP5U55n
 3Y/YrEpl2B1P3LOcqpZPLsKtqD9fLHU/7P8r28kdVORwopQcVSe821eZLUj/fFFhhEcm
 fnvu60X7NiMKSFBdSGrzi5BcBZLFnau6VfRggIwQgLUhoqDqP8NOKtmiyc8vwV/lK2Ps vg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pgaj@cadence.com
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp0116.outbound.protection.outlook.com [216.32.181.116])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2nsegh4j0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Nov 2018 04:50:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgpr7gucIyWPs5Ax7uoNcxJ17Cq+neSI5syqrTM4E2M=;
 b=rdbJbwKuvswYrrKyKsMsi1zVMDYNuhNUOQIvY2b0UvH5ollaqrV88kcM8YAFwGZ2ptZLj9JF5GxKV6k4ysnY2DpLTTyo/LW1OGkJpn4ARWmbPTnazfq6kZpcGpyfUBN8QKApuOKSlCHT+WA+RE93fKRWqVpqWBhT6v7zuqnSpgM=
Received: from BYAPR07MB5144.namprd07.prod.outlook.com (20.176.254.209) by
 BYAPR07MB4663.namprd07.prod.outlook.com (52.135.204.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Fri, 16 Nov 2018 12:50:39 +0000
Received: from BYAPR07MB5144.namprd07.prod.outlook.com
 ([fe80::d053:e762:4b70:bbe4]) by BYAPR07MB5144.namprd07.prod.outlook.com
 ([fe80::d053:e762:4b70:bbe4%3]) with mapi id 15.20.1294.045; Fri, 16 Nov 2018
 12:50:39 +0000
From:   Przemyslaw Gaj <pgaj@cadence.com>
To:     vitor <vitor.soares@synopsys.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Wolfram Sang <wsa@the-dreams.de>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Peter Rosin <peda@axentia.se>,
        Mike Shettel <mshettel@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v10 0/9] Add the I3C subsystem
Thread-Topic: [PATCH v10 0/9] Add the I3C subsystem
Thread-Index: AQHUbTpJDuExdoDPy0OoPELzXDBpUKVQ3xiAgAAL/YCAACKsgIAAB34AgAAraICAAA/6AIABJZIAgAAWDAA=
Date:   Fri, 16 Nov 2018 12:50:39 +0000
Message-ID: <8FFB4883-7220-4DC0-B012-5EC89134448E@cadence.com>
References: <20181026144333.12276-1-boris.brezillon@bootlin.com>
 <76b1d15d-232c-d8ba-5eba-8394e71be725@synopsys.com>
 <20181115135731.25f60990@bbrezillon> <20181115150137.GB4169@kunai>
 <20181115162826.42b54776@bbrezillon>
 <1d64f21a-ad24-94e0-2c17-25729ef59a31@synopsys.com>
 <20181115200058.1869afdb@bbrezillon>
 <5f946406-a205-3802-aefd-ebd8b5a72b0b@synopsys.com>
In-Reply-To: <5f946406-a205-3802-aefd-ebd8b5a72b0b@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4663;20:hp0c0TzWYKGPc9Ksopit+fIysy0bXiy0z73OjLMO7bE+Obsr+gw4OrWpRPUqCkqIAA+1ao41akeoOWJ+evF6YE1EAAbbcJdxtQYjLjP2yfYj+edBRveHSknH89g9eo2We9fOH+NMN+wajUxgrOa5VyTuzu2ImxiIi/c6CBWwnYLmprDgx+mlH95jTiw5aM0EJsOJ4frfYr+M3IfrR+jYZ5cZ5X3/QrWrsgk5PlcwhGxbt7pXA9Ux84k56V6vKqoh
x-ms-office365-filtering-correlation-id: 0f3f6982-ed33-4d76-b33d-08d64bc21c8b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4663;
x-ms-traffictypediagnostic: BYAPR07MB4663:
x-microsoft-antispam-prvs: <BYAPR07MB466373C339383DB3043ED3A7C2DD0@BYAPR07MB4663.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231415)(944501410)(52105112)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB4663;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4663;
x-forefront-prvs: 0858FF8026
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(39860400002)(346002)(366004)(36092001)(189003)(199004)(256004)(7736002)(99286004)(305945005)(7416002)(86362001)(6486002)(71190400001)(81166006)(83716004)(8676002)(6512007)(6436002)(229853002)(53936002)(71200400001)(36756003)(4326008)(5660300001)(25786009)(8936002)(6246003)(478600001)(68736007)(6506007)(476003)(11346002)(486006)(2906002)(66066001)(186003)(2900100001)(446003)(105586002)(102836004)(316002)(33656002)(54906003)(110136005)(106356001)(97736004)(26005)(53546011)(76176011)(14454004)(6116002)(93886005)(82746002)(81156014)(2616005)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4663;H:BYAPR07MB5144.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JY4LNDveAIf7gmTcJNn4b6fuzrfeRVeeqAGyDzPZV5FFtQpGJT0CPFkenRju5oyYbUliItP2Ki1FbcYvH6u/VJHZhPffxMVWL2BenYyHuovIsoa6ucWnWLzwXrXZnT+pFxyO3qw3AzhQt9q2E1oqOqGhNUJUoNw/VQ+hTC8gMwCakthEoGRbOJsA4Sv4dO2R6JBIu8fCdJQcDo5dyP6ZRh8Y3h1uIqPISQOGOwpwC2lnEaMWOGubYRTEhBS+ti2VP6qFuBYxg6SEnVhu69+ZqCj3cMHMpmD/2s+N0TMMjMAsALBzC0raPuXPl6pF/ySXlZvvz7dW8dr4P0FSc3jCrOosMguwszS76NachPy9xVo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <000C5ABA9CA7694F87E9835B9F20078F@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3f6982-ed33-4d76-b33d-08d64bc21c8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2018 12:50:39.0566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4663
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-16_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811160114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVml0b3IsDQoNCu+7v09uIDExLzE2LzE4LCAxOjMyIFBNLCAidml0b3IiIDx2aXRvci5zb2Fy
ZXNAc3lub3BzeXMuY29tPiB3cm90ZToNCg0KICAgIEVYVEVSTkFMIE1BSUwNCiAgICANCiAgICAN
CiAgICBIaSBCb3JpcywNCiAgICANCiAgICANCiAgICBPbiAxNS8xMS8xOCAxOTowMCwgQm9yaXMg
QnJlemlsbG9uIHdyb3RlOg0KICAgID4gT24gVGh1LCAxNSBOb3YgMjAxOCAxODowMzo0NyArMDAw
MA0KICAgID4gdml0b3IgPHZpdG9yLnNvYXJlc0BzeW5vcHN5cy5jb20+IHdyb3RlOg0KICAgID4N
CiAgICA+PiBIaSBCb3JpcywNCiAgICA+Pg0KICAgID4+DQogICAgPj4gT24gMTUvMTEvMTggMTU6
MjgsIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCiAgICA+Pj4gT24gVGh1LCAxNSBOb3YgMjAxOCAx
NjowMTozNyArMDEwMA0KICAgID4+PiBXb2xmcmFtIFNhbmcgPHdzYUB0aGUtZHJlYW1zLmRlPiB3
cm90ZToNCiAgICA+Pj4gICANCiAgICA+Pj4+IEhpIEJvcmlzLA0KICAgID4+Pj4gICANCiAgICA+
Pj4+PiBXaGF0IHdlIGNvdWxkIGRvIHRob3VnaCwgaXMgZXhwb3NlIEkzQyBkZXZpY2VzIHRoYXQg
ZG8gbm90IGhhdmUgYQ0KICAgID4+Pj4+IGRyaXZlciBpbiBrZXJuZWwgc3BhY2UsIGxpa2Ugc3Bp
ZGV2IGRvZXMuDQogICAgPj4+PiAuLi4NCiAgICA+Pj4+ICAgDQogICAgPj4+Pj4gTWFyaywgV29s
ZnJhbSwgQXJuZCwgR3JlZywgYW55IG9waW5pb24/DQogICAgPj4+PiBJcyB0aGVyZSBhIGJlbmVm
aXQgZm9yIGhhdmluZyBkcml2ZXJzIGluIHVzZXJzcGFjZT8gTXkgZ3V0IGZlZWxpbmcgaXMgdG8N
CiAgICA+Pj4+IGVuY291cmFnZSBwZW9wbGUgdG8gd3JpdGUga2VybmVsIGRyaXZlcnMuIElmIHRo
aXMgaXMsIGZvciBzb21lIHJlYXNvbiwNCiAgICA+Pj4+IG5vdCBwb3NzaWJsZSBmb3Igc29tZSBk
cml2ZXIsIHRoZW4gd2UgaGF2ZSBhIHVzZSBjYXNlIGF0IGhhbmQgdG8gdGVzdA0KICAgID4+Pj4g
dGhlIHRoZW4tdG8tYmUtZGV2ZWxvcGVkIHVzZXJzcGFjZSBpbnRlcmZhY2UgYWdhaW5zdC4gVW50
aWwgdGhlbiwgSQ0KICAgID4+Pj4gcGVyc29uYWxseSB3b3VsZG4ndCB3YXN0ZSBlZmZvcnQgb24g
ZGVzaWduaW5nIGl0IHdpdGhvdXQgYSB1c2VyIGluDQogICAgPj4+PiBzaWdodC4NCiAgICA+Pj4g
SSBraW5kIG9mIGFncmVlIHdpdGggdGhhdC4gVml0b3IsIGRvIHlvdSBoYXZlIGEgdXNlIGNhc2Ug
aW4gbWluZCBmb3INCiAgICA+Pj4gc3VjaCB1c2Vyc3BhY2UgZHJpdmVycz8gSSBkb24ndCB0aGlu
ayBpdCdzIHdvcnRoIGRlc2lnbmluZyBhbiBBUEkgZm9yDQogICAgPj4+IHNvbWV0aGluZyB3ZSBk
b24ndCBuZWVkICh5ZXQpLg0KICAgID4+IE15IHVzZSBjYXNlIGlzIGEgdG9vbCBmb3IgdGVzdHMs
IGxldHMgc2F5IGxpa2UgdGhlIGkyYyB0b29scy4NCiAgICA+IFdoYXQgd291bGQgeW91IGxpa2Ug
dG8gdGVzdCBleGFjdGx5Pw0KICAgID4NCiAgICA+PiBUaGVyZSBpcw0KICAgID4+IG90aGVyIHN1
YnN5c3RlbXMsIHNvbWUgb2YgdGhlbSBtZW50aW9uZWQgb24gdGhpcyB0aHJlYWQsIHRoYXQgaGF2
ZSBhbmQNCiAgICA+PiBpb2N0bCBzeXN0ZW0gY2FsbCBvciBvdGhlciBtZXRob2QgdG8gY2hhbmdl
IHBhcmFtZXRlcnMgb3Igc2VuZCBkYXRhLg0KICAgID4gSSBkb24ndCB0aGluayB0aGV5IGFkZGVk
IHRoZSAvZGV2IGludGVyZmFjZSBiZWZvcmUgaGF2aW5nIGEgcmVhbCB1c2UNCiAgICA+IGNhc2Ug
Zm9yIGl0Lg0KICAgID4NCiAgICA+Pg0KICAgID4+IEkgcmlzZSB0aGlzIHRvcGljIGJlY2F1c2Ug
SSByZWFsbHkgdGhpbmsgaXQgd29ydGggdG8gZGVmaW5lIG5vdyBob3cgdGhpcw0KICAgID4+IHNo
b3VsZCBiZSBkZXNpZ24gKGFuZCBmb3IgbWUgaG93IHRvIGRvIHRoZSB0aGluZ3MgcmlnaHQpIHRv
IGF2b2lkIGZ1dHVyZQ0KICAgID4+IGlzc3Vlcy4NCiAgICA+IEFjdHVhbGx5IGl0IHNob3VsZCBi
ZSBkb25lIHRoZSBvdGhlciB3YXkgYXJvdW5kOiB5b3Ugc2hvdWxkIGhhdmUgYSByZWFsDQogICAg
PiBuZWVkIGFuZCB0aGUgL2RldiBpbnRlcmZhY2Ugc2hvdWxkIGJlIGRlc2lnbmVkIHRvIGZ1bGZp
bGwgdGhpcyBuZWVkLg0KICAgID4gQmFzZWQgb24gdGhpcyByZWFsIHVzZSBjYXNlIHdlIGNhbiBk
aXNjdXNzIG90aGVyIHBvdGVudGlhbCB1c2FnZSB0aGF0DQogICAgPiBtaWdodCBhcHBlYXIgaW4g
dGhlIGZ1dHVyZSBhbmQgdHJ5IHRvIGRlc2lnbiBzb21ldGhpbmcgbW9yZQ0KICAgID4gZnV0dXJl
LXByb29mLCBidXQgY2xlYXJseSwgdGhpcyB1c2Vyc3BhY2UgaW50ZXJmYWNlIHNob3VsZCBiZSBk
cml2ZW4gYnkNCiAgICA+IGEgcmVhbC93ZWxsLWRlZmluZWQgdXNlIGNhc2UuDQogICAgPg0KICAg
ID4gQWxzbywgZXhwb3NpbmcgdGhpbmdzIHRvIHVzZXJzcGFjZSBpcyB3YXkgbW9yZSByaXNreSB0
aGFuIGFkZGluZyBhIG5ldw0KICAgID4gaW4ta2VybmVsIHN1YnN5c3RlbS9mcmFtZXdvcmssIGJl
Y2F1c2UgaXQgdGhlbiBiZWNvbWVzIHBhcnQgb2YgdGhlDQogICAgPiBzdGFibGUgQUJJLg0KICAg
ID4NCiAgICA+IFRvIG1ha2UgdGhpbmdzIGNsZWFyZXIsIEknbSBub3QgYWdhaW5zdCB0aGUgaWRl
YSBvZiBleHBvc2luZyBJM0MNCiAgICA+IGRldmljZXMgKG9yIEkzQyBidXNlcykgdG8gdXNlcnNw
YWNlLCBidXQgSSdkIGxpa2UgdG8gdW5kZXJzdGFuZCB3aGF0IHlvdQ0KICAgID4gcGxhbiB0byBk
byB3aXRoIHRoYXQuIElmIHRoaXMgaXMgYWJvdXQgdGVzdGluZywgd2hhdCBraW5kIG9mIHRlc3Rz
DQogICAgPiB5b3UnZCBsaWtlIHRvIHJ1bi4gSWYgdGhpcyBpcyBhYm91dCBkZXZlbG9waW5nIGRy
aXZlcnMgaW4gdXNlcnNwYWNlLA0KICAgID4gd2h5IGNhbid0IHRoZXNlIGJlIGRvbmUgaW4ga2Vy
bmVsIHNwYWNlIChsaWNlbnNlIGlzc3Vlcz8pLCBhbmQgd2hhdA0KICAgID4gd291bGQgdGhvc2Ug
ZHJpdmVycyBiZSBhbGxvd2VkIHRvIGRvPw0KICAgIA0KICAgIA0KICAgIEJhc2ljYWxseSBJIG5l
ZWQgYSB0b29sIHRoYXQgaGVscCBtZSBkdXJpbmcgdGhlIGRldmVsb3BtZW50IGFuZCB0byBhdm9p
ZCANCiAgICBtZSB0byB3cml0ZSBhIGR1bW15IGRyaXZlciBmb3IgZWFjaCBkZXZpY2UgdGhhdCBJ
IHRlc3QuDQoNCkZvciBub3cgd2UgYXJlIGRvaW5nIGl0IHRoYXQgd2F5LiBTZXBhcmF0ZSBkdW1t
eSBkcml2ZXIgZm9yIGVhY2ggZGV2aWNlLg0KICAgIA0KICAgIEZvciBpbnN0YW5jZXMgZG8gc29t
ZSByZWFkL3dyaXRlLCBnZXQvc2V0IGNjYyBjb21tYW5kcywgaWYgc29tZXRoaW5nIA0KICAgIGdv
ZXMgd3JvbmcgZHVyaW5nIHRoZSBidXMgaW5pdGlhbGl6YXRpb24gaGF2ZSBhIHRvIGRlYnVnIGV0
Yy4uLg0KICAgIA0KVGhhdCBzb3VuZHMgZ29vZCB0byBoYXZlIHBvc3NpYmlsaXR5IHRvIG1ha2Ug
c2ltcGxlIHJlYWRzL3dyaXRlcyBhbmQgDQpzZW5kIGJhc2ljIGNjYyBjb21tYW5kcy4gQnV0IG9m
IGNvdXJzZSBrZWVwaW5nIGluIG1pbmQgdGhhdCBJM0MgYnVzIGlzIA0KbW9yZSBjb21wbGljYXRl
ZCB0aGFuIEkyQywgYXMgQm9yaXMgbWVudGlvbmVkIGJlZm9yZS4NCiAgICANCiAgICBGb3IgbWUg
dGhpcyBpcyBhIHZhbGlkIHVzZSBjYXNlIGFuZCBJIGltYWdpbmUgd2hlbiBwZW9wbGUgc3RhcnQg
dG8gDQogICAgZGV2ZWxvcCBpbiBpM2MgdGhpcyBpbnRlcmZhY2Ugd2lsbCBoZWxwIGV2ZXJ5b25l
Lg0KICAgIA0KICAgIA0KICAgIEJlc3QgcmVnYXJkcywNCiAgICANCiAgICBWaXRvciBTb2FyZXMN
CiAgICANClJlZ2FyZHMsDQpQcnplbWVrDQogICAgDQoNCg==
