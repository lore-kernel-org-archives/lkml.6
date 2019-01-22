Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC23C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF1320870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="YdNC/PeT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbfAVLL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:11:29 -0500
Received: from mail-eopbgr40085.outbound.protection.outlook.com ([40.107.4.85]:54205
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727883AbfAVLL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:11:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDf5sprw13r42LZUBrHvTBKyI4a/XRowtsq/dDIv/9k=;
 b=YdNC/PeTUAS+hw3Gh7WwilPJQVDNBU6pMYt1+NO9U04W6nTPfV0TemstfAVG0MS6zK4G0DCZuqit9fJj5ovz3du9UZmhl5a+hD+UkHxWM3P8IfEcIeNO5QCmraBekC/9jjr40FSqkIStqvok44A6NmzF7ZvyG83OhdVwet1mOgY=
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com (10.168.81.21) by
 DB6PR0801MB1286.eurprd08.prod.outlook.com (10.168.11.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Tue, 22 Jan 2019 11:11:25 +0000
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33]) by DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33%2]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 11:11:25 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jin Gao (Arm Technology China)" <Jin.Gao@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>, "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v2 07/11] drm/komeda: Add komeda_crtc_vblank_enable/disable
Thread-Topic: [PATCH v2 07/11] drm/komeda: Add
 komeda_crtc_vblank_enable/disable
Thread-Index: AQHUskM2Offx3k/8a0u5t7UUjoQMeg==
Date:   Tue, 22 Jan 2019 11:11:25 +0000
Message-ID: <20190122110932.5138-8-james.qian.wang@arm.com>
References: <20190122110932.5138-1-james.qian.wang@arm.com>
In-Reply-To: <20190122110932.5138-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYAPR01CA0034.ausprd01.prod.outlook.com (2603:10c6:1:1::22)
 To DB6PR0801MB1990.eurprd08.prod.outlook.com (2603:10a6:4:6c::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0801MB1286;6:Bm0NWMcuLxBv9+INUtBGMcytb3Bc9HX4B63keAFidizqME35oqLJ46JGDDPdgG0glfv6DVjr6AN0h2NzlQ+YRdsXWjqcze4l3jg+AoLgSpAM5xhRP1yu+ycikAYbz8Zi+r09FXgrKKddaUuD5jqNgmfDk6oyRWgyPnFB02FO4jXpN79gJ/JEbXy0ZZC1kQHi2tHk9onqxbbtDxV+4ppmuRY8hbClDWfc+K5dwGRGt+q5M9LTz+AgSGUAC9PlqYo3BC0U+wseakf6ToKfMzn9yvFfqdx/tU8j3Ub6bBxdy2H0dLTNOhPRpgFiX2IqNjn7ofmNZ/60nCkODtZa5khxDcBndWdqQ0iBNqIMw2cnx7ZX3/Ax0q3HGZcMob9jOyRRl0s4QIyGiB9ejtYT4D7fdCVJt+SsrZ4y+n+ap8LRzPGjYr1/6nwmK8pcA5zHW5kuCF7fln1F2oeq0jgScQf4Zg==;5:+iIZ1R3TdL72OIUVvJxIFs/hWEx7DyIxct9T9FIPoW1FOpZRN2XNbRkVN+0TKzn89rPKHuNF3HwY++XQIU+041fpxP+76AQrqYloIW4A+ZO4Xku50aPxuGnVUcpOebBbW+edlltmi+/bhKgvniOBwK7w/LJ5ML0FWPwLUQQ9SrvjKfD7oDzSqPlQ0NjGHunayTUbiB7Ybz2DU1hrPo1pKw==;7:noJt5FlEdL4i/7BW1YzrJ/ApAdgpV/TiXOVYU0dqKASPiegQHCyOmhaSLZFSlyKikoLhCXSaggRUI4O3gQumvrKPgNTyIEStFb2pfSbi65Fv9kykhvqIacQT4dKV2taXKrjH5RTNWLzlfqVKkQPkwA==
x-ms-office365-filtering-correlation-id: ae322f7a-d31d-4227-785b-08d6805a58e5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1286;
x-ms-traffictypediagnostic: DB6PR0801MB1286:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB12860476C2F6F840A228ED74B3980@DB6PR0801MB1286.eurprd08.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(366004)(199004)(189003)(2906002)(25786009)(86362001)(36756003)(6116002)(3846002)(4326008)(6636002)(6486002)(103116003)(66066001)(105586002)(106356001)(6512007)(2501003)(53936002)(97736004)(6436002)(446003)(68736007)(81166006)(476003)(50226002)(8676002)(71200400001)(71190400001)(316002)(6506007)(52116002)(81156014)(486006)(11346002)(110136005)(54906003)(99286004)(305945005)(102836004)(14454004)(7736002)(26005)(76176011)(386003)(55236004)(1076003)(8936002)(478600001)(2616005)(186003)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1286;H:DB6PR0801MB1990.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oBEG/kp07WWIeWvZYDHiIXLd3biMnn10K+8v36LJr7YkdZLMKSGBwh36nUwkNPyIpZUOpV+wUTfOcIXJuF63XXOaV56Evwb8Fx0GW6zPywVkcdje4OQ0VVMWGzkVcTjHOQ4Q1JAgxCbR+d5ZcC0FxVNdFXQB79Oa0jmEXvIUjCKkFeW4kAvflCifBQA5sqzZztRz5tx5OoZ1lY9GUnBTcJrrQb1OruFtVWfDDTzbspwuXDVhziDu8ltxMLrUB3o+cI+GWgKda3ocuf73ErDUd2/9aoa7NR98sQmRxKDjbiLN84/dpKCq4IQzDa874zwG9iuAU0ezovsRLQnGCv5Y4/ik93Z96CZ91kV4jeSIZlXl2Uu1bo1KxcJ5a1faxe0XE6PZAJrRrxCdMXKH8leZozCPzggNT7XOwcitmNouViQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae322f7a-d31d-4227-785b-08d6805a58e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 11:11:16.5567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1286
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>

Add a new komeda_dev_func->on_off_vblank to enable/disable HW vblank event

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../gpu/drm/arm/display/komeda/d71/d71_dev.c  | 10 ++++++++++
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 19 +++++++++++++++++++
 .../gpu/drm/arm/display/komeda/komeda_dev.h   |  3 +++
 3 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/gpu=
/drm/arm/display/komeda/d71/d71_dev.c
index 2fb29aea9f69..f517ab0ceae9 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
@@ -241,6 +241,15 @@ static int d71_disable_irq(struct komeda_dev *mdev)
 	return 0;
 }
=20
+static void d71_on_off_vblank(struct komeda_dev *mdev, int master_pipe, bo=
ol on)
+{
+	struct d71_dev *d71 =3D mdev->chip_data;
+	struct d71_pipeline *pipe =3D d71->pipes[master_pipe];
+
+	malidp_write32_mask(pipe->dou_addr, BLK_IRQ_MASK,
+			    DOU_IRQ_PL0, on ? DOU_IRQ_PL0 : 0);
+}
+
 static int to_d71_opmode(int core_mode)
 {
 	switch (core_mode) {
@@ -498,6 +507,7 @@ static struct komeda_dev_funcs d71_chip_funcs =3D {
 	.irq_handler	=3D d71_irq_handler,
 	.enable_irq	=3D d71_enable_irq,
 	.disable_irq	=3D d71_disable_irq,
+	.on_off_vblank	=3D d71_on_off_vblank,
 	.change_opmode	=3D d71_change_opmode,
 	.flush		=3D d71_flush,
 };
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
index 9b370e1232e2..e19ba9468d31 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -347,7 +347,26 @@ struct drm_crtc_helper_funcs komeda_crtc_helper_funcs =
=3D {
 	.mode_fixup	=3D komeda_crtc_mode_fixup,
 };
=20
+static int komeda_crtc_vblank_enable(struct drm_crtc *crtc)
+{
+	struct komeda_dev *mdev =3D crtc->dev->dev_private;
+	struct komeda_crtc *kcrtc =3D to_kcrtc(crtc);
+
+	mdev->funcs->on_off_vblank(mdev, kcrtc->master->id, true);
+	return 0;
+}
+
+static void komeda_crtc_vblank_disable(struct drm_crtc *crtc)
+{
+	struct komeda_dev *mdev =3D crtc->dev->dev_private;
+	struct komeda_crtc *kcrtc =3D to_kcrtc(crtc);
+
+	mdev->funcs->on_off_vblank(mdev, kcrtc->master->id, false);
+}
+
 static const struct drm_crtc_funcs komeda_crtc_funcs =3D {
+	.enable_vblank		=3D komeda_crtc_vblank_enable,
+	.disable_vblank		=3D komeda_crtc_vblank_disable,
 };
=20
 int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms,
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.h
index 1ad1f6e49854..8acd25afb3e9 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -103,6 +103,9 @@ struct komeda_dev_funcs {
 	int (*enable_irq)(struct komeda_dev *mdev);
 	/** @disable_irq: disable irq */
 	int (*disable_irq)(struct komeda_dev *mdev);
+	/** @on_off_vblank: notify HW to on/off vblank */
+	void (*on_off_vblank)(struct komeda_dev *mdev,
+			      int master_pipe, bool on);
=20
 	/** @dump_register: Optional, dump registers to seq_file */
 	void (*dump_register)(struct komeda_dev *mdev, struct seq_file *seq);
--=20
2.17.1

