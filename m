Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80C3C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575BD2147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="D9sxIgxA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575BD2147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbeHPWBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:01:02 -0400
Received: from mail-sn1nam01on0061.outbound.protection.outlook.com ([104.47.32.61]:63564
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725749AbeHPWBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaufF1nJoT0DMexYPgSCqRqgf72AAdBenO7TsQva4w0=;
 b=D9sxIgxA0u9kWNk92EpxZ9xSwBFl6AO9B3eMuVxwAp35j9AYnhk/iKkT/D0IXf/ko09AuIX9S3gvs6rPxREarU2oZ2LwtN/tP58SQYiQR1tniyfMNcLeg8yS+YVHwqUTxA0asdet/Luw4SOWbB+34JLFqHnyV8M7+17OrLiBSjw=
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.176.31) by
 BN7PR12MB2660.namprd12.prod.outlook.com (20.176.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.25; Thu, 16 Aug 2018 19:00:45 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::51e6:2f16:498f:8d96]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::51e6:2f16:498f:8d96%4]) with mapi id 15.20.1017.020; Thu, 16 Aug 2018
 19:00:44 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH 1/2] x86/MCE/AMD: Check for NULL banks in THR interrupt
 handler
Thread-Topic: [PATCH 1/2] x86/MCE/AMD: Check for NULL banks in THR interrupt
 handler
Thread-Index: AQHUL+qS6VdgoYLWuEWHUWlxV25aZqS3mKIAgAAh5ZCACwiTEA==
Date:   Thu, 16 Aug 2018 19:00:43 +0000
Message-ID: <BN7PR12MB25930909EFF4F407A528A44FF83E0@BN7PR12MB2593.namprd12.prod.outlook.com>
References: <20180809140834.59264-1-Yazen.Ghannam@amd.com>
 <20180809161548.GA20928@nazgul.tnic>
 <BN7PR12MB259365671F2A73D5FF33C134F8250@BN7PR12MB2593.namprd12.prod.outlook.com>
In-Reply-To: <BN7PR12MB259365671F2A73D5FF33C134F8250@BN7PR12MB2593.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [2601:3c2:8280:2327:a156:973f:d5f1:b585]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR12MB2660;20:MWGNB2ZWUfl3Qvnh/sTu40jXcSBeFTAVAypGtagCjt9t1cwQ8wYRnooto3oygnismOKiEHXyhd0LOF/owHJOdKTfo9kkL9Ob6AZ3NCxIo0H6sqqHjEr0AcxbzQk8wn5MiCE03hyWniZcizYC+ffAUBOIvncF/gn14imeq9UBOG/uaTqW5mRq5bLa++ay28gBy/08G8EtarC9O4qLLi99Uz77KkICf0ieqV0/HT1YCdyZRvV1AIrCFFMohB+ogPIa
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(346002)(396003)(39860400002)(189003)(199004)(13464003)(11346002)(97736004)(476003)(14454004)(8936002)(446003)(2900100001)(256004)(55016002)(81156014)(74316002)(81166006)(229853002)(486006)(72206003)(53546011)(7696005)(7736002)(46003)(305945005)(54906003)(5250100002)(6506007)(86362001)(68736007)(110136005)(53936002)(6246003)(478600001)(5660300001)(76176011)(9686003)(316002)(105586002)(6116002)(25786009)(15650500001)(106356001)(8676002)(6436002)(4326008)(99286004)(2906002)(102836004)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2660;H:BN7PR12MB2593.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 28a5e44e-d79c-4e56-9c5a-08d603aa919f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2660;
x-ms-traffictypediagnostic: BN7PR12MB2660:
x-microsoft-antispam-prvs: <BN7PR12MB266059D08EC3CE33F1D11573F83E0@BN7PR12MB2660.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BN7PR12MB2660;BCL:0;PCL:0;RULEID:;SRVR:BN7PR12MB2660;
x-forefront-prvs: 07665BE9D1
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OUhABPjpVcD7Q0j6QIsjbYObCP20RszGSxB4brOr4rqccLpnoEKv80SWM6IkApSrtrkGEUK3z1WqFJliLNcAYjI4f4BOmAWm8zsQtEQsSma0unu65uUcVydcnfqJHkuLzDIuO1uRIK1znR/k736HiVUGUZyK9oWWWNDuQzpC86H/CEa9F+qJymCpdokA92plKIkZrPx685WKRy7yM2xpNoooVoHVhuniSEqbQZCeoOjRDs8nqnzkizd942hEtSA3OFd92JW6uY85sJ7gQxUamYtC/a3jUy1FyoiCc4K4B2pXAH7LjxzhMQ+TAi210jT32UXohnm3jMZ8PrsIscera3qnA3xqmGFiqwmfgqefrN8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a5e44e-d79c-4e56-9c5a-08d603aa919f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2018 19:00:44.0242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2660
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1lZGFjLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtZWRhYy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+DQo+IE9uIEJl
aGFsZiBPZiBHaGFubmFtLCBZYXplbg0KPiBTZW50OiBUaHVyc2RheSwgQXVndXN0IDksIDIwMTgg
MToxOCBQTQ0KPiBUbzogQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+DQo+IENjOiBsaW51
eC1lZGFjQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4g
dG9ueS5sdWNrQGludGVsLmNvbTsgeDg2QGtlcm5lbC5vcmcNCj4gU3ViamVjdDogUkU6IFtQQVRD
SCAxLzJdIHg4Ni9NQ0UvQU1EOiBDaGVjayBmb3IgTlVMTCBiYW5rcyBpbiBUSFINCj4gaW50ZXJy
dXB0IGhhbmRsZXINCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9t
OiBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT4NCj4gPiBTZW50OiBUaHVyc2RheSwgQXVn
dXN0IDksIDIwMTggMTE6MTYgQU0NCj4gPiBUbzogR2hhbm5hbSwgWWF6ZW4gPFlhemVuLkdoYW5u
YW1AYW1kLmNvbT4NCj4gPiBDYzogbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gdG9ueS5sdWNrQGludGVsLmNvbTsgeDg2QGtlcm5l
bC5vcmcNCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0geDg2L01DRS9BTUQ6IENoZWNrIGZv
ciBOVUxMIGJhbmtzIGluIFRIUg0KPiA+IGludGVycnVwdCBoYW5kbGVyDQo+ID4NCj4gPiBPbiBU
aHUsIEF1ZyAwOSwgMjAxOCBhdCAwOTowODozM0FNIC0wNTAwLCBZYXplbiBHaGFubmFtIHdyb3Rl
Og0KPiA+ID4gRnJvbTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KPiA+
ID4NCj4gPiA+IElmIHRocmVzaG9sZF9pbml0X2RldmljZSgpIGZhaWxzIHRoZW4gcGVyX2NwdSh0
aHJlc2hvbGRfYmFua3MpIHdpbGwgYmUNCj4gPiA+IGRlYWxsb2NhdGVkLiBUaGUgdGhyZXNob2xk
aW5nIGludGVycnVwdCBoYW5kbGVyIHdpbGwgc3RpbGwgYmUgYWN0aXZlLCBzbw0KPiA+DQo+ID4g
U28gZml4IHRoZSBjb2RlIHNvIHRoYXQgKnRoYXQqIGRvZXNuJ3QgaGFwcGVuIGluc3RlYWQgb2Yg
YWRkaW5nIGNoZWNrcw0KPiA+IHRvIHRoZSBpbnRlcnJ1cHQgaGFuZGxlci4NCj4gPg0KPiA+IEku
ZS4sDQo+ID4NCj4gPiAJaWYgKGVycikgew0KPiA+IAkJbWNlX3RocmVzaG9sZF92ZWN0b3IgPSBk
ZWZhdWx0X3RocmVzaG9sZF9pbnRlcnJ1cHQ7DQo+ID4gCQlyZXR1cm4gZXJyOw0KPiA+IAl9DQo+
ID4NCj4gDQo+IE9rYXkuIEknbGwgbWFrZSB0aGF0IGNoYW5nZS4NCj4gDQoNCkkgZG9uJ3QgdGhp
bmsgdGhpcyBpcyBlbm91Z2guIFdlIGhhdmUgYSBnYXAgYmV0d2VlbiB3aGVuIHRoZSBpbnRlcnJ1
cHQNCmhhbmRsZXIgaXMgc2V0IHVwIGR1cmluZyBib290IGluIF9fbWNoZWNrX2NwdV9pbml0X3Zl
bmRvcigpIGFuZCB3aGVuIGFsbA0KdGhlIGRhdGEgc3RydWN0dXJlcyBhcmUgY3JlYXRlZCBkdXJp
bmcgdGhyZXNob2xkX2luaXRfZGV2aWNlKCkuDQoNClNvIEkgdGhpbmsgd2Ugc2hvdWxkIGtlZXAg
dGhlIE5VTEwgcG9pbnRlciBjaGVja3MgZm9yIG5vdyB0byBrZWVwIHRoaXMgZml4DQpzbWFsbC4g
SSBjYW4gbWFrZSBhIG5ldyBwYXRjaCBmb2xsb3dpbmcgeW91ciBzdWdnZXN0aW9uIGFib3ZlLg0K
DQpXZSBjYW4gY2hhbmdlIHRoZSBjb2RlIHNvIHRoYXQgd2UgY3JlYXRlIHRoZSBkYXRhIHN0cnVj
dHVyZXMgZHVyaW5nIHRoZQ0KZWFybGllciBpbml0IHByb2Nlc3MsIGJ1dCBJIHRoaW5rIHRoaXMg
d2lsbCBiZSBhIG11Y2ggYmlnZ2VyIGNoYW5nZS4gVGhpcyBjb3VsZA0KZmFsbCB1bmRlciB0aGUg
aWRlYSBvZiBkZWNvdXBsaW5nIHRoZSBoYW5kbGluZyBjb2RlIGZyb20gc3lzZnMuDQoNClRoYW5r
cywNCllhemVuDQo=
