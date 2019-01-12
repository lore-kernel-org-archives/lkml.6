Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2921DC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 00:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A492084E
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 00:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="U7uTz/vT";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jGVQ/y86"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfALAlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 19:41:40 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:9932 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfALAlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 19:41:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547253700; x=1578789700;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=JwAenho7FTcjd5WEdJxsjab3dQXD/UydIQDlMOj+2lk=;
  b=U7uTz/vTrns2T4MHIo1IsJ1YJQUIrBgMIK3BxdL5nPj8GZ7Wqnc8T8RL
   CqmIjkV1AE8EppyHxG/AfAQDwAbAm33bcrYJ2NjwKdqStEC9WYNgChEeC
   lStudnWlGb6uuH5bJbWYA8M9HoWSsz5kUBHFPBr386+1IlBB5blzc7vZl
   +H91YRp9Zj64h0FnYFWlnLXWTUFyki0DvioIRtr+e+cotRxP1c5RoYKMQ
   IefXQtW1pZE62FGV2PCnJ7Ryxhhh5x/IffgLVfz5KDZGYYTLwLGV+dngn
   a2q/WbG5g5L0qmQspNJ3KYsgAssXM6yFCx9JEJC+uqI1gzQ0Qz2MrYr8n
   w==;
X-IronPort-AV: E=Sophos;i="5.56,467,1539619200"; 
   d="scan'208";a="98600984"
Received: from mail-dm3nam03lp2059.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.59])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2019 08:41:28 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwAenho7FTcjd5WEdJxsjab3dQXD/UydIQDlMOj+2lk=;
 b=jGVQ/y86/i/txeJBwQw2JgctPNbTec4NNpslqfiuku65lqRXyjf9N5zK1BmXSkdZaHx+FCxkcCHmcm7Akh1w6DEfXQmSqPgcQnOqk/FEYdxj6/ndOH4ejZufFxH03jjZ/C2Bl1CQhNUMb8dzmD76ZndaEQXKUapxBAXZKIuPfC8=
Received: from CY4PR04MB0392.namprd04.prod.outlook.com (10.173.188.145) by
 CY4PR04MB0808.namprd04.prod.outlook.com (10.172.138.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Sat, 12 Jan 2019 00:41:26 +0000
Received: from CY4PR04MB0392.namprd04.prod.outlook.com
 ([fe80::4538:eeeb:57c0:3d91]) by CY4PR04MB0392.namprd04.prod.outlook.com
 ([fe80::4538:eeeb:57c0:3d91%6]) with mapi id 15.20.1516.016; Sat, 12 Jan 2019
 00:41:26 +0000
From:   Alistair Francis <Alistair.Francis@wdc.com>
To:     "palmer@sifive.com" <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alistair Francis <Alistair.Francis@wdc.com>
Subject: [PATCH v4] RISC-V: defconfig: Enable Generic PCIE by default
Thread-Topic: [PATCH v4] RISC-V: defconfig: Enable Generic PCIE by default
Thread-Index: AQHUqg+MM4/QLJnNHUmA1qDrkrtO7Q==
Date:   Sat, 12 Jan 2019 00:41:26 +0000
Message-ID: <20190112004117.28265-1-alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.19.1
x-clientproxiedby: BYAPR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::37) To CY4PR04MB0392.namprd04.prod.outlook.com
 (2603:10b6:903:b1::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.170]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR04MB0808;6:W9P1bBgTI3W7+1oKVpfn/msq0b0aqajPE+HwdQABrqg8mSRudoI09JXfFWqQVGsXCBcSs0h9BW+fS1bkmaSW0Ef7jylNvQsE5ItXz+WqFwQxtgycSnVnW3iO/kiVR6eZ70ULihrv/mjdcGyvR44xL0XRytAeNPmgFlPyQbNW/jWE119DWZ+2KpjfsFlbLL98V5sPvhAZoreZdHXcuqgGPWB36/Bjth9wL5klEksWVSuS6NovnrqDI0KT3YNPuTWsCO2s9rBSzQoyV1tFruCwVJWvVgjaOyKHVoISvpjtHGAV1mMH8WzDAgDvQpPC6dPhn4juceMhxBP33Zw4ycwePIcY60F58e4Nfw4leLaWP0BVbY+aZyKo9EE1Y09MjDSRh7m44KaDwO0HAUJAW4++BVaeAkn6eJPT3DtVI8Z+iI2MjdeF3OZFlzADA/1ciHHO+Leidh/E6opzjsBxolSh/Q==;5:+/stFisyWEfXscqolRCeK2jhR27iT3NPq7bI5cMejrQaJ/FH/eP5Qqb1iyJr4Gob1i5YM/kx7VUK3C8ivFDdoq0Lt2bd9Q9nqPETMJC/zge7ia9/Fcjns7uQeEMYeHbV/zGEvGGYcDjpBb8/qhLvzC0BUsBVnVHP+L3GfsISS41EO2PV9y9WMNrB58nb7CMc3Y7EYOl3h/sYwnDS/TpFCw==;7:PliIwCzCEXQvWMK8QeYERGzElmg3x5vr74KKNthgWLetcpXyCvf8rxJzerN0SRFB/INm4BkmINzFp51i4CxtDMUl5CKNHvMniQ/8AcB4/n7ZCWvtjuLknIFu2q/q/IWBNU3WQygl3Mq46bbAlR1PZQ==
x-ms-office365-filtering-correlation-id: 9e0403b8-e945-4713-64f6-08d67826af0b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY4PR04MB0808;
x-ms-traffictypediagnostic: CY4PR04MB0808:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <CY4PR04MB08080EE61D82C52EBCDDAADC90860@CY4PR04MB0808.namprd04.prod.outlook.com>
x-forefront-prvs: 0915875B28
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(199004)(189003)(54906003)(6512007)(72206003)(50226002)(66066001)(36756003)(71190400001)(71200400001)(7736002)(305945005)(105586002)(25786009)(4326008)(498600001)(81166006)(81156014)(3846002)(6116002)(110136005)(106356001)(8936002)(8676002)(2501003)(14454004)(4744005)(99286004)(52116002)(1076003)(256004)(86362001)(14444005)(6486002)(68736007)(2616005)(102836004)(386003)(6506007)(186003)(26005)(476003)(5660300001)(2906002)(53936002)(97736004)(6436002)(486006)(44832011)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR04MB0808;H:CY4PR04MB0392.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vXTKY952JUON24yVHwKVSKFq5pyKO5knR3v9HkSl8ctvqbHLAwzSwVTMqStY1XGnLYb4Sel77qvPIPOznV+WxWF24XH6Jp+7F23FoAX5QnkimoGLBm3vYrEOT14cKXEUkms1mq97BHx9osyDW27fqNr7uu0dbmnNk/LTtYTR1LcbC5Uidq8iIXYeZumZH/BjBXt2m9CiYYzjfwqjq/xuahgt10eYU9dmGm+goU8b1Lk0a5CjFGi6Yc+GX2dIflE29HzntPSpYa3yRRwSENA4oxyVl0FG6BYbR/RwzTO6oOXb2h0vAvqM+lGrILrriUczYi9eTIs4fLe4gPMriNuEcKXlfMNiSeGdZcSTt0pUw0gO7L3eNov9SLLIe2zeqeCzJ2ixd4u4qoKmhYErW6NCi13DJV/4Hz3ulmzjn0MvGGM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0403b8-e945-4713-64f6-08d67826af0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2019 00:41:26.3322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0808
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable generic PCIe by default in the RISC-V defconfig, this allows us
to use QEMU's PCIe support out of the box.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 arch/riscv/configs/defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index f399659d3b8d..7c86bd71ae68 100644
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
@@ -63,7 +65,6 @@ CONFIG_USB_STORAGE=3Dy
 CONFIG_USB_UAS=3Dy
 CONFIG_VIRTIO_MMIO=3Dy
 CONFIG_SIFIVE_PLIC=3Dy
-CONFIG_RAS=3Dy
 CONFIG_EXT4_FS=3Dy
 CONFIG_EXT4_FS_POSIX_ACL=3Dy
 CONFIG_AUTOFS4_FS=3Dy
@@ -77,5 +78,6 @@ CONFIG_NFS_V4_1=3Dy
 CONFIG_NFS_V4_2=3Dy
 CONFIG_ROOT_NFS=3Dy
 CONFIG_CRYPTO_USER_API_HASH=3Dy
+CONFIG_CRYPTO_DEV_VIRTIO=3Dy
 CONFIG_PRINTK_TIME=3Dy
 # CONFIG_RCU_TRACE is not set
--=20
2.19.1

