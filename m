Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbeAaTku (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 14:40:50 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:37056 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751433AbeAaTks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 14:40:48 -0500
X-Google-Smtp-Source: AH8x227J7zKXAnlFmEGbx8DXbiBfpA7Bk3KWgyhKbMcAf99ZHcfwLspfWZxLILi23yAvdgjJyW8rcw==
From: Ildar Ismagilov <devix84@gmail.com>
Cc: devix84@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] srcu: Prevent sdp->srcu_gp_seq_needed_exp counter wrap
Date: Wed, 31 Jan 2018 22:39:53 +0300
Message-Id: <20180131193954.28386-1-devix84@gmail.com>
X-Mailer: git-send-email 2.11.0
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ildar Ismagilov <devix84@gmail.com>
---
 kernel/rcu/srcutree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 1798d1aa60fa..c54617280245 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -552,6 +552,9 @@ static void srcu_gp_end(struct srcu_struct *sp)
 				if (ULONG_CMP_GE(gpseq,
 						 sdp->srcu_gp_seq_needed + 100))
 					sdp->srcu_gp_seq_needed = gpseq;
+				if (ULONG_CMP_GE(gpseq,
+						 sdp->srcu_gp_seq_needed_exp + 100))
+					sdp->srcu_gp_seq_needed_exp = gpseq;
 				raw_spin_unlock_irqrestore_rcu_node(sdp, flags);
 			}
 	}
-- 
2.11.0
