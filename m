Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752631AbeETNvi (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 09:51:38 -0400
Received: from mail-eopbgr40065.outbound.protection.outlook.com ([40.107.4.65]:65469
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751410AbeETNuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 09:50:50 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
From: Nipun Gupta <nipun.gupta@nxp.com>
To: robin.murphy@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        robh@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        gregkh@linuxfoundation.org, laurentiu.tudor@nxp.com,
        bhelgaas@google.com
Cc: hch@lst.de, joro@8bytes.org, m.szyprowski@samsung.com,
        shawnguo@kernel.org, frowand.list@gmail.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        bharat.bhushan@nxp.com, stuyoder@gmail.com, leoyang.li@nxp.com,
        Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 5/7 v5] bus: fsl-mc: support dma configure for devices on fsl-mc bus
Date: Sun, 20 May 2018 19:19:49 +0530
Message-Id: <1526824191-7000-6-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
References: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::15) To VI1PR0401MB2429.eurprd04.prod.outlook.com
 (2603:10a6:800:2a::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0401MB2429;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2429;3:MzZxNRa+0UhPSRBxTHSDB+gIlElMnYbc/L70/VdR6f+Wi9zsMFZBwUA2rNn0Jw4RhAUyFJPvIsFS0ymCFrOjFl3zRVkNi+AoheeD22FmnlSb8gc2f3wro/Tc4RK/Av2GtbZztbZIF3cebDZsphCbmVRjtMiEtg1RMgMaaEZ6skLUqocmDQ5mce0HBHobmJ4cAkzCnPE5YOHTutQ68g4+Sw/Qadn5O19lP5NEPl2pLljkgohZ22sak3v1aeqxn1op;25:EQ6JfTgjApUt/QXgtykducOCo/Q34JJ3Zz9bqjbC42LRMsQQhUU4bhbyR6tLe56OEVuiRr1VeCOGGOkdEiGNk/UJ3jCdrCYSLc4t8N9pCW7b4kqqAW+ZiuAsVXD4fk6lPTq+xEB08MlSFS/vZrnURQq0YJzjvbjEpkaI3PIeRUwuv+XGT1efMQKD7ZnJnld+3weNGwtWfyIot3LJXyHoXm1out+6v05W90XvOBnDn0qHcwRdwT9JT5gx5BQB3lKGGXnz2Tw9xOUT2sB1o1yQ1TWJpZUPA1UDvm9SX+s3ZU9PAJvMxRomLYlsg/wc7oLNPyfqwbi8JuALUUaiYqS2lw==;31:7Inxn1hvNk8jOd0pOpKvTmuWjuwLoRLiiSh1s2oVLXgkqOIuAVK3A/1RowQJ7E0EgQ+jQdsOhYvkRIvKqNTFCREJphk8If7ernCtAy7jP03U4RgrpWAlnERPQtrgJvrbwgu0s97sekm2d7SZQ20I48qHj+aBzr2Wa1FMacGzO4QA61uMZRr9t7ULSLjXVsY4nlRuQMHdKMLtXvaAkXlIXgMb5oZMbMS0ycsOsEpaUdY=
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2429:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2429;20:hE4W886UkMl8sgmRHs7OxH2nCAPdHeI5GGbNSArr2CdiqgTK841IbvSYA31UmNTB21VOuTBvklVCoSeaes0ktUFGXmhKXmJEaReaTFffrPM536dh5shDvnuyJPnDESIh510dF7RxQV6n7SO9Mrm6RvCvtJ/4cqG6LUCUV25quHz/TkzWx2kjKRSA2HXXCtTA5tqOx8I4tFw320Up8kRG689VQtrhJL4AU+s1LRInkjm3eqqKTgTIHhspm3FcmfmbFeIZF8VFDG0E9fg4MHC03ZYT9ScA+LitwMuSiJPY16RKwpAP9ygQ6J6YpMqPcL1XgeaI0HGHldRPrF6/nJFlT89OUslyHzxVPn82LFWEPB1V+ERi7gv2hnPzU3BWuoCRU95GuzX/c5Rm6HDi1Z2umXnt5OkvCm394TXxApehCH/5fGMVJWfqHeSO9fuoGqpmHqReRs9bbwwsqihq3MhSEYsRhVq4f9tSeCHwG+HafSmpFHp4jpnSygfT+s0gZxGW;4:i/6VITjjYPwvuX73hpSxF/F3oJ9LAH+Rn3fjNCiVz90kzOhQs/4rGUMuKNxGTvGkMVgZpYriMHTC50GEgFkJk/cWd9peUc0h+L/L0rD9pAuyVClWwtCgShvEA7EqVJ4P5FfIURfFHUvpZP8hHC/XAAF4IWWfnwRT09MfSZf/7UB0gNepkZW9llIQhzinPIF+eBaiynS5Bfm2OqfIQ9ZmrO2WhS0hQ0OBiEiR3ZCGWKapDoJQF0Z3Pg3RoDRx3YMNO7CAXkwlnQMCDq6zl30r0uQuHJGBFbJ8cIq+lGJ6Ed8ZYoznRR6O3rj8T9lLT4qQ
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2429178AB9828F127626BDDEE6960@VI1PR0401MB2429.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR0401MB2429;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0401MB2429;
X-Forefront-PRVS: 06780E24F8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(39380400002)(396003)(366004)(189003)(199004)(316002)(50466002)(50226002)(47776003)(3846002)(86362001)(39060400002)(66066001)(6116002)(8936002)(16526019)(8676002)(7416002)(53936002)(6512007)(48376002)(486006)(186003)(26005)(44832011)(478600001)(81166006)(81156014)(76176011)(5660300001)(7736002)(52116002)(16586007)(51416003)(6486002)(97736004)(36756003)(68736007)(305945005)(4326008)(106356001)(446003)(25786009)(5009440100003)(11346002)(55236004)(6506007)(386003)(105586002)(476003)(2616005)(2906002)(956004)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2429;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0401MB2429;23:dg21S0xLPraw+JFZGkDwWGeTp/2Ja8YuRNYt4iS?=
 =?us-ascii?Q?dJx7ivCoqtRrYsJ0YWLWlu3U0+e1tzrOZvZLZQ+Cp8c35G/6npNB6nU+41cK?=
 =?us-ascii?Q?siLfIOv4lPpiNYSj2jiMAuF0WtTlBOb1G5OW1Xsfejwjkc3FhpL3ELuhEFtx?=
 =?us-ascii?Q?xqmdoMMUL0b+XKYBIqIE1CeGB030g5pY45JJfzDfcZ28YATA1DXynJXh8n1h?=
 =?us-ascii?Q?AFmjMCZJFDmqAa8DtVtaqSDUpax/ZA322AIvadEQJB/FoHLrs8gZUOEC5wd4?=
 =?us-ascii?Q?f5EurEKxDTAbURTb3/s8a4YAUe2QntiTRtN9QwiOXkl/xLUC05gTH0Lp86M0?=
 =?us-ascii?Q?xW+Iw6oDXNwzWtC/+J6Nsqqj4I4SQ+mRxuyMwUqWmJOkgmhsFisERwzeUObx?=
 =?us-ascii?Q?wOwPYQkvc79zeyXKns6cQq1abkoDVf5suW/6jvErFtXu9c0VVNgpJ+rkJaNc?=
 =?us-ascii?Q?IDmgRqAWr54UXkWu8X2wFikx/iAw+NP8ovGHwi88lGpDO4rluCChk1zhMVNR?=
 =?us-ascii?Q?p0q68VMTy8AKKPUeVuPgGrKTAzrXM7d9Mw1VT4CqrZqqAbg8nDhMqk0hUHNH?=
 =?us-ascii?Q?H/elqSwDP+Ld0N/ltM61bnen/MrsOm/VI17Wv7VlWiVd7aRwUU9K74IayChX?=
 =?us-ascii?Q?BaMf5SI0hTGwvYeHQ1dtgeqEguQDfaG1K7ikMp69RGMsbUXXhN1cZTQXORje?=
 =?us-ascii?Q?pbcuycNpSwMnQ5XlYx9JArdCUh+8dJQE+HTea5EdNA/U6lIxeI48zLSnkT3f?=
 =?us-ascii?Q?T8rzWCQutJPuWxLJLzLWb45T3wVONgAbsJYbnHHh5AagYhUisY28Mo1LB7BS?=
 =?us-ascii?Q?0Hqb+gs0tkzkW98zz4IR3ZwvUMYvu+IfHB2eo/N0swVQI8thIO70ijYii1sL?=
 =?us-ascii?Q?TwJkK3YcYEjC4lgN2SzT4gfIkWu4KXseA3TivDVuJLO0KbuyQLhh2QaY5YIo?=
 =?us-ascii?Q?vbVjopD6c0yyWSw0DDcpkw9NSky1LqVBMghcq5hgeUxY3fnd+6MIKXYmZ2So?=
 =?us-ascii?Q?2a4lmFnmPx3tTbUJkkygbTbdTTdZCwR+eU8KVHagH6CBfOyMBQcFVarFs60t?=
 =?us-ascii?Q?llInYvSI6ExFajGljXcP7VUXQEnO1qgIE9nZ0RPKnKKe9PQqPtJ2LOELy2zH?=
 =?us-ascii?Q?eNYxpHdYrUzlQ+Pld4n9MxL5QJAWqHBWcCt/a7p1jL9fIQT6kBQVEhpsd5RV?=
 =?us-ascii?Q?uQdQPouGAa7soAmcHUZ8QqckgxbePfxt/y7x6t9xtbhbD123prp1MccY+kUp?=
 =?us-ascii?Q?WrhuyDMra33IVNRorJd0nm+duQf/mg/133buuKs9E9J31X49TKFXMpwBoLxu?=
 =?us-ascii?Q?vpg=3D=3D?=
X-Microsoft-Antispam-Message-Info: aXE+ubPGZ8gmNg5ikMfy6x6Uo1FXXhdSo4AVUwsnhgVJs9DRnDJMlPKXey45+yVyh+OYONR9csD32xbFitL5A7j484PDf1PlxKd1eoWj/OBYg42FWjJY7Ju7cRXIKxQoCb7PYenBP+lZ9eKlA0eSEyN5oE0XIZgpYtXVUYZuiX1XZZXuqQkM1HiOT2J5phcT
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2429;6:RiO3+C2y9XZF9F0aw97EUYhijOw+bMIJfzE6qY5vf28YY1FtFbvfyJfE7k+C1FlF1nwTPXHZWMUc0vlso8gDfZfsdtOg7PbZLjLBaJlRh3W22IpkbQFBB8U3Old1W45+Ct3U5VWDq4jFjobqRuQumWttlu4o9xQEvGnhN9tZIAEai5PwjNO208J7wtNCBE1Iz55OhIPciwsE/Oey0ZNqYvlV36oPZRGXUseR26ENbELqQd0FoIRtKuL5Mq3prcDZpjplfngQBC69ks9KsTxs6cl/AOELujYV13tRNpQAMNtyV2JomnmpWa5B0HLNA0YVbva1Q1poMhaX/wMilY2SAvUqzf5jpDmq2rj4coozqXSNdV9blPn5vTlcibOELDjNgFgg66kN3yhF5F3VvzZTZ1BwsngvYAOAX3AgqmonHFgd4+mLc2GJZgySobaBX3/lI4laqztZ2dVB+hSsu/BjlA==;5:NZa29Tqp79rodAqIis5jSw3O9eAi9hxQZiVeNqhZgMxRXuoaFimQQEMl0qAELKT/G/4sZ+ALB6rcCfTTRdSnsEFRHqXXRFD0rhsokJuIXhpr7NU2EKO1+wGjzllJ7qODm5P6fjbjkeUZ7UoaqmY49tcOas1EhLyEaPEYOVPhVdA=;24:CxKnKGllRJFwqXl/L+pHVXP3BDlF0lVP5q+YDvVWSKYRGiTSimfUEMIM66KKOJEdqwoPimW77uYjiXOXym2e327yphmwgij81nnuGXdxCS8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2429;7:EdrjtVmsXzBmf8jlIWE3kw6f8NuwWFWGq/I9syznZ9GFzK7NEhpomQW4jjTmGtJ0tSmIVzpL0oV6sfcLIZmzRTgjHPK2Gx3JPyZ6aTdDUKSlsV6luAV6AN36kNj1AW302kz38RJGo311wqXI5e/6EOZ6ZFzzExIZ966bOob+p8CP9vY1j2/kA+yJG1ZJhzKBmvPfjXpJydcqc+CTPqiUvoSZHrSu2sgmMDx1PEkvjoqW1Fv6+1dnNGH0vtrlxQIv
X-MS-Office365-Filtering-Correlation-Id: 7b8fac6d-6f46-490e-0086-08d5be58b00e
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2018 13:50:42.5712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8fac6d-6f46-490e-0086-08d5be58b00e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2429
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support of dma configuration for devices on fsl-mc
bus using 'dma_configure' callback for busses. Also, directly calling
arch_setup_dma_ops is removed from the fsl-mc bus.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 5d8266c..fa43c7d 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -127,6 +127,16 @@ static int fsl_mc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
+static int fsl_mc_dma_configure(struct device *dev)
+{
+	struct device *dma_dev = dev;
+
+	while (dev_is_fsl_mc(dma_dev))
+		dma_dev = dma_dev->parent;
+
+	return of_dma_configure(dev, dma_dev->of_node, 0);
+}
+
 static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
@@ -148,6 +158,7 @@ struct bus_type fsl_mc_bus_type = {
 	.name = "fsl-mc",
 	.match = fsl_mc_bus_match,
 	.uevent = fsl_mc_bus_uevent,
+	.dma_configure  = fsl_mc_dma_configure,
 	.dev_groups = fsl_mc_dev_groups,
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_type);
@@ -633,10 +644,6 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 			goto error_cleanup_dev;
 	}
 
-	/* Objects are coherent, unless 'no shareability' flag set. */
-	if (!(obj_desc->flags & FSL_MC_OBJ_FLAG_NO_MEM_SHAREABILITY))
-		arch_setup_dma_ops(&mc_dev->dev, 0, 0, NULL, true);
-
 	/*
 	 * The device-specific probe callback will get invoked by device_add()
 	 */
-- 
1.9.1
