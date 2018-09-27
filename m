Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB79C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 06:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D7422156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 06:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="O8vhjV76";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Z5zd8EwV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D7422156D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbeI0Mtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 08:49:40 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:31725 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbeI0Mtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 08:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1538029982; x=1569565982;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NkV20f1XIdJybCIglcuBPNlaz35/s+jRhnSz7sD33jM=;
  b=O8vhjV76BZg9bZhElkYK5tAUWM2xSosc+R6kfiobFzhXVmluk1MO1tyD
   AC9W+AzIgipaU/OxNIj0opY2scKBGwiMNaFT1awAhNFIeZJFVItcg5uqZ
   Al6JPKD2lLREgW4uGI9wduYFfw+cULMIWBgSdt1Gqrin5xR8xVj/csHqd
   3AxbI1oLVSjZZz48aAotyi2DTR+uLTkVaJQHbyfiOevnxzoIVLD/lkExD
   vRpuFoCUjPVwo7BN2vXPcz0XDgiN5U63egLD5hDpI8CzxhtyuzHsLWDbe
   RtyIhRtanPRJUVR4aVljEyo84KuKk46sDVocsLBu8k5XAW8sRBMd88wtn
   g==;
X-IronPort-AV: E=Sophos;i="5.54,309,1534780800"; 
   d="scan'208";a="95212881"
Received: from mail-dm3nam05lp0111.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([216.32.181.111])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2018 14:32:50 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkV20f1XIdJybCIglcuBPNlaz35/s+jRhnSz7sD33jM=;
 b=Z5zd8EwVBJrEX3SSh8i3po0/c/FUXZg15AO7vk6E42CKG7L35znvYRd3t1jF7OsgIAWHD2wJjimqv7AXAMrk1vl6VdewsiCtB15uvGZRsIWAoqDlnuMFsT5aUlTOyhn+bjPxb3WfUVnB3D6HFaZguSTzabP6hBscCIqxBUeIAO8=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB4767.namprd04.prod.outlook.com (52.135.122.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Thu, 27 Sep 2018 06:32:48 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::c99d:1885:c976:a93b]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::c99d:1885:c976:a93b%2]) with mapi id 15.20.1164.024; Thu, 27 Sep 2018
 06:32:47 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Evan Green <evgreen@chromium.org>,
        Doug Anderson <dianders@chromium.org>
CC:     "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        sayali <sayalil@codeaurora.org>
Subject: RE: [PATCH v4] scsi: ufs: Make sysfs attributes writable
Thread-Topic: [PATCH v4] scsi: ufs: Make sysfs attributes writable
Thread-Index: AQHUVP9Wjs7PzRFI7kyunXbWziYPc6UBwOGjgAAKiYCAAQsCAIAA08vw
Date:   Thu, 27 Sep 2018 06:32:47 +0000
Message-ID: <SN6PR04MB4925DAB09EED762CDCCBBF47FC140@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <20180808224454.243790-1-evgreen@chromium.org>
 <6dd8a547-7260-09b8-9096-8a1564b08e70@intel.com>
 <8fd05b2d-fa48-78af-6f1c-7e485c1008f6@intel.com>
 <CAD=FV=W7h_3LwV-P5_E58-3qOo7Y-yQDTDfSLoU1+3c_6ZF0cg@mail.gmail.com>
 <yq1h8idgj5y.fsf@oracle.com>
 <CAD=FV=WNHDd8icQi3wtFV98w1zdEd-QqFn1PrZeXQWgYt4Yo1w@mail.gmail.com>
 <CAE=gft57aP3Qx-zdHR1UsJwS7JjVEpVvmCSTk3ctWrRF2=W4ww@mail.gmail.com>
In-Reply-To: <CAE=gft57aP3Qx-zdHR1UsJwS7JjVEpVvmCSTk3ctWrRF2=W4ww@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR04MB4767;6:w0hkN1fI5xYfYipIzWaBS4RKGnJCNcU5QcEMbo0c0N3ioC4yy5pUKmMHMTlzz7BX8cqSvp0dYKLEmYuHZFkA5Z/TBZkbBggMZCrSA3E9fUk+m1olQn+Gm3sCH1dXeZuuKrYYuJREPGc22nf6Ydpf8wXJaxkXtDLLQIujZw+O4t9OFxFFAqhqClZsvNeCbYP6gRMmBKDRDxr17s/A/Cq7F2K1Mooe0NO+g6hcFDar8R6F1huyqHfY4JpevNOO4sHKKtVjC7DmTXvHPNNibtr5CV7sYH9Ow41ACP+xvVIyR6jfsHa07oRNg60KESG4T27hNrsftgfMLC3BoRuFoyENnrmEV1sABcoE/erxwVt5Uu6EkifwoSn+m0rLLkgUlbIjwkI+1S3Q3EIqmcOZPs1lZRMwkP7nqHwz0aR5kCnXiOE8ysuC2ip15PYoK4eyRJLXJRlt3Red5aOaokXOebGZfg==;5:tZmq8DV4/IIZMNHSyam5YOnFpozcZ8UpfAAbh1zaRlSLOEo3mtD0cAnavGYdgKdzCqUuNxM2piHTpN+5xhR1IsoPri6Lei5V/1ytql3biyFtjG7aPA6d8gXUwEtJpGNx80grz+hdYjWDS3wTAYgoyYGVsXmUxv4CCBAgK7KNP08=;7:zBPPSfSvcX9C+jboOnx6b5/wAhJ2EEN/phuZARQHrCBrIXdAiJXri2kOnH3JxFJLna4tZjd6IzwrjXRO7V5cHosN5nHKAq+FY7QhzT9zr+wzrKxwF3OSMCirKEp0q83w8oU/61x/gOR8iRp6W88evQAa0m68/+cnGYyA7UdLc554+S21m17f4EOXrh9lQkQ5N+Jy8DyXKKzM/2CBG5gQztf1IeC5A6uQxMSoWko5P9mrE0i9RR0m++B1Y5phV3tL
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: e677ba80-b343-4d1d-62f5-08d624430aac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4767;
x-ms-traffictypediagnostic: SN6PR04MB4767:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4767460697F9FB59746B06C1FC140@SN6PR04MB4767.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(100405760836317);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:SN6PR04MB4767;BCL:0;PCL:0;RULEID:;SRVR:SN6PR04MB4767;
x-forefront-prvs: 0808323E97
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(346002)(396003)(376002)(39860400002)(199004)(189003)(105586002)(26005)(110136005)(5660300001)(71190400001)(4326008)(71200400001)(486006)(102836004)(2906002)(2900100001)(74316002)(5250100002)(478600001)(34290500001)(76176011)(11346002)(93886005)(68736007)(54906003)(316002)(7696005)(6506007)(446003)(476003)(99286004)(106356001)(186003)(256004)(14454004)(86362001)(305945005)(25786009)(3846002)(6116002)(39060400002)(55016002)(97736004)(8936002)(229853002)(6436002)(9686003)(72206003)(6306002)(8676002)(53936002)(33656002)(6246003)(81166006)(81156014)(966005)(66066001)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4767;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: huGG2xpr51tg+T8wKtryQT0AVYXkfaqC0AqBuehfdNhQEU3h3TaPrh9l5DRFOufGHScQXeVms4VMbkYhzHPIb3C8iey0HlyG8EaaYi4h1w0OuIZ+7dUKwcg70XQM5aDKqGASUkCZmf6QoAGvVIu5U4UnJOl/7TQyteqO7qPS2QQr/Mhawi2MQ2vhV9r+TGJMLsBN+v9jCHo37a45SST4bX/1EtqjRZ/6bdQ83BP9EKkrUPGNnTphaYKXGoALFZLPznBBoRX8PZy4/sU5I9mnGOHmXixFzuo5ZUoAiTe1Jk+6sHQ0uzlIXOLIs+qYv0AbegOXY6Ty2tYFlMjknqGTOmNmF6+9a11floizV1DYt1A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e677ba80-b343-4d1d-62f5-08d624430aac
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2018 06:32:47.8576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4767
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4gPg0KPiA+ID4gSSBoYXZlIHNpbXBseSBiZWVuIGF3YWl0aW5nIHNvbWUgc29ydCBvZiBj
b25zZW5zdXMgb24gdGhlIHZhcmlvdXMNCj4gPiA+IGNvbXBldGluZyBhcHByb2FjaGVzLiBMb3Rz
IG9mIHBhdGNoZXMgcG9zdGVkIHdpdGggdGlueSBpbmNyZW1lbnRhbCBmaXhlcw0KPiA+ID4gYnV0
IHZlcnkgbGl0dGxlIGRpc2N1c3Npb24gYWJvdXQgdGhlIG1lcml0cyBvZiBvbmUgb3ZlciB0aGUg
b3RoZXIuDQo+ID4NCj4gPiBBaCwgcGVyZmVjdCBpbmZvcm1hdGlvbiEgIFRoYW5rIHlvdSEgIEkg
d2FzIGp1c3QgY29uZnVzZWQgYmVjYXVzZSBJDQo+ID4gZGlkbid0IHVuZGVyc3RhbmQgYWxsIHRo
ZSBzdGF0dXMgYW5kIGl0IGp1c3QgbG9va2VkIGxpa2Ugc2lsZW5jZSBoZXJlLg0KPiA+DQo+ID4g
TWF5YmUgc29tZW9uZSBvbiB0aGlzIHRocmVhZCBjYW4gc3RhcnQgYSBkaXNjdXNzaW9uIHdpdGgg
YWxsIHRoZQ0KPiA+IHN0YWtlaG9sZGVycyAocGVvcGxlIHdobyBoYXZlIGJlZW4gaW52b2x2ZWQg
aW4gY29tcGV0aW5nIHBhdGNoZXMgb3INCj4gPiBvdGhlciB0aW55IGJpdHMgYW5kIHBpZWNlcykg
YW5kIHN1bW1hcml6ZSB0aGVpciB2aWV3IG9mIHRoZSBjdXJyZW50DQo+ID4gc3RhdHVzPyAgTWF5
YmUgdGhhdCB3b3VsZCBoZWxwIGdldCB0aGUgYmFsbCByb2xsaW5nIGFnYWluPw0KPiA+DQo+IA0K
PiBBaCwgSSBkaWQgbm90IHJlYWxpemUgdGhhdCdzIHdoYXQgd2FzIGJlaW5nIGdhdGVkIG9uLg0K
PiANCj4gVGhlc2UgcGF0Y2hlcyBjb21wbGVtZW50LCByYXRoZXIgdGhhbiBjb21wZXRlIHdpdGgs
IHRoZSBvdGhlciBwYXRjaGVzDQo+IG91dCB0aGVyZS4gVGhlcmUgYXJlIHR3byBjb21wb25lbnRz
IHRvIGNvbXBsZXRlbHkgcHJvdmlzaW9uaW5nIGEgVUZTDQo+IGRldmljZTogd3JpdGluZyB0aGUg
Y29uZmlndXJhdGlvbiBkZXNjcmlwdG9ycywgYW5kIHNldHRpbmcNCj4gYXR0cmlidXRlcy9mbGFn
cy4gTXkgb3JpZ2luYWwgc2VyaWVzIFsxXSBkaWQgY29udGFpbiBzdXBwb3J0IGZvciB0aGUNCj4g
cHJvdmlzaW9uaW5nIHBvcnRpb24sIGJ1dCBJIG9wdGVkIHRvIGxlYXZlIHRoYXQgdG8gU2F5YWxp
J3MgcGF0Y2ggWzJdDQo+IHRoYXQgdXNlcyBjb25maWdmcywgcmF0aGVyIHRoYW4gZHVwbGljYXRl
IGVmZm9ydC4gU2F5YWxpJ3Mgb3RoZXIgcGF0Y2gNCj4gWzNdIGRvZXMgaGFuZGxlIHNldHRpbmcg
dGhlIHJlZmVyZW5jZSBjbG9jayBmcmVxdWVuY3ksIHdoaWNoIGhhcyBzb21lDQo+IG92ZXJsYXAg
d2l0aCB0aGlzIHBhdGNoIGluIHRoYXQgYm90aCBzZXQgYlJlZkNsa0ZyZXEuIEJ1dCB0aGlzIHBh
dGNoDQo+IGFuZCB0aGUgZmxhZyBwYXRjaCBbNF0gYXJlIHN0aWxsIG5lZWRlZCBmb3IgcHJvdmlz
aW9uaW5nIGFjdGl2aXR5IGxpa2UNCj4gbG9ja2luZyB0aGUgZGVzY3JpcHRvcnMgZG93biBvbmNl
IHRoZXkncmUgc2V0IHVwLCBhbmQgZW5hYmxlIG90aGVyDQo+IGRldmljZSBleHBlcmltZW50YXRp
b24uIEluIG90aGVyIHdvcmRzLCB0aGV5J3JlIGluZGVwZW5kZW50Lg0KPiANCkFsc28sIGluIHRo
aXMgY29udGV4dCB0aGVyZSBpcyB0aGUgc2VyaWVzIGluIA0KaHR0cHM6Ly93d3cuc3Bpbmljcy5u
ZXQvbGlzdHMvbGludXgtc2NzaS9tc2cxMjM0NzkuaHRtbA0Kd2hpY2ggYWxsb3dzIHRvIHNlbmQg
VVBJVXMgdmlhIGEgYnNnIGRldmljZS4NCg0KSXQncyBub3QgYSBwcm92aXNpb25pbmcgc2VyaWVz
IHBlci1zZSBsaWtlIEV2YW4ncyBhbmQgU2F5YWxpJ3MuDQpJdCBjb3ZlcnMgdGhlIHByb3Zpc2lv
bmluZyBmdW5jdGlvbmFsaXR5LA0KQnV0IGFsc28gYWxsb3cgdG8gc2VuZCB0YXNrIG1hbmFnZW1l
bnQgVVBJVSwgYW5kIFVJQyBjb21tYW5kcywNCldoaWNoIGNhbiBiZSB1c2VkIGZvciB0ZXN0aW5n
IGFuZCB2YWxpZGF0aW9uLg0KDQpUaGFua3MsDQpBdnJpDQoNCg0KPiBUaGVyZSB3YXMgYWxzbyBh
bm90aGVyIGluZGVwZW5kZW50IGZpeCBbNV0gZm9yIGRldmljZXMgdGhhdCBzdGFydCBpbg0KPiBz
bGVlcCBtb2RlLCB3aGljaCBMaW51eCBjdXJyZW50bHkgY2FuJ3QgaGFuZGxlLiBUaGF0IHBhdGNo
IGdvdCBubw0KPiByZXZpZXdzLCB3aGljaCBpcyBhIHNoYW1lLCBhbmQgSSBzaG91bGQgcHJvYmFi
bHkgcmVzZW5kIGFzIG11bHRpcGxlDQo+IHBhdGNoZXMgb3IgYXQgbGVhc3Qgd2l0aCBzb21lIGFk
ZGl0aW9uYWwgaW5mb3JtYXRpb24uDQo+IA0KPiAtRXZhbg0KPiANCj4gWzFdIGh0dHBzOi8vbGtt
bC5vcmcvbGttbC8yMDE4LzUvMjkvOTY5DQo+IFsyXSBodHRwczovL2xrbWwub3JnL2xrbWwvMjAx
OC85LzE0LzI5Mw0KPiBbM10gaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTgvOS8xNC8yOTINCj4g
WzRdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTA1NzA4MTEvDQo+IFs1XSBo
dHRwczovL2xrbWwub3JnL2xrbWwvMjAxOC84LzEwLzY2OQ0K
