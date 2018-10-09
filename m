Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F91C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C77220835
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="jN+iAXVu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C77220835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbeJISjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:39:03 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35610 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbeJISg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:36:59 -0400
Received: by mail-ed1-f68.google.com with SMTP id y19-v6so1330043edd.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tny/9sbwvLv3IhW/IiVhHLLmo7Yu5TP6WDbTE1LgMVI=;
        b=jN+iAXVuDivoH2d82mpmHS0ug5K6lJhCv7b1QwCVw1BOP6un8sYDha5CHZT3Xee8Hf
         1q/BnuCwKHXOzh/BUzolt7pOR/VkMMan7v2vklYMeJC7Gt4s/+Xoz3002QM4DbCvNm9J
         OyGel4EbFlIFb+gataTyTi7Oy/Hl0LS4P/Vow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tny/9sbwvLv3IhW/IiVhHLLmo7Yu5TP6WDbTE1LgMVI=;
        b=JnPkKjtKF0ZUhEHOP+kK4yaVfZauvfckkt8v1yzGBb6e6EF0iAMZTeVAlZw/rsvMGb
         ChOvRsVV/EgH3CKYdd78+7modHhVGfFcU4RYa2RQhcVkmgradtaZg63KskYnokArHlIQ
         +BTAkN0mjYKcSZbTFjllZoXaPrTogv2fRnF4wWYZTzLwwftTAxUyiG/dNrVMrgeQ9ERm
         wT3aQFkOkovmSZlZq19oqRohzFRclZOJK5v/08SUfX59BdYTUUHZAnm7MfCtUmFGtH1Z
         VznlTCrbpNp41eLbvaU3kWT2xJbJb7AFe4RNrsHeshcipPMitoZRaHL1sk2RyCxSwygI
         u3tg==
X-Gm-Message-State: ABuFfogrmrvY05P4tEE/t2VPVgRGfaFJUuemQDkX2Xco0t0EhtxncZ4B
        Am3uuw70d0p3rK6IDqYt2mzlEg==
X-Google-Smtp-Source: ACcGV61CMo8JHf6RykIjMzsGN/qCUOTvQGrgPAxDx7Gvttym8sTD7TO8Bgl4IU/1sUOhXco9wyUvzQ==
X-Received: by 2002:aa7:dc4b:: with SMTP id g11-v6mr34160817edu.115.1539084029230;
        Tue, 09 Oct 2018 04:20:29 -0700 (PDT)
Received: from prevas-ravi.vestasvisitor.net ([193.47.71.171])
        by smtp.gmail.com with ESMTPSA id n23-v6sm3595821eja.41.2018.10.09.04.20.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 04:20:28 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 09/23] dynamic_debug: use pointer comparison in ddebug_remove_module
Date:   Tue,  9 Oct 2018 13:19:59 +0200
Message-Id: <20181009112013.14238-10-linux@rasmusvillemoes.dk>
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
index 2155e0e23530..ab81155f928d 100644
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
2.19.1.3.g1d92a00e68

