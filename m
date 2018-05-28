Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937915AbeE1Mw3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:52:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164439AbeE1Kzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:55:52 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
        Davide Caratti <dcaratti@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 279/496] net/sched: fix idr leak on the error path of tcf_bpf_init()
Date: Mon, 28 May 2018 12:01:04 +0200
Message-Id: <20180528100331.606177007@linuxfoundation.org>
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

[ Upstream commit bbc09e7842a5023ba5bc0f8d559b9dd464e44006 ]

when the following command sequence is entered

 # tc action add action bpf bytecode '4,40 0 0 12,31 0 1 2048,6 0 0 262144,6 0 0 0' index 100
 RTNETLINK answers: Invalid argument
 We have an error talking to the kernel
 # tc action add action bpf bytecode '4,40 0 0 12,21 0 1 2048,6 0 0 262144,6 0 0 0' index 100
 RTNETLINK answers: No space left on device
 We have an error talking to the kernel

act_bpf correctly refuses to install the first TC rule, because 31 is not
a valid instruction. However, it refuses to install the second TC rule,
even if the BPF code is correct. Furthermore, it's no more possible to
install any other rule having the same value of 'index' until act_bpf
module is unloaded/inserted again. After the idr has been reserved, call
tcf_idr_release() instead of tcf_idr_cleanup(), to fix this issue.

Fixes: 65a206c01e8e ("net/sched: Change act_api and act_xxx modules to use IDR")
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_bpf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sched/act_bpf.c
+++ b/net/sched/act_bpf.c
@@ -356,7 +356,7 @@ static int tcf_bpf_init(struct net *net,
 	return res;
 out:
 	if (res == ACT_P_CREATED)
-		tcf_idr_cleanup(*act, est);
+		tcf_idr_release(*act, bind);
 
 	return ret;
 }
