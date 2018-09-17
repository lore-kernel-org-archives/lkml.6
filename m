Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A72ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FAC720693
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OpMe7Lre"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FAC720693
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731412AbeIQIjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:39:37 -0400
Received: from mail-cys01nam02on0108.outbound.protection.outlook.com ([104.47.37.108]:42432
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728659AbeIQIbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krSp91guLnpdgglR1/YhkV5wKEu3jaWtR0gNBxtrNlc=;
 b=OpMe7LrejP5a+Ac8FJM3l+GiX/WuETNYJdxM+yND0+KjeJZKl/9M4v6l4rGhG6Z9h9Ik3MMU6DDu4EvAlLh9fE5KO6PPdgm5C55Y06fNPamV79fc+kf6lKp6g4QK4hyDT5bbz1WO3P5Rmg9rLQdYEOFo5eL0Fb9gcGum37NZXKw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0742.namprd21.prod.outlook.com (10.173.189.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Mon, 17 Sep 2018 03:06:21 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:06:21 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 42/57] drm/sun4i: Fix releasing node when
 enumerating enpoints
Thread-Topic: [PATCH AUTOSEL 4.9 42/57] drm/sun4i: Fix releasing node when
 enumerating enpoints
Thread-Index: AQHUTjMaUgv+uAGaekWi/vZxYsk8cA==
Date:   Mon, 17 Sep 2018 03:04:09 +0000
Message-ID: <20180917030340.378-42-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0742;6:08CW3nCZ8BauBi+Ek7A5sbfsTobDkZdEg0l2UunQ7pDNKVZ4vA2CbsdHeIO8cavi/VOE1pjtpCv9EmwrHUQm/HZPSBo+gc0c8FUl+k9h5nMll1vJ4sWaIbEBSeJyPta+LWe7Q5V0wSikMAcDsaB+2uZjoANvnZiagXLU6qO+Tjve8zNWI9ZOEopvMCkIOhDuZ/WcfzduOTGl6mRkfPV0mZTcWwDtAduJu7sAzB8gb1e0y9cq41QyBlwr/SJJ8WFix7zI2WqUfU2RhHM7RIo9R/CDzrngPcu/sgGMSMOr46SVXHuJG/lBEXQnARlb5aFZyDDBNqecMgOhCLeTbmc1EvHhOGcaXkUiTkRabm8UM1qkcVk7Z1pUtdJsh6OoU5JPPWRvTSWkO1WGJ6iyiMYYG/hyPhIJQ8kJPbF6fkpVC+VVwMLpIbSBqO9NetNcuiPW2ASgZrtuqo5om2X6nEiYBQ==;5:ZenkdJGKwfDcCWEPOcTv8Zp+toEiYzMeJi3aXvGwn8SFecc/4usBnZAkUtS40jgqcdZcj5sPeS4h7wD7hCcfIVU3nL9k+TPX+gDBXs2j3lW9A4mrRe3FRmQCXO7DjBH4pOq/h/7z0QJUSVDQnKvXKT04lDiUehL5lfX9giX7+7E=;7:UL1aqfKMfUqMoeXVf3i6Lz7g1gWm07ZRyNqLkgxlhuRDszNFfcGRW47kFvMaQzxh3AoMHXLkpFFTebYpFbfYBstAL8b3Pzd1KUuqnR30N8HetKsludpYJouGAaDvtfDQXkJPKN4qad9Ytc55JZZHtKPbw5wNsPhjWyrYTBOdfIe5tvsdIplh1u2LZm/HF9J9w9/xLVGp7o+XzQNa3vbZ5noG6Rkt0hXS6pCspxqq+mrpateeOVrNEmCTwdIZHGEn
x-ms-office365-filtering-correlation-id: 68c93514-bf1b-4063-0230-08d61c4a8bb0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0742;
x-ms-traffictypediagnostic: CY4PR21MB0742:
x-microsoft-antispam-prvs: <CY4PR21MB07420DF9D279C307660416AFFB1E0@CY4PR21MB0742.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0742;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0742;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(366004)(396003)(376002)(199004)(189003)(6486002)(6436002)(6512007)(6306002)(53936002)(4326008)(3846002)(217873002)(25786009)(2616005)(1076002)(14444005)(6506007)(186003)(6346003)(11346002)(446003)(26005)(2900100001)(6116002)(486006)(102836004)(256004)(107886003)(476003)(86612001)(575784001)(86362001)(2501003)(14454004)(97736004)(66066001)(76176011)(6666003)(316002)(54906003)(110136005)(99286004)(68736007)(10090500001)(22452003)(81156014)(2906002)(36756003)(8676002)(8936002)(81166006)(7736002)(305945005)(105586002)(5660300001)(106356001)(10290500003)(478600001)(966005)(72206003)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0742;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: P8jAMPytMzYsqySuU+SF+uA+/8WBB9c/7IbvJvfrikhBP7B8p8tmavMSI9RiUkYUNenNaNz3SgqEfHYt8VrAmkI8oxJVvb+le4l/g+/XTK287mCabAbL0+zTHoMMGvPnoYXq7uSEmRgSTx+uu2UidQN5Ojgokh1NG6LjJwcrPSh1r5/+3tzI+MMUS64me2oeE9bGlOqkyUD9yCFTPJV2HxUDdm2J4NSJyXQO/0/WfJbx4FAt1fo4Rl9UjCGWDjrIUCZ9EOYmOMISf46cltnWjltvW/Xa+BqDL5s5KEYJUnfXOr2Esg5DQ+XdtkPpEiAZWlgu6C2DN+Ggd4IeorBoSNVAdTJmj/9NlthoZa8XGRE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c93514-bf1b-4063-0230-08d61c4a8bb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:09.0552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0742
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

[ Upstream commit 367c359aa8637b15ee8df6335c5a29b7623966ec ]

sun4i_drv_add_endpoints() has a memory leak since it uses of_node_put()
when remote is equal to NULL and does nothing when remote has a valid
pointer.

Invert the logic to fix memory leak.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180625120304.7543-7-j=
ernej.skrabec@siol.net
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4=
i_drv.c
index aad2f4a2a0ef..97828faf2a1f 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -283,7 +283,6 @@ static int sun4i_drv_add_endpoints(struct device *dev,
 		remote =3D of_graph_get_remote_port_parent(ep);
 		if (!remote) {
 			DRM_DEBUG_DRIVER("Error retrieving the output node\n");
-			of_node_put(remote);
 			continue;
 		}
=20
@@ -297,11 +296,13 @@ static int sun4i_drv_add_endpoints(struct device *dev=
,
=20
 			if (of_graph_parse_endpoint(ep, &endpoint)) {
 				DRM_DEBUG_DRIVER("Couldn't parse endpoint\n");
+				of_node_put(remote);
 				continue;
 			}
=20
 			if (!endpoint.id) {
 				DRM_DEBUG_DRIVER("Endpoint is our panel... skipping\n");
+				of_node_put(remote);
 				continue;
 			}
 		}
--=20
2.17.1
