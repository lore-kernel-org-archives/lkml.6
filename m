Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33A2C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22DE2081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=MicronCorp.onmicrosoft.com header.i=@MicronCorp.onmicrosoft.com header.b="UksWh+6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbfBDLii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 06:38:38 -0500
Received: from mailout.micron.com ([137.201.242.129]:23722 "EHLO
        mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728376AbfBDLii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 06:38:38 -0500
Received: from mail.micron.com (bowex17d.micron.com [137.201.21.212])
        by mailout.micron.com (8.14.4/8.14.6) with ESMTP id x14BHoWg004522;
        Mon, 4 Feb 2019 04:17:50 -0700
Received: from BOWEX36H.micron.com (137.201.84.179) by bowex17d.micron.com
 (137.201.21.212) with Microsoft SMTP Server (TLS) id 15.0.1365.1; Mon, 4 Feb
 2019 04:17:50 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (137.201.84.23)
 by BOWEX36H.micron.com (137.201.84.179) with Microsoft SMTP Server (TLS) id
 15.0.1365.1 via Frontend Transport; Mon, 4 Feb 2019 04:17:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=MicronCorp.onmicrosoft.com; s=selector1-micron-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAWJQLWImA0iVORAzUIu9bTNyFQprNO41VcjqCJNFOQ=;
 b=UksWh+6yqaZxr3mrBl/WUv0B2hahnFZqL05FIFfEMxxdMixXuAIRu3+sThiFwKODkOuZy6eArGAgMC5nqOostmlgWRXu+OqlgTuRvLAU74JOdHLPs7dXrFH48rHXKsu9eDU6v+VJq42bQxzywLIpB4lm8MgtcrTXEVMwWqrT4Yw=
Received: from MN2PR08MB5951.namprd08.prod.outlook.com (20.179.98.155) by
 MN2PR08MB5870.namprd08.prod.outlook.com (20.179.87.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Mon, 4 Feb 2019 11:17:48 +0000
Received: from MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::8cda:e314:bfb0:41fe]) by MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::8cda:e314:bfb0:41fe%5]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 11:17:48 +0000
From:   "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        "Marek Vasut" <marek.vasut@gmail.com>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        Schrempf Frieder <frieder.schrempf@kontron.De>,
        Chuanhong Guo <gch981213@gmail.com>
Subject: [PATCH 1/2] mtd: spinand: Add function to read parameter page
Thread-Topic: [PATCH 1/2] mtd: spinand: Add function to read parameter page
Thread-Index: AdS8ertbcMMdpjNZRpS2VbhqufpNzQ==
Date:   Mon, 4 Feb 2019 11:17:48 +0000
Message-ID: <MN2PR08MB5951266775CD73E7B03BADD0B86D0@MN2PR08MB5951.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sshivamurthy@micron.com; 
x-originating-ip: [165.225.81.44]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MN2PR08MB5870;6:ufncwYVv/btdsKl+9uSFSi9WO6CKkoNglGmI+IidAvu10c7j9h4JvhlS/rzB4neCkRV0NaKHA95omC3d/awVRemaeDsxRKqGxxkL5+cQ2VO1YqPG592ejg5U8/xsePgsEAOYfkDcUIFYeKrKSk3Swi8eNxF6u8srByV4SphiVsa3WR8WhFB3JAnDZ6dd2OFAjZ1v2RhXbXyOutsT1Nplg5UxakfWloLgAPZSIBccW46+kJVo6mFEHF/ePNXHSY1av0Z/9VOARJm92jlefHALL1Ga2baEa3DbDswXExfFfZrGj5AImKQ4sQq/aVyea/OABr7kSpuV2lQj9j0tVZ1cWijNuLOQQUmvKZP4bj+sNjbNnN4JI+hcMsGf9bVFBSm8zRxRKQ39ZQ1/cXvWHHJBGcunTcZcgnT6U5U00BoxCsnbpBA0BEblRIPi/NpWkZ2qnzykULlzzRAZO0VYWPmBRw==;5:oYpS6qgau6bhrjdb74O6a9k1Sw+QFcOesC0zIuMFNDE/2gKTQT8nWADMGNdgjT4+FRcxgxlk7aTFrumHr2HddajUmZGplafKSYP2ePPp6R9k88XbpHatCOj0Y6RBd1RlJsNIwzpyQ1BPbl+6RQhK29UuRsjwFwKxzyBd3WhErtCeLyoBMnRyozDWvO0zHUxulHb2HXvx2JZ4dC4zMJyCfA==;7:lea1ac/dWeVn+YzarQemcLzY8njHbFu5CszlYJUDMBF5DxsAJhqtSuYUuZq9xvjf8UVKVSd6E6CvzMIgzFvjwNOLNeK0soG+y+b2IHTNGruf5aS+ntLEOjHCJGR1TqT7V9wTJ1F8VO7Tx1SDX/Bk9Q==
x-ms-office365-filtering-correlation-id: 513c54f2-d20e-4aa9-6dcf-08d68a926555
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MN2PR08MB5870;
x-ms-traffictypediagnostic: MN2PR08MB5870:|MN2PR08MB5870:
x-microsoft-antispam-prvs: <MN2PR08MB58707D160AFC22878C05C15AB86D0@MN2PR08MB5870.namprd08.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(396003)(39860400002)(376002)(189003)(199004)(186003)(54906003)(26005)(110136005)(2201001)(25786009)(9686003)(316002)(476003)(55016002)(7416002)(486006)(86362001)(66066001)(6436002)(14444005)(7696005)(14454004)(71200400001)(71190400001)(478600001)(97736004)(8676002)(256004)(305945005)(3846002)(7736002)(2501003)(6116002)(99286004)(53936002)(74316002)(106356001)(8936002)(81156014)(81166006)(55236004)(105586002)(102836004)(68736007)(6506007)(2906002)(39060400002)(33656002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR08MB5870;H:MN2PR08MB5951.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Q2iruqsbf+MgoR3JT7712r9G8MU4nv6tYeiScJgqOrtcAnoygGNtAn2dfnU0batCxhSLmTuD/7tOBHvfnMNgMKcY1srQZLI654zIvQkJCoewS/dEO9R5SBIboWc+WeaEKkBEol1yqSetwQqOV5VavW8YEdUjOipH+TooilmN//xDJMSfL5wibtIxFORMWXu+Fkiae+pl5KIOAwbXidI+xJkdZMQnCYKvGHnUlkGOpxuKPK1Dxx3141/R+ZuGc261Wxw/O+u7Pm4Qbx3RKj3ByPQynZMAVS6I0zpIBXqousDl1CFvxxEXvhpv7WFX1gUEyzskJWyS0UObzaFPBUoRJZFjk7FCc2mFHaMR/rjc7vUWFZklAInI0lsOxfY5wCS3FukxP6sIknVNzUIHH4gKg966JkV9ZvqMpzTuZmrPYzg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 513c54f2-d20e-4aa9-6dcf-08d68a926555
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 11:17:48.8709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR08MB5870
X-OriginatorOrg: micron.com
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24408.005
X-TM-AS-Result: No--6.948100-0.000000-31
X-TM-AS-MatchedID: 700038-708712-708797-701388-701475-851106-700648-700016-1
        88019-706290-700398-300010-701594-780052-851458-702911-701604-702426-847298
        -701384-707663-702898-709908-700811-105250-700059-148004-148007-148020-1480
        50-42000-42003-63
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-CheckInternalSenderRule: True
X-Scanned-By: MIMEDefang 2.78 on 137.201.130.65
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the manufacturers support parameter page, which can be used
to get the device details during detection.

This function reads parameter page and this page can be accessed by
set of commands, which are common across the manufacturers.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
Reviewed-by: Bean Huo <beanhuo@micron.com>
---
 drivers/mtd/nand/spi/core.c | 62 +++++++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h |  3 ++
 2 files changed, 65 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 479c2f2cf17f..12f3ace373cb 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -463,6 +463,68 @@ static int spinand_lock_block(struct spinand_device *s=
pinand, u8 lock)
 	return spinand_write_reg_op(spinand, REG_BLOCK_LOCK, lock);
 }
=20
+/**
+ * spinand_read_param_page_op - Read parameter page operation
+ * @spinand: the spinand device
+ * @page: page number where parameter page tables can be found
+ * @parameters: buffer used to store the parameter page
+ * @len: length of the buffer
+ *
+ * Read parameter page
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ */
+int spinand_parameter_page_read(struct spinand_device *spinand,
+				u8 page, void *parameters, u32 len)
+{
+	struct spi_mem_op pread_op =3D SPINAND_PAGE_READ_OP(page);
+	struct spi_mem_op pread_cache_op =3D
+				SPINAND_PAGE_READ_FROM_CACHE_OP(false,
+								0,
+								1,
+								parameters,
+								len);
+	u8 feature;
+	u8 status;
+	int ret;
+
+	if (len && !parameters)
+		return -EINVAL;
+
+	ret =3D spinand_read_reg_op(spinand, REG_CFG,
+				  &feature);
+	if (ret)
+		return ret;
+
+	/* CFG_OTP_ENABLE is used to enable parameter page access */
+	feature |=3D CFG_OTP_ENABLE;
+
+	spinand_write_reg_op(spinand, REG_CFG, feature);
+
+	ret =3D spi_mem_exec_op(spinand->spimem, &pread_op);
+	if (ret)
+		return ret;
+
+	ret =3D spinand_wait(spinand, &status);
+	if (ret < 0)
+		return ret;
+
+	ret =3D spi_mem_exec_op(spinand->spimem, &pread_cache_op);
+	if (ret)
+		return ret;
+
+	ret =3D spinand_read_reg_op(spinand, REG_CFG,
+				  &feature);
+	if (ret)
+		return ret;
+
+	feature &=3D ~CFG_OTP_ENABLE;
+
+	spinand_write_reg_op(spinand, REG_CFG, feature);
+
+	return 0;
+}
+
 static int spinand_check_ecc_status(struct spinand_device *spinand, u8 sta=
tus)
 {
 	struct nand_device *nand =3D spinand_to_nand(spinand);
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index b92e2aa955b6..9062bdbaefdd 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -420,4 +420,7 @@ int spinand_match_and_init(struct spinand_device *dev,
 int spinand_upd_cfg(struct spinand_device *spinand, u8 mask, u8 val);
 int spinand_select_target(struct spinand_device *spinand, unsigned int tar=
get);
=20
+int spinand_parameter_page_read(struct spinand_device *spinand,
+				u8 page, void *parameters, u32 len);
+
 #endif /* __LINUX_MTD_SPINAND_H */
--=20
2.17.1
