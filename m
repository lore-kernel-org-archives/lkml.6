Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD82AECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5171120C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CYxcolIz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5171120C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbeIRXZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 19:25:14 -0400
Received: from mail-by2nam03on0049.outbound.protection.outlook.com ([104.47.42.49]:28896
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730427AbeIRXZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 19:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHfBy3F1ItVpWGt6XXWB8cG+mXeMReJgwDUDZ9mPzBQ=;
 b=CYxcolIzu7PCxsPdr9OwY2bed+NGkPEx7PQyw9RGPYYeDABVdff3x7z+Fj/5E5ORt2R/PczJgL6pbHNqiCHPs6/ulIINX8cKn+Hk4MqMdlh6pygl/rH1+fxLEzkyiRWyUjXd4IhBW5uGddkJsSjeBNsejVbojYFxoohlj0rpPgE=
Received: from CY4PR1201MB2534.namprd12.prod.outlook.com (10.172.121.7) by
 CY4PR1201MB0037.namprd12.prod.outlook.com (10.172.77.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Tue, 18 Sep 2018 17:51:29 +0000
Received: from CY4PR1201MB2534.namprd12.prod.outlook.com
 ([fe80::b08f:8c8e:9b73:a942]) by CY4PR1201MB2534.namprd12.prod.outlook.com
 ([fe80::b08f:8c8e:9b73:a942%9]) with mapi id 15.20.1143.017; Tue, 18 Sep 2018
 17:51:29 +0000
From:   Jiandi An <jiandi@amd.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
CC:     Dave Airlie <airlied@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        Dave Airlie <airlied@linux.ie>,
        "open list:VIRTIO CORE, NET..." 
        <virtualization@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>
Subject: Re: [virtio-dev] [PATCH 2/2] drm/virtio: add iommu support.
Thread-Topic: [virtio-dev] [PATCH 2/2] drm/virtio: add iommu support.
Thread-Index: AQHUP5Ky9o6EaoAaAUKshOjpemWQV6TfQrMAgAyj3wCAAG3ngIAKHNIA
Date:   Tue, 18 Sep 2018 17:51:28 +0000
Message-ID: <5684a3fc-3605-7bb0-b0be-418c2ae702b5@amd.com>
References: <20180829122026.27012-1-kraxel@redhat.com>
 <20180829122026.27012-3-kraxel@redhat.com>
 <CAPM=9tyXc41DAkgjCRojrqH28qkirxgrpgNmrwu4WAeLpg7tAw@mail.gmail.com>
 <9bf20fa1-3752-edd1-588c-e38cd166c3af@amd.com>
 <20180912072541.nagfrr2dgy34szcx@sirius.home.kraxel.org>
In-Reply-To: <20180912072541.nagfrr2dgy34szcx@sirius.home.kraxel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM5PR07CA0068.namprd07.prod.outlook.com
 (2603:10b6:4:ad::33) To CY4PR1201MB2534.namprd12.prod.outlook.com
 (2603:10b6:903:da::7)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jiandi.An@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR1201MB0037;20:O3xQoP19qtWZhrHMh68EYJ9Dlevru2oOAmw0DZUzTRPLNgl4rIBCdlmJbe8dNZgkJRzrgoeo4talw3TW165LQ+UJHuH5kpALIvla5ZROfWNUInwhIxOknvZ4hKBbD7+tTI/JIqY+eOu68k6QgbEbiAWjdd9HTNPnOPhLolpFV865FXMpQja6qnOytSj4a4433ZnxYO0g5BQq+OgQWKCSmQkYtid2mcGnfV4PGR1gzmDzogOtQqLi7AyBnB3EZPm4
x-ms-office365-filtering-correlation-id: 821e7ab7-a76d-40ad-e760-08d61d8f5c4d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY4PR1201MB0037;
x-ms-traffictypediagnostic: CY4PR1201MB0037:
x-microsoft-antispam-prvs: <CY4PR1201MB003725867B925352A70CFB40FD1D0@CY4PR1201MB0037.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:CY4PR1201MB0037;BCL:0;PCL:0;RULEID:;SRVR:CY4PR1201MB0037;
x-forefront-prvs: 0799B1B2D7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(39860400002)(366004)(376002)(189003)(199004)(316002)(97736004)(6246003)(72206003)(478600001)(4326008)(25786009)(6436002)(186003)(2906002)(102836004)(6306002)(386003)(8936002)(8676002)(52116002)(99286004)(39060400002)(76176011)(256004)(53546011)(6512007)(26005)(486006)(53936002)(476003)(68736007)(6486002)(7736002)(2616005)(229853002)(446003)(5660300001)(305945005)(6916009)(6506007)(54906003)(93886005)(31696002)(11346002)(14454004)(966005)(2900100001)(66066001)(106356001)(105586002)(5250100002)(36756003)(31686004)(81156014)(81166006)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR1201MB0037;H:CY4PR1201MB2534.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Hv98WJKVY4uGdBxKzokFk4d/zigiHCwYs4UmXK6PRvd20AiFNAPydmPt3fgbt789xTMYw2LVACx0EDHGgJWbXKHsRhh/mUadtZiwr4bc0Uo5mMhloVpldTGI0IuC9rgkXsYNSsyRxS7XEgmZTGp+sxa0Mgi11x5pbkYqpfBgiU309JX0gwgyTwTt9BNqwYai/JrlbdqpHkv6r2Mn6KvU5uqNxRE0juviPnpjfXzQBIHFEF5T3tZRWFCRae+PNffYHlU3SFtGw1Q6X8lb0saYS9x303Pr18FntXt6OZ2av3HDm7NQK0xIq7C/IIgbeieX207a691geKIqBB9bBdpGf6czaaiIfpbyGSiqcMkElIk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC42138ACDCB9044A99E28917DFE91F3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 821e7ab7-a76d-40ad-e760-08d61d8f5c4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2018 17:51:29.0145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA5LzEyLzIwMTggMDI6MjUgQU0sIEdlcmQgSG9mZm1hbm4gd3JvdGU6DQo+ICAgSGks
DQo+IA0KPj4gSSBhdHRlbXB0ZWQgdG8gZml4IGl0IGluIHRoZSB0dG0gbGF5ZXIgYW5kIGhlcmUg
aXMgdGhlIGRpc2N1c3Npb24NCj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvYjQ0Mjgw
ZDctZWIxMy0wOTk2LTcxZjUtM2ZiZGViNDY2ODAxQGFtZC5jb20vDQo+Pg0KPj4gVGhlIHR0bSBt
YWludGFpbmVyIENocmlzdGlhbiBpcyBzdWdnZXN0aW5nIHRvIG1hcCBhbmQgc2V0IHR0bS0+cGFn
ZXMgYXMgZGVjcnlwdGVkDQo+PiByaWdodCBhZnRlciB0dG0tPnBhZ2VzIGFyZSBhbGxvY2F0ZWQu
DQo+Pg0KPj4gSnVzdCBjaGVja2luZyB3aXRoIHlvdSBndXlzIG1heWJlIHRoZXJlIGlzIGEgYmV0
dGVyIHdheSB0byBoYW5kbGUgdGhpcyBpbg0KPj4gdGhlIHZpcnRpbyBncHUgbGF5ZXIgaW5zdGVh
ZCBvZiB0aGUgY29tbW9uIHR0bSBsYXllci4gIENvdWxkIHlvdSBndXlzIHNoaW5lIHNvbWUNCj4+
IGxpZ2h0IG9uIHRoaXM/ICBUaGFua3MuDQo+IA0KPiBJIHRoaW5rIHRoZSB0dHkgbGF5ZXIgaXMg
dGhlIHJpZ2h0IHBsYWNlIHRvIGZpeCB0aGlzLiAgdmlydGlvIGp1c3QgY2FsbHMNCj4gZG93biB0
byB0dG0gZm9yIG1hcHBpbmdzLiAgSSB0aGluayB2aXJ0aW8gc2hvdWxkIGp1c3QgaGludCB0byB0
dG0gdXNpbmcNCj4gYSBmbGFnIGluIHNvbWUgc3RydWN0LCBwcm9iYWJseSB0dG1fYnVmZmVyX29i
amVjdCBvcg0KPiB0dG1fbWVtX3R5cGVfbWFuYWdlciwgdGhhdCB0aGUgb2JqZWN0cyBuZWVkIGRl
Y3J5cHRlZCBtYXBwaW5ncy4NCj4gDQo+IGNoZWVycywNCj4gICBHZXJkDQo+IA0KDQpJIHRlc3Rl
ZCB0aGlzIHBhdGNoIHdpdGggbm9uIFNFViBndWVzdC4gIEl0IGdpdmVzIGEgYmxhbmsgYmxhY2sg
c2NyZWVuIGlmIGJvb3RpbmcNCndpdGggc3dpb3RsYj1mb3JjZS4gIGRtYV9zeW5jIGlzIG1pc3Np
bmcgaWYgZG1hIG9wIHVzZXMgc3dpb3RsYiBhcyBib3VuY2UNCmJ1ZmZlci4gIEkgdHJpZWQgdG8g
cHV0IGEgZG1hX3N5bmNfc2dfZm9yX2RldmljZSgpIG9uIHZpcnRpb19ncHVfb2JqZWN0IG9iai0+
cGFnZXMtc2dsDQpiZWZvcmUgVklSVElPX0dQVV9DTURfVFJBTlNGRVJfVE9fSE9TVF8yRCBpcyBz
ZW50LiAgVGhpcyBmaXhlcyB0aGUga2VybmVsIGNvbnNvbGUgcGF0aC4NCk9uY2UgZGlzcGxheSBt
YW5nZXIgaXMga2lja2VkIG9mZiBmb3IgZXhhbXBsZSAoc3VkbyBzeXN0ZW1jdGwgc3RhcnQgbGln
aHRkbS5zZXJ2aWNlKSBhbmQNCnJlc291cmNlIGlkIDMgZ2V0cyBjcmVhdGVkIGZyb20gdXNlciBz
cGFjZSBkb3duLCBpdCBzdGlsbCBnaXZlcyBhIGJsYW5rIGJsYWNrIHNjcmVlbi4NCg0KSW4gYWRk
aXRpb24sIEkgYWRkZWQgZG1hX3N5bmNfc2dfZm9yX2RldmljZSgpIGJlZm9yZSBzZW5kaW5nIFZJ
UlRJT19HUFVfQ01EX1JFU09VUkNFX0ZMVVNIDQphbmQgVklSVElPX0dQVV9DTURfU0VUX1NDQU5P
VVQsIHN0aWxsIGJsYW5rIGJsYWNrIHNjcmVlbiBhZnRlciBkaXNwbGF5IG1hbmdlciBpcyBraWNr
ZWQgb2ZmLg0KDQpEbyB5b3Uga25vdyB3aGljaCBwYXRoIEknbSBzdGlsbCBtaXNzaW5nIGFzIGZh
ciBhcyBWSVJUSU9fR1BVX0NNRCBnb2VzPw0KDQpUaGFua3MNCi0gSmlhbmRpDQo=
