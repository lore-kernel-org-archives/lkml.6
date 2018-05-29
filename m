Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033481AbeE2BtC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 21:49:02 -0400
Received: from gate.crashing.org ([63.228.1.57]:44121 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937405AbeE2BsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 21:48:22 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Christopher Bostic <cbostic@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 09/15] fsi/gpio: Include command build in locked section
Date: Tue, 29 May 2018 11:30:38 +1000
Message-Id: <20180529013044.23815-10-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180529013044.23815-1-benh@kernel.crashing.org>
References: <20180529013044.23815-1-benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Kerr <jk@ozlabs.org>

For implementing relative addressing mode, we'll need to build a command
that is coherent with CFAM state. To do that, include the
build_command_* functions in the locked section of read/write/term.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/fsi/fsi-master-gpio.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
index e1bde9e3f855..d50ea4849377 100644
--- a/drivers/fsi/fsi-master-gpio.c
+++ b/drivers/fsi/fsi-master-gpio.c
@@ -463,14 +463,10 @@ static int fsi_master_gpio_xfer(struct fsi_master_gpio *master, uint8_t slave,
 {
 	int rc;
 
-	mutex_lock(&master->cmd_lock);
-
 	rc = send_request(master, cmd);
 	if (!rc)
 		rc = poll_for_response(master, slave, resp_len, resp);
 
-	mutex_unlock(&master->cmd_lock);
-
 	return rc;
 }
 
@@ -479,12 +475,17 @@ static int fsi_master_gpio_read(struct fsi_master *_master, int link,
 {
 	struct fsi_master_gpio *master = to_fsi_master_gpio(_master);
 	struct fsi_gpio_msg cmd;
+	int rc;
 
 	if (link != 0)
 		return -ENODEV;
 
+	mutex_lock(&master->cmd_lock);
 	build_abs_ar_command(&cmd, id, addr, size, NULL);
-	return fsi_master_gpio_xfer(master, id, &cmd, size, val);
+	rc = fsi_master_gpio_xfer(master, id, &cmd, size, val);
+	mutex_unlock(&master->cmd_lock);
+
+	return rc;
 }
 
 static int fsi_master_gpio_write(struct fsi_master *_master, int link,
@@ -492,12 +493,17 @@ static int fsi_master_gpio_write(struct fsi_master *_master, int link,
 {
 	struct fsi_master_gpio *master = to_fsi_master_gpio(_master);
 	struct fsi_gpio_msg cmd;
+	int rc;
 
 	if (link != 0)
 		return -ENODEV;
 
+	mutex_lock(&master->cmd_lock);
 	build_abs_ar_command(&cmd, id, addr, size, val);
-	return fsi_master_gpio_xfer(master, id, &cmd, 0, NULL);
+	rc = fsi_master_gpio_xfer(master, id, &cmd, 0, NULL);
+	mutex_unlock(&master->cmd_lock);
+
+	return rc;
 }
 
 static int fsi_master_gpio_term(struct fsi_master *_master,
@@ -505,12 +511,17 @@ static int fsi_master_gpio_term(struct fsi_master *_master,
 {
 	struct fsi_master_gpio *master = to_fsi_master_gpio(_master);
 	struct fsi_gpio_msg cmd;
+	int rc;
 
 	if (link != 0)
 		return -ENODEV;
 
+	mutex_lock(&master->cmd_lock);
 	build_term_command(&cmd, id);
-	return fsi_master_gpio_xfer(master, id, &cmd, 0, NULL);
+	rc = fsi_master_gpio_xfer(master, id, &cmd, 0, NULL);
+	mutex_unlock(&master->cmd_lock);
+
+	return rc;
 }
 
 static int fsi_master_gpio_break(struct fsi_master *_master, int link)
-- 
2.17.0
