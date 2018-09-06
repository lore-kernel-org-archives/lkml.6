Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCDAC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13C720652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="hnlqX9Zx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D13C720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbeIFUzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:55:17 -0400
Received: from mail-eopbgr730046.outbound.protection.outlook.com ([40.107.73.46]:12016
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbeIFUzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JT1gH9DLAq9JI05yQHjZ/EvlglOAKKaVAoBQ/TNNGuo=;
 b=hnlqX9ZxfXAlUxVhGw3cEgW/3E+94GX5qMngf896+yWm2dNxxqGqGhi5BKRI+V7ixpdDYSm9jXKs0h7enjS4wYFWEmMn0JR9qJH/QbXbqASaoU5QlFsmilBC4ERgZ4jgAmBuYFrtwTz4Mx4ZD3z9TnIZgQjd5t6ul2pxK+PFx2I=
Received: from DM6PR02MB5227.namprd02.prod.outlook.com (20.176.116.140) by
 DM6PR02MB5388.namprd02.prod.outlook.com (20.177.221.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.14; Thu, 6 Sep 2018 16:14:52 +0000
Received: from DM6PR02MB5227.namprd02.prod.outlook.com
 ([fe80::4c6f:aaa3:2a0:9644]) by DM6PR02MB5227.namprd02.prod.outlook.com
 ([fe80::4c6f:aaa3:2a0:9644%3]) with mapi id 15.20.1080.020; Thu, 6 Sep 2018
 16:14:52 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "olof@lixom.net" <olof@lixom.net>,
        Srinivas Goud <sgoud@xilinx.com>,
        Anirudha Sarangi <anirudh@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: [PATCH v5 3/4] edac: synopsys: Add EDAC ECC support for ZynqMP
 DDRC
Thread-Topic: [PATCH v5 3/4] edac: synopsys: Add EDAC ECC support for ZynqMP
 DDRC
Thread-Index: AQHUQS6AbtBSOWetW0KVDsZ1oOCLnKThgYaAgAHv0jA=
Date:   Thu, 6 Sep 2018 16:14:52 +0000
Message-ID: <DM6PR02MB52273E288A625F7BD59BB2FFC1010@DM6PR02MB5227.namprd02.prod.outlook.com>
References: <1535722070-10394-1-git-send-email-manish.narani@xilinx.com>
 <1535722070-10394-4-git-send-email-manish.narani@xilinx.com>
 <20180905101935.GD2237@zn.tnic>
In-Reply-To: <20180905101935.GD2237@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR02MB5388;6:yV1IW4OUYOW3umlPOkimSd5YAiHmoxa/Meo6eOiGZ/ffqmJIGezNr10Sw19V069irwc8Yab+iMtIqo1cRlgFvdqaXoiHC6S5qp2YQJ5tU3wyTtf9sutRO71H0vqqDepOHFXYKZsBp5vk0fF4kDn5izkY+BRdcjcUt9obUzuffazUIP5fjNQt5KKLVCdmgXkuJuXPZEMGw32s5bnlSNv5qh0+BGRREtYDc9XtZoByz/83GZ9Drs8YT+CiF2CX74N6eJgsjF9f4iXaEcr1I+GBrT53BvOapQ4Ug0cwVn/xj9o955lvy4o4Rtw4vNMKeiapWw+u1+Zw7KMEvB8Xwag55YGHQyyXq2K6FSN3xwQXgF9qruEri7iYz4VLxwTzAIlZzqgZteCVnEKiuJqMkk34B+NECPmx9rPTUemxJX4lkC533mCJju4m9U1AytUOZehF0MNhnZovCJJTfFKA6sJmhQ==;5:swMUc4gi3nyEEImfTytHhkA8WO+bWgGMzPVPzu+6n8tEvwTgD/RP5mPiFV66sara1RUZygaDaVmD09q5C4gfvn4AvDvqI0go+7nV6lbmk4lx0r7c09bUlK9gh19a4n4vtN/irpeK2zoM7jdZyAb/f9HGj2DojBNFhGBf8q72CVw=;7:if4Hj5nNZnbx1BAU0sTc0t0ZvUWmk7Ol6jEszRpc2O2S3k0f4DWTgiNTVDnUeYwZPSk7kiLP1OTWBMFRmjXi/ig8wNq8+zh2+QvZCWf+443GaNfWfdh1J2r2swfMfPXfpC9xW1h73d1C2mKs2vS9qcxpErs5tDK64PybySJiajmK7UR5UgDZK8vQQn7mR1JmVVIEcyQAlktVBKP+B/rNILLsJxNMqTMpTMBZbQAiqEIiDdfhKBY/18asmVYrfERP
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: d0f69b23-3e03-4711-0865-08d61413e07b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM6PR02MB5388;
x-ms-traffictypediagnostic: DM6PR02MB5388:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <DM6PR02MB5388701AF4CDE6AAE9D6FC87C1010@DM6PR02MB5388.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(258649278758335)(192813158149592)(105169848403564);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(10201501046)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:DM6PR02MB5388;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB5388;
x-forefront-prvs: 0787459938
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(346002)(396003)(376002)(136003)(366004)(189003)(199004)(13464003)(51914003)(26005)(6916009)(305945005)(2906002)(8676002)(186003)(66066001)(5250100002)(74316002)(7416002)(106356001)(25786009)(7736002)(102836004)(6506007)(105586002)(53546011)(55016002)(6436002)(229853002)(316002)(68736007)(4326008)(86362001)(54906003)(53936002)(9686003)(2900100001)(217873002)(446003)(76176011)(81156014)(81166006)(7696005)(6246003)(33656002)(8936002)(6116002)(3846002)(99286004)(72206003)(256004)(11346002)(476003)(14444005)(478600001)(486006)(5660300001)(97736004)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5388;H:DM6PR02MB5227.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /96XC8VYag2xnnPljQp90LigEgcITFMKlu0iSpsaTF/IDPo0oJQ1HYey2dAKbPC/OnyD3ZUylZPoboyrDXq8fxKZo95rg1768leewURRJsEmYYLjRacoyDi8hcTqmM4HkWRbfjbxPP/wqcw9nyiuMDWa2nxnPirZlDZ9397Ftvt4EFRr8kejO1rtfYbY6VRcABMUtZ3QW0lM0Dyk19MCefXj7UTGh3lune2bfvQaNJeB9H+ShGM1ODNgUqsG3MCEukUad8ZKRFS9WC2BQ3nLUdVTcNNUDCAhCl4xXyANu5c408Q8ADU21Y1zjOdFqB/FkHoDA3FnUinqEF/H/4vrmHikxSGYNBZ/psJKPcTfKWE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f69b23-3e03-4711-0865-08d61413e07b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2018 16:14:52.1246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5388
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQm9yaXMsDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgW21haWx0bzpicEBhbGllbjguZGVd
DQo+IFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDUsIDIwMTggMzo1MCBQTQ0KPiBUbzogTWFu
aXNoIE5hcmFuaSA8TU5BUkFOSUB4aWxpbnguY29tPg0KPiBDYzogcm9iaCtkdEBrZXJuZWwub3Jn
OyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgTWljaGFsIFNpbWVrDQo+IDxtaWNoYWxzQHhpbGlueC5j
b20+OyBtY2hlaGFiQGtlcm5lbC5vcmc7IGxlb3lhbmcubGlAbnhwLmNvbTsNCj4gYW1pdC5rdWNo
ZXJpYUBsaW5hcm8ub3JnOyBvbG9mQGxpeG9tLm5ldDsgU3Jpbml2YXMgR291ZCA8c2dvdWRAeGls
aW54LmNvbT47DQo+IEFuaXJ1ZGhhIFNhcmFuZ2kgPGFuaXJ1ZGhAeGlsaW54LmNvbT47IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBlZGFjQHZnZXIu
a2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDMvNF0gZWRhYzogc3lub3BzeXM6
IEFkZCBFREFDIEVDQyBzdXBwb3J0IGZvciBaeW5xTVANCj4gRERSQw0KPiANCj4gT24gRnJpLCBB
dWcgMzEsIDIwMTggYXQgMDY6NTc6NDlQTSArMDUzMCwgTWFuaXNoIE5hcmFuaSB3cm90ZToNCj4g
PiBBZGQgRURBQyBFQ0Mgc3VwcG9ydCBmb3IgWnlucU1QIEREUkMgSVAuIEFsc28gYWRkIHN1cHBv
cnQgZm9yIEVDQw0KPiA+IEVycm9yIEluamVjdGlvbiBpbiBaeW5xTVAuIFRoZSBjb3JyZWN0ZWQg
YW5kIHVuY29ycmVjdGVkIGVycm9yDQo+ID4gaW50ZXJydXB0cyBzdXBwb3J0IGlzIGFkZGVkLiBU
aGUgUm93LCBDb2x1bW4sIEJhbmssIEJhbmsgR3JvdXAgYW5kDQo+ID4gUmFuayBiaXRzIHBvc2l0
aW9ucyBhcmUgZGV0ZXJtaW5lZCB2aWEgQWRkcmVzcyBNYXAgcmVnaXN0ZXJzIG9mIFN5bm9wc3lz
DQo+IEREUkMuDQo+ID4gTWlub3IgaW5kZW50YXRpb24gY2hhbmdlcyBhcmUgYWxzbyBkb25lIGZv
ciBiZXR0ZXIgcmVhZGFiaWxpdHkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNYW5pc2ggTmFy
YW5pIDxtYW5pc2gubmFyYW5pQHhpbGlueC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZWRh
Yy9LY29uZmlnICAgICAgICAgfCAgICAyICstDQo+ID4gIGRyaXZlcnMvZWRhYy9zeW5vcHN5c19l
ZGFjLmMgfCAxMDU0DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0t
LS0tDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgOTM3IGluc2VydGlvbnMoKyksIDExOSBkZWxldGlv
bnMoLSkNCj4gDQo+IC4uLg0KPiANCj4gPiBAQCAtMjIyLDExICs0MDgsNzcgQEAgc3RhdGljIGlu
dCBzeW5wc19lZGFjX2dldGVycm9yX2luZm8oc3RydWN0DQo+ID4gc3lucHNfZWRhY19wcml2ICpw
cml2KSAgfQ0KPiA+DQo+ID4gIC8qKg0KPiA+ICsgKiB6eW5xbXBfZ2V0ZXJyb3JfaW5mbyAtIEdl
dCB0aGUgY3VycmVudCBFQ0MgZXJyb3IgaW5mbw0KPiA+ICsgKiBAcHJpdjoJRERSIG1lbW9yeSBj
b250cm9sbGVyIHByaXZhdGUgaW5zdGFuY2UgZGF0YQ0KPiA+ICsgKg0KPiA+ICsgKiBHZXQgdGhl
IEVDQyBlcnJvciBpbmZvcm1hdGlvbiBmcm9tIHRoZSBFQ0MgcmVnaXN0ZXJzIGFuZCBjbGVhciB0
aGUNCj4gPiArZXJyb3INCj4gPiArICogc3RhdHVzIGJpdHMgaW4gdGhlIEVDQyByZWdpc3RlcnMu
DQo+ID4gKyAqDQo+ID4gKyAqIFJldHVybjogMCBpZiB0aGVyZSBpcyBubyBlcnJvciwgb3RoZXJ3
aXNlIHJldHVybiAxICAqLyBzdGF0aWMgaW50DQo+ID4gK3p5bnFtcF9nZXRlcnJvcl9pbmZvKHN0
cnVjdCBzeW5wc19lZGFjX3ByaXYgKnByaXYpIHsNCj4gPiArCXZvaWQgX19pb21lbSAqYmFzZTsN
Cj4gPiArCXN0cnVjdCBzeW5wc19lY2Nfc3RhdHVzICpwOw0KPiA+ICsJdTMyIHJlZ3ZhbCwgY2xl
YXJ2YWwgPSAwOw0KPiA+ICsNCj4gPiArCWlmICghcHJpdikNCj4gPiArCQlyZXR1cm4gMTsNCj4g
DQo+IFNhbWUgYXMgZm9yIHRoZSBwcmV2aW91cyBwYXRjaDogd2h5IGFyZSB5b3UgdGVzdGluZyB0
aGlzIHNpbmNlIHlvdSdyZQ0KPiBkZXJlZmVyZW5jaW5nIGl0IGJlZm9yZSBjYWxsaW5nIHRoaXMg
ZnVuY3Rpb24/DQoNCk9rYXkuDQoNCj4gDQo+IC4uLg0KPiANCj4gPiBAQCAtMjU4LDEwICs1MzYs
NDYgQEAgc3RhdGljIHZvaWQgc3lucHNfZWRhY19oYW5kbGVfZXJyb3Ioc3RydWN0DQo+ID4gbWVt
X2N0bF9pbmZvICptY2ksICB9DQo+ID4NCj4gPiAgLyoqDQo+ID4gKyAqIHN5bnBzX2VkYWNfaW50
cl9oYW5kbGVyIC0gSW50ZXJydXB0IEhhbmRsZXIgZm9yIEVDQyBpbnRlcnJ1cHRzDQo+ID4gKyAq
IEBpcnE6ICAgICAgICBpcnEgbnVtYmVyDQo+ID4gKyAqIEBkZXZfaWQ6ICAgICBkZXZpY2UgaWQg
cG9pbnRlcg0KPiA+ICsgKg0KPiA+ICsgKiBUaGlzIGlzIHRoZSBJU1IgY2FsbGVkIGJ5IEVEQUMg
Y29yZSBpbnRlcnJ1cHQgdGhyZWFkLg0KPiANCj4gVGhlcmUncyBhbiAiRURBQyBjb3JlIGludGVy
cnVwdCB0aHJlYWQiPyE/IFRoaXMgaXMgdGhlIGZpcnN0IHRpbWUgSSBoZWFyIG9mIGl0Lg0KPiAN
Cj4gVHJ5IGFnYWluLg0KDQpPa2F5LiBJIHdpbGwgdXBkYXRlIHRoaXMgaW4gdjYuDQoNCj4gDQo+
ID4gKyAqIFRoaXMgaXMgdXNlZCB0byBjaGVjayBhbmQgcG9zdCBFQ0MgZXJyb3JzLg0KPiA+ICsg
Kg0KPiA+ICsgKiBSZXR1cm46IElSUV9OT05FLCBpZiBpbnRlcnJ1cHQgbm90IHNldCBvciBJUlFf
SEFORExFRCBvdGhlcndpc2UuDQo+ID4gKyAqLw0KPiA+ICtzdGF0aWMgaXJxcmV0dXJuX3Qgc3lu
cHNfZWRhY19pbnRyX2hhbmRsZXIoaW50IGlycSwgdm9pZCAqZGV2X2lkKSB7DQo+ID4gKwlzdHJ1
Y3QgbWVtX2N0bF9pbmZvICptY2kgPSBkZXZfaWQ7DQo+ID4gKwlzdHJ1Y3Qgc3lucHNfZWRhY19w
cml2ICpwcml2ID0gbWNpLT5wdnRfaW5mbzsNCj4gPiArCWNvbnN0IHN0cnVjdCBzeW5wc19wbGF0
Zm9ybV9kYXRhICpwX2RhdGEgPSBwcml2LT5wX2RhdGE7DQo+ID4gKwlpbnQgc3RhdHVzLCByZWd2
YWw7DQo+ID4gKw0KPiA+ICsJcmVndmFsID0gcmVhZGwocHJpdi0+YmFzZWFkZHIgKyBERFJfUU9T
X0lSUV9TVEFUX09GU1QpOw0KPiA+ICsJcmVndmFsICY9IChERFJfUU9TQ0VfTUFTSyB8IEREUl9R
T1NVRV9NQVNLKTsNCj4gPiArCWlmICghKHJlZ3ZhbCAmIEVDQ19DRV9VRV9JTlRSX01BU0spKQ0K
PiA+ICsJCXJldHVybiBJUlFfTk9ORTsNCj4gPiArDQo+ID4gKwlzdGF0dXMgPSBwX2RhdGEtPmdl
dGVycm9yX2luZm8ocHJpdik7DQo+ID4gKwlpZiAoc3RhdHVzKQ0KPiA+ICsJCXJldHVybiBJUlFf
Tk9ORTsNCj4gPiArDQo+ID4gKwlwcml2LT5jZV9jbnQgKz0gcHJpdi0+c3RhdC5jZV9jbnQ7DQo+
ID4gKwlwcml2LT51ZV9jbnQgKz0gcHJpdi0+c3RhdC51ZV9jbnQ7DQo+ID4gKwlzeW5wc19lZGFj
X2hhbmRsZV9lcnJvcihtY2ksICZwcml2LT5zdGF0KTsNCj4gPiArDQo+ID4gKwllZGFjX2RiZygz
LCAiVG90YWwgZXJyb3IgY291bnQgY2UgJWQgdWUgJWRcbiIsDQo+IA0KPiAiY2UiIGFuZCAidWUi
IGFyZSBhbHNvIGFiYnJldmlhdGlvbnMgYW5kIHNob3VsZCBiZSBpbiBjYXBzLg0KDQpPa2F5LiBX
aWxsIGJlIHRha2VuIGNhcmUgaW4gdjYuDQoNCj4gDQo+IC4uLg0KPiANCj4gPiArc3RhdGljIERF
VklDRV9BVFRSX1JXKGluamVjdF9kYXRhX2Vycm9yKTsNCj4gPiArc3RhdGljIERFVklDRV9BVFRS
X1JXKGluamVjdF9kYXRhX3BvaXNvbik7DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IHN5bnBzX2Vk
YWNfY3JlYXRlX3N5c2ZzX2F0dHJpYnV0ZXMoc3RydWN0IG1lbV9jdGxfaW5mbw0KPiA+ICsqbWNp
KSB7DQo+ID4gKwlpbnQgcmM7DQo+ID4gKw0KPiA+ICsJcmMgPSBkZXZpY2VfY3JlYXRlX2ZpbGUo
Jm1jaS0+ZGV2LCAmZGV2X2F0dHJfaW5qZWN0X2RhdGFfZXJyb3IpOw0KPiA+ICsJaWYgKHJjIDwg
MCkNCj4gPiArCQlyZXR1cm4gcmM7DQo+ID4gKwlyYyA9IGRldmljZV9jcmVhdGVfZmlsZSgmbWNp
LT5kZXYsICZkZXZfYXR0cl9pbmplY3RfZGF0YV9wb2lzb24pOw0KPiA+ICsJaWYgKHJjIDwgMCkN
Cj4gPiArCQlyZXR1cm4gcmM7DQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiANCj4gSSB0aGlu
ayBJJ20gaGF2aW5nIGEgZGVqYS12dToNCj4gDQo+IExhc3QgdGltZSBJIHNhaWQ6DQo+IA0KPiAi
TW9yZSBpbXBvcnRhbnRseSwgeW91IG5lZWQgdG8gcHV0IGFsbCB0aGF0IGluamVjdGlvbiBmdW5j
dGlvbmFsaXR5IGJlaGluZA0KPiBDT05GSUdfRURBQ19ERUJVRyAtIHlvdSBkb24ndCB3YW50IHRv
IGV4cG9zZSB0aGUgaW5qZWN0aW9uIGNhcGFiaWxpdGllcyBvbg0KPiBhIHByb2R1Y3Rpb24gbWFj
aGluZS4iDQo+IA0KPiBhbmQgeW91IHNhaWQ6DQo+IA0KPiAiSSBhZ3JlZS4gSSB3aWxsIHVwZGF0
ZSB0aGUgc2FtZSBieSBrZWVwaW5nIHRoZSBhYm92ZSBtZW50aW9uZWQgbWFjcm8uIg0KPiANCj4g
QnV0IG1heWJlIHlvdSd2ZSBtaXN1bmRlcnN0b29kIG1lLg0KDQpJIG1pc3NlZCBpdCBpbiB2NS4g
U29ycnkgZm9yIHRoZSBpbmNvbnZlbmllbmNlLiBXaWxsIHVwZGF0ZSB0aGF0IGluIHY2Lg0KDQo+
IA0KPiBHcmVwIHRoZSBvdGhlciBFREFDIGRyaXZlcnMgdG8gZmluZCBvdXQgaG93IHRvIGhpZGUg
dGhlIGluamVjdGlvbiBmdW5jdGlvbmFsaXR5DQo+IGJlaGluZCBDT05GSUdfRURBQ19ERUJVRy4N
Cj4gDQo+IEFuZCBtYXliZSB0aGlzIHBhdGNoIGlzIGJlY29taW5nIGh1dWdlIGFuZCB0b28gdW53
aWVsZHkgdG8gcmV2aWV3IHByb3Blcmx5DQo+IGFuZCBmb3IgeW91IHRvIGluY29ycG9yYXRlIGFs
bCB0aGUgZmVlZGJhY2suDQo+IA0KPiBUaGVyZWZvcmUsIHBsZWFzZSBzcGxpdCBpdCBpbiBzaW5n
bGUgcGF0Y2hlcywgZWFjaCBvZiB3aGljaCBpcyBkb2luZyBkaWZmZXJlbnQNCj4gdGhpbmdzOg0K
PiANCj4gMS4gZml4dXAvY2hhbmdlIGNvbW1lbnRzDQo+IDIuIGFkZCBkZWZpbmVzDQo+IDMuIGFk
ZCBmdW5jdGlvbmFsaXR5IFgNCj4gNC4gYWRkIGZ1bmN0aW9uYWxpdHkgWQ0KPiAuLi4NCj4gNS4g
YWRkIGluamVjdGlvbg0KPiA2LiB0aWUgaXQgYWxsIHRvZ2V0aGVyDQoNCldpbGwgZG8gdGhlIHNh
bWUgaW4gdjYuDQoNClRoYW5rcywNCk1hbmlzaCBOYXJhbmkNCg==
