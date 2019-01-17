Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C93C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08DC220657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pgsCfH9p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbfAQGGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 01:06:10 -0500
Received: from mail-eopbgr770089.outbound.protection.outlook.com ([40.107.77.89]:2308
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725902AbfAQGGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 01:06:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMx8+waEPvb4w5rxyt1ONuO5NBnO4o590IrYRePWjpc=;
 b=pgsCfH9pgm13tthX8lRhyQw2M+WknwjHs5Rkngbs6Q+gneiVot0Yq5P3fEqHJPysanDQsc80BW2brbT8czXLGEERRsmQIUrX6sGzOCt+03tw70EZZOMwnS2cFU24tkay4IYtMPULL/2KS1qXxqhyMLFGpRP1US+bXTWGinPeeiY=
Received: from BYAPR12MB3237.namprd12.prod.outlook.com (20.179.93.25) by
 BYAPR12MB3624.namprd12.prod.outlook.com (20.178.54.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Thu, 17 Jan 2019 06:06:06 +0000
Received: from BYAPR12MB3237.namprd12.prod.outlook.com
 ([fe80::a96e:ffd:3bd6:c5f5]) by BYAPR12MB3237.namprd12.prod.outlook.com
 ([fe80::a96e:ffd:3bd6:c5f5%4]) with mapi id 15.20.1537.018; Thu, 17 Jan 2019
 06:06:06 +0000
From:   S@vger.kernel.org
To:     Borislav Petkov <bp@alien8.de>, "S, Shirish" <Shirish.S@amd.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "maintainer : X86 ARCHITECTURE" <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "open list : X86 ARCHITECTURE" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/mce/amd: carve out MC4_MISC thresholding quirk
Thread-Topic: [PATCH 2/2] x86/mce/amd: carve out MC4_MISC thresholding quirk
Thread-Index: AQHUra2kVnXd3Qf5EkWPkkmzdXhRRKWyRv8AgAC2vAA=
Date:   Thu, 17 Jan 2019 06:06:06 +0000
Message-ID: <e65fd961-529e-d479-a269-10267596ec86@amd.com>
References: <1547651417-23583-1-git-send-email-shirish.s@amd.com>
 <1547651417-23583-3-git-send-email-shirish.s@amd.com>
 <20190116192502.GJ15409@zn.tnic>
In-Reply-To: <20190116192502.GJ15409@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0005.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::15) To BYAPR12MB3237.namprd12.prod.outlook.com
 (2603:10b6:a03:136::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Shirish.S@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [202.56.249.162]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3624;20:SiKrWn5ZvTT0gGYBXbpXivqYdz3cIXLaY6IBGOgz1fmXHFlXiVINDSCV4wxuSvQEs9IKc3or32PN2c4Ikfc/NruGqlCbyECj3Y1NA1B1v5IUE07wnyAzMnGma0CUj1X0rvBIm82I08uGL7+T8nvIj8rEaQKzqM2uhtWtCMXrmSeCUYcby/R2ya/uI5ldPVQZrKuPHjsSREWw3VUUxaAPlI/9FfGmVM9kmB2LbGl43USLD2AlEdFWW21YphXy/BEt
x-ms-office365-filtering-correlation-id: f937d527-3e68-4984-a35f-08d67c41de18
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3624;
x-ms-traffictypediagnostic: BYAPR12MB3624:
x-microsoft-antispam-prvs: <BYAPR12MB362453BD67F538ED50169572F2830@BYAPR12MB3624.namprd12.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(376002)(346002)(366004)(51914003)(199004)(189003)(54534003)(53546011)(316002)(386003)(6506007)(99286004)(110136005)(54906003)(66066001)(26005)(6246003)(81166006)(186003)(81156014)(102836004)(7736002)(8936002)(97736004)(347745004)(3846002)(68736007)(8676002)(53936002)(6116002)(52116002)(478600001)(76176011)(14454004)(72206003)(966005)(36756003)(305945005)(4326008)(476003)(25786009)(11346002)(256004)(6486002)(446003)(229853002)(71200400001)(71190400001)(486006)(106356001)(105586002)(31686004)(2616005)(6436002)(6306002)(6636002)(6512007)(5660300001)(2906002)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3624;H:BYAPR12MB3237.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5bb51HCJ+XbaCjk7pnpTWUTztOOiFIl+H0oSKfoznKxXdr60U6HBP2VIk6r2pY2EY/LvBkTq0eERU6JUQROJM1Qk5cD5HqVAQ17xdU6+EA+mGUMlp2dYVllRyUaE9JyJBGxfHm6AK3QtWXfETIYvgMvJdrUFC9e3AX6pJhGHH+asolxM/g4FRHv6XKrCd9pYBDXSjjtd5SXi3AtK6AM56SvjYpHJ8cQmoAjFU679DG34XLvi6frrSiWGC25fxQHak4U3r0241qlS6vnSs24W+YaHcO4UqylX/ddtZFO7xheD1KAnRIPsyhMDYNGv/MufCmQ4cd/y3Qrajl2VRoOnZ0igBG4fEgX22Eia2NxINZOJOslupf/j7Mc2gZcYGn1NgJnryUP69DYMdqgZKRsMTjh/t7M3SmzkC2Rx5MxF/n8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4F600553BB07D40A8AC7A0C968DDC2B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f937d527-3e68-4984-a35f-08d67c41de18
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 06:06:02.7465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3624
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxLzE3LzIwMTkgMTI6NTUgQU0sIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gV2Vk
LCBKYW4gMTYsIDIwMTkgYXQgMDM6MTA6NDBQTSArMDAwMCwgUywgU2hpcmlzaCB3cm90ZToNCj4+
IE1DNF9NSVNDIHRocmVzaG9sZGluZyBxdWlyayBuZWVkcyB0byBiZSBhcHBsaWVkIGR1cmluZyBT
NSAtPiBTMCBhbmQNCj4+IFMzIC0+IFMwIHN0YXRlIHRyYW5zaXRpb25zLCB3aGljaCBmb2xsb3cg
ZGlmZmVyZW50IGNvZGUgcGF0aHMsIGhlbmNlDQo+PiBjYXJ2ZSBpdCBvdXQgYW5kIG1vdmUgaXQg
bWNlX2FtZF9mZWF0dXJlX2luaXQoKSwgd2hpY2ggaXMgIHRoZSBjb252ZXJnaW5nDQo+PiBwb2lu
dCBvZiBib3RoIGNvZGUgcGF0aHMuDQo+Pg0KPj4gQ2hhbmdlbG9nW3YyXToNCj4+ICAgLSBtb3Zl
IHRoZSBxdWlyayB0byBtY2UvYW1kLmMNCj4gRm9yIGZ1dHVyZSByZWZlcmVuY2U6IGNoYW5nZWxv
ZyBsaW5lcyAuLi4NCj4NCj4+IFNpZ25lZC1vZmYtYnk6IFNoaXJpc2ggUyA8c2hpcmlzaC5zQGFt
ZC5jb20+DQo+PiAtLS0NCj4gLi4uIGxhbmQgYmVsb3cgdGhpcyBsaW5lIHNvIHRoYXQgdGhleSBh
cmUgbm90IHBhcnQgb2YgdGhlIGNvbW1pdA0KPiBtZXNzYWdlLg0KVW5kZXJzdG9vZC4NCj4+ICAg
YXJjaC94ODYva2VybmVsL2NwdS9tY2UvYW1kLmMgIHwgMzQgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPj4gICBhcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9jb3JlLmMgfCAyOSAt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDM0IGlu
c2VydGlvbnMoKyksIDI5IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4
Ni9rZXJuZWwvY3B1L21jZS9hbWQuYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2FtZC5jDQo+
PiBpbmRleCA4OTI5OGM4Li5mNmE1Yzk2IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94ODYva2VybmVs
L2NwdS9tY2UvYW1kLmMNCj4+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2FtZC5jDQo+
PiBAQCAtNTQ1LDYgKzU0NSwzMyBAQCBwcmVwYXJlX3RocmVzaG9sZF9ibG9jayh1bnNpZ25lZCBp
bnQgYmFuaywgdW5zaWduZWQgaW50IGJsb2NrLCB1MzIgYWRkciwNCj4+ICAgCXJldHVybiBvZmZz
ZXQ7DQo+PiAgIH0NCj4+ICAgDQo+PiArdm9pZCBtYzRfbWlzY190aHJlc2hvbGRpbmdfcXVpcmso
dm9pZCkNCj4gRnVuY3Rpb25zIHNob3VsZCBoYXZlIGEgdmVyYiBpbiB0aGVpciBuYW1lcy4NCj4N
Cj4gSSd2ZSBmaXhlZCB0aG9zZSBhbmQgb3RoZXIgaXNzdWVzIG5vdyBidXQgbWFrZSBzdXJlIHlv
dSB0YWtlIGEgbG9vayBhdA0KPiB0aG9zZSBuaWNlIGRvY3VtZW50cyBoZXJlLCBmb3IgZnV0dXJl
IHJlZmVyZW5jZSwgd2hlbiBwcmVwYXJpbmcgb3RoZXINCj4gcGF0Y2hlczoNCj4NCj4gaHR0cHM6
Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvcHJvY2Vzcy9pbmRleC5odG1sDQoNClRo
YW5rcyBmb3IgdGhlIHN1cHBvcnQsIGkgc2hhbGwgZm9sbG93IHRoZSBwcmFjdGljZSBmcm9tIG5l
eHQgcGF0Y2ggb253YXJkcy4NCg0KUmVnYXJkcywNCg0KU2hpcmlzaCBTDQoNCj4gVGh4Lg0KPg0K
LS0gDQpSZWdhcmRzLA0KU2hpcmlzaCBTDQoNCg==
