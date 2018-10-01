Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D854C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D9720652
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J7U+X8EM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D9720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbeJAOuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 10:50:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33365 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbeJAOuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 10:50:20 -0400
Received: by mail-wm1-f68.google.com with SMTP id y140-v6so1985475wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 01:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=V34KedFUl0dNpmZRY9XQEWcKkcvRF5BVwWbyCmrm3k8=;
        b=J7U+X8EMFfYFPLD72nlnRuWW0ikSxmXnmQTbHa6+CNxQq/dOnO6sVGuwBZN9c6oYE+
         GmhmBylOPTUvL/oVWCapcDYNRaQ+vY80xIyjuDJkWfdjePGwfxh7E5YyEEbNN4NIZBAl
         8plWoxh9x7IUfqF20oyQJO2cxTH1lt41jXVOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V34KedFUl0dNpmZRY9XQEWcKkcvRF5BVwWbyCmrm3k8=;
        b=LS819shyVeZ+LF8U9sVMsUwh8aDVTh5NB/8ngO7Y1LnyxVxrMsEmtsLtyBWxaNvFBo
         LIuKSrW+2SdO4cKpyq3JMxqrUpSfDsMLepepWRd9Wgh/uQz06+Aa3rqhqddQq0z/uVg+
         oaKJMYLkt8jUvRA8ZJ1oWdh9WzzPMa7n87yjp/g7NSAj5jsSaoExfJGBcq189koTpLtl
         R9pOQexnEQTfDvhXIzSxgqDb6Pfv5SsC32jAndueD490bRYGonkyzW6jE2qtdfkVPXhS
         TeveKovtXl4jWKgCGoUMuXcscFC8NFsrXF4wnlslb8fBm2HBwhMtu0AACXqoO+/v9fWm
         fS7w==
X-Gm-Message-State: ABuFfojPmt2wRYl13qBrZxJOfnXba+1GHsGJMFfpR6UBpcqm28hkytGn
        lkm8lBuZ0rkw1uts94co4meMcD99N7k=
X-Google-Smtp-Source: ACcGV629LDBIhanNOq6XVG+n+5Ccgt/JehqKhtr+4wnxQ3+tG4/Mdxsonazl6gTrrzWCuSShOWgELg==
X-Received: by 2002:a1c:1812:: with SMTP id 18-v6mr3341213wmy.34.1538381627210;
        Mon, 01 Oct 2018 01:13:47 -0700 (PDT)
Received: from dogfood.home ([2a01:cb1d:112:6f00:6d26:fb49:4a42:a358])
        by smtp.gmail.com with ESMTPSA id s1-v6sm2592130wrw.35.2018.10.01.01.13.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 01:13:46 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] kernel: jump_label: fix NULL dereference bug in __jump_label_mod_update()
Date:   Mon,  1 Oct 2018 10:13:24 +0200
Message-Id: <20181001081324.11553-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Cc: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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
 
-- 
2.17.1

