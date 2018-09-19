Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A06ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0950C21523
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="11e0B/0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0950C21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387535AbeITDq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:46:59 -0400
Received: from mail-dm3nam03on0071.outbound.protection.outlook.com ([104.47.41.71]:20752
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732852AbeITDq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyaVrrQOg0n1UIWMhoPRJKZMpW3/cUW8HVnkpcliXjk=;
 b=11e0B/0Nl765dvtn0Un6QXu+la+yt422nuVy6+GV1/gqgyy6ClYdVtnC9DYG1YjE5Ye0CoAFZ5N9/uJieJ0hAZJpAs1aN5RJDaCjrz18HcVL62Z3Z+5onHwhG6nW+E/UxwbOKgGfm58wSWeIV3EaTolviJ27Rz0T6R3/7VAabM8=
Received: from CY4PR1201MB2534.namprd12.prod.outlook.com (10.172.121.7) by
 CY4PR1201MB0262.namprd12.prod.outlook.com (10.172.79.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Wed, 19 Sep 2018 22:06:58 +0000
Received: from CY4PR1201MB2534.namprd12.prod.outlook.com
 ([fe80::b08f:8c8e:9b73:a942]) by CY4PR1201MB2534.namprd12.prod.outlook.com
 ([fe80::b08f:8c8e:9b73:a942%9]) with mapi id 15.20.1143.017; Wed, 19 Sep 2018
 22:06:58 +0000
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
Thread-Index: AQHUP5Ky9o6EaoAaAUKshOjpemWQV6TfQrMAgAyj3wCAAG3ngIAKHNIAgAC24gCAACmmAIAASX+AgACvr4A=
Date:   Wed, 19 Sep 2018 22:06:58 +0000
Message-ID: <bb7b8676-cf39-3144-2de1-389f4b0a70b3@amd.com>
References: <20180829122026.27012-1-kraxel@redhat.com>
 <20180829122026.27012-3-kraxel@redhat.com>
 <CAPM=9tyXc41DAkgjCRojrqH28qkirxgrpgNmrwu4WAeLpg7tAw@mail.gmail.com>
 <9bf20fa1-3752-edd1-588c-e38cd166c3af@amd.com>
 <20180912072541.nagfrr2dgy34szcx@sirius.home.kraxel.org>
 <5684a3fc-3605-7bb0-b0be-418c2ae702b5@amd.com>
 <20180919044600.utvnu5l6fvvi2qi4@sirius.home.kraxel.org>
 <d4c25272-9df8-33d6-d310-964b17a8c80d@amd.com>
 <20180919113807.6mwqxkdg6f55h6fg@sirius.home.kraxel.org>
In-Reply-To: <20180919113807.6mwqxkdg6f55h6fg@sirius.home.kraxel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0601CA0003.namprd06.prod.outlook.com
 (2603:10b6:803:2f::13) To CY4PR1201MB2534.namprd12.prod.outlook.com
 (2603:10b6:903:da::7)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jiandi.An@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR1201MB0262;20:NKCgcZkY/pxajUw9dyNQt7b0Zz5XflqduRfl+6YyLy/zRQkBOZPx+2l9F+MVm5R1HGgt3cY+fQEyeuMbV5cZGOluxGp1uY2kbU5LktIHAyf8lhmtI+ejsf751zo2fSBJFpjw1NEi+++VGDUz+5710uUedCmj2aIk8tRFzD9AWims0KT3f65Yr9IhwgdJF+oCYwQo7YIsaUu8IOMMGFj1k5Fi9Dy6M8f+mI7N5s+JzoUExXL+LjBQMd1NRyMoZ/0Q
x-ms-office365-filtering-correlation-id: 90df599c-c214-4acc-6e6e-08d61e7c37dc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR1201MB0262;
x-ms-traffictypediagnostic: CY4PR1201MB0262:
x-microsoft-antispam-prvs: <CY4PR1201MB0262158357EE23BBE80D6E6CFD1C0@CY4PR1201MB0262.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051);SRVR:CY4PR1201MB0262;BCL:0;PCL:0;RULEID:;SRVR:CY4PR1201MB0262;
x-forefront-prvs: 0800C0C167
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(39860400002)(396003)(136003)(189003)(199004)(6512007)(305945005)(5250100002)(7736002)(6916009)(102836004)(6306002)(5660300001)(53936002)(486006)(2616005)(11346002)(446003)(476003)(14444005)(6436002)(256004)(5024004)(106356001)(105586002)(31686004)(2900100001)(6116002)(186003)(3846002)(25786009)(8676002)(6246003)(4326008)(39060400002)(66066001)(53546011)(386003)(6506007)(81156014)(81166006)(966005)(72206003)(14454004)(8936002)(2906002)(36756003)(229853002)(68736007)(6486002)(478600001)(54906003)(316002)(93886005)(97736004)(99286004)(26005)(76176011)(52116002)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR1201MB0262;H:CY4PR1201MB2534.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: y5Tlr5FBXVM1Iw55CBN5Tln+AQcF2O3UYlqPWXmRYLYIzsVnHwEHVOxZkr6W9cB/EYDtpVeua93mwK5/HLNp3NUub1CTsx/yXUde3kSl7DwZL3T11dfRj4SszseL5YeYNJc2Fd5eICgG2fKo1kscG05m/7fbsB+j+ZxV1Ize/9GUtoGHGCTDGpCjhrOtULTbSwGhfL31EQYbkeKrVpp00pNqHxotp7g6tUiD/nBx2vD8dPru70QeB0cI5YXpdH0BsW2L+rUNMzWwDXV7nbRAPz4CSjaFI9PbkqwEaTJdM3joHYmxBbMqPpUBjM4JpdKpmzNoN6qIKKFwM+fbAcLYDufw1s/yPlsIsCAmRYiZyWA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9DBB1152B745F4E879EACF993538684@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90df599c-c214-4acc-6e6e-08d61e7c37dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2018 22:06:58.7289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0262
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA5LzE5LzIwMTggMDY6MzggQU0sIEdlcmQgSG9mZm1hbm4gd3JvdGU6DQo+Pj4+IE9u
Y2UgZGlzcGxheSBtYW5nZXIgaXMga2lja2VkIG9mZiBmb3IgZXhhbXBsZSAoc3VkbyBzeXN0ZW1j
dGwgc3RhcnQgbGlnaHRkbS5zZXJ2aWNlKSBhbmQNCj4+Pj4gcmVzb3VyY2UgaWQgMyBnZXRzIGNy
ZWF0ZWQgZnJvbSB1c2VyIHNwYWNlIGRvd24sIGl0IHN0aWxsIGdpdmVzIGEgYmxhbmsgYmxhY2sg
c2NyZWVuLg0KPj4+DQo+Pj4gSG1tLiAgSSdkIHN1c3BlY3QgdGhlcmUgaXMgc2ltcGx5IGEgY29k
ZSBwYXRoIG1pc3NpbmcuICBDYW4geW91IHNlbmQgdGhlDQo+Pj4gcGF0Y2ggeW91IGhhdmU/DQo+
Pj4NCj4+PiBjaGVlcnMsDQo+Pj4gICBHZXJkDQo+Pj4NCj4+DQo+PiBJIHNlbnQgdGhlIHBhdGNo
LiAgRm9yIG5vdyBpdCBkb2VzIGRtYV9zeW5jX3NnIG9uIHRoZSBwYWdlcyBpbiANCj4+IFRSQU5T
RkVSX1RPX0hPU1RfMkQvM0Qgd2hlbiB1c2VfZG1hX2FwaSBpcyB0cnVlLg0KPj4NCj4+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAxODA5MTkwNzA5MzEuOTExNjgtMS1qaWFuZGkuYW5A
YW1kLmNvbS8NCj4gDQo+IEhtbSwgdGhlIHdheSBpdCBpcyBob29rZWQgdXAgaXQgc2hvdWxkIG5v
dCBtaXNzIGFueSByZXNvdXJjZSB1cGRhdGUuDQo+IFNvIG5vdCBzdXJlIHdoeSBpdCBpc24ndCB3
b3JraW5nLg0KPiBQdXNoZWQgdGhlIHBhdGNoIG5ldmVydGhlbGVzcyBhcyBpdCBpcyBjbGVhcmx5
IGEgc3RlcCBpbnRvIHRoZSByaWdodA0KPiBkaXJlY3Rpb24uDQo+IA0KPiBjaGVlcnMsDQo+ICAg
R2VyZA0KPiANCg0KDQpJIGRpZCBtb3JlIHRyYWNpbmcgYW5kIGRpZ2dpbmcuICBUaGUgdHRtLXBh
Z2VzIHRoYXQgbmVlZHMgdG8gYmUgZG1hX3N5bmNlZA0KYXJlIGluc2lkZSB2aXJ0aW9fZ3B1X29i
amVjdC4NCg0KVGhlcmUgYXJlIDQgVklSVElPX0dQVV9DTURfUkVTT1VSQ0VfQ1JFQVRFXzJEL19B
VFRBQ0hfQkFDS0lORyBjb21pbmcgZG93bg0KdGhlIGRyaXZlciBjcmVhdGluZyB2aXJ0aW9fZ3B1
X29iamVjdHMgd2l0aCByZXNvdXJjZV9pZCA9IDEsIDIsIDMsIDQgcmVzcGVjdGl2ZWx5Lg0KDQpy
ZXNvdXJjZV9pZCA9IDEgaXMgY3JlYXRlZCBkdXJpbmcgZHJpdmVyIGxvYWQgaW4gdGhlIHBhdGgg
b2YgDQp2aXJ0aW9fZ3B1X3Byb2JlKCkNCiAgIHZpcnRpb19ncHVfZmJkZXZfaW5pdCgpDQogICAg
ICB2aXJ0aW9fZ3B1ZmJfY3JlYXRlKCkNCg0KSW4gdGhpcyBwYXRoIHZpcnRpb19ncHVfZnJhbWVi
dWZmZXJfaW5pdCgpIGlzIGNhbGxlZCB3aGVyZSBpdCB0aWVzDQp2aXJ0aW9fZ3B1X29iamVjdCAt
PiBkcm1fZ2VtX29iamVjdCBpbnRvIA0KdmlydGlvX2dwdV9mcmFtZWJ1ZmZlciAtPiBkcm1fZnJh
bWVidWZmZXIgLT4gZHJtX2dlbV9vYmplY3Qgb2JqWzBdDQoNClNvIGxhdGVyIHdpdGggZ2l2ZW4g
ZHJtX2dlbV9vYmplY3QsIGdlbV90b192aXJ0aW9fZ3B1X29iaigpIGNhbiBnZXQgdG8NCnRoZSB2
aXJ0aW9fZ3B1X29iamVjdCB0aGF0IGNvbnRhaW5zIGl0Lg0KDQpXaGVuIGtpY2tpbmcgb2ZmIGRp
c3BsYXkgbWFuYWdlciBzdWNoIGFzIGxpZ2h0ZG0NCnJlc291cmNlX2lkID0gMiwgMywgYW5kIDQg
YXJlIGNyZWF0ZWQgaW4gdGhlIGRybV9tb2RlX2NyZWF0ZV9kdW1iIGlvY3RsIHBhdGgNCmRybV9t
b2RlX2NyZWF0ZV9kdW1iKCkNCiAgIGRybV9pb2N0bCgpDQogICAgICBkcm1fbW9kZV9jcmVhdGVf
ZHVtYl9pb2N0bCgpDQogICAgICAgICB2aXJ0aW9fZ3B1X21vZGVfZHVtYl9jcmVhdGUoKQ0KDQpJ
biB0aGlzIHBhdGggYSBkaWZmZXJlbnQgdmlydGlvX2dwdV9vYmplY3QgaXMgY3JlYXRlZCBmb3Ig
ZWFjaCByZXNvdXJjZV9pZC4NClRoZSB2aXJ0aW9fZ3B1X29iamVjdCBvciB0aGUgdW5kZXJseWlu
ZyBkcm1fZ2VtX29iamVjdCBpcyBub3QgdGllZCB0bw0KdmlydGlvX2dwdV9mcmFtZWJ1ZmZlci4g
IEl0IGlzIHB1Ymxpc2hlZCB0byB1c2Vyc3BhY2UgdGhyb3VnaCBkcm1fZmlsZSB3aGljaA0KcmVn
aXN0ZXJzIHRoZSBnZW1faGFuZGxlIGZvciB0aGUgZHJtX2dlbV9vYmplY3QuDQoNCkFmdGVyIGRp
c3BsYXkgbWFuZ2VyIGlzIGtpY2tlZCBvZmYsIHRoZSBWSVJUSU9fR1BVX0NNRF9UUkFOU0ZFUl9U
T19IT1NUXzJEDQpjb21tYW5kIGlzIGFjdGluZyBvbiB0aGUgdmlydGlvX2dwdV9vYmplY3QgcmVz
b3VyY2UgY3JlYXRlZCBmb3IgcmVzb3VyY2VfaWQgPSAzLg0KDQpJbiB2aXJ0aW9fZ3B1X2NtZF90
cmFuc2Zlcl90b19ob3N0KCksIGl0IG9ubHkgaGFzIGFjY2VzcyB0byBzdHJ1Y3QgdmlydGlvX2dw
dV9kZXZpY2UsDQpzbyB0aGUgdmlydGlvX2dwdV9vYmplY3QgaXQgYWNjZXNzZXMgdGhyb3VnaCB2
aXJ0aW9fZ3B1X2RldmljZSBpcyByZXNvdXJjZV9pZCA9IDEncw0KdmlydGlvX2dwdV9vYmplY3Qu
DQoNCnZvaWQgdmlydGlvX2dwdV9jbWRfdHJhbnNmZXJfdG9faG9zdF8yZChzdHJ1Y3QgdmlydGlv
X2dwdV9kZXZpY2UgKnZnZGV2LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHVpbnQzMl90IHJlc291cmNlX2lkLCB1aW50NjRfdCBvZmZzZXQsDQouLi4NCiAgICAgc3Ry
dWN0IHZpcnRpb19ncHVfZmJkZXYgKnZnZmJkZXYgPSB2Z2Rldi0+dmdmYmRldjsNCiAgICAgc3Ry
dWN0IHZpcnRpb19ncHVfZnJhbWVidWZmZXIgKmZiID0gJnZnZmJkZXYtPnZnZmI7DQogICAgIHN0
cnVjdCB2aXJ0aW9fZ3B1X29iamVjdCAqb2JqID0gZ2VtX3RvX3ZpcnRpb19ncHVfb2JqKGZiLT5i
YXNlLm9ialswXSk7DQogICAgIA0KDQpJbiBzdHJ1Y3QgZHJtX2ZyYW1lYnVmZmVyLCB0aGVyZSBp
cyBzdHJ1Y3QgZHJtX2dlbV9vYmplY3QgKm9ials0XSwgb25seSBmaXJzdA0KZWxlbWVudCBpcyBi
ZWluZyB1c2VkIGhlcmUuICBDYW4gdGhlIHZpcnRpb19ncHVfb2JqZWN0IGNyZWF0ZWQgZnJvbSB1
c2VyIHNwYWNlDQpmb3IgcmVzb3VyY2VfaWQgMyBiZSBzYXZlZCBoZXJlIHRvIHRpZSBpdCB0byB2
aXJ0aW9fZ3B1X2ZyYW1lYnVmZmVyPw0KDQpJcyB0aGVyZSBiZXR0ZXIgd2F5IHRvIGdldCB0byB0
aGUgdmlydGlvX2dwdV9vYmplY3QgY3JlYXRlZCBpbiB0aGUNCnZpcnRpb19ncHVfbW9kZV9kdW1i
X2NyZWF0ZSgpIHBhdGggZnJvbSB2aXJ0aW9fZ3B1X2RldmljZSBvciBzb21laG93IGZyb20gZHJt
X2ZpbGUNCnZpYSBnZW1faGFuZGxlIGRvd24gYXQgdGhlIGxheWVyIG9mIHZpcnRpb19ncHVfY21k
X3RyYW5zZmVyX3RvX2hvc3QoKT8NCg0KVGhhbmtzDQotIEppYW5kaQ0K
