Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BD4C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC372083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Mn6oDVwl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC372083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbeIGFPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:15:02 -0400
Received: from mail-sn1nam01on0092.outbound.protection.outlook.com ([104.47.32.92]:36128
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728695AbeIGFPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMJtrsU+fksfKHnlx8+T5HJCSMMALZCJumi2CDZZmbs=;
 b=Mn6oDVwlgv5yPa7Hry/I2inVN62f/g06Bdkho9IIx+SqPN6pfyyReQpg7ZlHrqrYbH+QWjSnpaGXEq+48/cno3OtYB1npPFUNOl+NiXoZRk0lsbGfHBWnNTCmtOXHotIFvGLgYly++p1YVyDUFQjnmtj+lD+V+QjDPpoD3zafqc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0824.namprd21.prod.outlook.com (10.173.192.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:36:12 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:12 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mike Snitzer <snitzer@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 29/88] block: allow max_discard_segments to be
 stacked
Thread-Topic: [PATCH AUTOSEL 4.18 29/88] block: allow max_discard_segments to
 be stacked
Thread-Index: AQHURkLH6CCx4fMaJUqx8rljImC5sA==
Date:   Fri, 7 Sep 2018 00:36:12 +0000
Message-ID: <20180907003547.57567-29-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0824;6:AdKrEi7fqK/tx4D8cwhQ7v9njl7i9YCDhPpDhA8txoSyvkM9sUdWy2CeBDG73TUmLqloRFzSij5D2HE/vD9RuSS7n0OaXNBIdZHj4T3zQhLsINGy2uEVuAF5/Z/4FyqYsBlBuoCr+W7dDPh0gyaFlNDjxcZShtZhzY3kQllJqdCYqdrse5Hneub/ygAudIj8zMgLq5gchJFbDKkhw0DOeTyNnX500SHD3N+F9v5sabMOeuDARCqjPGY1n9dZD/n5VlLUE3qlQnZziOg1fY9a+OuXbzhF1DjolIKO32fvQd46HywsCqvztE2ZbUE3Gs0KnxDDxdP6ESLaOIvYZalizhIDkGWfVwe8OfHf9B7ESW8J5Z9am4a+ei2BgKw6M/sVEcOvv+LDGtaJ0TDw71eBVTJWt3TXGvBDEM6pjNLWZ7y0LT++gakU/cdMY5vMBTXOJyux+BXpdy94xinkxnZWEA==;5:zq+mdcYaSpP36fa5m+hReHZTOJJh9nNjKUXdeMDfZBaBoBHjUS3qreid5W0Ou2gBX6QJ8/kM8c3XKIPDSkbSHz4ojIrwu78h2wsFBE46lJnlVY+LP7Wc0p3e0ZFSXfJ8nglAEQxd5n3cEP7QOZvW9w77Qqt7u7/uvsRfZSFqUUY=;7:j7trz9fCDZHTxxeShwkNRV77OZNt4BA9e6dH2Ps22oJpvTm4I+GEigncGptj17C4MqMydeme+FZm8/KJbtkWO5W97/NGIiz51Lk2cPcwOaRtoPek561EOheyuZVO92tXCB9UE13XJH5p/obKDq0sSQfL8LDT1DSmnSUEetYvEI8XgHbf6uodihimM8P9LZdIdcwEiGCJplvnmiHv46EOZ+xr8UI7ASCAshEnOZupCNQJwueHbLMTmVVPQRpwRSf5
x-ms-office365-filtering-correlation-id: 4c741d40-50ca-4bda-b2c9-08d61459e9ce
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0824;
x-ms-traffictypediagnostic: CY4PR21MB0824:
x-microsoft-antispam-prvs: <CY4PR21MB08243372EC1F63E2344198E2FB000@CY4PR21MB0824.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0824;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0824;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(376002)(346002)(136003)(199004)(189003)(22452003)(14444005)(256004)(102836004)(6506007)(217873002)(10290500003)(186003)(26005)(5660300001)(4326008)(6346003)(81156014)(81166006)(110136005)(54906003)(72206003)(316002)(575784001)(1076002)(6116002)(3846002)(8936002)(107886003)(14454004)(86612001)(2900100001)(105586002)(106356001)(5250100002)(86362001)(76176011)(2501003)(53936002)(10090500001)(68736007)(66066001)(36756003)(6436002)(99286004)(6512007)(486006)(25786009)(2906002)(6486002)(478600001)(7736002)(305945005)(2616005)(476003)(11346002)(97736004)(8676002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0824;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Sp7LGgTbuqx+3O9GJnwm6enZmcSVykjDHLKhnlBWIhL52X8Hcm68g1SuYSnVfxolmsrGlmkSxH0vWXGYTHl4a+pCZCISTbUBGRP1polZZGrGJ6khemZjvLuYaTIgu+jhKwYO6irkGuZkNZVxwSdSVMeCSkpgrE5dbUM4OzFnfa6i6sBjYmRoXyB6Uy0q4vKvvvpTqQxJZA2HVMTambg+DRJdFZp7ksN7bLe+86jP3zIwWEcqEfzqGVCuMk35XNdzh/TWQlHSMhuINFJ9J4+GXi8OAaxt5OrMOVGfisHvUbvpP8FsLWo/k2tp60x3wBup9uM+rH6LnWlEE6mSdewWAU5I3YNgYf67bD9OcFi/l6o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c741d40-50ca-4bda-b2c9-08d61459e9ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:12.5485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Snitzer <snitzer@redhat.com>

[ Upstream commit 42c9cdfe1e11e083dceb0f0c4977b758cf7403b9 ]

Set max_discard_segments to USHRT_MAX in blk_set_stacking_limits() so
that blk_stack_limits() can stack up this limit for stacked devices.

before:

$ cat /sys/block/nvme0n1/queue/max_discard_segments
256
$ cat /sys/block/dm-0/queue/max_discard_segments
1

after:

$ cat /sys/block/nvme0n1/queue/max_discard_segments
256
$ cat /sys/block/dm-0/queue/max_discard_segments
256

Fixes: 1e739730c5b9e ("block: optionally merge discontiguous discard bios i=
nto a single request")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 block/blk-settings.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index d1de71124656..24fff4a3d08a 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -128,7 +128,7 @@ void blk_set_stacking_limits(struct queue_limits *lim)
=20
 	/* Inherit limits from component devices */
 	lim->max_segments =3D USHRT_MAX;
-	lim->max_discard_segments =3D 1;
+	lim->max_discard_segments =3D USHRT_MAX;
 	lim->max_hw_sectors =3D UINT_MAX;
 	lim->max_segment_size =3D UINT_MAX;
 	lim->max_sectors =3D UINT_MAX;
--=20
2.17.1
