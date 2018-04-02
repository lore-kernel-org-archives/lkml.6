Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751904AbeDBFbh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 01:31:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54916 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751314AbeDBFbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 01:31:36 -0400
From: rao.shoaib@oracle.com
To: linux-kernel@vger.kernel.org
Cc: paulmck@linux.vnet.ibm.com, joe@perches.com, willy@infradead.org,
        brouer@redhat.com, linux-mm@kvack.org,
        Rao Shoaib <rao.shoaib@oracle.com>
Subject: [PATCH 0/2] Move kfree_rcu out of rcu code and use kfree_bulk
Date: Sun,  1 Apr 2018 22:31:02 -0700
Message-Id: <1522647064-27167-1-git-send-email-rao.shoaib@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8850 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=484
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804020059
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rao Shoaib <rao.shoaib@oracle.com>

This patch moves kfree_call_rcu() out of rcu related code to
mm/slab_common and updates kfree_rcu() to use new bulk memory free
functions as they are more efficient.

This is a resubmission of the previous patch.

Changes:

1) checkpatch.pl has been fixed, so kfree_rcu macro is much simpler

2) To handle preemption, preempt_enable()/preempt_disable() statements
   have been added to __rcu_bulk_free().


Rao Shoaib (2):
  Move kfree_call_rcu() to slab_common.c
  kfree_rcu() should use kfree_bulk() interface

 include/linux/mm.h       |   5 ++
 include/linux/rcupdate.h |  43 +-----------
 include/linux/rcutiny.h  |   8 ++-
 include/linux/rcutree.h  |   2 -
 include/linux/slab.h     |  42 ++++++++++++
 kernel/rcu/tree.c        |  24 +++----
 kernel/sysctl.c          |  40 +++++++++++
 mm/slab.h                |  23 +++++++
 mm/slab_common.c         | 172 +++++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 302 insertions(+), 57 deletions(-)

-- 
2.7.4
