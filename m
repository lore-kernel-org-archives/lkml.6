Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165084AbeE1Mym (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:54:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163432AbeE1KzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:55:18 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
        Davide Caratti <dcaratti@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 282/496] net/sched: fix idr leak in the error path of tcp_pedit_init()
Date: Mon, 28 May 2018 12:01:07 +0200
Message-Id: <20180528100331.726345310@linuxfoundation.org>
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

[ Upstream commit 94fa3f929ec0c048b1f3658cc335b940df4f6d22 ]

tcf_pedit_init() can fail to allocate 'keys' after the idr has been
successfully reserved. When this happens, subsequent attempts to configure
a pedit rule using the same idr value systematically fail with -ENOSPC:

 # tc action add action pedit munge ip ttl set 63 index 100
 RTNETLINK answers: Cannot allocate memory
 We have an error talking to the kernel
 # tc action add action pedit munge ip ttl set 63 index 100
 RTNETLINK answers: No space left on device
 We have an error talking to the kernel
 # tc action add action pedit munge ip ttl set 63 index 100
 RTNETLINK answers: No space left on device
 We have an error talking to the kernel
 ...

Fix this in the error path of tcf_act_pedit_init(), calling
tcf_idr_release() in place of tcf_idr_cleanup().

Fixes: 65a206c01e8e ("net/sched: Change act_api and act_xxx modules to use IDR")
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_pedit.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -176,7 +176,7 @@ static int tcf_pedit_init(struct net *ne
 		p = to_pedit(*a);
 		keys = kmalloc(ksize, GFP_KERNEL);
 		if (keys == NULL) {
-			tcf_idr_cleanup(*a, est);
+			tcf_idr_release(*a, bind);
 			kfree(keys_ex);
 			return -ENOMEM;
 		}
