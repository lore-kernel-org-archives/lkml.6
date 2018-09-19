Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF81DC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7528621523
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="dTrURk11"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7528621523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387634AbeITDqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:46:09 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40372 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730876AbeITDo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:44:59 -0400
Received: by mail-ed1-f68.google.com with SMTP id j62-v6so6155501edd.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yXcu0lgya7AY/QzNdA2HkC5LKeWw93fYQrPWSy28E+8=;
        b=dTrURk11d7U12iIwZRAnCLnw6Xc90+azwJY3be0neSwjT6TIOEt5UTcbKZK7BSBj1s
         Ch9efNbtsEGJe/7yXgVMZfF4JY5+6op37af5/5wAJiWK6s4uVIhRiGbN1mq+1Eu7iUuX
         Z3WFuNEh1sUaFApAMttT3nvN4V0/WbxV4C6Uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yXcu0lgya7AY/QzNdA2HkC5LKeWw93fYQrPWSy28E+8=;
        b=TkfnXUTcs/3tMNyRUU5JWqfZwJmgoTHnloGPYwTZicJRxLGzP8+Z8x0c0GkosRIoqd
         CQd1CzMtPoVu+RQP2oVDdQMzcHi2SVNTAFCKHcoI5Zz7vccscljLwQHBSnyBKv4AAyg6
         akkqAcjCfhsIHV1r+hm4PYwpLR+rlWhif1vDDD7cBj9eNYNQX5e1m8ePM4fRVKfP17M4
         gYMR1ayAzMBoOULxkQ5ImAaRgx4z+fPlKuCdYXGK8h2iZ+OkmANAxoGP57MUfTilRjG6
         T8u3TpG8j47pe9nXNe+l6vqLzjisJ0PiEIwL3j1fn+7mkMxBI8D5uTga1AibXAGghfOW
         d1fw==
X-Gm-Message-State: APzg51Dg2o+wxj//LNawmZlGWXxT62elBgGQxyNwU7THgTFNHZj8HSQm
        t1zOAOcaWeTZToVQtLj4Ahm5rts9kotcShvQ
X-Google-Smtp-Source: ANB0Vdby5/Z26fxItQI15qcFI36rqC2x9NPpWdf9uGlj9dOUPkOJQEmswV58w3u8s63loskMOx7nTg==
X-Received: by 2002:a50:f419:: with SMTP id r25-v6mr58835768edm.226.1537394701996;
        Wed, 19 Sep 2018 15:05:01 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-115-161.cgn.ip.fibianet.dk. [5.186.115.161])
        by smtp.gmail.com with ESMTPSA id a9-v6sm2798edi.26.2018.09.19.15.05.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Sep 2018 15:05:01 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 10/22] dynamic_debug: remove unused EXPORT_SYMBOLs
Date:   Thu, 20 Sep 2018 00:04:32 +0200
Message-Id: <20180919220444.23190-11-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only caller of ddebug_{add,remove}_module outside dynamic_debug.c is
kernel/module.c, which is obviously not itself modular (though it would
be an interesting exercise to make that happen...). I also fail to see
how these interfaces can be used by modules, in-tree or not.

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
2.16.4

