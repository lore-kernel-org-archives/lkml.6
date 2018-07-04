Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6BDC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1776C219EA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XLNpHS3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1776C219EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753062AbeGDRb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 13:31:57 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36000 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752571AbeGDRb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 13:31:56 -0400
Received: by mail-pf0-f193.google.com with SMTP id u16-v6so3157369pfh.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 10:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=YelSRb9YlJV+Nv9pc0dG8owDongHm91C6B9aBWyPk7c=;
        b=XLNpHS3WJkkq+dtbFiUCNb3mSkA1zzHyOMt+WtJPQrhsxTHoqV8ELF4zEWM/uS6u78
         /Ng5wxE+fxTOq0e/pyoYWCFZ3T20ZVANuLk+0KawHazWbQP0lOQQYOprFs40dlJsF2BA
         6hrGAMMWUNVTNujiDIk6jFHG409lP4hoqwlKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=YelSRb9YlJV+Nv9pc0dG8owDongHm91C6B9aBWyPk7c=;
        b=MXuKmTAQIB5flApGxbTNvdpmzwBk+anvZZdyRobLcmTh3fm7eyEugZVdGQZf3zQ0Wj
         8vHI/k1CLC32nEYOXMO5hXn37f9YpH+5cep6EF1QV1bt5Ay7hFgm10FmEgak14+Gh5+R
         H62TDlSUdbpKFzX4CsSvxMuJTm2CSPBlMEptcW3yrkNthGyF1RU1KnqC1i0ml9K11c6o
         B5/K1f7h/nwgqfkfrsVGrciFR9/VSzEdhg+yYMIYpBLOLYKVwgsWdl/LntpBo03SSopP
         3paeT+c4/w+g+nbOs/WpEwF94Rtciui2+qH1r+9+PDkYcjc/OxhWoTbEwpEzKlb0cYrr
         xF5A==
X-Gm-Message-State: APt69E39fCNpnxsBQUbXcTRJCvpBL0aMp/niunplX2oCgJLm/nPXN+FT
        varDLVrfrnICj6y6yTa1gq/o+A==
X-Google-Smtp-Source: AAOMgpciP19pl1LLRqxLcPGFslb+J+REb0suUL4rquFOsK41qx1GWvDIKiZLW92TGG3w08wxLSC9Mg==
X-Received: by 2002:a62:843:: with SMTP id c64-v6mr3124232pfd.14.1530725515608;
        Wed, 04 Jul 2018 10:31:55 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id d18-v6sm7060189pfn.118.2018.07.04.10.31.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 10:31:54 -0700 (PDT)
Date:   Wed, 4 Jul 2018 10:31:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Baoquan He <bhe@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] resource: Use 2-factor allocator calls
Message-ID: <20180704173153.GA34386@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As already done treewide, switch from open-coded multiplication to using
2-factor allocation helpers.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/resource.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index d717acd12bf4..16debbf2d24c 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -453,7 +453,7 @@ int walk_system_ram_res_rev(u64 start, u64 end, void *arg,
 	int ret = -1;
 
 	/* create a list */
-	rams = vmalloc(sizeof(struct resource) * rams_size);
+	rams = vmalloc(array_size(rams_size, sizeof(struct resource)));
 	if (!rams)
 		return ret;
 
@@ -469,8 +469,8 @@ int walk_system_ram_res_rev(u64 start, u64 end, void *arg,
 			int rams_new_size;
 
 			rams_new_size = rams_size + 16;
-			rams_new = vmalloc(sizeof(struct resource)
-							* rams_new_size);
+			rams_new = vmalloc(array_size(rams_new_size,
+						      sizeof(struct resource)));
 			if (!rams_new)
 				goto out;
 
-- 
2.17.1


-- 
Kees Cook
Pixel Security
