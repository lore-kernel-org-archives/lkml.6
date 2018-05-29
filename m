Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033617AbeE2CFN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 22:05:13 -0400
Received: from gate.crashing.org ([63.228.1.57]:60870 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937736AbeE2CFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 22:05:11 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Christopher Bostic <cbostic@linux.vnet.ibm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 01/15] fsi: gpio: Trace busy count
Date: Tue, 29 May 2018 11:30:30 +1000
Message-Id: <20180529013044.23815-2-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180529013044.23815-1-benh@kernel.crashing.org>
References: <20180529013044.23815-1-benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Jeffery <andrew@aj.id.au>

An observation from trace output of the existing FSI tracepoints was
that the remote device was sometimes reporting as busy. Add a new
tracepoint reporting the busy count in order to get a better grip on how
often this is the case.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Acked-by: Eddie James <eajames@linux.vnet.ibm.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/fsi/fsi-master-gpio.c          |  3 +++
 include/trace/events/fsi_master_gpio.h | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
index 3f487449a277..2a49b167effe 100644
--- a/drivers/fsi/fsi-master-gpio.c
+++ b/drivers/fsi/fsi-master-gpio.c
@@ -401,6 +401,9 @@ static int poll_for_response(struct fsi_master_gpio *master,
 		break;
 	}
 
+	if (busy_count > 0)
+		trace_fsi_master_gpio_poll_response_busy(master, busy_count);
+
 	/* Clock the slave enough to be ready for next operation */
 	clock_zeros(master, FSI_GPIO_PRIME_SLAVE_CLOCKS);
 	return rc;
diff --git a/include/trace/events/fsi_master_gpio.h b/include/trace/events/fsi_master_gpio.h
index f95cf3264bf9..33e928c5acf3 100644
--- a/include/trace/events/fsi_master_gpio.h
+++ b/include/trace/events/fsi_master_gpio.h
@@ -64,6 +64,22 @@ TRACE_EVENT(fsi_master_gpio_break,
 	)
 );
 
+
+TRACE_EVENT(fsi_master_gpio_poll_response_busy,
+	TP_PROTO(const struct fsi_master_gpio *master, int busy),
+	TP_ARGS(master, busy),
+	TP_STRUCT__entry(
+		__field(int,	master_idx)
+		__field(int,	busy)
+	),
+	TP_fast_assign(
+		__entry->master_idx = master->master.idx;
+		__entry->busy = busy;
+	),
+	TP_printk("fsi-gpio%d: device reported busy %d times",
+		__entry->master_idx, __entry->busy)
+);
+
 #endif /* _TRACE_FSI_MASTER_GPIO_H */
 
 #include <trace/define_trace.h>
-- 
2.17.0
