Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234FFC04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF803213A2
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maximintegrated.onmicrosoft.com header.i=@maximintegrated.onmicrosoft.com header.b="SITTc4rd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF803213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maximintegrated.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbeK3OSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 09:18:18 -0500
Received: from mail-eopbgr720124.outbound.protection.outlook.com ([40.107.72.124]:46886
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726386AbeK3OSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 09:18:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com; s=selector1-maximintegrated-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6O1fTq7E63GXTlEVKz4tEx1bo754umfwYnPDGvrrPQ=;
 b=SITTc4rd2Uk5hyig+eQ3xc60js+dNOdF5kQGGptO7nwMLaxICkzz12FIshhRJGfeXcPs30gWyc0/exMS/gbnmb8HmfTC7PRA/dyc/3ObFTyO8qCsJJEQfmvpVMCyuKHvYhi5jnlSQgz8wu7QHwTKfoQ9gfW5PsGvap02Hv0zn2k=
Received: from DM6PR11MB3131.namprd11.prod.outlook.com (20.177.219.96) by
 DM6PR11MB2811.namprd11.prod.outlook.com (20.176.100.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.20; Fri, 30 Nov 2018 03:10:24 +0000
Received: from DM6PR11MB3131.namprd11.prod.outlook.com
 ([fe80::2dfb:d623:d7cb:cbe1]) by DM6PR11MB3131.namprd11.prod.outlook.com
 ([fe80::2dfb:d623:d7cb:cbe1%3]) with mapi id 15.20.1361.018; Fri, 30 Nov 2018
 03:10:24 +0000
From:   Ryan Lee <RyanS.Lee@maximintegrated.com>
To:     Grant Grundler <grundler@chromium.org>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Benson Leung <bleung@chromium.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>
Subject: RE: [PATCH V2] ASoC: max98373: Added max98373_reset for stable amp
 reset
Thread-Topic: [PATCH V2] ASoC: max98373: Added max98373_reset for stable amp
 reset
Thread-Index: AQHUhslIRSLmSIj6XkCUBOoX3Wedt6Vk8duAgAB6IMCAAJO+AIABlQPw
Date:   Fri, 30 Nov 2018 03:10:24 +0000
Message-ID: <DM6PR11MB313188E9EECC884D2A874FEBE7D30@DM6PR11MB3131.namprd11.prod.outlook.com>
References: <20181128031926.7157-1-ryans.lee@maximintegrated.com>
 <20181128094955.GG6828@sirena.org.uk>
 <DM6PR11MB3131E267C1EDF9254BC7D313E7D10@DM6PR11MB3131.namprd11.prod.outlook.com>
 <CANEJEGse1DGQE6K=sn=bfJuQW=-gM6zps+kvKd8y=yzXjrsTZQ@mail.gmail.com>
In-Reply-To: <CANEJEGse1DGQE6K=sn=bfJuQW=-gM6zps+kvKd8y=yzXjrsTZQ@mail.gmail.com>
Accept-Language: en-US, ko-KR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RyanS.Lee@maximintegrated.com; 
x-originating-ip: [204.17.143.20]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR11MB2811;6:DL/Ijt4hcOIZqbunyTTw8XhVQYJe7ClrbbJrM/tP4d0GeicMpqrSI2JUsog3hbR37xbdPEvuOVx2EQEWVvIm/KrfoducPiD/kZVGBwPJ9e2BERPulwxiSbpRBZl6Wc2xUs1ZIorVJSUsPvpV44yv1EsUOloFywZZpwFKOCuyJOpEJ7i1zqQSATcQSHLKsaeZ/S4g/Hn89ZzOLjor+CyyOXXmXuCSaGjR9+wTt50Nf39EI0ODfLuVIcZ5jolvk8COa7bcMFxznnEZKw/7jxtRxSyjYpbP63s9k2LE4Fjkv58nrap5EV3n5u9d6gmQdVqZOEFemuW1eBtLe1eizuUo9gacKfxvpATcLsfjHVzvoPNJwr60OV2pZ+UDFM10cxitSG6kPUVyv7/ZUC8kJwgMXt92cvUFRHigoVuIq3f4vhY7z4t7TnOkJQZ7Nl1voFvLgSdPaX2oazUe9x9BgeH3BA==;5:amCX0HZ7ZBvSEl7+Rt7+zxaO/296tlZQUeSYdI+VGgbjVyhur1YBo/5D/8H7xgqnGgbOtFRJLViyMYtwmZJohsvZyUkfoejBi7DLoIOvELI5yjrd0Mfhu+fHD+CMnHNJYk6pbbCw+R3yG4RkmiBWIWMGtlLX7BzEjAqZBxg8QaM=;7:XxqL3FfWvCLzQkAkfZ7XSwYgE1vB/FqR9OSIYwyLTzfQJiyMPsGhm8pCRHBHNXU6iI2eNw6HK5my418M/rDPhXjzQXrosrqx5HJg/WHjv7WMawwQThavM/05hrHKWmXkPkhKT4b1gev5uDzgHeCieg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 82602a94-6c5e-4085-3aae-08d656715ed0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM6PR11MB2811;
x-ms-traffictypediagnostic: DM6PR11MB2811:
x-microsoft-antispam-prvs: <DM6PR11MB28117CEF082269F9AFEEC2A6E7D30@DM6PR11MB2811.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231453)(999002)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DM6PR11MB2811;BCL:0;PCL:0;RULEID:;SRVR:DM6PR11MB2811;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39860400002)(376002)(366004)(346002)(199004)(189003)(13464003)(54534003)(40764003)(71190400001)(71200400001)(3846002)(6116002)(72206003)(53936002)(66066001)(7736002)(99286004)(316002)(14454004)(305945005)(74316002)(55016002)(86362001)(9686003)(106356001)(105586002)(229853002)(5660300001)(6436002)(14444005)(256004)(6246003)(478600001)(6916009)(25786009)(4326008)(81156014)(486006)(11346002)(76176011)(81166006)(7416002)(97736004)(8676002)(39060400002)(476003)(446003)(93886005)(8936002)(2906002)(33656002)(7696005)(102836004)(54906003)(68736007)(186003)(26005)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR11MB2811;H:DM6PR11MB3131.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: maximintegrated.com does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: JE+WGkACNYhHpdA1FZwh+j3KPbErTAyInqPr/+2l3xt+73Ii6Clu4h9WT2CFkY1nS13+mTI//ct6LE6m5N7EHwOWZmyjy15h/+zLJqhZ7QXj225JR/1ruPbnh+yLSwyDjGYDvEW03aFaBfmUPN4Qd6r/OAOC1I70dzDHEdvZ3olwWKmySCXIcC9bCUGUGTN14Wofpl3aYfJa8sGhS+AJrrTxvzWs2OL4GQg7TubMO4PEVZ08i9cWbRfMGSlE55TWMD2LWcTy4rJirKzqrYFYh7Km+K62BBR5Sr+51WdAo+53JpF0dAl2IE8OpafLD+Q0KZN3nqkfeuaa7pcxE2WjCZ1OIVnvOmOEJg6p9NcJ11o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82602a94-6c5e-4085-3aae-08d656715ed0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 03:10:24.0564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2811
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogR3JhbnQgR3J1bmRsZXIgPGdydW5k
bGVyQGNocm9taXVtLm9yZz4NCj5TZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDI4LCAyMDE4IDU6
NTYgUE0NCj5UbzogUnlhbiBMZWUgPFJ5YW5TLkxlZUBtYXhpbWludGVncmF0ZWQuY29tPg0KPkNj
OiBicm9vbmllQGtlcm5lbC5vcmc7IExpYW0gR2lyZHdvb2QgPGxnaXJkd29vZEBnbWFpbC5jb20+
Ow0KPnBlcmV4QHBlcmV4LmN6OyB0aXdhaUBzdXNlLmNvbTsgR3JhbnQgR3J1bmRsZXINCj48Z3J1
bmRsZXJAY2hyb21pdW0ub3JnPjsgS3VuaW5vcmkgTW9yaW1vdG8NCj48a3VuaW5vcmkubW9yaW1v
dG8uZ3hAcmVuZXNhcy5jb20+OyBCZW5zb24gTGV1bmcNCj48YmxldW5nQGNocm9taXVtLm9yZz47
IGFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZzsgTEtNTCA8bGludXgtDQo+a2VybmVsQHZnZXIu
a2VybmVsLm9yZz47IHJ5YW4ubGVlLm1heGltQGdtYWlsLmNvbQ0KPlN1YmplY3Q6IFJlOiBbUEFU
Q0ggVjJdIEFTb0M6IG1heDk4MzczOiBBZGRlZCBtYXg5ODM3M19yZXNldCBmb3Igc3RhYmxlDQo+
YW1wIHJlc2V0DQo+DQo+RVhURVJOQUwgRU1BSUwNCj4NCj4NCj4NCj5PbiBXZWQsIE5vdiAyOCwg
MjAxOCBhdCA5OjA3IEFNIFJ5YW4gTGVlDQo+PFJ5YW5TLkxlZUBtYXhpbWludGVncmF0ZWQuY29t
PiB3cm90ZToNCj4+DQo+PiA+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+ID5Gcm9tOiBN
YXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+DQo+PiA+U2VudDogV2VkbmVzZGF5LCBOb3Zl
bWJlciAyOCwgMjAxOCAxOjUwIEFNDQo+PiA+VG86IFJ5YW4gTGVlIDxSeWFuUy5MZWVAbWF4aW1p
bnRlZ3JhdGVkLmNvbT4NCj4+ID5DYzogTGlhbSBHaXJkd29vZCA8bGdpcmR3b29kQGdtYWlsLmNv
bT47IEphcm9zbGF2IEt5c2VsYQ0KPj4gPjxwZXJleEBwZXJleC5jej47IFRha2FzaGkgSXdhaSA8
dGl3YWlAc3VzZS5jb20+OyBHcmFudCBHcnVuZGxlcg0KPj4gPjxncnVuZGxlckBjaHJvbWl1bS5v
cmc+OyBLdW5pbm9yaSBNb3JpbW90bw0KPj4gPjxrdW5pbm9yaS5tb3JpbW90by5neEByZW5lc2Fz
LmNvbT47IEJlbnNvbiBMZXVuZw0KPj4gPjxibGV1bmdAY2hyb21pdW0ub3JnPjsgYWxzYS1kZXZl
bEBhbHNhLXByb2plY3Qub3JnOyBsaW51eC0NCj4+ID5rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBy
eWFuLmxlZS5tYXhpbUBnbWFpbC5jb20NCj4+ID5TdWJqZWN0OiBSZTogW1BBVENIIFYyXSBBU29D
OiBtYXg5ODM3MzogQWRkZWQgbWF4OTgzNzNfcmVzZXQgZm9yDQo+PiA+c3RhYmxlIGFtcCByZXNl
dA0KPj4gPg0KPj4gPk9uIFdlZCwgTm92IDI4LCAyMDE4IGF0IDAzOjIwOjE2QU0gKzAwMDAsIFJ5
YW4gTGVlIHdyb3RlOg0KPj4gPj4gU2lnbmVkLW9mZi1ieTogUnlhbiBMZWUgPHJ5YW5zLmxlZUBt
YXhpbWludGVncmF0ZWQuY29tPg0KPj4gPj4gLS0tDQo+PiA+DQo+PiA+Tm90IHNlZWluZyBhIGNo
YW5nZWxvZyBoZXJlIGxpa2UgSSBhc2tlZCBmb3IgOigNCj4+DQo+PiBBY3R1YWxseSBJIGFkZGVk
IGNoYW5nZWxvZyBhcyBiZWxvdy4gRG8geW91IG1lYW4gdGhpcyBpcyBub3Qgc3VmZmljaWVudD8N
Cj4NCj5UaGUgdGV4dCBpcyBwcm9iYWJseSBzdWZmaWNpZW50IGJ1dCBub3QgaW4gYSBmb3JtYXQg
dGhhdCBNYXJrIGNhbiBkaXJlY3RseSBhcHBseS4NCj5QbGVhc2UgdGFrZSBhIHF1aWNrIGxvb2sg
YXQgRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5yc3QuDQo+DQo+TWFy
ayB3YW50cyB0aGUgImNvbW1pdCBtZXNzYWdlIiB0byBiZSBiZWZvcmUgdGhlICctLS0nIGxpbmUu
IFNvIG1vdmUgdGhlDQo+IkNoYW5nZXM6IiB0ZXh0IHVwIHRvIGJlY29tZSB0aGUgY29tbWl0IG1l
c3NhZ2UgYW5kIGRyb3AgdGhlICJDaGFuZ2VzIg0KPmxpbmUuIFRoYXQgc2hvdWxkIGV4cGxhaW4g
d2h5IHRoaXMgY29tbWl0IGlzIG5lZWRlZCBhbmQgaW5jbHVkZSB0aGUgUy1vLUIgbGluZS4NClRo
YW5rcyBmb3IgeW91ciBoZWxwLiBJIHdpbGwgZml4IGl0Lg0KPg0KPmNoZWVycywNCj5ncmFudA0K
Pg0KPj4NCj4+IENoYW5nZXMgc2luY2UgdjEgOiBSZW1vdmVkIHVudXN1YWwgcmVwZWF0IGZvciBh
bXAgc29mdHdhcmUgcmVzZXQgYW5kDQo+dmVyaWZpY2F0aW9uLg0KPj4gICAgICAgICAgICAgICAg
ICAgIEFtcCBzb2Z0d2FyZSByZXNldCB3aWxsIGJlIHBlcmZvcm1lZCBvbmNlIGFuZCBpdCByZXBl
YXRzDQo+dmVyaWZpY2F0aW9uIG1heGltdW0gMyB0aW1lcyBpZiBpdCBpcyBmYWlsZWQuDQo+PiAg
ICAgICAgICAgICAgICAgICAgV2FpdCAxMG1zIGJlZm9yZSBldmVyeSB2ZXJpZmljYXRpb24gdHJp
YWwuIE1heGltdW0gMzBtcyBkZWxheSB3aWxsDQo+YmUgYXBwbGllZCB0byB3YWl0IEFNUCBpZGxl
IHN0YXRlLg0KPj4NCj4+ID4NCj4+ID4+IENoYW5nZXMgOiBDcmVhdGVkIG1heDk4MzczX3Jlc2V0
IGZ1bmN0aW9uIHRvIG1pbmltaXplIGNvZGUgZHVwbGljYXRpb24uDQo+PiA+PiAgICAgICAgICAg
Q2hhbmdlZCByZWdtYXBfd3JpdGUgdG8gcmVnbWFwX3VwZGF0ZV9iaXRzLiBPdGhlciBiaXRzDQo+
PiA+PiBleGNlcHQgTFNCDQo+PiA+bmVlZCB0byBiZSBtYXNrZWQuDQo+PiA+PiAgICAgICAgICAg
QWRkZWQgcmVzZXQgdmVyaWZpY2F0aW9uIHN0ZXAgdG8gbWFrZSBzdXJlIHNvZnR3YXJlIHJlc2V0
DQo+PiA+PiBpcyBjb21wbGV0ZWQNCj4+ID53ZWxsLiBTb2Z0d2FyZSByZXNldCBpcyBkb25lIGlu
IDEwbXMgaW4gbm9ybWFsIGNhc2UuDQo+PiA+PiAgICAgICAgICAgUmV2aXNpb24gSUQgaXMgYXZh
aWxhYmxlIHdoZW4gdGhlIGFtcCBpcyBpbiB0aGUgaWRsZQ0KPj4gPj4gc3RhdGUgd2hpY2ggbWVh
bnMNCj4+ID5zb2Z0d2FyZSByZXNldCBpcyBjb21wbGV0ZWQuDQo+PiA+PiAgICAgICAgICAgU29m
dHdhcmUgcmVzZXQgd2lsbCBiZSBwZXJmb3JtZWQgbWF4aW11bSAzIHRpbWVzIHRvIGF2b2lkDQo+
PiA+PiBhbXAgcmVzZXQNCj4+ID5mYWlsdXJlLiBHZW5lcmFsbHkgaXQgaXMgZG9uZSBpbiB0aGUg
Zmlyc3QgdHJpYWwuDQo+PiA+PiAgICAgICAgICAgc2xlZXAgdGltZSBhZnRlciBzb2Z0d2FyZSBy
ZXNldCBpcyBpbmNyZWFzZWQgKyAzMG1zIGZvciBldmVyeSByZXRyaWFsLg0KPj4gPk1heGltdW0g
cG9zc2libGUgbXNsZWVwIHRpbWUgaXMgMTAwIG1zIChpbml0aWFsIDEwIG1zICsgMzAgbXMgKiAz
IHRpbWVzKS4NCj4+ID4NCj4+ID5UaGlzIGxvb2tzIGxpa2UgaXQncyBzdXBwb3NlZCB0byBiZSBh
IGNoYW5nZWxvZyBidXQgaXQgaXNuJ3Qgb25lPw0K
