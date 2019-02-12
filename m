Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC6DC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B405D222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="iSZ2ZAQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731775AbfBLVmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:42:07 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43081 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731057AbfBLVmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:42:05 -0500
Received: by mail-ed1-f68.google.com with SMTP id f9so146660eds.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 13:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c/DP+/WPa+Jq+JAZdR/A0ANzlyTG7UQQ0eBVWCTtWwc=;
        b=iSZ2ZAQIrQiu4zvswrqxRbv/hOc15iZsZHSIg0qRcuB7IlbKMG8RWvp+MgAUlw7VOo
         VSzLPYMyKNl873vKJOyKjjodhd/QC3DaAgrIE8m4UPnreR5SYyA8sn8puWcD8mvxSFSS
         yVIeIuKbBGx6/r/lyrPdmGoLzAY13QaB5xy0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c/DP+/WPa+Jq+JAZdR/A0ANzlyTG7UQQ0eBVWCTtWwc=;
        b=XcGEFptonzj1JxdBgwlSfpKDFs3WRnGNJnBgpiR3Hhac8TFK04WFaLrz0gzGgmV9W/
         zHaO/S63AlFGIsHZdn2XpZeFyI444njKEqTrJJ5SvUBFH3hJtTCttMUpClskdOd0U++V
         CcYQ820stYwI6N1pzmQHf3jLUv3vC5J7icWD24uVQNVinV79k/COJYG4dInn2pJO1fXB
         pl1pYdU09Axm5IUeeDK9QOHm5lX3/yVoSzRW+o0X9LaGvDaET/WAb7K7/mWRaVu4HgQg
         OHKJ2cyNl0shzuk43PZqNn55yWyZlbEI3pzHNb7G0zf5pNiD8vzNcZSpILUoV5GPdSh6
         BUjw==
X-Gm-Message-State: AHQUAubQUBEuR6mlDKaDw4npipPdDYwBNDLw7Re0kXjqDUp+Mi/fZPQB
        lIoQHst1gfK4HLbzNQPLASXk5g==
X-Google-Smtp-Source: AHgI3Ialyaz6Q4vU9n5eHDQiT/dIOOvq67rwbx4q4+Yb9jl0YIdK6BqnB1JHWIT0VIiVF7okO4ZtgQ==
X-Received: by 2002:a17:906:4306:: with SMTP id j6mr4229872ejm.174.1550007723363;
        Tue, 12 Feb 2019 13:42:03 -0800 (PST)
Received: from prevas-ravi.waoo.dk (ip-5-186-119-174.cgn.fibianet.dk. [5.186.119.174])
        by smtp.gmail.com with ESMTPSA id v1sm3697607eds.47.2019.02.12.13.42.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 13:42:02 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 06/14] dynamic_debug: use pointer comparison in ddebug_remove_module
Date:   Tue, 12 Feb 2019 22:41:42 +0100
Message-Id: <20190212214150.4807-7-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212214150.4807-1-linux@rasmusvillemoes.dk>
References: <20190212214150.4807-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we store the passed-in string directly in ddebug_add_module, we
can use pointer equality instead of strcmp. This is a little more
efficient, but more importantly, this also makes the code somewhat more
correct:

Currently, if one loads and then unloads a module whose name happens to
match the KBUILD_MODNAME of some built-in functionality (which need not
even be modular at all), all of their dynamic debug entries vanish along
with those of the actual module. For example, loading and unloading a
core.ko hides all pr_debugs from drivers/base/core.c and other built-in
files called core.c (incidentally, there is an in-tree module whose name
is core, but I just tested this with an out-of-tree trivial one).

Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/dynamic_debug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 8274c4ea75e0..214828c65625 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -929,9 +929,10 @@ int ddebug_remove_module(const char *mod_name)
 
 	mutex_lock(&ddebug_lock);
 	list_for_each_entry_safe(dt, nextdt, &ddebug_tables, link) {
-		if (!strcmp(dt->mod_name, mod_name)) {
+		if (dt->mod_name == mod_name) {
 			ddebug_table_free(dt);
 			ret = 0;
+			break;
 		}
 	}
 	mutex_unlock(&ddebug_lock);
-- 
2.20.1

