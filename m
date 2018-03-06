Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752483AbeCFHIW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 02:08:22 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5738 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750792AbeCFHIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 02:08:20 -0500
Subject: [RFC PATCH] irqchip/gic-v3-its: handle wrapped case in
 its_wait_for_range_completion()
To: Marc Zyngier <marc.zyngier@arm.com>
References: <1518320521-12536-1-git-send-email-yangyingliang@huawei.com>
 <866073z7pr.wl-marc.zyngier@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yangyingliang <yangyingliang@huawei.com>
From: Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <5A9E3E13.6060207@huawei.com>
Date: Tue, 6 Mar 2018 15:06:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <866073z7pr.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.19.219]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yingliang <yangyingliang@huawei.com>

While cpus posting a bunch of ITS commands, the cmd_queue and rd_idx will
be wrapped easily. And current way of handling wrapped case is not quite
right.
Such as, in direct case, rd_idx will wrap if other cpus post commands
that make rd_idx increase. When rd_idx wrapped, the driver prints
timeout messages but in fact the command is finished.

This patch adds two variables to count wrapped times of ITS commands and
read index. With these two variables, the driver can handle wrapped case
correctly.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
  drivers/irqchip/irq-gic-v3-its.c | 72 
+++++++++++++++++++++++++++++++++-------
  1 file changed, 60 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c 
b/drivers/irqchip/irq-gic-v3-its.c
index 1d3056f..a03e18e 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -111,6 +111,9 @@ struct its_node {
  	u32			pre_its_base; /* for Socionext Synquacer */
  	bool			is_v4;
  	int			vlpi_redist_offset;
+	int 			last_rd;
+	u64			cmd_wrapped_cnt;
+	u64			rd_wrapped_cnt;
  };

  #define ITS_ITT_ALIGN		SZ_256
@@ -662,6 +665,7 @@ static int its_queue_full(struct its_node *its)

  static struct its_cmd_block *its_allocate_entry(struct its_node *its)
  {
+	u32 rd;
  	struct its_cmd_block *cmd;
  	u32 count = 1000000;	/* 1s! */

@@ -675,11 +679,24 @@ static struct its_cmd_block 
*its_allocate_entry(struct its_node *its)
  		udelay(1);
  	}

+	/*
+	 * Here is protected by its->lock and driver cannot allocate
+	 * ITS commands, if ITS command queue is full, so the read
+	 * won't wrap twice between this rd_idx and last rd_idx.
+	 * Count rd wrapped times here is safe.
+	 */
+	rd = readl_relaxed(its->base + GITS_CREADR);
+	if (rd < its->last_rd)
+		its->rd_wrapped_cnt++;
+	its->last_rd = rd;
+
  	cmd = its->cmd_write++;

  	/* Handle queue wrapping */
-	if (its->cmd_write == (its->cmd_base + ITS_CMD_QUEUE_NR_ENTRIES))
+	if (its->cmd_write == (its->cmd_base + ITS_CMD_QUEUE_NR_ENTRIES)) {
  		its->cmd_write = its->cmd_base;
+		its->cmd_wrapped_cnt++;
+	}

  	/* Clear command  */
  	cmd->raw_cmd[0] = 0;
@@ -713,29 +730,57 @@ static void its_flush_cmd(struct its_node *its, 
struct its_cmd_block *cmd)

  static int its_wait_for_range_completion(struct its_node *its,
  					 struct its_cmd_block *from,
-					 struct its_cmd_block *to)
+					 struct its_cmd_block *to,
+					 u64 last_cmd_wrapped_cnt)
  {
-	u64 rd_idx, from_idx, to_idx;
+	unsigned long flags;
+	u64 rd_idx, from_idx, to_idx, rd_wrapped_cnt;
  	u32 count = 1000000;	/* 1s! */

  	from_idx = its_cmd_ptr_to_offset(its, from);
  	to_idx = its_cmd_ptr_to_offset(its, to);

  	while (1) {
+		raw_spin_lock_irqsave(&its->lock, flags);
  		rd_idx = readl_relaxed(its->base + GITS_CREADR);
+		if (rd_idx < its->last_rd)
+			its->rd_wrapped_cnt++;
+		its->last_rd = rd_idx;
+		rd_wrapped_cnt = its->rd_wrapped_cnt;
+		raw_spin_unlock_irqrestore(&its->lock, flags);

-		/* Direct case */
-		if (from_idx < to_idx && rd_idx >= to_idx)
-			break;
-
-		/* Wrapped case */
-		if (from_idx >= to_idx && rd_idx >= to_idx && rd_idx < from_idx)
+		/*
+		 * If rd_wrapped_cnt > last_cmd_wrapped_cnt:
+		 * there are a lot of ITS commands posted by
+		 * other cpus and ITS is fast.
+		 *
+		 * If rd_wrapped_cnt < last_cmd_wrapped_cnt:
+		 * ITS is slow, there are some ITS commands
+		 * not finished.
+		 *
+		 * If rd_wrapped_cnt == last_cmd_wrapped_cnt:
+		 * it's common case.
+		 */
+		if (rd_wrapped_cnt > last_cmd_wrapped_cnt) {
+			/*
+			 * There is a lot of ITS commands posted by other cpus,
+			 * it make rd_idx move foward fast and wrap.
+			 */
  			break;
+		} else if (rd_wrapped_cnt == last_cmd_wrapped_cnt) {
+			/* Direct case */
+			if (from_idx < to_idx && rd_idx >= to_idx)
+				break;
+
+			/* Wrapped case */
+			if (from_idx >= to_idx && rd_idx >= to_idx && rd_idx < from_idx)
+				break;
+		}

  		count--;
  		if (!count) {
-			pr_err_ratelimited("ITS queue timeout (%llu %llu %llu)\n",
-					   from_idx, to_idx, rd_idx);
+			pr_err_ratelimited("ITS queue timeout (%llu %llu %llu) %llu %llu\n",
+					   from_idx, to_idx, rd_idx, rd_wrapped_cnt, last_cmd_wrapped_cnt);
  			return -1;
  		}
  		cpu_relax();
@@ -754,6 +799,7 @@ void name(struct its_node *its,						\
  	struct its_cmd_block *cmd, *sync_cmd, *next_cmd;		\
  	synctype *sync_obj;						\
  	unsigned long flags;						\
+	u64 cmd_wrapped_cnt;						\
  									\
  	raw_spin_lock_irqsave(&its->lock, flags);			\
  									\
@@ -776,9 +822,11 @@ void name(struct its_node *its,						\
  									\
  post:									\
  	next_cmd = its_post_commands(its);				\
+	cmd_wrapped_cnt = its->cmd_wrapped_cnt;				\
  	raw_spin_unlock_irqrestore(&its->lock, flags);			\
  									\
-	if (its_wait_for_range_completion(its, cmd, next_cmd))		\
+	if (its_wait_for_range_completion(its, cmd, next_cmd, 		\
+					  cmd_wrapped_cnt))		\
  		pr_err_ratelimited("ITS cmd %ps failed\n", builder);	\
  }

-- 
1.8.3
