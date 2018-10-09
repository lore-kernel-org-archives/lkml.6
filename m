Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E22DC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5091A20835
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="UzHZEYUl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5091A20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeJIShI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:37:08 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46115 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbeJIShI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:37:08 -0400
Received: by mail-ed1-f67.google.com with SMTP id g32-v6so1301667edg.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sA/jxv5F0qnu20pN8RN11C/qVSfpGyeJaerZ5AKmtrw=;
        b=UzHZEYUl5l+tombdmqejznWOMhkCvGGaGvUVKh5UY1P96yp9c96NY2T8qDJumNOjis
         gv+ExKavG9+qi6a//nsBB/qxhI7OzuBx/3TlczeWKBgoO9h4RhDnXsUfXeSHUbwbf0i9
         POSE14zyfnKF2OZWaCDqvrT7WUSmyfG+pjT5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sA/jxv5F0qnu20pN8RN11C/qVSfpGyeJaerZ5AKmtrw=;
        b=aGtKSUNRLYhuyiN6+rvyyixk6aXvcsIv3/vn/PCJha8jeemJDbYIXLG/DwuHWLjvit
         utSom4bfPWRnjdW0euFlOmUaDb9gdRr/SJB6Izq/nkHnW4dQNJ3hgeShl1SAE9AWr8JG
         W/JWZwkxqEpp+h0miFMHtzm+Ylh5fZFmWG2NwfNZV6pooWh0ug8PBW1ausQtPzIRV3Nk
         EQsFDUD9HouIJoA+yHx3o+CjO3pGN3uiiFomE670n+I8OywZflQRbdDyHVSrs+JeUMDG
         Mat8+DTh+QD0klegGMacCN7VJ+DMI6uCcUWp8h5uPLp/ZcN6C8CQHRpkEf/r0ZuI3oRB
         wCEQ==
X-Gm-Message-State: ABuFfoglNlGgHFy8/cQd9lOFQWfZM3HQ7b8+lfqKFcDG933Ij2DPdxaV
        YWI/wvB9hp/mW1knEP2MN3zycwXsBOk=
X-Google-Smtp-Source: ACcGV61tpBu0WZrNf/LYNlxmnAzSaQpd03+1J63CcJra5woKkfXH7Hm+vhjSa0stjjjNHmNgOfjBig==
X-Received: by 2002:a50:d651:: with SMTP id c17-v6mr33324459edj.178.1539084037824;
        Tue, 09 Oct 2018 04:20:37 -0700 (PDT)
Received: from prevas-ravi.vestasvisitor.net ([193.47.71.171])
        by smtp.gmail.com with ESMTPSA id n23-v6sm3595821eja.41.2018.10.09.04.20.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 04:20:37 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v2 17/23] ACPI: implement acpi_handle_debug in terms of _dynamic_func_call
Date:   Tue,  9 Oct 2018 13:20:07 +0200
Message-Id: <20181009112013.14238-18-linux@rasmusvillemoes.dk>
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
index e12d5ef1a054..83bacf9039e9 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -977,12 +977,8 @@ void __acpi_handle_debug(struct _ddebug *descriptor, acpi_handle handle, const c
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
2.19.1.3.g1d92a00e68

