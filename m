Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65544C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33FA8222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="KU3L829w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732163AbfBLVm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:42:29 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46907 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728944AbfBLVmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:42:11 -0500
Received: by mail-ed1-f65.google.com with SMTP id f2so134057edy.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 13:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8tQBQN4Gd6A8alQknyIJodX2WHALuebxSd6qUkfi74o=;
        b=KU3L829wnKF3SqK9LvGSd5qn/DtJqWO0TXSvxIKBmY7yRvVRmV7M5zHCJIPYK9zoP8
         +5jWbVxOVuFSIzdVeYVHE/JvYd9S82moo64g+Xv8QUJDtSRxwUJF5sLxCt1JrCRhggtg
         KxxJ2PYCg+wCm0WpdCPciFq9Bld6NV7h8J8AQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8tQBQN4Gd6A8alQknyIJodX2WHALuebxSd6qUkfi74o=;
        b=KP0zCUhPAFWrcGUuFyM26t3BAvMEZnEjT26W3KnFSwBuseyeAjy84qsnifmT6rEoDS
         78ukwWV5EklN8RfVHz7fS+oyw3sgIbwIvJNOzJQU8NA+Vhs4n16x/1VTM71i5ICAQSwn
         bR8antr4b9rt/2Qp2nFvaoDJ5TCxa3fPCobNIf/CuOnmBo8b2bW62Kra4/xlogUaBBp3
         TGGDIOeyia/uVD19blwoQQdqlJOK7DgtARqWvqNLRLECy++ABNzLKXAlw3kY9UuIMUfe
         2WAQJej3uCyxYjAnAMapDkK7NFVDPu/x+oSv9L60mDXGaUoFzNNdnAujaCMqVqlKLPmT
         62Zg==
X-Gm-Message-State: AHQUAuYLpjy80Du5+FNGfqt0w7VxKOaCe1fjmSrXcZ0kbJDH3VFeT2Ez
        KpzQ2HgaEJYOLTDOL+yQxKoZdg==
X-Google-Smtp-Source: AHgI3IYL7fHn0xJXjApiE5SmBJ8UwAZZS+WdZlHg+5w7Yf1q7tu7fRto9wYUuQrJ0ouTZqDfQEUXVQ==
X-Received: by 2002:a17:906:9146:: with SMTP id y6mr1556765ejw.153.1550007729860;
        Tue, 12 Feb 2019 13:42:09 -0800 (PST)
Received: from prevas-ravi.waoo.dk (ip-5-186-119-174.cgn.fibianet.dk. [5.186.119.174])
        by smtp.gmail.com with ESMTPSA id v1sm3697607eds.47.2019.02.12.13.42.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 13:42:09 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v4 12/14] ACPI: use proper DYNAMIC_DEBUG_BRANCH macro
Date:   Tue, 12 Feb 2019 22:41:48 +0100
Message-Id: <20190212214150.4807-13-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212214150.4807-1-linux@rasmusvillemoes.dk>
References: <20190212214150.4807-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dynamic debug may be implemented via static keys, but ACPI is missing
out on that runtime benefit since it open-codes one possible definition
of DYNAMIC_DEBUG_BRANCH.

Cc: linux-acpi@vger.kernel.org
Acked-by: Jason Baron <jbaron@akamai.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/acpi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 87715f20b69a..bcdfbb2bea24 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -987,7 +987,7 @@ void __acpi_handle_debug(struct _ddebug *descriptor, acpi_handle handle, const c
 #define acpi_handle_debug(handle, fmt, ...)				\
 do {									\
 	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
-	if (unlikely(descriptor.flags & _DPRINTK_FLAGS_PRINT))		\
+	if (DYNAMIC_DEBUG_BRANCH(descriptor))				\
 		__acpi_handle_debug(&descriptor, handle, pr_fmt(fmt),	\
 				##__VA_ARGS__);				\
 } while (0)
-- 
2.20.1

