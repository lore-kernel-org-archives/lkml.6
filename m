Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFB7ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A302F21522
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="c2KQl4m9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A302F21522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387424AbeITDo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:44:59 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45618 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733235AbeITDo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:44:58 -0400
Received: by mail-ed1-f68.google.com with SMTP id p52-v6so6145310eda.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2MpIPnUj7X7v5PFxUqTacXruO6RjfNepRmP1LhcK5GE=;
        b=c2KQl4m9pu4Ee8AtyT884SlCOxGHmdm5V8mK5pxjICzXyF5Lm8YzJRKSvN6Iqt9i1/
         z7jWv9Yk1ZW+dk1wKcvWMEv4KN2IgZs2hleDGI9IlEoRcWh7f9tUl/E2ImFP8CNdTfp+
         IH2wWoJUYaXr9Ho8jMEdhMP/adiuLHOvwasSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2MpIPnUj7X7v5PFxUqTacXruO6RjfNepRmP1LhcK5GE=;
        b=ZLx5DHVvUDOZI9K16BVW0709aAz+DPfm0CbMC2P/losy40N0NX5g5A2D7Hd0/AIn6U
         hb5OxaQwm9Y/dsUuRI+csY14Qxn0bUXTEUb6D/Vw1ne5k8eXD7cXM8tvOyu3+Jb6BGfn
         VgKBvhLLvpjbkl7smdsp2y80PdiJzzNgUkdEU4goba5GyTKglmmYZLMr/Mb7PfhWMhiD
         vFmStGLqJSBgDyCjuHZWpmawU17AqjTWA1pwvWtxA10QKh1AZ6YIWRJYL4yCJwOtf+93
         Fe/OxrGp8AZjN49Lf5QnhXXp3gqUT202wYL6R6IV6lTikweIwMWJNc1m00odrsGbdIiW
         F1LQ==
X-Gm-Message-State: APzg51DSJen1LPDrtR2fvlLUTyMu98exwwYT890gHVF66CQ4+2xQfFgL
        tIHu+ohHpSCfOKHBIHvniLpRWg==
X-Google-Smtp-Source: ANB0VdYDPu5L+c77merVhVncMVWlWZSGOdknbiUJkqtmBAdVyM3lgo6/SI88E7yiuvl1O64IP0VGPQ==
X-Received: by 2002:aa7:c441:: with SMTP id n1-v6mr58724142edr.55.1537394701077;
        Wed, 19 Sep 2018 15:05:01 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-115-161.cgn.ip.fibianet.dk. [5.186.115.161])
        by smtp.gmail.com with ESMTPSA id a9-v6sm2798edi.26.2018.09.19.15.05.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Sep 2018 15:05:00 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 09/22] dynamic_debug: use pointer comparison in ddebug_remove_module
Date:   Thu, 20 Sep 2018 00:04:31 +0200
Message-Id: <20180919220444.23190-10-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
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
2.16.4

