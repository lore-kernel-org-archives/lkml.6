Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09092C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2826208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kZYyn2pE";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="k43M47s3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbfAJTfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 14:35:03 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:62523 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbfAJTfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 14:35:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547148902; x=1578684902;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=xWfXdR8cj8M6IYzTCPeOEHg30o/1S7nr9XrrH552yPM=;
  b=kZYyn2pEV6xd1edbNYkLRr0sHWe34mNDqdwrfivfLiskSFzj8mlNBVvk
   98+rjT4St8g2sHKss7p5GkPz9LhuFHtaQyL13LpEesaYoC+20kgv2vG67
   p39dVmYSSacD5Q1rjELDSa9w1QYtpkyYp1SkQ7XH5IbIrWVKN7llENmvv
   6gCiLrDgKBynBxOukTXg6FMLwxyYdFuYYaO3XjUj5jaGMlIVBxBlOegAJ
   cwWHZL7uVm+1DRYUJ3uMDaWb8jDeCl4E1JbWauyi2DSFYw2EGmmXkt+QV
   6P49e+aJylvUD4CliIzzRytjuKmQcHsAG+cfVP8UrhykrN0hi3IId9oEo
   w==;
X-IronPort-AV: E=Sophos;i="5.56,462,1539619200"; 
   d="scan'208";a="203370719"
Received: from mail-co1nam04lp2054.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.54])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jan 2019 03:35:02 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWfXdR8cj8M6IYzTCPeOEHg30o/1S7nr9XrrH552yPM=;
 b=k43M47s3gZ6UqQpSXxh3QZHGY1HN+pVHaeQyJoo748oIXERfQud4gmAKG94jMRYSEIP41iKPxaey9rmtE9LYK+YILdGfL6blTzM4lZyqqQ0LS6a0S5kGgyfdbM/jC093sIfcYABKngjhdGZ5mkAMjLVqY5R267nJL25zhaiHUQQ=
Received: from MWHPR04MB0401.namprd04.prod.outlook.com (10.173.48.18) by
 MWHPR04MB0254.namprd04.prod.outlook.com (10.169.202.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Thu, 10 Jan 2019 19:35:01 +0000
Received: from MWHPR04MB0401.namprd04.prod.outlook.com
 ([fe80::10e5:e75d:3272:2d33]) by MWHPR04MB0401.namprd04.prod.outlook.com
 ([fe80::10e5:e75d:3272:2d33%7]) with mapi id 15.20.1516.016; Thu, 10 Jan 2019
 19:35:01 +0000
From:   Alistair Francis <Alistair.Francis@wdc.com>
To:     "Palmpalmer@sifive.com" <Palmpalmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alistair Francis <Alistair.Francis@wdc.com>
Subject: [PATCH v2] RISC-V: defconfig: Enable Generic PCIE by default
Thread-Topic: [PATCH v2] RISC-V: defconfig: Enable Generic PCIE by default
Thread-Index: AQHUqRuTleyE8WgISUO+ZqOMFa8nvQ==
Date:   Thu, 10 Jan 2019 19:35:01 +0000
Message-ID: <20190110193451.29016-1-alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.19.1
x-clientproxiedby: BYAPR11CA0098.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::39) To MWHPR04MB0401.namprd04.prod.outlook.com
 (2603:10b6:300:70::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0254;6:3Nn/JmX1XAtOTV9xjPzNHba0cqWtPBIZGD7iJaTeZfUmyWBI1FC26VsmnTVS4OXtirWKyr+EX5XMsQxnEsHuHl7nRkBcgxpZz/x7NaLe//8f2hXedd3pm1KTEmB8h+IAurfRvVXQ/f4QR95fRjfyTxbwVcuSGjP2bMh8kQlkHgwVgv2wdwHfg+6CSERmz8FYXJy5rPhUYKvLTl1baOTlrazOhAPavuB1jRXp+1qBLhqTQ9uvwvm7P1q6mJW0V2ZLVhBR8z5c9ukkWrlUS0DUgYyzFD1yIJkVFlscFuTEtcwJv1Bajf+RI8wHO47WjYRxayDepmVIuJRF8po3V9AZtlP7aFPr7LM8IbMzTnd68kpTrD4o4C+KuIgL39wUYQVGyxPtMtM6uk3CeBQQXEdbe6mx2pMZC+dIppH3Gba2XgMubSVDxUVuZSbiEwb8fQyvpy1S7ipl3qazs1BLpMfLkw==;5:5SyPEnuRXy0LpkyBCF344B4MgEWqSmg0oeNztgWBUziqCwuBF7iiUyQ/B/yaXU2y5+CXKAceG7iRBwxGizr7xR6OBvqsY/rrgyTxS0TAyxoZfr7hjsjrbhOYgr7s1AvfHg80w5454Pbz7BGJ98EuV6j3qtV234WSMlUADPIMmPRwVlnmc7liHb36TJlmT55ewhOG5afvw2l/2mrMCGpLfg==;7:+SDVKGjmtcKsnUZq1/EcPnPjtLYBk1DTGMngmIpyqm92O2wGE1DByikhC84l3SR1lVXd6d3w0zsJ4f3UVXqwLs//Uj2oYKRJ+6QRBtjgKcx3TRKNq1BNV4NQJXlXW/oEB4/il9PyoVHcj80iAq5l8A==
x-ms-office365-filtering-correlation-id: 32cb042b-a586-40fa-40c3-08d67732b643
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0254;
x-ms-traffictypediagnostic: MWHPR04MB0254:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0254DAFA52E8F90398EB67EB90840@MWHPR04MB0254.namprd04.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(396003)(366004)(376002)(136003)(39860400002)(199004)(189003)(4326008)(386003)(2616005)(476003)(5660300001)(6512007)(256004)(68736007)(102836004)(6436002)(53936002)(6506007)(66066001)(50226002)(26005)(186003)(6346003)(36756003)(305945005)(7736002)(486006)(52116002)(44832011)(81166006)(81156014)(99286004)(8676002)(72206003)(316002)(8936002)(106356001)(3846002)(105586002)(478600001)(14454004)(97736004)(54906003)(110136005)(2501003)(71190400001)(1076003)(71200400001)(86362001)(6116002)(25786009)(4744005)(6486002)(2906002)(41533002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0254;H:MWHPR04MB0401.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: foRCaqCyT0qzs8Vx+itwq27j1QE9mAlOVSLL41HurfAIwcu2nSm+5kS3OrDvOR2ulr/KR2+hSOkDrP2Rl0OhZDcrn13kfrccvu0FXg6phNpHfF+RytQDxOHUFtRATPTxpaEJqLgNFwKpc/IZUReAgnrcfuyZYW8CTOlT9ovZUkBXGwduvtXZxFQtNCim0Mc+vS/CG28QiEYS7mpeGyIC5jKFApqvpKSbyu8AvkbyP/yb1AmO6uiW3H8q+1AGksrkey3unLtCIegeOSCwt+2joDNQkhXkabNzn8cwXMcwV5EKWJboEGbaicEhpu+yPMgco7oKAOAEZr21yzFY2FA8B2haZ8G1pnWFANY+h8QGWSSU7mMd8saWg5bxvyvOI0THrl+8rMak7/unRC5psYksEoX2FQ2RnEO1fMuwKo0qRlPrDzu4w2cS4RjGKwZK5PJCPldkJQ87Fo0K4Ukhi5D2Kw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32cb042b-a586-40fa-40c3-08d67732b643
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 19:35:01.2727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0254
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable generic PCIe by default in the RISC-V defconfig, this allows us
to use QEMU's PCIe support out of the box.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 arch/riscv/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index f399659d3b8d..ccfd3f05223c 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -14,6 +14,8 @@ CONFIG_EXPERT=3Dy
 CONFIG_BPF_SYSCALL=3Dy
 CONFIG_SMP=3Dy
 CONFIG_PCI=3Dy
+CONFIG_PCIEPORTBUS=3Dy
+CONFIG_PCI_HOST_GENERIC=3Dy
 CONFIG_PCIE_XILINX=3Dy
 CONFIG_MODULES=3Dy
 CONFIG_MODULE_UNLOAD=3Dy
@@ -77,5 +79,6 @@ CONFIG_NFS_V4_1=3Dy
 CONFIG_NFS_V4_2=3Dy
 CONFIG_ROOT_NFS=3Dy
 CONFIG_CRYPTO_USER_API_HASH=3Dy
+CONFIG_CRYPTO_DEV_VIRTIO=3Dy
 CONFIG_PRINTK_TIME=3Dy
 # CONFIG_RCU_TRACE is not set
--=20
2.19.1

