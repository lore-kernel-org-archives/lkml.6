Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E481CC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861DB20852
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FTgCEecn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861DB20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932887AbeGINv3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 09:51:29 -0400
Received: from mail-eopbgr60096.outbound.protection.outlook.com ([40.107.6.96]:52352
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750996AbeGINvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 09:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkJ3iKzzRQ6MMatsEs7wM8ojedMNygzOc8t6Z60IiCg=;
 b=FTgCEecnPt3seUjjQ3KnzafHMjmdOE7xVqw1y9GUK7dPsgevIL8J1ocDJVeNAVbNMNfjboGAZbsF5jpzOq0XVRK4frYsXW08YcJFHk5ctGsAnGNKCNg+XAU3ubjh5aPkoJXOj7t68NNNiaI2DmpXY5qJHUpAbDu56WRjJEfuWr8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jan.dakinevich@virtuozzo.com; 
Received: from work.sw.ru (185.231.240.5) by
 HE1PR08MB2778.eurprd08.prod.outlook.com (2603:10a6:7:34::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Mon, 9 Jul 2018 13:51:17 +0000
From:   Jan Dakinevich <jan.dakinevich@virtuozzo.com>
To:     Yishai Hadas <yishaih@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Denis Lunev <den@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Jan Dakinevich <jan.dakinevich@virtuozzo.com>
Subject: [PATCH] ib/mlx4: adjust gfp flags for DMA allocations
Date:   Mon,  9 Jul 2018 16:51:13 +0300
Message-Id: <1531144273-25959-1-git-send-email-jan.dakinevich@virtuozzo.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR08CA0129.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::31) To HE1PR08MB2778.eurprd08.prod.outlook.com
 (2603:10a6:7:34::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d63219c2-e05b-48d4-0196-08d5e5a30c21
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR08MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2778;3:N3J7xKYIypHC1pyXcigbeo7L4OsFTup0a3wA3Azc49Vt0XuShrFpbVje6ILqTPB8MkLOwDh2ijOJk7FbeknlT+CGsM88gxTQKwb4AwChQzzmvLxhMp4SZPuWW7gKzbGQs9n8g2yNpvM7dFxQXOPDGkLW+J8ymWM2EC2Yov+Xgfvc/SYMvcmtyrqnVkNSCZoqRO4XeV4h3tGLCiYy/5eO0XbZCyGoPF7hBIkV5KWlA46vY9h0uLLzx52GG5u4rv0D;25:UwlvghNwx8GudPIOUVoRgj5g4uql+KxRJCoXhBTF0yy9oUzWj7zuZlu3ynOtggltlrrmSpskYg+zrM/mfu5qOfJgwZEBSVeo8F6JeeKqL46Xy9TxxNUDyNuC0Pciv3kesGyd4tvq8Qpl3OSSeUh0vvv/aCIt/RaTG+UmahdKW+Qx40278WLc9wJB9jk/sXijnprUeJY9xZFzH6QbLmA64+jXL/N+W+9tJPuu4SAXMjClGZO4P96OXpfcmrulyHL25lv26XGcJ7Tm11VKQW3y2pzn67p3HL7lN9vysQLiRBADiiRm3zXNRShfLGFhf4RgCk2biIv+5NtDYnKZzCHGkw==;31:43LBWR5yzWyoEdWJjnH6R595zPV0cYqRlwvzmyqNiko3V8QJiNxixVEyqoRkWe0ZUN/IhmyVR6q8Lkkq5SQBo+0Zxbfl20apXK0fsUovqNuGeIfgB3JfA5z24WNYygK1nkLVOK2OR7pVQBviuoerVMwn8BdaU+1crKihjNmnvImfFO46hBottyWLsmeJRvQzWymUBFcWnAgC6mqIbyjBqGr627RFpfrVrsE9m1zwUyQ=
X-MS-TrafficTypeDiagnostic: HE1PR08MB2778:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2778;20:zyROIpBmb02cTkjUIXuY+z1/5QKpPXKabd+PR/3GA5zSD/QDCVsj+OXzjrdQ/hcZzWfYdDGFTRBUPLJz4/Chd6uekahwGjpAtMVl34KRCozYGRKA2OZiJPWy3tXh7DI5kk6StRSNg5pt2pMPMZKkOlrZ2FpMPa4wJ3Vuwp0nRXVnKnzRnCXgvp2zCViDbUPJWcow1j1jAf3AH85PcARELgIO/k4C3cMAnk+xrXD1bumxt24qPFJf13CWm4ZJxht7NVI0A/KgM22pKhsHwylIZ7x2WLQRs7uDQ04C+llWn+bUxkwyGbqmwvXj7J1CuCf1YZ569Rs39bYj8fiO49hnKRSy8dgx5klKCzCjDDO3uefRaO7oOXYadbNkGZ8Q0dcIklBGnJSIcbf72HKFet7mTYRjlrJqqCXXZr2BkQncCmJlxon7u4rNt/qEu/a2mf8hX1fZSLYRSOkL9i1+2tx2T3SY0pxGbnGzwX+rGr9+mp8Df0VqglQEWu7tNxnut6m0;4:Kw8zNs1x0zTPqbeGlzR3+utL3vTpf4JecdjUJNtXcSLB0XG8nt7yy8qHjnRgTvMyuECHokg3RlCeFHjHYljd59fhHVZR4A1HfUN2qLXm6sM4j1E9yrwOLrhbJMcQp73bmx8lKOf7cXh6miyIuHmngHGyqvrzx29TFx6buvwrxjiq7CtFBA732/7o78RzsUsb5nqIquZ7AJrbLug0tScUnHNTotVQr3faI7SZjqw7o9a9idy/TK+w0rQTXEXrTjqVIso2pnEJ/0IeCBOtjbLwvA==
X-Microsoft-Antispam-PRVS: <HE1PR08MB2778AD8A8118BE96AC66A9C38A440@HE1PR08MB2778.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:HE1PR08MB2778;BCL:0;PCL:0;RULEID:;SRVR:HE1PR08MB2778;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39850400004)(376002)(396003)(346002)(189003)(199004)(97736004)(25786009)(956004)(2616005)(476003)(4326008)(316002)(16586007)(2906002)(54906003)(110136005)(6512007)(106356001)(6486002)(478600001)(53416004)(107886003)(44832011)(486006)(5660300001)(105586002)(305945005)(53936002)(68736007)(3846002)(6666003)(575784001)(47776003)(8936002)(69596002)(66066001)(86362001)(26005)(16526019)(14444005)(186003)(50466002)(1857600001)(48376002)(50226002)(36756003)(51416003)(6506007)(386003)(52116002)(81166006)(81156014)(8676002)(7736002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR08MB2778;H:work.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR08MB2778;23:0LFwJfeHdOr1DvWcm4FVldtkOdnBQeeWFpVYjufPM?=
 =?us-ascii?Q?B/t/uonKrjAtN18yKOyfiaRZP+yWGmAOyA14SFkTwv5rTvWV6TthCf3/Ad5D?=
 =?us-ascii?Q?+arn10mMwyGmE9MkGnu23IEUf2iorZhjmoy3/FDMGyb9Gl6xLB55vX4m+8rs?=
 =?us-ascii?Q?DyyZz36OU92cIMsNldv73+wJnRIT9YpOMfozrV+JrjQmtJ/9gdvGc9i+/3BQ?=
 =?us-ascii?Q?BNN2yUYOvhw+4cucRTawoJHP21TP5jMI1V5u9XpE+y7pSMTIO/fagMO/lJb6?=
 =?us-ascii?Q?p8BqLaCVoTW1dO8XoZkyizK6wLnmLtPuLHDHBhpKOdMVnxkomy1YGBlWYY/0?=
 =?us-ascii?Q?1gcH8HOxUIdNR7KuDC3PfrWBU85KtGazPhWTMaT13ZtP48e/HJAcudP+TOpb?=
 =?us-ascii?Q?SM5U7LpwBFTtZOHc76J1OySG7hRh8ChZXFfWDlG829BdYiUZD/HyI1rueRl3?=
 =?us-ascii?Q?4O718HEhEaBZOgF4HRhvcfG6oIk3yWvtpNnarIDfZWbDrsYRp21NtZL+gBho?=
 =?us-ascii?Q?eVAx9+I5/PdNzRfeOHWLt1Y/lMHwQjy0DzHzq/LwSEsNQWMbLHhgTYA0sXfz?=
 =?us-ascii?Q?fToW8+NnG4olnNto3BSYzQlfChckGxdzLUIJsE+LFkCg9InBtcPZ8G7idUzA?=
 =?us-ascii?Q?ipzFXpa2QzSWCwZsYVQOBgChUC2k4zNvf4Pa+w8YiMKdP7piicUv7hggEpPm?=
 =?us-ascii?Q?jWxFpaMTrLTS5NxaUmCIh1oEuG0PzgiJk/KRijMDrEl2/dFZHih4HwcnZcUL?=
 =?us-ascii?Q?gmH+6XAKlYu1mmNPCnQQb7BS8c1MWkPHiduZUq8xBSGtuFvYDXOHwFVvvEvV?=
 =?us-ascii?Q?B79ch8L63yIM0rKtJQnCpFngUU1m5s/+AslX7FRAK5MTKZ/4lreHGI5Csyec?=
 =?us-ascii?Q?yQLCEeJfacYu+k+IoEnN6ufFMS6n0v6xofP9HVblYk6YsFLNZCNlBfGSKldP?=
 =?us-ascii?Q?+ROE3sHE6c47Q7WRcQEJXFMw6p8hNhJXEFKIsI3g4Hdwr6SD65uJY3tptkne?=
 =?us-ascii?Q?97bioyLAPQlcSp7jaXhjSKkywAULNjZ35ucPOtyrbrU+lfbbMBkdkKcCV6Dz?=
 =?us-ascii?Q?fuqG7cV/hMGvIfYAK15bgr99jZ9S7WfoQYplRfL+0W7OErjO11tzo6g0lMYS?=
 =?us-ascii?Q?BN40RaeBzI6koCXpB0FnbRgHK/2mcUNM35qatkYDSb/bNwkaLC2XPeNgzvWd?=
 =?us-ascii?Q?zexA22QxmTmZSexYJYpvlDtomfDKd7wuEudfBYX3RyewRBq3ocEOozqfr1ys?=
 =?us-ascii?Q?Bzr3+5EeeQTuav7UpzAJ5HHlLk0RnEnNFayAxizB0wMbW7OQOt8DqZU1fcpO?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: t1hQe8ND45nFuInxMIAHvc93LJvGDSW7gO8mDzhW5jlQYsXayGCjKwA6jHNOoBYRprPy+I/jre8avWZhHlEu0UBoriQsy1tZoS6lCZblFAg4o/T80NrpNfCAw+EO9RKkKc23wl6c1Q4R8reUUUhWR9iujN77RfAOdYIsBqVcRhHQopHyVZMpzngHvQ7H20GDdKk9FHYvdhZJdJ6CLFg0jU+yXHeIB1JeJKuJrFs2hq8ijasUC7HwAZVm6lXfhMtVHp0gCf4lAoufxo02uHJjX+g+Y/+uivlxOZ9/Js5YSNcoe9yQ9aTaqktkWj1XBHSfM69mas1mimXOOFExEhh/K8HeA41yBeHtuI5lViJi8cc=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2778;6:z0DnOXu2P9rxztq9p/VZynJqAzY+2516rpUJzq4yKyzwcMlMd1SSv4BJjWKgtwWgz8QEUj1zBaOinrd2JHLvaXweAP6dmdRpqmTYYcX1B3IVpmbSJUcx4VWDJIk2Lf0EklDsw8cbwToC2+Adkap7eXokdbikyUsW87nGRwZtKs5tkR5GCn6gnTn5Peuhz6r5WFEGlkvkdeCSE//rmZaLFMvuxBiIB7Cmg8hNxWi/rJCBvnwMHcMjKi2ETdZDAlXGhflc/2+sZj5WTHIaag6mFfBrqYgKsVE3Cs9+U7ho+xC9jt9Hx1SEDm5VJPzoV4+POkG+cdbQ+iRbO4FH/zzCHRAupfOHYViVJzu7y+e0DuRT25tfSJA1sPo1z3E2jKnKpM5B8AqiTfrr3FKuUnMYAg2uc9kmAP+pTaIyfTcaJ8VmPZPCP7i5NUY6kY8Em+yubbwYFk2hq9GZuaYI80gAJQ==;5:e84eFvvBrTt9FSy0v+sjbsOkBNCr89c6itqwAcwG1jbrJz/kYqL+wjA6Id5I2S7WXX6Z2Kn9GlSQ2oC5ynXtkFxhvZtUcjOgsLqkiX/nsdDVryn1EjGmFvnpDaY8be063yfYYb9z2rOwjOd5TpIDwxpsLkVW/MN4KIXqNbAMWyw=;24:Rua1UHLKdL+MksR2T/WbLJhSE4kLJ5u1uadQsGgDzS+kz/Z3d9s6hPz+u2qIUoFJICEMEX8/nZWYDJBeaTEaye9rOf8soPrSqIyyk/uhR9o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2778;7:p3y0m2c7xDJoHJLrPW5EeqNPiw+U7k9V1uSJl7gwOOsfORWBVuHpo6HZlqin8Bow8Hm3wrQHh88b9edTV2Gp6ZQOw18586/R4Bp0RE1+jDY7FEzdb07q1647JSaIdas/rfzj/jzf3V2lWd9vz/N5R/qGb1sCL4lqL1m/dS9oWvLO/F2UhnsjnHGxbbT8jhY0yyJIAaaWEJu0rjhAvVscTQixfQlvLrvOI0856jcU+Mt1iTCwctLRJmjJxoMFKthg;20:PrTN0gsvujz9483ETqZbO7bqOSaf+9DtqYmd8yspnEiWklYGLH+4RkTN8mMMcUHKoEoCRgSULMuQebdb5x7vAKFQ7PiPAfZh03Sinagn1tiTfeTFrTLWjhvrEO8Eex95A5FTb6hJPsrQBMEz1LiJvZrr8ZGmAMtw2meUfZmRr7U=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 13:51:17.5563 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d63219c2-e05b-48d4-0196-08d5e5a30c21
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2778
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For most cases it is enough to use common GFP_KERNEL flag. However,
there is one place with defined fallback path on unsuccessful allocation.
In this case it would be preferred to append on first allocation attempt
__GFP_NOWARN and __GFP_NORETRY flags to suppress possible warnings and
to shorten the path to the fallback in a case of memory pressure.

Signed-off-by: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
---
 drivers/infiniband/hw/mlx4/cq.c            |  2 +-
 drivers/infiniband/hw/mlx4/qp.c            |  6 ++++--
 drivers/infiniband/hw/mlx4/srq.c           |  2 +-
 drivers/net/ethernet/mellanox/mlx4/alloc.c | 12 ++++++------
 include/linux/mlx4/device.h                |  2 +-
 5 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/cq.c b/drivers/infiniband/hw/mlx4/cq.c
index 82adc0d..609f126 100644
--- a/drivers/infiniband/hw/mlx4/cq.c
+++ b/drivers/infiniband/hw/mlx4/cq.c
@@ -102,7 +102,7 @@ static int mlx4_ib_alloc_cq_buf(struct mlx4_ib_dev *dev, struct mlx4_ib_cq_buf *
 	int err;
 
 	err = mlx4_buf_alloc(dev->dev, nent * dev->dev->caps.cqe_size,
-			     PAGE_SIZE * 2, &buf->buf);
+			     PAGE_SIZE * 2, &buf->buf, GFP_KERNEL);
 
 	if (err)
 		goto out;
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index 3b8045f..1893753 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -1193,7 +1193,8 @@ static int create_qp_common(struct mlx4_ib_dev *dev, struct ib_pd *pd,
 		}
 
 		if (mlx4_buf_alloc(dev->dev, qp->buf_size, qp->buf_size,
-				   &qp->buf)) {
+				   &qp->buf, __GFP_NOWARN | __GFP_NORETRY |
+				   GFP_KERNEL)) {
 			memcpy(&init_attr->cap, &backup_cap,
 			       sizeof(backup_cap));
 			err = set_kernel_sq_size(dev, &init_attr->cap, qp_type,
@@ -1202,7 +1203,8 @@ static int create_qp_common(struct mlx4_ib_dev *dev, struct ib_pd *pd,
 				goto err_db;
 
 			if (mlx4_buf_alloc(dev->dev, qp->buf_size,
-					   PAGE_SIZE * 2, &qp->buf)) {
+					   PAGE_SIZE * 2, &qp->buf,
+					   GFP_KERNEL)) {
 				err = -ENOMEM;
 				goto err_db;
 			}
diff --git a/drivers/infiniband/hw/mlx4/srq.c b/drivers/infiniband/hw/mlx4/srq.c
index ebee56c..4c7c9c5 100644
--- a/drivers/infiniband/hw/mlx4/srq.c
+++ b/drivers/infiniband/hw/mlx4/srq.c
@@ -141,7 +141,7 @@ struct ib_srq *mlx4_ib_create_srq(struct ib_pd *pd,
 		*srq->db.db = 0;
 
 		if (mlx4_buf_alloc(dev->dev, buf_size, PAGE_SIZE * 2,
-				   &srq->buf)) {
+				   &srq->buf, GFP_KERNEL)) {
 			err = -ENOMEM;
 			goto err_db;
 		}
diff --git a/drivers/net/ethernet/mellanox/mlx4/alloc.c b/drivers/net/ethernet/mellanox/mlx4/alloc.c
index 4bdf250..94bd27e 100644
--- a/drivers/net/ethernet/mellanox/mlx4/alloc.c
+++ b/drivers/net/ethernet/mellanox/mlx4/alloc.c
@@ -576,7 +576,7 @@ u32 mlx4_zone_free_entries_unique(struct mlx4_zone_allocator *zones, u32 obj, u3
 }
 
 static int mlx4_buf_direct_alloc(struct mlx4_dev *dev, int size,
-				 struct mlx4_buf *buf)
+				 struct mlx4_buf *buf, gfp_t gfp)
 {
 	dma_addr_t t;
 
@@ -585,7 +585,7 @@ static int mlx4_buf_direct_alloc(struct mlx4_dev *dev, int size,
 	buf->page_shift   = get_order(size) + PAGE_SHIFT;
 	buf->direct.buf   =
 		dma_zalloc_coherent(&dev->persist->pdev->dev,
-				    size, &t, GFP_KERNEL);
+				    size, &t, gfp);
 	if (!buf->direct.buf)
 		return -ENOMEM;
 
@@ -605,10 +605,10 @@ static int mlx4_buf_direct_alloc(struct mlx4_dev *dev, int size,
  *  multiple pages, so we don't require too much contiguous memory.
  */
 int mlx4_buf_alloc(struct mlx4_dev *dev, int size, int max_direct,
-		   struct mlx4_buf *buf)
+		   struct mlx4_buf *buf, gfp_t gfp)
 {
 	if (size <= max_direct) {
-		return mlx4_buf_direct_alloc(dev, size, buf);
+		return mlx4_buf_direct_alloc(dev, size, buf, gfp);
 	} else {
 		dma_addr_t t;
 		int i;
@@ -625,7 +625,7 @@ int mlx4_buf_alloc(struct mlx4_dev *dev, int size, int max_direct,
 		for (i = 0; i < buf->nbufs; ++i) {
 			buf->page_list[i].buf =
 				dma_zalloc_coherent(&dev->persist->pdev->dev,
-						    PAGE_SIZE, &t, GFP_KERNEL);
+						    PAGE_SIZE, &t, gfp);
 			if (!buf->page_list[i].buf)
 				goto err_free;
 
@@ -783,7 +783,7 @@ int mlx4_alloc_hwq_res(struct mlx4_dev *dev, struct mlx4_hwq_resources *wqres,
 
 	*wqres->db.db = 0;
 
-	err = mlx4_buf_direct_alloc(dev, size, &wqres->buf);
+	err = mlx4_buf_direct_alloc(dev, size, &wqres->buf, GFP_KERNEL);
 	if (err)
 		goto err_db;
 
diff --git a/include/linux/mlx4/device.h b/include/linux/mlx4/device.h
index 122e7e9..a146b95 100644
--- a/include/linux/mlx4/device.h
+++ b/include/linux/mlx4/device.h
@@ -1079,7 +1079,7 @@ static inline int mlx4_is_eth(struct mlx4_dev *dev, int port)
 }
 
 int mlx4_buf_alloc(struct mlx4_dev *dev, int size, int max_direct,
-		   struct mlx4_buf *buf);
+		   struct mlx4_buf *buf, gfp_t gfp);
 void mlx4_buf_free(struct mlx4_dev *dev, int size, struct mlx4_buf *buf);
 static inline void *mlx4_buf_offset(struct mlx4_buf *buf, int offset)
 {
-- 
2.1.4

