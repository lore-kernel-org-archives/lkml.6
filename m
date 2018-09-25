Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92558ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED1920880
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JIMZecmM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED1920880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbeIZFng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 01:43:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51088 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeIZFnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 01:43:35 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8PNSgx5174301;
        Tue, 25 Sep 2018 23:32:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=0JZ93YejSjz77GAag+S2lztN/zcwJm9cltKloDP+JWc=;
 b=JIMZecmMOsjkPmM1Zw4/MYKVy4ULcY8ICeDmEmLHfGt3Ag0sQ+dIKiQoKr9X3DQQrKW8
 7Odebmze1xhZRlF39ipD/CWWRK8yGFmly/pKCprMDqUdvSc6VQZiU922uHba/p9707oI
 ffhxBy4Tg73+0VNCy/9YNqYNeHbosmXd+qWIm2j8PBmbVL5gF8nc52UXDOZkVXzaeJ2n
 PmjXNQwcU88bLItvtQCIt5qkVEQcWGmV1br7XE/Z8DvPc9w6fJGMmfgUcvAeg+Pe1bSk
 ATgxBqvZJXRIxp0mqbz+ETQfmJSlFpXxDsi0YTT+tH83jXNEO8IC4ENipHnYKKE6WSrR 0g== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2mnd5tfa23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Sep 2018 23:32:50 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8PNWoRj010429
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Sep 2018 23:32:50 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8PNWnrG016174;
        Tue, 25 Sep 2018 23:32:49 GMT
Received: from smazumda-Precision-T1600.us.oracle.com (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Sep 2018 16:32:49 -0700
From:   subhra mazumdar <subhra.mazumdar@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, tglx@linutronix.de, dhaval.giani@oracle.com,
        steven.sistare@oracle.com
Subject: [RFC PATCH v2 0/1] Pipe busy wait
Date:   Tue, 25 Sep 2018 16:32:39 -0700
Message-Id: <20180925233240.24451-1-subhra.mazumdar@oracle.com>
X-Mailer: git-send-email 2.9.3
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9027 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=965
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809250229
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces busy waiting for pipes similar to network sockets.
When pipe is full or empty a thread busy waits for some microseconds before
sleeping. This avoids the sleep and wakeup overhead and improves
performance in case wakeup happens very fast. It uses a new field in
pipe_inode_info to decide how much to spin. As different workloads on
different systems can have different optimum spin time, it is configurable
via a tunable that can be set via /proc. The default value is 0 which
indicates no spin.

Following are the hackbench process using pipe and Unixbench performance 
numbers with baseline and suitable spin time.

Hackbench on 2 socket, 36 core and 72 threads Intel x86 machine
(lower is better). It also shows the usr+sys time as shown by time:
groups  baseline  usr+sys   patch(spin=10us)  usr+sys
1       0.6742    17.0212   0.6842 (-1.48%)   20.2765
2       0.7794    35.1954   0.7116 (8.7%)     38.1318
4       0.9744    55.6513   0.8247 (15.36%)   50.301
8       2.0382    129.519   1.572 (22.87%)    103.722
16      5.5712    427.096   2.7989 (49.76%)   194.162
24      7.9314    566.327   3.962 (50.05%)    278.368

Unixbench on 2 socket, 36 core and 72 threads Intel x86 machine (higher is
better). It shows pipe-based context switching test improving by 107.7% for
1 copy and by 51.3% for 72 parallel copies. This is expected as context
switch overhead is avoided altogether by busy wait.

72 CPUs in system; running 1 parallel copy of tests
System Benchmarks Index Values          baseline	patch(spin=10us)
Dhrystone 2 using register variables    2837.5		2842.0
Double-Precision Whetstone              753.3		753.5
Execl Throughput                        1056.8		1079.2
File Copy 1024 bufsize 2000 maxblocks   1794.0		1805.4
File Copy 256 bufsize 500 maxblocks     1111.4		1117.6
File Copy 4096 bufsize 8000 maxblocks   4136.7		4091.7
Pipe Throughput                         752.9		753.3
Pipe-based Context Switching            372.2		772.9
Process Creation                        840.1		847.6
Shell Scripts (1 concurrent)            1771.0		1747.5
Shell Scripts (8 concurrent)            7316.6		7308.3
System Call Overhead                    578.0		578.0
                                        ========	========
System Benchmarks Index Score           1337.8		1424.0

72 CPUs in system; running 72 parallel copies of tests
System Benchmarks Index Values          baseline 	patch(spin=10us)
Dhrystone 2 using register variables    112849.7	112429.8
Double-Precision Whetstone              44971.1		44929.7
Execl Throughput                        11257.6		11258.7
File Copy 1024 bufsize 2000 maxblocks   1514.6		1471.3
File Copy 256 bufsize 500 maxblocks     919.8		917.4
File Copy 4096 bufsize 8000 maxblocks   3543.8		3355.5
Pipe Throughput                         34530.6		34492.9
Pipe-based Context Switching            11298.2		17089.9
Process Creation                        9422.5		9408.1
Shell Scripts (1 concurrent)            38764.9		38610.4
Shell Scripts (8 concurrent)            32570.5		32458.8
System Call Overhead                    2607.4		2672.7
                                        ========	========
System Benchmarks Index Score           11077.2		11393.5

Changes from v1->v2:
-Removed preemption disable in the busy wait loop
-Changed busy spin condition to TASK_RUNNING state of the current thread
-Added usr+sys time for hackbench runs as shown by time command

subhra mazumdar (1):
  pipe: busy wait for pipe

 fs/pipe.c                 | 12 ++++++++++++
 include/linux/pipe_fs_i.h |  2 ++
 kernel/sysctl.c           |  7 +++++++
 3 files changed, 21 insertions(+)

-- 
2.9.3

