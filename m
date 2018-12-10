Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5517AC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 246A7205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 246A7205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbeLJHuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 02:50:15 -0500
Received: from lgeamrelo11.lge.com ([156.147.23.51]:36680 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeLJHuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 02:50:15 -0500
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.51 with ESMTP; 10 Dec 2018 16:50:13 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: chanho.min@lge.com
Received: from unknown (HELO kernel.lge.com) (165.186.175.97)
        by 156.147.1.126 with ESMTP; 10 Dec 2018 16:50:13 +0900
X-Original-SENDERIP: 165.186.175.97
X-Original-MAILFROM: chanho.min@lge.com
From:   Chanho Min <chanho.min@lge.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "David S. Miller" <davem@davemloft.net>,
        Michal Hocko <mhocko@suse.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Seungho Park <seungho1.park@lge.com>,
        Chanho Min <chanho.min@lge.com>
Subject: [PATCH] exec: make prepare_bprm_creds static
Date:   Mon, 10 Dec 2018 16:49:54 +0900
Message-Id: <1544428194-2431-1-git-send-email-chanho.min@lge.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

prepare_bprm_creds is not used outside exec.c, so there's no reason for it
to have external linkage.

Signed-off-by: Chanho Min <chanho.min@lge.com>
---
 fs/exec.c               | 2 +-
 include/linux/binfmts.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index fc281b7..b6c9e5f 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1399,7 +1399,7 @@ EXPORT_SYMBOL(finalize_exec);
  * Or, if exec fails before, free_bprm() should release ->cred and
  * and unlock.
  */
-int prepare_bprm_creds(struct linux_binprm *bprm)
+static int prepare_bprm_creds(struct linux_binprm *bprm)
 {
 	if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
 		return -ERESTARTNOINTR;
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index e9f5fe6..6a9e43d 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -138,7 +138,6 @@ extern int transfer_args_to_stack(struct linux_binprm *bprm,
 extern int bprm_change_interp(const char *interp, struct linux_binprm *bprm);
 extern int copy_strings_kernel(int argc, const char *const *argv,
 			       struct linux_binprm *bprm);
-extern int prepare_bprm_creds(struct linux_binprm *bprm);
 extern void install_exec_creds(struct linux_binprm *bprm);
 extern void set_binfmt(struct linux_binfmt *new);
 extern ssize_t read_code(struct file *, unsigned long, loff_t, size_t);
-- 
2.1.4

