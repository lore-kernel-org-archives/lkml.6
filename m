Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65D9C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 06:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F8F20779
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 06:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WzRQqmTn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F8F20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbeJVPMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 11:12:22 -0400
Received: from mail-by2nam03on0089.outbound.protection.outlook.com ([104.47.42.89]:10469
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726964AbeJVPMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 11:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40zhhrAGW12YoHb2EsqmL0hB1pIJIK7mOmpkY9KZIbA=;
 b=WzRQqmTnPwPEmpyDKiVzOBsNBJmVB/PTT5rJL3rF7Z97I17xdsaaH2y5pU4hHgc4d61wZbxYLqi0DA15UdrCu7ZxhNuYj8X/uqE4wTFp6JnHBRXlgzbcrKO75cifVi7IWJJM2OyR5o8wAWLDDilVVSMPsRmUFsc4kaTOsjEPy8c=
Received: from BN6PR12MB1714.namprd12.prod.outlook.com (10.175.101.11) by
 BN6PR12MB1924.namprd12.prod.outlook.com (10.175.102.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.26; Mon, 22 Oct 2018 06:55:04 +0000
Received: from BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::5472:26e2:affa:2b41]) by BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::5472:26e2:affa:2b41%7]) with mapi id 15.20.1250.028; Mon, 22 Oct 2018
 06:55:04 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Wenwen Wang <wang6495@umn.edu>
CC:     Kangjie Lu <kjlu@umn.edu>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        "Wang, Ken" <Ken.Wang@amd.com>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/amdgpu: fix a missing-check bug
Thread-Topic: [PATCH] drm/amdgpu: fix a missing-check bug
Thread-Index: AQHUaLea8TchUe8FQkSOGnWuMxL3Z6Uq1tqA
Date:   Mon, 22 Oct 2018 06:55:04 +0000
Message-ID: <fbd47fc0-c85c-baad-2e35-83de43d0b405@amd.com>
References: <1540069075-18358-1-git-send-email-wang6495@umn.edu>
In-Reply-To: <1540069075-18358-1-git-send-email-wang6495@umn.edu>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
x-clientproxiedby: AM6P193CA0113.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:85::18) To BN6PR12MB1714.namprd12.prod.outlook.com
 (2603:10b6:404:106::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1924;20:o3CV5nV3hxPZ5GuttG0aLfzyHWcRXD8dppLXIdlgE1tZdbxvrxlqM9ofgVDBRIvmNYJpKNEekzLnY0fT9DqNnTTVwEx2z/qeAqeKz23Dq/eBSE0mGY3ES98JCmu5+qYYdXutfQmaE/fwJQz6XdjgYVo8oybTyojeP/OPa0EPaWbYquw6vc1aE6PkWZF6R0I3/GOVunPKjsHDfwULEuAMLRtZ8EYflvZwG6tR/vfZoMpYbYKK2YVPap/1tbmnkzec
x-ms-office365-filtering-correlation-id: aabf8ad2-9ec0-4748-c460-08d637eb4acf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1924;
x-ms-traffictypediagnostic: BN6PR12MB1924:
x-microsoft-antispam-prvs: <BN6PR12MB1924113ECFC7AD7D7D2F55BD83F40@BN6PR12MB1924.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192374486261705)(8104003914727);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BN6PR12MB1924;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1924;
x-forefront-prvs: 08331F819E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(136003)(366004)(189003)(199004)(305945005)(86362001)(54906003)(446003)(58126008)(106356001)(486006)(64126003)(31696002)(53936002)(316002)(6246003)(2171002)(2900100001)(105586002)(71200400001)(7736002)(81166006)(71190400001)(97736004)(229853002)(6512007)(81156014)(186003)(8676002)(478600001)(46003)(6506007)(14444005)(256004)(76176011)(31686004)(8936002)(6486002)(6116002)(6436002)(386003)(65826007)(14454004)(6916009)(5660300001)(4326008)(2906002)(72206003)(102836004)(68736007)(476003)(2616005)(36756003)(11346002)(99286004)(5250100002)(52116002)(65806001)(25786009)(65956001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1924;H:BN6PR12MB1714.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UvDde1MldI2TuoBHnbXwKx8NqfLPogkhN3O3qlN97PMFbiOlEHxKe4WJah+h6Q0nd7yoCq/uO9mrdI42IqpiB9LXyMBQjG5tpvFVaeRWUxnX/v7IWrpBiTEpUEzB9h2NHpS/bk5G7b0ajyIueX6IVtgispACVjarDOhG0BH9nzwEgH/GHTP3QNLdC0bhFn8jqKL6FXzAjxNLCSTBV8bog1IiNSZ9iZJ25vF9UUBMHUEazUuAaNo5lF8RAEOk3fli+X+6r/sUNu8Ot4Iwh7bn5Un8O8a05cTzM1d2Y34A3XQgjyPpAYkg69VBc2oWNMbc5o2rv804XIod+xiszOMibEEsV+H/QgaxwcQoy6nOjwc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0EC1D905CD0D94B83B9CB2285F6BCFD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aabf8ad2-9ec0-4748-c460-08d637eb4acf
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2018 06:55:04.0851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1924
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMjAuMTAuMTggdW0gMjI6NTcgc2NocmllYiBXZW53ZW4gV2FuZzoNCj4gSW4gYW1kZ3B1X3Jl
YWRfYmlvc19mcm9tX3JvbSgpLCB0aGUgaGVhZGVyIG9mIHRoZSBWQklPUyBpcyBmaXJzdGx5IGNv
cGllZA0KPiB0byAnaGVhZGVyJyBmcm9tIGFuIElPIG1lbW9yeSByZWdpb24gdGhyb3VnaA0KPiBh
bWRncHVfYXNpY19yZWFkX2Jpb3NfZnJvbV9yb20oKS4gVGhlbiB0aGUgaGVhZGVyIGlzIGNoZWNr
ZWQgdG8gc2VlIHdoZXRoZXINCj4gaXQgaXMgYSB2YWxpZCBoZWFkZXIuIElmIHllcywgdGhlIHdo
b2xlIFZCSU9TLCBpbmNsdWRpbmcgdGhlIGhlYWRlciwgaXMNCj4gdGhlbiBjb3BpZWQgdG8gJ2Fk
ZXYtPmJpb3MnLiBUaGUgcHJvYmxlbSBoZXJlIGlzIHRoYXQgbm8gY2hlY2sgaXMgZW5mb3JjZWQN
Cj4gb24gdGhlIGhlYWRlciBhZnRlciB0aGUgc2Vjb25kIGNvcHkuIEdpdmVuIHRoYXQgdGhlIGRl
dmljZSBhbHNvIGhhcyB0aGUNCj4gcGVybWlzc2lvbiB0byBhY2Nlc3MgdGhlIElPIG1lbW9yeSBy
ZWdpb24sIGl0IGlzIHBvc3NpYmxlIGZvciBhIG1hbGljaW91cw0KPiBkZXZpY2UgY29udHJvbGxl
ZCBieSBhbiBhdHRhY2tlciB0byBtb2RpZnkgdGhlIGhlYWRlciBiZXR3ZWVuIHRoZXNlIHR3bw0K
PiBjb3BpZXMuIEJ5IGRvaW5nIHNvLCB0aGUgYXR0YWNrZXIgY2FuIHN1cHBseSBjb21wcm9taXNl
ZCBWQklPUywgd2hpY2ggY2FuDQo+IGNhdXNlIHVuZGVmaW5lZCBiZWhhdmlvciBvZiB0aGUga2Vy
bmVsIGFuZCBpbnRyb2R1Y2UgcG90ZW50aWFsIHNlY3VyaXR5DQo+IGlzc3Vlcy4NCj4NCj4gVGhp
cyBwYXRjaCByZXdyaXRlcyB0aGUgaGVhZGVyIGluICdhZGV2LT5iaW9zJyB1c2luZyB0aGUgaGVh
ZGVyIGFjcXVpcmVkIGluDQo+IHRoZSBmaXJzdCBjb3B5Lg0KDQpBcyBhbHJlYWR5IGFuc3dlcmVk
IHByZXZpb3VzbHkgdGhpcyBpcyBjb21wbGV0ZWx5IHN1cGVyZmx1b3VzLg0KDQpXZSBhcmUgbm90
IG1hcHBpbmcgVlJBTSBoZXJlLCBidXQgYSBmbGFzaCBST00gKFJlYWQgT25seSBNZW1vcnkpLiBU
aGUgDQpmbGFzaCByb20gaXMgbm90IGNoYW5nZWFibGUgdGhyb3VnaCB0aGUgbWFwcGluZy4NCg0K
QWRkaXRpb25hbCB0byB0aGF0IHRoZSBsZW5ndGggY2hlY2sgaXMganVzdCB0byBjb25maXJtIHRo
YXQgdGhlIHJvbSBpcyANCmNvcnJlY3RseSBtYXBwZWQsIGl0IGRvZXNuJ3QgdmFsaWRhdGUgdGhl
IHJvbSBpbiBhbnkgd2F5Lg0KDQpSZWdhcmRzLA0KQ2hyaXN0aWFuLg0KDQo+DQo+IFNpZ25lZC1v
ZmYtYnk6IFdlbndlbiBXYW5nIDx3YW5nNjQ5NUB1bW4uZWR1Pg0KPiAtLS0NCj4gICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYmlvcy5jIHwgMiArKw0KPiAgIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9iaW9zLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfYmlvcy5jDQo+IGluZGV4IGE1ZGY4MGQuLmFjNzAxZjQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9iaW9zLmMNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Jpb3MuYw0KPiBAQCAtMTgxLDYgKzE4MSw4IEBAIHN0YXRp
YyBib29sIGFtZGdwdV9yZWFkX2Jpb3NfZnJvbV9yb20oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpDQo+ICAgCS8qIHJlYWQgY29tcGxldGUgQklPUyAqLw0KPiAgIAlhbWRncHVfYXNpY19yZWFk
X2Jpb3NfZnJvbV9yb20oYWRldiwgYWRldi0+YmlvcywgbGVuKTsNCj4gICANCj4gKwltZW1jcHko
YWRldi0+YmlvcywgaGVhZGVyLCBBTURfVkJJT1NfU0lHTkFUVVJFX0VORCk7DQo+ICsNCj4gICAJ
aWYgKCFjaGVja19hdG9tX2Jpb3MoYWRldi0+YmlvcywgbGVuKSkgew0KPiAgIAkJa2ZyZWUoYWRl
di0+Ymlvcyk7DQo+ICAgCQlyZXR1cm4gZmFsc2U7DQoNCg==
