Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D36C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C778C20857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GN3487qi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C778C20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbeIGFQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:16:27 -0400
Received: from mail-by2nam01on0136.outbound.protection.outlook.com ([104.47.34.136]:26290
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729775AbeIGFQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQjoXOY//6prDp8ynRZ/elrDrrSp8BCInT5ge7AkeZI=;
 b=GN3487qiA8uvRBj0nT5onmJV9OKp5pHo/a2kN9jFDvVFT7VjntcPHgmjQbSsve1Z7m59yrlK2LN6DrzxNXSyKC95un9CJk+Wh85K4N6qojuXvslYvvXknhtE3z8N5VL7t7khyCkPKvDCk5i5YTZw3HYYeWIL/tNKqdlbULhVsqU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1143.1; Fri, 7 Sep 2018 00:38:18 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:38:18 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Krzysztof Ha?asa <khalasa@piap.pl>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 16/67] media: tw686x: Fix oops on buffer alloc
 failure
Thread-Topic: [PATCH AUTOSEL 4.14 16/67] media: tw686x: Fix oops on buffer
 alloc failure
Thread-Index: AQHURkL28eHMURHKnkuGUJaT3pergg==
Date:   Fri, 7 Sep 2018 00:37:31 +0000
Message-ID: <20180907003716.57737-16-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:kkE7i+2r6neXA5nUbV9Ni/nEuwU3Qj3dONlAypu4Ss1/i+Uky6oqf1G+XlOY24oQVFYI3zJsmNsz3d6A+9mDSuCYy2RdUEFNuF92FiRtQkb5AwbXMB6TJlPjkROJMAO97dKWr78Qscs9Py1F1xwJUHC81pHhS8O+4+6PpBy0NstOKR1K/plrt3mO7L4TzMR7lm62ORQcZmDJOT7j9BinqU+p3tJg1W2LU7srCXYrrjom+nqq40M/175zuB8oMVoLrscBVKeQ67GBkeE+Xh2yE8DRwHyPJQKlOk5tOmbcQ75cjWZlO783HuyTE0bZqbtHvMcJjmQLv7Twj85d1JlPoHh/MA8z9Sbhyp0vpWgqHlPtgWe3Sfl1TIGN4BBzdYnLFxmxvO7Mks2BYp8hz4TEn8DDLCRmi5O7RoxNtkbQ6zy1W44ma6MKZeCdWH+tKBfGzDR/E+J2YGUtcyJjzlly+A==;5:lthgaOH49bDeTwge6aIwl5auqX97LOxDD9i4oi2mcAhuHgQUMpo72Vf9OTTDm6cizXow9r5VYwovBmxP0x14GinAtM5RcdJ75019aVLev+3J6CkxFqNMt3dKK5pXKGU6aQZ2yrAVgJjbrDTpR6Yw+E8HTgauhW1wC5CrWyBvb3c=;7:E168doiNZm0vbVn2x5vTmkPqBPTejUenF1PfIl/AxIoxULJh8gvDUxQrs8to53JnaIbCmabqjY4iSdhpjB1hYNQl+4hGWgJNiVusY6LYRVar79rCUABAuaNawtBFxQwftiGjA2T9RJUCzuzmYDp3cGjgZh8XbJuC4f2PVvtTYj53s0QAGJchIZ1s1HHfSTAVP3VU2IZjiEA7svbL009ZH+5L9oO380HCskKVnP5t3s/xr3w2fw0fpIjCkCrluMxz
x-ms-office365-filtering-correlation-id: efabe515-44cc-4b84-1ec4-08d6145a349e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB07570F69238608CBAC524001FB000@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(95692535739014);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(8936002)(3846002)(81166006)(86612001)(6666003)(5250100002)(81156014)(486006)(99286004)(6486002)(106356001)(10290500003)(107886003)(256004)(14444005)(26005)(11346002)(14454004)(446003)(76176011)(6346003)(5660300001)(10090500001)(110136005)(2616005)(66066001)(186003)(476003)(72206003)(2501003)(54906003)(575784001)(316002)(6436002)(86362001)(97736004)(53936002)(22452003)(6506007)(102836004)(8676002)(6512007)(2900100001)(68736007)(305945005)(7736002)(217873002)(6116002)(1076002)(25786009)(2906002)(36756003)(4326008)(105586002)(478600001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: NaBGPwoR5Cqy4mu9NVOJcrNBXykKrihVIQc76+d40vs0IFhC/isvCvwdczMm5UvSKCmKEYhBR7M2NUq6zlfn5CGppsvWW0/9BLFGn33Coh7YE4MyyirrLHwNN9+A7IpYU5hKkojCGGbGFyFLD1asoHyJPtsoOIXmJF14peyyuTgL3ruq9/mLzc8CrTdlWeUuWR/ixrE6JwHFouPSnXvOPbvV/6M0uuhIlVqBxgTB6b5GzN87d4UD0ScQxPNFEfXNHfk7UzqXpjbfd7hDz5KQH5wVaKxolxbki5G2YT8vb9XvKymIOcBx+tdhLo0g5MMIAdFeFmiWjRjhA/9x7eZnZMMzN/M5P6V88wvI+x+XziQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efabe515-44cc-4b84-1ec4-08d6145a349e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:31.4820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Ha?asa <khalasa@piap.pl>

[ Upstream commit 5a1a2f63d840dc2631505b607e11ff65ac1b7d3c ]

The error path currently calls tw686x_video_free() which requires
vc->dev to be initialized, causing a NULL dereference on uninitizalized
channels.

Fix this by setting the vc->dev fields for all the channels first.

Fixes: f8afaa8dbc0d ("[media] tw686x: Introduce an interface to support mul=
tiple DMA modes")

Signed-off-by: Krzysztof Ha?asa <khalasa@piap.pl>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/pci/tw686x/tw686x-video.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/media/pci/tw686x/tw686x-video.c b/drivers/media/pci/tw=
686x/tw686x-video.c
index 0ea8dd44026c..3a06c000f97b 100644
--- a/drivers/media/pci/tw686x/tw686x-video.c
+++ b/drivers/media/pci/tw686x/tw686x-video.c
@@ -1190,6 +1190,14 @@ int tw686x_video_init(struct tw686x_dev *dev)
 			return err;
 	}
=20
+	/* Initialize vc->dev and vc->ch for the error path */
+	for (ch =3D 0; ch < max_channels(dev); ch++) {
+		struct tw686x_video_channel *vc =3D &dev->video_channels[ch];
+
+		vc->dev =3D dev;
+		vc->ch =3D ch;
+	}
+
 	for (ch =3D 0; ch < max_channels(dev); ch++) {
 		struct tw686x_video_channel *vc =3D &dev->video_channels[ch];
 		struct video_device *vdev;
@@ -1198,9 +1206,6 @@ int tw686x_video_init(struct tw686x_dev *dev)
 		spin_lock_init(&vc->qlock);
 		INIT_LIST_HEAD(&vc->vidq_queued);
=20
-		vc->dev =3D dev;
-		vc->ch =3D ch;
-
 		/* default settings */
 		err =3D tw686x_set_standard(vc, V4L2_STD_NTSC);
 		if (err)
--=20
2.17.1
