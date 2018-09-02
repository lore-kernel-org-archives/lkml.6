Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06EBC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0B9204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="omShygUs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A0B9204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbeIBRXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:23:40 -0400
Received: from mail-dm3nam03on0093.outbound.protection.outlook.com ([104.47.41.93]:1728
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726600AbeIBRXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxX/6nQLvhYqCaCH2U68siJNahrRJpdDEAbBY3RrQuo=;
 b=omShygUsUVfvclZH0/+e8TJDmbEgeRper+gmkGXpxvX5yK/Qt8ncHNkuI0wVEFjiCl/CbBFyDNn0aQHt9Oo7RtOMpanjm+Qs1L7VA6h+JizkmpE9gSXJtmQ++vHjiRgHN5HuDyQsjacSmE+gwLleW/u174UPNcV1QwHpUxJ0Wug=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:07:50 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:50 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     John Pittman <jpittman@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 64/89] dm cache: only allow a single io_mode
 cache feature to be requested
Thread-Topic: [PATCH AUTOSEL 4.14 64/89] dm cache: only allow a single io_mode
 cache feature to be requested
Thread-Index: AQHUQr3mNraEJlMe5kaSMae3o9eMuw==
Date:   Sun, 2 Sep 2018 13:07:28 +0000
Message-ID: <20180902064918.183387-64-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0149;6:gjLtj7wmNLIEyX5yi8TF84018G4L3pacHhdEwPuJ+U8b6xayPYX3H7nA0s1g5OFGuj7ghk9G40ArYzMnWd9CydvQyZn4dSuutjUMrXywDcPb3KjQLoJrhrIRU86U5mH/Q05vUsD0oLzZFqx1AivVfviYFkaPU2hLBQ59AHazIzWwzdQb5EBsEzVlkLAcT42jLy3+GMpEqvB+zS9BEajdXorkYQrI99NeICn+svcWX0Mm/I5YTOCQRd9RPjl375af2Df6ss8B49IEYHw+ypO6noSThmbaY/VkTRJuB9eBi+ljiTZghWf29AhBVFup4TO+8ffFaGgQKLq5ZpbVBKaC9RTDPusGV0Gp9Z1abK6GCxX8n8pCCt+nRrrjZPIMBscIKwrAqnfRB6kf6mf6bcAJWbCdW2ihiMLbwfV7kcLTJglzn440eHK7pOXz70/A/QiYW2lzcfv+d7p6C8GxNLmUsA==;5:AkWoKfLarTF22JKlwVq+Yb7c1w9V46t/72RaS//a0DaTP042l7lmsZMLTCkSG9gCY1QDvNkFKIHyp5Q1HqRhOqvqRvHwTggUjHrNdFfuntdgDUcsDpkFP72GjUsvB8BKnvzIKFp/8mV9BcZq8zSy6C29Ws7kb78c4x1ry1r/z/k=;7:AHto+AcPr95arIioik5Y+rF36ooEbTR859p+ra3mmO53jhUd5pABshFWcYDIeMtPTqOMAO7vLeK8ZLZDjTj4MryRr9qrNHljEPyDNsATpgDNIXeNWLwjqEzCuhc2mHXOtSSLa0IAEDf11cVSAOcFoRXtAyL/zc7lWHZPOhzooIgGhEDlYxjVd6EsmzPKfPpOeZXa3DfZk4WxQf0hpwqmHaUMRKNfFTptRlG3Q4PL/Qo/mDyFFZQ7lPn6Wj04eD5g
x-ms-office365-filtering-correlation-id: 79b5a762-26f7-465a-1a50-08d610d515ee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01490463BF7CABF09A0A4641FB0D0@CY4PR21MB0149.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0149;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0149;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(199004)(189003)(76176011)(6116002)(446003)(11346002)(3846002)(5660300001)(110136005)(54906003)(102836004)(26005)(22452003)(316002)(99286004)(6506007)(186003)(6666003)(107886003)(25786009)(1076002)(4326008)(305945005)(2501003)(7736002)(66066001)(97736004)(10090500001)(68736007)(5250100002)(8676002)(81156014)(81166006)(6486002)(6512007)(6436002)(2906002)(53936002)(256004)(217873002)(36756003)(575784001)(86362001)(10290500003)(105586002)(106356001)(72206003)(14454004)(478600001)(2616005)(476003)(486006)(2900100001)(8936002)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: T0A+aj84tmVaiRTzTZhuoD3xy9x4tYunwD80t8qAem0ai88DEzE4t9VQsJKY5mCGsXt/0u9P2+slPutrOd5AooADcUW2+allwSd2SMF+cQL0Ngh5XG7QGFNkKR0c0+7zVIwnMj3GDWwjsjYd4UeflW16POTXpKrMZjvSn4QroCFNlmu0Mjuy6otiT0dP5ubCmafKSPY2F4yJ4TN2FL94R1hL8HJyEro8dRam1hKoVrnSMxQlNGJV5xvBM3rVRMa420CQMBa7YqCdbKV5epl+DVQdMb3jl9Ese/XQGBPPC2yiV4sZmNB/MIpuk9CEC8dndHFkOBrzj1OzKucCLNxl1YW877K6DtaMHDomuQd0lyA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b5a762-26f7-465a-1a50-08d610d515ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:28.4567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Pittman <jpittman@redhat.com>

[ Upstream commit af9313c32c0fa2a0ac3b113669273833d60cc9de ]

More than one io_mode feature can be requested when creating a dm cache
device (as is: last one wins).  The io_mode selections are incompatible
with one another, we should force them to be selected exclusively.  Add
a counter to check for more than one io_mode selection.

Fixes: 629d0a8a1a10 ("dm cache metadata: add "metadata2" feature")
Signed-off-by: John Pittman <jpittman@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/md/dm-cache-target.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index 71c3507df9a0..a4b7c2698096 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -2330,7 +2330,7 @@ static int parse_features(struct cache_args *ca, stru=
ct dm_arg_set *as,
 		{0, 2, "Invalid number of cache feature arguments"},
 	};
=20
-	int r;
+	int r, mode_ctr =3D 0;
 	unsigned argc;
 	const char *arg;
 	struct cache_features *cf =3D &ca->features;
@@ -2344,14 +2344,20 @@ static int parse_features(struct cache_args *ca, st=
ruct dm_arg_set *as,
 	while (argc--) {
 		arg =3D dm_shift_arg(as);
=20
-		if (!strcasecmp(arg, "writeback"))
+		if (!strcasecmp(arg, "writeback")) {
 			cf->io_mode =3D CM_IO_WRITEBACK;
+			mode_ctr++;
+		}
=20
-		else if (!strcasecmp(arg, "writethrough"))
+		else if (!strcasecmp(arg, "writethrough")) {
 			cf->io_mode =3D CM_IO_WRITETHROUGH;
+			mode_ctr++;
+		}
=20
-		else if (!strcasecmp(arg, "passthrough"))
+		else if (!strcasecmp(arg, "passthrough")) {
 			cf->io_mode =3D CM_IO_PASSTHROUGH;
+			mode_ctr++;
+		}
=20
 		else if (!strcasecmp(arg, "metadata2"))
 			cf->metadata_version =3D 2;
@@ -2362,6 +2368,11 @@ static int parse_features(struct cache_args *ca, str=
uct dm_arg_set *as,
 		}
 	}
=20
+	if (mode_ctr > 1) {
+		*error =3D "Duplicate cache io_mode features requested";
+		return -EINVAL;
+	}
+
 	return 0;
 }
=20
--=20
2.17.1
