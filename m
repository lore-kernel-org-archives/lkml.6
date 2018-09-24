Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673F5ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23ADB21486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23ADB21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387963AbeIXSfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:35:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58378 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728153AbeIXSfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:35:39 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0D94C1018;
        Mon, 24 Sep 2018 12:33:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Corey Minyard <cminyard@mvista.com>,
        Justin Ernst <justin.ernst@hpe.com>,
        Andrew Banman <abanman@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: [PATCH 4.18 105/235] ipmi: Rework SMI registration failure
Date:   Mon, 24 Sep 2018 13:51:31 +0200
Message-Id: <20180924113116.082902353@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Corey Minyard <cminyard@mvista.com>

commit 2512e40e48d21d8bac09f7e91d2c3ceb2d3b50b2 upstream.

There were certain situations where ipmi_register_smi() would
return a failure, but the interface would still be registered
and would need to be unregistered.  This is obviously a bad
design and resulted in an oops in certain failure cases.

If the interface is started up in ipmi_register_smi(), then
an error occurs, shut down the interface there so the
cleanup can be done properly.

Fix the various smi users, too.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Reported-by: Justin Ernst <justin.ernst@hpe.com>
Tested-by: Justin Ernst <justin.ernst@hpe.com>
Cc: Andrew Banman <abanman@hpe.com>
Cc: Russ Anderson <russ.anderson@hpe.com>
Cc: <stable@vger.kernel.org> # 4.18.x
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/ipmi/ipmi_msghandler.c |   53 ++++++++++++++++++++----------------
 drivers/char/ipmi/ipmi_si_intf.c    |   17 ++---------
 drivers/char/ipmi/ipmi_ssif.c       |   13 ++------
 3 files changed, 37 insertions(+), 46 deletions(-)

--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -3381,39 +3381,45 @@ int ipmi_register_smi(const struct ipmi_
 
 	rv = handlers->start_processing(send_info, intf);
 	if (rv)
-		goto out;
+		goto out_err;
 
 	rv = __bmc_get_device_id(intf, NULL, &id, NULL, NULL, i);
 	if (rv) {
 		dev_err(si_dev, "Unable to get the device id: %d\n", rv);
-		goto out;
+		goto out_err_started;
 	}
 
 	mutex_lock(&intf->bmc_reg_mutex);
 	rv = __scan_channels(intf, &id);
 	mutex_unlock(&intf->bmc_reg_mutex);
+	if (rv)
+		goto out_err_bmc_reg;
 
- out:
-	if (rv) {
-		ipmi_bmc_unregister(intf);
-		list_del_rcu(&intf->link);
-		mutex_unlock(&ipmi_interfaces_mutex);
-		synchronize_srcu(&ipmi_interfaces_srcu);
-		cleanup_srcu_struct(&intf->users_srcu);
-		kref_put(&intf->refcount, intf_free);
-	} else {
-		/*
-		 * Keep memory order straight for RCU readers.  Make
-		 * sure everything else is committed to memory before
-		 * setting intf_num to mark the interface valid.
-		 */
-		smp_wmb();
-		intf->intf_num = i;
-		mutex_unlock(&ipmi_interfaces_mutex);
+	/*
+	 * Keep memory order straight for RCU readers.  Make
+	 * sure everything else is committed to memory before
+	 * setting intf_num to mark the interface valid.
+	 */
+	smp_wmb();
+	intf->intf_num = i;
+	mutex_unlock(&ipmi_interfaces_mutex);
 
-		/* After this point the interface is legal to use. */
-		call_smi_watchers(i, intf->si_dev);
-	}
+	/* After this point the interface is legal to use. */
+	call_smi_watchers(i, intf->si_dev);
+
+	return 0;
+
+ out_err_bmc_reg:
+	ipmi_bmc_unregister(intf);
+ out_err_started:
+	if (intf->handlers->shutdown)
+		intf->handlers->shutdown(intf->send_info);
+ out_err:
+	list_del_rcu(&intf->link);
+	mutex_unlock(&ipmi_interfaces_mutex);
+	synchronize_srcu(&ipmi_interfaces_srcu);
+	cleanup_srcu_struct(&intf->users_srcu);
+	kref_put(&intf->refcount, intf_free);
 
 	return rv;
 }
@@ -3504,7 +3510,8 @@ void ipmi_unregister_smi(struct ipmi_smi
 	}
 	srcu_read_unlock(&intf->users_srcu, index);
 
-	intf->handlers->shutdown(intf->send_info);
+	if (intf->handlers->shutdown)
+		intf->handlers->shutdown(intf->send_info);
 
 	cleanup_smi_msgs(intf);
 
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -2083,18 +2083,9 @@ static int try_smi_init(struct smi_info
 		 si_to_str[new_smi->io.si_type]);
 
 	WARN_ON(new_smi->io.dev->init_name != NULL);
-	kfree(init_name);
-
-	return 0;
-
-out_err:
-	if (new_smi->intf) {
-		ipmi_unregister_smi(new_smi->intf);
-		new_smi->intf = NULL;
-	}
 
+ out_err:
 	kfree(init_name);
-
 	return rv;
 }
 
@@ -2227,6 +2218,8 @@ static void shutdown_smi(void *send_info
 
 	kfree(smi_info->si_sm);
 	smi_info->si_sm = NULL;
+
+	smi_info->intf = NULL;
 }
 
 /*
@@ -2240,10 +2233,8 @@ static void cleanup_one_si(struct smi_in
 
 	list_del(&smi_info->link);
 
-	if (smi_info->intf) {
+	if (smi_info->intf)
 		ipmi_unregister_smi(smi_info->intf);
-		smi_info->intf = NULL;
-	}
 
 	if (smi_info->pdev) {
 		if (smi_info->pdev_registered)
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1214,18 +1214,11 @@ static void shutdown_ssif(void *send_inf
 		complete(&ssif_info->wake_thread);
 		kthread_stop(ssif_info->thread);
 	}
-
-	/*
-	 * No message can be outstanding now, we have removed the
-	 * upper layer and it permitted us to do so.
-	 */
-	kfree(ssif_info);
 }
 
 static int ssif_remove(struct i2c_client *client)
 {
 	struct ssif_info *ssif_info = i2c_get_clientdata(client);
-	struct ipmi_smi *intf;
 	struct ssif_addr_info *addr_info;
 
 	if (!ssif_info)
@@ -1235,9 +1228,7 @@ static int ssif_remove(struct i2c_client
 	 * After this point, we won't deliver anything asychronously
 	 * to the message handler.  We can unregister ourself.
 	 */
-	intf = ssif_info->intf;
-	ssif_info->intf = NULL;
-	ipmi_unregister_smi(intf);
+	ipmi_unregister_smi(ssif_info->intf);
 
 	list_for_each_entry(addr_info, &ssif_infos, link) {
 		if (addr_info->client == client) {
@@ -1246,6 +1237,8 @@ static int ssif_remove(struct i2c_client
 		}
 	}
 
+	kfree(ssif_info);
+
 	return 0;
 }
 


