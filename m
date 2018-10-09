Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07F0C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6683F214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="OosXLW4E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6683F214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbeJIShB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:37:01 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41983 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727284AbeJIShA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:37:00 -0400
Received: by mail-ed1-f65.google.com with SMTP id x31-v6so1315465edd.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YfYqdETdVGU71NK+5BbeGX1st6hc9fJrYkGKI3vmiNc=;
        b=OosXLW4E7eS358zWHJ0EgVpp3ss0kGMs8gYeXB/vH0YjZRFiKKsWeYXiz9l/LhyUvc
         zXG4D9YVMjSuvbZQDLhp7UgPHb9EIyckLLAsZy9GfT4Z6jyZ6BrQgTNlWDnqoE1XbbcA
         3sjhiIRSidcqiCe/lqGYcCrGiiL/rZLw3OL1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YfYqdETdVGU71NK+5BbeGX1st6hc9fJrYkGKI3vmiNc=;
        b=XXCm8JhfOPUJUqftGZWpxDmlUWwyQbMJQi+IXy5W4HSRCJsBC/29E2SXk9owtJ0itS
         gSFe33Qw2KU+6SZ0+hUL16eh5MWh1n0u0+IxeMrLZwpAOHAetNm005zHTjdhlZPL13D1
         xwnK3D0MjKi4x9KFxcsGekDJubsXf04ir08TmPvxYBSHB4Jh4A56gXuy+86ZbqQnWLdU
         3BI2/HctI4wdUdTifsZQpoU6ZNwjQ8aaBXmNbBGFELQrwz4BuWqG2RIWR45r5exHfiky
         dlyjTQRbfBrQe7SXXkWwkFRQCF3vD2JWHlLEScyCqsT0L9bx18tUiSxKb8xa457Ykjiu
         VCXw==
X-Gm-Message-State: ABuFfohm3LbiW3X9t0VY8wBfIGpXFn3vPw0QsiP667Jv9zBdgz5xLPRb
        TIwrJ+yiuEHy4I/n2y8iOnzNxg==
X-Google-Smtp-Source: ACcGV63cPw18pebgw2kIBuAAyJwitWVZu/tf6/MPwqIaQ8oRasgZG7cWntXlvk4wfvUUMyyjRiLt5w==
X-Received: by 2002:a50:8664:: with SMTP id 33-v6mr35950754edt.190.1539084030446;
        Tue, 09 Oct 2018 04:20:30 -0700 (PDT)
Received: from prevas-ravi.vestasvisitor.net ([193.47.71.171])
        by smtp.gmail.com with ESMTPSA id n23-v6sm3595821eja.41.2018.10.09.04.20.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 04:20:30 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 10/23] dynamic_debug: remove unused EXPORT_SYMBOLs
Date:   Tue,  9 Oct 2018 13:20:00 +0200
Message-Id: <20181009112013.14238-11-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.4.g721af0fda3
In-Reply-To: <20181009112013.14238-1-linux@rasmusvillemoes.dk>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
 <20181009112013.14238-1-linux@rasmusvillemoes.dk>
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
index ab81155f928d..f1de45a100fa 100644
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
2.19.1.3.g1d92a00e68

