Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424991AbeE1Mx3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:53:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164222AbeE1Kzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:55:35 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
        Davide Caratti <dcaratti@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 283/496] net/sched: fix idr leak in the error path of __tcf_ipt_init()
Date: Mon, 28 May 2018 12:01:08 +0200
Message-Id: <20180528100331.764653302@linuxfoundation.org>
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

[ Upstream commit 1e46ef1762bb2e52f0f996131a4d16ed4e9fd065 ]

__tcf_ipt_init() can fail after the idr has been successfully reserved.
When this happens, subsequent attempts to configure xt/ipt rules using
the same idr value systematically fail with -ENOSPC:

 # tc action add action xt -j LOG --log-prefix test1 index 100
 tablename: mangle hook: NF_IP_POST_ROUTING
         target:  LOG level warning prefix "test1" index 100
 RTNETLINK answers: Cannot allocate memory
 We have an error talking to the kernel
 Command "(null)" is unknown, try "tc actions help".
 # tc action add action xt -j LOG --log-prefix test1 index 100
 tablename: mangle hook: NF_IP_POST_ROUTING
         target:  LOG level warning prefix "test1" index 100
 RTNETLINK answers: No space left on device
 We have an error talking to the kernel
 Command "(null)" is unknown, try "tc actions help".
 # tc action add action xt -j LOG --log-prefix test1 index 100
 tablename: mangle hook: NF_IP_POST_ROUTING
         target:  LOG level warning prefix "test1" index 100
 RTNETLINK answers: No space left on device
 We have an error talking to the kernel
 ...

Fix this in the error path of __tcf_ipt_init(), calling tcf_idr_release()
in place of tcf_idr_cleanup(). Since tcf_ipt_release() can now be called
when tcfi_t is NULL, we also need to protect calls to ipt_destroy_target()
to avoid NULL pointer dereference.

Fixes: 65a206c01e8e ("net/sched: Change act_api and act_xxx modules to use IDR")
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_ipt.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/net/sched/act_ipt.c
+++ b/net/sched/act_ipt.c
@@ -80,9 +80,12 @@ static void ipt_destroy_target(struct xt
 static void tcf_ipt_release(struct tc_action *a, int bind)
 {
 	struct tcf_ipt *ipt = to_ipt(a);
-	ipt_destroy_target(ipt->tcfi_t);
+
+	if (ipt->tcfi_t) {
+		ipt_destroy_target(ipt->tcfi_t);
+		kfree(ipt->tcfi_t);
+	}
 	kfree(ipt->tcfi_tname);
-	kfree(ipt->tcfi_t);
 }
 
 static const struct nla_policy ipt_policy[TCA_IPT_MAX + 1] = {
@@ -187,7 +190,7 @@ err2:
 	kfree(tname);
 err1:
 	if (ret == ACT_P_CREATED)
-		tcf_idr_cleanup(*a, est);
+		tcf_idr_release(*a, bind);
 	return err;
 }
 
