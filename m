Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2928C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8209320855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gwv8ccg3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8209320855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbeIBRY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:24:56 -0400
Received: from mail-bn3nam01on0091.outbound.protection.outlook.com ([104.47.33.91]:56192
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728753AbeIBRYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pbu//Wpi7PxYiQC+vElA9DI5p3gi5mQZ0/UKOXRIwNU=;
 b=gwv8ccg3jaNF1nfXHJJK2FlDTitzyL8daYYn4J6oxxiQf5lWXEwJonenRQWZhitwYVCw1jzNRDsj6/Xg+kzZAJxv7tTCw41nqY2yU4HkUTFvnYLEHk8Ebpgkkbt1GvC+4bchA5RGZIoqHHhv8EQjSKVwtXfTc/u3bJIxYzXS9M8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:08:53 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:08:53 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 01/62] misc: mic: SCIF Fix scif_get_new_port()
 error handling
Thread-Topic: [PATCH AUTOSEL 4.9 01/62] misc: mic: SCIF Fix
 scif_get_new_port() error handling
Thread-Index: AQHUQr4Ncvq/iz1tCU69bF7OZsLhJQ==
Date:   Sun, 2 Sep 2018 13:08:34 +0000
Message-ID: <20180902065131.183542-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:nj9nVf7VpQovRRpU/yfzydnTyGfN+vC55ljo5PncvvJRiuCb7R6U0P2XvUS8ket96MLyE2N9Svzd9mcNRCew0M/+9LVBgSFngH2PaB5KG1CMTF8U0pmQlt7qYfxrMced5qc7tBPIpdNSnsWwBgFPMtGohwQDMfo5XIL5rVQ0BTKFj29nRn3fu91RkyVPWWZ3wDHJANL+2sW7JWeDYcy9DmJVOF2v3lupYRCDOPcJX6gn1GMl6MjuTZnLm2A1z1VmCPXzCdvsqpVvNESsQifOSvk9QrOBn7HCILzhJzuIyAtMyoQLuvHPzU9EtJbwCLXag14vhaD0O3HW6ghdDdb42mTHEo8KWuCxvNbIwu8eUgn000KWjEzDOJVda0DmZVA0m15D4a3ToLrjGC3upAPCNHnWcZKGAfixKNiYiUp/7noxzPsPFX1Jh9fT80C91Ue3Sv0ahLK30p+WR5JrITAWOA==;5:LHc4kUzOZEi3/QOIf3vq5pvF0gtw2jC5c2cF8hE4AusRYMJ7OmT64qTwmL2KJNV+f0G4HgGEQUur/g5WfNnGZ72ZTY78/xoAusmtQ1QCWrfnc6nKBthTIlpj+z7RBQ/88wlXSTqW9IjEjKOiGWB7NBd7yOAaBjkNJut46aK4NRk=;7:b1VjLvzDZ5mHWqsnHbCO+SqCjus5r4gg4UEJ4RQ/LmWET7zuBayfGNYV7kvPPU+a/iA1O3YtrsaNpZNe45g+iQXckL/nz10xCDu4Hf4GdI+C7vQH8msv4PzNtTXsbjvz0HF15sRJqwNoLjLR5BFGKaPXVi5u/dOXfnoeDzk/JVpuGCyf5W/SnKpidkIWbvaYcisozYpsbu9FZu4Oof0RivCCQ67t9iK6ELymo2HhNFRKx0WMercKfdx7mQ9mXwqL
x-ms-office365-filtering-correlation-id: d1cbd000-423a-4b4a-456a-08d610d53b90
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB04697944D68208F19F98511AFB0D0@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(136003)(366004)(346002)(199004)(189003)(110136005)(68736007)(36756003)(316002)(72206003)(54906003)(2501003)(81166006)(81156014)(8936002)(14454004)(97736004)(10090500001)(25786009)(106356001)(7736002)(2900100001)(4326008)(2906002)(8676002)(105586002)(305945005)(5660300001)(53936002)(1076002)(6116002)(478600001)(5250100002)(6666003)(3846002)(107886003)(10290500003)(99286004)(6486002)(6512007)(6436002)(2616005)(66066001)(6506007)(22452003)(26005)(186003)(86362001)(575784001)(217873002)(476003)(486006)(256004)(102836004)(86612001)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: y96jQSI21ZkBd8bp5PkI6P0GEw4Kn77DZ28ytT+oQ8aqlBDdFzKE/7mxwWEAuI7qHLbBcIN6gzHyIAAlxk0++Z017H5HkPk3S6X+dEck3rMRERkieRNjLkwBd9gW/RCk4FMi7tmFnKUHfE3ttlweZgvnTqNpzfHD4idkN4Qxd3iyAHbjbGBikZy2LEXyX3fYc1XxLxAa/8khoFiShTCKnR73UNvTHmZvuME2H+Vzsf3g1HnqmIpWJ+0g80eXewBN8LrRPLfgQQ6uV0Lbl3Wwnhy3Uhj8HnZ/OQlfyvUlbtmvIcwR1XwJ7sp5uStnfxoeuUx7+JfBX+WkHKiMe0SGRz9uYe3VZlcAXhYs0FPTRoQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1cbd000-423a-4b4a-456a-08d610d53b90
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:08:34.1938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit a39284ae9d2ad09975c8ae33f1bd0f05fbfbf6ee ]

There are only 2 callers of scif_get_new_port() and both appear to get
the error handling wrong.  Both treat zero returns as error, but it
actually returns negative error codes and >=3D 0 on success.

Fixes: e9089f43c9a7 ("misc: mic: SCIF open close bind and listen APIs")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/misc/mic/scif/scif_api.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/mic/scif/scif_api.c b/drivers/misc/mic/scif/scif_=
api.c
index ddc9e4b08b5c..56efa9d18a9a 100644
--- a/drivers/misc/mic/scif/scif_api.c
+++ b/drivers/misc/mic/scif/scif_api.c
@@ -370,11 +370,10 @@ int scif_bind(scif_epd_t epd, u16 pn)
 			goto scif_bind_exit;
 		}
 	} else {
-		pn =3D scif_get_new_port();
-		if (!pn) {
-			ret =3D -ENOSPC;
+		ret =3D scif_get_new_port();
+		if (ret < 0)
 			goto scif_bind_exit;
-		}
+		pn =3D ret;
 	}
=20
 	ep->state =3D SCIFEP_BOUND;
@@ -648,13 +647,12 @@ int __scif_connect(scif_epd_t epd, struct scif_port_i=
d *dst, bool non_block)
 			err =3D -EISCONN;
 		break;
 	case SCIFEP_UNBOUND:
-		ep->port.port =3D scif_get_new_port();
-		if (!ep->port.port) {
-			err =3D -ENOSPC;
-		} else {
-			ep->port.node =3D scif_info.nodeid;
-			ep->conn_async_state =3D ASYNC_CONN_IDLE;
-		}
+		err =3D scif_get_new_port();
+		if (err < 0)
+			break;
+		ep->port.port =3D err;
+		ep->port.node =3D scif_info.nodeid;
+		ep->conn_async_state =3D ASYNC_CONN_IDLE;
 		/* Fall through */
 	case SCIFEP_BOUND:
 		/*
--=20
2.17.1
