Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86F5C282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 06:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7833520661
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 06:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pi5xaejz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfBLGDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 01:03:55 -0500
Received: from mail-eopbgr10084.outbound.protection.outlook.com ([40.107.1.84]:9453
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725916AbfBLGDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 01:03:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KCFp9pSEKgQsdr5TaYOrJEapocfEmcbxmFLZXrGssQ=;
 b=pi5xaejzEZOLbTAH/4cZen7KyYRrkZ181kNxqNFkGdXna+n6hiQ5n61ImBoS9PTOc/MgmXK8M1RguwvOWnYmB6tnv1sT3WJrbMuzToTBdPx6UuacKXe5DGcYQNWQNOXnUhpO9ZEg4oUvnbVR5R7JiQW29YkCWc7dIDG9TUgewW0=
Received: from VI1PR04MB4558.eurprd04.prod.outlook.com (20.177.55.216) by
 VI1PR04MB5567.eurprd04.prod.outlook.com (20.178.123.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Tue, 12 Feb 2019 06:03:43 +0000
Received: from VI1PR04MB4558.eurprd04.prod.outlook.com
 ([fe80::b0fe:dee7:b2d3:9355]) by VI1PR04MB4558.eurprd04.prod.outlook.com
 ([fe80::b0fe:dee7:b2d3:9355%5]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 06:03:43 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Chen Yu <chenyu56@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 6/9] usb: roles: Find the muxes by also matching
 against the device node
Thread-Topic: [PATCH v2 6/9] usb: roles: Find the muxes by also matching
 against the device node
Thread-Index: AQHUuLVSCFz0E1ZQKUWUh+dd3nT5iqXablHwgAAOWoCAAThjEA==
Date:   Tue, 12 Feb 2019 06:03:42 +0000
Message-ID: <VI1PR04MB4558F4F7BC10D82FC1BE71B489650@VI1PR04MB4558.eurprd04.prod.outlook.com>
References: <20190130160259.46919-1-heikki.krogerus@linux.intel.com>
 <20190130160259.46919-7-heikki.krogerus@linux.intel.com>
 <VI1PR04MB4558283CA9D752D5452FA09989640@VI1PR04MB4558.eurprd04.prod.outlook.com>
 <20190211104629.GE16987@kuha.fi.intel.com>
In-Reply-To: <20190211104629.GE16987@kuha.fi.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=jun.li@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5567;6:GaVH/JOXrFbjKqOVJO5B0IhoUevmof50aZbKoTAbooq+/s6J7xGDO5ndh8rDooJ6h2S6clhUsONRDssvG/qmo16fQ764p0e/IiCTMTSzycCApeTI08O+kCuLk8TinWqinKmPIjN032z8Ww5dUPOUE+45PIsWgOSqlIRWZtwsLB1nKUaRkmnqfHldYjZBg2d8RwzZw00Al6LlamCxbQP8oYb2V5sdksDyN3nE6yAuI0ZCFu8GZKzALQO/5gWNx2GIk0r6zk5faMFwXa5YZhHClWugtrsGiTA6K8xP2A19l3uJy0wXUuvlNvy5pZjgKR15H8tMEZxhwz+OlTB5la7lIfB8Kddj/fEnaFd6elEdItv9Lt7Am58cK5x7Kf8jTUHrqzfUOlI8MGHNimD5l/s7Kl+7EcKIYli5i5nc+PfWVm31LnwiJ6c8y48wqZd0y3M7+bG1ZWD70AA/0JEIRpze2Q==;5:KAq9wf6jxGpphKBH9DDZYtiA1h+sGQ0Vlo+iB89xy1lPAMV8pYxVq/7fS1GWnpKCTo4GCjfUiIbWlo42oQmStR8YyZ1/BPjGRZDutibxDBI95b8rn31sJGxifLCqkLKA3q0DDfJy2v3UuSEe627QRz7sXfj6tvuUOuWgn20zAoAPFYhn0V6s/PTNwql6wBOJKjmgRReLdfIiTwQsnb2bzw==;7:5mNW1Ef0UXveThL8OTSVIudo5YEEfc7/AEIC5v/gnCtuyEio6x/fiZWgYhcvhKl/5ZGsDZbyEK1M5byqcEiZ55L59Ek1mxPJpifHKg7abefPQP8Y12H0fdkf8IV02TY5Cp/1s4Wb0AY1FHqya1ivMw==
x-ms-office365-filtering-correlation-id: 2a6dbd15-f132-4b80-675e-08d690afd7b1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5567;
x-ms-traffictypediagnostic: VI1PR04MB5567:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB55670B4CC9B176304B0D90DF89650@VI1PR04MB5567.eurprd04.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(39860400002)(376002)(346002)(199004)(189003)(13464003)(6116002)(4326008)(3846002)(53936002)(6246003)(76176011)(14454004)(6306002)(256004)(229853002)(9686003)(2906002)(476003)(446003)(11346002)(97736004)(8936002)(486006)(106356001)(305945005)(44832011)(68736007)(74316002)(81156014)(93886005)(478600001)(7696005)(71190400001)(71200400001)(7736002)(45080400002)(8676002)(86362001)(81166006)(966005)(55016002)(186003)(25786009)(105586002)(6436002)(26005)(6916009)(6506007)(53546011)(102836004)(33656002)(316002)(54906003)(66066001)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5567;H:VI1PR04MB4558.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NIqF9KCitkwpqzLBGVgbH02Dw9Dz/AuTO+FkckD5tgcuMBtnX2/xF7v2+CMMPfMx6gCOxIsznN3dYCMG3QSGnTrB2EgRdkBHEMTkDO/OdPsHuXKh6SWiau0NKbnqD5CCBc/23TMDeOHh7yN7qsjBxeoF2NiR95rmWdEW79j26nL/VyyyOVFy5isPsLBMDbE7Sn4Jo2KzPTKedY69V2oRI26Nh/FsaHE3xG0lGygXrJ6ARdm/E7caqqo9Al5EtMJo1UOp06X263ViNDb0NJ5gfjHz6DvX/SZButVCNSYzAIuuz2Euv0QtE2C+5aMw4nmugCtiyQMrd1D4lGIAYLSG/T3/2K1vsY+p4a+fd++VttwqIry7ZPLpKeEc9h6t66WiNIsl6gfVlrf/Uq5U4uIpTFScgcWilvqw+dUiFIC49Lg=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6dbd15-f132-4b80-675e-08d690afd7b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 06:03:43.0917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5567
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGVpa2tpIEtyb2dlcnVz
IDxoZWlra2kua3JvZ2VydXNAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiAyMDE5xOoy1MIxMcjV
IDE4OjQ2DQo+IFRvOiBKdW4gTGkgPGp1bi5saUBueHAuY29tPg0KPiBDYzogR3JlZyBLcm9haC1I
YXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IEFuZHkgU2hldmNoZW5rbw0KPiA8
YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT47IENoZW4gWXUgPGNoZW55dTU2QGh1YXdlaS5jb20+
OyBIYW5zIGRlDQo+IEdvZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPjsgbGludXgtdXNiQHZnZXIu
a2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYyIDYvOV0gdXNiOiByb2xlczogRmluZCB0aGUgbXV4ZXMgYnkgYWxzbyBtYXRj
aGluZyBhZ2FpbnN0IHRoZQ0KPiBkZXZpY2Ugbm9kZQ0KPiANCj4gT24gTW9uLCBGZWIgMTEsIDIw
MTkgYXQgMDk6NTg6MDRBTSArMDAwMCwgSnVuIExpIHdyb3RlOg0KPiA+IEhpIEhlaWtraSwNCj4g
Pg0KPiA+ID4gQEAgLTg0LDcgKzg1LDEyIEBAIGVudW0gdXNiX3JvbGUgdXNiX3JvbGVfc3dpdGNo
X2dldF9yb2xlKHN0cnVjdA0KPiA+ID4gdXNiX3JvbGVfc3dpdGNoICpzdykgIH0NCj4gPiA+IEVY
UE9SVF9TWU1CT0xfR1BMKHVzYl9yb2xlX3N3aXRjaF9nZXRfcm9sZSk7DQo+ID4gPg0KPiA+ID4g
LXN0YXRpYyBpbnQgX19zd2l0Y2hfbWF0Y2goc3RydWN0IGRldmljZSAqZGV2LCBjb25zdCB2b2lk
ICpuYW1lKQ0KPiA+ID4gK3N0YXRpYyBpbnQgc3dpdGNoX2Z3bm9kZV9tYXRjaChzdHJ1Y3QgZGV2
aWNlICpkZXYsIGNvbnN0IHZvaWQNCj4gPiA+ICsqZndub2RlKSB7DQo+ID4gPiArCXJldHVybiBk
ZXZfZndub2RlKGRldikgPT0gZndub2RlOw0KPiA+DQo+ID4gWW91IG1pc3NlZCB0aGUgY29tbWVu
dA0KPiA+IGh0dHBzOi8vZW1lYTAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91
cmw9aHR0cHMlM0ElMkYlMkZsa20NCj4gPg0KPiBsLm9yZyUyRmxrbWwlMkYyMDE5JTJGMSUyRjIy
JTJGNDM3JmFtcDtkYXRhPTAyJTdDMDElN0NqdW4ubGklNDBueA0KPiBwLmNvbQ0KPiA+ICU3Qzhj
MmQ0MGQ1ZTVkMjQ2ZGEzNGFkMDhkNjkwMGUzMWNmJTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTlj
NQ0KPiBjMzAxNjM1DQo+ID4gJTdDMCU3QzAlN0M2MzY4NTQ3ODgwNDA5NjUyMjQmYW1wO3NkYXRh
PWRiNGd2WEtjOUluV2lsdHN3ZWV0eFhZcg0KPiB0UGJ0ZlgNCj4gPiBqc2hQaCUyRm52QTI0aWcl
M0QmYW1wO3Jlc2VydmVkPTANCj4gPg0KPiA+IHJldHVybiBkZXZfZndub2RlKGRldi0+cGFyZW50
KSA9PSBmd25vZGU7DQo+IA0KPiBUaGF0J3MgYWN0dWFsbHkgbm90IHRoZSBjYXNlLiBzdHJ1Y3Qg
dXNiX3JvbGVfc3dpdGNoX2Rlc2MgaGFzIGEgbWVtYmVyIGZvciBmd25vZGUsDQo+IGFuZCB0aGF0
J3Mgd2hhdCB3ZSB1c2Ugd2l0aCB0aGUgYWN0dWFsIG11eCBkZXZpY2UuIENoZWNrDQo+IHVzYl9y
b2xlX3N3aXRjaF9yZWdpc3RlcigpOg0KPiANCj4gICAgICAgICAuLi4NCj4gICAgICAgICBzdy0+
ZGV2LmZ3bm9kZSA9IGRlc2MtPmZ3bm9kZTsNCj4gICAgICAgICAuLi4NCj4gDQo+IFNvcnJ5IGZv
ciBub3QgcmVhbGl6aW5nIGl0IGJlZm9yZS4NCg0KU28gZGVzYy0+Zndub2RlIHNob3VsZCBiZSBp
bml0aWFsaXplZCBiZWZvcmUgZG8gdXNiX3JvbGVfc3dpdGNoX3JlZ2lzdGVyKCk/DQpCdXQgc2Vl
bXMgdXNiX3JvbGVfc3dpdGNoX2Rlc2MgaXMgYSByZWFkLW9ubHkgb2JqZWN0IHNvIGNhbid0IGJl
IHNldCBhdCBydW50aW1lLg0KDQp1c2JfY29udHJvbGxlcl9ub2RlIHsNCgkuLi4NCgl1c2Itcm9s
ZS1zd2l0Y2g7DQoNCglwb3J0IHsNCgkJc3dfcHJvdmlkZXJfbm9kZTogZW5kcG9pbnQgew0KCQkJ
cmVtb3RlLWVuZHBvaW50ID0gPCZzd19jb25zdW1lcl9ub2RlPjsNCgkJfTsNCgl9Ow0KfTsNCg0K
dHlwZWNfbm9kZSB7DQoJLi4uDQoJcG9ydCB7DQoJCXN3X2NvbnN1bWVyX25vZGU6IGVuZHBvaW50
IHsNCgkJCXJlbW90ZS1lbmRwb2ludCA9IDwmc3dfcHJvdmlkZXJfbm9kZT47DQoJCX07DQoJfTsN
Cn07DQoNCklzIG15IHVuZGVyc3RhbmRpbmcgY29ycmVjdD8NCg0KVGhhbmtzDQpKdW4NCj4gDQo+
IA0KPiB0aGFua3MsDQo+IA0KPiAtLQ0KPiBoZWlra2kNCg==
