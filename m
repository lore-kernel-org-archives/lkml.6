Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3CAC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44282083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="c16E97MY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44282083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbeIGFQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:16:32 -0400
Received: from mail-cys01nam02on0116.outbound.protection.outlook.com ([104.47.37.116]:29216
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729799AbeIGFQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zF8lgYjMb4foGgmGwGpqZ8NARkjOPaaAzy0jD3NTYA=;
 b=c16E97MYlS7oW+5FI1SdY8fEWapXtS0MU073V6lxp62jzKH/X321JGlkKql48rybaKWJUGl7fWPEbayywPDjjbqGfWhxw2cmNTsVYwCEDMGZ2tGX1aqdSLzBlEQfy6jeFedIWGaWAE6zeXxM4+MpmCtTMB29SBLoPfwvT/2Y3fM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0840.namprd21.prod.outlook.com (10.173.192.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:38:20 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:38:20 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mike Snitzer <snitzer@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 21/67] block: allow max_discard_segments to be
 stacked
Thread-Topic: [PATCH AUTOSEL 4.14 21/67] block: allow max_discard_segments to
 be stacked
Thread-Index: AQHURkL45/ewZgaTykiXqZUvCFCeJw==
Date:   Fri, 7 Sep 2018 00:37:34 +0000
Message-ID: <20180907003716.57737-21-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0840;6:xom9JgOaMNzmQFUXpa0yj82WCeAghalKmfk02UR73A4HlTs8VqxQie4uL0ix3dZ9l/93a0P9O25OC8GFa6t2RUMIZGpFHd0v2I4AGVO0v7abYuVRFxhifeG3l6rAhm7ZLZCX2c30MPuuipKtKma6ZqsAzG/iymDVDOVb5NxS2/aV5mhpTlHksh9Lrm8lA9Js7khl5By+JTNoh4tn1p9Ogb1zLzuyCkASp1TWM+SNebyUSfxeZ39DincMoJHPj7fm8mGH4NZp9zC0QSMZYSAeAzCStRBjybFjsO0G15IRZbLez4I90RJ4ZiJeL5JGzdpCASYYBMGU8SIyU9nMdoMcms2GzzIW3djHgc+vNGASMEX2uyTvl4XO6uUIvmGUF08dEgoDuaWCr41zxASm/N3CECibbU2NXcAJYgtbc6GdkRjla4KJjQUd5jOrTNv1jJfOCvYzwwADcJX3jj/gSv2ZQg==;5:mIMfXyTgKGlhbfnCRJy256eoLHyWRn7F5sqcbX49Xe67klVm8qN4pa7wqoHTYR5qZ0l4G9+CG10n/d3QGwZWLG6IsYjezFYEIZBCBspjY5+OUsZ1eeSoC/fU3gfd2AOQYp6RZfp3awqgZWcX1Ruzt9a8JL+QKXp0Ds0Xk9EeYzE=;7:JuCztvHYRz3HmickfUbiLL/fpXywMsO3VTFwwNNh5HCyeGJYWuwvP4XSwVxgRSXkjhDdF8mF3DjoYL9smCNLqiv3IyXeKk0aWFq4yt1aM0wKIjjHruaTNzUDPExhJpEV43BcFYanI2nFh8nMO5/Lw+ph/+5BkZx66TJT4BlVMP4pj1ISUCkCnSgv4wAKgF0QYT/p8nSFP0kpKQxTvPs5qQpSnsuj3qDrra9Gz/Niwg54CXWJRd/66GiAxIghRH3g
x-ms-office365-filtering-correlation-id: 61a8239d-f283-4b5f-923d-08d6145a35d4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0840;
x-ms-traffictypediagnostic: CY4PR21MB0840:
x-microsoft-antispam-prvs: <CY4PR21MB084081F4ED3A5847E173A4A8FB000@CY4PR21MB0840.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0840;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0840;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(39860400002)(396003)(136003)(189003)(199004)(66066001)(186003)(99286004)(26005)(8936002)(76176011)(102836004)(81166006)(81156014)(5250100002)(54906003)(6506007)(110136005)(11346002)(446003)(316002)(476003)(2616005)(106356001)(6486002)(86362001)(575784001)(6436002)(105586002)(86612001)(97736004)(486006)(6346003)(53936002)(6512007)(68736007)(10090500001)(2501003)(1076002)(22452003)(6116002)(3846002)(36756003)(4326008)(8676002)(10290500003)(2900100001)(25786009)(256004)(14444005)(305945005)(72206003)(7736002)(478600001)(14454004)(217873002)(6666003)(5660300001)(107886003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0840;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 9w73AfykbjOwJZAWH5H8SBoaMs+t4Z2S8J93myvOV5zHJ3a1yBanoHfCnNWSTfRzGClC2tfJqjbU5k2z9buVogEJJ07un5dJii7gvpbUg7TT5NXiiWbWAD/bjCpkjfIfhHW4j6Sy3z5BITY4xQAgpxWrhLyap21+sF3/b9YlehN5ppiSdPSoSadZBm8zajk52qA4AOpQJLpmNn82OccNH/RnpZWbvQcqJVS6Q7eHc32UI4e9oQZtbnE0DFFcOIRW4z5ASvduBXcVH/10K+QdNfuL2str/bY7EDQ78xIxaE5Qq3UhmO2nRUC6n9rmMcICxOOoQTIIg00fw1cUtq3nxKhlm2GW5diy+157ZsSc4j4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a8239d-f283-4b5f-923d-08d6145a35d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:34.7924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0840
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
index 8559e9563c52..474b0b95fcd1 100644
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
