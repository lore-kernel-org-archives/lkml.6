Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B007BC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63FD420867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yWKJapU4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63FD420867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbeLACSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:18:33 -0500
Received: from mail-eopbgr710043.outbound.protection.outlook.com ([40.107.71.43]:45696
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726616AbeLACSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:18:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iB+Wf08sTW38YAZyMs9rCSXTOoe8cJhbopg569ifrQo=;
 b=yWKJapU4blskLKSxwRfZUmCcLd0C1RG6Q9TvvTjU5R0deCMdTHhn/qLEYyJjfrABSSHHlpfHxNo4NrCjf8Kf001k0fmZX6yJ7wKpknF1wafHaAW+yVvSr/hM/VlunRyhCyY0OI6RCCVqi5rmiIUPTGMtkHnGjjEDG4Jgj2iaEGY=
Received: from MWHPR1201MB0061.namprd12.prod.outlook.com (10.174.98.12) by
 MWHPR1201MB0064.namprd12.prod.outlook.com (10.174.98.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.21; Fri, 30 Nov 2018 15:08:52 +0000
Received: from MWHPR1201MB0061.namprd12.prod.outlook.com
 ([fe80::4481:91d7:9564:e869]) by MWHPR1201MB0061.namprd12.prod.outlook.com
 ([fe80::4481:91d7:9564:e869%9]) with mapi id 15.20.1361.019; Fri, 30 Nov 2018
 15:08:52 +0000
From:   "StDenis, Tom" <Tom.StDenis@amd.com>
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "luto@kernel.org" <luto@kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] x86/mm/cpa: Fix cpa-array TLB invalidation
Thread-Topic: [PATCH 0/4] x86/mm/cpa: Fix cpa-array TLB invalidation
Thread-Index: AQHUiLXipdRkoql6EkWifNhS5aJus6VoZy0AgAADw1yAAADTgA==
Date:   Fri, 30 Nov 2018 15:08:51 +0000
Message-ID: <811e7759-40ab-a351-c538-c2b7bde49fd1@amd.com>
References: <20181130134455.490139778@infradead.org>
 <d1e4cb48-1952-fb61-bd2b-db9efe3b5f1a@amd.com>
 <BN6PR12MB180942F2C841FD138A046569F7D30@BN6PR12MB1809.namprd12.prod.outlook.com>
In-Reply-To: <BN6PR12MB180942F2C841FD138A046569F7D30@BN6PR12MB1809.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::16) To MWHPR1201MB0061.namprd12.prod.outlook.com
 (2603:10b6:301:54::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tom.StDenis@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR1201MB0064;20:7iLshTGh4Fq9q7wuThW6YnYxh7ENbd2fWWRD9RrvqTlZwcWgqVnTxbrG8Q2dTPbTzR9NkXDLy3fu2xnG8kiA8WqWOsNv1emmMEOYBjxpUHK5gDVo4u1ChNeW/gfK+/2ifo8/QLAhXFV84ZfWwPXf0vgZ9uuexMQG1bf7oms0q9fiDxqTO9kHgSIDzLaV1JGhqZh3nGo++xopogrb7bQ+WVtFOpxuqZw+NFgoOrBmu9fcmRBHEHPuWsGiWAB0FyG3
x-ms-office365-filtering-correlation-id: 2b5ac4cb-49b3-4d25-e60b-08d656d5bcd0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR1201MB0064;
x-ms-traffictypediagnostic: MWHPR1201MB0064:
x-microsoft-antispam-prvs: <MWHPR1201MB00641CC7199169B4925BBC96F7D30@MWHPR1201MB0064.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231453)(999002)(944501410)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR1201MB0064;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1201MB0064;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(366004)(39850400004)(346002)(189003)(199004)(99286004)(31686004)(25786009)(105586002)(305945005)(7736002)(106356001)(6486002)(6246003)(66066001)(229853002)(72206003)(316002)(54906003)(478600001)(110136005)(5660300001)(11346002)(2616005)(186003)(446003)(2501003)(52116002)(486006)(386003)(76176011)(6506007)(4326008)(2906002)(86362001)(68736007)(26005)(53546011)(6512007)(71190400001)(97736004)(14454004)(6436002)(8676002)(71200400001)(2201001)(8936002)(31696002)(256004)(36756003)(14444005)(476003)(81166006)(4001150100001)(81156014)(3846002)(6116002)(102836004)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB0064;H:MWHPR1201MB0061.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5Qr8Y92Rz1LCeQUGYc/4UQDSsr/c4YFI4Eiowesx5C9MuAkqmJQjuPSecZXDD9xFgUQLiY7mDCRpx4hm7BVK92mNXzRJeuHHUVSyNOBHltaqUfl63QQjyVj4Oo2rXXugGJUMDkXKf3e5A10HFgk2oEPrS0g06BI5G2BU6XjRdJ+7M0GP0Q1WXDT2XNsu5NG47gWrO5d1x0CnnHwn6rMkFKUW6S5aRlKW0K5BGvJOvNRqkiWZNX+tGLxL8DWmAjzEUg3pNIc2RKZSemxddCQrtrZe+PEcBpAjftjG/v87ay+P24K/I+xZXLpmrskJgfqVcTPOmQ88zL0PlynZyeyhxoWXuKWpf/9PxAiM8wsstuE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF0BDF813A045645A18457FFB20A5656@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b5ac4cb-49b3-4d25-e60b-08d656d5bcd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 15:08:51.9687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOC0xMS0zMCAxMDowNyBhLm0uLCBEZXVjaGVyLCBBbGV4YW5kZXIgd3JvdGU6DQo+IFN1
cmUsIGJ1dCBpdCBtaWdodCBiZSB3ZWVrIG9yIHNvLiDCoEZvciBub3cgY2FuIHlvdSB0ZXN0IGFn
YWluc3QgTGludXMgDQo+IG1hc3Rlcj/CoCBJdCBzaG91bGQgYmUgY2xvc2UgZW5vdWdoLg0KDQpJ
IG5lZWQgdGhlIGJ1bGsgbW92ZSBmcm9tIHRoZSBvdXIgZHJtLW5leHQgbWVyZ2UgKHdoaWNoIGlz
bid0IHlldCANCnVwc3RyZWFtKSB0byB0cmlnZ2VyIHRoZSBidWcgdGhvdWdoLg0KDQpJIGNhbiB0
cnkgdG8gY2hlcnJ5IHBpY2sgaXQgb24gdG9wIG9mIG1hc3Rlci4NCg0KVG9tDQoNCj4gDQo+IA0K
PiBBbGV4DQo+IA0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gKkZyb206KiBTdERlbmlzLCBUb20NCj4g
KlNlbnQ6KiBGcmlkYXksIE5vdmVtYmVyIDMwLCAyMDE4IDk6NTI6MjYgQU0NCj4gKlRvOiogUGV0
ZXIgWmlqbHN0cmE7IGRhdmUuaGFuc2VuQGludGVsLmNvbTsgbHV0b0BrZXJuZWwub3JnDQo+ICpD
YzoqIHg4NkBrZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBEZXVjaGVy
LCBBbGV4YW5kZXINCj4gKlN1YmplY3Q6KiBSZTogW1BBVENIIDAvNF0geDg2L21tL2NwYTogRml4
IGNwYS1hcnJheSBUTEIgaW52YWxpZGF0aW9uDQo+IEhpIFBldGVyLA0KPiANCj4gVW5mb3J0dW5h
dGVseSBJIGNhbid0IGFwcGx5IHRoaXMgb24gdG9wIG9mIG91ciBkcm0tbmV4dCB0aGUgZmlyc3Qg
cGF0Y2gNCj4gZmFpbHMuDQo+IA0KPiBBbGV4OiBjb3VsZCB3ZSByZWJhc2UgYWdhaW4gYXQgc29t
ZSBwb2ludD8NCj4gDQo+IFRvbQ0KPiANCj4gT24gMjAxOC0xMS0zMCA4OjQ0IGEubS4sIFBldGVy
IFppamxzdHJhIHdyb3RlOg0KPj4gSGksDQo+PiANCj4+IFllc3RlcmRheSBUb20gcmVwb3J0ZWQg
YSBDUEEgYnVnIHRyaWdnZXJlZCBieSB0aGUgQU1ER1BVIHRlYW0uDQo+PiANCj4+IEl0IHR1cm5z
IG91dCB0aGF0IHdpdGggY29tbWl0Og0KPj4gDQo+PsKgwqDCoCBhNzI5NWZkNTNjMzkgKCJ4ODYv
bW0vY3BhOiBVc2UgZmx1c2hfdGxiX2tlcm5lbF9yYW5nZSgpIikNCj4+IA0KPj4gSSBtaXNyZWFk
IHRoZSBjcGEgYXJyYXkgY29kZSBhbmQgbWVzc2VkIHVwIHRoZSBUTEIgaW52YWxpZGF0aW9ucyBm
b3IgaXQuIFRoZXNlDQo+PiBwYXRjaGVzIChob3BlZnVsbHkpIGZpeCB0aGUgaXNzdWUgd2hpbGUg
YWxzbyBzaHJpbmtpbmcgdGhlIENQQSBjb2RlIGFnYWluLg0KPj4gDQo+PiBUb20sIHdvdWxkIHlv
dSBiZSBzbyBraW5kIGFzIHRvIHRlc3QgYWdhaW4/IFRoZXNlIHBhdGNoZXMgYXJlIHNpZ25pZmlj
YW50bHkNCj4+IGRpZmZlcmVudCBmcm9tIHdoYXQgSSBzZW5kIHlvdSB5ZXN0ZXJkYXkuDQo+PiAN
Cj4+IC0tLQ0KPj4gYXJjaC94ODYvbW0vbW1faW50ZXJuYWwuaCB8wqDCoCAyICsNCj4+IGFyY2gv
eDg2L21tL3BhZ2VhdHRyLmPCoMKgwqAgfCAxNjcgKysrKysrKysrKysrKysrKysrKystLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gYXJjaC94ODYvbW0vdGxiLmPCoMKgwqDCoMKgwqDCoMKg
IHzCoMKgIDQgKy0NCj4+IDMgZmlsZXMgY2hhbmdlZCwgNzkgaW5zZXJ0aW9ucygrKSwgOTQgZGVs
ZXRpb25zKC0pDQo+PiANCj4gDQoNCg==
