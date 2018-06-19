Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EB9C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D781C2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HPE/o5W+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="d37fqCRf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D781C2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937858AbeFSPSP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:18:15 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:35956 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937750AbeFSPSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1529421488; x=1560957488;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=x336fvugodnPHFznva0k9A9y0AaDBjE9gvAnq7+kdXM=;
  b=HPE/o5W+Oc+JrchUOh6L5mv8yLWGmfZsNkFvJrHARaUsLRuYFfzSTb1O
   ojtDjErY7NPfWIcfsZW6eAK6wmq1UPTam23DCMnH6w9q3lmnaQYw+SAGN
   6Az4bpRdozJOWbuh5EFQW1j2Dx5xt0Tq0KoMblV3KAqAJ+fT7ngBYtZ8b
   G0aQZswDPFlkzKpNS4a9tA9FEhmwW5BZRO9lbD88Ykk5M4hqnN3OQeb8B
   FMSE4qnkHTugQTXeIEpWDjMDUQzolgWGb3qpynlxZzVZmKcFeUfVmczl8
   LjbfSR//OcGhkIp7MqxxiLhRvlzgxmRJaTMN3bHCLblmKftwkfKo+ijc6
   Q==;
X-IronPort-AV: E=Sophos;i="5.51,243,1526313600"; 
   d="scan'208";a="83185367"
Received: from mail-dm3nam03lp0021.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([207.46.163.21])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2018 23:18:07 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x336fvugodnPHFznva0k9A9y0AaDBjE9gvAnq7+kdXM=;
 b=d37fqCRfQmk5sAXC9WYU7aO72chhF8v+6ES3ys43tXAL4F+eM6IOd8JGP7xhk+V82zxaZsGJt9iOptOsWvTbbeJrX+BgZY3REClwOJPzrcD9Cc40i9TjpC48pwTjluxY2eLWi22QABZ2pZ2svGVgufUjnhu/ozKM/D9fVikqnLs=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0800.namprd04.prod.outlook.com (10.172.168.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.14; Tue, 19 Jun 2018 15:18:06 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5%8]) with mapi id 15.20.0863.016; Tue, 19 Jun 2018
 15:18:05 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: use blk_mq_timeout_work to limit the max timeout
Thread-Topic: [PATCH] blk-mq: use blk_mq_timeout_work to limit the max timeout
Thread-Index: AQHUB5sHt3Tm1rT3wE6GHzvCbSQoQaRnsjkA
Date:   Tue, 19 Jun 2018 15:18:05 +0000
Message-ID: <884a5cbb5622ca5c890585a8d5dff0e3a1d60cfe.camel@wdc.com>
References: <1529391610-1654-1-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1529391610-1654-1-git-send-email-jianchao.w.wang@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0800;7:e0ToBB61k6KvONlihUt5Z/NcEJ8AyguxJCPZJCZqA27ETOVXDMec6zsrclhVItuOcJDqVEHaXk7S5cWAH2HAa7cxyKfCm24uNlhLQaWMT2PUQSIGo0fiUe1/Fq+BekdeHBvHFwIQfacYDxtco02fd/JGi6TyWp+0RRuzZtkQ2Mjz9Ti/TVm1PP2ODXFe3OkF5GYQY1x47XIOvL/ktxkHV83WsH6QUQ9pW7S4GNv+ZHAj/aEpWW4tEdN0g0CdYXDd;20:QOCDOtOYB3Qo53l8/wHS6SlzFWJa8tXH6qdIRUmLCfYaTmFiV7x0j8YCQKJvjXh+7YwHL7aUA6qXWRYHmyVrSnoMcg8mk7GXVhqzF+A4vnX0z2TU70+BpdASe5KG6XO0m9HeFszOlnEXx8QpfhxbrVY8GK0gVEzbbp7AIzQNllg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a8ed0b38-a0e7-4beb-c3bd-08d5d5f7db86
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0800;
x-ms-traffictypediagnostic: MWHPR04MB0800:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB080093ACF5F4F5904CE8B09F98700@MWHPR04MB0800.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0800;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0800;
x-forefront-prvs: 07083FF734
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(346002)(366004)(376002)(199004)(189003)(2616005)(3660700001)(5660300001)(11346002)(446003)(3280700002)(25786009)(106356001)(305945005)(476003)(486006)(2906002)(66066001)(86362001)(4326008)(36756003)(68736007)(8676002)(2900100001)(81156014)(229853002)(478600001)(8936002)(6246003)(186003)(81166006)(110136005)(76176011)(14454004)(72206003)(99286004)(102836004)(6116002)(53936002)(118296001)(105586002)(6512007)(3846002)(97736004)(2501003)(59450400001)(316002)(26005)(54906003)(5250100002)(6436002)(6506007)(7736002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0800;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: xc/ABvgNr9C4QUQPDtLaOgtwBVnIXXFTCYEpb4F1l7Nifi1/JA3ScldqHalkJZOEKW+8gO6G/AEcNel0kNWYo/ZZ70cV2ZnTTkToPUJ+/czFYwfs9b+dVjsnsVmQUgf0N6wuytodq5JbbHjQ99g+cvGrVt1Kp/DIx1K8+beD96TgdnzyHLWbvaiNnc0G51L+F2wkZjG5L7YdJu0RVOoRIjO7tfoJjcq/MEX5hr+tNJ4pHqmUVE+RtegejZI+KQ19CkhvDRwYLZkSZJiulMWikcUn1vS/a2NIQUVBnWxUhA2Q3faX9YvhMfyoYBLYiX7fKpZlcmAnJjCX12dqqRa8NA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <391D6F2D7D21334286B6AD14B1AF2DC0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ed0b38-a0e7-4beb-c3bd-08d5d5f7db86
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2018 15:18:05.7302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA2LTE5IGF0IDE1OjAwICswODAwLCBKaWFuY2hhbyBXYW5nIHdyb3RlOg0K
PiBibGtfcnFfdGltZW91dCBpcyBuZWVkZWQgdG8gbGltaXQgdGhlIG1heCB0aW1lb3V0IHZhbHVl
LCBvdGhlcndpc2UsDQo+IGEgaWRsZSBoY3R4IGNhbm5vdCBiZSBkZWFjdGl2YXRlZCB0aW1lbHkg
aW4gc2hhcmVkLXRhZyBjYXNlLg0KPiANCj4gRml4ZXM6IDEyZjViOTMxIChibGstbXE6IFJlbW92
ZSBnZW5lcmF0aW9uIHNlcWV1bmNlKQ0KPiBTaWduZWQtb2ZmLWJ5OiBKaWFuY2hhbyBXYW5nIDxq
aWFuY2hhby53LndhbmdAb3JhY2xlLmNvbT4NCj4gLS0tDQo+ICBibG9jay9ibGstbXEuYyB8IDIg
Ky0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2Jsay1tcS5jIGIvYmxvY2svYmxrLW1xLmMNCj4gaW5kZXgg
NzBjNjViYi4uY2NlYmU3YiAxMDA2NDQNCj4gLS0tIGEvYmxvY2svYmxrLW1xLmMNCj4gKysrIGIv
YmxvY2svYmxrLW1xLmMNCj4gQEAgLTg2OCw3ICs4NjgsNyBAQCBzdGF0aWMgdm9pZCBibGtfbXFf
dGltZW91dF93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykNCj4gIAlibGtfbXFfcXVldWVf
dGFnX2J1c3lfaXRlcihxLCBibGtfbXFfY2hlY2tfZXhwaXJlZCwgJm5leHQpOw0KPiAgDQo+ICAJ
aWYgKG5leHQgIT0gMCkgew0KPiAtCQltb2RfdGltZXIoJnEtPnRpbWVvdXQsIG5leHQpOw0KPiAr
CQltb2RfdGltZXIoJnEtPnRpbWVvdXQsIGJsa19ycV90aW1lb3V0KHJvdW5kX2ppZmZpZXNfdXAo
bmV4dCkpKTsNCj4gIAl9IGVsc2Ugew0KPiAgCQkvKg0KPiAgCQkgKiBSZXF1ZXN0IHRpbWVvdXRz
IGFyZSBoYW5kbGVkIGFzIGEgZm9yd2FyZCByb2xsaW5nIHRpbWVyLiBJZg0KDQpIZWxsbyBKaWFu
Y2hhbywNCg0KV2hhdCBtYWtlcyB5b3UgdGhpbmsgdGhhdCBpdCB3b3VsZCBiZSBuZWNlc3Nhcnkg
dG8gY2FsbCBibGtfcnFfdGltZW91dCgpIGZyb20NCmJsa19tcV90aW1lb3V0X3dvcmsoKT8gSGF2
ZSB5b3Ugbm90aWNlZCB0aGF0IGJsa19hZGRfdGltZXIoKSBhbHJlYWR5IGNhbGxzIHRoYXQNCmZ1
bmN0aW9uPyBJIHRoaW5rIGl0IGlzIG5vdCBuZWNlc3NhcnkgdG8gY2FsbCBibGtfcnFfdGltZW91
dCgpIGZyb20NCmJsa19tcV90aW1lb3V0X3dvcmsoKSBiZWNhdXNlIGl0IGlzIGd1YXJhbnRlZWQg
aW4gdGhhdCBmdW5jdGlvbiB0aGF0IHRoZSBuZXh0DQp0aW1lb3V0IGlzIGxlc3MgdGhhbiBCTEtf
TUFYX1RJTUVPVVQgamlmZmllcyBpbiB0aGUgZnV0dXJlLg0KDQpCYXJ0Lg0KDQoNCg0K
