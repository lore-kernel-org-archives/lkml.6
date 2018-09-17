Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2378AECE564
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB732147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="HEgTN2OV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB732147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbeIQI2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:28:41 -0400
Received: from mail-cys01nam02on0138.outbound.protection.outlook.com ([104.47.37.138]:10368
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729703AbeIQI2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsK9M7ODrkP67u7ngZGkoIfqtqeSZdZ+T5nwB0Srwp4=;
 b=HEgTN2OVYEbgv+8BfhXUm/3lngTbjwGN7eZ4sd51DIt3N0CohGR0LatCuzTebAABM1YdiPaIohyMS+z8eYvwmGfdUvgpLCFX+YQmOBJ30NAFSScmHmslL9NlLF6AJRoSGbCGqQTS/GHnHt6NpzKcthqSQp6p4LKLoGknyOhLFA0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0118.namprd21.prod.outlook.com (10.173.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:03:20 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:20 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Hugo Lefeuvre <hle@owl.eu.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 124/136] staging: pi433: fix race condition in
 pi433_ioctl
Thread-Topic: [PATCH AUTOSEL 4.18 124/136] staging: pi433: fix race condition
 in pi433_ioctl
Thread-Index: AQHUTjK7O0jECHvsBkiElIn3gybxog==
Date:   Mon, 17 Sep 2018 03:01:29 +0000
Message-ID: <20180917030006.245495-124-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0118;6:Bw3iQvOqQvkxr+LYET7Gd8qfDidisaomvJIL0o49jMaCssUfTR7/vKMC/e0t+gcYp9WJu0szDg0RZXT0bcQdxHsv3bSOdUHaIx83hrAepfU9avhN8Ookpb9WgY4xJe6Xz5mjsOqq5Kjy1ecGuF/YwIKYOi3Uq+ixileutDLqYbB4TqQIKhTXxfaFF/DOg7fdMuM9VxvDkW71QNTcQ+jonYZaaT83olrG4oB9Q6p77u6AqU5yCaY2Esa0/81qoAp6m/JFP4GVpBAZj3/5XL/FMTF+BNHk1OldNZ7ckZZnjPik6Bw7+vRwTy7r+27KhK46AbEFJYeQLEzaVA7bwl+iCLkiPIz+8KLSQ3WCMZsR7ik0g7MVTZSQtlEgDN1oVgT+kC/9BKzWarB3K7w/041j3WmAaqBFV47fsiCDr0KKlv0FRwOy+d0kAHwcAn9RpFnT3ur+iuqWelB3oqw4hJTc8Q==;5:C82hvIQOZF9s5NY1X/HhFrJm/fFTpMU/tlo6lW4aH9jYRR3fMub/SyJ+DG2q7DlKQkzBfJHeZFRxVyimTAfzfnW+dXLJnSxBV1yiChaswucmon7L+JPgO/apkN5st4R/06oCZ/pKDdBvRCAeOJvf0YhavV7TSTkR7OW8FFujekQ=;7:m2DPJ+rA7mIpKULgkSx+3VnHBqn5nPV6Yyl7rPgQy2JU1AcJzmhfH+5fpVCfFXs+GKoksnj64TbxV8geFx1RVyMTenUZzsXnHrZkXL6aBshIsZmiHlsD5SaSKS6zBFIAcFhQ5nd7igv0NhiRYzYbtQR4dBUCFW4g+jLqrxTKOjEQxICHBesn4NcZtf6y3S6TeLjsvuPNYGVcaEyC4/2UTknJxxJ70Wz0tf4hjjh+KqmPE4pF+eE0SbZu6ZcUcx07
x-ms-office365-filtering-correlation-id: 395e5167-b42f-42ed-0e13-08d61c4a1fb5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0118;
x-ms-traffictypediagnostic: CY4PR21MB0118:
x-microsoft-antispam-prvs: <CY4PR21MB0118310A8672C743B39EB1A1FB1E0@CY4PR21MB0118.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0118;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0118;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39860400002)(376002)(366004)(199004)(189003)(2616005)(186003)(8936002)(10290500003)(66066001)(97736004)(102836004)(36756003)(5250100002)(256004)(3846002)(6116002)(2900100001)(476003)(2501003)(14454004)(54906003)(446003)(217873002)(110136005)(486006)(11346002)(6346003)(8676002)(575784001)(86362001)(26005)(72206003)(81166006)(81156014)(86612001)(14444005)(478600001)(25786009)(105586002)(2906002)(99286004)(68736007)(6486002)(305945005)(7736002)(76176011)(6506007)(6512007)(53936002)(22452003)(1076002)(4326008)(6436002)(316002)(107886003)(10090500001)(106356001)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0118;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 3t6EdsmdUDa9GZ5rV4+L845ZKlNZlPG3kic4PvAf71BFDNZcgSlKUs6IcwIAZsVw9KC3E2FBYekVBPjZ2sdZWmx1IUkVHao3I8tfbrBLu7AteNitN02ikmY1ImWqc1zP98LrX17eaCabotW2EtZd+BvJWtPK1UCta1w1RpWiBURNqR+GidBb8FrNyC3wbezQmfkt6JuUiVhLrP3DdW/O8TQC+r62Qbm0EeIHkZW8iJgtr7O+F4+kxhgRTuQXVjLjhTi6xCcdB8w4p6ZRIAsBvROtUEdYP/zuEFs7cnk1+YZsZMSfoqA++s1SyXrRLV+vykj2Rgz5ZgWqgIS9FLKMU053Iwgwg/cgBBteSPpUTB0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 395e5167-b42f-42ed-0e13-08d61c4a1fb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:29.5727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Lefeuvre <hle@owl.eu.com>

[ Upstream commit 6de4ef65a8c6f53ce7eef06666410bc3b6e4b624 ]

In the PI433_IOC_WR_TX_CFG case in pi433_ioctl, instance->tx_cfg is
modified via

copy_from_user(&instance->tx_cfg, argp, sizeof(struct pi433_tx_cfg)))

without any kind of synchronization. In the case where two threads
would execute this same command concurrently the tx_cfg field might
enter in an inconsistent state.

Additionally: if ioctl(PI433_IOC_WR_TX_CFG) and write() execute
concurrently the tx config might be modified while it is being
copied to the fifo, resulting in potential data corruption.

Fix: Get instance->tx_cfg_lock before modifying tx config in the
PI433_IOC_WR_TX_CFG case in pi433_ioctl.

Also, do not copy data directly from user space to instance->tx_cfg.
Instead use a temporary buffer allowing future checks for correctness
of copied data and simpler code.

Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/staging/pi433/pi433_if.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433=
_if.c
index b061f77dda41..94e0bfcec991 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -880,6 +880,7 @@ pi433_ioctl(struct file *filp, unsigned int cmd, unsign=
ed long arg)
 	int			retval =3D 0;
 	struct pi433_instance	*instance;
 	struct pi433_device	*device;
+	struct pi433_tx_cfg	tx_cfg;
 	void __user *argp =3D (void __user *)arg;
=20
 	/* Check type and command number */
@@ -902,9 +903,11 @@ pi433_ioctl(struct file *filp, unsigned int cmd, unsig=
ned long arg)
 			return -EFAULT;
 		break;
 	case PI433_IOC_WR_TX_CFG:
-		if (copy_from_user(&instance->tx_cfg, argp,
-				   sizeof(struct pi433_tx_cfg)))
+		if (copy_from_user(&tx_cfg, argp, sizeof(struct pi433_tx_cfg)))
 			return -EFAULT;
+		mutex_lock(&device->tx_fifo_lock);
+		memcpy(&instance->tx_cfg, &tx_cfg, sizeof(struct pi433_tx_cfg));
+		mutex_unlock(&device->tx_fifo_lock);
 		break;
 	case PI433_IOC_RD_RX_CFG:
 		if (copy_to_user(argp, &device->rx_cfg,
--=20
2.17.1
