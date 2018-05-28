Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164431AbeE1Kzp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:55:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:44182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164416AbeE1Kzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:55:38 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
        Davide Caratti <dcaratti@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 284/496] net/sched: fix idr leak in the error path of tcf_skbmod_init()
Date: Mon, 28 May 2018 12:01:09 +0200
Message-Id: <20180528100331.808800023@linuxfoundation.org>
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

[ Upstream commit f29cdfbe33d6915ba8056179b0041279a67e3647 ]

tcf_skbmod_init() can fail after the idr has been successfully reserved.
When this happens, every subsequent attempt to configure skbmod rules
using the same idr value will systematically fail with -ENOSPC, unless
the first attempt was done using the 'replace' keyword:

 # tc action add action skbmod swap mac index 100
 RTNETLINK answers: Cannot allocate memory
 We have an error talking to the kernel
 # tc action add action skbmod swap mac index 100
 RTNETLINK answers: No space left on device
 We have an error talking to the kernel
 # tc action add action skbmod swap mac index 100
 RTNETLINK answers: No space left on device
 We have an error talking to the kernel
 ...

Fix this in tcf_skbmod_init(), ensuring that tcf_idr_release() is called
on the error path when the idr has been reserved, but not yet inserted.
Also, don't test 'ovr' in the error path, to avoid a 'replace' failure
implicitly become a 'delete' that leaks refcount in act_skbmod module:

 # rmmod act_skbmod; modprobe act_skbmod
 # tc action add action skbmod swap mac index 100
 # tc action add action skbmod swap mac continue index 100
 RTNETLINK answers: File exists
 We have an error talking to the kernel
 # tc action replace action skbmod swap mac continue index 100
 RTNETLINK answers: Cannot allocate memory
 We have an error talking to the kernel
 # tc action list action skbmod
 #
 # rmmod  act_skbmod
 rmmod: ERROR: Module act_skbmod is in use

Fixes: 65a206c01e8e ("net/sched: Change act_api and act_xxx modules to use IDR")
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_skbmod.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sched/act_skbmod.c
+++ b/net/sched/act_skbmod.c
@@ -155,7 +155,7 @@ static int tcf_skbmod_init(struct net *n
 	ASSERT_RTNL();
 	p = kzalloc(sizeof(struct tcf_skbmod_params), GFP_KERNEL);
 	if (unlikely(!p)) {
-		if (ovr)
+		if (ret == ACT_P_CREATED)
 			tcf_idr_release(*a, bind);
 		return -ENOMEM;
 	}
