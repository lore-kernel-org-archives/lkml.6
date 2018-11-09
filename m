Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CCCC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B530E20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="NySe9vGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B530E20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbeKJIyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:54:50 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41760 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728858AbeKJIyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:54:04 -0500
Received: by mail-lj1-f196.google.com with SMTP id z80-v6so2964634ljb.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 15:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zikFil/AtYdu6Kux+125DpNglxhjQyI/EB/SaAFQ3pM=;
        b=NySe9vGirPKOeoUta4zyOtLJVYIqmQ8s2VS0BBRcj6i1YKTxY5ycDcnlZwwKO7x8Qu
         sDh6Oo0BpWljCqqWRW1GB79qRExjB429UhlI+XgZ2X3NhwqcufuUMIpF+KGccM9+MzZL
         jNegXkMX1OqO0M/PnKQ6MCwLNTHO7p9yQvHf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zikFil/AtYdu6Kux+125DpNglxhjQyI/EB/SaAFQ3pM=;
        b=l+7t88Mvrey0dmNpwLyv4VmGOKNufT/0AoR8XS+JGMNngtKQRySUmBi9jyk3wUNHWd
         J/3BN5djO51xtr3C4vajx7tpR6rr+dpSP/HfqTRIWCaYq2m1JZJaOxuI1vRLII8/8s/5
         W+4DXI4Xgv5QEwR+z2mFMjKljuXziZ0oc+dVfQTqIQnIuhzS2nSyOgsCg4QLbyYUnB52
         DXbac6kqnnrk9q4nrawNp7VcyoaPHTF4uZu+L9p2KgHu6j4HijWxAxNFvJutHP36jS7P
         +0Cw6OIjoGk+/dNEh9dlwSV/n9I7jKwBU1K+8Ywv1iRWJyTv1fc3dvMJpmzf0pmAEbEW
         mVPQ==
X-Gm-Message-State: AGRZ1gIqbG6mxBdwc4SO9woEXI7ejLAgXAsqXVBtkPIKZ/xAF1b76IhB
        TVNF8db3Fgxup9VufFqyb8TxFg==
X-Google-Smtp-Source: AJdET5fcezmWo/EYhEv4h6PTkhr1PwuoYpPcKtAVIkVdn4bIiZHvdJH/sWFYpdwEZwBMX5+ClME7bg==
X-Received: by 2002:a2e:9bc3:: with SMTP id w3-v6mr6479464ljj.70.1541805078151;
        Fri, 09 Nov 2018 15:11:18 -0800 (PST)
Received: from prevas-ravi.prevas.se (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id x16sm1584012lff.26.2018.11.09.15.11.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 15:11:17 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v3 15/23] ACPI: use proper DYNAMIC_DEBUG_BRANCH macro
Date:   Sat, 10 Nov 2018 00:10:13 +0100
Message-Id: <20181109231021.11658-16-linux@rasmusvillemoes.dk>
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
index ed80f147bd50..052e6492ebd7 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -980,7 +980,7 @@ void __acpi_handle_debug(struct _ddebug *descriptor, acpi_handle handle, const c
 #define acpi_handle_debug(handle, fmt, ...)				\
 do {									\
 	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
-	if (unlikely(descriptor.flags & _DPRINTK_FLAGS_PRINT))		\
+	if (DYNAMIC_DEBUG_BRANCH(descriptor))				\
 		__acpi_handle_debug(&descriptor, handle, pr_fmt(fmt),	\
 				##__VA_ARGS__);				\
 } while (0)
-- 
2.19.1.6.gbde171bbf5

