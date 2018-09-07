Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A16C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494942077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="Cm0XjMR7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494942077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbeIGLns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 07:43:48 -0400
Received: from mail-cys01nam02on0063.outbound.protection.outlook.com ([104.47.37.63]:20288
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725933AbeIGLnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 07:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7527mkpscDgGpo+gGv2l3SWY7evChCsRGuWTxzGzHhc=;
 b=Cm0XjMR7lRIiZzBAiM5wmCooEEZvYfl5KNiUQeuTQmTZy9fCXT2gn795xYQptxvIR/l3SpCReVdHgfHmcrQ9jUrG9uLxI99sbMmd4AbVomm7Md3eHBjxX7YB3rLaUdgG1hmijrZXSXgkMar9/K4ilMXt6MnH5i+o0G8uKaDm/TQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jampala.Srikanth@cavium.com; 
Received: from hyd1400.caveonetworks.com.com (115.113.156.2) by
 DM6PR07MB4620.namprd07.prod.outlook.com (2603:10b6:5:a0::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.16; Fri, 7 Sep 2018 07:02:08 +0000
From:   Srikanth Jampala <Jampala.Srikanth@cavium.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        sgadam@cavium.com, Jampala.Srikanth@cavium.com
Subject: [PATCH 1/1] crypto: cavium/nitrox - Added support for SR-IOV configuration.
Date:   Fri,  7 Sep 2018 12:31:18 +0530
Message-Id: <1536303678-3674-1-git-send-email-Jampala.Srikanth@cavium.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [115.113.156.2]
X-ClientProxiedBy: MAXPR0101CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::29) To DM6PR07MB4620.namprd07.prod.outlook.com
 (2603:10b6:5:a0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29bc3a72-3a9a-4322-4755-08d6148fd4e9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR07MB4620;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4620;3:bmynGwVIulHJjqXZkHUHfOcxDT7ACANNkQ64nRdKDG+0435kOoaf15V8QsxWfkCDblc1Pf0TzXCkZChKyrs7x7mRPUncBbZUkiwhRtC+xd9eVcUrn0RR4zqtDOVVROvCyqAbjrtKEbIdvfGbDeRzxZAF+dm7CSd8jDmMm2iLmwqHJQPPCdFd/zvjkS2ofZsMuqlCglY3rZ3XWT6WAg/To062y6gjRh+l/Ppq/zA1+irPD8b9pSqoz9XVDzW5w2Ju;25:jJ6GA8oP4ixczyK8zcKHRB2w0XS03NgKA8MnTEsaLQlbKlvkxkKSOyqcZDIc5A3dD3S1ixY+VKuyLZVK2EcQTnIGs1gbKgRSE8kdt1Lh1O4fZdeIXxrzHloWkCkK0FE77INZGWdkwstmIgvecmgV5E50bPbT7ZZKouZB+SuHlFCwlk5Jd3E9A1+OX2jnXQtQ9rpUfNjzmvu5NwkflI+988SL29ufKY8aWYk0+BCmp7LcuU5UAmhRXJ1ucNrkbauV3v+72o0yQbOddsr3LuK5f10dpRBsMAvHcCQ22WG+js8B5BzYRdkBhiUeTwWP+jpBdWsEABkBmKTEn98/o1Qipg==;31:Unjcu+gzgo94rD3OGvTNUTW3GBLCSItv5hMvbla1BMs7BtJCMzlqkx6FhoE6LqY73Z+0+6sSFS41mkh19qsAh4v9I63ZiOYAzlVeFrNdOXwkOHE2Oyz4JgvOz85O+UC5/Xl6aGxMA7ZqpZtw9kYHZpLeLIltkOqD0rAe773H/6piRXDJuK06kz/awqRN7PWiYGnmJTOGEOp83Bz6Rnf/A/bZyNHdmu5Dz7SYz66bJkA=
X-MS-TrafficTypeDiagnostic: DM6PR07MB4620:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4620;20:FSuPlAVF27A0ONuKOYxgXMPs4qNOKBn/IAe9uYJvR23cjYiJ+PYqinBJeDMJnFRYxebtWoU9JFnmv7uc8LKmMpr0+LEuMQP6fMFxqcA8DyRbhjMv7RIguH+iio/D9FknCs3YnTHVe537tJ3LitkD64G40R2nF1lErT7d2IDx7kw0+0QVMkTAV4pSG+P6/qNrDQIdEF3/B396X/xT6+T7Dtm6HOjX56XcEHcjVaMM86qpXbp/4OJt7n+P5jn5VaH4dK1qcdbfQfh7//QXtsUzcNUszNSlA+UnjoW06VAlSwa4CF4bkYxCrP0gYRTEjGkdHFJgWNprPxJFxonhJabpcai+1+T0ibyn3kfv1KNAVVyyIa1biO7SoEMYK8cr2GR5Mmfnp4JyHtYiejFeYFK3f9hhgLi3R/gQrQGn9tSY0i5GnwGIWSGLxn06PV86watwUX1XYpZ0TJZMPvnKn8SeVaW4uz5QDI62sRvXFb8OyvCWTTruilAe+u218+i2eON5;4:+sMVhuMe1i9D6NdsF2nR00Rq63bstok8iWHd5vIzPI7/QBNy5SGKSaPCQx+69G6ACgYT5oBSRvB2jAV6l4Ok70zEY/OI6zlMXiAYjXDqxui96bJJruZxrjuNW76Y4yrIKTrkBHOY5eHi8ebOCvf21C3e5awK+0G9IkKlVSAT3GOE1pGkBbCBgQWIn2X0KMchYW4hEwAW4A3mgq7ieKndnIAVrwtHV4eKUdhiaUDC/8iqGPjOuQdREcbihxYIf+l7OIZEAQDkyTBy4jqYbqSb0w==
X-Microsoft-Antispam-PRVS: <DM6PR07MB462034B2E7C215CB1C68B556F4000@DM6PR07MB4620.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699050);SRVR:DM6PR07MB4620;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4620;
X-Forefront-PRVS: 07880C4932
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(39860400002)(376002)(136003)(199004)(189003)(4720700003)(956004)(476003)(2616005)(478600001)(316002)(16586007)(386003)(6506007)(72206003)(2906002)(16526019)(305945005)(486006)(51416003)(7736002)(52116002)(8676002)(14444005)(5024004)(186003)(26005)(575784001)(86362001)(68736007)(6512007)(8936002)(53936002)(25786009)(50226002)(3846002)(6486002)(4326008)(97736004)(6116002)(81156014)(81166006)(36756003)(48376002)(47776003)(50466002)(106356001)(105586002)(5660300001)(66066001)(107886003)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4620;H:hyd1400.caveonetworks.com.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB4620;23:kOVjBC2WfkdrmsZ+d6y4N4nAAMWI8LWohT8zxebOP?=
 =?us-ascii?Q?oMeLlETBuMnhbTYleCiOkHHy6T09Zk/wWlfTGSjpPQAmG5xBtipjv3VKz9WC?=
 =?us-ascii?Q?U9wvbGbUu92E23UrM2WjAhVVWSrIEkQwcsA796IwnFIXOQLNP2TZA/4cMo3C?=
 =?us-ascii?Q?YGqTD+Y2hmykjPbiKwkGMKV/2s5JjX878EKDt314waPYPsv8wDnxh2k6tq9z?=
 =?us-ascii?Q?ksJudo3pTJttkCUrdOWqBX5L4DCCimaUdxYqlfNRa0CUBuACUEO8Xa/KfzSG?=
 =?us-ascii?Q?V+8gpoiywPoTXNwhy7C3n6mtgDngf8fauHTmHMq671Q7dG0L7P5dRX8KmVvH?=
 =?us-ascii?Q?ChxftTdujKem2emTErTP+gpeKt3Mtjkh4eAzeF1RV4jn6tR7QKrGNxuKDrYg?=
 =?us-ascii?Q?CQbBSsdr+YzWa/YjgwN3I2tjq/RWriH7pbv3QRdltxtUE0/capD91LmyLgl3?=
 =?us-ascii?Q?OelLNYW1CpWA1096VavdFrI7e9/xEqPG1INs5vluIpWlE0IiBcvTdNHqmFgK?=
 =?us-ascii?Q?/epoC9oGgiDhKEVTlNP9pXLJxsNpa56Xopk4++EqggXk2qaylNKQ3S+hKni1?=
 =?us-ascii?Q?NhCa/xfsf7mw21+IDXIep7J9sxgwF7jzpQhL0qmARZH1xiGlHQ3ch+L6cFTZ?=
 =?us-ascii?Q?4St5xKYO91LPxGkea9kiu57LMQOvNn5N25fTnAxyAN+cHg4iAqimEPoKRHz5?=
 =?us-ascii?Q?y9/D8BkC6WRlAc51m7sGB1QM5bPBPB6sN6tibeaAKiUvTY1AFHyVYL2QcnFn?=
 =?us-ascii?Q?ttMayKr0VEtb/d4l2IDjtS0qWE+7u9Oe1ZTHU0eRU+T9y/xfYzS2cq8H27zP?=
 =?us-ascii?Q?PeLuEidbI9r7fw3rk2xKgxm2RC498V7eeDFKW3FfJ4aPw5735Lp+yz84ru0I?=
 =?us-ascii?Q?NVNMJWGs19IIEGfX12ptq/16s0JD1ssN2vg7OJ993c7rtT2dkYZ4wwzjQ9ZJ?=
 =?us-ascii?Q?DwBb4QNI7CtSd1vIBMex2ejhqCj2L5PO30unYfYk0w7xdzqLi9FyGiSf6RaO?=
 =?us-ascii?Q?8IvFIEBjjLKoDhVxJftZYq1P78NXqbqToLcIZ7BcSFt0Jt/Vx+TSoSCi/Lpp?=
 =?us-ascii?Q?14qtWMb3Rxq2l6OBXI7yKYDVqGeQQgQOLxMLo03XTSZm9K8+cjXu7/ALxNcQ?=
 =?us-ascii?Q?hCxv9KPttvSqquZN86o37jAbPTzrw5PmmjWz7weX0TQcAhixk1b8ourjey1w?=
 =?us-ascii?Q?KNpWAHv0aflut3FVRk72dK+vM6Gf1IOhdAMia+aHKcKlHhsBg8o8bqKPw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: ylaPs2REOpDrZSE6jltbcVqa4mqaEriPS1603lImJGhQqjZ6mJ4RHYhbuwPTwGCVHyJT3WlLgCVpdvFG/wNJZ13JZPFC1TMkU6aKwDV0c7cpsbEEjCKoJNCt4JILsWnLWYNlJy+cSb0cKP1syvCrqry0k+tDniSXz4vwFx37Hgul0KCCr0zcvQkez0qMDRoXqjgJZ5yFAn0KJELjWeizvaNpBMPUA7H6KqWjLc2tpiZPZAk14wzXgFXE5tqhPBRVsOQYmwExH2R4cIwlpDMvDECeVdaGpojqHUjB3ByRmkJ65/5UyZVaIwtfTKBGCAdL9gS30ODmpid8YYaW3Q9b6YiypsyAGybDUhDrupcBkjU=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4620;6:S2a6ZTYI/Bn5oa6ILe1iVwmbYVBF47HQ25kzMDemo3yA8/zE8MXX+rN0vQbZpjO62cSNwV5bxYiGU1sC4+HkjGS1Xo3LLk1oSQ8N/2LUJCcduQmO0GKND3XX8OVYASitxSwr1fyY4uAsRhLo3k4koWin++bo/SgrlNfu6OmZpPGxm7niBWRxpHcRrXBQs5pflLA+21cuHSIrDyee6cZ+aL2R+qtFRf0AeDU7TfhokDYCg/HqPWrANQFYKX2mVbSNvtqN/dBeZ287pyrMfmFl2i3X43lbAkiU2TeeBnol+dLXSNw0KzDOC2r3rnqdESkvqZYq4MlTRkstYRg97tZhaFOuXmTI6te8SLg5JXPZgjwF9S3S+XDGRrTexWjSBGY3hV1nHYLkWbdodPvsrD7rMZSDDf3sklYxrtQH0qKp/JKSsfuBv3mXhCH/uNEdU9ZEdlHXhE8Ln68SEoJmG5AlYA==;5:wDuFIPLt9ZduNLFVxckx2b609oCXWxpFdwCOROPFOVbDTgJoj9+9qVZbcVuXI8kqNvPRVsLw08+GVUDKSulXx0mNLVBYQse0S5hh6gqrfHXCljC8K1PXLlzF5xit9EiJ2R+XwxgAb/qksSuxCmko8m5RhlhUL8A5Ma96SpKhfs0=;7:Xg1mPiiGU+nBEa6IO7ZAFdHhmsW5BjQ1NaPFMbTDBLV9jBZ+24apImeDVUWB1w4P0PC07mh2PAlpUhVUryiAs1kCbZ4AVGZCjyH9HO/Qbhhvsr1dOfcrSsQP+r9uoNLaIjiswA7g1lVIWgTa9ynxgsJHmFbowvKKvy5qsxqsftS++OCzSNzIuZqStDVqnG1XBM5rIwa/jJdTRwbpXB5yV/cUpdK1TgMCbqt1e7U5mUuX+4NpICmcu4yTBV/4n7SD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 07:02:08.2253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29bc3a72-3a9a-4322-4755-08d6148fd4e9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4620
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added support to configure SR-IOV using sysfs interface.
Supported VF modes are 16, 32, 64 and 128. Grouped the
hardware configuration functions to "nitrox_hal.h" file.
Changed driver version to "1.1".

Signed-off-by: Srikanth Jampala <Jampala.Srikanth@cavium.com>
Reviewed-by: Gadam Sreerama <sgadam@cavium.com>
---
 drivers/crypto/cavium/nitrox/Makefile        |   2 +
 drivers/crypto/cavium/nitrox/nitrox_common.h |  14 --
 drivers/crypto/cavium/nitrox/nitrox_dev.h    |  36 ++++-
 drivers/crypto/cavium/nitrox/nitrox_hal.c    |  12 +-
 drivers/crypto/cavium/nitrox/nitrox_hal.h    |  22 +++
 drivers/crypto/cavium/nitrox/nitrox_isr.c    |   1 +
 drivers/crypto/cavium/nitrox/nitrox_main.c   |  29 +++-
 drivers/crypto/cavium/nitrox/nitrox_sriov.c  | 150 +++++++++++++++++++
 8 files changed, 236 insertions(+), 30 deletions(-)
 create mode 100644 drivers/crypto/cavium/nitrox/nitrox_hal.h
 create mode 100644 drivers/crypto/cavium/nitrox/nitrox_sriov.c

diff --git a/drivers/crypto/cavium/nitrox/Makefile b/drivers/crypto/cavium/nitrox/Makefile
index 45b7379e8e30..6fcda6b56f7e 100644
--- a/drivers/crypto/cavium/nitrox/Makefile
+++ b/drivers/crypto/cavium/nitrox/Makefile
@@ -7,3 +7,5 @@ n5pf-objs := nitrox_main.o \
 	nitrox_hal.o \
 	nitrox_reqmgr.o \
 	nitrox_algs.o
+
+n5pf-$(CONFIG_PCI_IOV) += nitrox_sriov.o
diff --git a/drivers/crypto/cavium/nitrox/nitrox_common.h b/drivers/crypto/cavium/nitrox/nitrox_common.h
index 312f72801af6..00ef931115da 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_common.h
+++ b/drivers/crypto/cavium/nitrox/nitrox_common.h
@@ -25,19 +25,5 @@ int nitrox_process_se_request(struct nitrox_device *ndev,
 			      struct skcipher_request *skreq);
 void backlog_qflush_work(struct work_struct *work);
 
-void nitrox_config_emu_unit(struct nitrox_device *ndev);
-void nitrox_config_pkt_input_rings(struct nitrox_device *ndev);
-void nitrox_config_pkt_solicit_ports(struct nitrox_device *ndev);
-void nitrox_config_vfmode(struct nitrox_device *ndev, int mode);
-void nitrox_config_nps_unit(struct nitrox_device *ndev);
-void nitrox_config_pom_unit(struct nitrox_device *ndev);
-void nitrox_config_rand_unit(struct nitrox_device *ndev);
-void nitrox_config_efl_unit(struct nitrox_device *ndev);
-void nitrox_config_bmi_unit(struct nitrox_device *ndev);
-void nitrox_config_bmo_unit(struct nitrox_device *ndev);
-void nitrox_config_lbc_unit(struct nitrox_device *ndev);
-void invalidate_lbc(struct nitrox_device *ndev);
-void enable_pkt_input_ring(struct nitrox_device *ndev, int ring);
-void enable_pkt_solicit_port(struct nitrox_device *ndev, int port);
 
 #endif /* __NITROX_COMMON_H */
diff --git a/drivers/crypto/cavium/nitrox/nitrox_dev.h b/drivers/crypto/cavium/nitrox/nitrox_dev.h
index af596455b420..4f560cedd0aa 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_dev.h
+++ b/drivers/crypto/cavium/nitrox/nitrox_dev.h
@@ -88,9 +88,25 @@ struct nitrox_bh {
 	struct bh_data *slc;
 };
 
-/* NITROX-V driver state */
-#define NITROX_UCODE_LOADED	0
-#define NITROX_READY		1
+/*
+ * NITROX Device states
+ */
+enum ndev_state {
+	__NDEV_NOT_READY,
+	__NDEV_READY,
+	__NDEV_IN_RESET,
+};
+
+/* NITROX support modes for VF(s) */
+enum vf_mode {
+	__NDEV_MODE_PF,
+	__NDEV_MODE_VF16,
+	__NDEV_MODE_VF32,
+	__NDEV_MODE_VF64,
+	__NDEV_MODE_VF128,
+};
+
+#define __NDEV_SRIOV_BIT 0
 
 /* command queue size */
 #define DEFAULT_CMD_QLEN 2048
@@ -98,7 +114,6 @@ struct nitrox_bh {
 #define CMD_TIMEOUT 2000
 
 #define DEV(ndev) ((struct device *)(&(ndev)->pdev->dev))
-#define PF_MODE 0
 
 #define NITROX_CSR_ADDR(ndev, offset) \
 	((ndev)->bar_addr + (offset))
@@ -108,13 +123,15 @@ struct nitrox_bh {
  * @list: pointer to linked list of devices
  * @bar_addr: iomap address
  * @pdev: PCI device information
- * @status: NITROX status
+ * @state: NITROX device state
+ * @flags: flags to indicate device the features
  * @timeout: Request timeout in jiffies
  * @refcnt: Device usage count
  * @idx: device index (0..N)
  * @node: NUMA node id attached
  * @qlen: Command queue length
  * @nr_queues: Number of command queues
+ * @mode: Device mode PF/VF
  * @ctx_pool: DMA pool for crypto context
  * @pkt_cmdqs: SE Command queues
  * @msix: MSI-X information
@@ -128,7 +145,8 @@ struct nitrox_device {
 	u8 __iomem *bar_addr;
 	struct pci_dev *pdev;
 
-	unsigned long status;
+	atomic_t state;
+	unsigned long flags;
 	unsigned long timeout;
 	refcount_t refcnt;
 
@@ -136,6 +154,8 @@ struct nitrox_device {
 	int node;
 	u16 qlen;
 	u16 nr_queues;
+	int num_vfs;
+	enum vf_mode mode;
 
 	struct dma_pool *ctx_pool;
 	struct nitrox_cmdq *pkt_cmdqs;
@@ -173,9 +193,9 @@ static inline void nitrox_write_csr(struct nitrox_device *ndev, u64 offset,
 	writeq(value, (ndev->bar_addr + offset));
 }
 
-static inline int nitrox_ready(struct nitrox_device *ndev)
+static inline bool nitrox_ready(struct nitrox_device *ndev)
 {
-	return test_bit(NITROX_READY, &ndev->status);
+	return atomic_read(&ndev->state) == __NDEV_READY;
 }
 
 #endif /* __NITROX_DEV_H */
diff --git a/drivers/crypto/cavium/nitrox/nitrox_hal.c b/drivers/crypto/cavium/nitrox/nitrox_hal.c
index ab4ccf2f9e77..2b256ba36dff 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_hal.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_hal.c
@@ -256,7 +256,7 @@ void nitrox_config_nps_unit(struct nitrox_device *ndev)
 	/* disable ILK interface */
 	core_gbl_vfcfg.value = 0;
 	core_gbl_vfcfg.s.ilk_disable = 1;
-	core_gbl_vfcfg.s.cfg = PF_MODE;
+	core_gbl_vfcfg.s.cfg = __NDEV_MODE_PF;
 	nitrox_write_csr(ndev, NPS_CORE_GBL_VFCFG, core_gbl_vfcfg.value);
 	/* config input and solicit ports */
 	nitrox_config_pkt_input_rings(ndev);
@@ -400,3 +400,13 @@ void nitrox_config_lbc_unit(struct nitrox_device *ndev)
 	offset = LBC_ELM_VF65_128_INT_ENA_W1S;
 	nitrox_write_csr(ndev, offset, (~0ULL));
 }
+
+void config_nps_core_vfcfg_mode(struct nitrox_device *ndev, enum vf_mode mode)
+{
+	union nps_core_gbl_vfcfg vfcfg;
+
+	vfcfg.value = nitrox_read_csr(ndev, NPS_CORE_GBL_VFCFG);
+	vfcfg.s.cfg = mode & 0x7;
+
+	nitrox_write_csr(ndev, NPS_CORE_GBL_VFCFG, vfcfg.value);
+}
diff --git a/drivers/crypto/cavium/nitrox/nitrox_hal.h b/drivers/crypto/cavium/nitrox/nitrox_hal.h
new file mode 100644
index 000000000000..3baef865b17c
--- /dev/null
+++ b/drivers/crypto/cavium/nitrox/nitrox_hal.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __NITROX_HAL_H
+#define __NITROX_HAL_H
+
+#include "nitrox_dev.h"
+
+void nitrox_config_emu_unit(struct nitrox_device *ndev);
+void nitrox_config_pkt_input_rings(struct nitrox_device *ndev);
+void nitrox_config_pkt_solicit_ports(struct nitrox_device *ndev);
+void nitrox_config_nps_unit(struct nitrox_device *ndev);
+void nitrox_config_pom_unit(struct nitrox_device *ndev);
+void nitrox_config_rand_unit(struct nitrox_device *ndev);
+void nitrox_config_efl_unit(struct nitrox_device *ndev);
+void nitrox_config_bmi_unit(struct nitrox_device *ndev);
+void nitrox_config_bmo_unit(struct nitrox_device *ndev);
+void nitrox_config_lbc_unit(struct nitrox_device *ndev);
+void invalidate_lbc(struct nitrox_device *ndev);
+void enable_pkt_input_ring(struct nitrox_device *ndev, int ring);
+void enable_pkt_solicit_port(struct nitrox_device *ndev, int port);
+void config_nps_core_vfcfg_mode(struct nitrox_device *ndev, enum vf_mode mode);
+
+#endif /* __NITROX_HAL_H */
diff --git a/drivers/crypto/cavium/nitrox/nitrox_isr.c b/drivers/crypto/cavium/nitrox/nitrox_isr.c
index ee0d70ba25d5..4f4334929f35 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_isr.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_isr.c
@@ -6,6 +6,7 @@
 #include "nitrox_dev.h"
 #include "nitrox_csr.h"
 #include "nitrox_common.h"
+#include "nitrox_hal.h"
 
 #define NR_RING_VECTORS 3
 #define NPS_CORE_INT_ACTIVE_ENTRY 192
diff --git a/drivers/crypto/cavium/nitrox/nitrox_main.c b/drivers/crypto/cavium/nitrox/nitrox_main.c
index fee7cb2ce747..6d7a421bddb8 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_main.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_main.c
@@ -11,13 +11,14 @@
 #include "nitrox_dev.h"
 #include "nitrox_common.h"
 #include "nitrox_csr.h"
+#include "nitrox_hal.h"
 
 #define CNN55XX_DEV_ID	0x12
 #define MAX_PF_QUEUES	64
 #define UCODE_HLEN 48
 #define SE_GROUP 0
 
-#define DRIVER_VERSION "1.0"
+#define DRIVER_VERSION "1.1"
 #define FW_DIR "cavium/"
 /* SE microcode */
 #define SE_FW	FW_DIR "cnn55xx_se.fw"
@@ -42,6 +43,15 @@ static unsigned int qlen = DEFAULT_CMD_QLEN;
 module_param(qlen, uint, 0644);
 MODULE_PARM_DESC(qlen, "Command queue length - default 2048");
 
+#ifdef CONFIG_PCI_IOV
+int nitrox_sriov_configure(struct pci_dev *pdev, int num_vfs);
+#else
+int nitrox_sriov_configure(struct pci_dev *pdev, int num_vfs)
+{
+	return 0;
+}
+#endif
+
 /**
  * struct ucode - Firmware Header
  * @id: microcode ID
@@ -136,9 +146,6 @@ static int nitrox_load_fw(struct nitrox_device *ndev, const char *fw_name)
 	write_to_ucd_unit(ndev, ucode);
 	release_firmware(fw);
 
-	set_bit(NITROX_UCODE_LOADED, &ndev->status);
-	/* barrier to sync with other cpus */
-	smp_mb__after_atomic();
 	return 0;
 }
 
@@ -555,7 +562,7 @@ static int nitrox_probe(struct pci_dev *pdev,
 	if (err)
 		goto pf_hw_fail;
 
-	set_bit(NITROX_READY, &ndev->status);
+	atomic_set(&ndev->state, __NDEV_READY);
 	/* barrier to sync with other cpus */
 	smp_mb__after_atomic();
 
@@ -567,7 +574,7 @@ static int nitrox_probe(struct pci_dev *pdev,
 
 crypto_fail:
 	nitrox_debugfs_exit(ndev);
-	clear_bit(NITROX_READY, &ndev->status);
+	atomic_set(&ndev->state, __NDEV_NOT_READY);
 	/* barrier to sync with other cpus */
 	smp_mb__after_atomic();
 pf_hw_fail:
@@ -602,11 +609,16 @@ static void nitrox_remove(struct pci_dev *pdev)
 	dev_info(DEV(ndev), "Removing Device %x:%x\n",
 		 ndev->hw.vendor_id, ndev->hw.device_id);
 
-	clear_bit(NITROX_READY, &ndev->status);
+	atomic_set(&ndev->state, __NDEV_NOT_READY);
 	/* barrier to sync with other cpus */
 	smp_mb__after_atomic();
 
 	nitrox_remove_from_devlist(ndev);
+
+#ifdef CONFIG_PCI_IOV
+	/* disable SR-IOV */
+	nitrox_sriov_configure(pdev, 0);
+#endif
 	nitrox_crypto_unregister();
 	nitrox_debugfs_exit(ndev);
 	nitrox_pf_sw_cleanup(ndev);
@@ -632,6 +644,9 @@ static struct pci_driver nitrox_driver = {
 	.probe = nitrox_probe,
 	.remove	= nitrox_remove,
 	.shutdown = nitrox_shutdown,
+#ifdef CONFIG_PCI_IOV
+	.sriov_configure = nitrox_sriov_configure,
+#endif
 };
 
 module_pci_driver(nitrox_driver);
diff --git a/drivers/crypto/cavium/nitrox/nitrox_sriov.c b/drivers/crypto/cavium/nitrox/nitrox_sriov.c
new file mode 100644
index 000000000000..453d920fbd69
--- /dev/null
+++ b/drivers/crypto/cavium/nitrox/nitrox_sriov.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/pci.h>
+#include <linux/delay.h>
+
+#include "nitrox_dev.h"
+#include "nitrox_hal.h"
+#include "nitrox_common.h"
+
+static inline bool num_vfs_valid(int num_vfs)
+{
+	bool valid = false;
+
+	switch (num_vfs) {
+	case 16:
+	case 32:
+	case 64:
+	case 128:
+		valid = true;
+		break;
+	}
+
+	return valid;
+}
+
+static inline enum vf_mode num_vfs_to_mode(int num_vfs)
+{
+	enum vf_mode mode = 0;
+
+	switch (num_vfs) {
+	case 0:
+		mode = __NDEV_MODE_PF;
+		break;
+	case 16:
+		mode = __NDEV_MODE_VF16;
+		break;
+	case 32:
+		mode = __NDEV_MODE_VF32;
+		break;
+	case 64:
+		mode = __NDEV_MODE_VF64;
+		break;
+	case 128:
+		mode = __NDEV_MODE_VF128;
+		break;
+	}
+
+	return mode;
+}
+
+static void pf_sriov_cleanup(struct nitrox_device *ndev)
+{
+	 /* PF has no queues in SR-IOV mode */
+	atomic_set(&ndev->state, __NDEV_NOT_READY);
+	/* unregister crypto algorithms */
+	nitrox_crypto_unregister();
+
+	/* cleanup PF resources */
+	nitrox_pf_cleanup_isr(ndev);
+	nitrox_common_sw_cleanup(ndev);
+}
+
+static int pf_sriov_init(struct nitrox_device *ndev)
+{
+	int err;
+
+	/* allocate resources for PF */
+	err = nitrox_common_sw_init(ndev);
+	if (err)
+		return err;
+
+	err = nitrox_pf_init_isr(ndev);
+	if (err) {
+		nitrox_common_sw_cleanup(ndev);
+		return err;
+	}
+
+	/* configure the packet queues */
+	nitrox_config_pkt_input_rings(ndev);
+	nitrox_config_pkt_solicit_ports(ndev);
+
+	/* set device to ready state */
+	atomic_set(&ndev->state, __NDEV_READY);
+
+	/* register crypto algorithms */
+	return nitrox_crypto_register();
+}
+
+static int nitrox_sriov_enable(struct pci_dev *pdev, int num_vfs)
+{
+	struct nitrox_device *ndev = pci_get_drvdata(pdev);
+	int err;
+
+	if (!num_vfs_valid(num_vfs)) {
+		dev_err(DEV(ndev), "Invalid num_vfs %d\n", num_vfs);
+		return -EINVAL;
+	}
+
+	if (pci_num_vf(pdev) == num_vfs)
+		return num_vfs;
+
+	err = pci_enable_sriov(pdev, num_vfs);
+	if (err) {
+		dev_err(DEV(ndev), "failed to enable PCI sriov %d\n", err);
+		return err;
+	}
+	dev_info(DEV(ndev), "Enabled VF(s) %d\n", num_vfs);
+
+	ndev->num_vfs = num_vfs;
+	ndev->mode = num_vfs_to_mode(num_vfs);
+	/* set bit in flags */
+	set_bit(__NDEV_SRIOV_BIT, &ndev->flags);
+
+	/* cleanup PF resources */
+	pf_sriov_cleanup(ndev);
+
+	config_nps_core_vfcfg_mode(ndev, ndev->mode);
+
+	return num_vfs;
+}
+
+static int nitrox_sriov_disable(struct pci_dev *pdev)
+{
+	struct nitrox_device *ndev = pci_get_drvdata(pdev);
+
+	if (!test_bit(__NDEV_SRIOV_BIT, &ndev->flags))
+		return 0;
+
+	if (pci_vfs_assigned(pdev)) {
+		dev_warn(DEV(ndev), "VFs are attached to VM. Can't disable SR-IOV\n");
+		return -EPERM;
+	}
+	pci_disable_sriov(pdev);
+	/* clear bit in flags */
+	clear_bit(__NDEV_SRIOV_BIT, &ndev->flags);
+
+	ndev->num_vfs = 0;
+	ndev->mode = __NDEV_MODE_PF;
+
+	config_nps_core_vfcfg_mode(ndev, ndev->mode);
+
+	return pf_sriov_init(ndev);
+}
+
+int nitrox_sriov_configure(struct pci_dev *pdev, int num_vfs)
+{
+	if (!num_vfs)
+		return nitrox_sriov_disable(pdev);
+
+	return nitrox_sriov_enable(pdev, num_vfs);
+}
-- 
2.17.1

