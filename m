Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164285AbeE1Kya (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:54:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164256AbeE1KyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:54:15 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Davide Caratti <dcaratti@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 280/496] net/sched: fix idr leak in the error path of tcf_simp_init()
Date: Mon, 28 May 2018 12:01:05 +0200
Message-Id: <20180528100331.649896896@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Davide Caratti <dcaratti@redhat.com>

[ Upstream commit 60e10b3adc3bac0f6a894c28e0eb1f2d13607362 ]

if the kernel fails to duplicate 'sdata', creation of a new action fails
with -ENOMEM. However, subsequent attempts to install the same action
using the same value of 'index' systematically fail with -ENOSPC, and
that value of 'index' will no more be usable by act_simple, until rmmod /
insmod of act_simple.ko is done:

 # tc actions add action simple sdata hello index 100
 # tc actions list action simple

        action order 0: Simple <hello>
         index 100 ref 1 bind 0
 # tc actions flush action simple
 # tc actions add action simple sdata hello index 100
 RTNETLINK answers: Cannot allocate memory
 We have an error talking to the kernel
 # tc actions flush action simple
 # tc actions add action simple sdata hello index 100
 RTNETLINK answers: No space left on device
 We have an error talking to the kernel
 # tc actions add action simple sdata hello index 100
 RTNETLINK answers: No space left on device
 We have an error talking to the kernel
 ...

Fix this in the error path of tcf_simp_init(), calling tcf_idr_release()
in place of tcf_idr_cleanup().

Fixes: 65a206c01e8e ("net/sched: Change act_api and act_xxx modules to use IDR")
Suggested-by: Cong Wang <xiyou.wangcong@gmail.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_simple.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sched/act_simple.c
+++ b/net/sched/act_simple.c
@@ -121,7 +121,7 @@ static int tcf_simp_init(struct net *net
 		d = to_defact(*a);
 		ret = alloc_defdata(d, defdata);
 		if (ret < 0) {
-			tcf_idr_cleanup(*a, est);
+			tcf_idr_release(*a, bind);
 			return ret;
 		}
 		d->tcf_action = parm->action;
