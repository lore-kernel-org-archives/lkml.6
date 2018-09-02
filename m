Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCE4C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257B22077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Wz/jP1iC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257B22077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbeIBRsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:48:43 -0400
Received: from mail-eopbgr680117.outbound.protection.outlook.com ([40.107.68.117]:50363
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728284AbeIBRUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4/H7kePGrzh3EqHCehN0ufCb0fqTnGmDwo203dVJ2Y=;
 b=Wz/jP1iCjYD5dTZdz6pxJ9yX0zRggVXAC9xo596X9YPsFZVX8IE/jO2tgriCO3+Z+aKW9KzNHGFlZMJ9xzc6lvMPqR5F/m3pbl6edTlz5bV3mcVYoaMKOqEV0WYiZEuPZBGh28E9QbSQZhefPR2EjUPWoQQ/YITzF+I0cdyhVFE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:56 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:56 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Yelena Krivosheev <yelena@marvell.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 080/131] net: mvneta: fix mtu change on port
 without link
Thread-Topic: [PATCH AUTOSEL 4.18 080/131] net: mvneta: fix mtu change on port
 without link
Thread-Index: AQHUQr2FzbiOlAFYL0GH47Eh/pr6wQ==
Date:   Sun, 2 Sep 2018 13:04:45 +0000
Message-ID: <20180902064601.183036-80-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:cjGybwnHT8d6uKXbG5uwYhYifeLhdf37iWw4tkMPN3jyC7cWJs3dWC2GgF6vPCyLF3m6DhjGhLz4f+0dFA+HOd86okT61sz3n7glzEVrg27xve7qpBNfDJFHYy521qAb974Ra1C8/JYZIa1Qt3gq/eL5T5hNjfa2WagNx/BjuhZDcbIZAC+pR1w+2NJoA31JS51OHrs3psG/hCFyBnmSk2QGsDZZvT07P9zfctrFbFWWdfLzD9qA6ZM4isBEmInERVUGPsunLNz+IXJEl+aaraJK0B3j5pFJdsmZTSmvOQUM4CtkAymGEEyOBO1BaVT/x1YdhzA5uHoLLocWNj+dmGjOLdMdI/PPMFrvoyeoR7SIagCx2gRpfAThCXcxZh01MexfmR/LIzIzMONTyAGu8k9WcElAkHL0rqvoRoa/F+0ruZrFJFcXjvowlvAUQys1Dp6pVrHdopIQZAa3i4yvUQ==;5:7CnAIFUT2J013ieMb6IOaw817KjU0G0sapYUeiiNCpr5WGyq5nxrDO5oLNUd++6126hcILFsrnYiK/FoP3ybfz9QVezKHyEykRwQbFqRaabt1+RzMhkSV37dUEXejww2gobY+Ui5x0lq/SNsUeCePYM6qGJlH9a5QbSs67qIy+s=;7:Sf2imbubPt+Lku7Xckr8C7cYjJjxN9kyFUSmVGCtwNV1neB07HIZsK7cbGqw3cPrGPEjoC4LVtaB8UC3BmQaclRxX+KijwRV/EBBCLlo52IebdabdZuIjcBW3qQ09oh/78VSO23MZVdSYXk8QDEZkISrzQwJwb0TRrW+oSSJZ0j/9j2PyGZWxoMEemtnRxZbYjB9pNECJgQwhwN/R0ACYh+JcTCV74vMxWXYI63Z7oI/uxDXS9dg+Jlb+gK3ybVI
x-ms-office365-filtering-correlation-id: bd22ee39-26b7-4415-cc08-08d610d4ae7f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07416B5364A56867DE85D6D3FB0D0@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(97736004)(2906002)(186003)(26005)(256004)(14444005)(102836004)(11346002)(25786009)(476003)(486006)(2616005)(446003)(305945005)(66066001)(5250100002)(2501003)(7736002)(6506007)(8676002)(68736007)(76176011)(6666003)(99286004)(6486002)(105586002)(81156014)(81166006)(53936002)(5660300001)(22452003)(478600001)(6436002)(86362001)(575784001)(14454004)(54906003)(36756003)(106356001)(110136005)(6512007)(4326008)(107886003)(217873002)(3846002)(2900100001)(316002)(8936002)(1076002)(10090500001)(6116002)(72206003)(86612001)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rGYKx9run82IVJ7H8Gu737vAT+ubulNH7rFqncpsVq1gtT2Xjqq3REz1eRDcS8mZLrSzlGRKev0E4Kstacro5U4tHp+ptv3eFQnYt1qBP/ONu696LcYvq9cKpGCOk+bpHjJYYwSq5TiZ7TCwehW9Y9jRmtX+0QAB/SE2nJ7Wfp0jR6U/TSKJ3lns4x9Nq9WMLY2qipoulRBIy4ZpdY/eLE4aYk4BwAk6q18BsNP0/3VQjzbU+HRSnb5ahtVMi+M6htqnIj6K1qpL8RjlwBUgxa/+pQzfwZpBHqTj+jcaEl0Qm4U+XO2kJE6w3N2gUkQSd41M4swH8o4gF7a3E0T0wOqtkLiwZt/p7FQ5PRnT2O4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd22ee39-26b7-4415-cc08-08d610d4ae7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:45.2161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
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
index 82ac1d10f239..b4253d0e056b 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -3196,7 +3196,6 @@ static int mvneta_change_mtu(struct net_device *dev, =
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
