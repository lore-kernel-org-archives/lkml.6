Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFB8C7113E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B201E208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g6EVVIja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B201E208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbeJPEVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 00:21:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45677 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeJPEVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 00:21:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id u12-v6so10238630pfn.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 13:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mR/nT5nCH8r3TvWFMt9H5xUCBQQEUFMwnxIrguxIQ9I=;
        b=g6EVVIjapTI5b5L3/qLj8K2l+oVt7Gtszlp1WrYt0FKfZjD+AXHDiXZ5AKmNMIB/Gt
         O9gxbNiIRGBSnuvVFzVajfbrmKviQunsrpfxnQWSIN+R6ZkrwFnJtctIthVI2rKgZANs
         Z6B+gB10TRvmMLyeRrLvT/9+VA7EKsHBs/svw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mR/nT5nCH8r3TvWFMt9H5xUCBQQEUFMwnxIrguxIQ9I=;
        b=RhGR1x5Toznt41CkWM8AlQsV0Wige4XgGPYRIeQOzqIT65cCY8QukMgilwyBbed3CZ
         48w+dAsK+SWUG/mUM5mqurKLaalwNCFD0EwkbhaeTOvrgQhE/nGF1LkS3C3KYfj5/XWa
         LMqHNm10+sa9gfC3mzHbtBgYSGEIGDU5s6HYrZG33j6IOZReeARvuT0jaZCy5I5vBuN0
         yYwk4Hu8QKJDZhv6Abo63yY5xT9VoIi8trPW9oRZi9HFXRFYLXAssZ/Vth6Fru+8uEs9
         a1J65RIFPqF5inQPhZE32LPzm96pw2vUKJoz4CbNiQAWpmroWPorbXdUgLkXf2hk9QC4
         Xkhw==
X-Gm-Message-State: ABuFfohNBnRG964WuhobBY0ZJWpLBE8R8zuuqqBazUkxOZwZQBTnYk1y
        08ho0Aq8+h2nERMi0L9Hpc8rxw==
X-Google-Smtp-Source: ACcGV61MlM8NEJUHupS9dc3+5rBJfHhgf6100fL48kR0c7MkFoxnUI8fS8nXOMXMje/SON0BKMIQNA==
X-Received: by 2002:a63:5a54:: with SMTP id k20-v6mr17566147pgm.297.1539635652175;
        Mon, 15 Oct 2018 13:34:12 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id j2-v6sm16011954pfj.91.2018.10.15.13.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 13:34:11 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH] drm/i915: Silence build error with UBSAN
Date:   Mon, 15 Oct 2018 13:34:10 -0700
Message-Id: <20181015203410.155997-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I enable UBSAN and compile this driver with clang I get the
following build error:

drivers/gpu/drm/i915/intel_engine_cs.o: In function `intel_engine_init_execlist':
drivers/gpu/drm/i915/intel_engine_cs.c:411: undefined reference to `__compiletime_assert_411'

from what I can figure out, the compiler can't optimize
execlists_num_ports() sufficiently enough at compile time to figure out
that the 'execlists->port_mask = 1' assignment one line above the
BUILD_BUG_ON_NOT_POWER_OF_2 check will make execlists_num_ports() return
2. Most likely that's because UBSAN is going to check the load inside
execlists_num_ports() and that check isn't omitted so the optimizer
can't optimize away the whole function.

So let's just change this check to cause a build error when the maximum
number of ports isn't a power of two. It looks like this is similar to
what's being checked here so this might work well enough.

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/i915/intel_engine_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/intel_engine_cs.c b/drivers/gpu/drm/i915/intel_engine_cs.c
index 217ed3ee1cab..bdf75628ed83 100644
--- a/drivers/gpu/drm/i915/intel_engine_cs.c
+++ b/drivers/gpu/drm/i915/intel_engine_cs.c
@@ -463,7 +463,7 @@ static void intel_engine_init_execlist(struct intel_engine_cs *engine)
 	struct intel_engine_execlists * const execlists = &engine->execlists;
 
 	execlists->port_mask = 1;
-	BUILD_BUG_ON_NOT_POWER_OF_2(execlists_num_ports(execlists));
+	BUILD_BUG_ON_NOT_POWER_OF_2(EXECLIST_MAX_PORTS);
 	GEM_BUG_ON(execlists_num_ports(execlists) > EXECLIST_MAX_PORTS);
 
 	execlists->queue_priority = INT_MIN;
-- 
Sent by a computer through tubes

