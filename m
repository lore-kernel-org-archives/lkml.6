Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id utk5OFOIGltTCwAAmS7hNA
	; Fri, 08 Jun 2018 13:49:59 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 980A26089E; Fri,  8 Jun 2018 13:49:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2505960590;
	Fri,  8 Jun 2018 13:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2505960590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752535AbeFHNt4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 09:49:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:54301 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751121AbeFHNtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 09:49:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A58FDABA6;
        Fri,  8 Jun 2018 13:49:54 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Davidlohr Bueso <dbueso@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] ipc: Limit sysctl value to IPCMNI
Date: Fri,  8 Jun 2018 15:49:49 +0200
Message-Id: <20180608134949.12672-1-tiwai@suse.de>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently shmmni proc entry accepts all entered integer values, but
the practical limit is IPCMNI (32768).  This confuses user as if a
bigger value were accepted but not applied correctly.

This patch changes the proc entry to use *_minmax variant to limit the
accepted values accordingly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 ipc/ipc_sysctl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index 8ad93c29f511..0c8f89f54e61 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -99,6 +99,7 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
 static int zero;
 static int one = 1;
 static int int_max = INT_MAX;
+static int ipcmni = IPCMNI;
 
 static struct ctl_table ipc_kern_table[] = {
 	{
@@ -120,7 +121,9 @@ static struct ctl_table ipc_kern_table[] = {
 		.data		= &init_ipc_ns.shm_ctlmni,
 		.maxlen		= sizeof(init_ipc_ns.shm_ctlmni),
 		.mode		= 0644,
-		.proc_handler	= proc_ipc_dointvec,
+		.proc_handler	= proc_ipc_dointvec_minmax,
+		.extra1		= &zero,
+		.extra2		= &ipcmni,
 	},
 	{
 		.procname	= "shm_rmid_forced",
-- 
2.17.0
