Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A4EC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD32820855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="gxNBQ1Jg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD32820855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbeKJIyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:54:07 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41761 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbeKJIyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:54:06 -0500
Received: by mail-lj1-f195.google.com with SMTP id z80-v6so2964706ljb.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 15:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WjlkOi7SsoKeG44ML8h7MnjFOLGteuTlJadrTcyRrTQ=;
        b=gxNBQ1Jgalir7n7qBfARJLrySPGPeemWx8ePDBGJblGpaZbx+xIRof3IKgDtosB2j5
         jYpwiF8oe3+KHfQ/b8HsdwFRhFpEGydX2ybC0gB6zbsIsowZ+sGa0z9SjzXV/W84YfI9
         OXlY78Ha9rLTJHpSge3WruhMzaeQHKyMduBUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WjlkOi7SsoKeG44ML8h7MnjFOLGteuTlJadrTcyRrTQ=;
        b=Q5uEB/bYisdI18erUgnXWYnEMisBRnlPrcY3hcb7Hv+/9l7BeIBJUqw1bYkgeWp846
         fQMTaLTJIpwMF0U5/+YNE5aCfTg1DnNQt740mrfpCnWzHTTrUAZCZ7bGgMNN6gwC3iz1
         aTjrneX5vqh7F9Lq7UuRFtHSvor1+QNS5WGuQbGdLgQ9zzL4C0yXoilT8t+HvG6apobM
         0b18ZfDV7nfCLStAZjhV+WXwCi0IsROGavanKEIy1djsVtp9+ArNSuMRQsqHBWbGtF48
         jVFMkFTKBdi9zZeQlYh3eZyYsedZIv3WUGrv/rAZ8J1eihYDnsTlxn+Ub0gI+6d0Rtfg
         +CSw==
X-Gm-Message-State: AGRZ1gKzHKbMxm4GdErrem4uPy+x0pMKjlpmlj4M5a4leqL4fi5aCnTU
        UVwqRFeU1N9kpuI+XrnmUTwZgTlw/dIvTA==
X-Google-Smtp-Source: AJdET5elACq6XJVK7gZmLt4RGbeG75mJlPBBpzOC98ImthMx8XGxkLJ5rMT6nOyMuaCx61lKBdgFFw==
X-Received: by 2002:a2e:3218:: with SMTP id y24-v6mr3300351ljy.157.1541805080702;
        Fri, 09 Nov 2018 15:11:20 -0800 (PST)
Received: from prevas-ravi.prevas.se (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id x16sm1584012lff.26.2018.11.09.15.11.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 15:11:20 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v3 17/23] ACPI: implement acpi_handle_debug in terms of _dynamic_func_call
Date:   Sat, 10 Nov 2018 00:10:15 +0100
Message-Id: <20181109231021.11658-18-linux@rasmusvillemoes.dk>
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

With coming changes on x86-64, all dynamic debug descriptors in a
translation unit must have distinct names. The macro _dynamic_func_call
takes care of that. No functional change.

Cc: linux-acpi@vger.kernel.org
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/acpi.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index de8633456d71..b284598ae023 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -975,12 +975,8 @@ void __acpi_handle_debug(struct _ddebug *descriptor, acpi_handle handle, const c
 #else
 #if defined(CONFIG_DYNAMIC_DEBUG)
 #define acpi_handle_debug(handle, fmt, ...)				\
-do {									\
-	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
-	if (DYNAMIC_DEBUG_BRANCH(descriptor))				\
-		__acpi_handle_debug(&descriptor, handle, pr_fmt(fmt),	\
-				##__VA_ARGS__);				\
-} while (0)
+	_dynamic_func_call(fmt, __acpi_handle_debug,			\
+			   handle, pr_fmt(fmt), ##__VA_ARGS__)
 #else
 #define acpi_handle_debug(handle, fmt, ...)				\
 ({									\
-- 
2.19.1.6.gbde171bbf5

