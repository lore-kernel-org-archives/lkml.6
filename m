Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B261DECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6155E20C07
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MantKi4M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6155E20C07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbeGPQa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:30:58 -0400
Received: from mail-db5eur01on0135.outbound.protection.outlook.com ([104.47.2.135]:25850
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728061AbeGPQa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OxGv054nUqSCtm/hoyDT93gdVchpC17Ks1ZPTDn+BI=;
 b=MantKi4M8L5/gvNvIvqp9Hfkcb+TSlGzmcgddJWgmAxo/spA7jL1LMkw0ybOO39XHFyxzaJZJxxVjYAKFQnoaa4VF8mm5kU58BmX9cSkOZioxtUVPDIIupbUCY66t+3R2TbALi+UOImeiAGipjf97Mq16zskrauAlczVqfhmFrI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from i7.sw.ru (185.231.240.5) by
 AM6PR08MB3255.eurprd08.prod.outlook.com (2603:10a6:209:47::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Mon, 16 Jul 2018 16:02:31 +0000
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH 2/2] fs/fuse, splice_write: reduce allocation size.
Date:   Mon, 16 Jul 2018 19:03:44 +0300
Message-Id: <20180716160344.7015-2-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180716160344.7015-1-aryabinin@virtuozzo.com>
References: <20180716160344.7015-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR0501CA0032.eurprd05.prod.outlook.com
 (2603:10a6:800:60::18) To AM6PR08MB3255.eurprd08.prod.outlook.com
 (2603:10a6:209:47::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af4ec184-480c-48de-8337-08d5eb3589fe
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3255;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3255;3:UieDKDUtpDGn5s69/mhPPR/ynDn8EitiCQfi9uszpRViaewZpS1Pwtc9dHQ8AQVxRfoboar+AvU6OWILGIREcC58CmIV3Fj1FwN3uTbs9kDUIKm5wYb16AESVd/JweNPrlKCIBfweSIk6b4aFozAFC7TIEnyrKDpL5+Or1s3irhxsEk2SrIB0TC2djbTwAcIy67jpVlbWq58ikosI5+y9D/SEf0UYQBqsYlHSySgLyx8HzbmowhLCNu5lpehIQ9H;25:8twfDhQOi4bENngVNivaiFU5E6mcefIEfjcKWnAU+NpITOciTY4XaJX2UK1vyxbJazleJ8z3B0/2PArp6QY0F9UJ5RwVpVjGbXmaQM1tkqdtFjamnm0n+zpEVKgxICoJJBMYJG4mK69jHZ4duqxF2Ms+3ArHtgDSHQ5eoEtLkvOBPwpYD84gA+E9CtMkJ2/WkYK/xARcUmJ0YjO0hIzw1X0hgmjnTb7pXade7sPD3z6oJ4U0dySON/7JKVuaUh7TM4lFgOGQ0Qlw/n/+W02DWSoUpebliPQ5PanfOti2ceTHHuT29Ft0sFViPqCSNge23aO//cBCKrTgRrRyuRcQvg==;31:maVjiLC+8FsL35aVd6FGuKeQUvsk4RhKJnosPKYZkF/A1Kc3YbM+K2jraNDmpI7TXtsSn417ssv4cy/eUG+G3eVkI80WQd/yCSk4K0TLs7cmqvV565xSXiCN1ADwz3Vluva7Z8SLUM3lZ8D/HAGbQUZntF6lfa69UTzVbjqK6yA53PWmTPyv/ZVbxI/XhJtYCGRksoy6WYMxBB4gyWybBoXHPJErFqkL/XwdrHzznz4=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3255:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3255;20:pkOCyRy2SAK9U4PaY1EliC77NrF/kjjXvRM7HnrzX05yGq1uuI1o8FTK/GoPZGeH3nMvN8o7tXT0SiuRP1HgJS9AsLWtJmp9hFWu2vzRWLYz0m/jAapisTOrWxRjZK0Y5rLd/5WzE/5I9J8gfDN9uhAmg9Rd5imzEvyMqenNkPQYUrxT8wrAeLwTDuBDK4FjknHmEIA8jwNRV0ISLE/IO0T1hwP4oeuNG4yB2KIMC8pbk616Lk02aP3LWLwjKP62XdH1R3LzV7EE8W/jzCQ+S5RN3TA1D0u/vSKA8BgY7pNKnCPU8slFWIuJIlxGzEgz8VkaVLfT4WZJHDZaS/Xe7v7V+cQjvDJqB/9UUkmutd+xn72et/JASuRdE0uBUZctPtfY1b4usy0e9CjfZNp0bFT8Jfg9yB2tXQfBqlM42Chpwj/56n7JM4/tk/WVSIxJLd3+g9dClK/pZFNCClEiNkk11fK0Th6K24HvdyFNVumt2wIBchrK/ME0REyHCwMn;4:m4Q4DTvAH/fKfIIBZ1lga/xkqAeHqkmRNki96Y2nhdehFvqzrJWQeHN3yOLl16HEKDRz4m/RolwA5RmInhDN+I2x17HnKcNN+Q/wzXUh0jjn0krYcO+xIcqhvHfK1dbLx/FkiNsld3z4Gdg9ECy6EfwVPn7E1dfU/VM30CLg16anS/XGdClh4POOfurYN67XgQq0i0Mc8WoPYpEupQTRkXWlkL2qKvnJweC/nJKrFa33MNNpUw5edebOEMbpgOilP3yHBOE2d/RZgyv6TTHKM2b0vNRJhbogvjo+hq6NJoOoXe/8+BWjmcsmKDgE+oH0
X-Microsoft-Antispam-PRVS: <AM6PR08MB32558739EEB089DF15EB0668B05D0@AM6PR08MB3255.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM6PR08MB3255;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3255;
X-Forefront-PRVS: 073515755F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39840400004)(396003)(136003)(366004)(376002)(346002)(199004)(189003)(68736007)(305945005)(53416004)(6666003)(53936002)(36756003)(6512007)(1076002)(47776003)(48376002)(66066001)(4326008)(5660300001)(25786009)(6916009)(107886003)(50466002)(105586002)(106356001)(97736004)(3846002)(16586007)(6116002)(81166006)(478600001)(8936002)(81156014)(8676002)(11346002)(6486002)(2906002)(26005)(386003)(316002)(6506007)(486006)(16526019)(476003)(76176011)(446003)(186003)(50226002)(14444005)(52116002)(2616005)(86362001)(51416003)(7736002)(956004);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3255;H:i7.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR08MB3255;23:244cvAHpvbe8NMHQb2JY+rfdfzzIMfPH4lMxLS/BV?=
 =?us-ascii?Q?Sb3wxWDfcW7RTt9Tr8wN7lKN/br/DkHcYwmWn1fFAFPaEQyVU6wmq/w1yuai?=
 =?us-ascii?Q?9+QAHlm8XSjdzMtpmCyIWKXLOrxQTGKBuEwsyAFsg80IcfS2AA+xxP7yHKR8?=
 =?us-ascii?Q?iTcIRSAJ3SmHxyrbArYruaY7MibtcOfIMIUyJ7B4/CHg/07a1zQj8Pmce3BC?=
 =?us-ascii?Q?8Z7UFj97mLjQP/JcWUsTXBVlbpeF+zWQk8yVF7P1kTm1k2j9yXXcsbOKor1p?=
 =?us-ascii?Q?VwUxDQHZ+w7RiRX0IFzcu02bhrJUGttDk/LNdT4UfdrmamSTMUW7n7DA46OS?=
 =?us-ascii?Q?7To8GkshJE0RID0R/97uDTDo4CI7Kk0Z3PD+WlsLvhTdsN6T6Yn44j78K4Jg?=
 =?us-ascii?Q?hyAalHg9B6t0+OwGPTm1Eae53+BuSb+TXwBpxhhOFx0ESMvOFj9WayUrD8QN?=
 =?us-ascii?Q?MPsQHzh4cu8YemfE6l9JXQX7gi7AINNHaG2x/HpPALejovyd0CrPEVORyurJ?=
 =?us-ascii?Q?SfuDxMzJ0mNoYrqrWRXCMLyelPAPauqtQtYWd8Yja9wvyRfghNrnqBTO9UL3?=
 =?us-ascii?Q?OnAY4SOLB2CmgHJDVEfO2uwr+5Sq6KOawer379F+7g57ex1lnTm9dZa4JQj3?=
 =?us-ascii?Q?ooA3BtFxLoyKBWYPvfWr00jQ+zODAnZBwC5STJ0KQzE0xHyN4VW6Oi8ax/bg?=
 =?us-ascii?Q?dAoQJRjoyorATHR3Rjp8hv6C45ztsFgPRKsos7Sx0P/k+2EeHmQZCwQfYYNO?=
 =?us-ascii?Q?oxMUVQ48YSSftRuHxgeQXN5LQwGUUVmNeFsDPn98tG8wknN5BeTOMs74iQdo?=
 =?us-ascii?Q?0JmBSe2b4WIVufA/Shf5uWzNPb7kcOolrFNo1P6pmYJQUaiAEORSy68KRQib?=
 =?us-ascii?Q?jQSI8bqlAXCUum7PYB0N1c9dzN4WxSJzQ1f049fBHd0CfS1DdyaEuonYMTd8?=
 =?us-ascii?Q?/j+gipeANtQEUkcj2mQB6d6Zhj07dNGBSOu5jkEJKgTWg9/bc1FKBIWpWwyL?=
 =?us-ascii?Q?yTRUnNCWEwOzA4UbDzKxhbR98hg6y8oopDfR2vx+bhPIrqpn/wXyNnp7wlvt?=
 =?us-ascii?Q?QF1EsDn1VdahpdzgA0LZ71akscqMW809VMl3O7AWHjakqK0/Igg/7vouVhCu?=
 =?us-ascii?Q?+LnPHmOaJhuIV0T3veBT421GVZ4u6T6RMOieuVInfAfW5c/fZnuEZ9Pl0Esu?=
 =?us-ascii?Q?4EVrNgjDHbwk8onXNRhSvRIzdOjWIR+0Nh/KAFy/UCB3TNyuUhczbalJsR5v?=
 =?us-ascii?Q?WXutyEbcHQcVt6MT5Y=3D?=
X-Microsoft-Antispam-Message-Info: vE8lCrmKC4iaHTFgXuF9BsxrcI04z0cG9QdiaKkXHbMPjzdphXSCAdqd/DeMRJbG0Dp9qPzMlxZAXL9ii1m7qKa8xltKBxYTpEnQfD07wsMJnUNIo+saVXFCesVRiF5NP70YoOA0XK3j0ctJpg/o/PBG+ZsvMDyJ8foHvRr6KaaSLkAGARwef+Day3gZcDd5FKgDACgq5cLoZYOYa6BerkLQL/LDo1NWpTQXfXtTOwTd3a0jCKvVaqGa0kf7zgEvaoQN9aYZ932zldWjaVWm3mUBZ0mqOmuqy5l4k1xI/R/0WW3Buce2CkA9/zwIxr+I3qe9l5avGpgjzlW5CUjDAnpQ15ybgJiNwMITZJ2gMZc=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3255;6:YKQ55bLCAE1p6lcMOME/+m9oUCnYKr9DsHmg5k9g8bPdW0pr/7CIlIWoDvq74csBhR8+kfrNzivqEHQEJ2TobeHd/tOMLToiH6H3LxT8bOL++ikd4C+ZywN0ev72qL6vYk1wp5KDf0srO/Mht1ZaZZy0BLMDE8c7GU4UI5JKX0x9P2DFDQtlYu+syapMl1BvuTR8gXlNAhXUEeLcOF75uZXBD60PXvtfQ3m8rmt4SwN3YzfG2N0re0gNypwKBdaQgY3ooYWUFjw2ciAwRcGy4sePILyYL2ULCa4uNSSiJTAUyvzkduC2dCHU4Nrtcy730AKUgG0bm6IKMBd7xYu7ic2pnmY2yNA37f2y382WZY+ERj8POp9x7jdUzVWosdONjGfdgcqO+uKpatFbbfuOVd7aCsHL/rNAaKqnZSIw0EdL/+Gx4nKVBByNMRbFU6ncKLZJPCNSJB6dUpU0qvJd7Q==;5:+5/wZYmlNRPS//KXlsaFWCUTeVnohwpS51lFEZyrZUycQ/WHCz+6Am2L5so02pX4ETRMAvlCS2i9hlLc0nvJypAYcxIDy1diu/1D8l69t2FV7QSpQAtTScmJVsravcSlyqT3apmJriiNp0C0OInetWGSY5cQsNesT2ftGUKL/As=;24:JRsshN5a/hCR6y/N80CbEQSOGj/qkRuDdeBEjMEGYGAeAnOqMTfU9k5WsvuiQlWRN32XHibypNvcaAL0sh+lNAauZrtAg71Fj0JxWGJo2iw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3255;7:BQUi7m25IizWu0DBHbMklYzHS1cyqJW3eldQgAwmwTsRC8NT5JHPzdNqMbCJ+1AI2rGVb4eklWUM4zV9jwwa/i1Kxa+o3/NnEVwBpK4U+T/dIrpjV/Jix6M+aAO1mZTX8jL+KiHoCY0P9teciZy9I0HtLBxtsAkLgWA908u84yNAZxdOs8NHwnDJoa6pj1okHppBH68+jJLg/Cd5Cec9h/Q9IDVB41gwL2DrcLc+WWTPeThB4C4H3bY5Pv8ayPok;20:OUjGrOCsV4ZgcikpkeHe7qycx63lu0i/BJDTKd4mMlXQq9jwUOT347FNeT/+kgSS4/A3RILgHCWjlzd5R5FqyPjSRMWi0CJ7sxz38NB3r5g3Uy/eXD3gKSWoyQKV9rlEZZlzS41DYOEXjFHVHwilD5qUwXovfusT52MmZNa6qSM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2018 16:02:31.5609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af4ec184-480c-48de-8337-08d5eb3589fe
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3255
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'bufs' array contains 'pipe->buffers' elements, but the
fuse_dev_splice_write() uses only 'pipe->nrbufs' elements.

So reduce the allocation size to 'pipe->nrbufs' elements.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 fs/fuse/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 74900571546d..39789f070cde 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1944,7 +1944,7 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 	if (!fud)
 		return -EPERM;
 
-	bufs = kvmalloc_array(pipe->buffers, sizeof(struct pipe_buffer),
+	bufs = kvmalloc_array(pipe->nrbufs, sizeof(struct pipe_buffer),
 			      GFP_KERNEL);
 	if (!bufs)
 		return -ENOMEM;
-- 
2.16.4

