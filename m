Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C49ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3143206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="OYlP4ync"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3143206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389991AbeIUR2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 13:28:46 -0400
Received: from mail-co1nam03on0046.outbound.protection.outlook.com ([104.47.40.46]:14080
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389517AbeIUR2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 13:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ci0HHmHvp+vHOLdfCpA+xM3cCSelKo8o/thTikJahqo=;
 b=OYlP4yncD9zvurK8XUXQiPg60x0jX7jpURXS8zB++kvWT1+j8cr4LdjaRqBbXfOww/ZBbFBV0SS9Hzf35mmdl3sExwHKAuIlLOQ9etERE59tJWLc4qatJTNIXqyB9axhrQG+WURExxPu4bDcNppxN/9LJfVuL4VbZrm+GPLjAzE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jampala.Srikanth@cavium.com; 
Received: from hyd1621.caveonetworks.com (115.113.156.2) by
 SN6PR07MB4622.namprd07.prod.outlook.com (2603:10b6:805:3a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Fri, 21 Sep 2018 11:39:07 +0000
From:   Srikanth Jampala <Jampala.Srikanth@cavium.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        sgadam@cavium.com, Jampala.Srikanth@cavium.com
Subject: [PATCH cryptodev-2.6 1/3] crypto: cavium/nitrox - added support to identify the NITROX device partname.
Date:   Fri, 21 Sep 2018 17:08:00 +0530
Message-Id: <20180921113802.26475-1-Jampala.Srikanth@cavium.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [115.113.156.2]
X-ClientProxiedBy: MA1PR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::16) To SN6PR07MB4622.namprd07.prod.outlook.com
 (2603:10b6:805:3a::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 891312fc-8b07-45d0-421c-08d61fb6d842
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4622;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4622;3:q2mcVHIJg4neTO7xGczE5KOr/We9B/jxysk/tstALSPB8kuZz9EwdXxCCdSMk+ISq+JbHlXISRKyicMKe6olUgQQM2fLklyFITn9f4xDp0ZXERzBPEHT9yUeGJ2qW8u8/5PSfAQbAQdx4W1lKXbCtecIuW2J4DPVT5JC0I9ug2fJHz/TRyfaK2HRyBDO+gy1DEJ49khf0xTH0C+2LIhqqvDrGOJZAKnY5AYTsIGN9UGjnDZvn8OZlk4XL4MkhX+s;25:+Ljswnq6o3wvtKfWPRr6n5evyVR3YL20R+NjojNrRWuYTIiV7Wk6VCsD9l4uvkvSf3ehs2bSOlJb8z4o4fy1Yx08Zxbecf+CaqZsK1VnA35t6CUyj+4aomoUE1TV8EEMdgOn0rPgiZQK0slydUA7EGq/CCfZzjtPHpg+EojZ5UyoUZeCY2GOX0cKTiMzsQiMY9QdlZUlh45N6nhRRe7qE/VNXBUrMqqGPMaU6aYCGAdPkSXCCjkaxTZXBwM+wG8CelnQ8TKTfpkFUNGI/f/6jyjnaaOicyE52obUGu3R5SCX2FDEEsEL9R6yToowRgFhlfTzDOtA7Ue5f685MG+SYQ==;31:rT63BAqRAO6emBEKUQuvZFNOFOzLfWptZzDzKgpq7BjhJ1nGdCGLlEUC6eS/3t3Kynjb+mWedRtfZDQCj+iE51GOYAEB0FKTz66VsipRLJ2CDz6cJAzK0YP7DCXXx9aMsRqhjYzQb0b95FZXsHqtF4TO4fOYuzPdbKJ+nGUv8UmUlZAeBfPDyX1Zd7A1TBKP14F6qqvDFxffuCWWG0C50nPSx+ifJEYXY6enzGfUzEc=
X-MS-TrafficTypeDiagnostic: SN6PR07MB4622:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4622;20:E1wclMFw06e95X/bD8uEx2MpoPKCjB7fMvqxrj457DgxWH49GlnFoxV1KTFYGUApud088lYf66/YqtDRzh9N8pDxZXSVKdUNmUGF8RRKl486lmwRduId1SVo8uNAHseQsVLIi7nYWG7ERj7zs5mJQb/tXhusS7Z4KMJwMGXyxVZ0IjD4lwiMGzVXu+C7CDaZNDAnpbM47P4Jnq35dC2dq+AM3wbUja1GrgE1S7mcpdrBPtgCU68eAMOutiJ4ncMFIzrhDZTNs02i/Zuu3pOW67vSrpSXsu0A/bcBwnCXkorRI4T6mQ5dLOWb6nJx//NQRbhNdYdM542a/oNQ1JD+3e0tFnMzVGiPftrrakywLifBO5U/GOVNOSNaeCsKKmqaDGtUFRYJcFJX8RYKOS8kqZiz6k9AanF3/1qTcV4HTBC3P0CAnZkCe8IUNQZJwPo4IaYcneE5f1Ft91DAPZuqB/7dza3iAEfjkAADjyVoLHrqNGDu2pqmQ33kjpz7+O6m;4:QhASJjSOkEWJwHJbCkMEctxLnLEObS5b+5U2128FI5i0a2yOsk2z8Ph2VagbWwvvqaCI9MmBzDnZ6YlcyOLkQOcZwuhPNxuiWoPLupkLejU8pgo20sEVrR3meLFP9n6FydYmwNGAnmJUz8wjuCN2HbHfUvLu6CEHCkLO240ny0mQWEXs2wBvm6hTsz9XlvdIX5ztsEcgoJDAEbAXBfs5LrtljY8co8/Kp83/BLpC4ZJU7s1RFa+/6vBC8EduiYj1/ZQsUvw7IbPSg4mDbUq8hw==
X-Microsoft-Antispam-PRVS: <SN6PR07MB462208030EF5297F181AFBC4F4120@SN6PR07MB4622.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051);SRVR:SN6PR07MB4622;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4622;
X-Forefront-PRVS: 0802ADD973
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(366004)(396003)(346002)(189003)(199004)(316002)(97736004)(16586007)(6506007)(47776003)(16526019)(8936002)(107886003)(106356001)(81166006)(53416004)(5660300001)(3846002)(69596002)(52116002)(51416003)(14444005)(575784001)(1076002)(105586002)(4326008)(86362001)(8676002)(6486002)(6116002)(305945005)(6512007)(186003)(6666003)(7736002)(476003)(72206003)(26005)(478600001)(48376002)(486006)(50466002)(956004)(2616005)(25786009)(66066001)(386003)(81156014)(68736007)(36756003)(50226002)(2906002)(55236004)(53936002)(21314002)(358055004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4622;H:hyd1621.caveonetworks.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR07MB4622;23:EF1uGXqVjx7ootFjKQQToUP/HM7PD537ZYZbGHlN7?=
 =?us-ascii?Q?flEOHCXaVc4NA/UKyDr0/A7OUDxcGnooO5PC9xjIfzcKiTOOMF/dEYzqxMqA?=
 =?us-ascii?Q?uFioIaGCFmuBOMdGsF8DaLCxg3+rWoy3U34PWnQHAfDkGLD8K8+EssHW+fbt?=
 =?us-ascii?Q?NR8cE/nfwWPliS5MWlZC1D0gt+fptsT+Q0oH4DbUXng8N2NzeLHitOapfn88?=
 =?us-ascii?Q?fqyboMaDmLMwHjOsOOPvTNYw0MqyWG1IqWyyYzXbIt3CnzXbuAtULwYetT3j?=
 =?us-ascii?Q?znM0VaC+xuCdRseJi04eHPO5iD8P/vCOlv5Rf3LPoBeW59KEgx+LDU4xMOKo?=
 =?us-ascii?Q?p332pbxkucufKaur7kiuoOgNhQ57NnDyP5qF0uVyUs5/Agufd2rVB0ZGC5Io?=
 =?us-ascii?Q?WVAzK48o6d5mkxuScXhknhnsCRNQV7myKu7sJLqjdCukzcNCPLj1V/K290Nh?=
 =?us-ascii?Q?90TkdxuXo0RzGxrOwnFIs8sjU/6tsH5JfjtO2Al2moBzzSDP0Gdvr2ZLaENp?=
 =?us-ascii?Q?4LpdApKc4OxhD21lvfNJ7qbGKGaqt3hT9+7+sA47kgggKUUCPzHS2X1K6P+C?=
 =?us-ascii?Q?l0nIxWJwx6ofYwPAUcOpFU1uF7CwLbTQcGZTCgwdBS7W9HTHGThVAo45teez?=
 =?us-ascii?Q?v/D3gttWk6Z330HEASRy8msXyNZI7IDcItlzbQAnhj8KYl38F4cWLcvSCRRK?=
 =?us-ascii?Q?IMvBlEHuosvTW715LxqL8Useln7vhU9Wpe8J5YzmrsCl1tI60ccTUXWi6lTC?=
 =?us-ascii?Q?8in+jQ48VqASr8rwx5/fBpGriPdNnqMLnpdsa07JKfuYYRk+wOH+VTFX5e7Y?=
 =?us-ascii?Q?/cqbv0H1KwRMlTPiUPo1hV75pt4Ip/3iv73jthgodV9OX1M00fY12htfsph8?=
 =?us-ascii?Q?rJQbdtF1YuCMUEil21jlKix6y2jEKemGLQJNAr1+OvObgUo3rog2aDTb9XO5?=
 =?us-ascii?Q?I/BPNXBqnAL8yXWE/wOxpzvaP222YHZZ0zT+NPj5XoaYmATh9GuqspsJ8ano?=
 =?us-ascii?Q?p530Y5IEnJp5Dd0AsaWwdLe5agBTyoFEf4G8D22/HtItJ1amShvh6cw/yHNS?=
 =?us-ascii?Q?7pNPNjTZcIY0iQl6WPNjB3U5K3Jq4VHnKnRFO+kYWkHwKGlPZR+k1hNR3eqM?=
 =?us-ascii?Q?bcaxSm6bynDpoTrjH1fBuUfqvli8asVrAVLUxY/rhtXZCGfO6oo2D9JRWIR1?=
 =?us-ascii?Q?T6ac8hmhAXOtWJtQiB21HXJjI2e3VbuS/fB5/eV2yZaGdGMVy0drDlNasUqW?=
 =?us-ascii?Q?NwE0Z+R3SkplJSy56qOarY6W6E0Yt9bTnkBI5SlQwPW0gnXIWxJ8eI0rvXYq?=
 =?us-ascii?Q?aqvCnimfnLfjsO4TFY++ew=3D?=
X-Microsoft-Antispam-Message-Info: IvvuvvRbHz2h4WC0GlaE1tInI5uapckuIOHTbZ7dvz+kxj+mDB85vRfOi7mvCRsKfMHUA05DlQQCHUDyBUP97OUbgWv6gFDZDy/y1ZW9fZfi62uGXQ1W2k6sQmCWvUOVU824iwXx8x/qElwh6MPoNum0jsJaH4MiCrKI+snm4Cp6g6Zu1HCE2FpHaiVqEVYEnwD2giCE4gHcxcXSig2ForOmjliygMZwz+yPfHiEVR0SGXvBneB33EjLu+dl1Cztf9ojNdOj/5GTRhyaS7Gjo2b0WvF3KUai1G0tbFQVzXj7dpmEFYLWiD6ryapfFh07ucMwGk7MJ5gpjgsoXcPmlX5UpavIAH/QgSkos00aLhk=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4622;6:Fmw3hTgWJBhCNCuP4VIner3EbKtq/zuDnzYdyHYkvuKwhxrG3pNnaEyZJk0+xTA4LLTFc6elZ50VFPLaQ2j89EMMW4ZwJpXhgDjU9af5ConxDrl5qyvpIYdfefo7xSmFJbVKLfqt8fCKr3A7xRVjZ5IaPDzkCAFetU7TP41O4e1CbizuM5rXP/85OSW3M/+WWAmeLIod9AMhaB5utAjDazpI8yTSttHrOVLrFKu1ZZXKm1NvmuuwlJsLxhRR0Hi+b7bW9jr3UjlZumdi1Bc5M3JmAevSgCksv74ScMju+2+kbtZRC62m90fFI0VQ9IHaRbmbJ0yjvFSHP8UFLvTga6t3eKxODEcK0rNTFM7Sj/g45bwRULGjIoQ0kWJAU8zn21DIjgpsx0tjAG8IGucnzw4ucicgJuOUsabaTpX2pPNMMxwR/ObHmmU/N9iX4gi1vbatWSSiKdxfG63jTQgrZw==;5:nmai8jRK1GQMATJG7lRs8sK7/Krp/FPJzK8YTcs037+pUM2fdGypqtAt7TPDrnoUpvCEAy0w8+Aj1PONaHiBQSn0IQ08HDPPMaJ1XM8MnIIsKma+9RpHQ/hyamk+FSzB8YxoS4TtInSoPjjTeOUd2hajk3XcFP1CFoeFj//NhIw=;7:5uk/nnfN9VTyp/wMQLrIc8GzYYgj5md7emDP7Qi/LsTSHkhMGL6MAVgmDBnsRlZrXr5EMePSZlDP7weGUGE0fyIMahPBtACLMcj3jzoPWe9QL6G+98dFZn0y1g/pSRO76G+Y/+WNbgR6FRTJdXtmG7RhcHxSdEBO8/lGD/7ZNmBMZ7hD4b7k4JSs5lkT2lhvRmX8SQTXIddkjqfeQqHPH6o/RNirc46FTt9URAbWZ8U0MtHV0ofD8wT9/dvfFZRx
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2018 11:39:07.2099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 891312fc-8b07-45d0-421c-08d61fb6d842
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get the device partname based on it's capabilities like,
core frequency, number of cores and revision id.

Signed-off-by: Srikanth Jampala <Jampala.Srikanth@cavium.com>
---
 drivers/crypto/cavium/nitrox/nitrox_csr.h  | 111 +++++++++++++++++++++
 drivers/crypto/cavium/nitrox/nitrox_dev.h  |  17 +++-
 drivers/crypto/cavium/nitrox/nitrox_hal.c  |  57 +++++++++++
 drivers/crypto/cavium/nitrox/nitrox_hal.h  |   1 +
 drivers/crypto/cavium/nitrox/nitrox_main.c |  20 ----
 5 files changed, 184 insertions(+), 22 deletions(-)

diff --git a/drivers/crypto/cavium/nitrox/nitrox_csr.h b/drivers/crypto/cavium/nitrox/nitrox_csr.h
index 9dcb7fdbe0a7..1ad27b1a87c5 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_csr.h
+++ b/drivers/crypto/cavium/nitrox/nitrox_csr.h
@@ -7,9 +7,16 @@
 
 /* EMU clusters */
 #define NR_CLUSTERS		4
+/* Maximum cores per cluster,
+ * varies based on partname
+ */
 #define AE_CORES_PER_CLUSTER	20
 #define SE_CORES_PER_CLUSTER	16
 
+#define AE_MAX_CORES	(AE_CORES_PER_CLUSTER * NR_CLUSTERS)
+#define SE_MAX_CORES	(SE_CORES_PER_CLUSTER * NR_CLUSTERS)
+#define ZIP_MAX_CORES	5
+
 /* BIST registers */
 #define EMU_BIST_STATUSX(_i)	(0x1402700 + ((_i) * 0x40000))
 #define UCD_BIST_STATUS		0x12C0070
@@ -111,6 +118,9 @@
 #define LBC_ELM_VF65_128_INT		0x120C000
 #define LBC_ELM_VF65_128_INT_ENA_W1S	0x120F000
 
+#define RST_BOOT	0x10C1600
+#define FUS_DAT1	0x10C1408
+
 /* PEM registers */
 #define PEM0_INT 0x1080428
 
@@ -1082,4 +1092,105 @@ union lbc_inval_status {
 	} s;
 };
 
+/**
+ * struct rst_boot: RST Boot Register
+ * @jtcsrdis: when set, internal CSR access via JTAG TAP controller
+ *   is disabled
+ * @jt_tst_mode: JTAG test mode
+ * @io_supply: I/O power supply setting based on IO_VDD_SELECT pin:
+ *    0x1 = 1.8V
+ *    0x2 = 2.5V
+ *    0x4 = 3.3V
+ *    All other values are reserved
+ * @pnr_mul: clock multiplier
+ * @lboot: last boot cause mask, resets only with PLL_DC_OK
+ * @rboot: determines whether core 0 remains in reset after
+ *    chip cold or warm or soft reset
+ * @rboot_pin: read only access to REMOTE_BOOT pin
+ */
+union rst_boot {
+	u64 value;
+	struct {
+#if (defined(__BIG_ENDIAN_BITFIELD))
+		u64 raz_63 : 1;
+		u64 jtcsrdis : 1;
+		u64 raz_59_61 : 3;
+		u64 jt_tst_mode : 1;
+		u64 raz_40_57 : 18;
+		u64 io_supply : 3;
+		u64 raz_30_36 : 7;
+		u64 pnr_mul : 6;
+		u64 raz_12_23 : 12;
+		u64 lboot : 10;
+		u64 rboot : 1;
+		u64 rboot_pin : 1;
+#else
+		u64 rboot_pin : 1;
+		u64 rboot : 1;
+		u64 lboot : 10;
+		u64 raz_12_23 : 12;
+		u64 pnr_mul : 6;
+		u64 raz_30_36 : 7;
+		u64 io_supply : 3;
+		u64 raz_40_57 : 18;
+		u64 jt_tst_mode : 1;
+		u64 raz_59_61 : 3;
+		u64 jtcsrdis : 1;
+		u64 raz_63 : 1;
+#endif
+	};
+};
+
+/**
+ * struct fus_dat1: Fuse Data 1 Register
+ * @pll_mul: main clock PLL multiplier hardware limit
+ * @pll_half_dis: main clock PLL control
+ * @efus_lck: efuse lockdown
+ * @zip_info: ZIP information
+ * @bar2_sz_conf: when zero, BAR2 size conforms to
+ *    PCIe specification
+ * @efus_ign: efuse ignore
+ * @nozip: ZIP disable
+ * @pll_alt_matrix: select alternate PLL matrix
+ * @pll_bwadj_denom: select CLKF denominator for
+ *    BWADJ value
+ * @chip_id: chip ID
+ */
+union fus_dat1 {
+	u64 value;
+	struct {
+#if (defined(__BIG_ENDIAN_BITFIELD))
+		u64 raz_57_63 : 7;
+		u64 pll_mul : 3;
+		u64 pll_half_dis : 1;
+		u64 raz_43_52 : 10;
+		u64 efus_lck : 3;
+		u64 raz_26_39 : 14;
+		u64 zip_info : 5;
+		u64 bar2_sz_conf : 1;
+		u64 efus_ign : 1;
+		u64 nozip : 1;
+		u64 raz_11_17 : 7;
+		u64 pll_alt_matrix : 1;
+		u64 pll_bwadj_denom : 2;
+		u64 chip_id : 8;
+#else
+		u64 chip_id : 8;
+		u64 pll_bwadj_denom : 2;
+		u64 pll_alt_matrix : 1;
+		u64 raz_11_17 : 7;
+		u64 nozip : 1;
+		u64 efus_ign : 1;
+		u64 bar2_sz_conf : 1;
+		u64 zip_info : 5;
+		u64 raz_26_39 : 14;
+		u64 efus_lck : 3;
+		u64 raz_43_52 : 10;
+		u64 pll_half_dis : 1;
+		u64 pll_mul : 3;
+		u64 raz_57_63 : 7;
+#endif
+	};
+};
+
 #endif /* __NITROX_CSR_H */
diff --git a/drivers/crypto/cavium/nitrox/nitrox_dev.h b/drivers/crypto/cavium/nitrox/nitrox_dev.h
index 4f560cedd0aa..1059495ee541 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_dev.h
+++ b/drivers/crypto/cavium/nitrox/nitrox_dev.h
@@ -5,6 +5,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/pci.h>
+#include <linux/if.h>
 
 #define VERSION_LEN 32
 
@@ -48,15 +49,27 @@ struct nitrox_cmdq {
 	dma_addr_t dma;
 };
 
+/**
+ * struct nitrox_hw - NITROX hardware information
+ * @partname: partname ex: CNN55xxx-xxx
+ * @fw_name: firmware version
+ * @freq: NITROX frequency
+ * @vendor_id: vendor ID
+ * @device_id: device ID
+ * @revision_id: revision ID
+ * @se_cores: number of symmetric cores
+ * @ae_cores: number of asymmetric cores
+ * @zip_cores: number of zip cores
+ */
 struct nitrox_hw {
-	/* firmware version */
+	char partname[IFNAMSIZ * 2];
 	char fw_name[VERSION_LEN];
 
+	int freq;
 	u16 vendor_id;
 	u16 device_id;
 	u8 revision_id;
 
-	/* CNN55XX cores */
 	u8 se_cores;
 	u8 ae_cores;
 	u8 zip_cores;
diff --git a/drivers/crypto/cavium/nitrox/nitrox_hal.c b/drivers/crypto/cavium/nitrox/nitrox_hal.c
index 2b256ba36dff..4627a1976176 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_hal.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_hal.c
@@ -4,6 +4,8 @@
 #include "nitrox_dev.h"
 #include "nitrox_csr.h"
 
+#define PLL_REF_CLK 50
+
 /**
  * emu_enable_cores - Enable EMU cluster cores.
  * @ndev: N5 device
@@ -410,3 +412,58 @@ void config_nps_core_vfcfg_mode(struct nitrox_device *ndev, enum vf_mode mode)
 
 	nitrox_write_csr(ndev, NPS_CORE_GBL_VFCFG, vfcfg.value);
 }
+
+void nitrox_get_hwinfo(struct nitrox_device *ndev)
+{
+	union emu_fuse_map emu_fuse;
+	union rst_boot rst_boot;
+	union fus_dat1 fus_dat1;
+	unsigned char name[IFNAMSIZ * 2] = {};
+	int i, dead_cores;
+	u64 offset;
+
+	/* get core frequency */
+	offset = RST_BOOT;
+	rst_boot.value = nitrox_read_csr(ndev, offset);
+	ndev->hw.freq = (rst_boot.pnr_mul + 3) * PLL_REF_CLK;
+
+	for (i = 0; i < NR_CLUSTERS; i++) {
+		offset = EMU_FUSE_MAPX(i);
+		emu_fuse.value = nitrox_read_csr(ndev, offset);
+		if (emu_fuse.s.valid) {
+			dead_cores = hweight32(emu_fuse.s.ae_fuse);
+			ndev->hw.ae_cores += AE_CORES_PER_CLUSTER - dead_cores;
+			dead_cores = hweight16(emu_fuse.s.se_fuse);
+			ndev->hw.se_cores += SE_CORES_PER_CLUSTER - dead_cores;
+		}
+	}
+	/* find zip hardware availability */
+	offset = FUS_DAT1;
+	fus_dat1.value = nitrox_read_csr(ndev, offset);
+	if (!fus_dat1.nozip) {
+		dead_cores = hweight8(fus_dat1.zip_info);
+		ndev->hw.zip_cores = ZIP_MAX_CORES - dead_cores;
+	}
+
+	/* determine the partname CNN55<cores>-<freq><pincount>-<rev>*/
+	if (ndev->hw.ae_cores == AE_MAX_CORES) {
+		switch (ndev->hw.se_cores) {
+		case SE_MAX_CORES:
+			i = snprintf(name, sizeof(name), "CNN5560");
+			break;
+		case 40:
+			i = snprintf(name, sizeof(name), "CNN5560s");
+			break;
+		}
+	} else if (ndev->hw.ae_cores == (AE_MAX_CORES / 2)) {
+		i = snprintf(name, sizeof(name), "CNN5530");
+	} else {
+		i = snprintf(name, sizeof(name), "CNN5560i");
+	}
+
+	snprintf(name + i, sizeof(name) - i, "-%3dBG676-1.%u",
+		 ndev->hw.freq, ndev->hw.revision_id);
+
+	/* copy partname */
+	strncpy(ndev->hw.partname, name, sizeof(ndev->hw.partname));
+}
diff --git a/drivers/crypto/cavium/nitrox/nitrox_hal.h b/drivers/crypto/cavium/nitrox/nitrox_hal.h
index 3baef865b17c..489ee64c119e 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_hal.h
+++ b/drivers/crypto/cavium/nitrox/nitrox_hal.h
@@ -18,5 +18,6 @@ void invalidate_lbc(struct nitrox_device *ndev);
 void enable_pkt_input_ring(struct nitrox_device *ndev, int ring);
 void enable_pkt_solicit_port(struct nitrox_device *ndev, int port);
 void config_nps_core_vfcfg_mode(struct nitrox_device *ndev, enum vf_mode mode);
+void nitrox_get_hwinfo(struct nitrox_device *ndev);
 
 #endif /* __NITROX_HAL_H */
diff --git a/drivers/crypto/cavium/nitrox/nitrox_main.c b/drivers/crypto/cavium/nitrox/nitrox_main.c
index 6d7a421bddb8..acce0f0b9c7a 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_main.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_main.c
@@ -291,26 +291,6 @@ static int nitrox_bist_check(struct nitrox_device *ndev)
 	return 0;
 }
 
-static void nitrox_get_hwinfo(struct nitrox_device *ndev)
-{
-	union emu_fuse_map emu_fuse;
-	u64 offset;
-	int i;
-
-	for (i = 0; i < NR_CLUSTERS; i++) {
-		u8 dead_cores;
-
-		offset = EMU_FUSE_MAPX(i);
-		emu_fuse.value = nitrox_read_csr(ndev, offset);
-		if (emu_fuse.s.valid) {
-			dead_cores = hweight32(emu_fuse.s.ae_fuse);
-			ndev->hw.ae_cores += AE_CORES_PER_CLUSTER - dead_cores;
-			dead_cores = hweight16(emu_fuse.s.se_fuse);
-			ndev->hw.se_cores += SE_CORES_PER_CLUSTER - dead_cores;
-		}
-	}
-}
-
 static int nitrox_pf_hw_init(struct nitrox_device *ndev)
 {
 	int err;
-- 
2.17.1

