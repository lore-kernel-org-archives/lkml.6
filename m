Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7945C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8745920892
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="jbr2Jtzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8745920892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=infinera.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbeKHEN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 23:13:27 -0500
Received: from mail-by2nam03on0063.outbound.protection.outlook.com ([104.47.42.63]:12320
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726915AbeKHEN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 23:13:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmGJkLp2XbSOFM4xM8xLQk3uJkBFoZOiPD2xS2qXJV4=;
 b=jbr2JtzssaBy/BjD26OYX9rsQcnxFDZVYKDO87xHAhi+GbAnzzG5ca19o8jB0vnf0gRBrimsMb7IuqWEHYQbXc4I1fp5M29LTgE0xkQ8AQ1lrg4XTY62D1zLymz9eIbVIchRCzfaUvailYMnO3w501FTTzpS9n55TGaWQwzxguE=
Received: from CY1PR10MB0731.namprd10.prod.outlook.com (10.163.235.25) by
 CY1PR10MB0474.namprd10.prod.outlook.com (10.163.90.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Wed, 7 Nov 2018 18:41:47 +0000
Received: from CY1PR10MB0731.namprd10.prod.outlook.com
 ([fe80::c0f4:b5fe:1197:8f35]) by CY1PR10MB0731.namprd10.prod.outlook.com
 ([fe80::c0f4:b5fe:1197:8f35%5]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 18:41:47 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "danielwa@cisco.com" <danielwa@cisco.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nkela@cisco.com" <nkela@cisco.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "xe-linux-external@cisco.com" <xe-linux-external@cisco.com>
Subject: Re: [PATCH] jffs2: implement mount option to configure endianness
Thread-Topic: [PATCH] jffs2: implement mount option to configure endianness
Thread-Index: AQHUdhzsqXgjqeVdYEqFu2rUs5D51aVEBd8AgAADEoCAAHQfAIAAFpWAgAAHN4CAAAv2gA==
Date:   Wed, 7 Nov 2018 18:41:47 +0000
Message-ID: <bee96cb5db73c325675881b180006e1382718abe.camel@infinera.com>
References: <20181106214928.40020-1-nkela@cisco.com>
         <921b0f78cf67d7307a0555e1fd6f2c2976310adc.camel@infradead.org>
         <1e4c066d1896e2a0b8b146253d34d05cc4f9ab36.camel@infinera.com>
         <8b08e8b992093453bb2b9caff8cff08c.squirrel@twosheds.infradead.org>
         <20181107173303.slnb3i2d6ufaonp7@zorba>
         <df9cdf1753ec7e6e20c12aa096b98453.squirrel@twosheds.infradead.org>
In-Reply-To: <df9cdf1753ec7e6e20c12aa096b98453.squirrel@twosheds.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Joakim.Tjernlund@infinera.com; 
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR10MB0474;6:NV+mP2Fdxsp81vhagDWzQBlpZGn5Bh658/PrA5PcgIPp+TpVCKovEehXSXq/o3rE4oKLFFMIODgpr44Qq/m3BhBuO7VMgv1LacspzKpWYP8IEcE13XLyMl2AaYU+aQP680jKJfFAP62EhFcjjkExgnuYxAl3VmMssxgJIb+gE0RgHN/3bc1WW0vmTMNBvYyimL6jBXH1ll18V+KkHBinvffq/K5LIo9hlpofh6iPy1MK/ddoqgfhJva12mCluEshyGrVINRIe2Jp8DdN+gIBwamF4YORp0LW8OoZMwAASNh4k7RqEAJVqyY/ZPs1AX6FcRjzx/WGlycM/gOeBsFB6rcCxqQ3IekPRw+qMKTl7QNWmDz+q2xWZjle/RefPmYs//jG5xA+ytnagsnE4vHO/CJmXfwOQZVlw487WtfSG7GrH7XNiVVg/JIppWRswA6J+Hv+PmbDsZzpGTAHTjLVBQ==;5:DEnBU+CWE4uqp86I7RJR6bbmTcq0Ljvw96/ZI9zyNRQDNI3sSt2546sc1YtfwWHmo9WTKBaDRgMsjnelOUYpONsu4pOynjAtc6p05CeoVaeET/tHdy73Oj7ms8nAnVcGB5A4cJaFUlTafG+07P12+jjxVUmlFWF+CCET4TSiQwU=;7:ut9wJRS8SCtonJvpux/X4s6qeICxqWB/zI33K5Jza6thorznI9NzubDtYx8sTEPDJnZphy1r5u7R7VVGsy9ZyIYOEVxals3gyvOgF1erC5G8JeUBMbsB/3GjxBUD8fbrIynL64Yqqc18xhgTG/h+ig==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 91219c4c-2403-4903-e6a4-08d644e0ac4b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR10MB0474;
x-ms-traffictypediagnostic: CY1PR10MB0474:
x-microsoft-antispam-prvs: <CY1PR10MB0474C999881F8F2EA4DB8D41F4C40@CY1PR10MB0474.namprd10.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231382)(944501410)(52105095)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:CY1PR10MB0474;BCL:0;PCL:0;RULEID:;SRVR:CY1PR10MB0474;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(366004)(346002)(39850400004)(199004)(189003)(72206003)(36756003)(486006)(6436002)(2906002)(86362001)(110136005)(54906003)(2616005)(5660300001)(11346002)(6486002)(316002)(446003)(305945005)(7736002)(476003)(6506007)(6246003)(118296001)(66066001)(76176011)(106356001)(229853002)(105586002)(93886005)(99286004)(478600001)(102836004)(97736004)(6512007)(53936002)(26005)(186003)(4326008)(25786009)(2501003)(71190400001)(71200400001)(8936002)(5024004)(8676002)(256004)(2900100001)(68736007)(3846002)(14454004)(81156014)(81166006)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR10MB0474;H:CY1PR10MB0731.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: infinera.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wm+T3ErN+wNJ5vIOKsVXfZPcOQ5hubBOXCs6q8IUj5b/CbOQNKrIsX5t+9vYXzjiG5eAVfjDJ3kusJTk2rupiIgvwBoh2P00L/98dAV6Ihyclv5kLkP0vwrdt8Q6iyjas+WIQZbFPyViJFGsDQ1gYp8MBZGRA/PXCsHUyiR1J7WX6HwPjIqQwjDZNZH4l2eKmcjEVvnFzjZBkzA2ZPufv/cuT/72ZzPEa/XEA0yJh/B0Gm8pTn+jRQDpV4dIMZm1Xdy7uvQxzUkZ3MRcVKKfUSWfTSWJ+Iwb4kmU78rW6CrecicTrjnteM6bDrUlva15ToI7tVPvD+GheZSa87IeGw0Q0151PIRy5IrhQbNi+ks=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A5392B57406D64CBAD4DB958574B3E8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91219c4c-2403-4903-e6a4-08d644e0ac4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 18:41:47.2428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR10MB0474
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTExLTA3IGF0IDE3OjU4ICswMDAwLCBEYXZpZCBXb29kaG91c2Ugd3JvdGU6
DQo+IENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9y
Z2FuaXphdGlvbi4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0K
PiANCj4gDQo+ID4gT24gV2VkLCBOb3YgMDcsIDIwMTggYXQgMDQ6MTI6MTRQTSAtMDAwMCwgRGF2
aWQgV29vZGhvdXNlIHdyb3RlOg0KPiA+ID4gPiBZZXMsIHRoaXMgbWF5IHNsb3cgdGhpbmdzIGRv
d24uIEkgYW0gbm90IHN1cmUgSSBhZ3JlZSB3aXRoIHRoZSBpbXBsLg0KPiA+ID4gPiBlaXRoZXIu
DQo+ID4gPiA+IENvdWxkIG9uZSBub3QgbWFrZSBjcHVfdG9famVfWC9qZVhfdG9fY3B1IGEgZnVu
Y3Rpb24gcHRyIHdoaWNoIGlzIHNldA0KPiA+ID4gdG8NCj4gPiA+ID4gYSBmdW5jLiB3aXRoIHRo
ZSBjb3JyZWN0IGVuZGlhbj8NCj4gPiA+IA0KPiA+ID4gT24geDg2IHJldHBvbGluZSB3b3VsZCBt
YWtlIHRoYXQgcXVpdGUgc2xvdy4NCg0KcmV0cG9saW5lIGFzaWRlLCB3b3VsZCBpdCBtYWtlIGEg
ZGlmZmVyZW5jZSA/DQoNCj4gPiANCj4gPiBJcyB4ODYgdGhlIGxhcmdlc3QgY29uc3VtZXIgb2Yg
amZmczIgPw0KPiANCj4gQ2VydGFpbmx5IG5vdC4gSSdtIG5vdCBzdXJlIHdoaWNoIGFyY2hpdGVj
dHVyZXMgZG8gaGF2ZSBTcGVjdHJlIFYyDQo+IG1pdGlnYXRpb25zIHdoaWNoIG1ha2UgaW5kaXJl
Y3QgYnJhbmNoZXMgZXhwZW5zaXZlIG5vdy4uLiBwZXJoYXBzIHRoZXJlIGlzDQo+IG5vIGludGVy
c2VjdGlvbiB3aXRoIHRoZSBjYXNlcyB3aGVyZSB3ZSByZWFsbHkgY2FyZSBhYm91dCBKRkZTMiBi
ZWluZw0KPiBDUFUtYm91bmQ/DQoNCkFsbCB0aGF0IHBhc3Npbmcgb2YgYSBuZXcgZXh0cmEgYXJn
IGFuZCBleHRyYSBpZiAuLiBlbGlmIC4uIGRvZXMgY29zdCB0b28uDQo=
