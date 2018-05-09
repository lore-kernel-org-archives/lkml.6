Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965018AbeEIPQF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:16:05 -0400
Received: from smtprelay0128.hostedemail.com ([216.40.44.128]:40378 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S964995AbeEIPQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:16:01 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:2:41:69:355:379:541:800:960:966:968:973:988:989:1042:1260:1345:1359:1437:1535:1605:1730:1747:1777:1792:2196:2198:2199:2200:2393:2538:2559:2562:2892:2902:3138:3139:3140:3141:3142:3865:3866:3867:3868:3870:3871:3872:4050:4119:4250:4321:4384:4385:4395:5007:6119:6261:7903:8784:8957:9153:9592:10004:10848:11026:11232:11473:11658:11914:12043:12296:12438:12555:12679:12683:12895:13972:14394:21080:21212:21324:21433:21451:21611:21627:21740:30012:30019:30051:30054:30067:30070:30075:30080,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:22,LUA_SUMMARY:none
X-HE-Tag: coast68_8bad99c2fd916
X-Filterd-Recvd-Size: 8788
From: Joe Perches <joe@perches.com>
To: Corey Minyard <minyard@acm.org>
Cc: x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] ipmi: msghandler: Add and use pr_fmt and dev_fmt, remove PFX
Date: Wed,  9 May 2018 08:15:47 -0700
Message-Id: <7d811e7a91743911469514c9e76ebc3c94336f91.1525878372.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1525878372.git.joe@perches.com>
References: <cover.1525878372.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Standardize the prefixing of output messages using the pr_fmt and dev_fmt
mechanisms instead of a separate #define PFX

Miscellanea:

o Because this message prefix is very long, use a non-standard define
  of #define pr_fmt(fmt) "%s" fmt, "IPMI message handler: "
  which removes ~170 bytes of object code in an x86-64 defconfig with ipmi
  (with even more object code reduction on 32 bit compilations)

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 53 +++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 28 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 946bfcb1eeee..db81f1e51bb9 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -11,6 +11,9 @@
  * Copyright 2002 MontaVista Software Inc.
  */
 
+#define pr_fmt(fmt) "%s" fmt, "IPMI message handler: "
+#define dev_fmt pr_fmt
+
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/poll.h>
@@ -30,8 +33,6 @@
 #include <linux/workqueue.h>
 #include <linux/uuid.h>
 
-#define PFX "IPMI message handler: "
-
 #define IPMI_DRIVER_VERSION "39.2"
 
 static struct ipmi_recv_msg *ipmi_alloc_recv_msg(void);
@@ -1490,8 +1491,7 @@ int ipmi_set_gets_events(struct ipmi_user *user, bool val)
 			list_move_tail(&msg->link, &msgs);
 		intf->waiting_events_count = 0;
 		if (intf->event_msg_printed) {
-			dev_warn(intf->si_dev,
-				 PFX "Event queue no longer full\n");
+			dev_warn(intf->si_dev, "Event queue no longer full\n");
 			intf->event_msg_printed = 0;
 		}
 
@@ -2289,16 +2289,15 @@ static void bmc_device_id_handler(struct ipmi_smi *intf,
 			|| (msg->msg.netfn != IPMI_NETFN_APP_RESPONSE)
 			|| (msg->msg.cmd != IPMI_GET_DEVICE_ID_CMD)) {
 		dev_warn(intf->si_dev,
-			 PFX "invalid device_id msg: addr_type=%d netfn=%x cmd=%x\n",
-			msg->addr.addr_type, msg->msg.netfn, msg->msg.cmd);
+			 "invalid device_id msg: addr_type=%d netfn=%x cmd=%x\n",
+			 msg->addr.addr_type, msg->msg.netfn, msg->msg.cmd);
 		return;
 	}
 
 	rv = ipmi_demangle_device_id(msg->msg.netfn, msg->msg.cmd,
 			msg->msg.data, msg->msg.data_len, &intf->bmc->fetch_id);
 	if (rv) {
-		dev_warn(intf->si_dev,
-			 PFX "device id demangle failed: %d\n", rv);
+		dev_warn(intf->si_dev, "device id demangle failed: %d\n", rv);
 		intf->bmc->dyn_id_set = 0;
 	} else {
 		/*
@@ -3131,8 +3130,7 @@ static int __ipmi_bmc_register(struct ipmi_smi *intf,
 		mutex_unlock(&bmc->dyn_mutex);
 
 		dev_info(intf->si_dev,
-			 "ipmi: interfacing existing BMC (man_id: 0x%6.6x,"
-			 " prod_id: 0x%4.4x, dev_id: 0x%2.2x)\n",
+			 "interfacing existing BMC (man_id: 0x%6.6x, prod_id: 0x%4.4x, dev_id: 0x%2.2x)\n",
 			 bmc->id.manufacturer_id,
 			 bmc->id.product_id,
 			 bmc->id.device_id);
@@ -3171,7 +3169,7 @@ static int __ipmi_bmc_register(struct ipmi_smi *intf,
 		rv = platform_device_register(&bmc->pdev);
 		if (rv) {
 			dev_err(intf->si_dev,
-				PFX " Unable to register bmc device: %d\n",
+				"Unable to register bmc device: %d\n",
 				rv);
 			goto out_list_del;
 		}
@@ -3189,8 +3187,7 @@ static int __ipmi_bmc_register(struct ipmi_smi *intf,
 	 */
 	rv = sysfs_create_link(&intf->si_dev->kobj, &bmc->pdev.dev.kobj, "bmc");
 	if (rv) {
-		dev_err(intf->si_dev,
-			PFX "Unable to create bmc symlink: %d\n", rv);
+		dev_err(intf->si_dev, "Unable to create bmc symlink: %d\n", rv);
 		goto out_put_bmc;
 	}
 
@@ -3199,8 +3196,8 @@ static int __ipmi_bmc_register(struct ipmi_smi *intf,
 	intf->my_dev_name = kasprintf(GFP_KERNEL, "ipmi%d", intf_num);
 	if (!intf->my_dev_name) {
 		rv = -ENOMEM;
-		dev_err(intf->si_dev,
-			PFX "Unable to allocate link from BMC: %d\n", rv);
+		dev_err(intf->si_dev, "Unable to allocate link from BMC: %d\n",
+			rv);
 		goto out_unlink1;
 	}
 
@@ -3209,8 +3206,8 @@ static int __ipmi_bmc_register(struct ipmi_smi *intf,
 	if (rv) {
 		kfree(intf->my_dev_name);
 		intf->my_dev_name = NULL;
-		dev_err(intf->si_dev,
-			PFX "Unable to create symlink to bmc: %d\n", rv);
+		dev_err(intf->si_dev, "Unable to create symlink to bmc: %d\n",
+			rv);
 		goto out_free_my_dev_name;
 	}
 
@@ -3294,7 +3291,7 @@ static void guid_handler(struct ipmi_smi *intf, struct ipmi_recv_msg *msg)
 	if (msg->msg.data_len < 17) {
 		bmc->dyn_guid_set = 0;
 		dev_warn(intf->si_dev,
-			 PFX "The GUID response from the BMC was too short, it was %d but should have been 17.  Assuming GUID is not available.\n",
+			 "The GUID response from the BMC was too short, it was %d but should have been 17.  Assuming GUID is not available.\n",
 			 msg->msg.data_len);
 		goto out;
 	}
@@ -3418,7 +3415,7 @@ channel_handler(struct ipmi_smi *intf, struct ipmi_recv_msg *msg)
 		if (rv) {
 			/* Got an error somehow, just give up. */
 			dev_warn(intf->si_dev,
-				 PFX "Error sending channel information for channel %d: %d\n",
+				 "Error sending channel information for channel %d: %d\n",
 				 intf->curr_channel, rv);
 
 			intf->channel_list = intf->wchannels + set;
@@ -4311,7 +4308,7 @@ static int handle_read_event_rsp(struct ipmi_smi *intf,
 		 * message.
 		 */
 		dev_warn(intf->si_dev,
-			 PFX "Event queue full, discarding incoming events\n");
+			 "Event queue full, discarding incoming events\n");
 		intf->event_msg_printed = 1;
 	}
 
@@ -4330,7 +4327,7 @@ static int handle_bmc_rsp(struct ipmi_smi *intf,
 	recv_msg = (struct ipmi_recv_msg *) msg->user_data;
 	if (recv_msg == NULL) {
 		dev_warn(intf->si_dev,
-			 "IPMI message received with no owner. This could be because of a malformed message, or because of a hardware error.  Contact your hardware vender for assistance\n");
+			 "IPMI message received with no owner. This could be because of a malformed message, or because of a hardware error.  Contact your hardware vendor for assistance.\n");
 		return 0;
 	}
 
@@ -4366,7 +4363,7 @@ static int handle_one_recv_msg(struct ipmi_smi *intf,
 	if (msg->rsp_size < 2) {
 		/* Message is too small to be correct. */
 		dev_warn(intf->si_dev,
-			 PFX "BMC returned to small a message for netfn %x cmd %x, got %d bytes\n",
+			 "BMC returned too small a message for netfn %x cmd %x, got %d bytes\n",
 			 (msg->data[0] >> 2) | 1, msg->data[1], msg->rsp_size);
 
 		/* Generate an error response for the message. */
@@ -4381,7 +4378,7 @@ static int handle_one_recv_msg(struct ipmi_smi *intf,
 		 * marginally correct.
 		 */
 		dev_warn(intf->si_dev,
-			 PFX "BMC returned incorrect response, expected netfn %x cmd %x, got netfn %x cmd %x\n",
+			 "BMC returned incorrect response, expected netfn %x cmd %x, got netfn %x cmd %x\n",
 			 (msg->data[0] >> 2) | 1, msg->data[1],
 			 msg->rsp[0] >> 2, msg->rsp[1]);
 
@@ -5271,16 +5268,16 @@ static int ipmi_init_msghandler(void)
 
 	rv = driver_register(&ipmidriver.driver);
 	if (rv) {
-		pr_err(PFX "Could not register IPMI driver\n");
+		pr_err("Could not register IPMI driver\n");
 		return rv;
 	}
 
-	pr_info("ipmi message handler version " IPMI_DRIVER_VERSION "\n");
+	pr_info("version %s\n", IPMI_DRIVER_VERSION);
 
 #ifdef CONFIG_IPMI_PROC_INTERFACE
 	proc_ipmi_root = proc_mkdir("ipmi", NULL);
 	if (!proc_ipmi_root) {
-	    pr_err(PFX "Unable to create IPMI proc dir");
+	    pr_err("Unable to create IPMI proc dir\n");
 	    driver_unregister(&ipmidriver.driver);
 	    return -ENOMEM;
 	}
@@ -5336,10 +5333,10 @@ static void __exit cleanup_ipmi(void)
 	/* Check for buffer leaks. */
 	count = atomic_read(&smi_msg_inuse_count);
 	if (count != 0)
-		pr_warn(PFX "SMI message count %d at exit\n", count);
+		pr_warn("SMI message count %d at exit\n", count);
 	count = atomic_read(&recv_msg_inuse_count);
 	if (count != 0)
-		pr_warn(PFX "recv message count %d at exit\n", count);
+		pr_warn("recv message count %d at exit\n", count);
 }
 module_exit(cleanup_ipmi);
 
-- 
2.15.0
