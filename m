Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932991AbeE1M6y (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:58:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164121AbeE1Kyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:54:46 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
        Davide Caratti <dcaratti@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 281/496] net/sched: fix idr leak in the error path of tcf_act_police_init()
Date: Mon, 28 May 2018 12:01:06 +0200
Message-Id: <20180528100331.689710709@linuxfoundation.org>
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

[ Upstream commit 5bf7f8185f7c7112decdfe3d3e5c5d5e67f099a1 ]

tcf_act_police_init() can fail after the idr has been successfully
reserved (e.g., qdisc_get_rtab() may return NULL). When this happens,
subsequent attempts to configure a police rule using the same idr value
systematiclly fail with -ENOSPC:

 # tc action add action police rate 1000 burst 1000 drop index 100
 RTNETLINK answers: Cannot allocate memory
 We have an error talking to the kernel
 # tc action add action police rate 1000 burst 1000 drop index 100
 RTNETLINK answers: No space left on device
 We have an error talking to the kernel
 # tc action add action police rate 1000 burst 1000 drop index 100
 RTNETLINK answers: No space left on device
 ...

Fix this in the error path of tcf_act_police_init(), calling
tcf_idr_release() in place of tcf_idr_cleanup().

Fixes: 65a206c01e8e ("net/sched: Change act_api and act_xxx modules to use IDR")
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_police.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sched/act_police.c
+++ b/net/sched/act_police.c
@@ -194,7 +194,7 @@ failure:
 	qdisc_put_rtab(P_tab);
 	qdisc_put_rtab(R_tab);
 	if (ret == ACT_P_CREATED)
-		tcf_idr_cleanup(*a, est);
+		tcf_idr_release(*a, bind);
 	return err;
 }
 
