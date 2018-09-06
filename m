Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A89C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E91E2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="YZOZA0HA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E91E2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbeIFS4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:56:50 -0400
Received: from mail-eopbgr730055.outbound.protection.outlook.com ([40.107.73.55]:10400
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729073AbeIFS4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nA8IXc/43/ZpbdfTfNRS434WJV74rfavs/bm8SYuZMc=;
 b=YZOZA0HARxHKMBSyu9LxVtOLoXZ76/zmQKHxh420If2tZB++HspwjWlVvZElbmBiVQpIerKo6d2UvEghoecCJXy27g1cZUfgKzZ3m64FM/yw7rbFXc8TIHwCj3QV/F5bs3svRbjBCfmvdEteTfG2DrnY8YOdZPwgVgPiTeRpjxc=
Received: from BYAPR07MB5144.namprd07.prod.outlook.com (20.176.254.209) by
 BYAPR07MB5382.namprd07.prod.outlook.com (20.177.125.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Thu, 6 Sep 2018 14:20:55 +0000
Received: from BYAPR07MB5144.namprd07.prod.outlook.com
 ([fe80::581:6eee:fab6:4c99]) by BYAPR07MB5144.namprd07.prod.outlook.com
 ([fe80::581:6eee:fab6:4c99%4]) with mapi id 15.20.1122.009; Thu, 6 Sep 2018
 14:20:55 +0000
From:   Przemyslaw Gaj <pgaj@cadence.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Wolfram Sang <wsa@the-dreams.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
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
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v6 01/10] i3c: Add core I3C infrastructure
Thread-Topic: [PATCH v6 01/10] i3c: Add core I3C infrastructure
Thread-Index: AQHUH3VT99XuaYWr3kWHpjq9POOKYqTML50AgALgfQCAAFeJAIAABncAgAXdiQCAAANWgIAAMGEAgAMUiwCAAHYxAIAFiUGAgAUNtQD//+MCAIAABCaAgAAqtID//+S2gIAAJKwA
Date:   Thu, 6 Sep 2018 14:20:55 +0000
Message-ID: <A207EE0E-9DBC-4A39-822C-37B09D0F81B3@cadence.com>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <20180719152930.3715-2-boris.brezillon@bootlin.com>
 <d2f40cc2-b344-69d1-4314-83524ad7b178@synopsys.com>
 <20180824143934.6d6b6487@bbrezillon>
 <bdb2924f-ecfa-1da3-41db-9ac77d4d933b@synopsys.com>
 <20180824201600.7d80bca9@bbrezillon>
 <fe839027-c4d7-4d6f-412b-5b315cbc7a39@synopsys.com>
 <20180828140209.29155d00@bbrezillon>
 <4DBE768F-3CDC-41BE-9CC8-E294E7277CB1@cadence.com>
 <8abfb007-d755-36a4-5960-fddd61d04aa2@synopsys.com>
 <3D2681D9-1ACC-42FF-9FAB-D86B3C689003@cadence.com>
 <9584757a-e7e2-5bfe-fc2c-e9bc14ad65a8@synopsys.com>
 <25862F03-9823-42B0-87AC-AE36D7E9C780@cadence.com>
 <CAK8P3a3pkddD9VnogYryQKoL9Z_5qVRBXd6yr1z6CqGU692rXg@mail.gmail.com>
 <20180906151437.4259d6fc@bbrezillon>
 <5AD923AE-E86E-4414-A48F-CE7399E18431@cadence.com>
 <20180906160947.3c80072f@bbrezillon>
In-Reply-To: <20180906160947.3c80072f@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pgaj@cadence.com; 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5382;20:lTGWSLiY+l/jQCP3nDEvzguTcxVUf8w3zBFVNahDgGJUi7FUzSPdC+NC2bzGx3Ob6ojGs1O44yjTMxoKkZDrGJNclJqEtumU22gwoXh3HwdXndVKTHY6rPSMBihIzNn+cs+e1OK/Puc/oHrk1MkaI2mOoMi1D+lmlCe/tKF/oSjENTo62zEsVbAJl+YQS1muHzja3FNWQlw7w3uroUYzQFs/ZCgDMsbK/8V0myocROsaNA4TEPKJm4uJqw9GeVYY
x-ms-office365-filtering-correlation-id: 9c44d728-7a5c-40e3-f9d8-08d61403f5a1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5382;
x-ms-traffictypediagnostic: BYAPR07MB5382:
x-microsoft-antispam-prvs: <BYAPR07MB5382A6F93415248370078E41C2010@BYAPR07MB5382.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(60795455431006)(10436049006162)(72170088055959)(72806322054110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BYAPR07MB5382;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5382;
x-forefront-prvs: 0787459938
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(346002)(396003)(376002)(199004)(189003)(36092001)(54014002)(486006)(2900100001)(6436002)(229853002)(575784001)(86362001)(14444005)(54906003)(6486002)(105586002)(106356001)(26005)(476003)(256004)(5250100002)(7416002)(102836004)(6506007)(53546011)(2616005)(11346002)(446003)(316002)(186003)(76176011)(99286004)(6916009)(8676002)(81156014)(7736002)(81166006)(6246003)(5660300001)(4326008)(33656002)(8936002)(6306002)(6512007)(6116002)(97736004)(36756003)(68736007)(25786009)(305945005)(53936002)(2906002)(966005)(66066001)(93886005)(3846002)(14454004)(478600001)(82746002)(83716003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5382;H:BYAPR07MB5144.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kXzkvjMjZEvajhcsGqhhuecT0rWqt7sefcxAWG5SrcfRhb9cZ7C/vkFpIUs7RJ98cbqR4cAqeca+51a+LhYjWqV5w2uG+p8pxlopxcUZBd+oR+rMIFHr7SgQdntd0yCZOjrgbQwjYwsmJpXMeEW/xJckTwf46yli5WjUYp7eDbZSLvfwrmnpr8AelDyTkCUV8LkXf9eQ7NdUM7EqwYAogPT8lKImn1GwCLKwNa9MKLSU9DbQjQ94AsbP03A0XiREr7S/iwIVRsiaAzQ6vAP/e2jrJIQKybFup/f3sCkY/0yLL/sbhTTYQoFcjuhklE00PZiXDJivgNh9BP7dZBXAm2sUK+/7hd7ijvnwKMjvWQM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FB86CB3B553EC42A64FFA5762978ADE@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c44d728-7a5c-40e3-f9d8-08d61403f5a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2018 14:20:55.7163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5382
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDkvNi8xOCwgNDoxMCBQTSwgIkJvcmlzIEJyZXppbGxvbiIgPGJvcmlzLmJyZXpp
bGxvbkBib290bGluLmNvbT4gd3JvdGU6DQoNCiAgICBFWFRFUk5BTCBNQUlMDQogICAgDQogICAg
DQogICAgT24gVGh1LCA2IFNlcCAyMDE4IDEzOjQ3OjI5ICswMDAwDQogICAgUHJ6ZW15c2xhdyBH
YWogPHBnYWpAY2FkZW5jZS5jb20+IHdyb3RlOg0KICAgIA0KICAgID4gT24gOS82LzE4LCAzOjE0
IFBNLCAiQm9yaXMgQnJlemlsbG9uIiA8Ym9yaXMuYnJlemlsbG9uQGJvb3RsaW4uY29tPiB3cm90
ZToNCiAgICA+IA0KICAgID4gICAgIEVYVEVSTkFMIE1BSUwNCiAgICA+ICAgICANCiAgICA+ICAg
ICANCiAgICA+ICAgICBPbiBUaHUsIDYgU2VwIDIwMTggMTQ6NTk6NDYgKzAyMDANCiAgICA+ICAg
ICBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPiB3cm90ZToNCiAgICA+ICAgICANCiAgICA+
ICAgICA+IE9uIFRodSwgU2VwIDYsIDIwMTggYXQgMjo0MyBQTSBQcnplbXlzbGF3IEdhaiA8cGdh
akBjYWRlbmNlLmNvbT4gd3JvdGU6ICANCiAgICA+ICAgICA+ID4NCiAgICA+ICAgICA+ID4gSGkg
Qm9yaXMsIFZpdG9yLA0KICAgID4gICAgID4gPg0KICAgID4gICAgID4gPiBUaGlzIHJlcG9zaXRv
cnkgZG9lcyBub3QgY29udGFpbiBmdWxsIGtlcm5lbCBzb3VyY2VzLCBidXQgaXQgc2hvdWxkIGJl
IGVub3VnaCB0byBkaXNjdXNzIG1hc3RlcnNoaXAgcmVxdWVzdCBmZWF0dXJlLg0KICAgID4gICAg
ID4gPiBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMtM0Ff
X2dpdGh1Yi5jb21fcHJ6ZW1la2dhal9pM2MtMkRsaW51eF9jb21taXRfZDU0ZmU2OGE5ZDNlNTcz
YzBjNDU0YTJjNmYxYWZhZmMyMDE0MmVjNSZkPUR3SUNBZyZjPWFVcTk4M0wycHVlMkZxS0ZvUDZQ
R0hNSlF5b0o3a2wzczNHWi1faGFYcVkmcj1DTW5BZk1fT2ZwcWNXWlJmaXFjUld3Jm09T1BTYTI1
RU5uckYwUXY3MERHNDlabmdmZHlnSlp1YmpvM1RPZ0JBM3BKNCZzPV9DNmkxS1BwbFFHY1d2UVlQ
a3JHeDdWM1RqS0RKdnF0M0tHLXZjZFUySzQmZT0NCiAgICA+ICAgICA+ID4NCiAgICA+ICAgICA+
ID4gUGxlYXNlIGtlZXAgaW4gbWluZCB0aGF0IHRoaXMgaXMgaW5pdGlhbCB2ZXJzaW9uLCBidXQg
bWFzdGVyc2hpcCB3b3JrcyBjb3JyZWN0bHkuIEkgYWRkZWQgb25lIHByb3BlcnR5IHRvIERUIHRv
IHJlZmxlY3QgcmVsYXRpb25zaGlwIGJldHdlZW4gbWFzdGVycy4NCiAgICA+ICAgICA+ID4gSXQg
aXMgcG9zc2libGUgdG8gcmVxdWVzdCBtYXN0ZXJzaGlwIG9uIGRlbWFuZCAodXNpbmcgc3lzZnMu
IFVzZWZ1bCBpbiBjYXNlIHdoZW4gTGludXggbWFjaGluZSBpcyBlcXVpcHBlZCBvbmx5IHdpdGgg
c2Vjb25kYXJ5IG1hc3RlciBjb250cm9sbGVyKSBvciBhdXRvbWF0aWNhbGx5IGNoYW5nZSBvcGVy
YXRpb24gbW9kZSB3aGVuIGRldmljZSBkcml2ZXIgd2FudHMgdG8gcmVhZC93cml0ZSBzb21ldGhp
bmcgZnJvbS90byBkZXZpY2UuDQogICAgPiAgICAgPiA+DQogICAgPiAgICAgPiA+IEknbSBzdXJl
IEkgd2lsbCBoYXZlIHRvIHJld29yayBzb21ldGhpbmcgYmVjYXVzZSB0aGlzIHdhcyBpbXBsZW1l
bnRlZCBvbiBzb3VyY2VzIGZyb20gUEFUQ0ggdjQuIEkgc2F3IHRoYXQgQm9yaXMgcmVsZWFzZWQg
djcgeWVzdGVyZGF5IDopICAgIA0KICAgID4gICAgID4gDQogICAgPiAgICAgPiANCiAgICA+ICAg
ICA+IENhbiB5b3UgZXhwbGFpbiB0aGUgcmVhc29uIGZvciBoYXZpbmcgYSB1c2VyIHNwYWNlIGlu
dGVyZmFjZSBhbmQgRFQgcHJvcGVydHk/DQogICAgPiAgICAgPiBJIHRob3VnaHQgd2UgaGFkIGNv
bmNsdWRlZCBlYXJsaWVyIHRoYXQgd2Ugd291bGRuJ3QgbmVlZCB0aGF0LCBidXQgaXQncyBwb3Nz
aWJsZQ0KICAgID4gICAgID4gdGhhdCBJIG1pc3NlZCBzb21ldGhpbmcgaW4gdGhlIGRpc2N1c3Np
b24gc2luY2UgdGhlbi4gIA0KICAgID4gICAgIA0KICAgID4gICAgIEkgZG9uJ3QgdGhpbmsgdGhl
IHN5c2ZzIGtub2IgaXMgbmVlZGVkLCB0aGlzIGJlaW5nIHNhaWQsIGFmdGVyIHRoaW5raW5nDQog
ICAgPiAgICAgYSBiaXQgbW9yZSBhYm91dCBtYXN0ZXJzaGlwIGhhbmRvdmVyIGFuZCB0aGUgc2Vj
b25kYXJ5IG1hc3RlciBjYXNlLCBJDQogICAgPiAgICAgdGhpbmsgd2UgaGF2ZSBzb21ldGhpbmcg
aW1wb3J0YW50IHRvIHNvbHZlLg0KICAgID4gICAgIA0KICAgID4gICAgIFdoZW4gYSBtYXN0ZXIg
aXMgbm90IGluIGNvbnRyb2wgb2YgdGhlIGJ1cywgaXQgZ2V0cyBpbmZvcm1lZCBvZiBkZXZpY2Vz
DQogICAgPiAgICAgcHJlc2VudCBvbiB0aGUgYnVzIGJ5IG1vbml0b3JpbmcgREFBIG9yIERFRlNM
VlMgYnJvYWRjYXN0IGV2ZW50cy4gVGhhdA0KICAgID4gICAgIG1lYW5zIHRoZSBzZWNvbmRhcnkg
bWFzdGVyIHNob3VsZCBwb3B1bGF0ZSB0aGUgYnVzIHdpdGggSTNDL0kyQyBkZXZpY2VzDQogICAg
PiAgICAgb24gc3VjaCBldmVudHMsIGJ1dCB0aGF0J3Mgbm90IGVub3VnaCwgYmVjYXVzZSBERUZT
TFZTL0RBQSBkbyBub3QNCiAgICA+ICAgICBwcm92aWRlIGFsbCBkZXZpY2UgaW5mby4gU29tZSBv
ZiB0aGVtIChsaWtlIHJlYWQvd3JpdGUvaWJpIGxpbWl0YXRpb25zKQ0KICAgID4gICAgIHJlcXVp
cmUgZXh0cmEgQ0NDIGNvbW1hbmRzLCBhbmQsIHRvIHNlbmQgdGhvc2UgQ0NDIGNvbW1hbmRzLCB0
aGUNCiAgICA+ICAgICBzZWNvbmRhcnkgbWFzdGVyIG11c3QgY2xhaW0gdGhlIGJ1cy4gV2UgY291
bGQgYWRkIGEgY2FzZSB3aGVyZSB3ZQ0KICAgID4gICAgIGRlY2xhcmUgZGV2aWNlcyBhcyBwYXJ0
aWFsbHkgZGlzY292ZXJlZCB1bnRpbCB0aGUgbWFzdGVyIGFjcXVpcmVzDQogICAgPiAgICAgb3du
ZXJzaGlwIG9mIHRoZSBidXMsIGJ1dCB0aGF0IG1lYW5zIHBhcnQgb2YgdGhlIGRhdGEgcmV0dXJu
ZWQgYnkNCiAgICA+ICAgICBpM2NfZGV2aWNlX2dldF9pbmZvKCkgd2lsbCBiZSBpbmFjY3VyYXRl
LCB3aGljaCBtaWdodCBoYXZlIGFuIGltcGFjdCBvbg0KICAgID4gICAgIHNvbWUgaTNjIGRyaXZl
ciAtPnByb2JlKCkgZnVuY3Rpb25zLg0KICAgID4gDQogICAgPiBIb3cgZG8geW91IHdhbnQgdG8g
aGFuZGxlIGNhc2VzIHdoZW4gc2Vjb25kYXJ5IG1hc3RlciBqb2lucyB0aGUgYnVzIGFmdGVyIA0K
ICAgID4gREVGU0xWUz8gT2YgY291cnNlIHdlIGNhbiBzZW5kIERFRlNMVlMgYWZ0ZXIgc2Vjb25k
YXJ5IG1hc3RlciBqb2lucyB0aGUgYnVzLg0KICAgIA0KICAgIFRoYXQncyBhbHJlYWR5IHRoZSBj
YXNlIDstKS4gRXZlcnkgdGltZSB0aGUgY3VycmVudCBtYXN0ZXIgZGlzY292ZXJzDQogICAgYW5v
dGhlciBtYXN0ZXIsIGl0J3Mgc2VuZHMgYSBERUZTTFZTIGF0IHRoZSBlbmQgb2YgdGhlIERBQSBw
cm9jZWR1cmUuDQogICAgDQogICAgPiAgICAgDQogICAgPiAgICAgV2UgY291bGQgYWxzbyBzYXkg
dGhhdCBwYXJ0aWFsbHkgZGlzY292ZXJlZCBkZXZpY2VzIHNob3VsZCBub3QgYmUNCiAgICA+ICAg
ICByZWdpc3RlcmVkIHRvIHRoZSBkZXZpY2UgbW9kZWwsIGJ1dCB3ZSB0aGVuIGhpdCB0aGUgcHJv
YmxlbSBvZiAid2hvIGNhbg0KICAgID4gICAgIGZvcmNlIHRoZSBzZWNvbmRhcnkgbWFzdGVyIHRv
IGNsYWltIHRoZSBidXMgaWYgdGhlcmUncyBubyB1c2Vycz8iLg0KICAgID4gDQogICAgPiBOb3cg
SSBmZWVsIGxpa2UgSSBtaXNzZWQgc29tZXRoaW5nLiBEbyB5b3Ugd2FudCB0byBwb3B1bGF0ZSBz
ZWNvbmQgaW5zdGFuY2UNCiAgICA+IG9mIHRoZSBzYW1lIHBoeXNpY2FsIGJ1cz8gSWYgeWVzLCB0
aGVuIHdlIGRvbid0IG5lZWQgdG8gaGF2ZSByZWZlcmVuY2UgDQogICAgPiBiZXR3ZWVuIG1hc3Rl
cnMgaW4gRFQuDQogICAgDQogICAgVGhpcyBpcyB0aGUgZGlzY3Vzc2lvbiB3ZSd2ZSBoYWQgYWJv
dXQgMSBtb250aCBhZ28gd2l0aCBBcm5kLCBXb2xmcmFtDQogICAgYW5kIFBldGVyLCBhbmQgdGhl
IGNvbmNsdXNpb24gd2FzIHRoYXQgMiBkaWZmZXJlbnQgbWFzdGVycyBjb25uZWN0ZWQgdG8NCiAg
ICB0aGUgc2FtZSBwaHlzaWNhbCBidXMgc2hvdWxkIGV4cG9zZSAyIGRpZmZlcmVudCBidXNlcyAo
d2hpY2ggbWVhbnMNCiAgICBoYXZpbmcgdGhlIHNhbWUgcGh5c2ljYWwgZGV2aWNlcyBleHBvc2Vk
IDIgdGltZXMgaW4gTGludXgpLg0KDQpPaywgSSBpbXBsZW1lbnRlZCBpdCBhZnRlciBvdXIgZGlz
Y3Vzc2lvbiwgSSB0aGluayBpdCB3YXMgaW4gTWF5LiBJIGV2ZW4gaGFkIA0KdmVyc2lvbiB3aGVy
ZSBldmVyeSBtYXN0ZXIgaGFkIG93biBidXMuIA0KICAgIA0KDQo=
