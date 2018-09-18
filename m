Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D038C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC9B2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cJZMPWyg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC9B2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbeIRSgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 14:36:35 -0400
Received: from mail-eopbgr20093.outbound.protection.outlook.com ([40.107.2.93]:10848
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729197AbeIRSge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 14:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyJCviY4A6ZQ/mHUB9xmkNUI/NTWK9qDZLpb83A1nlQ=;
 b=cJZMPWyg/rdcf8gU0EioOTYbijIaF0sQDRSgXUwSKPxYt+6giFbyeXIyfUp0GlVhQ34t1w7BNbF7AeQe20vmtnjqmKINoNrQ6+d8dLZr42dg4hZR3UbcJVkBvGI6aHQERpgLGlZkUz5M6/CqO+A6gJ/1VDYbdPQJDHhw44WeKrE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jan.dakinevich@virtuozzo.com; 
Received: from work.sw.ru (185.231.240.5) by
 VI1PR08MB2782.eurprd08.prod.outlook.com (2603:10a6:802:19::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Tue, 18 Sep 2018 13:03:53 +0000
From:   Jan Dakinevich <jan.dakinevich@virtuozzo.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Mark Bloch <markb@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Kees Cook <keescook@chromium.org>,
        Kamal Heib <kamalheib1@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Denis Lunev <den@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Jan Dakinevich <jan.dakinevich@virtuozzo.com>
Subject: [PATCH 3/4] IB/mlx4: move pkeys field aside from mlx4_ib_dev
Date:   Tue, 18 Sep 2018 16:03:45 +0300
Message-Id: <1537275826-27247-4-git-send-email-jan.dakinevich@virtuozzo.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1537275826-27247-1-git-send-email-jan.dakinevich@virtuozzo.com>
References: <1537275826-27247-1-git-send-email-jan.dakinevich@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1P18901CA0005.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::15) To VI1PR08MB2782.eurprd08.prod.outlook.com
 (2603:10a6:802:19::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73ac78f0-0164-423f-de39-08d61d672fff
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2782;3:BjkfbF65l7dUSHKGhtPGZ/JYFIC6v80mQ2gwXgG9NNyB52Q1PvBZVXx0Z6bTeSTICndebrlSzsGqFieig+BHAaT5z5ZmzHzBAe5/gMWCbxGQj9BpG8frX2XuewXHwUdBEJjOcP9IkIZ1CRltpnsWzeudVLtGCZs0Wcv3rGm2jyh6kSfiKTp0o4f7KYA7oJnbnK2A5rQAwMSc4wHtBnzV5p/B/0AWDT9f04AU7HLW3WqCw8NstnpU/kbUa7oXIiCz;25:CQuR/etJEo2o/LWKQkZTBcbXifSnDumoK/+Bx/yneZAaE1jNm8AmOSEqjOD4ynxjcXSt6kbnHDzGvoSAPpJGa6UlsV2bXr1p5pR+z2RZANuB6aD7GiwmdzsjwIs3ZUSDAw5/Ir//6vWJkO0mjFJcx8FsyPbYGP1l6xwe4P1Rmzbalimsb8FFWNPS/SBBAXC5W2j7MsN+9WVI+lF0thAHc1X3wjEf0Fm3JgSaAmdalTdFuvDkX3o31ApHCnMnDvaRK5wzLeST4FbgNfsHYwuy7GxqWROTm8Y2pcXO+cUNkl9l2GP28CCZsZyVGDMc4W0HEaUC6tNtkXF8gQ+yl6jtiQ==;31:Gbz7mu/Rh4Rz6utBRafp0Q06xT+FxVb7P/Po9c0SsQCLKyq0YaTRmtLAuwE8cnff4IiLxu9pjJGJiHQWWjfQ/HxMAlD3ceD7kMv/z/e/zouNbvztcYeMglu0zP0e7DW69/vyvFRSEkXR5+0JAFDrdY7nsGR5qf80A8o+qtMVjM7PMYqST9WhiOgohsHn/uU9Mwe8ZBmMRDhnjJGQJoqZofngGRgCZ1mX2Z3F7rQRe28=
X-MS-TrafficTypeDiagnostic: VI1PR08MB2782:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2782;20:R472toj/+9I/kp7QrBu5vs0y96DlO+CxXXwlu0SegnTMOlgGZlKjscYHO542GC1CqHMc9fWgwZ/tRNLEUL04ypXyaOXp8bk3SmDZYErGH2mw515/C4dgwW5E070RlYCnS9CgZMG4cZD44mVGVzdH38YJQaK/Of5/AcQw5/tJAbw668mixV3lp/xW4+N7KVXIMG3axhJqpa+oqBhGabPG4PvBnXAQ1LB6uo/Vt4mI9SkyIp3nAcLPLcz7q2FZKCrCqI/NELjh5gt5H1qJJaWfuZ0lHn193G1gJ6v4kkr/5fFIXiqU0PiNBvNd6g+hmfj+pNlP9qTaIqjRJ4VkU5YK9g+H2Me4uN6gjStEcB7IDvw4WCWSH/aTqyGbdFDnduogCIixoXLR7Tffv+Z4zDlnimdyGq8sOVuleAy50fXkf8ukt4R/AcM3Vvq2Nxtl3plRqgEpuT7P0SXXQmSNPQCq6e5D0ycZIlmj3sxiOpAwKkU/cfop2J67lqyGREYS091l;4:sXlbuHl1q5N0Atk68m0yqNzHSPTh2DuISVPgpwFUX51DL1ibIVFb/w8I+hWkexPVqaQQF+VKAtCki35ChRT695VweEYsayuejefHHhjdJCZ6CcrZQXGEmFP3jR7IIN8rYFf9sgl+OskE+BlrvNFX+y/OSuc4N+pmQWPdmdsirOJqvY15tXtW3yARBoMBNFWo3iT69CGoHMi5hbo6a05P4g8QNB9bOHuWSX8x5QE7CM9PBTFHPi0wywF4gJKY4mAoYsgkQdvgzzwZcvr8+Yp6KA==
X-Microsoft-Antispam-PRVS: <VI1PR08MB278241036AA481635EDCEB908A1D0@VI1PR08MB2782.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:VI1PR08MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB2782;
X-Forefront-PRVS: 0799B1B2D7
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(136003)(39850400004)(376002)(189003)(199004)(3846002)(486006)(16526019)(44832011)(7736002)(26005)(68736007)(39060400002)(6116002)(54906003)(186003)(53416004)(81166006)(305945005)(16586007)(7416002)(107886003)(66066001)(2616005)(106356001)(956004)(8676002)(50466002)(8936002)(478600001)(446003)(105586002)(11346002)(476003)(110136005)(81156014)(5660300001)(6486002)(6512007)(69596002)(97736004)(4326008)(76176011)(25786009)(47776003)(52116002)(316002)(2906002)(50226002)(386003)(6506007)(48376002)(36756003)(6666003)(86362001)(51416003)(53936002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB2782;H:work.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB2782;23:MHynDaTl+tzz6hRTveA7+U2hOO5MiFabytm65bBnb?=
 =?us-ascii?Q?5xbRP92lnw+HK1fDQGbmiyav5dcKnW7m7msdVp+IFpr2fhpRHspXXS/snAsM?=
 =?us-ascii?Q?bH62nGKj04mLQEeXm2Wh8QJiABeIXu7nfIC+7mCX++m1xTTbpQXGoGt/DDAb?=
 =?us-ascii?Q?PyiIFMK+rg5elQHd8YBrCVl9htIsiYfJfeV168Iwu6ivEJRAxBYji2Cxf5Zo?=
 =?us-ascii?Q?0FKvv6ONRwOGhW8d8Vg9Ck2H3Z8/QlI4ktJKl/8xoCwy3aEa3RCgk+uMJeO+?=
 =?us-ascii?Q?wj/b/uUNsCxZp1E7QL8jLX75CZSEIYRjPXOLUhzwFOyWf06k2HydTPIE9kOs?=
 =?us-ascii?Q?KvKKhLtLHtXwb72zy/1xsZukaJ48Bm8tS+54AwqhO5PfuEPh6cl7oD65PEEe?=
 =?us-ascii?Q?W2W8JiH9za2Y9whc/2ioLfR9cZQI7zwkfVSsZSd87Sg07IcmDwPf7rYxYQTV?=
 =?us-ascii?Q?HUyx5N8T1K5jFHU/HQ4WpyWYLgLQzFvpZW92oHMaJdmCTxImxP+U/2Jig+ID?=
 =?us-ascii?Q?oy1o7DdeMMZzEWX1V/8dDbfAJuuF0WBTjoskoUcqNGMJDobJqQERmXDbtO94?=
 =?us-ascii?Q?xcJOL6YUonJrhZt5ZaMxf55QUQ8/Jr4P7l+7WEEBp8Ae794CXswkEZHfajPy?=
 =?us-ascii?Q?Pg9vxSyvOvbZlZYA7cOMPjIJyUqc47cS+JMBlrU+Cdn2jjO5hatkPrDqm286?=
 =?us-ascii?Q?qSV4fhCPmRpkmSY53ZqZZv+d1RW9wKWUQ4jYYcJcQONGTWaFayq0sTDFjU7I?=
 =?us-ascii?Q?iebkd0ecluf3XPoCIyIhTX5PorVXtBoyrrRyQk8aLtNzZ5dWVZSFNYf8a+BM?=
 =?us-ascii?Q?RtB4uzdU4XBVZYVQyEE0RTn++gM0KLi1ffj0KAGQXV93ILzMFwSOXn+vWQ2G?=
 =?us-ascii?Q?KbopBDaRYqQQDHWp6nV0QZP64vtzCMobAwtYqmbzNyUrh5SLqeWEcVwmHJ0G?=
 =?us-ascii?Q?mGIp8StK0ECdzBIUD9a9s0Z8r9GmU0ogcfQ6mMCHOndHlNdqEHfh/ZbMbXuO?=
 =?us-ascii?Q?3W8bDnNZHXOn1zfXD9bVM1agGjYRcg/oBAtajI7J/WVoJ3R00kT4skomt8TF?=
 =?us-ascii?Q?zAQ1snUWz7XRfbvXXVh/rvZfpjr43Yv1nTum86M0dUk27lYEhUmvbvaiQn9W?=
 =?us-ascii?Q?pBQ40Hih3ybsO6r7FjskpRy6ZOV9DZUHQ7NrHYvRD8bsHCA3kpsu7bUnKkE+?=
 =?us-ascii?Q?4cnTHc0srUkaMldZ9tDXkNpd4Mp705zPZDVGIijhJcDCT5S9DVoV+CtaTICP?=
 =?us-ascii?Q?QVf6IbFUGMYGXNxl2ZDoLdwCrn07GTO4ZZfBgpz1sQY9pVcoK2KxE4r/zwNr?=
 =?us-ascii?Q?WvHOQun36SuRFm5td6bjrdRbsYUvty6vgc+CIfEN3d34ZGFyBg43C0zZZfRZ?=
 =?us-ascii?Q?hBdFQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: L2gP3iQ/lp6T6ijybymEtxP55HDNu0KD92g0qs+RdcKraE/b2xO8KtgD61fPMtL0ElHv/ass2+agvQo4WKmFyMlGRo3OKauSjEpSMxdaGOaIayYVOfpUiQP9lI1j8mUHSpYzbgco1QW0fw7DnACwwgRhDv1vniWpDtpF6Wa8G+IAZq+Xl6O/oxJK4T+6fU/8CL7qahPEYuy9LMN04DSMYGiaRRJFQPAINLG9LDq5blE/UqxsJ3XUtBbbSnLJtWAp1o/+BhOELxN7iPtaPMTcP/6aT61OcFgbz4Blkm08D0o8lbYV1oXA1UuBNG30DTWf5nugzvpFAJiK5IZuSW7mp+q097Ea3O5JREgopSzzSPs=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2782;6:0NlizPgMyCY18BRjMtrnlE4QFAmvpQ5MZAZjDO5gWNrbPNwBGbbsEMyDMeHNKNU3URN0L4j+wwRx0kIDlwD8wA4vNrMRwrdoxWScRBwfOiqnPH1SAnCmeFsumr6K8t0oPVkEC7HFo0ufWJL/50PEqZd/IyN7qjWJjo78JpH3jYOcBmSaJpmp7g9bblQvLgAZRbmRXCYuqR1rK7bxcbmQ8vXBXtf8GZ0Njoi+UFaVGo/TSAr+hebVj/qGHZZf1uIi7ufbJxBZL//GYloYqRgS/+X6aRKLAu1G6/I7bielomcLk4qH9SQmMHsbeJEsnj4yJ8zSn62IBcUyI+wKzouwojRmnZA8ebUaie8IIJeQnUj3BRfkQSgA6a+fcsgzWa01I8660ApMeQrroXP8csXEoTx2Yldq76XDmJAboQfp3ZEIa72JwL4DsEtUvD3WSyKM6/ZWF7s2n66l4cUkDNUTlA==;5:2nCvy46F/N5XD/TNCfR3bq6929R4Hx/LWg18UwyzVe751rdCYtpAJMW163DBkfnoYmMz8dCxBkxqTgKSwSrqkkPqypcZLCsU07aHibyIZEPNs+RMzKyk8Rp9IVfAQWmOgD9jm5wFu05LQXQ/scAC/oMg3GwzrLNPW1N57pdiKZY=;7:ZF7D941GaL3LVmMpGC3srQVbY1MCNf3y8BcmOm6uK8Wz3Gy/2oYYVujmXI8YKxmvKqJhVUPI7RXzvKMs95AGbKwZ927stqPmQf+iW5rvHUpGz7NOrZbcl0OjffVNfLkElo2LH4Dv7Vbm/wEV5doJGAq0uss9P7qv3NTUz8EFezsIpEX0yyTW+oN/X1RXeBjfngGR2TCZXUbOv9DGduKKp55kIqXuhrrcqs3JSEnZKsekupxkACSzXkJLQMVrmwia
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2782;20:DshjPV4/KsEEL0FHXZflFE3LiUzMM+Sz9Lz36CCv7GwsddhwGhzBuv92GtskwRemYHrhz2MtRQ2kSE+G0UVEIVRb1p594PsNZD7F8bPiIhzBrzgFzfwMnW/aHVUj0+WPCh8EEg+LsAmcC1zi1WZBj9noeMzAptorV9JfCC88Dnc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2018 13:03:53.3638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ac78f0-0164-423f-de39-08d61d672fff
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2782
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 2nd patch of 3 of the work for decreasing size
of mlx4_ib_dev.

The field takes about 36K and could be safely allocated with kvzalloc.

Signed-off-by: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
---
 drivers/infiniband/hw/mlx4/mad.c     | 18 +++++++++---------
 drivers/infiniband/hw/mlx4/main.c    | 11 ++++++++---
 drivers/infiniband/hw/mlx4/mlx4_ib.h |  2 +-
 drivers/infiniband/hw/mlx4/sysfs.c   | 30 +++++++++++++++---------------
 4 files changed, 33 insertions(+), 28 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/mad.c b/drivers/infiniband/hw/mlx4/mad.c
index e5466d7..3eceb46 100644
--- a/drivers/infiniband/hw/mlx4/mad.c
+++ b/drivers/infiniband/hw/mlx4/mad.c
@@ -268,9 +268,9 @@ static void smp_snoop(struct ib_device *ibdev, u8 port_num, const struct ib_mad
 				pr_debug("PKEY[%d] = x%x\n",
 					 i + bn*32, be16_to_cpu(base[i]));
 				if (be16_to_cpu(base[i]) !=
-				    dev->pkeys.phys_pkey_cache[port_num - 1][i + bn*32]) {
+				    dev->pkeys->phys_pkey_cache[port_num - 1][i + bn*32]) {
 					pkey_change_bitmap |= (1 << i);
-					dev->pkeys.phys_pkey_cache[port_num - 1][i + bn*32] =
+					dev->pkeys->phys_pkey_cache[port_num - 1][i + bn*32] =
 						be16_to_cpu(base[i]);
 				}
 			}
@@ -348,7 +348,7 @@ static void __propagate_pkey_ev(struct mlx4_ib_dev *dev, int port_num,
 				continue;
 			for (ix = 0;
 			     ix < dev->dev->caps.pkey_table_len[port_num]; ix++) {
-				if (dev->pkeys.virt2phys_pkey[slave][port_num - 1]
+				if (dev->pkeys->virt2phys_pkey[slave][port_num - 1]
 				    [ix] == i + 32 * block) {
 					err = mlx4_gen_pkey_eqe(dev->dev, slave, port_num);
 					pr_debug("propagate_pkey_ev: slave %d,"
@@ -455,10 +455,10 @@ static int find_slave_port_pkey_ix(struct mlx4_ib_dev *dev, int slave,
 	unassigned_pkey_ix = dev->dev->phys_caps.pkey_phys_table_len[port] - 1;
 
 	for (i = 0; i < dev->dev->caps.pkey_table_len[port]; i++) {
-		if (dev->pkeys.virt2phys_pkey[slave][port - 1][i] == unassigned_pkey_ix)
+		if (dev->pkeys->virt2phys_pkey[slave][port - 1][i] == unassigned_pkey_ix)
 			continue;
 
-		pkey_ix = dev->pkeys.virt2phys_pkey[slave][port - 1][i];
+		pkey_ix = dev->pkeys->virt2phys_pkey[slave][port - 1][i];
 
 		ret = ib_get_cached_pkey(&dev->ib_dev, port, pkey_ix, &slot_pkey);
 		if (ret)
@@ -546,7 +546,7 @@ int mlx4_ib_send_to_slave(struct mlx4_ib_dev *dev, int slave, u8 port,
 			return -EINVAL;
 		tun_pkey_ix = pkey_ix;
 	} else
-		tun_pkey_ix = dev->pkeys.virt2phys_pkey[slave][port - 1][0];
+		tun_pkey_ix = dev->pkeys->virt2phys_pkey[slave][port - 1][0];
 
 	dqpn = dev->dev->phys_caps.base_proxy_sqpn + 8 * slave + port + (dest_qpt * 2) - 1;
 
@@ -1382,11 +1382,11 @@ int mlx4_ib_send_to_wire(struct mlx4_ib_dev *dev, int slave, u8 port,
 	if (dest_qpt == IB_QPT_SMI) {
 		src_qpnum = 0;
 		sqp = &sqp_ctx->qp[0];
-		wire_pkey_ix = dev->pkeys.virt2phys_pkey[slave][port - 1][0];
+		wire_pkey_ix = dev->pkeys->virt2phys_pkey[slave][port - 1][0];
 	} else {
 		src_qpnum = 1;
 		sqp = &sqp_ctx->qp[1];
-		wire_pkey_ix = dev->pkeys.virt2phys_pkey[slave][port - 1][pkey_index];
+		wire_pkey_ix = dev->pkeys->virt2phys_pkey[slave][port - 1][pkey_index];
 	}
 
 	send_qp = sqp->qp;
@@ -1840,7 +1840,7 @@ static int create_pv_sqp(struct mlx4_ib_demux_pv_ctx *ctx,
 					      &attr.pkey_index);
 	if (ret || !create_tun)
 		attr.pkey_index =
-			to_mdev(ctx->ib_dev)->pkeys.virt2phys_pkey[ctx->slave][ctx->port - 1][0];
+			to_mdev(ctx->ib_dev)->pkeys->virt2phys_pkey[ctx->slave][ctx->port - 1][0];
 	attr.qkey = IB_QP1_QKEY;
 	attr.port_num = ctx->port;
 	ret = ib_modify_qp(tun_qp->qp, &attr, qp_attr_mask_INIT);
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 1e3bb67..8ba0103 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -2477,12 +2477,12 @@ static void init_pkeys(struct mlx4_ib_dev *ibdev)
 				for (i = 0;
 				     i < ibdev->dev->phys_caps.pkey_phys_table_len[port];
 				     ++i) {
-					ibdev->pkeys.virt2phys_pkey[slave][port - 1][i] =
+					ibdev->pkeys->virt2phys_pkey[slave][port - 1][i] =
 					/* master has the identity virt2phys pkey mapping */
 						(slave == mlx4_master_func_num(ibdev->dev) || !i) ? i :
 							ibdev->dev->phys_caps.pkey_phys_table_len[port] - 1;
 					mlx4_sync_pkey_table(ibdev->dev, slave, port, i,
-							     ibdev->pkeys.virt2phys_pkey[slave][port - 1][i]);
+							     ibdev->pkeys->virt2phys_pkey[slave][port - 1][i]);
 				}
 			}
 		}
@@ -2491,7 +2491,7 @@ static void init_pkeys(struct mlx4_ib_dev *ibdev)
 			for (i = 0;
 			     i < ibdev->dev->phys_caps.pkey_phys_table_len[port];
 			     ++i)
-				ibdev->pkeys.phys_pkey_cache[port-1][i] =
+				ibdev->pkeys->phys_pkey_cache[port-1][i] =
 					(i) ? 0 : 0xFFFF;
 		}
 	}
@@ -2595,6 +2595,7 @@ static void mlx4_ib_release(struct ib_device *device)
 						 ib_dev);
 
 	kvfree(ibdev->iboe);
+	kvfree(ibdev->pkeys);
 }
 
 static void *mlx4_ib_add(struct mlx4_dev *dev)
@@ -2636,6 +2637,10 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 	ibdev->iboe->parent = ibdev;
 	iboe = ibdev->iboe;
 
+	ibdev->pkeys = kvzalloc(sizeof(struct pkey_mgt), GFP_KERNEL);
+	if (!ibdev->pkeys)
+		goto err_dealloc;
+
 	if (mlx4_pd_alloc(dev, &ibdev->priv_pdn))
 		goto err_dealloc;
 
diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/mlx4/mlx4_ib.h
index 2996c61..2b5a9b2 100644
--- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
+++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
@@ -608,7 +608,7 @@ struct mlx4_ib_dev {
 	struct kobject	       *ports_parent;
 	struct kobject	       *dev_ports_parent[MLX4_MFUNC_MAX];
 	struct mlx4_ib_iov_port	iov_ports[MLX4_MAX_PORTS];
-	struct pkey_mgt		pkeys;
+	struct pkey_mgt	       *pkeys;
 	unsigned long *ib_uc_qpns_bitmap;
 	int steer_qpn_count;
 	int steer_qpn_base;
diff --git a/drivers/infiniband/hw/mlx4/sysfs.c b/drivers/infiniband/hw/mlx4/sysfs.c
index e219093..a5b4592a 100644
--- a/drivers/infiniband/hw/mlx4/sysfs.c
+++ b/drivers/infiniband/hw/mlx4/sysfs.c
@@ -447,12 +447,12 @@ static ssize_t show_port_pkey(struct mlx4_port *p, struct port_attribute *attr,
 		container_of(attr, struct port_table_attribute, attr);
 	ssize_t ret = -ENODEV;
 
-	if (p->dev->pkeys.virt2phys_pkey[p->slave][p->port_num - 1][tab_attr->index] >=
+	if (p->dev->pkeys->virt2phys_pkey[p->slave][p->port_num - 1][tab_attr->index] >=
 	    (p->dev->dev->caps.pkey_table_len[p->port_num]))
 		ret = sprintf(buf, "none\n");
 	else
 		ret = sprintf(buf, "%d\n",
-			      p->dev->pkeys.virt2phys_pkey[p->slave]
+			      p->dev->pkeys->virt2phys_pkey[p->slave]
 			      [p->port_num - 1][tab_attr->index]);
 	return ret;
 }
@@ -476,8 +476,8 @@ static ssize_t store_port_pkey(struct mlx4_port *p, struct port_attribute *attr,
 		 idx < 0)
 		return -EINVAL;
 
-	p->dev->pkeys.virt2phys_pkey[p->slave][p->port_num - 1]
-				    [tab_attr->index] = idx;
+	p->dev->pkeys->virt2phys_pkey[p->slave][p->port_num - 1]
+				     [tab_attr->index] = idx;
 	mlx4_sync_pkey_table(p->dev->dev, p->slave, p->port_num,
 			     tab_attr->index, idx);
 	err = mlx4_gen_pkey_eqe(p->dev->dev, p->slave, p->port_num);
@@ -687,7 +687,7 @@ static int add_port(struct mlx4_ib_dev *dev, int port_num, int slave)
 	if (ret)
 		goto err_free_gid;
 
-	list_add_tail(&p->kobj.entry, &dev->pkeys.pkey_port_list[slave]);
+	list_add_tail(&p->kobj.entry, &dev->pkeys->pkey_port_list[slave]);
 	return 0;
 
 err_free_gid:
@@ -716,19 +716,19 @@ static int register_one_pkey_tree(struct mlx4_ib_dev *dev, int slave)
 
 	get_name(dev, name, slave, sizeof name);
 
-	dev->pkeys.device_parent[slave] =
+	dev->pkeys->device_parent[slave] =
 		kobject_create_and_add(name, kobject_get(dev->iov_parent));
 
-	if (!dev->pkeys.device_parent[slave]) {
+	if (!dev->pkeys->device_parent[slave]) {
 		err = -ENOMEM;
 		goto fail_dev;
 	}
 
-	INIT_LIST_HEAD(&dev->pkeys.pkey_port_list[slave]);
+	INIT_LIST_HEAD(&dev->pkeys->pkey_port_list[slave]);
 
 	dev->dev_ports_parent[slave] =
 		kobject_create_and_add("ports",
-				       kobject_get(dev->pkeys.device_parent[slave]));
+				       kobject_get(dev->pkeys->device_parent[slave]));
 
 	if (!dev->dev_ports_parent[slave]) {
 		err = -ENOMEM;
@@ -748,7 +748,7 @@ static int register_one_pkey_tree(struct mlx4_ib_dev *dev, int slave)
 
 err_add:
 	list_for_each_entry_safe(p, t,
-				 &dev->pkeys.pkey_port_list[slave],
+				 &dev->pkeys->pkey_port_list[slave],
 				 entry) {
 		list_del(&p->entry);
 		mport = container_of(p, struct mlx4_port, kobj);
@@ -760,9 +760,9 @@ static int register_one_pkey_tree(struct mlx4_ib_dev *dev, int slave)
 	kobject_put(dev->dev_ports_parent[slave]);
 
 err_ports:
-	kobject_put(dev->pkeys.device_parent[slave]);
+	kobject_put(dev->pkeys->device_parent[slave]);
 	/* extra put for the device_parent create_and_add */
-	kobject_put(dev->pkeys.device_parent[slave]);
+	kobject_put(dev->pkeys->device_parent[slave]);
 
 fail_dev:
 	kobject_put(dev->iov_parent);
@@ -793,7 +793,7 @@ static void unregister_pkey_tree(struct mlx4_ib_dev *device)
 
 	for (slave = device->dev->persist->num_vfs; slave >= 0; --slave) {
 		list_for_each_entry_safe(p, t,
-					 &device->pkeys.pkey_port_list[slave],
+					 &device->pkeys->pkey_port_list[slave],
 					 entry) {
 			list_del(&p->entry);
 			port = container_of(p, struct mlx4_port, kobj);
@@ -804,8 +804,8 @@ static void unregister_pkey_tree(struct mlx4_ib_dev *device)
 			kobject_put(device->dev_ports_parent[slave]);
 		}
 		kobject_put(device->dev_ports_parent[slave]);
-		kobject_put(device->pkeys.device_parent[slave]);
-		kobject_put(device->pkeys.device_parent[slave]);
+		kobject_put(device->pkeys->device_parent[slave]);
+		kobject_put(device->pkeys->device_parent[slave]);
 		kobject_put(device->iov_parent);
 	}
 }
-- 
2.1.4

