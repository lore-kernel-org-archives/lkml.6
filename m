Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B404FECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 01:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D502075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 01:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="czusButT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D502075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbeJYJ60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 05:58:26 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43757 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbeJYJ6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 05:58:25 -0400
Received: by mail-qt1-f196.google.com with SMTP id q41-v6so7991416qtq.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 18:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UNa/t9rRC91BV1dr6X2f7W55SSKjZ97xlXgIrbqUXUI=;
        b=czusButTMN/uNzZZ34Q/SnvIXJTZGsPDvsZkvMWCP06ciWNUUewL2u+Mk4gIEK+5pS
         Jl69asx44T/guF4j9st0f8xCtIaf2J2Zen6gezzkS9bNTT3KYA104atxfbmjv2KTPVpz
         AB79j5x8+322Hkx+uqUzAddml6RAuZkfiErss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UNa/t9rRC91BV1dr6X2f7W55SSKjZ97xlXgIrbqUXUI=;
        b=WzHcXPvQCk9r9yo56dDJ8/WCbf8r5J+W4MmgMoMIGZIbTJgVRcrFNVNEodxUXERJRr
         h1s7CXbdQJXtnMyKl/PQ2ErPSgCKP42sbUeE2sW3DPX6s8DzKqq+DNJu2QCONaiSmRvK
         5ZyY5c6DncU0ZX692cHpz6H/Jt/VHO73dcAq1ufEFfYRJwJAiu0UNO/e236jfCajpv0Q
         il/6EnNh+/ZgpkIYxBeenYXRnyyI0TjXWK788lpp25+dZSq9ZPTKPClojV1kqCzuMlR1
         LG/g7r0AM9/0acE+YlkDu12fdBwPfo4yh2XoNzYaQopTEA/hhyNyTMYN0+ls0sZ4LBaA
         uFUg==
X-Gm-Message-State: AGRZ1gL/kWpm6da7DqnUKh73t4A7BjZFbWU7gLr9s/saWbG5thkqVGLA
        HsQ6tix5UCSgg/S7ZwgFQHaIxdesuqMbwA==
X-Google-Smtp-Source: AJdET5cgYb5IslnZt4MnUgHoRLzvTixKiJXHSxbbYyNsixS8+sNs2YynFxCm53xEsNQae/XBHrD3CA==
X-Received: by 2002:aed:2554:: with SMTP id w20-v6mr4736913qtc.183.1540430876020;
        Wed, 24 Oct 2018 18:27:56 -0700 (PDT)
Received: from workstation.celeiro.br ([138.204.25.17])
        by smtp.gmail.com with ESMTPSA id m6-v6sm5338994qta.50.2018.10.24.18.27.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 18:27:54 -0700 (PDT)
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        Rafael David Tinoco <rafael.tinoco@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Mark Brown <broonie@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Nitin Gupta <ngupta@vflare.org>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH 2/2] mm/zsmalloc.c: fix zsmalloc ARM LPAE support
Date:   Wed, 24 Oct 2018 22:27:45 -0300
Message-Id: <20181025012745.20884-2-rafael.tinoco@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181025012745.20884-1-rafael.tinoco@linaro.org>
References: <20181025012745.20884-1-rafael.tinoco@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 02390b87a945 ("mm/zsmalloc: Prepare to variable
MAX_PHYSMEM_BITS"), an architecture has to define this value in order to
guarantee that zsmalloc will be able to encode and decode the obj value
properly.

Similar to that change, this one sets the value for ARM LPAE, fixing a
possible null-ptr-deref in zs_map_object() when using ARM LPAE and
HIGHMEM pages located above the 4GB watermark.

Link: https://bugs.linaro.org/show_bug.cgi?id=3765#c17
Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 arch/arm/include/asm/pgtable-3level-types.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/pgtable-3level-types.h b/arch/arm/include/asm/pgtable-3level-types.h
index 921aa30259c4..bd4994f98700 100644
--- a/arch/arm/include/asm/pgtable-3level-types.h
+++ b/arch/arm/include/asm/pgtable-3level-types.h
@@ -67,4 +67,6 @@ typedef pteval_t pgprot_t;
 
 #endif	/* STRICT_MM_TYPECHECKS */
 
+#define MAX_POSSIBLE_PHYSMEM_BITS	36
+
 #endif	/* _ASM_PGTABLE_3LEVEL_TYPES_H */
-- 
2.19.1

