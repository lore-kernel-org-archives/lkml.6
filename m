Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbeBHBWM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 20:22:12 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:38598 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750736AbeBHBWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 20:22:10 -0500
X-Google-Smtp-Source: AH8x225gxRrIcEKFgygxM9qQH7v3rRlGNw9CtN8c1Y7N1zFiuhqYz3PpXg9xggeR06oMwC+f+RnGJg==
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
Subject: [PATCH 2/2] amdgpu/dc/dml: Support clang option for stack alignment
Date: Wed,  7 Feb 2018 17:21:56 -0800
Message-Id: <20180208012156.165934-2-mka@chromium.org>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
In-Reply-To: <20180208012156.165934-1-mka@chromium.org>
References: <20180208012156.165934-1-mka@chromium.org>
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
 drivers/gpu/drm/amd/display/dc/dml/Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index b8cadf833e71..740975931d21 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -24,7 +24,13 @@
 # It provides the general basic services required by other DAL
 # subcomponents.
 
-subdir-ccflags-y += -mhard-float -msse -mpreferred-stack-boundary=4
+ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
+	cc_stack_align=-mpreferred-stack-boundary=4
+else ifneq ($(call cc-option, -mstack-alignment=16),)
+	cc_stack_align := -mstack-alignment=16
+endif
+
+subdir-ccflags-y += -mhard-float -msse $(cc_stack_align)
 
 DML = display_mode_lib.o display_rq_dlg_calc.o \
 	  display_rq_dlg_helpers.o dml1_display_rq_dlg_calc.o \
-- 
2.16.0.rc1.238.g530d649a79-goog
