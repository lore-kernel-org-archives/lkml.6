Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A523C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF3420663
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359070;
	bh=NzJq5QG4ODKiMPyiHkGDEEQmktF9v3ybVAmfp8q08iE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2F8CDJuyyGIocCXDo0aB+1b0PwEvT36tIG1htN7SICRqD2h1v5/f3jj0xa8Hw7Oys
	 y4EILayh2gsevADRqgi+wUtxFkSSrUNejdegbXKuddlPLVq0ehmPRIfJSpooaPGFH2
	 26/I9O26exjP4qy5gqEyJSayaK+6UBfz66oLEZ1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731208AbfAXTo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:44:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:45228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733283AbfAXTo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:44:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBAF1218D4;
        Thu, 24 Jan 2019 19:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548359065;
        bh=NzJq5QG4ODKiMPyiHkGDEEQmktF9v3ybVAmfp8q08iE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=twey7DF7IBWjQMtFo4vzYxU5PqrwQn5mHkm1I+2vr5dKpbO6GUcDXvMaPim7Qt6Tu
         XTsWTFs+tus1jFuE0pUSZgdnLEcMJNArRk5G7A2uF+TA5wV5k8eBp4xopAXJ1ilvR3
         1yPfpkYcqn/1EX3/L1rCbhjgT+VZStyT+88wXbaQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Corey Minyard <cminyard@mvista.com>,
        Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH 4.20 124/127] ipmi: Dont initialize anything in the core until something uses it
Date:   Thu, 24 Jan 2019 20:21:10 +0100
Message-Id: <20190124190217.196045864@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
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

From: Corey Minyard <cminyard@mvista.com>

commit 913a89f009d98c85a902d718cd54bb32ab11d167 upstream.

The IPMI driver was recently modified to use SRCU, but it turns out
this uses a chunk of percpu memory, even if IPMI is never used.

So modify thing to on initialize on the first use.  There was already
code to sort of handle this for handling init races, so piggy back
on top of that, and simplify it in the process.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Reported-by: Tejun Heo <tj@kernel.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org # 4.18
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/ipmi/ipmi_msghandler.c |  143 ++++++++++++++++++++----------------
 1 file changed, 80 insertions(+), 63 deletions(-)

--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -62,7 +62,8 @@ static void ipmi_debug_msg(const char *t
 { }
 #endif
 
-static int initialized;
+static bool initialized;
+static bool drvregistered;
 
 enum ipmi_panic_event_op {
 	IPMI_SEND_PANIC_EVENT_NONE,
@@ -612,7 +613,7 @@ static DEFINE_MUTEX(ipmidriver_mutex);
 
 static LIST_HEAD(ipmi_interfaces);
 static DEFINE_MUTEX(ipmi_interfaces_mutex);
-DEFINE_STATIC_SRCU(ipmi_interfaces_srcu);
+struct srcu_struct ipmi_interfaces_srcu;
 
 /*
  * List of watchers that want to know when smi's are added and deleted.
@@ -720,7 +721,15 @@ struct watcher_entry {
 int ipmi_smi_watcher_register(struct ipmi_smi_watcher *watcher)
 {
 	struct ipmi_smi *intf;
-	int index;
+	int index, rv;
+
+	/*
+	 * Make sure the driver is actually initialized, this handles
+	 * problems with initialization order.
+	 */
+	rv = ipmi_init_msghandler();
+	if (rv)
+		return rv;
 
 	mutex_lock(&smi_watchers_mutex);
 
@@ -1076,7 +1085,7 @@ int ipmi_create_user(unsigned int
 {
 	unsigned long flags;
 	struct ipmi_user *new_user;
-	int           rv = 0, index;
+	int           rv, index;
 	struct ipmi_smi *intf;
 
 	/*
@@ -1094,18 +1103,9 @@ int ipmi_create_user(unsigned int
 	 * Make sure the driver is actually initialized, this handles
 	 * problems with initialization order.
 	 */
-	if (!initialized) {
-		rv = ipmi_init_msghandler();
-		if (rv)
-			return rv;
-
-		/*
-		 * The init code doesn't return an error if it was turned
-		 * off, but it won't initialize.  Check that.
-		 */
-		if (!initialized)
-			return -ENODEV;
-	}
+	rv = ipmi_init_msghandler();
+	if (rv)
+		return rv;
 
 	new_user = kmalloc(sizeof(*new_user), GFP_KERNEL);
 	if (!new_user)
@@ -3291,17 +3291,9 @@ int ipmi_register_smi(const struct ipmi_
 	 * Make sure the driver is actually initialized, this handles
 	 * problems with initialization order.
 	 */
-	if (!initialized) {
-		rv = ipmi_init_msghandler();
-		if (rv)
-			return rv;
-		/*
-		 * The init code doesn't return an error if it was turned
-		 * off, but it won't initialize.  Check that.
-		 */
-		if (!initialized)
-			return -ENODEV;
-	}
+	rv = ipmi_init_msghandler();
+	if (rv)
+		return rv;
 
 	intf = kzalloc(sizeof(*intf), GFP_KERNEL);
 	if (!intf)
@@ -5017,6 +5009,22 @@ static int panic_event(struct notifier_b
 	return NOTIFY_DONE;
 }
 
+/* Must be called with ipmi_interfaces_mutex held. */
+static int ipmi_register_driver(void)
+{
+	int rv;
+
+	if (drvregistered)
+		return 0;
+
+	rv = driver_register(&ipmidriver.driver);
+	if (rv)
+		pr_err("Could not register IPMI driver\n");
+	else
+		drvregistered = true;
+	return rv;
+}
+
 static struct notifier_block panic_block = {
 	.notifier_call	= panic_event,
 	.next		= NULL,
@@ -5027,66 +5035,75 @@ static int ipmi_init_msghandler(void)
 {
 	int rv;
 
+	mutex_lock(&ipmi_interfaces_mutex);
+	rv = ipmi_register_driver();
+	if (rv)
+		goto out;
 	if (initialized)
-		return 0;
+		goto out;
 
-	rv = driver_register(&ipmidriver.driver);
-	if (rv) {
-		pr_err("Could not register IPMI driver\n");
-		return rv;
-	}
-
-	pr_info("version " IPMI_DRIVER_VERSION "\n");
+	init_srcu_struct(&ipmi_interfaces_srcu);
 
 	timer_setup(&ipmi_timer, ipmi_timeout, 0);
 	mod_timer(&ipmi_timer, jiffies + IPMI_TIMEOUT_JIFFIES);
 
 	atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
 
-	initialized = 1;
+	initialized = true;
 
-	return 0;
+out:
+	mutex_unlock(&ipmi_interfaces_mutex);
+	return rv;
 }
 
 static int __init ipmi_init_msghandler_mod(void)
 {
-	ipmi_init_msghandler();
-	return 0;
+	int rv;
+
+	pr_info("version " IPMI_DRIVER_VERSION "\n");
+
+	mutex_lock(&ipmi_interfaces_mutex);
+	rv = ipmi_register_driver();
+	mutex_unlock(&ipmi_interfaces_mutex);
+
+	return rv;
 }
 
 static void __exit cleanup_ipmi(void)
 {
 	int count;
 
-	if (!initialized)
-		return;
-
-	atomic_notifier_chain_unregister(&panic_notifier_list, &panic_block);
+	if (initialized) {
+		atomic_notifier_chain_unregister(&panic_notifier_list,
+						 &panic_block);
 
-	/*
-	 * This can't be called if any interfaces exist, so no worry
-	 * about shutting down the interfaces.
-	 */
+		/*
+		 * This can't be called if any interfaces exist, so no worry
+		 * about shutting down the interfaces.
+		 */
 
-	/*
-	 * Tell the timer to stop, then wait for it to stop.  This
-	 * avoids problems with race conditions removing the timer
-	 * here.
-	 */
-	atomic_inc(&stop_operation);
-	del_timer_sync(&ipmi_timer);
+		/*
+		 * Tell the timer to stop, then wait for it to stop.  This
+		 * avoids problems with race conditions removing the timer
+		 * here.
+		 */
+		atomic_inc(&stop_operation);
+		del_timer_sync(&ipmi_timer);
 
-	driver_unregister(&ipmidriver.driver);
+		initialized = false;
 
-	initialized = 0;
+		/* Check for buffer leaks. */
+		count = atomic_read(&smi_msg_inuse_count);
+		if (count != 0)
+			pr_warn("SMI message count %d at exit\n", count);
+		count = atomic_read(&recv_msg_inuse_count);
+		if (count != 0)
+			pr_warn("recv message count %d at exit\n", count);
 
-	/* Check for buffer leaks. */
-	count = atomic_read(&smi_msg_inuse_count);
-	if (count != 0)
-		pr_warn("SMI message count %d at exit\n", count);
-	count = atomic_read(&recv_msg_inuse_count);
-	if (count != 0)
-		pr_warn("recv message count %d at exit\n", count);
+		cleanup_srcu_struct(&ipmi_interfaces_srcu);
+	}
+	if (drvregistered)
+		driver_unregister(&ipmidriver.driver);
 }
 module_exit(cleanup_ipmi);
 


