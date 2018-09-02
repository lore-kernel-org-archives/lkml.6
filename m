Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE540C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851BC20855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="M5dD/Gbb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 851BC20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbeIBRXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:23:37 -0400
Received: from mail-sn1nam02on0134.outbound.protection.outlook.com ([104.47.36.134]:59648
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727049AbeIBRXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6l4cgmCIAg6VmaV6uyCisgTEdVR28l5x+9oouX35a5E=;
 b=M5dD/GbbM7dI5fdmBhgwPK2TJSTyApw6cO9ulmThG1LyUU7azNYk1ZbyUQ2zc/XBwM+xByNN0EFd/A49XyGDTYgMA+pijf9tWY9eKpgL/tWa4DSoW/1FygLux7ZH7HORpQ+QK3YUgZAV3TZqJRFeAQpjUSvWKrAkuQ5QdtVLnPs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0503.namprd21.prod.outlook.com (10.172.122.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:07:45 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:45 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Yelena Krivosheev <yelena@marvell.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 53/89] net: mvneta: fix mtu change on port
 without link
Thread-Topic: [PATCH AUTOSEL 4.14 53/89] net: mvneta: fix mtu change on port
 without link
Thread-Index: AQHUQr3ejF/OGMdX1EGqxsj9v1UPRg==
Date:   Sun, 2 Sep 2018 13:07:15 +0000
Message-ID: <20180902064918.183387-53-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0503;6:KsyelxPjB8XckbtREbrnk+2ZGNqoWdQkCiiAYWFWvG93vgew35WoFe8TeNk0VxOjyCAOl/0mr1X4DbgUNC4jPXOqXN87kIqSMQEgCmB1KApLyA/fBz6lj5ScSyNALhqRz1hsyBaM0ltPGVgGXhYTp2T+/PhdxwPGDc1ERDBia2u0gA1E8PZ0f6usUQdy5HhHA+j6QOYn2TasKOMuoggTCoQVgVzAIld93T/6yx4OBwaswBhCX8iFC2+9SSGCP+vT+Wh0ZlYoUuxqUtVfOyrWhOw7XsAmZakK6Dqa1YACD7jIT8eAu86TWRgTkLHua3t6aybt61mnXx0+Pmtgfb2IaXFJgwZk4x8GDkZvZ+Xv17Qct0OvFNCIi0HoC+CarSckodufrBNdKwjrzaYkx5vppQ7hxsVAQS1MgVM2v2/1zTlNKFnl5VUss3WW4RVtwCc1CKplZ1ZaS3rYTr4Yf3PRMQ==;5:TpNN4GBdjRUEq1O7Weun/gDEERc8fY5Qj6sblO+4jZV6yfSKde7HDD/3zdE3amQ2c0RyS/QARC0CcTOpcsJ7irBeZRPebVm/+fsLH5gcTh6XuHTkspcL/A5qooeGXjjOvBz24JmOdUi2UcjHGzXMwjsGdMJMHEnjZhWFbUkCYKQ=;7:9+V01fYRtmVADx+OPgxrgB6ifXMf4HZ4lJpffynpqsRlRw+OdwNaQDnVc0P4L+D96Fav+VxMQhjEb7PLHwj8LYUls6pLwBKopFpMEeQuWRWAp8GUK/+g1tU8sWeHGx7aQ0kWOdxBGhU2gjnKzw7F4swZH/muaZ+26EQwXJpR3EeH5VYmOj+RT2foBJYqTIeW6eTSI/je7ULbavmoxFHEIvRNnrlsA7HuIyWcqvwnNv4CDh88Z2oFkoqXdLv8qGCp
x-ms-office365-filtering-correlation-id: 25af935a-d46a-46e9-7429-08d610d51364
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0503;
x-ms-traffictypediagnostic: CY4PR21MB0503:
x-microsoft-antispam-prvs: <CY4PR21MB0503415B093650EDCC297CE5FB0D0@CY4PR21MB0503.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0503;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0503;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(376002)(346002)(366004)(189003)(199004)(105586002)(8936002)(102836004)(6346003)(68736007)(2900100001)(6116002)(217873002)(186003)(36756003)(81156014)(81166006)(1076002)(99286004)(26005)(5660300001)(66066001)(6666003)(8676002)(54906003)(256004)(316002)(305945005)(22452003)(3846002)(10090500001)(7736002)(110136005)(14444005)(106356001)(2906002)(6506007)(10290500003)(2501003)(478600001)(2616005)(72206003)(6512007)(53936002)(575784001)(86362001)(86612001)(107886003)(6436002)(14454004)(76176011)(486006)(25786009)(476003)(97736004)(446003)(11346002)(6486002)(4326008)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0503;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 8XayQwg2coQhqpTahLMOdiw5PzX2b8IX04OIg8n7Hw0ndnwXO6jpGbOD/q98Sdl8/AqiytJdHqfLQPDqyDZredlBIxE7fUljVQwut4t0EfhGh1QSnEJqB2rcYmTojGhb8AiOasgsnLTrlYvlsiRQpK89l8BoDJlIwkT5xUEj9PSuEzCNG5hjmP7oSxs8Q/utwQ9rNBuWSjezobfpsIT4S8dw6dJiNboA53XRP8SmCYIwTV7qd+Cs39Ik5S6qz91bhDFQn7urrIRBoxLr3zTMfM6IntZDwmd4J8xykyjz1nt6kTpDq/rJuoNKJRGK78sYakQmqs5nYpoh1AuHtD+ohUN9O2JywFfQzAXAZ6ZSgII=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25af935a-d46a-46e9-7429-08d610d51364
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:15.5120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0503
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yelena Krivosheev <yelena@marvell.com>

[ Upstream commit 8466baf788ec3e18836bd9c91ba0b1a07af25878 ]

It is incorrect to enable TX/RX queues (call by mvneta_port_up()) for
port without link. Indeed MTU change for interface without link causes TX
queues to stuck.

Fixes: c5aff18204da ("net: mvneta: driver for Marvell Armada 370/XP
network unit")
Signed-off-by: Yelena Krivosheev <yelena@marvell.com>
[gregory.clement: adding Fixes tags and rewording commit log]
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/m=
arvell/mvneta.c
index 3deaa3413313..074a5b79d691 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -3195,7 +3195,6 @@ static int mvneta_change_mtu(struct net_device *dev, =
int mtu)
=20
 	on_each_cpu(mvneta_percpu_enable, pp, true);
 	mvneta_start_dev(pp);
-	mvneta_port_up(pp);
=20
 	netdev_update_features(dev);
=20
--=20
2.17.1
