Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C623ECE560
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FEFF2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WEM3+K0B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FEFF2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbeIRSgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 14:36:24 -0400
Received: from mail-eopbgr20093.outbound.protection.outlook.com ([40.107.2.93]:10848
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726037AbeIRSgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 14:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tS9YZxmmDSveQk3vKSrKlIM7NCMw+E8TFupVrn4z34=;
 b=WEM3+K0Bbwn7x/XQv5S6fve0teE54/WbNhfIfVy9LNqfco+plmXaNrVrAZ9Xq9aig8t1fDkCs2lWUfuXtSQegKgieaTk/ZLGu13Yv23TMDFu0OGxr1IGjrk5GlU4TgeRzJcxUvAnMWzblbXGZuW03a97AzKzMdVrrrIqLV1ql2w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jan.dakinevich@virtuozzo.com; 
Received: from work.sw.ru (185.231.240.5) by
 VI1PR08MB2782.eurprd08.prod.outlook.com (2603:10a6:802:19::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Tue, 18 Sep 2018 13:03:49 +0000
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
Subject: [PATCH 0/4] IB: decrease large contigous allocation
Date:   Tue, 18 Sep 2018 16:03:42 +0300
Message-Id: <1537275826-27247-1-git-send-email-jan.dakinevich@virtuozzo.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1P18901CA0005.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::15) To VI1PR08MB2782.eurprd08.prod.outlook.com
 (2603:10a6:802:19::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92febfdb-639f-4026-adda-08d61d672d85
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2782;3:ZJHsti4S1Q/n5vtw6/8/D8Wn5RBbETv4NM5c9VohfZ4sjx3H8CQtSwYwRZRMciyiQk0mV14/leebVWEDdSFgFd/XCzar42xup7k/Vula4ARHFm26VsaynBPwnyzWdfFxQieEgmIax7H0E9UQO8alJJY6vz3tkV4AWCUfiKuVsjyZHCIXiXeI9kygujO5CFNl6Exha3zHaKwzOxcydiZB0sTa5dp6tHNK7nnpc+4mHfqIWacMXGotn/gkXnVTo7fE;25:RmRkMr5zaovKNn/I9mygoL1+JF+cJcnPfyhBaQWOac0D52ozOrfsgj3WAFQuT476u/i1swEUx1E90uVqdKpM103WwxA/6cuXQkFfcWcyKvbCWB8ByrjRc/lS2mjYbbPUpRCvJ3P9At+wW4T2h4pescXwdZ0ZG4Jeqtz5q2t3mrNqEOrTW+oC7FQxy/M+N/Uh/X77DnAJueoTFS3WbhhkTBybwSWcBLiaUaiG0SHldK61xMymgVqhz1BnpXyPBD3h2yyeP9WkG89AJPpKygdMpu6j4i6pyru9sjelrKbW4mPtuYVQsWCJ6jUfFUopyag6Mvi5mx6+jJrDbvo65sRkBg==;31:RjUVQ0LLkDWQntnm5J3HvmatKZmGvKyEtOqnpNTc1LCXqQ/xqONqkZAO5Nd3HTpNVLXU1dmErM475nGKeFy6UtnKbhddKPqxOHbq2S0cRHXgD24hpINETMYhW0r1bW/chqtG7v0D+bc0BWfnViwQpQfHbp6CHR7jNSjZjRt7dPt2XbWuZE1Xls2ZTda/2AI+e8OYXN+1McyqC7HmLcZOFJUad20ph/B2sFIjOyfN4kg=
X-MS-TrafficTypeDiagnostic: VI1PR08MB2782:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2782;20:i/NHGLdgxU2AahEIgMTh4/3Xfh9UAbg302v70A0zwxxC+HCMy9f5p1tryzIi2mohnB4doBCpO+CsH5tigzE1GPyV9075k5a8fg01W969X4UYRvc/MxsA4rFqXGmkSd/yYgDXRzZLMce29qjo7y/5cVJKUBRLaWpI/rmx5wHOF6kERQHQo+dUFBrqqHuSY70lRDLFcbOYCPnVWQUOFoSHXLHlARpTLQVObfFJsQBzHhWeEOJBVSLety/TENDAB6hOMXF9lbTKuraTmVhaXpQ7lthAxOkhaguNplOBoPnXvWHNxCpPvbUWlfkvTeSrczoEvLJj1kjF9AQlefc2TaF+Sz4K6aNM3zHX5T9ER14Whfzmpq/kCieCfU3qnu7xKFfj5Gc7zaDNf1najEFaRfPVLYANwsmxvnxHXbWw0Zvr1wu2zzn9bfSWdI9wJag7O+/s2ILmgBkFXerf6J+VCmbl+CcsA/SAyrV5ttgfTVQEy/aFn/DUcWMwodsYg6ddUpEN;4:tVOJAQzP5nr75Tk5jT8YHWadElN2dmJyRZx2fYjPeGcusHwZ07vw1YllIMuiV4Flc57KsKI/OLM2/5CES6jSNEtl8C7Ki2NN6UXd5eT7DICOYllJV1mkasdhbbg+ZwYgwaRJzSmZrBG+Wf1L8YsG5bV1qB6MEqH9ZawJBKZ20a75v8aBxD5y1jeOxN6SrXaUYPFeeSgOKwaB0bJ21/KIyheBQC2t1yzi1XGyjCQNWHxfUXedCYfyN/NfYOcNZeymGRVB+ZQ1bn0Hm7IpC0dHcQ==
X-Microsoft-Antispam-PRVS: <VI1PR08MB2782E0E243D6AAE9D8DBEA138A1D0@VI1PR08MB2782.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:VI1PR08MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB2782;
X-Forefront-PRVS: 0799B1B2D7
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(136003)(39850400004)(376002)(189003)(199004)(3846002)(486006)(16526019)(44832011)(7736002)(26005)(68736007)(39060400002)(6116002)(54906003)(186003)(53416004)(81166006)(305945005)(16586007)(7416002)(107886003)(66066001)(2616005)(106356001)(956004)(8676002)(50466002)(8936002)(478600001)(105586002)(476003)(110136005)(81156014)(5660300001)(6486002)(6512007)(14444005)(69596002)(97736004)(4326008)(25786009)(47776003)(52116002)(316002)(2906002)(50226002)(386003)(6506007)(48376002)(36756003)(6666003)(86362001)(51416003)(53936002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB2782;H:work.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB2782;23:ixqet6Xy33mexOpayV/lIAlF0nBIZE6ftjMRRVbP7?=
 =?us-ascii?Q?uXtzGM0O0LCY1Z/f/4umy4s17Ea5h5eRQ/prA+oZr8+R5rmZwhTR2CjR49ua?=
 =?us-ascii?Q?2ZZvtY3hKLukX/tIqu/39Mm5/AgBRZY7W/lRxpacDSpg8NR2fRzsuGMtTSqp?=
 =?us-ascii?Q?JUFIPMAPV0NH622wDX79FqyMEB+SynjE0MzOh6waZPFOIUuUDqsptZKauJ6J?=
 =?us-ascii?Q?/N/Mf+yXhQwnNzfurcTpHMonI3Tm4vty+jLpt8kAhehzl3qBcOTSDpO8dgGv?=
 =?us-ascii?Q?IW9MbCoU9nBBPOxer/1lA/ajOtj7RqakocyJfEgHn+GqYio4oI266sxYn/Cu?=
 =?us-ascii?Q?LUiuTEh1bEmEjdSWz8xbSnnjDQqtKmJbnEsQkFdtLaL28lH6c4NdMQg4ushM?=
 =?us-ascii?Q?sA8GDy/vIQ57ftmQE2kwXG2iD9WIRvm/6DUuOqccYD8zY/YYqPI9ioJZgqt8?=
 =?us-ascii?Q?1pquTkkgZoT+hp33x8QVaMw8YMd35EWiwCCbT0NluXwRj8zYjLIkPW0xZPQs?=
 =?us-ascii?Q?CrI8wwccIarCmSO0CFquiaXgN8pwSOhOEbR9TTfPGWlIgm9E/SNtfn9+jV1/?=
 =?us-ascii?Q?jYfxvHqP4bB2kc/n+RXmiRg3CrDAGL751vgiqXX/bwBPQ6GLZRRGz7rL1mAA?=
 =?us-ascii?Q?+ak5Urf19GViM2m8hkmX9IOgGthDeggO1UEgTOZM06fl3MM+jCIOQpOu2JH6?=
 =?us-ascii?Q?O0v9Kaqkdo3yG4Z/xFSNI6a1NzcKWZPAphjqqC+Wx95X5Q6lG2Sn6pdNO66u?=
 =?us-ascii?Q?Pa8IEYgDEaV1hetLXjfbul8f4FzeUqwmJrE2bIdk9twmvdeCoMS1wHrHXhk2?=
 =?us-ascii?Q?Ti+yGOc9L+UMKjxu/gKawoZbgqPs224sa+h6+hzqhJ5SbCa0nnPvsds1hBew?=
 =?us-ascii?Q?Xr7DYkDyoEIlZHqTE/F0+KTi71YLHXQnelp+AHJV/IUxp0wkMTAt5QvxBRFz?=
 =?us-ascii?Q?i/qzrnKLQ4/mGQ/xd4upgmJ+XEoQsEgwN0UBtKe5DUeR5weMJ6IS3ahxgefn?=
 =?us-ascii?Q?RbzDiZnZNHns54FHTj0O+3WBhSB+Q3C2gG5g2TxzT75e2Q8eaa4jtEEVXPxq?=
 =?us-ascii?Q?ivt7f0V6B2G7gjvZk6UPxtiMhVcqiZT8UYOzgDix3ETFQ3WHFCWPA7ggd7Gy?=
 =?us-ascii?Q?MA7mWN40iGAYjPWsF1CUxrc+eSLCuQPy8qSTfI+yGxu6O6TJvr7n0DwrY/jv?=
 =?us-ascii?Q?OGgTZLWnx8zEIWih59cYXrzQe59BnnUegZYvbSY4XHAGXev+Q7U3uiO+PGjO?=
 =?us-ascii?Q?ojZ78W1sqB2m1GaVNl/qrM7f9FFqc+MtHsmaRcxvWJaJoD96dcD5HR1gIt4v?=
 =?us-ascii?Q?lugEQLgTYV1dVkLmjpBqPg=3D?=
X-Microsoft-Antispam-Message-Info: MVrU56+M6EXaYvLx2OLKQfuxtReNOre0tk2rbXWn4iFRDoK7amUnG/z1WbAEjTFI2mng/+na92qmsoDtfoDrpHDbunmTqgWKS8qaAWFe2odaQtFxcsc+W9Lz8DiWRatsdy1iQa2ZoXOXIK5LK2LTfLUN20lc1ag0FIQwiHwqoEWXNW1j+AvBPcgDWPDWB2NQlzDSe4G7KMgmdXmF6b0cT2VxK4tiDJpQKoLRysltpPLS6VD58lOH5vUmrSMrsGT64AOUgcer24LV1jZojhugpujXuVyxzoDPtGrXNUPcPZrH5BTEWKLicyJ6VUlFWt39btlRH+qUnFXr5rXwuRmD370I6JAvKERO0L8cG0KaSIE=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2782;6:o03Uzx3ECovG19AkOX9FqOb34/f+GCylG1BgTNCVq3LiBmCdzA7zzDZAU9GeUPQCJdASCsB9yMnnxM3WPIvoruoVYFXPToDPH/Sv7HopKnAiny0zMk5lgmSSx5AAcByHBLXj3SiXMo/Q7oDdApDSQyA7GtrC0/EtTRZZBLKvvQVFXSrJWdMFSMWHTeNe+9iOrs36rc0KRwC2PZcgNVYjiaISnvM8K2k+3rMSbXABs3guVH4B2j/8cZKnNa1CKZV8tu6eYORaAk4v4mKCWIlLDbj68WqL5yplnc3MY3mRjmFEzWS7zKQv30IKlf4OYtffi25b2h5BD1Gc8LwNbQjkLFrkpLIDH9nHjzpKU3f04PKgqN8VZfkcuE5uLWjA55Xhk1QnMpzPy2QY55mlhLVxN18KydIe6fIJK52hT+V7v+bNNMFv6PKLO/vBUdylNs/7ehJb6Q+ZAQEUmzSb2tnzbQ==;5:xE3YFzGueRLsw0PDQMa8QuKNtApGdW4/3M+6oxO+E7al8gHVwZAepsO5fhPRnXnpgckjZI1rB46A2mvCU8EygRXhq8dhmsTOtwmHlDnjA+oavTzBQemkm2PN5bWhIMAYaNJ2AMubDmKmQ6m8SE5c11LdiRzciCK826ecZe2jXB8=;7:VkB+3F18hizmiYDsPvG1ZhZiF5JweASYNsbqIc0xOQdkSlQ4BjX8YF9YiqSbGRNodjFueVXpg236pCcnYNNhxSUReMUjUwAwUHqb3ahUGP7TxFnsd2no14IRNfb/KZZ48HC1u1j3elI75NVxDwYtINXW7JG4ZUAz4qYLZtlq5re8IiREmAM2Pjm0+tCV2HoLFWiaLGJRVc2LnnN6IYoEfjWk+FSpiD9V9RcPI+QTVBkWEqHNGp2l299s5Ks1z0DO
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2782;20:cT2ntYOFd5LK+l+3ZkCdxExOmW3z8cJzLANdn3TkAW+FevuMjAgd/rGRghe/T2zadqsKv5RbXsQIykx9D7YpGeyAGuZi7klD3QliffPDw9ywTX6chiySHXFZhT6XsszgpDqIipwgqaeVE927EfknDsixzA21tF5x/C0M2u1wuQQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2018 13:03:49.2076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92febfdb-639f-4026-adda-08d61d672d85
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2782
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The size of mlx4_ib_device became too large to be allocated as whole contigous 
block of memory. Currently it takes about 55K. On architecture with 4K page it 
means 3rd order.

This patch series makes an attempt to split mlx4_ib_device into several parts 
and allocate them with less expensive kvzalloc

Jan Dakinevich (4):
  IB/core: introduce ->release() callback
  IB/mlx4: move iboe field aside from mlx4_ib_dev
  IB/mlx4: move pkeys field aside from mlx4_ib_dev
  IB/mlx4: move sriov field aside from mlx4_ib_dev

 drivers/infiniband/core/device.c        |   2 +
 drivers/infiniband/hw/mlx4/alias_GUID.c | 192 ++++++++++++++++----------------
 drivers/infiniband/hw/mlx4/cm.c         |  32 +++---
 drivers/infiniband/hw/mlx4/mad.c        |  98 ++++++++--------
 drivers/infiniband/hw/mlx4/main.c       |  93 ++++++++++------
 drivers/infiniband/hw/mlx4/mcg.c        |   4 +-
 drivers/infiniband/hw/mlx4/mlx4_ib.h    |   8 +-
 drivers/infiniband/hw/mlx4/qp.c         |   8 +-
 drivers/infiniband/hw/mlx4/sysfs.c      |  40 +++----
 include/rdma/ib_verbs.h                 |   2 +
 10 files changed, 256 insertions(+), 223 deletions(-)

-- 
2.1.4

