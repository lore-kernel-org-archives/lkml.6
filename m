Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA916C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 13:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B662176D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 13:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="elWHM+iG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81B662176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbeHRQYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 12:24:18 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:44084 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbeHRQYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 12:24:17 -0400
Received: by mail-ed1-f44.google.com with SMTP id f23-v6so5961233edr.11
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 06:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dxhFnp8a3JQlhkZoZgfQ7p7+WfMJlV8bqTkBphCAz9Y=;
        b=elWHM+iGNhV9lbryXnmtdjRblmiRsvJJqpUdtHkHc4LYeK/RKJijZ9qEnz+4ATOe+V
         /NB3N07IF9p4851sppyJVHWPlU1PzbM9aZZYs1D9NRho0MVBIs8afVTpTyycATeoxRCi
         JUbttuidtEzMzrCb5vjkiT0J6WMZFXNVHyzjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dxhFnp8a3JQlhkZoZgfQ7p7+WfMJlV8bqTkBphCAz9Y=;
        b=FXgSPnrrPySCYA0ICC67r/EZAezYmEr/qIKw/AYxJwsIlRQux0SFX0Jeyfdkjkh3pH
         yq00hVLJIXHi06Wb1pRGIzpJbMRUMC9Acjr2AGAn4GRFeMCxiXRXgkb/57hZkntSF/e7
         TpGABq37a+uKBcXYpqnI8L928rCL5OVjmBgg4uqltIT59LKZ3JCPHUtHnXexFyCJBKU+
         JzJnXSLh+2mBdpMkaf2lBozBloBIkBrv/ZUOJ9Rqc17juPZ57g3MmGdGfphyF6VoIp4g
         G20tudFXWPLixMYQuk2XDp+tUXvGZoWXsl0oN3Vzbkr5M2kuzUaND1NBkZZ1jGvcoQve
         XBpQ==
X-Gm-Message-State: AOUpUlEZgc5ZcFyMESpIqpmx6rDtD0+xbufbnIJP3fumFTxE/+9m88ax
        xxMDcDfDaqB/4nY7i7bQMhPFmMZEeikE/A==
X-Google-Smtp-Source: AA+uWPxq7/f/fU8pPwxCohIFKI70juhwT1w7WA2LRP9dhnxR31xqB6UG5OXtiXhOaXOlNAEhmmgtrQ==
X-Received: by 2002:a50:da01:: with SMTP id z1-v6mr46785481edj.62.1534598195349;
        Sat, 18 Aug 2018 06:16:35 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-212.cgn.ip.fibianet.dk. [5.186.114.212])
        by smtp.gmail.com with ESMTPSA id r11-v6sm2821403edp.60.2018.08.18.06.16.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Aug 2018 06:16:34 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <ynorov@caviumnetworks.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] lib/bitmap.c: simplify bitmap_print_to_pagebuf
Date:   Sat, 18 Aug 2018 15:16:23 +0200
Message-Id: <20180818131623.8755-8-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180818131623.8755-1-linux@rasmusvillemoes.dk>
References: <20180818131623.8755-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

len is guaranteed to lie in [1, PAGE_SIZE]. If scnprintf is called with
a buffer size of 1, it is guaranteed to return 0. So in the extremely
unlikely case of having just one byte remaining in the page, let's just
call scnprintf anyway. The only difference is that this will write a
'\0' to that final byte in the page, but that's an improvement: We now
guarantee that after the call, buf is a properly terminated C string of
length exactly the return value.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/bitmap.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 277c9a63a5ab..75175da01fd8 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -469,12 +469,9 @@ int bitmap_print_to_pagebuf(bool list, char *buf, const unsigned long *maskp,
 			    int nmaskbits)
 {
 	ptrdiff_t len = PAGE_SIZE - ((unsigned long)buf & (PAGE_SIZE-1));
-	int n = 0;
 
-	if (len > 1)
-		n = list ? scnprintf(buf, len, "%*pbl\n", nmaskbits, maskp) :
-			   scnprintf(buf, len, "%*pb\n", nmaskbits, maskp);
-	return n;
+	return list ? scnprintf(buf, len, "%*pbl\n", nmaskbits, maskp) :
+		      scnprintf(buf, len, "%*pb\n", nmaskbits, maskp);
 }
 EXPORT_SYMBOL(bitmap_print_to_pagebuf);
 
-- 
2.16.4

