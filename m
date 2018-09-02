Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8A6C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1B8204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="S6TXOM5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1B8204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbeIBRWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:22:12 -0400
Received: from mail-eopbgr720115.outbound.protection.outlook.com ([40.107.72.115]:16848
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728614AbeIBRWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:22:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoAasIJ5gGGzpLbKiE5C/kcOKrwL4SOD+u0Z2DHDWmo=;
 b=S6TXOM5oVc5M+3WaWEEOucrl8kowfV8bl4GrzwGpPmEQ930skmHrVRE0ggtoEKufKfGqslijnSTbittDN2ECSn8EAxRY3JBpo0Y5eKA7arquRvGeshjVBKhpvJwcZ+swmdi7eZNVatPLzziDLG2+SR0NoAPg+PiKj8kmJ205m5o=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:06:19 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:06:19 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 130/131] RDMA/cma: Do not ignore net namespace
 for unbound cm_id
Thread-Topic: [PATCH AUTOSEL 4.18 130/131] RDMA/cma: Do not ignore net
 namespace for unbound cm_id
Thread-Index: AQHUQr2p5mqwOCqcakmLEs8oDR9gaQ==
Date:   Sun, 2 Sep 2018 13:05:46 +0000
Message-ID: <20180902064601.183036-130-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:fkKEvqrzewA3zWmYqbeUhfzt+ommyhpwGd9hHrZDLUg+gtMFx+6XQOk+QbUHbx2/+OOKuYxpBTzZzSDtIrcUM0bECnm3Ym6e1+K1amGRtRpjrZDv5CoErJwBauYbRJgTmNfB8dSBfJ3gOki3BEbVw6dSZeWZzaQmJVajmWQTMuSqh0YYmqBy0gGJFRq008NE71Lc28o5CXq8T+9EdN2jTWqjM96RpOYOKpKkNMo3AdtJz+NGrZvlOrp6+X/iaCl0VTzAtWyTb0ThP3UP2NXEM3kgjm9ZDvUGTmtsUZPYs6/QY8qPiFACo7x5feYE/EjJk9AmcKCBlOyAmKBMdz2CrQ4C6zyjwKzSsLu/ByI3rMQS383tB0p2NbRiKGzhVHjfPdyKKdHXHYf3geDjZtS0tQwLjsFIiwGWVKLvXo//o5ztXI1pvWf4ISLKVYqMIAkk3MAkpd8AlGMyYrjw5jAOqQ==;5:pskPnTSP0G64alXUy78zGjtb5O4TGUTzd/KZ1kvftJwK2H8MjH6nwx7tHGR1BkEtpZ3uVGI5tIhbJX928S+yxTNUP0yKI4CtfJLHABD0BvfzVbYW460ZTUdG/3Wo/mwILtCtRqkEGr1j21s//NLgdTSi0uND8PsH+H/UZ8zVaPI=;7:c0cyvAVrWQJGtvNk8l8u/LSBJuLKpyoG/bQxXcwLeyiwrfgPs/WYxTMAkOro/XJ0WqJIQrlo18sxEowovA72fHbowhRjRGwwB+hpIfxAi9DyCLJwkzoGMZtkPs/jzicLSbvZWCMroA/f/Y3f7p5cELc8Pxq8ifNOAHsonMelvQA89EfZTxgFTDymPhyN1YBv8zowHCby1Kv+5ZRrnCFWFEvHjBTdNL9GLO74h38vG7kI0BYCgDgDEftQfZp0UrOH
x-ms-office365-filtering-correlation-id: 064b51b8-a586-4b84-dff8-08d610d4dfe6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
x-microsoft-antispam-prvs: <CY4PR21MB08221AD5AD731F668D79F590FB0D0@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(366004)(39860400002)(189003)(199004)(256004)(6512007)(486006)(86612001)(97736004)(68736007)(478600001)(446003)(11346002)(25786009)(8676002)(10090500001)(8936002)(2906002)(110136005)(86362001)(107886003)(4326008)(186003)(26005)(6346003)(76176011)(6486002)(53936002)(2616005)(476003)(72206003)(10290500003)(6506007)(81166006)(81156014)(66066001)(22452003)(99286004)(102836004)(5660300001)(217873002)(106356001)(2900100001)(1076002)(6666003)(7736002)(2501003)(14454004)(5250100002)(305945005)(3846002)(54906003)(36756003)(6436002)(105586002)(316002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: OaeIpk4Uq4yPJ6XWjWvYcqSWxm3woRIS8vT7JFsL2RU671gzImn3E/sEf2d9JLwJ/bhTU7lWOH6zcSyAmSSpSI4M2T2dfzYd2BWMR1jvzKZvstmtxqgdDX5uvSGmMY9IeqY5B5b3D47DtrQhSDk5SlBwBcx+uQlu3dr2ssR7KPSK3FGpXrEJ8xJy8HEL01PoiWHAQ5aOPhKh7MFzS/NbRmFbQCjW/h1bsjsv3eASF2WoUSTVacVUvVTivyp4qZi6u6bQukEtxvAHi2FNNFE38ORUnHCwAWO5eiyhtTdF6+jUrVfgbLNmqQ5OHwBPeOxDr+d7eTyTs92e08fgE81R8c98TBDm+vxvegoIpu/39PE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 064b51b8-a586-4b84-dff8-08d610d4dfe6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:05:46.7532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

[ Upstream commit 643d213a9a034fa04f5575a40dfc8548e33ce04f ]

Currently if the cm_id is not bound to any netdevice, than for such cm_id,
net namespace is ignored; which is incorrect.

Regardless of cm_id bound to a netdevice or not, net namespace must
match. When a cm_id is bound to a netdevice, in such case net namespace
and netdevice both must match.

Fixes: 4c21b5bcef73 ("IB/cma: Add net_dev and private data checks to RDMA C=
M")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Reviewed-by: Daniel Jurgens <danielj@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/core/cma.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index bff10ab141b0..dafcb6f019b3 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1445,9 +1445,16 @@ static bool cma_match_net_dev(const struct rdma_cm_i=
d *id,
 		       (addr->src_addr.ss_family =3D=3D AF_IB ||
 			rdma_protocol_roce(id->device, port_num));
=20
-	return !addr->dev_addr.bound_dev_if ||
-	       (net_eq(dev_net(net_dev), addr->dev_addr.net) &&
-		addr->dev_addr.bound_dev_if =3D=3D net_dev->ifindex);
+	/*
+	 * Net namespaces must match, and if the listner is listening
+	 * on a specific netdevice than netdevice must match as well.
+	 */
+	if (net_eq(dev_net(net_dev), addr->dev_addr.net) &&
+	    (!!addr->dev_addr.bound_dev_if =3D=3D
+	     (addr->dev_addr.bound_dev_if =3D=3D net_dev->ifindex)))
+		return true;
+	else
+		return false;
 }
=20
 static struct rdma_id_private *cma_find_listener(
--=20
2.17.1
