Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A293C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A0620666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Kgj6ForG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A0620666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbeJAHOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:14:12 -0400
Received: from mail-eopbgr690117.outbound.protection.outlook.com ([40.107.69.117]:44672
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729069AbeJAHOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8nvwofMb9ST/mHlfRPkkjz3eaX/ABDlDTTVy6wyrfc=;
 b=Kgj6ForGCcByZKH9zTUusxiYKX8Wqkxqji7WwcyZh4P3PGsPzg83RvrB1bEHM76wndcrjOntS/XJOn081wPK8Afk8vjglsBn8ySUYWiDkCPRY4wDGz6SSUQeOR+DO6zWFWE4i0Tg9lqHVFMXzegW0a8YXTcs0i7UWN73c7qfG64=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.6; Mon, 1 Oct 2018 00:38:55 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:55 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 38/65] r8169: set TxConfig register after TX / RX
 is enabled, just like RxConfig
Thread-Topic: [PATCH AUTOSEL 4.18 38/65] r8169: set TxConfig register after TX
 / RX is enabled, just like RxConfig
Thread-Index: AQHUWR8R+WM9mytSvUKaQHXj5dOFpA==
Date:   Mon, 1 Oct 2018 00:38:26 +0000
Message-ID: <20181001003754.146961-38-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:SAzQyURzlCpbVgtV44DLzFuDzqxk/OAahTZ/OlDf0KJj5ZYg2+LPSvstCHPSmznYcRiy80zzaVLYOBUFeggNyWyCf/8g6/5R42q1yIYXKckahxN1cuiZeesX2J5pIq7+Uoins7MCh8zXBOwfyMVJ1XbAwHlhtOCMluTs+mgv9uFKIW8fOorNJHcFU9Eg2uDkzYzfZHr8JYvE3q869RGxXOU7nMRl0RBRt2ktT5xU3g2pfchYro1LxCRhER6jFkr7NtgtzM7Onm2yjHOhrz1semKy+DYIxQPR2QPxEUS76Qm+h/Tkcx6CdU/sMs8KqoUpduK69aqjf4589NPzu4BMBh7SYlfxsBYItKZz6c4AHN5FqsQJ/5RQuiKyN72jzICWfMnMDf46NTUj2tdbruOpzlkNaToplarIsb/SJQgiV6H4HRLtjuejIoEJkvTCnYgRrp+0m6eI61xBdCTmfwsUtQ==;5:Kfwc5MMqmnwsd96u/qDaqIditm90OlwaoLO9GyY+g8hNIhKlSJwzKcrjpT01RZebEBz3v9gggkU83hF5SubJqrkQ3Do1wEAXsZPav7yvOIsgRoz5T3Bcjk+h59yFrRH3VTBmw46nYz8vMHDRIPvjHa3rt25QAWsjOy/At/2ctaQ=;7:74F5bQ5YakIHrq38kfbZmTUiUYDDChiP7lKjlqfk4VEeLD8PJGxZCoXuiYQrbxhaCuk9n4x3t2UKlRWLtetaI6SK+OZpMk6CT5ywyB3dTdmn/r5y4kiNzIhWiNUWQ96+2JeZnohe/EMXpJowYJGlHEkZnIInBon38amQkp4cM9obYccsnLSj0+AR3PEhdnF9bxUQEWm6r0gtQS2tZYSEGoCBqASkJYOs7iolMd1RoG2uDjJJOL6/QeqEcUL5XWVB
x-ms-office365-filtering-correlation-id: 1f9a273f-3e66-4564-53ae-08d6273644cc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0181CB026A4C3A2550649589FBEF0@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6029001)(39860400002)(136003)(396003)(346002)(376002)(366004)(199004)(189003)(6512007)(71200400001)(71190400001)(6116002)(3846002)(2906002)(6436002)(1076002)(34290500001)(446003)(7736002)(478600001)(11346002)(53936002)(6486002)(66066001)(25786009)(2616005)(4326008)(476003)(81166006)(106356001)(72206003)(102836004)(86612001)(486006)(10290500003)(2900100001)(6506007)(76176011)(256004)(8676002)(217873002)(14444005)(97736004)(6666003)(107886003)(105586002)(81156014)(99286004)(54906003)(110136005)(5660300001)(2501003)(14454004)(5250100002)(22452003)(186003)(305945005)(26005)(68736007)(316002)(36756003)(8936002)(86362001)(10090500001)(575784001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LNi1sWCWYgCHPTcASL3QhcuB4vvRrvusMDfhm7nF4suC9i481KzAqmkCrMNVF4qWLrIKzWDdnOErwzgx7fEO/JQkLa/GTUDGHciImjhdfaCNYXlHBOTQlo7+WCNuiDgHiR6j7FOsaWthCkZGX1sJOVTcY7LbA9i9gIHnqe0zocAp8WSA1GhGymkk7nZdLCLkVRgkTi7UHkIhoPyn5qcXhaMnNw+5hm4A+umbYwGtmFCc80Wvx6t6f4pMw9SLySUaOwDef1giLJyOSU6B4sboJ12IVUrKGhXVmQ93HmLr4wwlWE1upSFmYyak0Rl2a87BnA+cxMdgII+9bDGkxh/pnB3YTJFujgqZB5cJ1V4EAfY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9a273f-3e66-4564-53ae-08d6273644cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:26.5122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>

[ Upstream commit f74dd480cf4e31e12971c58a1d832044db945670 ]

Commit 3559d81e76bf ("r8169: simplify rtl_hw_start_8169") changed order of
two register writes:
1) Caused RxConfig to be written before TX / RX is enabled,
2) Caused TxConfig to be written before TX / RX is enabled.

At least on XIDs 10000000 ("RTL8169sb/8110sb") and
18000000 ("RTL8169sc/8110sc") such writes are ignored by the chip, leaving
values in these registers intact.

Change 1) was reverted by
commit 05212ba8132b42 ("r8169: set RxConfig after tx/rx is enabled for RTL8=
169sb/8110sb devices"),
however change 2) wasn't.

In practice, this caused TxConfig's "InterFrameGap time" and "Max DMA Burst
Size per Tx DMA Burst" bits to be zero dramatically reducing TX performance
(in my tests it dropped from around 500Mbps to around 50Mbps).

This patch fixes the issue by moving TxConfig register write a bit later in
the code so it happens after TX / RX is already enabled.

Fixes: 05212ba8132b42 ("r8169: set RxConfig after tx/rx is enabled for RTL8=
169sb/8110sb devices")
Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/realtek/r8169.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/re=
altek/r8169.c
index e5eb361b973c..5d4b094acf0d 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -5150,13 +5150,13 @@ static void rtl_hw_start(struct  rtl8169_private *t=
p)
=20
 	rtl_set_rx_max_size(tp);
 	rtl_set_rx_tx_desc_registers(tp);
-	rtl_set_tx_config_registers(tp);
 	RTL_W8(tp, Cfg9346, Cfg9346_Lock);
=20
 	/* Initially a 10 us delay. Turned it into a PCI commit. - FR */
 	RTL_R8(tp, IntrMask);
 	RTL_W8(tp, ChipCmd, CmdTxEnb | CmdRxEnb);
 	rtl_init_rxcfg(tp);
+	rtl_set_tx_config_registers(tp);
=20
 	rtl_set_rx_mode(tp->dev);
 	/* no early-rx interrupts */
--=20
2.17.1
