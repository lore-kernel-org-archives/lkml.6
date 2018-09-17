Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24037ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B733A214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="M7zSbqGs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B733A214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbeIQI10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:27:26 -0400
Received: from mail-eopbgr710103.outbound.protection.outlook.com ([40.107.71.103]:50082
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729337AbeIQI1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=paYBdpfGZd8Gc02IKD18BVELjhAJWlE6GsMtvlTzlkc=;
 b=M7zSbqGscEuaQTw1VPVVEcF8V5oK0T7bdMJSW7AJDv6+anEgIGJ1Ld/7vfhByBxZp+3SI7CtbU+vdpzjkj/1LmGxsV0AZvg7ePtBALJRgMifXBp7jKOK2/+YeABr6UL5E7fmhqf9eN/g+6bt4fR5E8SVeQXnAWjaMj3ASUJUFds=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0790.namprd21.prod.outlook.com (10.175.121.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Mon, 17 Sep 2018 03:02:03 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:03 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 089/136] drm/sun4i: Fix releasing node when
 enumerating enpoints
Thread-Topic: [PATCH AUTOSEL 4.18 089/136] drm/sun4i: Fix releasing node when
 enumerating enpoints
Thread-Index: AQHUTjKupYpljfLmoU2LqMZORwY2kQ==
Date:   Mon, 17 Sep 2018 03:01:08 +0000
Message-ID: <20180917030006.245495-89-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0790;6:AaKeigJyST+KYI8zg7l48zsV/8qZQ1116AXe9ejB7V0Sv8P+KbmvULdeFL7OXl2OWA0ki534w89fT9oMeSu2lpid190tH0IxbZFfiVLbBHLcKMX5D/Eghs1GK7MyGjpudt+604Q2UesZWN0HTxv/xotFG6j3+nulQJ54pm4XGWypvUkdHMruy27DwNggr8bXtBmOjJ1G7oNjDyakbodLZ4sIgBHu//r35ea+F4yMXztSH+p7K9FHzmmWgrOvErj2AGbiVfYWtTxhEZTx9aU0Qipgn2SIKQlba+PU8k3uarageRHKR7l3RIUfDvhObdtDZJn9vp/aXFh8Q7R/ej01eGuVPjDmTVbCgRGKXZ7DTsm+XJEIgb5K5ddrxcG0u/lSfeWpIMo8x7MjuLte8jcArSO0Q00Mi88tivnVKfNB6Fzd1xYXN87GH1PNZXxQdKa5ZuxyIHBE5hDzWAkvhfAtpQ==;5:3NZClJ6Z9YUP2r1F6ItbBf7Yhaj4KS6JMJg7cf9BRt8AC6EAaAViIU9ee0ZFg89miHHPZyZOqSInKGVVpzizfRcJtuE0al8wdrDi3PNrtKZoKqFeGhno61+TRmEoKAHK+0Wx+Gvjdxa6+QC+4U+doE6E8Iv8UTobSCl8xfr7ibo=;7:TQfu7osQ6avf6W1T0MhLtnJZJDDms/i/K6gBOYuI4yuuuJTcfB00BJmk49F7VxDRKS5817ghDK7JzVGgenKpy+cmY+8jlMrY4hHKcirj792yZy7bGjMorYjATaAWF4p89nosWsEbW5qP38uyFk7rhAiAJRvGW6yWQWdyVOKkfTTnl74yklBp0k2fEFBv94KVMx+hA3vXifa4GdY5Tko8RRvHsuGwZTqu36pFi6j1FK6xg39sdmML3P9+J+Xr8K1T
x-ms-office365-filtering-correlation-id: 73797d36-9c35-4343-642c-08d61c49f1c6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0790;
x-ms-traffictypediagnostic: CY4PR21MB0790:
x-microsoft-antispam-prvs: <CY4PR21MB079036EE03619F151CCEDD78FB1E0@CY4PR21MB0790.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0790;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0790;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(136003)(396003)(376002)(366004)(199004)(189003)(76176011)(22452003)(110136005)(99286004)(6436002)(6486002)(2900100001)(2906002)(54906003)(6346003)(10090500001)(5660300001)(7736002)(6512007)(14444005)(217873002)(316002)(256004)(53936002)(36756003)(6506007)(6306002)(25786009)(106356001)(26005)(86612001)(10290500003)(1076002)(68736007)(476003)(6116002)(3846002)(478600001)(5250100002)(11346002)(446003)(72206003)(2501003)(81156014)(81166006)(8676002)(966005)(14454004)(102836004)(107886003)(186003)(2616005)(97736004)(86362001)(66066001)(305945005)(486006)(8936002)(4326008)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0790;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: wTMfjEgW6Sf3wEDYK0l0qkN7EANb1YzUgcH7fpq6mMOnWEiKjglaD2rIWn0fSz0BRpHj8+l0Z6Legd6vGcLPEIMwsdy8O2TRYzZ3wEi5Ey/RzkqRBpsKnr9Sx5FRP3v6U349h2b2edhUv8UPRzN4968uE5tgqQNvRy0AkOnBqmsr9+yiKuwfHd9Ky6VrZ7fVtr1HxIFHG+EGJjglHMcQKPmTy0lZAvMg5ztqR2IaRNCqo+Jx8WYNHx076gyrkKBkxZmlitxyuSZimhdijtUVqztLRzAH/4y9OF+t+uhutxgTPJuINrXAT6cpxWTlR3BPdmON7VGZw8iYwA+wKnE4zHhHGfo5QBlwxQ31ym9qzPw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73797d36-9c35-4343-642c-08d61c49f1c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:08.3386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0790
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
index 50d19605c38f..e15fa2389e3f 100644
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
