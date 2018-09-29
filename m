Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B5EC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 01:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15572073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 01:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="McxtkQgg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F15572073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbeI2IP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 04:15:59 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:51545 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeI2IP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 04:15:59 -0400
Received: by mail-io1-f73.google.com with SMTP id w23-v6so7600094iob.18
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 18:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=YBvPWNStdSCZdwpuY045db/PjMLed+h/ETzcHBpouRQ=;
        b=McxtkQggJYn2BBONilDbhns2dT6bUDeOcq3AdKGWlqzjnMmE1a2a2gM5zpVJ9D22La
         PtljhMT+cSXYYNn7o1X3Ap3mhll+PDujSybcEac4ApcWRYqxLp9sbrmH6GJKkySjHtgM
         zEOubcUY0d2ywH2vIwOcLVwXMY8M1PW4mkHInCESX2TK4xA7SJHQwbYsNLI788rJcvgx
         Sd/hNfgdqKe+wiG10lg8PkuspQCrWNCQtPFximDzyz99ArTTTJHvPp3JhaFtzI24vGOi
         G4kJsEU8+8WNbAWTOfE3gp0OalupkbCEsyKY5Chte4qghqIabh8jxp5Pc3Qz5xN8dY/X
         V2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=YBvPWNStdSCZdwpuY045db/PjMLed+h/ETzcHBpouRQ=;
        b=LzuFoJl07a8kfj7XCx9krXskJyNfoMK4psze3qzGC7/olK8Uh1cDuHeZwdGDr8vlAU
         4sqSQ37B4+lMfsxrbXMQ+4CMc8XxwaBYr8MXqGzThcHC7OJO7ANKhsPJx61b7cCzPcTZ
         P74XUxR7y/Q6rmsMPcXbicmlFlmngR5gep0LYe2PdHh08smLG1EyrnXFtYsQHYHhKGkq
         4Yro8qovbseQ4unrPwBIr4Q0XcGBHNkvaXnUXw5eJCGVmuEnOfzH2juq5yQiW+LpSeqn
         g/+IsZQOkXW6a+X4TngTHMTW51m/p9K7v0GL5aBX/rn3dDZwc7eFQ7Jlei0IR/rei9W3
         KzHg==
X-Gm-Message-State: ABuFfogm4oczsJ+VglCO3CRPkFfSCj0VSSzrqjS3G1POGRXbHDUKMwNa
        r/0j/Y3kRPh7f/xCLRBmYrGlxQahrQ==
X-Google-Smtp-Source: ACcGV63hd4lxY9ZVNOySs3ycRr81XvZRy7exCPiwov3tsXgfZP5qn/Q+bjT1CYySiknq9B+Gi/2LlDUV1Q==
X-Received: by 2002:a24:56ce:: with SMTP id o197-v6mr3668302itb.32.1538185770744;
 Fri, 28 Sep 2018 18:49:30 -0700 (PDT)
Date:   Sat, 29 Sep 2018 03:49:26 +0200
Message-Id: <20180929014926.227002-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH] apparmor: don't try to replace stale label in ptraceme check
From:   Jann Horn <jannh@google.com>
To:     John Johansen <john.johansen@canonical.com>,
        apparmor@lists.ubuntu.com, jannh@google.com
Cc:     linux-kernel@vger.kernel.org, Cyrill Gorcunov <gorcunov@gmail.com>,
        kernel test robot <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

begin_current_label_crit_section() must run in sleepable context because
when label_is_stale() is true, aa_replace_current_label() runs, which uses
prepare_creds(), which can sleep.

Until now, the ptraceme access check (which runs with tasklist_lock held)
violated this rule.

Fixes: b2d09ae449ced ("apparmor: move ptrace checks to using labels")
Reported-by: Cyrill Gorcunov <gorcunov@gmail.com>
Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Jann Horn <jannh@google.com>
---
 security/apparmor/lsm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 8c7f46a6a8dc..0f56431b4b2f 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -131,11 +131,11 @@ static int apparmor_ptrace_traceme(struct task_struct *parent)
 	struct aa_label *tracer, *tracee;
 	int error;
 
-	tracee = begin_current_label_crit_section();
+	tracee = __begin_current_label_crit_section();
 	tracer = aa_get_task_label(parent);
 	error = aa_may_ptrace(tracer, tracee, AA_PTRACE_TRACE);
 	aa_put_label(tracer);
-	end_current_label_crit_section(tracee);
+	__end_current_label_crit_section(tracee);
 
 	return error;
 }
-- 
2.19.0.605.g01d371f741-goog

