Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752493AbeBHUxw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 15:53:52 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:40284 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752454AbeBHUxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 15:53:48 -0500
X-Google-Smtp-Source: AH8x227nnKYPXaCJsaoBy2ycrs2NcAfoRn3FY6KTOsqDDUkFHf7Ni7eBpQYyaE9HjX47ZjNtjmzlKQ==
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
Subject: [PATCH v3 3/4] amdgpu/dc/dml: Support clang option for stack alignment
Date: Thu,  8 Feb 2018 12:53:15 -0800
Message-Id: <20180208205316.93330-3-mka@chromium.org>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
In-Reply-To: <20180208205316.93330-1-mka@chromium.org>
References: <20180208205316.93330-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DML uses the compiler option -mpreferred-stack-boundary=4 to configure
a stack alignment of 16 bytes. Clang uses the option -mstack-alignment
instead, which expects as parameter the alignment in bytes, and not a
power of two like -mpreferred-stack-boundary.

Probe for both compiler options and use the correct one, similar to
what is done in arch/x86/Makefile.

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v3:
- adapted use of variable instead of subdir-ccflags-y

 drivers/gpu/drm/amd/display/dc/dml/Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 96b337a03172..782886cac61c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -24,7 +24,13 @@
 # It provides the general basic services required by other DAL
 # subcomponents.
 
-dml_ccflags := -mhard-float -msse -mpreferred-stack-boundary=4
+ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
+	cc_stack_align := -mpreferred-stack-boundary=4
+else ifneq ($(call cc-option, -mstack-alignment=16),)
+	cc_stack_align := -mstack-alignment=16
+endif
+
+dml_ccflags := -mhard-float -msse $(cc_stack_align)
 
 CFLAGS_display_mode_vba.o := $(dml_ccflags)
 CFLAGS_display_mode_lib.o := $(dml_ccflags)
-- 
2.16.0.rc1.238.g530d649a79-goog
