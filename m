Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7507CC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E0820652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XGCgP17w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28E0820652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbeJWCLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 22:11:15 -0400
Received: from mail-eopbgr700067.outbound.protection.outlook.com ([40.107.70.67]:35023
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727590AbeJWCLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 22:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wbl/48yzg2Yfn/eTUxBsivajcIrGhn9TASx/PtMek4w=;
 b=XGCgP17wvh+/GDkz68x9yXthKyNgqLXWEBPskYBQYbp/5Ee+AKR5Za2k/7knVaVisr6fyLdmQt0Z5/lafMIkdGtQ5LuHn175z3M8Us83x9agt0Odykf+j6Vmj5TX3Kc93iOI2k47JybRzDd44/1vjC/9XgFBYylisaGv7GAaELU=
Received: from DM5PR12MB1707.namprd12.prod.outlook.com (10.175.89.136) by
 DM5PR12MB1865.namprd12.prod.outlook.com (10.175.87.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.29; Mon, 22 Oct 2018 17:51:42 +0000
Received: from DM5PR12MB1707.namprd12.prod.outlook.com
 ([fe80::74d5:db9a:60e2:2f7f]) by DM5PR12MB1707.namprd12.prod.outlook.com
 ([fe80::74d5:db9a:60e2:2f7f%8]) with mapi id 15.20.1250.028; Mon, 22 Oct 2018
 17:51:41 +0000
From:   "Kuehling, Felix" <Felix.Kuehling@amd.com>
To:     Wenwen Wang <wang6495@umn.edu>
CC:     "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>, Kangjie Lu <kjlu@umn.edu>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Wang, Ken" <Ken.Wang@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix a missing-check bug
Thread-Topic: [PATCH] drm/amdgpu: fix a missing-check bug
Thread-Index: AQHUabfA9wOrq74Mw0m1PEpMMi4Ut6UrjFSA
Date:   Mon, 22 Oct 2018 17:51:41 +0000
Message-ID: <f9913234-f9d7-1a99-3064-500d9daf6e16@amd.com>
References: <1540069075-18358-1-git-send-email-wang6495@umn.edu>
In-Reply-To: <1540069075-18358-1-git-send-email-wang6495@umn.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-clientproxiedby: YQXPR0101CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::47) To DM5PR12MB1707.namprd12.prod.outlook.com
 (2603:10b6:3:10f::8)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1865;20:uR2K4U2KPBRM99Go8SiIh+epbD+zlX2oHZBRu/YJJtv2Ctsomw7b7u/EDDV+ThsRbq3oTHwVeVgcPW88k9EIKoFopEPbELgsrZhq6JupOaHlNREF6rVOR4VIkoeWMTtE0y9EZIebonQXoeoeRclxHturtHcAtHRNgMu4H2xJFt57va17rwujrj/NCUUP6b8m8vbpITrdVqjytetrIdWp6z2KNyMUxK/z/YoMmNE3+x/2kPuBq1yaS2i8hRp2MhFy
x-ms-office365-filtering-correlation-id: f0cfd716-a4c7-456c-0730-08d6384705f5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1865;
x-ms-traffictypediagnostic: DM5PR12MB1865:
x-microsoft-antispam-prvs: <DM5PR12MB1865240DEB6129E50F665E9892F40@DM5PR12MB1865.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192374486261705)(8104003914727);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1865;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1865;
x-forefront-prvs: 08331F819E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(346002)(396003)(136003)(189003)(199004)(31686004)(36756003)(8936002)(14454004)(81156014)(25786009)(2616005)(11346002)(446003)(64126003)(65826007)(476003)(106356001)(97736004)(486006)(6246003)(26005)(2900100001)(6916009)(72206003)(4326008)(2906002)(316002)(54906003)(58126008)(6512007)(6346003)(7736002)(53936002)(86362001)(186003)(102836004)(478600001)(99286004)(229853002)(2171002)(105586002)(6506007)(53546011)(305945005)(6486002)(52116002)(76176011)(6436002)(71200400001)(5250100002)(8676002)(68736007)(71190400001)(65956001)(386003)(66066001)(65806001)(31696002)(14444005)(6116002)(81166006)(256004)(3846002)(5660300001)(4001150100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1865;H:DM5PR12MB1707.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
x-microsoft-antispam-message-info: wV9sZRuKnNYXjCZE1WDlsbTYhz+/K5S3jZRFMNVjqfbCe6MUrzuE+zVVe/v+bX6+BBCSZwpoES56mDt1y4shYDJgHXqHspQ1FZYlZgz6gODA2FeenASuVmGaubw6Rp014srd2VbMHNVRNB7VbPQha2ma7hxRrVK7/xykJ6V8OYVvcmq1QAESCe2ygIMLlvzXw6v6AW5EvBPOSvoQGitOpERXut386OadASbU6tweK9/+s4wUCdQsrDqIoW243Y/Ta/Kw9lisG1odhroh9tcRgQueEWI9OQCvWr42mBisczHvDSSszOPTNPWMqK6pKDULJW4p/bMa+tq5PFl79wFPTGDRedmyLghuABFz/L/w8Oc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4FB05575003F94F9D86CCA1F7AB5B1F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0cfd716-a4c7-456c-0730-08d6384705f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2018 17:51:41.8281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1865
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIEJJT1Mgc2lnbmF0dXJlIGNoZWNrIGRvZXMgbm90IGd1YXJhbnRlZSBpbnRlZ3JpdHkgb2Yg
dGhlIEJJT1MgaW1hZ2UNCmVpdGhlciB3YXkuIEFzIEkgdW5kZXJzdGFuZCBpdCwgdGhlIHNpZ25h
dHVyZSBpcyBqdXN0IGEgbWFnaWMgbnVtYmVyLg0KSXQncyBub3QgYSBjcnlwdG9ncmFwaGljIHNp
Z25hdHVyZS4gVGhlIGNoZWNrIGlzIGp1c3QgYSBzYW5pdHkgY2hlY2suDQpUaGVyZWZvcmUgdGhp
cyBjaGFuZ2UgZG9lc24ndCBhZGQgYW55IG1lYW5pbmdmdWwgcHJvdGVjdGlvbiBhZ2FpbnN0IHRo
ZQ0Kc2NlbmFyaW8geW91IGRlc2NyaWJlZC4NCg0KUmVnYXJkcywNCsKgIEZlbGl4DQoNCk9uIDIw
MTgtMTAtMjAgNDo1NyBwLm0uLCBXZW53ZW4gV2FuZyB3cm90ZToNCj4gSW4gYW1kZ3B1X3JlYWRf
Ymlvc19mcm9tX3JvbSgpLCB0aGUgaGVhZGVyIG9mIHRoZSBWQklPUyBpcyBmaXJzdGx5IGNvcGll
ZA0KPiB0byAnaGVhZGVyJyBmcm9tIGFuIElPIG1lbW9yeSByZWdpb24gdGhyb3VnaA0KPiBhbWRn
cHVfYXNpY19yZWFkX2Jpb3NfZnJvbV9yb20oKS4gVGhlbiB0aGUgaGVhZGVyIGlzIGNoZWNrZWQg
dG8gc2VlIHdoZXRoZXINCj4gaXQgaXMgYSB2YWxpZCBoZWFkZXIuIElmIHllcywgdGhlIHdob2xl
IFZCSU9TLCBpbmNsdWRpbmcgdGhlIGhlYWRlciwgaXMNCj4gdGhlbiBjb3BpZWQgdG8gJ2FkZXYt
PmJpb3MnLiBUaGUgcHJvYmxlbSBoZXJlIGlzIHRoYXQgbm8gY2hlY2sgaXMgZW5mb3JjZWQNCj4g
b24gdGhlIGhlYWRlciBhZnRlciB0aGUgc2Vjb25kIGNvcHkuIEdpdmVuIHRoYXQgdGhlIGRldmlj
ZSBhbHNvIGhhcyB0aGUNCj4gcGVybWlzc2lvbiB0byBhY2Nlc3MgdGhlIElPIG1lbW9yeSByZWdp
b24sIGl0IGlzIHBvc3NpYmxlIGZvciBhIG1hbGljaW91cw0KPiBkZXZpY2UgY29udHJvbGxlZCBi
eSBhbiBhdHRhY2tlciB0byBtb2RpZnkgdGhlIGhlYWRlciBiZXR3ZWVuIHRoZXNlIHR3bw0KPiBj
b3BpZXMuIEJ5IGRvaW5nIHNvLCB0aGUgYXR0YWNrZXIgY2FuIHN1cHBseSBjb21wcm9taXNlZCBW
QklPUywgd2hpY2ggY2FuDQo+IGNhdXNlIHVuZGVmaW5lZCBiZWhhdmlvciBvZiB0aGUga2VybmVs
IGFuZCBpbnRyb2R1Y2UgcG90ZW50aWFsIHNlY3VyaXR5DQo+IGlzc3Vlcy4NCj4NCj4gVGhpcyBw
YXRjaCByZXdyaXRlcyB0aGUgaGVhZGVyIGluICdhZGV2LT5iaW9zJyB1c2luZyB0aGUgaGVhZGVy
IGFjcXVpcmVkIGluDQo+IHRoZSBmaXJzdCBjb3B5Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBXZW53
ZW4gV2FuZyA8d2FuZzY0OTVAdW1uLmVkdT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfYmlvcy5jIHwgMiArKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2Jpb3MuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9iaW9zLmMNCj4g
aW5kZXggYTVkZjgwZC4uYWM3MDFmNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2Jpb3MuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfYmlvcy5jDQo+IEBAIC0xODEsNiArMTgxLDggQEAgc3RhdGljIGJvb2wgYW1kZ3B1
X3JlYWRfYmlvc19mcm9tX3JvbShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gIAkvKiBy
ZWFkIGNvbXBsZXRlIEJJT1MgKi8NCj4gIAlhbWRncHVfYXNpY19yZWFkX2Jpb3NfZnJvbV9yb20o
YWRldiwgYWRldi0+YmlvcywgbGVuKTsNCj4gIA0KPiArCW1lbWNweShhZGV2LT5iaW9zLCBoZWFk
ZXIsIEFNRF9WQklPU19TSUdOQVRVUkVfRU5EKTsNCj4gKw0KPiAgCWlmICghY2hlY2tfYXRvbV9i
aW9zKGFkZXYtPmJpb3MsIGxlbikpIHsNCj4gIAkJa2ZyZWUoYWRldi0+Ymlvcyk7DQo+ICAJCXJl
dHVybiBmYWxzZTsNCg==
