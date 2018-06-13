Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DBA59C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858D120693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nrhdRZO9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858D120693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754513AbeFMGLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 02:11:07 -0400
Received: from mail-he1eur01on0041.outbound.protection.outlook.com ([104.47.0.41]:63148
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754377AbeFMGLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 02:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IZDUrxApzIbRJRqnvcrxXeg4tCx5ueRpaaEZjsVG5c=;
 b=nrhdRZO9YkSEcRhav4xqPMl7/hzn0XhHWTm6jguqjnSd7a8CfsVlXX0mzuH5p49qH/24iwvbYUF83BQNrcQPNc77WJLGL2a2kU+LRbsYORt3jB/Xh/QBn99aiI+EHWZkGyma5q39hEtOGUJJlX4FlpQHSjxFWHe8HFDCi+ysP0Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
Received: from idcbfarm.ap.freescale.net (14.142.187.166) by
 HE1PR0402MB2842.eurprd04.prod.outlook.com (2603:10a6:3:d6::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.18; Wed, 13 Jun 2018 06:10:55 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org
Cc:     boris.brezillon@bootlin.com, frieder.schrempf@exceet.de,
        computersforpeace@gmail.com, david.wolfe@nxp.com, han.xu@nxp.com,
        festevam@gmail.com, marek.vasut@gmail.com,
        prabhakar.kushwaha@nxp.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH] mtd: devices: m25p80: Make sure WRITE_EN is issued before each write
Date:   Wed, 13 Jun 2018 11:39:18 +0530
Message-Id: <1528870158-14781-1-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: TYAPR01CA0134.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::26) To HE1PR0402MB2842.eurprd04.prod.outlook.com
 (2603:10a6:3:d6::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 59da6190-bcb7-44ec-b6b7-08d5d0f46fe4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0402MB2842;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0402MB2842;3:QzS4M2CF5QclXWR+U6SjmmZ3YjgRfBCZm0FyeGTB0plgqdGS/RePuTIfWemFRnwv98Z1w26iRAaxfpr+TQhGjt/2bNrEN3P+7YZpuD+45lJQ4PWBYKfafEM5IYDz3i1rtrp8aUYVVJIieDGdLcHgfT0OQZOb+UO1FOAaGzI89iY+KWvzdtxIjkUuFxV+7/vsYiXvBgMYhbj0PkZ3q6/qa9YvYR+U8LK+Zv40bQobAlHkw2qEPK83lX0AXLxVjHGu;25:C4iwy+oFxkJQYrimXGD/KCm5GLn4QLYZY2SiV2Yfvg0jt7sjmWfSAZBB8PR03PqrQJJ9joW20DYOHQqtnN9PgLq7KG+aEDOTvT7NdKtnLqdhztoMtG04WzBpGsCxu7GE/HU+Li8FZ4LIQsa52H9XxI48TJQw8UXHyuEHpVZCwBxZ9RupFMKKSgzLVPGyv+KUmkaZLiIb9t2EEY/R0cepV7omx5UhybWO43fLmEnPbGAMDeQe7qA7jVUXE7qO0ncyOR57OM3KYSYHi81bu8gXHoCpeLD3BFhDewyjjTqGpWUI9j5B1BF2rhec6lB5eaSzQfNyFcMqUFAwE7Q3vfdypw==;31:aD2dunXadi5PoF4GJqMUDm9+xmnAwgl4KU7YXzNgV3Rocpl/+S+OD1g8CwJgo9QMKmWeFj7hafejDowXG0SC1+6SWMiJuvRM+XQlISfpXQqsfw+bRGSUkbxYSQEEWFvfBkTs0JwLHyHZRnken7Cvise8Ya/W29fIYm6Ky+C+bLgloz7IeY7+Nx3tuAW9br/UKYhQ0IraYawJq3UpnePzj+NWx2huqe6GupCJQYZqrc8=
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2842:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0402MB2842;20:uDpyc68Jo5rIlihQzA8h0OTjMIE3x3hyYpx78RvKk+R4X35T5MlthlrmhwaipFT1vbqL0Np6kMKB2iJ0SBu7bMK2mtgVYpboQuSmCVB8WD6u/QyiXlrDQPQ+QuOmpJbr3T6NTKxERxP9OdOfYK2iY5cUoKlnKipqjN/mTRBPy/+wc92ROTarNviYyYiySDhAmnJTdCIXzbF6f5eVNUWkN2ahyvTyrmNuqWoQHJm8aNyT/4yrD1L8ExNn0R7l1OxKlbe1FDgchAJi9eFIy4KiIa4WufZPcSlvF3N5eKp+lFupFzA4k0/XmlsMMZvaNNS1mGYJLmdLlzdDil6FiEApr9FWonlaxtAwhA/WED5UtIutRxA7VQztEbVPy/GCVf/2pKQVy5QH/0qBHddmNI5T4/B4p/MB1hPn9QpxnnBODhpKiDr/N8zLlyE0PCV6j90TXcSMLhqZtPZ+rorfT1ahCOfCDJDeEMtfKvDmxSo8mLyU5xDqKNYYcJ6BRCMcVF6r;4:EuKWFImdYKPrEyyQ73ld3Ljq5TBu923lca7Q4XLJWBuvnq31iFbVUu9ZOHmKGVLOckqqZfVJit2hcuYVAHv8VLEfsz/zMqajV7ASm7/Rn4lS7NUCCqFdDdExxSGrJsQcpXPQUIur2bwDA7yEtbJuHZ5kSsSmbx2SP7jXqS/ilBvEN7GiN2H8vJwrrGClazxXkaNe5Foe6uOz+4A10+LmB78DlQp7rUiKP8OKyt1BYlJJtjqrTp8mO02T/5tV52UWOMy3DS+WmNH0Hpcv/VvSjmNFH2jId+qeeOI9M9C+4aXrHU3cRiyS1JGUTHxrEbf/WdneGZ9mH7sDV/yBpCR2sTp5D7SrC38r4JNOpdeJ+YE=
X-Microsoft-Antispam-PRVS: <HE1PR0402MB2842821642C22338A28EE7A5997E0@HE1PR0402MB2842.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0402MB2842;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0402MB2842;
X-Forefront-PRVS: 07025866F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39860400002)(396003)(39380400002)(199004)(189003)(2351001)(68736007)(316002)(26005)(6486002)(5660300001)(7736002)(16586007)(478600001)(6916009)(6666003)(6306002)(305945005)(25786009)(16526019)(186003)(2361001)(1857600001)(4326008)(53936002)(6512007)(39060400002)(86362001)(52116002)(476003)(2616005)(956004)(66066001)(486006)(47776003)(55236004)(6506007)(50466002)(59450400001)(48376002)(105586002)(81166006)(386003)(106356001)(2906002)(97736004)(8936002)(8676002)(5009440100003)(36756003)(3846002)(51416003)(50226002)(81156014)(6116002)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0402MB2842;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0402MB2842;23:eTq+OCBRoNv9oVilZpkA5ejUvtF4pOynuFHrRCd?=
 =?us-ascii?Q?iJgKhQ9eKf0ET1jdJR8D3RxOTf0USZkvMD5VYVlNQJNLIeQ48kfV3oh8CKs+?=
 =?us-ascii?Q?WCxky/XIh1a9NNRTWcVJEkrFCYmHLu8HGl1sUFmIjIc+IIISM0WrKx8Vjban?=
 =?us-ascii?Q?2N/2zepLkMmlJWq0Zs2bqMQlQ29QrbVpZ+RSHIVXzQoyiiBROAQMvBav5Ywx?=
 =?us-ascii?Q?I8RjkhY9ZT9Tq0PzwDAumlcvmGXnELk6K3lFhlrB8HJvGoxE4b12oorFHPBh?=
 =?us-ascii?Q?dQ9qnCiS+qX58u2tHcS1DZeba0+71aVh9q891mUbAldAE67746F535qvNbUu?=
 =?us-ascii?Q?RAOxdimt9AD7jfHIWYi6srpDK65vlHd6ShxAUjEqm9Dfp4xoyBMLrgwKcSlH?=
 =?us-ascii?Q?49HCAXBnydNUIVYAqyKDErHhEpQ+6Xs/iCHc1AcWFzVqtb4goTcM8MggmFpd?=
 =?us-ascii?Q?EvnbHwWdaBeBspv02oYsD95PFuOhPt9UBHV+LQunyKcpQvKicYhOU0Sy3PfR?=
 =?us-ascii?Q?fZbHCNSRi8OugXsQW//j2B3N1Cwc27RgqXT2wAoQvu83CiCPh6zFDRHz1n5f?=
 =?us-ascii?Q?qztyA5y+V2843yQULiXw/Iy5vlwm67rDgiyrt2MdCNy7YcOC6nz+0jE4oyoj?=
 =?us-ascii?Q?6BzevsDHp720E2JbquaJ6aSn1cZxMmOjLd9RTxDLEMMeTfB8vDN86GXD/iC1?=
 =?us-ascii?Q?JCtMhosGtB7snBx5FCUhHi4CcAaBhMyKszRKrnuphcQOc8ovnSxWiboQQH0D?=
 =?us-ascii?Q?6ddgq+h4JNIU8+i6WJzst4MTkul9Ur6TCSqMO2Qic9bmYvhww9Iw8cOMsMRW?=
 =?us-ascii?Q?9FfMv94dPPIa2n4tz5skw8MOIVSXKDxHvgabe/880ZW4ofl8L0lkskI1mg+r?=
 =?us-ascii?Q?+9PgUgh1fu0AtGz/0rL8qehTiLymKZQE4bcliyejvk3GbwNETaLKx3mMkGPu?=
 =?us-ascii?Q?ULan1MpUabNkv4eNyb+oHCR7DZcstvme4NfvhdZWVQkEUi2LizGh7A5/XaU2?=
 =?us-ascii?Q?pCG/FggxLMi7Ju2T8yuUEU6r87XK311GUrmSuwuai1bd9tvOdxZ+S95CIxpo?=
 =?us-ascii?Q?GMBLmaGZS4em7uHDUinE9s8Yv2MRmlqKdEkgIdXR1v3aUfT0SZcSjF7mPzPj?=
 =?us-ascii?Q?jp1omvSJtryYG/sOPLgFbqJym1olQATI2aKc3Tlh6ddsf46vE9bSJ20XvLUD?=
 =?us-ascii?Q?UeuQmEBOMJ4K19wZJb4UxZHvvh8VjZMFawpCc9fTY6bhVActqS9ES7nCK5lR?=
 =?us-ascii?Q?MlWZnZBS4fB58XUmxI3LcMAW4GLEgPqx1sJb+hOrz538EceQcuf8h3FdZf+D?=
 =?us-ascii?Q?K84VC9srfzALitUkJ8UN9SW4uXCljObDeORbfjQsCVlnr?=
X-Microsoft-Antispam-Message-Info: u9QA8MJY0MALnEpKOqFGMjjlE7+jq4+n3P7H//JQraMoP1L0uuxNLOZQnBb9z7pjvPzUxmuy4JoOsD/ETBZ2PlbFAA7sbKvf8iPS+OhKrHUTzCn1YgQpRkj2p1vcmKUf985iM739/Hf7uGqZZ55lNk4Nutknl1whANiwTtpKwJtAV/fprAsIWsdknz4yCL4S
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0402MB2842;6:8fWgshsW5r9aL0lohM6lxvr+Z29q4a8mdkHHBeda5Arc5+2C3pzIxGYTP59DBdAHcvdy+WMqKyFHFWx8xfJ485r6zuFP3CIc+vJZYOS84oqbxgdP50vveUA+8T2nNSnXofPu5zEwBAQdwERc2vRIuZNOiXDFw+8Hw4RSzYNIw7ayQx/Q9HruhaTRKlmIz8djiX/SowkgnPgbBVciP8fa3fxTcBK4v38uuBL57psZwEYZb2uL316eim2M1egcyIlUdKcri8P0Xf6tuT/m6/wQN59AhOH+3p+nE4/pa6hCL8RT0O1bwu4KBdugBolSXk4GeDx0BMqPRblK15x9u1hrN7HBmNgy5ntze61A+n9pO6X+j/7ZnZ4zfrHienuXSFxP8ll600nYxiLzvBj8DWTyl/tK0bBQ85IrkNJ5BFUdcak8liXrbBCozoXA8IUKYkk2Wy+jBALjPPoAc/oKq3YL8w==;5:7mmlAX5Ln+GPLJoRkszeQjcZR8VJ+rncj7vJu0zNQm5Y8/00JU8LVmBiL6kh8yOY5Uy9F4U9sPgYy/sj7KiTeB2OgLul1wsJKEsYGClt6o5V3kZJ+qO1hmgIJxgMAAYi12/jeKaC8Kd/fzZplmprpJcgkUyfUMl1wXH4LS9ZYwg=;24:zuuSBN8hVwfHovSNZi73e7C/BM3PlK6yeDSVDCeVBYW3Ab3orf9NmG1d/oksn7AvwtYYXiHi+wQcCgbnVeS591PheRae6WZNb9E3Udh+gW8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0402MB2842;7:RdXbtYPSn6yQrxg+NeMaOMXop0s9dBH+L7QEQ3qPiimRE1oAbExbGLt5iiZsldi/L5WXKVAXNZzV8BR14KhwsXmvDKfHtikutICEfLubWLqH7nms/6GjhnbIWtaRLoOTK5axPz8+/qe7JhvEk6AIQfw38K5tlObn9lEH5Ddqexlx3e3X6synk54NGFY+2/fnRQP1oH+ZcPH6yUfou5Hboem86sFBhlFQ3dpnvuZqVIfFogOyuP+V2OGIHzLaMQT5
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2018 06:10:55.0806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59da6190-bcb7-44ec-b6b7-08d5d0f46fe4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2842
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SPI controllers can't write nor->page_size bytes in a single step
because their TX FIFO is too small, but when that happens we should
make sure a WRITE_EN command before each write access and READ_SR command
after each write access is issued.

The core is already taking care of that, so all we have to do here is
return the actual number of bytes that were written during the
spi_mem_exec_op() operation.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
 drivers/mtd/devices/m25p80.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index e84563d..60224fe 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -72,7 +72,6 @@ static ssize_t m25p80_write(struct spi_nor *nor, loff_t to, size_t len,
 				   SPI_MEM_OP_ADDR(nor->addr_width, to, 1),
 				   SPI_MEM_OP_DUMMY(0, 1),
 				   SPI_MEM_OP_DATA_OUT(len, buf, 1));
-	size_t remaining = len;
 	int ret;
 
 	/* get transfer protocols. */
@@ -84,22 +83,16 @@ static ssize_t m25p80_write(struct spi_nor *nor, loff_t to, size_t len,
 	if (nor->program_opcode == SPINOR_OP_AAI_WP && nor->sst_write_second)
 		op.addr.nbytes = 0;
 
-	while (remaining) {
-		op.data.nbytes = remaining < UINT_MAX ? remaining : UINT_MAX;
-		ret = spi_mem_adjust_op_size(flash->spimem, &op);
-		if (ret)
-			return ret;
-
-		ret = spi_mem_exec_op(flash->spimem, &op);
-		if (ret)
-			return ret;
+	ret = spi_mem_adjust_op_size(flash->spimem, &op);
+	if (ret)
+		return ret;
+	op.data.nbytes = len < op.data.nbytes ? len : op.data.nbytes;
 
-		op.addr.val += op.data.nbytes;
-		remaining -= op.data.nbytes;
-		op.data.buf.out += op.data.nbytes;
-	}
+	ret = spi_mem_exec_op(flash->spimem, &op);
+	if (ret)
+		return ret;
 
-	return len;
+	return op.data.nbytes;
 }
 
 /*
-- 
2.7.4

Patch is based on the spi-mem framework[1]
[1]https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/log/?h=for-4.18
