Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1D0C282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 02:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC738214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 02:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qMLwbldg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfA2CCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 21:02:44 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:1255 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726995AbfA2CCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 21:02:43 -0500
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4fb4400000>; Tue, 29 Jan 2019 10:02:41 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Mon, 28 Jan 2019 18:02:40 -0800
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Mon, 28 Jan 2019 18:02:40 -0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 29 Jan
 2019 02:02:38 +0000
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.57) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Tue, 29 Jan 2019 02:02:38 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3510.namprd12.prod.outlook.com (20.179.94.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Tue, 29 Jan 2019 02:02:19 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::e4f9:9814:247a:d064]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::e4f9:9814:247a:d064%5]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 02:02:19 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
CC:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V3 3/3] i2c: tegra: Add DMA Support
Thread-Topic: [PATCH V3 3/3] i2c: tegra: Add DMA Support
Thread-Index: AQHUtStTAcI7HkG9xUCTwb3QXTduAKXCELwAgANJJjCAACemIA==
Date:   Tue, 29 Jan 2019 02:02:18 +0000
Message-ID: <BYAPR12MB339837F4E341F7911F1E1E67C2970@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1548475073-12408-1-git-send-email-skomatineni@nvidia.com>
 <1548475073-12408-3-git-send-email-skomatineni@nvidia.com>
 <5973707c-555f-a27c-2ff3-e867d4b2cde7@gmail.com>
 <BYAPR12MB339874021C106E447529E887C2960@BYAPR12MB3398.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB339874021C106E447529E887C2960@BYAPR12MB3398.namprd12.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3510;6:YO5WdWjPf/efMui8xbQmyP+MPxRRmzDQT9RfIRVKBZlzOnA0ELGji1Nk9e6rU4c9aPvX4x3UGFzhc/z+XkQaqFQGMtZLAg5sVcLmWtQPmh9fPtA4S3XkItXgpozSfiel/6xUD8u7JQhVmcisIAVw/5AFnnop5/hVhdv/P7LXkHv5TalYqMl5p2YeMdOE72Xrn53IXqgysfnf2qoidcnOh49XbfIdompZ6UvULRYXjbEobdqlfMmfeiCzTqx7dSfPRQkQlP+NS5wyPFPVBUubLcp6EapjiOGsJ/oO4P4mcjZHOV5KcZhiWUoiihCexzgl3UN8h0Jvf8Mv17yRSbDsDI9a8Et/pfszvRSYHsPZvVMy0ycVRGTt4soLyjtug6OxYHCc/hQY6UGB8JXTtnKlZzkz+KvCRaKy/mYgj/04Lyl7xLox43PKrmFlDL5KQ5OS5DwVNcApAlfPW7j3lm7Fyg==;5:ftGdAZdFeNjUb5CYSbGKkkYnt3DhvJVxfajDk34twZQsFmYOMXnqZ8IJUoCaf8YnTPUS9us0yxMjs+DfXqGrITkAUMAoFuaiRrdUrz1WGNDgxfF5kgIrtbq9+xnu3nvOEvXxDtstNk+p7WhVi/0am4cRYo7fkgZlQ3Y6Ahs8uL496wF6wADlMoG7o8ABZRXnstm6TKPHVUwOmBjgXZrSSQ==;7:MoB90aPsXWk6vDgzcwq0n3HqNgH6V28YymUU2I91NlaW0zD5sm8l3325/t+QRmYdrJEDz3KyyLo5HmI/TxGBSAWmU6NgN+6+7U+upFYug3662Q2wET+UroXb8U0zAjjnVaKm5eGBmpSYukN5L8bvcg==
x-ms-office365-filtering-correlation-id: 88ca4ebf-081e-4ff0-265b-08d6858dcccb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3510;
x-ms-traffictypediagnostic: BYAPR12MB3510:
x-microsoft-antispam-prvs: <BYAPR12MB35101C9FE1AE4E95BF9D316CC2970@BYAPR12MB3510.namprd12.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(366004)(189003)(199004)(39060400002)(74316002)(53936002)(86362001)(68736007)(76176011)(97736004)(6636002)(9686003)(55016002)(33656002)(2906002)(4326008)(6246003)(256004)(14444005)(7696005)(6436002)(25786009)(229853002)(476003)(11346002)(446003)(8936002)(81166006)(81156014)(93886005)(2501003)(14454004)(305945005)(54906003)(110136005)(71200400001)(102836004)(316002)(66066001)(478600001)(106356001)(186003)(8676002)(486006)(7736002)(26005)(105586002)(6506007)(99286004)(71190400001)(3846002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3510;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YTMGJ+Xwhe6KHKFukE7HmrSjAY0MUSmmwktfiY27XLSWZZ7pPJMJDo7dWjYK7NWq9WjoNCzHDdQbMDwuwK2lbzI00vCdcvN96vqDvp4/wpRk2jLRLHQbDa0iT8AraALBqCTTwh4sgMC9UeQ9dYP3IGaucaOUSM3jTr+tDhDOTz6dReGJufHQNPDfBKH8Xr7xCXap74//GOd71faAfv2YSJ2gk01WsblVKLUiyS0cPnE7xcZNCQD/UbZipPFDrdKzecGZgBzeyPCjOmtZQ0OSwOFtixDKNJspkYSkXPQYrOlYJF6dNCaWM3ciy3l7mihsdxHNgQPqz/r14/jTkPp1Yayh4PqI8GiDLrR2DAjgHLy2drnFYF42ALJR3abWFuuB2k23LDusyzMeI1jwcdhRMQErQGRSAknZD0jA+mGnIjk=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ca4ebf-081e-4ff0-265b-08d6858dcccb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 02:02:19.0371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3510
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548727361; bh=g7vq4dOKJcPXIaHPXSqWPnouXsxsayepYmkq1DrX/Gg=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-microsoft-exchange-diagnostics:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=qMLwbldg89wUpJc+8CHjTuziKLnta8M1oyYqj1B0yYPTmJNZmyCvtxIX/nEYSMSaM
         iaVsDn3NWefDiBBFmpFFi71kAPKiLD5QCJG+px/r9ykP0C06vUQuA7DnyfUWbTC2JM
         83p2Z2t6IraSHsgNN7oRT0mutEmVhZMLjo7ciKQemas3MY2kgEAQbr3VkDHtOR5Dam
         bmTnThnT3HiTMAuPoFazEvb+p27mpQuwcLO4isXEm98QUlKLQtQqIzzflRrLVg8XvZ
         yZ33fXnWNuJUVBFVJSdrWQVkqfqqmxMTmdnpj/NzLGdmYN5wCegN/oTTPA6vJqGwQs
         ZNbm0EFPfxilQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gPiA+IFRoaXMgcGF0Y2ggYWRkcyBETUEgc3VwcG9ydCBmb3IgVGVncmEgSTJDLg0KPiA+
ID4gDQo+ID4gPiBUZWdyYSBJMkMgVFggYW5kIFJYIEZJRk8gZGVwdGggaXMgOCB3b3Jkcy4gUElP
IG1vZGUgaXMgdXNlZCBmb3IgDQo+ID4gPiB0cmFuc2ZlciBzaXplIG9mIHRoZSBtYXggRklGTyBk
ZXB0aCBhbmQgRE1BIG1vZGUgaXMgdXNlZCBmb3IgDQo+ID4gPiB0cmFuc2ZlciBzaXplIGhpZ2hl
ciB0aGFuIG1heCBGSUZPIGRlcHRoIHRvIHNhdmUgQ1BVIG92ZXJoZWFkLg0KPiA+ID4gDQo+ID4g
PiBQSU8gbW9kZSBuZWVkcyBmdWxsIGludGVydmVudGlvbiBvZiBDUFUgdG8gZmlsbCBvciBlbXB0
eSBGSUZPJ3MgYW5kIA0KPiA+ID4gYWxzbyBuZWVkIHRvIHNlcnZpY2UgbXVsdGlwbGUgZGF0YSBy
ZXF1ZXN0cyBpbnRlcnJ1cHQgZm9yIHRoZSBzYW1lIA0KPiA+ID4gdHJhbnNhY3Rpb24gYWRkaW5n
IG92ZXJoZWFkIG9uIENQVSBmb3IgbGFyZ2UgdHJhbnNmZXJzLg0KPiA+ID4gDQo+ID4gPiBETUEg
bW9kZSBpcyBoZWxwZnVsIGZvciBMYXJnZSB0cmFuc2ZlcnMgZHVyaW5nIGRvd25sb2FkaW5nIG9y
IA0KPiA+ID4gdXBsb2FkaW5nIEZXIG92ZXIgSTJDIHRvIHNvbWUgZXh0ZXJuYWwgZGV2aWNlcy4N
Cj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogU293amFueWEgS29tYXRpbmVuaSA8c2tvbWF0
aW5lbmlAbnZpZGlhLmNvbT4NCj4gPiA+IA0KPiA+ID4gLS0tDQo+ID4NCj4gPiBTZWVtcyB0aGVy
ZSBhcmUgZ29vZCBuZXdzLCBBUEIgRE1BIGNvdWxkIGFjY2VzcyBJUkFNLiBRdW90ZSBmcm9tIFRS
TTogIlRoZSBzb3VyY2UgbWF5IGJlIERSQU0gb3IgSVJBTSwgYW5kIHRoZSBkZXN0aW5hdGlvbiBs
b2NhdGlvbiBjb3VsZCBiZSBkZXZpY2VzIHBsYWNlZCBvbiA+IEFQQiBCdXM7IG9yIHZpY2UgdmVy
c2EiLiBIZW5jZSBpdCBzaGFsbCBiZSBtdWNoIG1vcmUgZWZmaWNpZW50IHRvIHVzZSBJUkFNIGZv
ciB0aGUgRE1BIGJ1ZmZlciwgcGxlYXNlIGNvbnNpZGVyIHRoYXQgdmFyaWFudC4NCj4gPg0KPg0K
PiBSZWdhcmRpbmcgeW91ciByZXF1ZXN0IGZvciBXcml0ZSBDb21iaW5lZCBtZW1vcnksIGl0IGRv
ZXNu4oCZdCBndWFyYW50ZWUgdGhlIG9yZGVyLg0KPg0KPiBNYWluIHJlYXNvbiBmb3IgYWRkaW5n
IERNQSBtb2RlIHN1cHBvcnQgdG8gVGVncmEgSTJDIGRyaXZlciBpcyBub3QgZm9yIGFjdHVhbCB0
cmFuc2ZlciBwZXJmb3JtYW5jZSBidXQgZm9yIG5vdCBoYXZpbmcgZGVsYXllZCBJMkMgdHJhbnNm
ZXIgbWFpbmx5IGluIGNhc2Ugb2YgQ1BVIGZ1bGx5IGxvYWRlZCBhbmQgSTJDIHRyYW5zZmVyIGR1
cmluZyB0aGF0IHRpbWUgKEZXIHVwbG9hZC9kb3dubG9hZCwgU2Vuc29yIHByb2dyYW1taW5nLi4p
IHVzaW5nIFBJTyA+IG1vZGUgaW50cm9kdWNlcyBkZWxheSBiL3cgYnl0ZXMgb2YgdHJhbnNmZXIg
YXMgaXQgZGVwZW5kcyBvbiBDUFUgc2NoZWR1bGluZyBhbmQgaW50ZXJydXB0IHByaW9yaXR5IHdo
aWNoIGltcGFjdHMgb24gc2VydmluZyBpbnRlcnJ1cHRzIGFuZCBmaWxsaW5nIEZJRk8gZm9yIHRy
YW5zZmVyIHRvIGhhcHBlbi4NCj4NCj4gQmVsb3cgYXJlIHRoZSBjYXNlcyB3aGVyZSB3ZSBzZWUg
dGhlIG5lZWQgZm9yIERNQSBtb2RlIGZvciBJMkMgdHJhbnNmZXJzIChtYWlubHkgZHVyaW5nIHRo
ZSB1c2UgY2FzZXMgd2hlcmUgQ1BVIGlzIGZ1bGx5IGxvYWRlZCkNCj4gLSBTb21lIGRldmljZXMg
bmVlZCBGVyB1cGRhdGUgb3ZlciBJMkMgYW5kIERNQSBtb2RlIGhlbHBzIGluIHN1Y2ggbGFyZ2Ug
dHJhbnNmZXJzIG9uIEkyQyByZWR1Y2luZyBDUFUgaW50ZXJ2ZW50aW9uIG1haW5seSB3aGVuIENQ
VSBpcyBmdWxseSBsb2FkZWQuDQo+IC0gU29tZSBkZXZpY2VzIGhhdmUgaW50ZXJuYWwgdGltZW91
dCBmb3Igbm8gZGF0YSBhY3Rpdml0eSBvbiBJMkMgYnVzIGFmdGVyIHRoZSBzdGFydCBjb21tYW5k
ICh0aW1lIHJlc3RyaWN0aW9uIGIvdyBkYXRhIHRvIGRhdGEgd2l0aGluIHNpbmdsZSB0cmFuc2Fj
dGlvbikgdG8gYXZvaWQgYnVzIGhhbmcgYW5kIHRoZXkgZm9yY2UgdG8gc3RvcCB3aGVuIHRpbWVv
dXQgaGFwcGVucy4gd2l0aCBQSU8gbW9kZSBpbiB0aG9zZSBjYXNlcywgZGVwZW5kaW5nIG9uIENQ
VSBsb2FkLCB0aGVyZSBjb3VsZCBiZSBtb3JlIGRlbGF5IGluIHNlcnZpbmcgaW50ZXJydXB0IGZv
ciBkYXRhIHJlcXVlc3RzIGFuZCBzZW5kaW5nIHRoZSBkYXRhIGNhdXNpbmcgdGhlIGRldmljZSB0
byB0cmlnZ2VyIGl0cyB0aW1lb3V0IGFuZCB0cmFuc2FjdGlvbiBzdG9wcy4NCj4gLSBIZWxwcyBm
b3IgcmVhZGluZyBkYXRhIGZyb20gSTJDIHNlbnNvcnMgd2l0aCBiZXR0ZXIgQlcuDQoNCkZvdW5k
IGZyb20gZG9jdW1lbnRhdGlvbiBkZWZhdWx0IGF0dHJpYnV0ZSBpcyBETUFfQVRUUl9XUklURV9C
QVJSSUVSIHdoaWNoIGZvcmNlcyBhbGwgcGVuZGluZyB3cml0ZXMgdG8gY29tcGxldGUgcHJldmVu
dGluZyByYWNlIGIvdyBjb21wbGV0aW9uIG5vdGlmaWNhdGlvbiBhbmQgZGF0YSBETUEuDQpXaWxs
IHVzZSB3cml0ZS1jb21iaW5lZCBtZW1vcnkgYWxsb2NhdGlvbiBmb3IgRE1BIGJ1ZmZlciBpbiBy
ZXZpc2VkIHBhdGNoLi4NCg0KVGhhbmtzDQpzb3dqYW55YQ0KDQo=
