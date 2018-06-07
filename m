Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id c9z7DPH5GFsdcAAAmS7hNA
	; Thu, 07 Jun 2018 09:30:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9901E608B8; Thu,  7 Jun 2018 09:30:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id F1C87606DD;
	Thu,  7 Jun 2018 09:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F1C87606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753494AbeFGJaS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 05:30:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:54621 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753004AbeFGJ3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 05:29:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AFCCBAF03;
        Thu,  7 Jun 2018 09:29:52 +0000 (UTC)
From: Miroslav Benes <mbenes@suse.cz>
To: jikos@kernel.org, jpoimboe@redhat.com, jeyu@kernel.org
Cc: pmladek@suse.com, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 3/3] module: Remove superfluous call to klp_module_going()
Date: Thu,  7 Jun 2018 11:29:49 +0200
Message-Id: <20180607092949.1706-4-mbenes@suse.cz>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180607092949.1706-1-mbenes@suse.cz>
References: <20180607092949.1706-1-mbenes@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that patched modules cannot suddenly disappear we could
theoretically remove klp_module_going() altogether. Unfortunately we
cannot do that in practice. Loading of a patched module may fail and we
need to execute right the actions implemented in klp_module_going().

Remove the call from delete_module syscall though, because that one is
really superfluous.

Signed-off-by: Miroslav Benes <mbenes@suse.cz>
---
 kernel/module.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/module.c b/kernel/module.c
index a6e43a5806a1..af29a0d3708f 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1019,7 +1019,6 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
 		mod->exit();
 	blocking_notifier_call_chain(&module_notify_list,
 				     MODULE_STATE_GOING, mod);
-	klp_module_going(mod);
 	ftrace_release_mod(mod);
 
 	async_synchronize_full();
-- 
2.17.0
