Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 5UaeHa+CGVuMFwAAmS7hNA
	; Thu, 07 Jun 2018 19:08:46 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 85126606DD; Thu,  7 Jun 2018 19:08:46 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KviE1IlL"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BC45B601D2;
	Thu,  7 Jun 2018 19:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BC45B601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932522AbeFGTIl (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 15:08:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50342 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932351AbeFGTIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 15:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LO+Pld7A45unsZVQaQ0DclM68S+B5jpIgvtmzaTHQBU=; b=KviE1IlLXflk/qgKBRg1n8Z2+P
        a2Em5xpnLBOM2DDWxSgRvYjsxK6s+uIIKImuVaLDi86EmOl0wu/kg9xYC+BRhAebLxR6Wcfeqbg82
        am9z6BJIPc0rprv/9rRXGg+WCgxeIG53k9sHgSgYLyPcM865oB/FbpUcQ6CNd3flphVUxYxhqnW93
        4JIkcPo8op13fwdLatMYZsAdWkc02Fa5jIInQ+aLvv3Lt3mn5gB8QJzPUP1K4coFR1w8/z+dkXbv7
        /TvB5Xprj7Hd+1pXheGCnx8lMcF0veLpjldRGl/c+0Ia9LLcv/U7VmN9rn16TCuHBNsY9DoLTAu17
        ZLfsinUQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fR0Gu-0006cT-F1; Thu, 07 Jun 2018 19:08:32 +0000
Date: Thu, 7 Jun 2018 12:08:32 -0700
From: Matthew Wilcox <willy@infradead.org>
To: hans.westgaard.ry@oracle.com, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-rdma@vger.kernel.org,
        =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>,
        Parav Pandit <parav@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC] IB/mad: Use IDR instead of per-port list
Message-ID: <20180607190832.GA24370@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hans reports a bug where the mlx4 driver uses the MSB of the agent number
to store slave number, meaning we can only use agent numbers up to 2^24.
Fix this by using an IDR to assign the agent numbers and also look up the
agent when a MSD packet is received.

I've changed the locking substantially, so this may well have a
performance issue.  There are a few different possibilities for fixing
that, including moving to an RCU-based lookup.


diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index b28452a55a08..611a1f268b07 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -38,6 +38,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/dma-mapping.h>
+#include <linux/idr.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/security.h>
@@ -58,8 +59,8 @@ MODULE_PARM_DESC(send_queue_size, "Size of send queue in number of work requests
 module_param_named(recv_queue_size, mad_recvq_size, int, 0444);
 MODULE_PARM_DESC(recv_queue_size, "Size of receive queue in number of work requests");
 
+static DEFINE_IDR(ib_mad_clients);
 static struct list_head ib_mad_port_list;
-static atomic_t ib_mad_client_id = ATOMIC_INIT(0);
 
 /* Port list lock */
 static DEFINE_SPINLOCK(ib_mad_port_list_lock);
@@ -376,8 +377,16 @@ struct ib_mad_agent *ib_register_mad_agent(struct ib_device *device,
 		goto error4;
 	}
 
-	spin_lock_irqsave(&port_priv->reg_lock, flags);
-	mad_agent_priv->agent.hi_tid = atomic_inc_return(&ib_mad_client_id);
+	idr_preload(GFP_KERNEL);
+	idr_lock_irqsave(&ib_mad_clients, flags);
+
+	ret2 = idr_alloc_cyclic(&ib_mad_clients, mad_agent_priv, 0,
+			(1 << 24), GFP_ATOMIC);
+	if (ret2 < 0) {
+		ret = ERR_PTR(ret2);
+		goto error5;
+	}
+	mad_agent_priv->agent.hi_tid = ret2;
 
 	/*
 	 * Make sure MAD registration (if supplied)
@@ -393,7 +402,7 @@ struct ib_mad_agent *ib_register_mad_agent(struct ib_device *device,
 				if (method) {
 					if (method_in_use(&method,
 							   mad_reg_req))
-						goto error5;
+						goto error6;
 				}
 			}
 			ret2 = add_nonoui_reg_req(mad_reg_req, mad_agent_priv,
@@ -409,24 +418,26 @@ struct ib_mad_agent *ib_register_mad_agent(struct ib_device *device,
 					if (is_vendor_method_in_use(
 							vendor_class,
 							mad_reg_req))
-						goto error5;
+						goto error6;
 				}
 			}
 			ret2 = add_oui_reg_req(mad_reg_req, mad_agent_priv);
 		}
 		if (ret2) {
 			ret = ERR_PTR(ret2);
-			goto error5;
+			goto error6;
 		}
 	}
 
-	/* Add mad agent into port's agent list */
-	list_add_tail(&mad_agent_priv->agent_list, &port_priv->agent_list);
-	spin_unlock_irqrestore(&port_priv->reg_lock, flags);
+	idr_unlock_irqrestore(&ib_mad_clients, flags);
+	idr_preload_end();
 
 	return &mad_agent_priv->agent;
+error6:
+	idr_remove(&ib_mad_clients, mad_agent_priv->agent.hi_tid);
 error5:
-	spin_unlock_irqrestore(&port_priv->reg_lock, flags);
+	idr_unlock_irqrestore(&ib_mad_clients, flags);
+	idr_preload_end();
 	ib_mad_agent_security_cleanup(&mad_agent_priv->agent);
 error4:
 	kfree(reg_req);
@@ -587,10 +598,10 @@ static void unregister_mad_agent(struct ib_mad_agent_private *mad_agent_priv)
 	port_priv = mad_agent_priv->qp_info->port_priv;
 	cancel_delayed_work(&mad_agent_priv->timed_work);
 
-	spin_lock_irqsave(&port_priv->reg_lock, flags);
+	idr_lock_irqsave(&ib_mad_clients, flags);
 	remove_mad_reg_req(mad_agent_priv);
-	list_del(&mad_agent_priv->agent_list);
-	spin_unlock_irqrestore(&port_priv->reg_lock, flags);
+	idr_remove(&ib_mad_clients, mad_agent_priv->agent.hi_tid);
+	idr_unlock_irqrestore(&ib_mad_clients, flags);
 
 	flush_workqueue(port_priv->wq);
 	ib_cancel_rmpp_recvs(mad_agent_priv);
@@ -1718,22 +1729,16 @@ find_mad_agent(struct ib_mad_port_private *port_priv,
 	struct ib_mad_agent_private *mad_agent = NULL;
 	unsigned long flags;
 
-	spin_lock_irqsave(&port_priv->reg_lock, flags);
+	idr_lock_irqsave(&ib_mad_clients, flags);
 	if (ib_response_mad(mad_hdr)) {
 		u32 hi_tid;
-		struct ib_mad_agent_private *entry;
 
 		/*
 		 * Routing is based on high 32 bits of transaction ID
 		 * of MAD.
 		 */
 		hi_tid = be64_to_cpu(mad_hdr->tid) >> 32;
-		list_for_each_entry(entry, &port_priv->agent_list, agent_list) {
-			if (entry->agent.hi_tid == hi_tid) {
-				mad_agent = entry;
-				break;
-			}
-		}
+		mad_agent = idr_find(&ib_mad_clients, hi_tid);
 	} else {
 		struct ib_mad_mgmt_class_table *class;
 		struct ib_mad_mgmt_method_table *method;
@@ -1794,7 +1799,7 @@ find_mad_agent(struct ib_mad_port_private *port_priv,
 		}
 	}
 out:
-	spin_unlock_irqrestore(&port_priv->reg_lock, flags);
+	idr_unlock_irqrestore(&ib_mad_clients, flags);
 
 	return mad_agent;
 }
@@ -3156,8 +3161,6 @@ static int ib_mad_port_open(struct ib_device *device,
 
 	port_priv->device = device;
 	port_priv->port_num = port_num;
-	spin_lock_init(&port_priv->reg_lock);
-	INIT_LIST_HEAD(&port_priv->agent_list);
 	init_mad_qp(port_priv, &port_priv->qp_info[0]);
 	init_mad_qp(port_priv, &port_priv->qp_info[1]);
 
@@ -3336,6 +3339,9 @@ int ib_mad_init(void)
 
 	INIT_LIST_HEAD(&ib_mad_port_list);
 
+	/* Client ID 0 is used for snoop-only clients */
+	idr_alloc(&ib_mad_clients, NULL, 0, 0, GFP_KERNEL);
+
 	if (ib_register_client(&mad_client)) {
 		pr_err("Couldn't register ib_mad client\n");
 		return -EINVAL;
diff --git a/drivers/infiniband/core/mad_priv.h b/drivers/infiniband/core/mad_priv.h
index 28669f6419e1..f2cb2eea7d42 100644
--- a/drivers/infiniband/core/mad_priv.h
+++ b/drivers/infiniband/core/mad_priv.h
@@ -89,7 +89,6 @@ struct ib_rmpp_segment {
 };
 
 struct ib_mad_agent_private {
-	struct list_head agent_list;
 	struct ib_mad_agent agent;
 	struct ib_mad_reg_req *reg_req;
 	struct ib_mad_qp_info *qp_info;
@@ -201,9 +200,7 @@ struct ib_mad_port_private {
 	struct ib_cq *cq;
 	struct ib_pd *pd;
 
-	spinlock_t reg_lock;
 	struct ib_mad_mgmt_version_table version[MAX_MGMT_VERSION];
-	struct list_head agent_list;
 	struct workqueue_struct *wq;
 	struct ib_mad_qp_info qp_info[IB_MAD_QPS_CORE];
 };
diff --git a/include/linux/idr.h b/include/linux/idr.h
index e856f4e0ab35..97b4924f0bca 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -81,6 +81,11 @@ static inline void idr_set_cursor(struct idr *idr, unsigned int val)
 	WRITE_ONCE(idr->idr_next, val);
 }
 
+#define idr_lock_irqsave(idr, flags) \
+				xa_lock_irqsave(&(idr)->idr_rt, flags)
+#define idr_unlock_irqrestore(idr, flags) \
+				xa_unlock_irqrestore(&(idr)->idr_rt, flags)
+
 /**
  * DOC: idr sync
  * idr synchronization (stolen from radix-tree.h)
