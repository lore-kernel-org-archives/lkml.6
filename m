Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94270ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA26206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="WM1E0gwk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA26206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387574AbeITDpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:45:33 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41722 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733235AbeITDpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:45:10 -0400
Received: by mail-ed1-f65.google.com with SMTP id f38-v6so6166089edd.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A80wQthOJgi0twLRVcMWnZiiuFKRtq/Sn+wCLsW8RZ8=;
        b=WM1E0gwkEmUa4NDj84wp4sfLaVBF0hg5OWAOTHFVximkz+IJOZ6nxC+9zcKzaUww2I
         nMuffbYjWkz4MveGGn4qW/XNpgR0fyNmk2NUOdBCWXTF825tWyZLS6CQtUeVLV/UFLgE
         4THvuqWIpXUyOiX2i5SfNKmIVxqy1+kg9g0NI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A80wQthOJgi0twLRVcMWnZiiuFKRtq/Sn+wCLsW8RZ8=;
        b=O5uhBds6+I0vlmaaMRsIrkdDu/Q+EFaMhyBpPYwDWJvVQGUlLZUfyfqPMu41WKC7W8
         ehFfzMewPi20q+GvAJ4D6L2ss1A5xNDG5Eu3qTbxaYtD/9mlQWwhZsGlyfxOGW5cw08O
         VwN1oT0pkluB6ZGY9pdiBtekSD0dXUcNVJlCbCniqPxWdC73k0tcZ+BojW0912KerJBy
         e7V7lW2akMKaxu4ZqQ3d8wMw/IiAhYOZLH+eso+vRbQUX88oXzUdvjJZPEjfDrE2je6V
         LDLlISPkJzthTZ6YoGmjFX4b7FpGPSTCO1pkM2Z2L8b2rUU26KVcgh0amCNSXHm9oZsa
         oHzA==
X-Gm-Message-State: APzg51Cq/v0JSLQHgh3Kw9iTFzMU8Ex+TCIYtLydWhF9o4q1z9yMnjYo
        H3HuEHiT3n+fSPLWXra3Ox4WSIiLkONbvPvj
X-Google-Smtp-Source: ANB0VdZaTW+OD6OptL93zT3Z5Phh2W2UT7NWb3h2W00MHU9KqPEoqpQ4flRHeU+fTujzV5PtnkIceA==
X-Received: by 2002:a50:ec03:: with SMTP id g3-v6mr61150178edr.96.1537394713116;
        Wed, 19 Sep 2018 15:05:13 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-115-161.cgn.ip.fibianet.dk. [5.186.115.161])
        by smtp.gmail.com with ESMTPSA id a9-v6sm2798edi.26.2018.09.19.15.05.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Sep 2018 15:05:12 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 16/22] ACPI: remove unused __acpi_handle_debug macro
Date:   Thu, 20 Sep 2018 00:04:38 +0200
Message-Id: <20180919220444.23190-17-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_DYNAMIC_DEBUG is not set, acpi_handle_debug directly invokes
acpi_handle_printk (if DEBUG) or does a no-printk (if !DEBUG). So this
macro is never used.

Cc: linux-acpi@vger.kernel.org
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/acpi.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 21e03aa32aae..e12d5ef1a054 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -948,9 +948,6 @@ acpi_handle_printk(const char *level, void *handle, const char *fmt, ...) {}
 #if defined(CONFIG_ACPI) && defined(CONFIG_DYNAMIC_DEBUG)
 __printf(3, 4)
 void __acpi_handle_debug(struct _ddebug *descriptor, acpi_handle handle, const char *fmt, ...);
-#else
-#define __acpi_handle_debug(descriptor, handle, fmt, ...)		\
-	acpi_handle_printk(KERN_DEBUG, handle, fmt, ##__VA_ARGS__);
 #endif
 
 /*
-- 
2.16.4

