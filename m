Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970893AbeCSTPM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 15:15:12 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35353 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969607AbeCSTPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 15:15:06 -0400
X-Google-Smtp-Source: AG47ELvIDdBNwAZqXQYv2dh1ll37JZ1d32vfqo3YVcoinWEPq5m4kpvzzsogoVKbun9z2QFKRtdVRg==
From: Matthias Kaehlcke <mka@chromium.org>
To: Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2] drm/i915: Disable some extra clang warnings
Date: Mon, 19 Mar 2018 12:14:51 -0700
Message-Id: <20180319191451.83910-1-mka@chromium.org>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
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

Fixes: 39bf4de89ff7 ("drm/i915: Add -Wall -Wextra to our build, set
warnings to full")
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v2:
- rebased on drm-tip
- added comment indicating that disabled warnings are clang warnings

 drivers/gpu/drm/i915/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
index 4eee91a3a236..9717c037b582 100644
--- a/drivers/gpu/drm/i915/Makefile
+++ b/drivers/gpu/drm/i915/Makefile
@@ -18,6 +18,11 @@ subdir-ccflags-y += $(call cc-disable-warning, type-limits)
 subdir-ccflags-y += $(call cc-disable-warning, missing-field-initializers)
 subdir-ccflags-y += $(call cc-disable-warning, implicit-fallthrough)
 subdir-ccflags-y += $(call cc-disable-warning, unused-but-set-variable)
+# clang warnings
+subdir-ccflags-y += $(call cc-disable-warning, sign-compare)
+subdir-ccflags-y += $(call cc-disable-warning, sometimes-uninitialized)
+subdir-ccflags-y += $(call cc-disable-warning, unneeded-internal-declaration)
+subdir-ccflags-y += $(call cc-disable-warning, initializer-overrides)
 subdir-ccflags-$(CONFIG_DRM_I915_WERROR) += -Werror
 
 # Fine grained warnings disable
-- 
2.16.2.804.g6dcf76e118-goog
