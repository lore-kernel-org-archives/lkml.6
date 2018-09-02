Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB9DC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EFAB20837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BxBQpbF4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EFAB20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbeIBRav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:30:51 -0400
Received: from mail-co1nam03on0097.outbound.protection.outlook.com ([104.47.40.97]:50844
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729910AbeIBRau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/jawX3MdtdM1CG+j/9S6TU3oSTNc56hUj9AW3IkBWk=;
 b=BxBQpbF47U8y9yUrlOErMnOTseI7RGb7LVtJvwNkbmVE9bdD3WmtNorAaonyUNyle58SHFZNHp0AH7fYnDpcQmZ0O2kaEd5zmBs/mfEW8icsL5Ddtu3X5yFv84teN9L0qqWDSB3szDK6pnuqzh4apfEQpiEZLzIjnKybtuNSh1Y=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:14:42 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:14:42 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Yelena Krivosheev <yelena@marvell.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 30/62] net: mvneta: fix mtu change on port without
 link
Thread-Topic: [PATCH AUTOSEL 4.9 30/62] net: mvneta: fix mtu change on port
 without link
Thread-Index: AQHUQr7oVNGX19gubU6HXGvVMIVddg==
Date:   Sun, 2 Sep 2018 13:14:41 +0000
Message-ID: <20180902131411.183978-20-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:yStGfT5ptiL2+i3TaRlMchgXwqXwcVTrlq18eEdo/8/z06dIWkiDczAoz8olAC4rPIFMrXpdTE5hR8cdtjmIem1tJwCH+vQFt+LohhGCmuwZcza++KIJu/7uCmqsNS//axJmdHxJ2a/FgS/MOylEYW+zT7uTIucNJXdavDgdbY0dWXTh+k1mx4X1QPZGjHp0461rgKiCaBdeenIT+nvSSgboQjvQ8UXoMf/HW/E0ibzc2er5jO3URmekzVURwcIG9Ua3i5G3rfzHkl0jgNATGLbZjtC/yUtE3aLIZ/1N5m+lUF1zT/nkhlr0m+hXuOLxWRpElHM7N8f64X5EKjswfDm90RA3V7b7Dd41azbJX2surXy/eOQlAzzae1GUR05Huhyhv2uETJ7prm/b/YtJug10eaPk+SU4N6sFWRZ4u16dEsYrpH0ZpTVAEqvGPZMQCryyLbmRNXtA0Uj2jwe46A==;5:fIvDORw37tVKPCexCNyuyDQqWDm08dC1Rwg9feWyqc3gdJt0pYg/kONokk6kGRBRy1DpESDVAIZKV4uF7r2NeRn1nfcDhkdOZDv7m+8YgbEs5u3F995VueZyzCkHInvgsw4caD0lXBuIDbN5VpKWAEecOFS6WseW1XW4uSOeDq8=;7:h0iRvVaLPTAhYY2CnYDvp6Plpr05RxpPNqyq2S5EZ2jfb21AdrY2LrHtIPKHBqAYYMwTNYX0V48qBeWNWA6kAkmXElq05mGnTvd5CD4/3HqE3oPt2ReI6M3kc8nBlxfP6XZWiQht4qPJpV3fB1ChjE/JHUzyABNBs1W7ZW5qRQYwntVERAoMET76ayOj6ayTVmjjCuSqt5Bpsa4t2a3mZ9Pcqab4EC88tax7PSylfxMewufzOHM0XBdifDidTftt
x-ms-office365-filtering-correlation-id: a3fc70f4-6962-4141-2a2d-08d610d60b74
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0120432EA433078F68DC7BC0FB0D0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(1496009)(39860400002)(346002)(136003)(376002)(396003)(366004)(189003)(199004)(106356001)(53936002)(72206003)(5250100002)(22452003)(97736004)(6512007)(10090500001)(2616005)(2501003)(446003)(11346002)(478600001)(10290500003)(476003)(14454004)(81166006)(186003)(486006)(25786009)(4326008)(36756003)(102836004)(8676002)(81156014)(105586002)(8936002)(2900100001)(99286004)(66066001)(68736007)(110136005)(26005)(107886003)(6506007)(5660300001)(76176011)(14444005)(54906003)(316002)(1076002)(86612001)(3846002)(6116002)(256004)(7736002)(6486002)(575784001)(86362001)(6436002)(305945005)(217873002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: w175NP4qi7WH4UP6IqqwRQ03gY6WWbqNdECTRo3xaXSTQgP2sBcZN7H00gs7wGgJHuIoaKsCZhbGXW1almGWaHE87Mr/prlKhlsnVeydiLPXa8ovEwilKbpdOm+uyIhJrztbK+8QYc7+AZMwAbQp+o2+EDzRlNLMzIH0H8OGUfejGMv5byB/Y9e/lu2SGPcpmCvog/uls0iDKJbSNslHpzfMblqx6GvHZx5EouZ8AP1T55NevmIYOhEpLLoq7NhtuVkuFNhTKfyi+nS4aTU5tfu/D5/fvZ1nLOYlNgVLLaVbEyG2gAMkXtusjT4XvYzEIG4c5Pz33FlIZnV1r8L5nDvBnZJjRHuDmpo5WESwG8I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3fc70f4-6962-4141-2a2d-08d610d60b74
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:14:41.8780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
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
index 17b81780d12f..c92ffdf91065 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -3117,7 +3117,6 @@ static int mvneta_change_mtu(struct net_device *dev, =
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
