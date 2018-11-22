Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A45C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 18:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2746B20824
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 18:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0hWj5cwm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2746B20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404505AbeKWFbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 00:31:35 -0500
Received: from mail-eopbgr730070.outbound.protection.outlook.com ([40.107.73.70]:9469
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729748AbeKWFbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 00:31:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEW2XD9vIAq0SdopsttAB2UZ+EI7UbhMs59SZzA+uSg=;
 b=0hWj5cwmOJ+v24XfyfgGH4ND8OZjV87zyARFnOi7UzGf3gF1ZUaiMzRkYTTM4ujPjQQgEG1IGd+uPJfSV9JfIV0c7IGWV4BR3IriNrLuRAvO7X32JAc0S9H+QpaO6F7t6TozrwmVfo5kYOTcmnd8uBGROUX7bTprUCglNJhCewM=
Received: from BN6PR12MB1714.namprd12.prod.outlook.com (10.175.101.11) by
 BN6PR12MB1393.namprd12.prod.outlook.com (10.168.228.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.23; Thu, 22 Nov 2018 18:50:53 +0000
Received: from BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::f8a7:157:6224:34ee]) by BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::f8a7:157:6224:34ee%2]) with mapi id 15.20.1339.027; Thu, 22 Nov 2018
 18:50:53 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>
CC:     Linux MM <linux-mm@kvack.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 1/3] mm: Check if mmu notifier callbacks are allowed to
 fail
Thread-Topic: [PATCH 1/3] mm: Check if mmu notifier callbacks are allowed to
 fail
Thread-Index: AQHUgoOWzXcwRxKRSkqDtMb8Yb/sZaVcI4iA
Date:   Thu, 22 Nov 2018 18:50:53 +0000
Message-ID: <800ac84e-593c-31c5-cc01-2b05e877e867@amd.com>
References: <20181122165106.18238-1-daniel.vetter@ffwll.ch>
 <20181122165106.18238-2-daniel.vetter@ffwll.ch>
In-Reply-To: <20181122165106.18238-2-daniel.vetter@ffwll.ch>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [2a02:908:125b:9a00:a142:2be6:b7be:5a3a]
x-clientproxiedby: AM6PR02CA0024.eurprd02.prod.outlook.com
 (2603:10a6:20b:6e::37) To BN6PR12MB1714.namprd12.prod.outlook.com
 (2603:10b6:404:106::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1393;20:lj8ZE4d7cmoel0fJ2oVjke5MC16huKcdAyaBbshxpnBoy226yCQAfbAPhz7XzsR/pe9aPw/LMGW2v2pPBb4gUdmxAQcqt4dbYCdnYsjtYkbX2/WFTGpShHJVNaPDifGTzUn2P9TfuL71302UK1lDGlk+Y8K2vpwPylxBWKsXz0TQyu79h3dWzI42bj352F/AkB0PodpGwdamMC+FubWfRdWpOMIqOCXhYQI0IcDkcMLq3vG49zra1Q4/QTc92bT8
x-ms-office365-filtering-correlation-id: 4bf2efcd-fdbb-4538-3412-08d650ab6db9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1393;
x-ms-traffictypediagnostic: BN6PR12MB1393:
x-microsoft-antispam-prvs: <BN6PR12MB1393040C714B5C705BDDA5EA83DB0@BN6PR12MB1393.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231442)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN6PR12MB1393;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1393;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(25786009)(72206003)(64126003)(65956001)(65806001)(97736004)(68736007)(478600001)(316002)(76176011)(52116002)(6486002)(6436002)(99286004)(54906003)(2900100001)(14454004)(58126008)(110136005)(81156014)(81166006)(31686004)(186003)(6506007)(386003)(229853002)(102836004)(86362001)(106356001)(105586002)(36756003)(2906002)(7736002)(65826007)(6116002)(446003)(8936002)(6246003)(4326008)(486006)(46003)(14444005)(476003)(6512007)(2616005)(305945005)(53936002)(11346002)(8676002)(256004)(31696002)(66574009)(71190400001)(7416002)(71200400001)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1393;H:BN6PR12MB1714.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0MnlLkAw5MsqswDRLVkJ2wHXPdAkOgkR9o5rQLMYk45GcHY1YhY73x1SA6EWQYjJS3zng5vgv8TJ17JF/G5QihQKETHyKXKfuXJlDvpkUYHRUO8n9ChBl8zcr/pWoan0fpH73eobamR5odFw+cGl3ObhKb9JFArvILOHLW1LqPVpDrXPuM6zmAgKLu/Aq95laEvtrg7OcI+SZMWcBYkIn1ncqQzt16kqiCTkOX7+OtaRkErwV+liy2CYoJjnHDYpmU2rB8zxcTvMHTGH/qVYx5UwloNgQd6CXA/GKNQDIIgGbTCc9PLWEdXKpsGdsEQVDqrQNxoWvvkFaaiYcng/jpgL0QvfvfHRXKyBT7DaT78=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <076964FFF5ABA64A8FD48047436FD562@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf2efcd-fdbb-4538-3412-08d650ab6db9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 18:50:53.5300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1393
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMjIuMTEuMTggdW0gMTc6NTEgc2NocmllYiBEYW5pZWwgVmV0dGVyOg0KPiBKdXN0IGEgYml0
IG9mIHBhcmFub2lhLCBzaW5jZSBpZiB3ZSBzdGFydCBwdXNoaW5nIHRoaXMgZGVlcCBpbnRvDQo+
IGNhbGxjaGFpbnMgaXQncyBoYXJkIHRvIHNwb3QgYWxsIHBsYWNlcyB3aGVyZSBhbiBtbXUgbm90
aWZpZXINCj4gaW1wbGVtZW50YXRpb24gbWlnaHQgZmFpbCB3aGVuIGl0J3Mgbm90IGFsbG93ZWQg
dG8uDQo+DQo+IENjOiBBbmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0K
PiBDYzogTWljaGFsIEhvY2tvIDxtaG9ja29Ac3VzZS5jb20+DQo+IENjOiAiQ2hyaXN0aWFuIEvD
tm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gQ2M6IERhdmlkIFJpZW50amVzIDxy
aWVudGplc0Bnb29nbGUuY29tPg0KPiBDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsLnZldHRlckBm
ZndsbC5jaD4NCj4gQ2M6ICJKw6lyw7RtZSBHbGlzc2UiIDxqZ2xpc3NlQHJlZGhhdC5jb20+DQo+
IENjOiBsaW51eC1tbUBrdmFjay5vcmcNCj4gQ2M6IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJl
ZGhhdC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBWZXR0ZXIgPGRhbmllbC52ZXR0ZXJA
aW50ZWwuY29tPg0KDQpBY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPg0KDQo+IC0tLQ0KPiAgIG1tL21tdV9ub3RpZmllci5jIHwgMiArKw0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL21tL21tdV9u
b3RpZmllci5jIGIvbW0vbW11X25vdGlmaWVyLmMNCj4gaW5kZXggNTExOWZmODQ2NzY5Li41OWUx
MDI1ODlhMjUgMTAwNjQ0DQo+IC0tLSBhL21tL21tdV9ub3RpZmllci5jDQo+ICsrKyBiL21tL21t
dV9ub3RpZmllci5jDQo+IEBAIC0xOTAsNiArMTkwLDggQEAgaW50IF9fbW11X25vdGlmaWVyX2lu
dmFsaWRhdGVfcmFuZ2Vfc3RhcnQoc3RydWN0IG1tX3N0cnVjdCAqbW0sDQo+ICAgCQkJCXByX2lu
Zm8oIiVwUyBjYWxsYmFjayBmYWlsZWQgd2l0aCAlZCBpbiAlc2Jsb2NrYWJsZSBjb250ZXh0Llxu
IiwNCj4gICAJCQkJCQltbi0+b3BzLT5pbnZhbGlkYXRlX3JhbmdlX3N0YXJ0LCBfcmV0LA0KPiAg
IAkJCQkJCSFibG9ja2FibGUgPyAibm9uLSIgOiAiIik7DQo+ICsJCQkJV0FSTihibG9ja2FibGUs
IiVwUyBjYWxsYmFjayBmYWlsdXJlIG5vdCBhbGxvd2VkXG4iLA0KPiArCQkJCSAgICAgbW4tPm9w
cy0+aW52YWxpZGF0ZV9yYW5nZV9zdGFydCk7DQo+ICAgCQkJCXJldCA9IF9yZXQ7DQo+ICAgCQkJ
fQ0KPiAgIAkJfQ0KDQo=
