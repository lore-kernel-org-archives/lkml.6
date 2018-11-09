Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05A8C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D4120827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ORYJI5oZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D4120827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbeKJIyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:54:05 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44737 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728957AbeKJIyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:54:05 -0500
Received: by mail-lj1-f194.google.com with SMTP id k19-v6so2945698lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 15:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PeycFQIWB361UCrQAw91tO/V5hkVyltTQfPihSwVUzE=;
        b=ORYJI5oZkS4NwmV0OtapOeeNHN3Z8Bcb93RsNA7pryOlUV+CPXVpJNyOtrpOVuklZ+
         y9+Oiqhkqoqk9kb2sX3TPmWktBwtWmDprVHkoxC1pfYH55Cza0xOjuNpPYyzup2El7d0
         OeMjDAtMzlJKNJoZODC+IuQZ+SLNXdJGEkKBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PeycFQIWB361UCrQAw91tO/V5hkVyltTQfPihSwVUzE=;
        b=ZAZEvhZxMhFk9UXp4JsovLOZaKsF4HfydmObIHbbbkokbga/SV3wVSeidtkjoke0dV
         uF1Fd2BaxACEeowsRdvir66MSSpFYjm0Dpy08fOaSYafIaDzg1p5Ohp8Y3i3ajFRJ3Ft
         QWBW9h1ywKw1Cjgx0HVN07QKDdP1o9aVBYqOpYBWcBY3p/F8dcg4/gmuWI78oUIVI1Ll
         n1bXmt/aDGFVf5zrwVUv4TOKdevglRkI4mNzoozqYoOJ8i180T6OZmEKUrv1PpaIAUjD
         q6TnfHTWrRIaleOMw/MukwdsTPxQgFpc7S2hf93oYl8iLUxnUUDFxLzqtKnvu1LIUqLk
         l5QQ==
X-Gm-Message-State: AGRZ1gJfEfuATo+1HdfpI+phGGdpA6snfp9DmlC1gXsKsI2pKsL33ce/
        9ydrdJONe3ygjnM7j0D/nhmneA==
X-Google-Smtp-Source: AJdET5dSWX/JUGRZ5mSH0eZeoXcKYSTXEJCx6/IHg0wHch7cDxpT3xCCHeAfhAOEG8KJ7kij7Rj5Cw==
X-Received: by 2002:a2e:82c9:: with SMTP id n9-v6mr6402169ljh.137.1541805079329;
        Fri, 09 Nov 2018 15:11:19 -0800 (PST)
Received: from prevas-ravi.prevas.se (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id x16sm1584012lff.26.2018.11.09.15.11.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 15:11:18 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v3 16/23] ACPI: remove unused __acpi_handle_debug macro
Date:   Sat, 10 Nov 2018 00:10:14 +0100
Message-Id: <20181109231021.11658-17-linux@rasmusvillemoes.dk>
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

If CONFIG_DYNAMIC_DEBUG is not set, acpi_handle_debug directly invokes
acpi_handle_printk (if DEBUG) or does a no-printk (if !DEBUG). So this
macro is never used.

Cc: linux-acpi@vger.kernel.org
Acked-by: Jason Baron <jbaron@akamai.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/acpi.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 052e6492ebd7..de8633456d71 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -946,9 +946,6 @@ acpi_handle_printk(const char *level, void *handle, const char *fmt, ...) {}
 #if defined(CONFIG_ACPI) && defined(CONFIG_DYNAMIC_DEBUG)
 __printf(3, 4)
 void __acpi_handle_debug(struct _ddebug *descriptor, acpi_handle handle, const char *fmt, ...);
-#else
-#define __acpi_handle_debug(descriptor, handle, fmt, ...)		\
-	acpi_handle_printk(KERN_DEBUG, handle, fmt, ##__VA_ARGS__);
 #endif
 
 /*
-- 
2.19.1.6.gbde171bbf5

