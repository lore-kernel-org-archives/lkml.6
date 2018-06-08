Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id BLukAPi/Glu6fAAAmS7hNA
	; Fri, 08 Jun 2018 17:42:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4BC88607E4; Fri,  8 Jun 2018 17:42:34 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GVi1BqaE"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B498F605A5;
	Fri,  8 Jun 2018 17:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B498F605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752775AbeFHRma (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 13:42:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36696 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751694AbeFHRm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 13:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2UZYN8ulbHDW9480iZM+EmI3W97aWs8aF4H/1Xc0A8M=; b=GVi1BqaED0UlRkVQ78ABc8vdD
        36mbxU/JTQfsjBdfnRPk14mwa9k1o/+GJ0yvxatdfkgcyarEDZwAUKFwSb5IPNYh2UrxjnEG0Wry+
        FlGwUIhX6qmSECybrSHeY1papP6+H1IQRlCWwpL99pl2tA/bORdEa5aH9JQUw21sLNvh9VHzTF74j
        p3NZHGaNYZRY6WXYh5Z6Ck6gsZKUJmFeIcVnWQu52c3dDbo6YlFZgtuZ9UkdlV0I3IM1mMbZEnKbX
        gOXXwRa6cQpfAhQkDc9lYz9VJtNgHSGVRWn4akf4WWBLcbtOiSwMTNc5gCI9X6va+NUOw1xx4cA3A
        wpId3K70A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fRLP3-0008TU-BV; Fri, 08 Jun 2018 17:42:21 +0000
From: Matthew Wilcox <willy@infradead.org>
To: hans.westgaard.ry@oracle.com, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc: Matthew Wilcox <mawilcox@microsoft.com>,
        linux-rdma@vger.kernel.org,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        Parav Pandit <parav@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] IB/mad: Agent registration is process context only
Date: Fri,  8 Jun 2018 10:42:17 -0700
Message-Id: <20180608174218.32455-2-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180608174218.32455-1-willy@infradead.org>
References: <20180608174218.32455-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Document this (it's implicitly true due to sleeping operations already
in use in both registration and deregistration).  Use this fact to use
spin_lock_irq instead of spin_lock_irqsave.  This improves performance
slightly.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 drivers/infiniband/core/mad.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index f742ae7a768b..68f4dda916c8 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -190,6 +190,8 @@ EXPORT_SYMBOL(ib_response_mad);
 
 /*
  * ib_register_mad_agent - Register to send/receive MADs
+ *
+ * Context: Process context.
  */
 struct ib_mad_agent *ib_register_mad_agent(struct ib_device *device,
 					   u8 port_num,
@@ -210,7 +212,6 @@ struct ib_mad_agent *ib_register_mad_agent(struct ib_device *device,
 	struct ib_mad_mgmt_vendor_class *vendor_class;
 	struct ib_mad_mgmt_method_table *method;
 	int ret2, qpn;
-	unsigned long flags;
 	u8 mgmt_class, vclass;
 
 	/* Validate parameters */
@@ -376,7 +377,7 @@ struct ib_mad_agent *ib_register_mad_agent(struct ib_device *device,
 		goto error4;
 	}
 
-	spin_lock_irqsave(&port_priv->reg_lock, flags);
+	spin_lock_irq(&port_priv->reg_lock);
 	mad_agent_priv->agent.hi_tid = atomic_inc_return(&ib_mad_client_id);
 
 	/*
@@ -422,11 +423,11 @@ struct ib_mad_agent *ib_register_mad_agent(struct ib_device *device,
 
 	/* Add mad agent into port's agent list */
 	list_add_tail(&mad_agent_priv->agent_list, &port_priv->agent_list);
-	spin_unlock_irqrestore(&port_priv->reg_lock, flags);
+	spin_unlock_irq(&port_priv->reg_lock);
 
 	return &mad_agent_priv->agent;
 error5:
-	spin_unlock_irqrestore(&port_priv->reg_lock, flags);
+	spin_unlock_irq(&port_priv->reg_lock);
 	ib_mad_agent_security_cleanup(&mad_agent_priv->agent);
 error4:
 	kfree(reg_req);
@@ -575,7 +576,6 @@ static inline void deref_snoop_agent(struct ib_mad_snoop_private *mad_snoop_priv
 static void unregister_mad_agent(struct ib_mad_agent_private *mad_agent_priv)
 {
 	struct ib_mad_port_private *port_priv;
-	unsigned long flags;
 
 	/* Note that we could still be handling received MADs */
 
@@ -587,10 +587,10 @@ static void unregister_mad_agent(struct ib_mad_agent_private *mad_agent_priv)
 	port_priv = mad_agent_priv->qp_info->port_priv;
 	cancel_delayed_work(&mad_agent_priv->timed_work);
 
-	spin_lock_irqsave(&port_priv->reg_lock, flags);
+	spin_lock_irq(&port_priv->reg_lock);
 	remove_mad_reg_req(mad_agent_priv);
 	list_del(&mad_agent_priv->agent_list);
-	spin_unlock_irqrestore(&port_priv->reg_lock, flags);
+	spin_unlock_irq(&port_priv->reg_lock);
 
 	flush_workqueue(port_priv->wq);
 	ib_cancel_rmpp_recvs(mad_agent_priv);
@@ -625,6 +625,8 @@ static void unregister_mad_snoop(struct ib_mad_snoop_private *mad_snoop_priv)
 
 /*
  * ib_unregister_mad_agent - Unregisters a client from using MAD services
+ *
+ * Context: Process context.
  */
 void ib_unregister_mad_agent(struct ib_mad_agent *mad_agent)
 {
-- 
2.17.1
