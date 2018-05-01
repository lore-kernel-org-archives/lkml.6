Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756351AbeEASZD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 14:25:03 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34904 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756045AbeEASZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 14:25:02 -0400
X-Google-Smtp-Source: AB8JxZrKgr59BaOAJr5qUFaJCf2JhxY0NNSDkDR625l5C+34xBkDmMTtbLbp+FCl9yPdupZkmloSmg==
From: Matthias Kaehlcke <mka@chromium.org>
To: Chris Wilson <chris@chris-wilson.co.uk>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3] drm/i915: Disable some extra clang warnings
Date: Tue,  1 May 2018 11:24:40 -0700
Message-Id: <20180501182440.70121-1-mka@chromium.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 39bf4de89ff7 ("drm/i915: Add -Wall -Wextra to our build, set
warnings to full") enabled extra warnings for i915 to spot possible
bugs in new code, and then disabled a subset of these warnings to keep
the current code building without warnings (with gcc). Enabling the
extra warnings also enabled some additional clang-only warnings, as a
result building i915 with clang currently is extremely noisy. For now
also disable the clang warnings sign-compare, sometimes-uninitialized,
unneeded-internal-declaration and initializer-overrides. If desired
they can be re-enabled after the code has been fixed.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v3:
- don't disable -Wunneeded-internal-declaration , the only occurrence
  can be fixed in the code
- removed 'Fixes' tag, since backporting is not necessary

 drivers/gpu/drm/i915/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
index 9bee52a949a9..dfe01452c8d1 100644
--- a/drivers/gpu/drm/i915/Makefile
+++ b/drivers/gpu/drm/i915/Makefile
@@ -18,6 +18,10 @@ subdir-ccflags-y += $(call cc-disable-warning, type-limits)
 subdir-ccflags-y += $(call cc-disable-warning, missing-field-initializers)
 subdir-ccflags-y += $(call cc-disable-warning, implicit-fallthrough)
 subdir-ccflags-y += $(call cc-disable-warning, unused-but-set-variable)
+# clang warnings
+subdir-ccflags-y += $(call cc-disable-warning, sign-compare)
+subdir-ccflags-y += $(call cc-disable-warning, sometimes-uninitialized)
+subdir-ccflags-y += $(call cc-disable-warning, initializer-overrides)
 subdir-ccflags-$(CONFIG_DRM_I915_WERROR) += -Werror
 
 # Fine grained warnings disable
-- 
2.17.0.441.gb46fe60e1d-goog
