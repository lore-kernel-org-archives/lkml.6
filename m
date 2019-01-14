Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EED8C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 01:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43C7206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 01:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfANBZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 20:25:56 -0500
Received: from muru.com ([72.249.23.125]:33538 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbfANBZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 20:25:55 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 144AA814F;
        Mon, 14 Jan 2019 01:25:59 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Alan Cox <alan@llwyncelyn.cymru>, Jiri Slaby <jslaby@suse.cz>,
        Johan Hovold <johan@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Peter Hurley <peter@hurleysoftware.com>,
        Rob Herring <robh@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 1/3] tty: n_gsm: Add copy_config() and gsm_config() to prepare for serdev
Date:   Sun, 13 Jan 2019 17:25:26 -0800
Message-Id: <20190114012528.2367-2-tony@atomide.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114012528.2367-1-tony@atomide.com>
References: <20190114012528.2367-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For supporting serdev drivers, we need to be able to configure n_gsm
from drivers. Let's prepare for that by adding copy_config() and
gsm_config() helper functions by moving the code around a bit.

Let's also unify the comments to keep checkpatch happy while at it.

Cc: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@llwyncelyn.cymru>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Johan Hovold <johan@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/n_gsm.c | 207 +++++++++++++++++++++++---------------------
 1 file changed, 107 insertions(+), 100 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2214,6 +2214,111 @@ static struct gsm_mux *gsm_alloc_mux(void)
 	return gsm;
 }
 
+static void gsm_copy_config_values(struct gsm_mux *gsm,
+				   struct gsm_config *c)
+{
+	memset(c, 0, sizeof(*c));
+	c->adaption = gsm->adaption;
+	c->encapsulation = gsm->encoding;
+	c->initiator = gsm->initiator;
+	c->t1 = gsm->t1;
+	c->t2 = gsm->t2;
+	c->t3 = 0;	/* Not supported */
+	c->n2 = gsm->n2;
+	if (gsm->ftype == UIH)
+		c->i = 1;
+	else
+		c->i = 2;
+	pr_debug("Ftype %d i %d\n", gsm->ftype, c->i);
+	c->mru = gsm->mru;
+	c->mtu = gsm->mtu;
+	c->k = 0;
+}
+
+static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
+{
+	int need_close = 0;
+	int need_restart = 0;
+
+	/* Stuff we don't support yet - UI or I frame transport, windowing */
+	if ((c->adaption != 1 && c->adaption != 2) || c->k)
+		return -EOPNOTSUPP;
+	/* Check the MRU/MTU range looks sane */
+	if (c->mru > MAX_MRU || c->mtu > MAX_MTU || c->mru < 8 || c->mtu < 8)
+		return -EINVAL;
+	if (c->n2 < 3)
+		return -EINVAL;
+	if (c->encapsulation > 1)	/* Basic, advanced, no I */
+		return -EINVAL;
+	if (c->initiator > 1)
+		return -EINVAL;
+	if (c->i == 0 || c->i > 2)	/* UIH and UI only */
+		return -EINVAL;
+	/*
+	 * See what is needed for reconfiguration
+	 */
+
+	/* Timing fields */
+	if (c->t1 != 0 && c->t1 != gsm->t1)
+		need_restart = 1;
+	if (c->t2 != 0 && c->t2 != gsm->t2)
+		need_restart = 1;
+	if (c->encapsulation != gsm->encoding)
+		need_restart = 1;
+	if (c->adaption != gsm->adaption)
+		need_restart = 1;
+	/* Requires care */
+	if (c->initiator != gsm->initiator)
+		need_close = 1;
+	if (c->mru != gsm->mru)
+		need_restart = 1;
+	if (c->mtu != gsm->mtu)
+		need_restart = 1;
+
+	/*
+	 * Close down what is needed, restart and initiate the new
+	 * configuration
+	 */
+
+	if (need_close || need_restart) {
+		int ret;
+
+		ret = gsm_disconnect(gsm);
+
+		if (ret)
+			return ret;
+	}
+	if (need_restart)
+		gsm_cleanup_mux(gsm);
+
+	gsm->initiator = c->initiator;
+	gsm->mru = c->mru;
+	gsm->mtu = c->mtu;
+	gsm->encoding = c->encapsulation;
+	gsm->adaption = c->adaption;
+	gsm->n2 = c->n2;
+
+	if (c->i == 1)
+		gsm->ftype = UIH;
+	else if (c->i == 2)
+		gsm->ftype = UI;
+
+	if (c->t1)
+		gsm->t1 = c->t1;
+	if (c->t2)
+		gsm->t2 = c->t2;
+
+	/*
+	 * FIXME: We need to separate activation/deactivation from adding
+	 * and removing from the mux array
+	 */
+	if (need_restart)
+		gsm_activate_mux(gsm);
+	if (gsm->initiator && need_close)
+		gsm_dlci_begin_open(gsm->dlci[0]);
+	return 0;
+}
+
 /**
  *	gsmld_output		-	write to link
  *	@gsm: our mux
@@ -2495,89 +2600,6 @@ static __poll_t gsmld_poll(struct tty_struct *tty, struct file *file,
 	return mask;
 }
 
-static int gsmld_config(struct tty_struct *tty, struct gsm_mux *gsm,
-							struct gsm_config *c)
-{
-	int need_close = 0;
-	int need_restart = 0;
-
-	/* Stuff we don't support yet - UI or I frame transport, windowing */
-	if ((c->adaption != 1 && c->adaption != 2) || c->k)
-		return -EOPNOTSUPP;
-	/* Check the MRU/MTU range looks sane */
-	if (c->mru > MAX_MRU || c->mtu > MAX_MTU || c->mru < 8 || c->mtu < 8)
-		return -EINVAL;
-	if (c->n2 < 3)
-		return -EINVAL;
-	if (c->encapsulation > 1)	/* Basic, advanced, no I */
-		return -EINVAL;
-	if (c->initiator > 1)
-		return -EINVAL;
-	if (c->i == 0 || c->i > 2)	/* UIH and UI only */
-		return -EINVAL;
-	/*
-	 *	See what is needed for reconfiguration
-	 */
-
-	/* Timing fields */
-	if (c->t1 != 0 && c->t1 != gsm->t1)
-		need_restart = 1;
-	if (c->t2 != 0 && c->t2 != gsm->t2)
-		need_restart = 1;
-	if (c->encapsulation != gsm->encoding)
-		need_restart = 1;
-	if (c->adaption != gsm->adaption)
-		need_restart = 1;
-	/* Requires care */
-	if (c->initiator != gsm->initiator)
-		need_close = 1;
-	if (c->mru != gsm->mru)
-		need_restart = 1;
-	if (c->mtu != gsm->mtu)
-		need_restart = 1;
-
-	/*
-	 *	Close down what is needed, restart and initiate the new
-	 *	configuration
-	 */
-
-	if (need_close || need_restart) {
-		int ret;
-
-		ret = gsm_disconnect(gsm);
-
-		if (ret)
-			return ret;
-	}
-	if (need_restart)
-		gsm_cleanup_mux(gsm);
-
-	gsm->initiator = c->initiator;
-	gsm->mru = c->mru;
-	gsm->mtu = c->mtu;
-	gsm->encoding = c->encapsulation;
-	gsm->adaption = c->adaption;
-	gsm->n2 = c->n2;
-
-	if (c->i == 1)
-		gsm->ftype = UIH;
-	else if (c->i == 2)
-		gsm->ftype = UI;
-
-	if (c->t1)
-		gsm->t1 = c->t1;
-	if (c->t2)
-		gsm->t2 = c->t2;
-
-	/* FIXME: We need to separate activation/deactivation from adding
-	   and removing from the mux array */
-	if (need_restart)
-		gsm_activate_mux(gsm);
-	if (gsm->initiator && need_close)
-		gsm_dlci_begin_open(gsm->dlci[0]);
-	return 0;
-}
-
 static int gsmld_ioctl(struct tty_struct *tty, struct file *file,
 		       unsigned int cmd, unsigned long arg)
 {
@@ -2586,29 +2608,14 @@ static int gsmld_ioctl(struct tty_struct *tty, struct file *file,
 
 	switch (cmd) {
 	case GSMIOC_GETCONF:
-		memset(&c, 0, sizeof(c));
-		c.adaption = gsm->adaption;
-		c.encapsulation = gsm->encoding;
-		c.initiator = gsm->initiator;
-		c.t1 = gsm->t1;
-		c.t2 = gsm->t2;
-		c.t3 = 0;	/* Not supported */
-		c.n2 = gsm->n2;
-		if (gsm->ftype == UIH)
-			c.i = 1;
-		else
-			c.i = 2;
-		pr_debug("Ftype %d i %d\n", gsm->ftype, c.i);
-		c.mru = gsm->mru;
-		c.mtu = gsm->mtu;
-		c.k = 0;
+		gsm_copy_config_values(gsm, &c);
 		if (copy_to_user((void *)arg, &c, sizeof(c)))
 			return -EFAULT;
 		return 0;
 	case GSMIOC_SETCONF:
 		if (copy_from_user(&c, (void *)arg, sizeof(c)))
 			return -EFAULT;
-		return gsmld_config(tty, gsm, &c);
+		return gsm_config(gsm, &c);
 	default:
 		return n_tty_ioctl_helper(tty, file, cmd, arg);
 	}
-- 
2.20.1
