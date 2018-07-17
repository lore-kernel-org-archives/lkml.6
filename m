Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A6AECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300202083B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iQ0euHlO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 300202083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbeGQQcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:32:25 -0400
Received: from mail-eopbgr30101.outbound.protection.outlook.com ([40.107.3.101]:10642
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729706AbeGQQcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+bVRt8pl3YuCmJfSOu3wr7wx+6/Zh7c4LoxIXs/AS0=;
 b=iQ0euHlOgIvZiRrGkCsCqIQ70vhLN6YL0zKKL+SU8gtEi1KGZRIrcnFGdDga7pheed3Cku563Zo+THM7ZPLsvOqV23C3ClkDNektXH2g9yBCC4mk45mR51f1+g1BZGyHuxjY/walm8QCUFexI1stsfatk6LsYULYhta97SYxN+M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from i7.sw.ru (185.231.240.5) by
 DB7PR08MB3258.eurprd08.prod.outlook.com (2603:10a6:5:1f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Tue, 17 Jul 2018 15:59:02 +0000
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 1/3] fs/fuse, splice_write: Don't access pipe->buffers without pipe_lock()
Date:   Tue, 17 Jul 2018 19:00:33 +0300
Message-Id: <20180717160035.9422-1-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <CAJfpegvAAQTAjxLcQLefvFOQDJ6ug_G8Jggt=UZci+YnNP741A@mail.gmail.com>
References: <CAJfpegvAAQTAjxLcQLefvFOQDJ6ug_G8Jggt=UZci+YnNP741A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1P193CA0005.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:bd::15) To DB7PR08MB3258.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9022e56-7bb5-4752-b2c2-08d5ebfe3801
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3258;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;3:ZWrAwhMLM3CbZac6j75x+HE/IyGQr0ktW48FUFuRs/M4/EBAV15+V5TctK/4KM3OzYM+/WJAE+fBOry3/vz5pUuASa5cmEq3mAjXVGC+sGSM3LIG5B1YNzd9as/ztphO0JLgmTz9O1JgxVgJjkVDw+pAHKTj0UqpVIEt7tp9UKRUa7JQrsJ08qJmeHEzJ8V5U9JTj4XQOFmiL2hTGux0WNPF6kSZNRGATz9KcwYwa6CCF4dY/Inr32w6q3eBI7ib;25:e7ONYOe+u5oPFc0j3lV1yt3Lm0XQkJoi8Da54+6UoInG4xOjgwyHwE9A2cIBagmjrGdWwwuBq4caJGbnPpUKbfdgKWI3FaJi13gRq+jV3lbDc+yMYm7VGt3uObtNYThPqb5JrVkwA4G7PLUfUyaKV/AwlMj7FIRSPcwTewyeEDeDW/KWmjMWngso+Sig+SyhBnd6kl+BX3CLdkdC8MOgOILM1RPUQ1z84XK9Fwr68uAa7GbXIV2j08L06eDQWsiqAKvXWcZcEg16j/OiQs5GQQreedQbms76cnPXgNHfTfVrqjiuPbF+g834eq9cbswFfJ20syvPk3wo0kU2NmygSw==;31:BjqhDBRGd1tedyjnIE+0k6V7whWXQlzs7cztNX535ttRH8q1C14DC4YJMvismOohRJW/6gkEVx3F62k7fwuUZEeEcAoVMhGZo09nbfoGe+drxFJujZiRD26YBjrjPkAy43c4JnyyeQtaVql0YggY8ztBYhMjcmDIu34IYlpNvyeYGBEMXtEHc4JuijBDWGQqRvbtGDrLIkr1YLjNb0Ssaki59cpu6znYfOYeiLWcuRc=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3258:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;20:XZ15fy/1tdAMos5HVfsuw+3Mcr9t7g7+aARhjQvjonJIBGXVLk9jcewCYNPjN+qIWcspXCuw0+xlWwI21XCl7lW5cSO6IQJGeGK4ApabsjKEIgqULJUcVgA7nOzp8uBoFdIWKViyQosxc8Buaf64Fg+kmR7khnBg660Q1y+RuQf5raarvqef/Ip9J6kULVr0YC6FFW11D6f5dwbSPAjZvXjaqsNWcBq2xYnzwukZU+Khr7U8UbqBNYBHqN0vb4VciHyvPbg3Lbw6/L+nMmJMcRcDgHJ6SLU1o4RcEvB7T0i9mNP4dcxuW3mvLoEm5b1lkCDaJ/SFKeR2LSy1cwMdYx9ubf/r9z+pPnMyj2nbw+aOFLDUB4Omgw3b50UD5l2zt5dB04lqyDpEKOnaKks6CKvGXju6fFbzVLqL910W6VjV4wZTRpBfcEOi1I9VprUbewr2LtvoGrq3+gFDBvP6LLfPuapCUkmWM2XPv6LegHnBbhyIo0hU6SzxdeZZUK7a;4:I8hgYwS3INzd+lAHZDZOrlRzssPOTAyQ3fmVfOqdKCGB4VrJwQA/07bKBcGgRLINI9lFHNjAtf5q3bE+WINgtkzoBjTU7OWjwO/7RRUJfexDcFKeqUBYX+nxUQbIMTN6qLX5XEj4wIfXmCWr0uMGkwCsP+XTjRZEzx/c5t9AvAzj/e5dCSFwFBx1BeSva1ocVGtjbW0S+MfIdln69FktYTHHbsOcW7J8c/JzoSP9wrxkndlKkOdpVleQSF07S6zeivMAsr53M7Yek5oyPvqm64A5A2BayB+UiSJdyPXV/jaq5xv0p1F6sIwdRtApx+iZXjP/DzC1vlpUQ8WFepOwnMU3EAQzeVGN9d2dEk2V9kg=
X-Microsoft-Antispam-PRVS: <DB7PR08MB32588F0C32524AF4CFE84DA1B05C0@DB7PR08MB3258.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB7PR08MB3258;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3258;
X-Forefront-PRVS: 073631BD3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39850400004)(136003)(346002)(366004)(199004)(189003)(48376002)(68736007)(6512007)(2616005)(5660300001)(36756003)(476003)(11346002)(6666003)(446003)(956004)(105586002)(106356001)(486006)(81156014)(8676002)(50226002)(81166006)(7736002)(16526019)(47776003)(8936002)(66066001)(50466002)(2906002)(186003)(6916009)(76176011)(4326008)(14444005)(52116002)(6486002)(97736004)(6116002)(6506007)(26005)(51416003)(16586007)(1076002)(25786009)(53416004)(478600001)(316002)(86362001)(305945005)(53936002)(3846002)(386003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3258;H:i7.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR08MB3258;23:PJG3Zzsod2CAfVDImG/VFFn4YGGWjX9Bio2noN1rK?=
 =?us-ascii?Q?f3IXpGqR5sWGH2XGBkTFWYq/V1qMVUfnCpjQLwrgP4P44MNO0xssHrOsOJM3?=
 =?us-ascii?Q?A2iIYoEG03jUt+Mqu58dTrjtUPNN2ED0FbwC8+59M2Sjv2mbaMLNdXKFHbJB?=
 =?us-ascii?Q?bvd/emX4+AXvZP3AxOv6+0/4OuPLDyS4pYaxdBwNTewb1VYMk7xl+Ju9pCgx?=
 =?us-ascii?Q?oFWPhjQtHL/rkPVnAkxhtY9uDud3tb9KardwkcqH1P+ZjmosqqcI1K9LQ+bm?=
 =?us-ascii?Q?9tR0ENT5fcEMZTYhRrzCYxccfCHvhRAD5ynko1yvoQ45iZ+Gi8D1P6Qbt0hC?=
 =?us-ascii?Q?a0y5l9jhiAt6thjy0SouRQTW20UrXCTXZzSHUPsrso5uwRD5xhVEi4KxWnOM?=
 =?us-ascii?Q?MTWkpZXu9sT0QH5sx/hkMgO1FXcCHR6kLkQ4NTayLSLuaCtxvme7L7WRBQQT?=
 =?us-ascii?Q?2SwO/WhW8RJChR/CH87Chf2u2cpvJiiOPr317P0l/pRL3aO8xeqexQnteiu4?=
 =?us-ascii?Q?v1EfjvxVw3zF8DcTXbjKmmvt1v6Tg3KV2elS/a1Ii5/zy6lKcqFBdohWZTc5?=
 =?us-ascii?Q?axZvds7L7ikyOiDAhjRtOl3Tm/iXPSwbrueWo6OXJ9nhkMDL/PpKXhHkrFtP?=
 =?us-ascii?Q?hMOGuFjpCVqtokgyEvwXze3RgnwWqg9yTJEPBTh9SBN+eG0s+PzNVD7sgcl0?=
 =?us-ascii?Q?o05liCGm3bTzJ1BKbcKq7M6BxJgpI7azrPVmStHGhY+7rIOL/OA5m18Z4eMs?=
 =?us-ascii?Q?YU6DePNHe/dUYK6EhZXS6idQCTECZIFE5Za2cGP0Gqk95+KWoiNh9465fN0N?=
 =?us-ascii?Q?1qMZ91bFB9C6udCUyUD3GabusUzhOMZ9Q7d99XtZvm5U4Bti8/eZuoh5bE4W?=
 =?us-ascii?Q?h9erncyLUtSqtIvbR40uyTfJ6fTjpAb5icWay59Lc4P+nEgnEVz+pw3oUDXP?=
 =?us-ascii?Q?aab5/iM95uCF+Rvt42HKG6XgEeGUIERDWib/wTsqzqLkgPZxKu9rhRPHrxLQ?=
 =?us-ascii?Q?fs0LcKpEWVfCdOFZwqxf3b48HiFwGWO3D4jcSwMYgF+Aso3PxpdyCCNRF+bQ?=
 =?us-ascii?Q?q4jnFp730ha4gSDFyITu5IIdR2HkZprpVHLcjbQW1KAr5NiISQWC5zmyiTug?=
 =?us-ascii?Q?sgSbbxfKfWRsszQS9MJCYDX7Cvo0p+tYneAbnySpguUpeo2Vu7KPd2NPM0/y?=
 =?us-ascii?Q?7nXnnaD7/m43O6ig2+VTNrleC2c61BHxcOvNDkp0Bk+axZq+s4cnNtfGQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: pPdwOwTsGUv94/gVJAP7IQfcGwtcuf57sPkyvsGR+Cho/PRbrYUPLuokCrOx2ywovWP6B/ComFmN1ezPxpjb46LR3XgzQJ8iPesuyupZXwrIyTNe2WMeKYAhX23YRSm3uNSaDqopqumE2PZ+xT0/9QsvMlDjkyJk+rapsYxni8bKNbicd3ZynHb/nTkfDk0rkIHGGeiqCrRzrWLfVgQ+N31zE/omcaakhfoaDDUR7iq2MLe3C/4JxnjsZLZiBdH3Ygktt8gliDLpqrb+S4jTHsnWbwMQa0nYOAVbYFUW/szf0NsDEZiq5ncTcHKkqjLAYtkJZ5tw7LvFLzjJ87VTVgxRHavOvZ1tJIpLEgWoBcQ=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;6:YHEwvXNh+qxnlaqqTRSip9DlUu5wTmUR8jiQfEK62jO0B/zJr389px8mNvFidKyY0eE1qIIXZ9PTWK2Sf8v3U44E2rcpXNGih/GMpm+2RkEeFS34xGKgmOodY7E9CXmbiTy6cn1sbJKOKYm9GYGmh89JBez/y9o73cQIH6Hz4ciytycQnFfX/d1SeoZAEPayxcQ5aXPXEZw1e9eTDkDjgXNZ7RtFVsj+E4Psf9llzW1yokjIloLRdHgoNasEPgw50yWWjQH1R9u6oo7J5xwDmmoC1nm+ENYpf+PHS1sYsqvKVN+2Q3KmAlvGXncN78IteD2vgh1A9C5c3GHGIpfBC5TXU8K9VZ951V/gmBAjNfkC7mSbBjyvhleS0zm6GJ+ykT0JzPtElilwwy3yN4zfjW7HLnb31yCsxtTR22asqe3WeWR1UU5lwSk7l2tOvGo+zhX7mjrDDAttVEdv5h3aGw==;5:6NdcxRafSsbye6NM4Iowc5fhIJOXtMp4Fi3nNxKXbN3GTIEtTAq8R0aEO5YKIKmdruSzSCRMVepYL8vCYpjIjyM7XSm6QeqqKvnBeZoqpSvwz0DQ1/XT1+jBw/ttMSdQwQxtH7rEcOV+fQHqsCa5utk9qa7Docj+DzmS64+RLs8=;24:1zeKmdxpRnijvfK1TIpLhyLdElC2MB2X5DHgT1xxCIwlXSzCDRZ2LjqtJVw+z3yRUUHYLphLM43NRg5ENgo1WC8OBrD28ck+a9/IS/ZZ7sE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;7:rRCpIRb7SQY913dBuyfJASee15RjM2YuVMMVkdzhR9QmG+laMhb83HBxhlHHksFogRp7+ZqLLqwpqKWC/e4WW8u7nhu6je3iTXaxy7JR5gALDp5rdQ+1QR6VltIEZlvD6xSvJQxkLZKuwXpYqejY/feKZw60BSJbDlAYSUVnLXRCuP49LLT7u0RvxX9tpXwDCZyQtDMci9LGo8OcEtP5hgvRi6UElbRhob65aeM+CHvOcCmfmt2BQ0+gejo95sVm;20:G5a1BH9xKGgoIU4BjStxqvQYuvYC2XpT2MjPV8aDCzlHKeM04Wz5qtlEMaTwCcIE0pW89qbr4mK6sV2KEFEuGNA3n45bj7ZqNPWo8gefI3AaJS3beEAINmSMvc5JwYkqatRjoKyU3no7fgRDNFcpRBkVAtOa7Ezr8yb39yvb/K0=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 15:59:02.9944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9022e56-7bb5-4752-b2c2-08d5ebfe3801
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3258
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fuse_dev_splice_write() reads pipe->buffers to determine the size of
'bufs' array before taking the pipe_lock(). This is not safe as
another thread might change the 'pipe->buffers' between the allocation
and taking the pipe_lock(). So we end up with too small 'bufs' array.

Move the bufs allocations inside pipe_lock()/pipe_unlock() to fix this.

Fixes: dd3bb14f44a6 ("fuse: support splice() writing to fuse device")
Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: <stable@vger.kernel.org>
---
 fs/fuse/dev.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index c6b88fa85e2e..702592cce546 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1944,12 +1944,15 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 	if (!fud)
 		return -EPERM;
 
+	pipe_lock(pipe);
+
 	bufs = kmalloc_array(pipe->buffers, sizeof(struct pipe_buffer),
 			     GFP_KERNEL);
-	if (!bufs)
+	if (!bufs) {
+		pipe_unlock(pipe);
 		return -ENOMEM;
+	}
 
-	pipe_lock(pipe);
 	nbuf = 0;
 	rem = 0;
 	for (idx = 0; idx < pipe->nrbufs && rem < len; idx++)
-- 
2.16.4

