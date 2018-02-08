Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752515AbeBHUyH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 15:54:07 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38252 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752464AbeBHUxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 15:53:51 -0500
X-Google-Smtp-Source: AH8x226/WRl0PT8rYbe+bnTkITVLnt7dT22uGEYR/v5x2B5NYNxozy06IpclAR40WcnBPgAto3sNyA==
From: Matthias Kaehlcke <mka@chromium.org>
To: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        Harry Wentland <harry.wentland@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Justin TerAvest <teravest@chromium.org>,
        Craig Bergstrom <craigb@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 4/4] amdgpu/dc/calcs: Support clang option for stack alignment
Date: Thu,  8 Feb 2018 12:53:16 -0800
Message-Id: <20180208205316.93330-4-mka@chromium.org>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
In-Reply-To: <20180208205316.93330-1-mka@chromium.org>
References: <20180208205316.93330-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

calcs uses the compiler option -mpreferred-stack-boundary=4 to configure
a stack alignment of 16 bytes. Clang uses the option -mstack-alignment
instead, which expects as parameter the alignment in bytes, and not a
power of two like -mpreferred-stack-boundary.

Probe for both compiler options and use the correct one, similar to
what is done in arch/x86/Makefile.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v3:
- patch added

Note to self: if this patterns proliferates further we probably want to
put the evaluation of the correct compiler flag in some common place.

 drivers/gpu/drm/amd/display/dc/calcs/Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
index af0f452f3c9f..95f332ee3e7e 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
@@ -24,7 +24,13 @@
 # It calculates Bandwidth and Watermarks values for HW programming
 #
 
-calcs_ccflags := -mhard-float -msse -mpreferred-stack-boundary=4
+ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
+	cc_stack_align := -mpreferred-stack-boundary=4
+else ifneq ($(call cc-option, -mstack-alignment=16),)
+	cc_stack_align := -mstack-alignment=16
+endif
+
+calcs_ccflags := -mhard-float -msse $(cc_stack_align)
 
 CFLAGS_dcn_calcs.o := $(calcs_ccflags)
 CFLAGS_dcn_calc_auto.o := $(calcs_ccflags)
-- 
2.16.0.rc1.238.g530d649a79-goog
