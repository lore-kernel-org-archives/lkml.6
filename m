Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60132C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D39452081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hsupBlfy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D39452081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbeKFAuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:50:39 -0500
Received: from mail-eopbgr690059.outbound.protection.outlook.com ([40.107.69.59]:24320
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727623AbeKFAuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:50:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Idh7hPvNN1A+3AJaj8FTpAc1rAKfKeFw3Q4QfZpv5h4=;
 b=hsupBlfyrgkIO7VF0RRHQ0WLiITKdR9YsCKDT9BRNk5gR0o2WhGryPpg3JvcGobk2cpZ8dFtog4mdKSDvDvET484jt490xk3hJx1ni+zBDx/OGJ2D9oxyHxmJdXb/BBjuaT8dRoGoXO+IUxlilNkipstIIo+QwW5GG26TjPKJfk=
Received: from BY2PR12MB0178.namprd12.prod.outlook.com (10.162.82.27) by
 BY2PR12MB0545.namprd12.prod.outlook.com (10.162.77.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.35; Mon, 5 Nov 2018 15:30:21 +0000
Received: from BY2PR12MB0178.namprd12.prod.outlook.com
 ([fe80::1c95:ee1d:3995:439e]) by BY2PR12MB0178.namprd12.prod.outlook.com
 ([fe80::1c95:ee1d:3995:439e%10]) with mapi id 15.20.1294.028; Mon, 5 Nov 2018
 15:30:21 +0000
From:   "Wentland, Harry" <Harry.Wentland@amd.com>
To:     Lyude Paul <lyude@redhat.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC:     "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        "Li, Roman" <Roman.Li@amd.com>, "Cheng, Tony" <Tony.Cheng@amd.com>,
        "S, Shirish" <Shirish.S@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/amd/amdgpu/dm: Fix dm_dp_create_fake_mst_encoder()
Thread-Topic: [PATCH] drm/amd/amdgpu/dm: Fix dm_dp_create_fake_mst_encoder()
Thread-Index: AQHUck6n0qDhucOJhEiBUXNJk56JFKVBVEuA
Date:   Mon, 5 Nov 2018 15:30:21 +0000
Message-ID: <d4f69652-6077-2c51-f5b9-54c1dc105098@amd.com>
References: <20181030220940.25052-2-Jerry.Zuo@amd.com>
 <20181102015151.29397-1-lyude@redhat.com>
In-Reply-To: <20181102015151.29397-1-lyude@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.250]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-clientproxiedby: YTOPR0101CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::37) To BY2PR12MB0178.namprd12.prod.outlook.com
 (2a01:111:e400:585a::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR12MB0545;20:XAYhv51na87v18PJjzYFzPT+eS2MvyIs9Zh4YqgJR4wLFg7DRiKuANUe+cdHDq7vh8wsl5bAN0St5y3btU/93sOeMDHrCZirLYXzijSIna8zzVxeoBQLDHs68wPX4EwTW6wepjxiyLTK8ATL3fdF813+RnSMZMscjVbx04CUR4pqmav2vSfWBfNmKn6G4toK6WzCII0LnI/tdKztiBziYo/p4Q7G10QFdCIpMj817DScc0WtJCOMq3Q48SPg1DDE
x-ms-office365-filtering-correlation-id: 4bad0eaa-4445-4809-35b3-08d6433398d3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0545;
x-ms-traffictypediagnostic: BY2PR12MB0545:
x-microsoft-antispam-prvs: <BY2PR12MB054589960AAA465681437CB18CCA0@BY2PR12MB0545.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BY2PR12MB0545;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0545;
x-forefront-prvs: 08476BC6EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(39860400002)(366004)(199004)(189003)(51234002)(52314003)(72206003)(316002)(5660300001)(36756003)(14444005)(65956001)(65806001)(66066001)(71190400001)(26005)(186003)(7736002)(305945005)(76176011)(102836004)(8936002)(110136005)(52116002)(54906003)(8676002)(81156014)(81166006)(6116002)(3846002)(476003)(6246003)(446003)(2616005)(31686004)(31696002)(575784001)(86362001)(486006)(2900100001)(71200400001)(11346002)(64126003)(105586002)(478600001)(6512007)(14454004)(45080400002)(6486002)(106356001)(6436002)(256004)(53936002)(25786009)(4326008)(65826007)(53546011)(6506007)(386003)(2906002)(58126008)(68736007)(2501003)(229853002)(97736004)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0545;H:BY2PR12MB0178.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KowzyRIySnOEPPtkTgx7QkInCX2J1cAqobkZm5rg3C75bJB/m4Mv8+FNuh/RXTOdnRxvwiVH5K9VkzGBLAYAk8UyqersO3S7EUBvKOicDVlAehmdQqjUy8fLMrD2fT9TXDy2pkhAcgZ7dqOhtWXp8kV7XYmu680Qx9/5HDMmJBO1uKQlvLO8wJWYjoOgTuFCv+8CKNPe5mLX3PbpkTRS/tSbII5hXJeHCdLOVC5obU7mnv95ObwEt4xjsa50ZB7pGOlqxVr6t+7GV3Qa2PLCMPXQ8okqauOIEhMIRFnAP0NTZVP/BqR1GwgoENWocvw4r7Gp9HaaPM7S1gO2HgKLt3NRuKobmedAS2QVpiV+POU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <39BECB9B956C284FB5DC17F214C13BDA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bad0eaa-4445-4809-35b3-08d6433398d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2018 15:30:21.0479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0545
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOC0xMS0wMSA5OjUxIHAubS4sIEx5dWRlIFBhdWwgd3JvdGU6DQo+IFt3aHldDQo+IFJl
bW92aW5nIGNvbm5lY3RvciByZXVzYWdlIGZyb20gRE0gdG8gbWF0Y2ggdGhlIHJlc3Qgb2YgdGhl
IHRyZWUgZW5kZWQNCj4gdXAgcmV2ZWFsaW5nIGFuIGlzc3VlIHRoYXQgd2FzIHN1cnByaXNpbmds
eSBzdWJ0bGUuIFRoZSBvcmlnaW5hbCBhbWRncHUNCj4gY29kZSBmb3IgREMgdGhhdCB3YXMgc3Vi
bWl0dGVkIGFwcGVhcnMgdG8gaGF2ZSBsZWZ0IGEgY2h1bmsgaW4NCj4gZG1fZHBfY3JlYXRlX2Zh
a2VfbXN0X2VuY29kZXIoKSB0aGF0IHRyaWVzIHRvIGZpbmQgYSAibWFzdGVyIGVuY29kZXIiLA0K
PiB0aGUgbGlrZXMgb2Ygd2hpY2ggaXNuJ3QgYWN0dWFsbHkgdXNlZCBvciBzdG9yZWQgYW55d2hl
cmUuIEl0IGRvZXMgc28gYXQNCj4gdGhlIHdyb25nIHRpbWUgYXMgd2VsbCBieSB0cnlpbmcgdG8g
YWNjZXNzIHBhcnRzIG9mIHRoZSBkcm1fY29ubmVjdG9yDQo+IGZyb20gdGhlIGVuY29kZXIgaW5p
dCBiZWZvcmUgaXQncyBhY3R1YWxseSBiZWVuIGluaXRpYWxpemVkLiBUaGlzDQo+IHJlc3VsdHMg
aW4gYSBOVUxMIHBvaW50ZXIgZGVyZWYgb24gTVNUIGhvdHBsdWdzOg0KPiANCj4gWyAgMTYwLjY5
NjYxM10gQlVHOiB1bmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVu
Y2UgYXQgMDAwMDAwMDAwMDAwMDAwMA0KPiBbICAxNjAuNjk3MjM0XSBQR0QgMCBQNEQgMA0KPiBb
ICAxNjAuNjk3ODE0XSBPb3BzOiAwMDEwIFsjMV0gU01QIFBUSQ0KPiBbICAxNjAuNjk4NDMwXSBD
UFU6IDIgUElEOiA2NCBDb21tOiBrd29ya2VyLzI6MSBLZHVtcDogbG9hZGVkIFRhaW50ZWQ6IEcg
ICAgICAgICAgIE8gICAgICA0LjE5LjBMeXVkZS1UZXN0KyAjMg0KPiBbICAxNjAuNjk5MDIwXSBI
YXJkd2FyZSBuYW1lOiBIUCBIUCBaQm9vayAxNSBHNC84Mjc1LCBCSU9TIFA3MCBWZXIuIDAxLjIy
IDA1LzE3LzIwMTgNCj4gWyAgMTYwLjY5OTY3Ml0gV29ya3F1ZXVlOiBldmVudHNfbG9uZyBkcm1f
ZHBfbXN0X2xpbmtfcHJvYmVfd29yayBbZHJtX2ttc19oZWxwZXJdDQo+IFsgIDE2MC43MDAzMjJd
IFJJUDogMDAxMDogICAgICAgICAgKG51bGwpDQo+IFsgIDE2MC43MDA5MjBdIENvZGU6IEJhZCBS
SVAgdmFsdWUuDQo+IFsgIDE2MC43MDE1NDFdIFJTUDogMDAxODpmZmZmYzkwMDAwMjlmYzc4IEVG
TEFHUzogMDAwMTAyMDYNCj4gWyAgMTYwLjcwMjE4M10gUkFYOiAwMDAwMDAwMDAwMDAwMDAwIFJC
WDogZmZmZjg4MDQ0NDBlZDQ2OCBSQ1g6IGZmZmY4ODA0NDQwZTkxNTgNCj4gWyAgMTYwLjcwMjc3
OF0gUkRYOiAwMDAwMDAwMDAwMDAwMDAwIFJTSTogZmZmZjg4MDQ1NTZjNTcwMCBSREk6IGZmZmY4
ODA0NDQwZWQwMDANCj4gWyAgMTYwLjcwMzQwOF0gUkJQOiBmZmZmODgwNDU4ZTIxODAwIFIwODog
MDAwMDAwMDAwMDAwMDAwMiBSMDk6IDAwMDAwMDAwNWZjYTBhMjUNCj4gWyAgMTYwLjcwNDAwMl0g
UjEwOiBmZmZmODgwNDVhMDc3YTNkIFIxMTogZmZmZjg4MDQ1YTA3N2EzYyBSMTI6IGZmZmY4ODA0
NDQwZWQwMDANCj4gWyAgMTYwLjcwNDYxNF0gUjEzOiBmZmZmODgwNDU4ZTIxODAwIFIxNDogZmZm
Zjg4MDQ0NDBlOTAwMCBSMTU6IGZmZmY4ODA0NDQwZTkwMDANCj4gWyAgMTYwLjcwNTI2MF0gRlM6
ICAwMDAwMDAwMDAwMDAwMDAwKDAwMDApIEdTOmZmZmY4ODA0NWYyODAwMDAoMDAwMCkga25sR1M6
MDAwMDAwMDAwMDAwMDAwMA0KPiBbICAxNjAuNzA1ODU0XSBDUzogIDAwMTAgRFM6IDAwMDAgRVM6
IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzDQo+IFsgIDE2MC43MDY0NzhdIENSMjogZmZmZmZm
ZmZmZmZmZmZkNiBDUjM6IDAwMDAwMDAwMDIwMGEwMDEgQ1I0OiAwMDAwMDAwMDAwMzYwNmUwDQo+
IFsgIDE2MC43MDcxMjRdIERSMDogMDAwMDAwMDAwMDAwMDAwMCBEUjE6IDAwMDAwMDAwMDAwMDAw
MDAgRFIyOiAwMDAwMDAwMDAwMDAwMDAwDQo+IFsgIDE2MC43MDc3MjRdIERSMzogMDAwMDAwMDAw
MDAwMDAwMCBEUjY6IDAwMDAwMDAwZmZmZTBmZjAgRFI3OiAwMDAwMDAwMDAwMDAwNDAwDQo+IFsg
IDE2MC43MDgzNzJdIENhbGwgVHJhY2U6DQo+IFsgIDE2MC43MDg5OThdICA/IGRtX2RwX2FkZF9t
c3RfY29ubmVjdG9yKzB4ZWQvMHgxZDAgW2FtZGdwdV0NCj4gWyAgMTYwLjcwOTYyNV0gID8gZHJt
X2RwX2FkZF9wb3J0KzB4MmZhLzB4NDcwIFtkcm1fa21zX2hlbHBlcl0NCj4gWyAgMTYwLjcxMDI4
NF0gID8gd2FrZV91cF9xKzB4NTQvMHg3MA0KPiBbICAxNjAuNzEwODc3XSAgPyBfX211dGV4X3Vu
bG9ja19zbG93cGF0aC5pc3JhLjE4KzB4YjMvMHgxMTANCj4gWyAgMTYwLjcxMTUxMl0gID8gZHJt
X2RwX2RwY2RfYWNjZXNzKzB4ZTcvMHgxMTAgW2RybV9rbXNfaGVscGVyXQ0KPiBbICAxNjAuNzEy
MTYxXSAgPyBkcm1fZHBfc2VuZF9saW5rX2FkZHJlc3MrMHgxNTUvMHgxZTAgW2RybV9rbXNfaGVs
cGVyXQ0KPiBbICAxNjAuNzEyNzYyXSAgPyBkcm1fZHBfY2hlY2tfYW5kX3NlbmRfbGlua19hZGRy
ZXNzKzB4YTMvMHhkMCBbZHJtX2ttc19oZWxwZXJdDQo+IFsgIDE2MC43MTM0MDhdICA/IGRybV9k
cF9tc3RfbGlua19wcm9iZV93b3JrKzB4NGIvMHg4MCBbZHJtX2ttc19oZWxwZXJdDQo+IFsgIDE2
MC43MTQwMTNdICA/IHByb2Nlc3Nfb25lX3dvcmsrMHgxYTEvMHgzYTANCj4gWyAgMTYwLjcxNDY2
N10gID8gd29ya2VyX3RocmVhZCsweDMwLzB4MzgwDQo+IFsgIDE2MC43MTUzMjZdICA/IHdxX3Vw
ZGF0ZV91bmJvdW5kX251bWErMHgxMC8weDEwDQo+IFsgIDE2MC43MTU5MzldICA/IGt0aHJlYWQr
MHgxMTIvMHgxMzANCj4gWyAgMTYwLjcxNjU5MV0gID8ga3RocmVhZF9jcmVhdGVfd29ya2VyX29u
X2NwdSsweDcwLzB4NzANCj4gWyAgMTYwLjcxNzI2Ml0gID8gcmV0X2Zyb21fZm9yaysweDM1LzB4
NDANCj4gWyAgMTYwLjcxNzg4Nl0gTW9kdWxlcyBsaW5rZWQgaW46IGFtZGdwdShPKSB2ZmF0IGZh
dCBzbmRfaGRhX2NvZGVjX2dlbmVyaWMgam95ZGV2IGk5MTUgY2hhc2ggZ3B1X3NjaGVkIHR0bSBp
MmNfYWxnb19iaXQgZHJtX2ttc19oZWxwZXIgc25kX2hkYV9jb2RlY19oZG1pIGhwX3dtaSBzeXNj
b3B5YXJlYSBpVENPX3dkdCBzeXNmaWxscmVjdCBzcGFyc2Vfa2V5bWFwIHN5c2ltZ2JsdCBmYl9z
eXNfZm9wcyBzbmRfaGRhX2ludGVsIHVzYmhpZCB3bWlfYm1vZiBkcm0gc25kX2hkYV9jb2RlYyBi
dHVzYiBzbmRfaGRhX2NvcmUgaW50ZWxfcmFwbCBidHJ0bCB4ODZfcGtnX3RlbXBfdGhlcm1hbCBi
dGJjbSBidGludGVsIGNvcmV0ZW1wIHNuZF9wY20gY3JjMzJfcGNsbXVsIGJsdWV0b290aCBwc21v
dXNlIHNuZF90aW1lciBzbmQgcGNzcGtyIGkyY19pODAxIG1laV9tZSBpMmNfY29yZSBzb3VuZGNv
cmUgbWVpIHRwbV90aXMgd21pIHRwbV90aXNfY29yZSBocF9hY2NlbCBlY2RoX2dlbmVyaWMgbGlz
M2x2MDJkIHRwbSB2aWRlbyByZmtpbGwgYWNwaV9wYWQgaW5wdXRfcG9sbGRldiBocF93aXJlbGVz
cyBwY2NfY3B1ZnJlcSBjcmMzMmNfaW50ZWwgc2VyaW9fcmF3IHRnMyB4aGNpX3BjaSB4aGNpX2hj
ZCBbbGFzdCB1bmxvYWRlZDogYW1kZ3B1XQ0KPiBbICAxNjAuNzIwMTQxXSBDUjI6IDAwMDAwMDAw
MDAwMDAwMDANCj4gDQo+IFNvbWVob3cgdGhlIGNvbm5lY3RvciByZXVzYWdlIERNIHdhcyB1c2lu
ZyBmb3IgTVNUIGNvbm5lY3RvcnMgbWFuYWdlZCB0bw0KPiBwYXBlciBvdmVyIHRoaXMgaXNzdWUg
ZW50aXJlbHk7IGhlbmNlIHdoeSB0aGlzIHdhcyBuZXZlciBjYXVnaHQgdW50aWwNCj4gbm93Lg0K
PiANCj4gW2hvd10NCj4gU2luY2UgdGhpcyBjb2RlIGlzbid0IHVzZWQgYW55d2hlcmUgYW5kIHNl
ZW1zIHVzZWxlc3MgYW55d2F5LCB3ZSBjYW4NCj4ganVzdCBkcm9wIGl0IGVudGlyZWx5LiBUaGlz
IGFwcGVhcnMgdG8gZml4IHRoZSBpc3N1ZSBvbiBteSBIUCBaQm9vayB3aXRoDQo+IGFuIEFNRCBX
WDQxNTAuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMeXVkZSBQYXVsIDxseXVkZUByZWRoYXQuY29t
Pg0KDQpHb29kIGNhdGNoLiBQcm9iYWJseSBnb3QgYnJva2VuIHdpdGggc29tZSBvZiB0aGUgYmVz
dF9lbmNvZGVyIGNsZWFudXAgdGhhdCBoYXBwZW5lZCBpbiB0aGUgbGFzdCBmZXcgbW9udGhzLiBJ
IHJlYWxseSBzaG91bGQndmUgY2F1Z2h0IGl0IHRoZW4uDQoNClJldmlld2VkLWJ5OiBIYXJyeSBX
ZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4NCg0KSGFycnkNCg0KPiAtLS0NCj4gSGV5
ISBUaGlzIGlzIHRoZSBwYXRjaCB0aGF0IEkgd2FzIHRhbGtpbmcgYWJvdXQsIGZlZWwgZnJlZSB0
byByZXZpZXcNCj4gaXQtd2Ugc2hvdWxkIG1ha2Ugc3VyZSB0aGlzIGdvZXMgaW4gd2l0aCB0aGUg
cmVzdCBvZiB0aGUgcGF0Y2hlcyB5b3UndmUNCj4gZ290IHNvIGZhci4NCj4gDQo+ICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9tc3RfdHlwZXMuYyB8IDUg
LS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX21zdF90
eXBlcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1f
bXN0X3R5cGVzLmMNCj4gaW5kZXggNmFhNzM1OWQ2MWEzLi41NDMyYTE4NjJiNDEgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX21z
dF90eXBlcy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0v
YW1kZ3B1X2RtX21zdF90eXBlcy5jDQo+IEBAIC0yODUsMTIgKzI4NSw3IEBAIGRtX2RwX2NyZWF0
ZV9mYWtlX21zdF9lbmNvZGVyKHN0cnVjdCBhbWRncHVfZG1fY29ubmVjdG9yICpjb25uZWN0b3Ip
DQo+ICAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBkZXYtPmRldl9wcml2YXRlOw0KPiAg
CXN0cnVjdCBhbWRncHVfZW5jb2RlciAqYW1kZ3B1X2VuY29kZXI7DQo+ICAJc3RydWN0IGRybV9l
bmNvZGVyICplbmNvZGVyOw0KPiAtCWNvbnN0IHN0cnVjdCBkcm1fY29ubmVjdG9yX2hlbHBlcl9m
dW5jcyAqY29ubmVjdG9yX2Z1bmNzID0NCj4gLQkJY29ubmVjdG9yLT5iYXNlLmhlbHBlcl9wcml2
YXRlOw0KPiAtCXN0cnVjdCBkcm1fZW5jb2RlciAqZW5jX21hc3RlciA9DQo+IC0JCWNvbm5lY3Rv
cl9mdW5jcy0+YmVzdF9lbmNvZGVyKCZjb25uZWN0b3ItPmJhc2UpOw0KPiAgDQo+IC0JRFJNX0RF
QlVHX0tNUygiZW5jIG1hc3RlciBpcyAlcFxuIiwgZW5jX21hc3Rlcik7DQo+ICAJYW1kZ3B1X2Vu
Y29kZXIgPSBremFsbG9jKHNpemVvZigqYW1kZ3B1X2VuY29kZXIpLCBHRlBfS0VSTkVMKTsNCj4g
IAlpZiAoIWFtZGdwdV9lbmNvZGVyKQ0KPiAgCQlyZXR1cm4gTlVMTDsNCj4gDQo=
