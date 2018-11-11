Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59804C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2128E2154B
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6qO5f2M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2128E2154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389593AbeKLIVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:21:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:48422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387819AbeKLIVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:21:23 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 966CF22353;
        Sun, 11 Nov 2018 22:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975485;
        bh=ZZUnPclX9UIf+YvmVRO7v7gKJ8NJ9WgU4ce0HJrO+ew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l6qO5f2MECnDZ2pRshROKuLHQ3ozTkbzPd6QZ1blgawaEOTaGwKbtM3gRBvAzGBLN
         WLYZQq0NGQ4enIEkF/ZXTMSb7t6q4GDfDKrm3/v4tILl4oG/Mhh0aMTHr5cRmDH9Ft
         rQh1ysX+2L1vcO2aZO8Z9TJRG/Y8xRYne8fjJLUE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Frank Haverkamp <haver@linux.vnet.ibm.com>,
        Joerg-Stephan Vogt <jsvogt@de.ibm.com>,
        Michael Jung <mijung@gmx.net>,
        Michael Ruettger <michael@ibmra.de>,
        Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>,
        Sebastian Ott <sebott@linux.vnet.ibm.com>,
        "Eberhard S. Amann" <esa@linux.vnet.ibm.com>,
        Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>,
        "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 4.18 235/350] signal/GenWQE: Fix sending of SIGKILL
Date:   Sun, 11 Nov 2018 14:21:39 -0800
Message-Id: <20181111221717.869399035@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
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

From: Eric W. Biederman <ebiederm@xmission.com>

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
Cc: stable@vger.kernel.org
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/genwqe/card_base.h |    2 +-
 drivers/misc/genwqe/card_dev.c  |    9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

--- a/drivers/misc/genwqe/card_base.h
+++ b/drivers/misc/genwqe/card_base.h
@@ -408,7 +408,7 @@ struct genwqe_file {
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
@@ -1357,7 +1358,7 @@ static int genwqe_inform_and_stop_proces
 		dev_warn(&pci_dev->dev,
 			 "[%s] send SIGKILL and wait ...\n", __func__);
 
-		rc = genwqe_force_sig(cd, SIGKILL); /* force terminate */
+		rc = genwqe_terminate(cd);
 		if (rc) {
 			/* Give kill_timout more seconds to end processes */
 			for (i = 0; (i < GENWQE_KILL_TIMEOUT) &&


