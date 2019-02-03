Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B8CC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EFF1218D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbfBCNuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:50:13 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52970 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727974AbfBCNtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:46 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9X-0003ts-Bk; Sun, 03 Feb 2019 13:49:43 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9U-0006pL-Ej; Sun, 03 Feb 2019 14:49:40 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Kleber Sacilotto de Souza" <klebers@linux.vnet.ibm.com>,
        "Michael Ruettger" <michael@ibmra.de>,
        "Joerg-Stephan Vogt" <jsvogt@de.ibm.com>,
        "Eberhard S. Amann" <esa@linux.vnet.ibm.com>,
        "Frank Haverkamp" <haver@linux.vnet.ibm.com>,
        "Gabriel Krisman Bertazi" <krisman@linux.vnet.ibm.com>,
        "Michael Jung" <mijung@gmx.net>,
        "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Sebastian Ott" <sebott@linux.vnet.ibm.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.186807772@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 029/305] signal/GenWQE: Fix sending of SIGKILL
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Eric W. Biederman" <ebiederm@xmission.com>

commit 0ab93e9c99f8208c0a1a7b7170c827936268c996 upstream.

The genweq_add_file and genwqe_del_file by caching current without
using reference counting embed the assumption that a file descriptor
will never be passed from one process to another.  It even embeds the
assumption that the the thread that opened the file will be in
existence when the process terminates.   Neither of which are
guaranteed to be true.

Therefore replace caching the task_struct of the opener with
pid of the openers thread group id.  All the knowledge of the
opener is used for is as the target of SIGKILL and a SIGKILL
will kill the entire process group.

Rename genwqe_force_sig to genwqe_terminate, remove it's unncessary
signal argument, update it's ownly caller, and use kill_pid
instead of force_sig.

The work force_sig does in changing signal handling state is not
relevant to SIGKILL sent as SEND_SIG_PRIV.  The exact same processess
will be killed just with less work, and less confusion.  The work done
by force_sig is really only needed for handling syncrhonous
exceptions.

It will still be possible to cause genwqe_device_remove to wait
8 seconds by passing a file descriptor to another process but
the possible user after free is fixed.

Fixes: eaf4722d4645 ("GenWQE Character device and DDCB queue")
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Frank Haverkamp <haver@linux.vnet.ibm.com>
Cc: Joerg-Stephan Vogt <jsvogt@de.ibm.com>
Cc: Michael Jung <mijung@gmx.net>
Cc: Michael Ruettger <michael@ibmra.de>
Cc: Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>
Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: Eberhard S. Amann <esa@linux.vnet.ibm.com>
Cc: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
Cc: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/misc/genwqe/card_base.h | 2 +-
 drivers/misc/genwqe/card_dev.c  | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

--- a/drivers/misc/genwqe/card_base.h
+++ b/drivers/misc/genwqe/card_base.h
@@ -401,7 +401,7 @@ struct genwqe_file {
 	struct file *filp;
 
 	struct fasync_struct *async_queue;
-	struct task_struct *owner;
+	struct pid *opener;
 	struct list_head list;		/* entry in list of open files */
 
 	spinlock_t map_lock;		/* lock for dma_mappings */
--- a/drivers/misc/genwqe/card_dev.c
+++ b/drivers/misc/genwqe/card_dev.c
@@ -52,7 +52,7 @@ static void genwqe_add_file(struct genwq
 {
 	unsigned long flags;
 
-	cfile->owner = current;
+	cfile->opener = get_pid(task_tgid(current));
 	spin_lock_irqsave(&cd->file_lock, flags);
 	list_add(&cfile->list, &cd->file_list);
 	spin_unlock_irqrestore(&cd->file_lock, flags);
@@ -65,6 +65,7 @@ static int genwqe_del_file(struct genwqe
 	spin_lock_irqsave(&cd->file_lock, flags);
 	list_del(&cfile->list);
 	spin_unlock_irqrestore(&cd->file_lock, flags);
+	put_pid(cfile->opener);
 
 	return 0;
 }
@@ -275,7 +276,7 @@ static int genwqe_kill_fasync(struct gen
 	return files;
 }
 
-static int genwqe_force_sig(struct genwqe_dev *cd, int sig)
+static int genwqe_terminate(struct genwqe_dev *cd)
 {
 	unsigned int files = 0;
 	unsigned long flags;
@@ -283,7 +284,7 @@ static int genwqe_force_sig(struct genwq
 
 	spin_lock_irqsave(&cd->file_lock, flags);
 	list_for_each_entry(cfile, &cd->file_list, list) {
-		force_sig(sig, cfile->owner);
+		kill_pid(cfile->opener, SIGKILL, 1);
 		files++;
 	}
 	spin_unlock_irqrestore(&cd->file_lock, flags);
@@ -1346,7 +1347,7 @@ static int genwqe_inform_and_stop_proces
 		dev_warn(&pci_dev->dev,
 			 "[%s] send SIGKILL and wait ...\n", __func__);
 
-		rc = genwqe_force_sig(cd, SIGKILL); /* force terminate */
+		rc = genwqe_terminate(cd);
 		if (rc) {
 			/* Give kill_timout more seconds to end processes */
 			for (i = 0; (i < genwqe_kill_timeout) &&

