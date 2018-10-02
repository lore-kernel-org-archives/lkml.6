Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8079CC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE352089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE352089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbeJBMzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 08:55:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43637 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbeJBMzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 08:55:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w926DQII1858083
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 1 Oct 2018 23:13:26 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w926DQKV1858080;
        Mon, 1 Oct 2018 23:13:26 -0700
Date:   Mon, 1 Oct 2018 23:13:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-77ac1c02d9f20a0d72fa992c88b98c15d087dbca@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, jeyu@kernel.org, mingo@kernel.org,
        dan.carpenter@oracle.com, ard.biesheuvel@linaro.org,
        tglx@linutronix.de, hpa@zytor.com, keescook@chromium.org,
        peterz@infradead.org
Reply-To: jeyu@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
          ard.biesheuvel@linaro.org, dan.carpenter@oracle.com,
          tglx@linutronix.de, hpa@zytor.com, peterz@infradead.org,
          keescook@chromium.org
In-Reply-To: <20181001081324.11553-1-ard.biesheuvel@linaro.org>
References: <20181001081324.11553-1-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/core] jump_label: Fix NULL dereference bug in
 __jump_label_mod_update()
Git-Commit-ID: 77ac1c02d9f20a0d72fa992c88b98c15d087dbca
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  77ac1c02d9f20a0d72fa992c88b98c15d087dbca
Gitweb:     https://git.kernel.org/tip/77ac1c02d9f20a0d72fa992c88b98c15d087dbca
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Mon, 1 Oct 2018 10:13:24 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 2 Oct 2018 08:08:18 +0200

jump_label: Fix NULL dereference bug in __jump_label_mod_update()

Commit 19483677684b ("jump_label: Annotate entries that operate on
__init code earlier") refactored the code that manages runtime
patching of jump labels in modules that are tied to static keys
defined in other modules or in the core kernel.

In the latter case, we may iterate over the static_key_mod linked
list until we hit the entry for the core kernel, whose 'mod' field
will be NULL, and attempt to dereference it to get at its 'state'
member.

So let's add a non-NULL check: this forces the 'init' argument of
__jump_label_update() to false for static keys that are defined in
the core kernel, which is appropriate given that __init annotated
jump_label entries in the core kernel should no longer be active
at this point (i.e., when loading modules).

Fixes: 19483677684b ("jump_label: Annotate entries that operate on ...")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20181001081324.11553-1-ard.biesheuvel@linaro.org
---
 kernel/jump_label.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index e8cf3ff3149c..14a7f9881745 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -516,7 +516,7 @@ static void __jump_label_mod_update(struct static_key *key)
 		else
 			stop = m->jump_entries + m->num_jump_entries;
 		__jump_label_update(key, mod->entries, stop,
-				    m->state == MODULE_STATE_COMING);
+				    m && m->state == MODULE_STATE_COMING);
 	}
 }
 
