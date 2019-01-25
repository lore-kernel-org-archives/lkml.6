Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DF5C282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 00:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8521C218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 00:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="odbvWhwT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbfAYAxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 19:53:24 -0500
Received: from mail-vs1-f73.google.com ([209.85.217.73]:36127 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbfAYAxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 19:53:23 -0500
Received: by mail-vs1-f73.google.com with SMTP id r133so2998565vsc.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 16:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=lImYpiAn1uJlETxYy7nHGrYS1qOku0eBJBZYPcEb9VQ=;
        b=odbvWhwT6481BRFmWz+HTJ5w2iyTkKq165H7DpqSBNd95LzJ58leC9HI1ts+um3zTt
         sGLG5AE3GNvCFdvII60PxnCfPGSHYHSWqIIups9yHdHh/9ULFPeNDVbtKl4GkMhOMDvX
         IFWWA7vUoilKzA+26J924P2pgfXlAVQ+zuEAEkGGfzAd6lsLUeir/3i2WyuxOUsIIiaQ
         AzPCMHrjHtHJXki4Y7B6JN2qTo1Qhr+HrE2rS3dLz0Sjr4IHtQkeWqWt0Lwrx+8Oobsg
         r7dY2PQ82m9JQv5WNJ5AK6BHsbKX+eeIkK4GXmytnBVHfssgAXA4b5J92BtycUH/ahCd
         Rl3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=lImYpiAn1uJlETxYy7nHGrYS1qOku0eBJBZYPcEb9VQ=;
        b=qjHhUQpDJK4tPPDteu6cVD8BK8hiOCPaB7mxAT8oV7MsPgm6UtgT2LFUo8E4gR+paj
         slkSimoSD8oagjLkGg4L0yuSnCu5fTKP4XOeDiyAK+Sax6aV0OwaB3eaERQrPa5WcYFV
         gfhV5NiI/e2Yw6Xm6ACRNTvCMGT9MUJKsg6EESPNn5yXXWUgLElfM2oVwCOk01k/jEyv
         8sDLUXwCi+OUp10QMNLca2vV8JmPqXcyURJg86YIqV0UlhYY4wKQ4usx6Qjdq5Gv4FjF
         3qMV3K5lXGKMpl9UdYKdQ5S1/zMJXlCAj2wYRgGlvhMoQ0Q+hVZtaDmwLyf4qkUbiLMB
         ibLQ==
X-Gm-Message-State: AJcUukdh4EEiDxAW8z56yF6FrMHW3dUFezHYDJnyrrKto9UgNK21kB7I
        ra/U0CKo+A80/Bi1iz3CYr6tHaV0Nt1Uz4/Yz4s=
X-Google-Smtp-Source: ALg8bN5gjC2t14WSAJstQ+OAgdmNd0+EtOob/jdgNeSBgNP66NpeJ/4VYrKvORwUINDWmrKNyJ2F3mUHXNfET2Cl0WY=
X-Received: by 2002:a67:8542:: with SMTP id h63mr7284273vsd.43.1548377602513;
 Thu, 24 Jan 2019 16:53:22 -0800 (PST)
Date:   Thu, 24 Jan 2019 16:52:59 -0800
Message-Id: <20190125005304.183322-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
X-Patchwork-Bot: notify
Subject: [PATCH] drm/amd/display: add -msse2 to prevent Clang from emitting
 libcalls to undefined SW FP routines
From:   ndesaulniers@google.com
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     Nick Desaulniers <ndesaulniers@google.com>, stable@vger.kernel.org,
        S@google.com, Shirish <Shirish.S@amd.com>,
        Matthias Kaehlcke <mka@google.com>,
        James Y Knight <jyknight@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "=?UTF-8?q?Michel=20D=C3=A4nzer?=" <michel.daenzer@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/x86/Makefile disables SSE and SSE2 for the whole kernel.  The
AMDGPU drivers modified in this patch re-enable SSE but not SSE2.  Turn
on SSE2 to support emitting double precision floating point instructions
rather than calls to non-existent (usually available from gcc_s or
compiler_rt) floating point helper routines.

Link: https://gcc.gnu.org/onlinedocs/gccint/Soft-float-library-routines.html
Link: https://github.com/ClangBuiltLinux/linux/issues/327
Cc: stable@vger.kernel.org # 4.19
Reported-by: S, Shirish <Shirish.S@amd.com>
Reported-by: Matthias Kaehlcke <mka@google.com>
Suggested-by: James Y Knight <jyknight@google.com>
Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/gpu/drm/amd/display/dc/calcs/Makefile | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
index 95f332ee3e7e..dc85a3c088af 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
@@ -30,7 +30,7 @@ else ifneq ($(call cc-option, -mstack-alignment=16),)
 	cc_stack_align := -mstack-alignment=16
 endif
 
-calcs_ccflags := -mhard-float -msse $(cc_stack_align)
+calcs_ccflags := -mhard-float -msse -msse2 $(cc_stack_align)
 
 CFLAGS_dcn_calcs.o := $(calcs_ccflags)
 CFLAGS_dcn_calc_auto.o := $(calcs_ccflags)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index d97ca6528f9d..33c7d7588712 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -30,7 +30,7 @@ else ifneq ($(call cc-option, -mstack-alignment=16),)
 	cc_stack_align := -mstack-alignment=16
 endif
 
-dml_ccflags := -mhard-float -msse $(cc_stack_align)
+dml_ccflags := -mhard-float -msse -msse2 $(cc_stack_align)
 
 CFLAGS_display_mode_lib.o := $(dml_ccflags)
 CFLAGS_display_pipe_clocks.o := $(dml_ccflags)
-- 
2.20.1.321.g9e740568ce-goog

