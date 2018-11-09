Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CDAC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84EA20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="f5izmFC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84EA20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbeKJIx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:53:58 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33649 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728855AbeKJIx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:53:57 -0500
Received: by mail-lf1-f65.google.com with SMTP id i26so2513087lfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 15:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gtBNlOV6caZtQTJ8UdN0Pc9ivMg1MfiukWQjhYhOldw=;
        b=f5izmFC+KkSjAaq0K4ewd6LB95R0RX2SuYHPiN8r4fVFsr4/OA13AlvC78qBWcr28j
         9pHoZSTLHfeXRQinVdAn0n48UlPEjGln7sQjQR0W9yniF1XddnI+pgL2in9sKcCze+hK
         5HncS1lAWKFGxDDhKAowqro5S+9R5aI0drzXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gtBNlOV6caZtQTJ8UdN0Pc9ivMg1MfiukWQjhYhOldw=;
        b=Vb/K9oPuzHst9bji41xWS1PdYDmCyswfylTzAuj5SeHOqB+qTh37SblMvOEWGJ8pf6
         KlA0WV45SwBlUrLWKNMeDPpcqFLp1D+8v/oesqRBa6PKFl7713UPcFs1luYTzHIsBxB4
         dYSKnqNX4zPHAcCt711aUo9EX6z8GB4xZNz9lARLL9uf844sCRGBV3+vrgYNzbkT+Srw
         iIL2kU5wW1PiB46BIFdi2UIoHvmY49rZssjP7tIMYFyLGb9Bj4MeJ+6HmbOY1XhY2ij1
         iAHsbTHMOu1qF8emooSH2oOw7dOg7+DGlECQ9r443PKHOXBm9UZXCpF6/LG6oM+Y6fcL
         wTcQ==
X-Gm-Message-State: AGRZ1gIT76a+ruXNAkz8qpZtNRyc7zGsuyw6ENGHr6sknzAZZrqs0ITC
        vmMz0nn2bo0A/DAbf64d/Wvtmw==
X-Google-Smtp-Source: AJdET5fq18bxeDnodRDDMROMip1xNGqHldP0DwqooucjrKlAEYluge1NO/jZPd4QIgFtAjUpcEnA+w==
X-Received: by 2002:a19:2c92:: with SMTP id s140mr6258958lfs.42.1541805071958;
        Fri, 09 Nov 2018 15:11:11 -0800 (PST)
Received: from prevas-ravi.prevas.se (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id x16sm1584012lff.26.2018.11.09.15.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 15:11:11 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 10/23] dynamic_debug: remove unused EXPORT_SYMBOLs
Date:   Sat, 10 Nov 2018 00:10:08 +0100
Message-Id: <20181109231021.11658-11-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181109231021.11658-1-linux@rasmusvillemoes.dk>
References: <20181009112013.14238-1-linux@rasmusvillemoes.dk>
 <20181109231021.11658-1-linux@rasmusvillemoes.dk>
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
2.19.1.6.gbde171bbf5

