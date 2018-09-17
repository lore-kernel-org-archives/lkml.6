Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C340ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67C2208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="g5dsMyTe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D67C2208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbeIQIaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:30:16 -0400
Received: from mail-dm3nam03on0114.outbound.protection.outlook.com ([104.47.41.114]:30720
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728385AbeIQIaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yDPDeyU/tMucBDUMybsbzhbbRhJfJ7t0tbUZyoNVJY=;
 b=g5dsMyTeH8/UtM8A0ttH5MwuHWtyVO7uk+cMLCvzREx8Jer6NSzoW2Pf/LhKHDbvlRA7P/43J92K3BK+PKomzTNwDDWivsM7ZdVSVgDi6Tl9fm1dNbadIkCW+wCXMg/bLiikI2KHBH3DngNIDf6XcMdx4V/i7iis4IZCGaQn3FI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0774.namprd21.prod.outlook.com (10.173.192.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Mon, 17 Sep 2018 03:04:55 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:55 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 63/87] drm/sun4i: Fix releasing node when
 enumerating enpoints
Thread-Topic: [PATCH AUTOSEL 4.14 63/87] drm/sun4i: Fix releasing node when
 enumerating enpoints
Thread-Index: AQHUTjLzRcA6KcwZw0CFeDL3Zu40XA==
Date:   Mon, 17 Sep 2018 03:03:04 +0000
Message-ID: <20180917030220.245686-63-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0774;6:1qv8YBXeg9SGK5ZlneGVOHj5EePoWIoJFiPhaBUiq7Jx8eSP1cdPCLdIP3ai3Ik/I2ExT2HoiUaYJVc9rp4UbEDgIU0l8wczDZfxtHS84h1SdkBeBbMT/bMPmOQsH+qq9az9j2lkODU6MX5fF0emWVY8dfbhFcDy2QmiwXr6/pO07tgU9zoXYvztc5N4qG5EmVs1Hxo1IIbvbtQTkwXQTAp8DfGcYA1ck+vO5emvwQHBT+A7vOk5R9aW1EOjnp55TpajWT8R6O4xoKJ8XZnJ8IU5hOWztwS7yOKtTw7pJ+wvsZjY8tgc62UJsLz2ghmEaF6KjPQYzfhBt3+Os3haXsRp7VuJ+UvQFEyskfkRkfS2wtDR270vtVL3O8sYa+uJhUMA+wOAg3uwjlxhcgdx0Pn5Rp4EGeGwUEN66elHQNFFQEl2ABK7jD+sEBKO3wdVpVIDNgPsbcsTj87GhdK5Cw==;5:Brb+G9dVRISGwNA+okGgEXNKd6nzd1/L3TZp44zAXMYSZCoZSrO8CUzDddQezmMXhHwsWfMEz9pfSOTZY3/lZn1ebMyFXCbrUJB4c19f6xZipmSXFJk1itvf33DEitO3cQgHxB/gDm8XIzsJZYFF0yoUUsOYUYXg3W9KLxzM9Bg=;7:9xAC+UqtQVENrCldk3Qm8WsQnTtlikwCDpjgrGxrC9b9r5OJ0hKPKF+wXL6TPGdqn8BoB+6+UdsGS7Y67KDJ1hAcxF71OaEohqYPbVizeBD5gQQGGsQd5BOjPmMFbOaI/3kUK8YGmkmvxnqhJQzRmN9MX0DBH5A9sV5vJZb0wLfxR9ptd8Sav6myEZvlTEui+B78kjVt94YlUsvuJqRKq5gegeZKLCGsqMK77Sjd6GYRmvmOeyDYdhZU3jsLks4M
x-ms-office365-filtering-correlation-id: c0b0d33e-691f-4800-c72f-08d61c4a5816
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0774;
x-ms-traffictypediagnostic: CY4PR21MB0774:
x-microsoft-antispam-prvs: <CY4PR21MB077468104E8248D0F9260865FB1E0@CY4PR21MB0774.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0774;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0774;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(396003)(39860400002)(346002)(199004)(189003)(54906003)(105586002)(316002)(4326008)(6116002)(1076002)(14454004)(305945005)(7736002)(22452003)(81156014)(66066001)(81166006)(99286004)(8936002)(8676002)(966005)(3846002)(478600001)(72206003)(53936002)(10290500003)(68736007)(6306002)(106356001)(6512007)(25786009)(76176011)(110136005)(11346002)(476003)(2616005)(446003)(6436002)(486006)(6506007)(86612001)(10090500001)(102836004)(86362001)(6346003)(186003)(26005)(36756003)(97736004)(2906002)(256004)(14444005)(2900100001)(6486002)(217873002)(107886003)(2501003)(6666003)(5250100002)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0774;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: RlNoHTkKFniPks1TWrt0Ew8QHdFwZgwdjIqRaH99IIq89KCr18SsyxBO2I/Fk/fuiKaZMRWTnmfTDBjPaBj1nm+gS1KMJLTrbOx8PW54/MTIYUGIXHocZBbCdg9PbrcKVR1Uve6P4m64XWxp1YsZA9sIodvBnG8fDxPAWapSN4rKugt4/1mPbdVaehDHwaXxOdQNR/2IBlCa6Lx6W+yU+y6n6eedDmxTUk+IR0WC5Pr86v9sqy+cMtk4rle3rE8W0Cw07KvvR4kiXFr+PMG9UwCYnbnhQG1omHY0Q8Sbk2YqQM3GdMpYcSjJr62qA/7YS64LB7wWz1Oc5r3CLcP9ojB7DTStK691P19qTuGLhYQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b0d33e-691f-4800-c72f-08d61c4a5816
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:04.8216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0774
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
index ace59651892f..8d3c8070ed86 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -241,7 +241,6 @@ static int sun4i_drv_add_endpoints(struct device *dev,
 		remote =3D of_graph_get_remote_port_parent(ep);
 		if (!remote) {
 			DRM_DEBUG_DRIVER("Error retrieving the output node\n");
-			of_node_put(remote);
 			continue;
 		}
=20
@@ -255,11 +254,13 @@ static int sun4i_drv_add_endpoints(struct device *dev=
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
