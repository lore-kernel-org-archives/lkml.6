Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752396AbeERNHo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 09:07:44 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35453 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752500AbeERNF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 09:05:29 -0400
X-Google-Smtp-Source: AB8JxZpGViDMXI2BBNMBz9f3Q3uG5PCp2Vv6nY7KrEy6b0E0aA8adpwJdrWHv01u43YKt9Zjg10TDQ==
From: Roman Pen <roman.penyaev@profitbricks.com>
To: linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Or Gerlitz <ogerlitz@mellanox.com>, Doug Ledford <dledford@redhat.com>,
        Swapnil Ingle <swapnil.ingle@profitbricks.com>,
        Danil Kipnis <danil.kipnis@profitbricks.com>,
        Jack Wang <jinpu.wang@profitbricks.com>,
        Roman Pen <roman.penyaev@profitbricks.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/26] rculist: introduce list_next_or_null_rr_rcu()
Date: Fri, 18 May 2018 15:03:48 +0200
Message-Id: <20180518130413.16997-2-roman.penyaev@profitbricks.com>
X-Mailer: git-send-email 2.13.1
In-Reply-To: <20180518130413.16997-1-roman.penyaev@profitbricks.com>
References: <20180518130413.16997-1-roman.penyaev@profitbricks.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function is going to be used in transport over RDMA module
in subsequent patches.

Function returns next element in round-robin fashion,
i.e. head will be skipped.  NULL will be returned if list
is observed as empty.

Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org
---
 include/linux/rculist.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 127f534fec94..b0840d5ab25a 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -339,6 +339,25 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
 })
 
 /**
+ * list_next_or_null_rr_rcu - get next list element in round-robin fashion.
+ * @head:	the head for the list.
+ * @ptr:        the list head to take the next element from.
+ * @type:       the type of the struct this is embedded in.
+ * @memb:       the name of the list_head within the struct.
+ *
+ * Next element returned in round-robin fashion, i.e. head will be skipped,
+ * but if list is observed as empty, NULL will be returned.
+ *
+ * This primitive may safely run concurrently with the _rcu list-mutation
+ * primitives such as list_add_rcu() as long as it's guarded by rcu_read_lock().
+ */
+#define list_next_or_null_rr_rcu(head, ptr, type, memb) \
+({ \
+	list_next_or_null_rcu(head, ptr, type, memb) ?: \
+		list_next_or_null_rcu(head, READ_ONCE((ptr)->next), type, memb); \
+})
+
+/**
  * list_for_each_entry_rcu	-	iterate over rcu list of given type
  * @pos:	the type * to use as a loop cursor.
  * @head:	the head for your list.
-- 
2.13.1
