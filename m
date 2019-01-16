Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADD8C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4071B20866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="gVyA1qza"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387999AbfAPGhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 01:37:32 -0500
Received: from mail-eopbgr150051.outbound.protection.outlook.com ([40.107.15.51]:61360
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730938AbfAPGhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 01:37:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glWXjt2Boz0T2PuqPsq/DOQD5waxKz7EN+zcvTBi1XA=;
 b=gVyA1qzaDOPHXCMjzBElC7P7KyDNixdSufMUMnhKgcCYZ3762YYVfZnK7ESv6HujeTArFZJlm9fUqeQeyG5p6DjM8P9wpruSVGmWX5Sfv04kS0Wc0N0bJEzAGfh5eZNJ9KODWEnis0flw4opyytfHJ8KAyzl4RN/FHiK+gLsdDA=
Received: from AM6PR03MB4327.eurprd03.prod.outlook.com (20.177.33.25) by
 AM6PR03MB4919.eurprd03.prod.outlook.com (20.178.89.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Wed, 16 Jan 2019 06:37:26 +0000
Received: from AM6PR03MB4327.eurprd03.prod.outlook.com
 ([fe80::844b:fab6:64d8:2f37]) by AM6PR03MB4327.eurprd03.prod.outlook.com
 ([fe80::844b:fab6:64d8:2f37%3]) with mapi id 15.20.1516.019; Wed, 16 Jan 2019
 06:37:26 +0000
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
To:     Gerd Hoffmann <kraxel@redhat.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>
CC:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "daniel.vetter@intel.com" <daniel.vetter@intel.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "noralf@tronnes.org" <noralf@tronnes.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH v2] drm/xen-front: Make shmem backed display buffer
 coherent
Thread-Topic: [PATCH v2] drm/xen-front: Make shmem backed display buffer
 coherent
Thread-Index: AQHUrNs7IxVSN/1nuUaI+Ik1wHznAaWxcBsAgAACEIA=
Date:   Wed, 16 Jan 2019 06:37:26 +0000
Message-ID: <22e0945b-9339-bb71-0eea-0a72cfc1e47f@epam.com>
References: <20190115140420.4652-1-andr2000@gmail.com>
 <20190116063002.jq3aas6ofhaogmyk@sirius.home.kraxel.org>
In-Reply-To: <20190116063002.jq3aas6ofhaogmyk@sirius.home.kraxel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
x-originating-ip: [85.223.209.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR03MB4919;6:FSBlDbV8CZX5rbeYXARcf+7r8whb9ytYeh4wNlo2a4HapvqOqlS+puIZ01nfpHLCCtHgZ9GHltlHxfovKOILBA7D5673ZE4GwpyYJk0NhcRb0oByr8CdqVZN9TUBA+ZAuvjH6CjcSYEZlH9tVapxLMucW3r12QgXxq3rjv+HpwzgmjDFbxkbthkdr4fMB1vabNTNasYp8PMhMCrj5AS1dO09lp01p3pgV2RnGl5fmsiNwMA66JTHCQwywFjDN3xM5omEQgrwaeEW4qf5H+QUSEiMGx5Y82nuYOViGJHukYTugrCL2k/TzPg87kQIRMjsBNykKk+ip/8oK7PbS6ZC0kegMgKfR1u5zAq94uS0rrEarIeverxsBraCERPO7k7c0SxsNzXzWOSP8JGtN0kkpz35oJx/brNs7NwWLiO/wFpH08lFQf82ZTeI3Ctzwnaav6JWgFs8ZYLvfXFLHkqeuw==;5:QmPNVBLjkKPPFNH5mI52YVyTtM/tJCGNXB1bOLfO9iFPAtAGiaH7tB4LV+CEKipR/QfkzA+79l1KUhjjIIku8Zufvbb6b493mccki372e5qykK4rjLyndJW0BUB4yZsrQHxka6hEfFaA9FRw75dlL5RE74Z04R+WN26omuAqpTc5rqBALJIQUBrllNoBiEXdDNrXNNWkm2slYJvk8qBrLA==;7:xIny1RODIu4K6YviJ6G8wCfD0aj5CZD66CFtPDfgcDXMmHYRBA6kcN/nZoI6K8b7P/pfJLy618XdRItVo77m4vAKBaaDAroOv4K6AZwnQjX+MJkyfGiDghowHW6IU3T+nHoLisCWoIpJWTbtdKoOzg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fa86a66e-640e-4875-86ed-08d67b7d146f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR03MB4919;
x-ms-traffictypediagnostic: AM6PR03MB4919:
x-microsoft-antispam-prvs: <AM6PR03MB491905A3FF20B55376DFBB5DE7820@AM6PR03MB4919.eurprd03.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(376002)(366004)(396003)(189003)(199004)(2906002)(26005)(4326008)(68736007)(229853002)(71190400001)(5660300001)(186003)(71200400001)(305945005)(8676002)(106356001)(39060400002)(81156014)(6246003)(25786009)(316002)(105586002)(81166006)(102836004)(7736002)(6486002)(53546011)(6506007)(55236004)(6436002)(486006)(66066001)(80792005)(86362001)(446003)(31696002)(11346002)(97736004)(7416002)(476003)(2616005)(14454004)(36756003)(3846002)(6116002)(72206003)(99286004)(6512007)(256004)(8936002)(53936002)(110136005)(54906003)(478600001)(31686004)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR03MB4919;H:AM6PR03MB4327.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WsrpJbUVAdHrqcLzOxMJqvoTNZXF0hqifcbCZC93LswZmQNlFr1qm2qdriV/sYFIJR27Fshp/mZkDH1Y+azY2ie2hQXlRvk1rcevzriE07M+0kFS/q7ta0s321AUKNBK8JGmaGWR4REhlrVQmhMs/ApV6pkHcz1+iASD1TJ3lHIBtOLwhabfVK+3r36w3MFU7ENGhHC+sVlnxHw+0G+X3G1CJiPw2LzV8OuL9tzsxNbbRr8kr5upvFug8arnPYwNuQQS+73ETfi8OPUgvBqIgbZrqFnkvF3WUilY3BTOW4Z6KTCeOcWgrIJYwUKOHy84mt/uxnN6LdksEg5mOMJgUiz01q9CgHgmfCDtI+Ojkkj/pnDjaMaozM0TggZX8zW4wAI059qMY4Sd4LkpdPB9cJymbNlCBCCKnjat8fNYkhQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF9949537E6CE84CA17CC70F66BE35DD@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa86a66e-640e-4875-86ed-08d67b7d146f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 06:37:26.2534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4919
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8xNi8xOSA4OjMwIEFNLCBHZXJkIEhvZmZtYW5uIHdyb3RlOg0KPiAgICBIaSwNCj4NCj4+
ICsJaWYgKCFkbWFfbWFwX3NnKGRldi0+ZGV2LCB4ZW5fb2JqLT5zZ3QtPnNnbCwgeGVuX29iai0+
c2d0LT5uZW50cywNCj4+ICsJCQlETUFfQklESVJFQ1RJT05BTCkpIHsNCj4+ICsJCXJldCA9IC1F
RkFVTFQ7DQo+PiArCQlnb3RvIGZhaWxfZnJlZV9zZ3Q7DQo+PiArCX0NCj4gSG1tLCBzbyBpdCBz
ZWVtcyB0aGUgYXJtIGd1eXMgY291bGQgbm90IGNvbWUgdXAgd2l0aCBhIHN1Z2dlc3Rpb24gaG93
IHRvDQo+IHNvbHZlIHRoYXQgb25lIGluIGEgYmV0dGVyIHdheS4gIE9rLCBsZXRzIGdvIHdpdGgg
dGhpcyB0aGVuLg0KPg0KPiBCdXQgZGlkbid0IHdlIGFncmVlIHRoYXQgdGhpcyBkZXNlcnZlcyBh
IGNvbW1lbnQgZXhtcGxhaW5pbmcgdGhlIHB1cnBvc2UNCj4gb2YgdGhlIGRtYV9tYXBfc2coKSBj
YWxsIGlzIHRvIGZsdXNoIGNhY2hlcyBhbmQgdGhhdCB0aGVyZSBpcyBubyBhY3R1YWwNCj4gRE1B
IGhhcHBlbmluZyBoZXJlPw0KTXkgYmFkLCB3aWxsIGFkZCB0aGUgY29tbWVudA0KPiBjaGVlcnMs
DQo+ICAgIEdlcmQNCj4NClRoYW5rIHlvdSwNCk9sZWtzYW5kcg==
