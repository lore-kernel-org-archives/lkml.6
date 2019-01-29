Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC950C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC648214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762155;
	bh=kajCHNDTU5MsoF2Jr/z3Uc082cuC+brgVOlZzfOwyUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jXbxwMQQ591y2R+tt/ffgvyHxBh6OKqh98EuyKhNrlI4aA8o0bXAL4dx2SuyA+nZv
	 2PL+HCnQxdX69Wc+g6/mOe7GjBxEaU9e6e1YID9sizqK2+CdGn6NTY5fdoCbLb/cdB
	 dxbNiVOiMFkhwDknxq0wSFSjfpbcsu8CXtjucEPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbfA2Lme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:42:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:60168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728740AbfA2Lm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:42:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0EEF214DA;
        Tue, 29 Jan 2019 11:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762146;
        bh=kajCHNDTU5MsoF2Jr/z3Uc082cuC+brgVOlZzfOwyUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z59eVkIxnTkkBaJc5B5O5r5YlANvx4lBIXxLw4+TUEhtsmrJNZoPlqv3BXrMUW7+q
         PtuvC/RU2Bg7fE8ANpFx2gzj8c2UxXWfFQ9ihy3PYOxZhtylLvsEFTrbh7eAXomGTG
         Qcl2dORzE/scUZNZmOpcWc87tlbQSwF20wFayMhA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Long Li <longli@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 106/117] Drivers: hv: vmbus: Remove the useless API vmbus_get_outgoing_channel()
Date:   Tue, 29 Jan 2019 12:35:57 +0100
Message-Id: <20190129113212.669957607@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 4d3c5c69191f98c7f7e699ff08d2fd96d7070ddb ]

Commit d86adf482b84 ("scsi: storvsc: Enable multi-queue support") removed
the usage of the API in Jan 2017, and the API is not used since then.

netvsc and storvsc have their own algorithms to determine the outgoing
channel, so this API is useless.

And the API is potentially unsafe, because it reads primary->num_sc without
any lock held. This can be risky considering the RESCIND-OFFER message.

Let's remove the API.

Cc: Long Li <longli@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hv/channel.c      |  1 -
 drivers/hv/channel_mgmt.c | 44 ---------------------------------------
 include/linux/hyperv.h    | 17 ---------------
 3 files changed, 62 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index fe00b12e4417..ce0ba2062723 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -711,7 +711,6 @@ int vmbus_disconnect_ring(struct vmbus_channel *channel)
 	/* Snapshot the list of subchannels */
 	spin_lock_irqsave(&channel->lock, flags);
 	list_splice_init(&channel->sc_list, &list);
-	channel->num_sc = 0;
 	spin_unlock_irqrestore(&channel->lock, flags);
 
 	list_for_each_entry_safe(cur_channel, tmp, &list, sc_list) {
diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index edd34c167a9b..d01689079e9b 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -405,7 +405,6 @@ void hv_process_channel_removal(struct vmbus_channel *channel)
 		primary_channel = channel->primary_channel;
 		spin_lock_irqsave(&primary_channel->lock, flags);
 		list_del(&channel->sc_list);
-		primary_channel->num_sc--;
 		spin_unlock_irqrestore(&primary_channel->lock, flags);
 	}
 
@@ -1302,49 +1301,6 @@ int vmbus_request_offers(void)
 	return ret;
 }
 
-/*
- * Retrieve the (sub) channel on which to send an outgoing request.
- * When a primary channel has multiple sub-channels, we try to
- * distribute the load equally amongst all available channels.
- */
-struct vmbus_channel *vmbus_get_outgoing_channel(struct vmbus_channel *primary)
-{
-	struct list_head *cur, *tmp;
-	int cur_cpu;
-	struct vmbus_channel *cur_channel;
-	struct vmbus_channel *outgoing_channel = primary;
-	int next_channel;
-	int i = 1;
-
-	if (list_empty(&primary->sc_list))
-		return outgoing_channel;
-
-	next_channel = primary->next_oc++;
-
-	if (next_channel > (primary->num_sc)) {
-		primary->next_oc = 0;
-		return outgoing_channel;
-	}
-
-	cur_cpu = hv_cpu_number_to_vp_number(smp_processor_id());
-	list_for_each_safe(cur, tmp, &primary->sc_list) {
-		cur_channel = list_entry(cur, struct vmbus_channel, sc_list);
-		if (cur_channel->state != CHANNEL_OPENED_STATE)
-			continue;
-
-		if (cur_channel->target_vp == cur_cpu)
-			return cur_channel;
-
-		if (i == next_channel)
-			return cur_channel;
-
-		i++;
-	}
-
-	return outgoing_channel;
-}
-EXPORT_SYMBOL_GPL(vmbus_get_outgoing_channel);
-
 static void invoke_sc_cb(struct vmbus_channel *primary_channel)
 {
 	struct list_head *cur, *tmp;
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index ed74888087f1..dcb6977afce9 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -830,15 +830,6 @@ struct vmbus_channel {
 	 * All Sub-channels of a primary channel are linked here.
 	 */
 	struct list_head sc_list;
-	/*
-	 * Current number of sub-channels.
-	 */
-	int num_sc;
-	/*
-	 * Number of a sub-channel (position within sc_list) which is supposed
-	 * to be used as the next outgoing channel.
-	 */
-	int next_oc;
 	/*
 	 * The primary channel this sub-channel belongs to.
 	 * This will be NULL for the primary channel.
@@ -972,14 +963,6 @@ void vmbus_set_sc_create_callback(struct vmbus_channel *primary_channel,
 void vmbus_set_chn_rescind_callback(struct vmbus_channel *channel,
 		void (*chn_rescind_cb)(struct vmbus_channel *));
 
-/*
- * Retrieve the (sub) channel on which to send an outgoing request.
- * When a primary channel has multiple sub-channels, we choose a
- * channel whose VCPU binding is closest to the VCPU on which
- * this call is being made.
- */
-struct vmbus_channel *vmbus_get_outgoing_channel(struct vmbus_channel *primary);
-
 /*
  * Check if sub-channels have already been offerred. This API will be useful
  * when the driver is unloaded after establishing sub-channels. In this case,
-- 
2.19.1



