Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE174C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881CD206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EZXt1szx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 881CD206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeIMBbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 21:31:21 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37074 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbeIMBbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 21:31:20 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8CKO5vu041213;
        Wed, 12 Sep 2018 20:25:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=8Sry9VfOa8WI9s6H5jH3I6krWsR4HwJtnmYrg+2LmK8=;
 b=EZXt1szxpHc8ol5fV1KKfNqXodveVWbdn1JL60e+Pqs4ZedPEj9EWCpP25pdWEen8wgF
 iAw4eQcSdgFSuRyMx7NYunmPofoHgqX2RUydmzz/sEBNyOTW/PN6+Z4+I67QwFKVzlmG
 yrABMZLuL3j7d7qql5QRuIsIiDZkOy5t8DrERa4f5gpZ0OaHKR5FYL4fim4XZls5ozoe
 98EnVAg1y1wsE+1c5pmoyUa/1Q9fwGDIURA0DH5oY6sO5JTPvkp3mIuPeyAnDilwUFwM
 3HvI8jYcariK/SqA6GHsJAW7Eg11pFu8QQVgESSzec5U6rVSdMgp9vUl237rxpHznvhN Qw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2mc72qvbvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Sep 2018 20:25:00 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8CKOwpN029974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Sep 2018 20:24:59 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8CKOvA0024062;
        Wed, 12 Sep 2018 20:24:57 GMT
Received: from pp-ThinkCentre-M82.us.oracle.com (/10.132.93.61)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Sep 2018 13:24:56 -0700
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     dave.hansen@intel.com, mhocko@suse.com, nao.horiguchi@gmail.com,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        khandual@linux.vnet.ibm.com, steven.sistare@oracle.com,
        prakash.sangappa@oracle.com
Subject: [PATCH V2 0/6] VA to numa node information
Date:   Wed, 12 Sep 2018 13:23:58 -0700
Message-Id: <1536783844-4145-1-git-send-email-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9014 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=574
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809120201
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For analysis purpose it is useful to have numa node information
corresponding mapped virtual address ranges of a process. Currently,
the file /proc/<pid>/numa_maps provides list of numa nodes from where pages
are allocated per VMA of a process. This is not useful if an user needs to
determine which numa node the mapped pages are allocated from for a
particular address range. It would have helped if the numa node information
presented in /proc/<pid>/numa_maps was broken down by VA ranges showing the
exact numa node from where the pages have been allocated.

The format of /proc/<pid>/numa_maps file content is dependent on
/proc/<pid>/maps file content as mentioned in the manpage. i.e one line
entry for every VMA corresponding to entries in /proc/<pids>/maps file.
Therefore changing the output of /proc/<pid>/numa_maps may not be possible.

This patch set introduces the file /proc/<pid>/numa_vamaps which
will provide proper break down of VA ranges by numa node id from where the
mapped pages are allocated. For Address ranges not having any pages mapped,
a '-' is printed instead of numa node id.

Includes support to lseek, allowing seeking to a specific process Virtual
address(VA) starting from where the address range to numa node information
can to be read from this file.

The new file /proc/<pid>/numa_vamaps will be governed by ptrace access
mode PTRACE_MODE_READ_REALCREDS.

See following for previous discussion about this proposal

https://marc.info/?t=152524073400001&r=1&w=2


Prakash Sangappa (6):
  Add check to match numa node id when gathering pte stats
  Add /proc/<pid>/numa_vamaps file for numa node information
  Provide process address range to numa node id mapping
  Add support to lseek /proc/<pid>/numa_vamaps file
  File /proc/<pid>/numa_vamaps access needs PTRACE_MODE_READ_REALCREDS
    check
  /proc/pid/numa_vamaps: document in Documentation/filesystems/proc.txt

 Documentation/filesystems/proc.txt |  21 +++
 fs/proc/base.c                     |   6 +-
 fs/proc/internal.h                 |   1 +
 fs/proc/task_mmu.c                 | 265 ++++++++++++++++++++++++++++++++++++-
 4 files changed, 285 insertions(+), 8 deletions(-)

-- 
2.7.4

