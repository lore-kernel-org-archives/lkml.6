Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FB8C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30F2B222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="g7hMvnP0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732215AbfBLVm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:42:58 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36033 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730460AbfBLVmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:42:06 -0500
Received: by mail-ed1-f65.google.com with SMTP id o59so180866edb.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 13:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sQgWZAL7D80pwiDPm13bE5t9aJhs7ZQMvmRzMmQvZjw=;
        b=g7hMvnP0vPHhvmtxdBNlJvfHqV3cLDoX25a/PQXj0G0EkU006vIYz+scA91SncjjE2
         rNZOGU4v0Fm+kKYcA4LQ5vXutlTtF8uo1yWJ/JxQhAzVRkj/EfclaOhrLYVjgmEioJRn
         Lbg6gFmd5y7LSLmwXDrb0zm61IRyqN+/V6cYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sQgWZAL7D80pwiDPm13bE5t9aJhs7ZQMvmRzMmQvZjw=;
        b=Bj+5QgCd+Fjvmd4kqHVIzKZqnB1Thv+MOv7T9TVGRWg5PoRk7rLhr80gImEHCbdfYI
         ea2rCm8QXOzM9+RiFC/psc+GSFNs04Lxpwcg9A/y/kHrpd/MwWUa3nrRXT6Oa9kxZH2v
         zTyUCsG5IoktXS8Lo2diwWMJ+keLJ1lOE0ZsgFaFc22P0/LFAyTJt98UZRXExfwCXIZU
         nh+J+B8tNWyqD6o7AViE5v6/a20K2Blp44/yHmkV+lJDaQ0H/EicozEb+AR7T37brCIR
         HK1IoMj3NG25B793qmblu1dr9wZwqgRdBvJct1ENi7ft+DaG6TkPkC74Qg59EUVBdMIb
         MHhg==
X-Gm-Message-State: AHQUAuYFLuMUWYICb1GAwB/Qhiyqv6kCEmrOElJFcmwhmSCMBgRGK+Qn
        5oFGiT4dE1zbDp7dqIUm5qa+2g==
X-Google-Smtp-Source: AHgI3Ib6LVHcStIhXviEXmzlaqDqfKtn3lDwu4tXV2Faq/hhu8dDhvkK+o2DwehrrEclBwCePgXkYQ==
X-Received: by 2002:a17:906:6d98:: with SMTP id h24mr4137712ejt.232.1550007724434;
        Tue, 12 Feb 2019 13:42:04 -0800 (PST)
Received: from prevas-ravi.waoo.dk (ip-5-186-119-174.cgn.fibianet.dk. [5.186.119.174])
        by smtp.gmail.com with ESMTPSA id v1sm3697607eds.47.2019.02.12.13.42.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 13:42:03 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 07/14] dynamic_debug: remove unused EXPORT_SYMBOLs
Date:   Tue, 12 Feb 2019 22:41:43 +0100
Message-Id: <20190212214150.4807-8-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212214150.4807-1-linux@rasmusvillemoes.dk>
References: <20190212214150.4807-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only caller of ddebug_{add,remove}_module outside dynamic_debug.c is
kernel/module.c, which is obviously not itself modular (though it would
be an interesting exercise to make that happen...). I also fail to see
how these interfaces can be used by modules, in-tree or not.

Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/dynamic_debug.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 214828c65625..7b76f43edaef 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -868,7 +868,6 @@ int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 	vpr_info("%u debug prints in module %s\n", n, dt->mod_name);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(ddebug_add_module);
 
 /* helper for ddebug_dyndbg_(boot|module)_param_cb */
 static int ddebug_dyndbg_param_cb(char *param, char *val,
@@ -938,7 +937,6 @@ int ddebug_remove_module(const char *mod_name)
 	mutex_unlock(&ddebug_lock);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(ddebug_remove_module);
 
 static void ddebug_remove_all_tables(void)
 {
-- 
2.20.1

