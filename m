Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F5EC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E3520834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SF0qkAi1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E3520834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbeHaA26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 20:28:58 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58670 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbeHaA26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 20:28:58 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7UKNV3o031630;
        Thu, 30 Aug 2018 20:24:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=gFhBUMBXzoC3pRUXmAKVddLOLbwOtQG6FsZP/aPXY3U=;
 b=SF0qkAi16pIpTEfJy50p6RkCnu6t09AexWOCWemC6Te/ILsesFSNcH3P302TAq12H7UC
 IULYVykxF9ZMeCYFpQr8Kn0kodXcXPJ+ECi06jpE3/Li6in6/K7l2pkCfVh1b/pLrmv/
 yLKxchUMR6Fgcv6AfOW4XyDBv0M/SW8xle9RKQBhD1Qx0p3woNndgdMm4fs10kYd/RX+
 tR0M+1Mze4CJ3A/uh239zwcAkM1ELHOFOAW9QbfoZTb5Am0yGn+wIYZVjCSP+3UTu8hI
 q6ygrQ5+yLfNY4EbyD4qe9hS/HmyU/sWy2J7e8UFO3kPJDCOaH/wqoUMXxXHaoXeOzhQ Aw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2m2yrqptsp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 20:24:44 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7UKOh8d008869
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 20:24:43 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7UKOhRU005365;
        Thu, 30 Aug 2018 20:24:43 GMT
Received: from smazumda-Precision-T1600.us.oracle.com (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Aug 2018 13:24:42 -0700
From:   subhra mazumdar <subhra.mazumdar@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, dhaval.giani@oracle.com,
        steven.sistare@oracle.com, subhra.mazumdar@oracle.com
Subject: [RFC PATCH 0/2] Pipe busy wait
Date:   Thu, 30 Aug 2018 13:24:56 -0700
Message-Id: <20180830202458.32579-1-subhra.mazumdar@oracle.com>
X-Mailer: git-send-email 2.9.3
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9001 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=380
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808300206
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces busy waiting for pipes similar to network sockets.
When pipe is full or empty a thread busy waits for some microseconds before
sleeping. This avoids the sleep and wakeup overhead and improves
performance in case wakeup happens very fast. It uses new fields in
pipe_inode_info to decide how much to spin and if data has been written or
read during spin. As different workloads on different systems can have
different optimum spin time, it is configurable via a tunable that can be
set via /proc. The default value is 0 which indicates no spin.

Following are the hackbench process run times using pipe for different
sized systems with baseline and suitable spin time.

Hackbench on 2 socket, 36 core and 72 threads Intel x86 machine
(lower is better):
groups  baseline     patch(spin=10us)
1       0.603        0.614 (-1.82%)
2       0.673        0.527 (21.7%)
4       0.765        0.638 (16.6%)
8       1.935        1.114 (42.43%)
16      7.314        2.007 (72.56%)
32      6.215        3.585 (42.32%)

Hackbench on 1 socket, 16 core and 32 threads Intel x86 VM
(lower is better):
groups  baseline     patch(spin=10us)
1       1.314        0.747 (43.15%)
2       1.454        0.754 (48.14%)
4       3.409        1.343 (60.6%)
8       6.879        2.559 (62.8%)
16      9.82         4.951 (49.58%)

Hackbench on 1 socket, 4 core and 8 threads Intel x86 VM
(lower is better):
groups  baseline     patch(spin=5us)
1       2.827        1.455 (48.53%)
2       6.201        2.805 (54.77%)
4       9.514        5.008 (47.36%)
8       14.571       8.422 (42.2%)

Hackbench on 1 socket, 1 core and 2 threads Intel x86 VM
(lower is better):
groups  baseline     patch(spin=5us)
1       3.365        2.948 (12.39%)
2       6.82         6.535 (4.18%)
4       13.18        13.025 (1.18%)

subhra mazumdar (2):
  pipe: introduce busy wait for pipe
  pipe: use pipe busy wait

 fs/pipe.c                 | 58 +++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/pipe_fs_i.h | 20 ++++++++++++++++
 kernel/sysctl.c           |  7 ++++++
 3 files changed, 83 insertions(+), 2 deletions(-)

-- 
2.9.3

