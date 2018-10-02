Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD18C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98B62083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kOk1Xlqy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C98B62083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbeJBVks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:40:48 -0400
Received: from mail-sn1nam01on0080.outbound.protection.outlook.com ([104.47.32.80]:52480
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726906AbeJBVkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zogacoXR31Ke+wqap2+hAkykppFC/iltThy6PwjCt4A=;
 b=kOk1Xlqyd97ihsAf71pmB0qzJ0QZQigU8IPgRfbUhYzl0UpBOhVoO+uMj+QSTS2DA/86h9ggA675WodqgZMENGAOBJ9qn6O4SxIoH4V/56GgouLFL4EsIGn/ozFknUeFjB57xQttn7Cx16beVqfyB82RmxkvGsRBqt1wqxXG4Yg=
Received: from BN6PR12MB1714.namprd12.prod.outlook.com (10.175.101.11) by
 BN6PR12MB1602.namprd12.prod.outlook.com (10.172.20.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.20; Tue, 2 Oct 2018 14:56:50 +0000
Received: from BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::5826:a5b3:996b:ce05]) by BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::5826:a5b3:996b:ce05%10]) with mapi id 15.20.1185.024; Tue, 2 Oct 2018
 14:56:50 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        David Airlie <airlied@linux.ie>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/scheduler: Simplify spsc_queue_count check in
 drm_sched_entity_select_rq
Thread-Topic: [PATCH] drm/scheduler: Simplify spsc_queue_count check in
 drm_sched_entity_select_rq
Thread-Index: AQHUWhsAWuD8dSDOr0KeWeE7/oXFPKUMDAuA
Date:   Tue, 2 Oct 2018 14:56:49 +0000
Message-ID: <7c5cbc38-f052-7f0f-d13e-6a7ce2ea80ba@amd.com>
References: <20181002064124.25881-1-natechancellor@gmail.com>
In-Reply-To: <20181002064124.25881-1-natechancellor@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
x-originating-ip: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
x-clientproxiedby: HE1PR09CA0048.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::16) To BN6PR12MB1714.namprd12.prod.outlook.com
 (2603:10b6:404:106::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1602;20:vTYLuP6slRMbbrbWJ7pPcAkzEir8wM3tYr0/1M3YWQM3fjCIriwBrNbzvP4h9crzKNdQKCwU9xr9xl1CqFAQqa+LcHg3xfu5yCKV2uzAgxKpSlh2hoLrC9aFH8Zw1/IHRSoFbd2uI2SYOUzkWSfMwaxbTRMwhwRJmwKBgKVrVMv+wHUt0NFWEvZ3/QIQGFfTSI6kf5JLYOP5RAXv7asw+Csp+V7hrTFDnSe/m/8Ulb5SJcYGgxEueqEIZdWrlITn
x-ms-office365-filtering-correlation-id: 71eaba2f-5f9d-43fb-66a5-08d628774808
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1602;
x-ms-traffictypediagnostic: BN6PR12MB1602:
x-microsoft-antispam-prvs: <BN6PR12MB16027D0B78369A164E3B5B8383E80@BN6PR12MB1602.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BN6PR12MB1602;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1602;
x-forefront-prvs: 0813C68E65
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(136003)(366004)(199004)(189003)(72206003)(99286004)(478600001)(65806001)(65956001)(6506007)(386003)(25786009)(6512007)(39060400002)(5660300001)(52116002)(76176011)(7736002)(4326008)(6436002)(68736007)(305945005)(14454004)(53936002)(6246003)(8676002)(446003)(46003)(6486002)(97736004)(316002)(476003)(486006)(2616005)(11346002)(36756003)(6116002)(14444005)(256004)(106356001)(58126008)(65826007)(105586002)(81156014)(81166006)(64126003)(66574008)(5250100002)(8936002)(31686004)(71200400001)(71190400001)(229853002)(86362001)(575784001)(31696002)(186003)(2906002)(110136005)(54906003)(2900100001)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1602;H:BN6PR12MB1714.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: h8co7/v2DLgXxBgiTU1qkI5uxDzoFQjwk33XVudWDZddtFOqVWlQgx7JYbO4RFRl57FXQJphTuZK0fW5g4GGMml83oLzLynOAdYMGUuAYwK/5UtmWIbWxxRWrepznmPqTLreIi6BwXTXdaXl1fpmDiZgvj2K+ptQAXRxn0nc6iXVRVHnWqT30TiYpHrdajGjz2EEI6fWHylMdsA0v/K2JRkh2sJhGOLulOsKSIj/6kHRVkteb3JxRxaf8sVSV2lqasfThHhzlwMvGwejuKKisfG3/IbMg50MB6zOKHfFlPQLLCEEPMhQoFSLFsbk4XT1cytOFFlPuL4KKZm4SzkC+yuYtgCFa3MFycago8b8Zbs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F01DA4B51E94543AB6C034BB33DCFA4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71eaba2f-5f9d-43fb-66a5-08d628774808
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2018 14:56:50.0015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1602
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMDIuMTAuMjAxOCB1bSAwODo0MSBzY2hyaWViIE5hdGhhbiBDaGFuY2VsbG9yOg0KPiBDbGFu
ZyBnZW5lcmF0ZXMgYSB3YXJuaW5nIHdoZW4gaXQgc2VlcyBhIGxvZ2ljYWwgbm90IGZvbGxvd2Vk
IGJ5IGENCj4gY29uZGl0aW9uYWwgb3BlcmF0b3IgbGlrZSA9PSwgPiwgb3IgPC4NCj4NCj4gZHJp
dmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYzo0NzA6Njogd2FybmluZzogbG9n
aWNhbCBub3QgaXMNCj4gb25seSBhcHBsaWVkIHRvIHRoZSBsZWZ0IGhhbmQgc2lkZSBvZiB0aGlz
IGNvbXBhcmlzb24NCj4gWy1XbG9naWNhbC1ub3QtcGFyZW50aGVzZXNdDQo+ICAgICAgICAgIGlm
ICghc3BzY19xdWV1ZV9jb3VudCgmZW50aXR5LT5qb2JfcXVldWUpID09IDAgfHwNCj4gICAgICAg
ICAgICAgIF4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfn4NCj4gZHJpdmVy
cy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYzo0NzA6Njogbm90ZTogYWRkIHBhcmVu
dGhlc2VzDQo+IGFmdGVyIHRoZSAnIScgdG8gZXZhbHVhdGUgdGhlIGNvbXBhcmlzb24gZmlyc3QN
Cj4gICAgICAgICAgaWYgKCFzcHNjX3F1ZXVlX2NvdW50KCZlbnRpdHktPmpvYl9xdWV1ZSkgPT0g
MCB8fA0KPiAgICAgICAgICAgICAgXg0KPiAgICAgICAgICAgICAgICggICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgKQ0KPiBkcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3Nj
aGVkX2VudGl0eS5jOjQ3MDo2OiBub3RlOiBhZGQgcGFyZW50aGVzZXMNCj4gYXJvdW5kIGxlZnQg
aGFuZCBzaWRlIGV4cHJlc3Npb24gdG8gc2lsZW5jZSB0aGlzIHdhcm5pbmcNCj4gICAgICAgICAg
aWYgKCFzcHNjX3F1ZXVlX2NvdW50KCZlbnRpdHktPmpvYl9xdWV1ZSkgPT0gMCB8fA0KPiAgICAg
ICAgICAgICAgXg0KPiAgICAgICAgICAgICAgKCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICkNCj4gMSB3YXJuaW5nIGdlbmVyYXRlZC4NCj4NCj4gSXQgYXNzdW1lcyB0aGUgYXV0
aG9yIG1pZ2h0IGhhdmUgbWFkZSBhIG1pc3Rha2UgaW4gdGhlaXIgbG9naWM6DQo+DQo+IGlmICgh
YSA9PSBiKSAtPiBpZiAoIShhID09IGIpKQ0KPg0KPiBTb21ldGltZXMgdGhhdCBpcyB0aGUgY2Fz
ZTsgb3RoZXIgdGltZXMsIGl0J3MganVzdCBhIHN1cGVyIGNvbnZvbHV0ZWQNCj4gd2F5IG9mIHNh
eWluZyAnaWYgKGEpJyB3aGVuIGIgPSAwOg0KPg0KPiBpZiAoITEgPT0gMCkgLT4gaWYgKDAgPT0g
MCkgLT4gaWYgKHRydWUpDQo+DQo+IEFsdGVybmF0aXZlbHk6DQo+DQo+IGlmICghMSA9PSAwKSAt
PiBpZiAoISExKSAtPiBpZiAoMSkNCj4NCj4gU2ltcGxpZnkgdGhpcyBjb21wYXJpc29uIHNvIHRo
YXQgQ2xhbmcgZG9lc24ndCBjb21wbGFpbi4NCj4NCj4gRml4ZXM6IDM1ZTE2MGU3ODFhMCAoImRy
bS9zY2hlZHVsZXI6IGNoYW5nZSBlbnRpdGllcyBycSBldmVuIGVhcmxpZXIiKQ0KPiBTaWduZWQt
b2ZmLWJ5OiBOYXRoYW4gQ2hhbmNlbGxvciA8bmF0ZWNoYW5jZWxsb3JAZ21haWwuY29tPg0KDQpS
ZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0K
DQpHb2luZyB0byBwaWNrIHRoYXQgdXAgZm9yIHB1c2hpbmcgdXBzdHJlYW0gYXMgd2VsbC4NCg0K
VGhhbmtzLA0KQ2hyaXN0aWFuLg0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9zY2hlZHVs
ZXIvc2NoZWRfZW50aXR5LmMgfCAzICstLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMiBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9z
Y2hlZHVsZXIvc2NoZWRfZW50aXR5LmMgYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVk
X2VudGl0eS5jDQo+IGluZGV4IDRlNWU5NWMwY2FiNS4uM2UyMmE1NGE5OWMyIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jDQo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5LmMNCj4gQEAgLTQ2Nyw4ICs0Njcs
NyBAQCB2b2lkIGRybV9zY2hlZF9lbnRpdHlfc2VsZWN0X3JxKHN0cnVjdCBkcm1fc2NoZWRfZW50
aXR5ICplbnRpdHkpDQo+ICAgCXN0cnVjdCBkbWFfZmVuY2UgKmZlbmNlOw0KPiAgIAlzdHJ1Y3Qg
ZHJtX3NjaGVkX3JxICpycTsNCj4gICANCj4gLQlpZiAoIXNwc2NfcXVldWVfY291bnQoJmVudGl0
eS0+am9iX3F1ZXVlKSA9PSAwIHx8DQo+IC0JICAgIGVudGl0eS0+bnVtX3JxX2xpc3QgPD0gMSkN
Cj4gKwlpZiAoc3BzY19xdWV1ZV9jb3VudCgmZW50aXR5LT5qb2JfcXVldWUpIHx8IGVudGl0eS0+
bnVtX3JxX2xpc3QgPD0gMSkNCj4gICAJCXJldHVybjsNCj4gICANCj4gICAJZmVuY2UgPSBSRUFE
X09OQ0UoZW50aXR5LT5sYXN0X3NjaGVkdWxlZCk7DQoNCg==
