Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C2FC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09C220834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="y93v5HyO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A09C220834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbeHaA26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 20:28:58 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58672 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbeHaA26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 20:28:58 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7UKNY4v031676;
        Thu, 30 Aug 2018 20:24:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=iuQ5spCkYBImoJ5Jc7VISLxVqEoNMIE4pA4GRSdBhrA=;
 b=y93v5HyONyvRswYshGZ5gRH5OBFYZnbcY+6SGgVDj5w8Rkncd1voYGsjvoYQjg57xhkr
 xxWudFPsqNzFEshCfh/Ji+UFmqA6Kr9ySkU34oPkALjuQtGgNU2rHfvMH5wmWVzUaaRG
 AVLHholxd7OdJO19T7hxr0FrU5cthfNnPwaZM8Rzmu65xy+QZfSWyRHw7I6WdF+mYpSr
 DMUqc0iDJSOhtZvSjB11dugwpy5jbtOf9zSVvOOTULsw+os+aKsPQY6vMF+Ysxu+BLTB
 K8gwScu5FBykmz7V3RGHgIj4RPALLMDLLAFYwFklpHsNXKLz1Cqz8VH7S2v15ELALJJP Rw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2m2yrqptsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 20:24:44 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7UKOhiZ031465
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 20:24:44 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7UKOh6O005595;
        Thu, 30 Aug 2018 20:24:43 GMT
Received: from smazumda-Precision-T1600.us.oracle.com (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Aug 2018 13:24:43 -0700
From:   subhra mazumdar <subhra.mazumdar@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, dhaval.giani@oracle.com,
        steven.sistare@oracle.com, subhra.mazumdar@oracle.com
Subject: [RFC PATCH 1/2] pipe: introduce busy wait for pipe
Date:   Thu, 30 Aug 2018 13:24:57 -0700
Message-Id: <20180830202458.32579-2-subhra.mazumdar@oracle.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180830202458.32579-1-subhra.mazumdar@oracle.com>
References: <20180830202458.32579-1-subhra.mazumdar@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9001 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=855
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808300206
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce pipe_ll_usec field for pipes that indicates the amount of micro
seconds a thread should spin if pipe is empty or full before sleeping. This
is similar to network sockets. Workloads like hackbench in pipe mode
benefits significantly from this by avoiding the sleep and wakeup overhead.
Other similar usecases can benefit. pipe_wait_flag is used to signal any
thread busy waiting. pipe_busy_loop_timeout checks if spin time is over.

Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
---
 include/linux/pipe_fs_i.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index e7497c9..fdfd2a2 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -1,6 +1,8 @@
 #ifndef _LINUX_PIPE_FS_I_H
 #define _LINUX_PIPE_FS_I_H
 
+#include <linux/sched/clock.h>
+
 #define PIPE_DEF_BUFFERS	16
 
 #define PIPE_BUF_FLAG_LRU	0x01	/* page is on the LRU */
@@ -54,6 +56,8 @@ struct pipe_inode_info {
 	unsigned int waiting_writers;
 	unsigned int r_counter;
 	unsigned int w_counter;
+	unsigned int pipe_ll_usec;
+	unsigned long pipe_wait_flag;
 	struct page *tmp_page;
 	struct fasync_struct *fasync_readers;
 	struct fasync_struct *fasync_writers;
@@ -157,6 +161,21 @@ static inline int pipe_buf_steal(struct pipe_inode_info *pipe,
 	return buf->ops->steal(pipe, buf);
 }
 
+static inline unsigned long pipe_busy_loop_current_time(void)
+{
+	return (unsigned long)(local_clock() >> 10);
+}
+
+static inline bool pipe_busy_loop_timeout(struct pipe_inode_info *pipe,
+					  unsigned long start_time)
+{
+	unsigned long bp_usec = READ_ONCE(pipe->pipe_ll_usec);
+	unsigned long end_time = start_time + bp_usec;
+	unsigned long now = pipe_busy_loop_current_time();
+
+	return time_after(now, end_time);
+}
+
 /* Differs from PIPE_BUF in that PIPE_SIZE is the length of the actual
    memory allocation, whereas PIPE_BUF makes atomicity guarantees.  */
 #define PIPE_SIZE		PAGE_SIZE
-- 
2.9.3

