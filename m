Return-Path: <maco@android.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526028334; cv=none;
        d=google.com; s=arc-20160816;
        b=HCj1WNoLDP3AmV+Pc2I87FBG7O+i7vGdeHsoebdvukrr+xTCdfiPgJILZbK3Bb06da
         zvZujCM0Ss/fMaIucy4qxbEV4lBVyazksF/xnY4YiKxMOoUM70A4725eideB9jVbmTZO
         JTZ/av7duXs0phV61Zuy+j6pjSNV1kP4XHrSi7P1pLQgyEJg2OXm1u4HYv45EAMCaTX4
         G0GCmYOlXk+7LK3m9b03A0uEm6qB7RqmC0VnDEVZ4fE7huIzg8APX/ULe1fC+ywVFZc5
         7X4rJblBRIkXoihDSf5gcZGTyLb7AJOzUmAQExSrMxXUD0uMC2ToVMHnO2tLsMIUeRmK
         KAjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=yvwj9YoLVBgZFds3y//EPWw+MOAC3dKR8RvLn1c/fpk=;
        b=L2Wam0448R4gRul5CGlSbXyHp3G5eEuMNKvjyUpSl3eWBn0/EIn2KiLUG1SKlzbsc2
         ExJPkjMnr+g30JIN1hIH3B27mMygaIlIM7dK+A3fz3U/j+BpJHKRMxEvRJeY1I76xxtU
         egEyeymrC0BF8XSyw3TQYnsCi2KsV9OwzH/o/CgpAbz7DFTm8LD+GqAqYIgP5DLe9lEg
         Xq3pa+jwFumbBgNxxbj9miw1N8sJ03Yc8shFxaGGkd28dxGgKs7dW4cMSPjn6/FFvNrW
         ERSH1WTXxPR/Gcgm8YZ/daWmsEDiqXXvzYTKwtkIsOT5q6R2eGwwBpGOZOGhdANQVd+Y
         PsoA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@android.com header.s=20161025 header.b=qOGCoxfs;
       spf=pass (google.com: domain of maco@android.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=maco@android.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=android.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@android.com header.s=20161025 header.b=qOGCoxfs;
       spf=pass (google.com: domain of maco@android.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=maco@android.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=android.com
X-Google-Smtp-Source: AB8JxZrAYLmBgB3niEishsgGPs4dglNonGJobuD93eodZbvkzdmLK/A21RUj9TwfCWcKQpdF6PrIUQ==
From: Martijn Coenen <maco@android.com>
To: john.stultz@linaro.org,
	tkjos@google.com,
	arve@android.com,
	amit.pundir@linaro.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	devel@driverdev.osuosl.org,
	maco@google.com,
	Martijn Coenen <maco@android.com>
Subject: [PATCH v2] ANDROID: binder: remove 32-bit binder interface.
Date: Fri, 11 May 2018 01:45:24 -0700
Message-Id: <20180511084524.234119-1-maco@android.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599564783998052037?=
X-GMAIL-MSGID: =?utf-8?q?1600156687301192332?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Martijn Coenen <maco@google.com>

New devices launching with Android P need to use the 64-bit
binder interface, even on 32-bit SoCs [0].

This change removes the Kconfig option to select the 32-bit
binder interface. We don't think this will affect existing
userspace for the following reasons:
1) The latest Android common tree is 4.14, so we don't
   believe any Android devices are on kernels >4.14.
2) Android devices launch on an LTS release and stick with
   it, so we wouldn't expect devices running on <= 4.14 now
   to upgrade to 4.17 or later. But even if they did, they'd
   rebuild the world (kernel + userspace) anyway.
3) Other userspaces like 'anbox' are already using the
   64-bit interface.

Note that this change doesn't remove the 32-bit UAPI
itself; the reason for that is that Android userspace
always uses the latest UAPI headers from upstream, and
userspace retains 32-bit support for devices that are
upgrading. This will be removed as well in 2-3 years,
at which point we can remove the code from the UAPI
as well.

Finally, this change introduces build errors on archs where
64-bit get_user/put_user is not supported, so make binder
unavailable on m68k (which wouldn't want it anyway).

[0]: https://android-review.googlesource.com/c/platform/build/+/595193

Signed-off-by: Martijn Coenen <maco@android.com>
---
Changes in v2:
  - Dropped support for m68k to avoid build errors.

 drivers/android/Kconfig  | 15 +--------------
 drivers/android/binder.c |  4 ----
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/android/Kconfig b/drivers/android/Kconfig
index 7dce3795b887..ee4880bfdcdc 100644
--- a/drivers/android/Kconfig
+++ b/drivers/android/Kconfig
@@ -10,7 +10,7 @@ if ANDROID
 
 config ANDROID_BINDER_IPC
 	bool "Android Binder IPC Driver"
-	depends on MMU
+	depends on MMU && !M68K
 	default n
 	---help---
 	  Binder is used in Android for both communication between processes,
@@ -32,19 +32,6 @@ config ANDROID_BINDER_DEVICES
 	  created. Each binder device has its own context manager, and is
 	  therefore logically separated from the other devices.
 
-config ANDROID_BINDER_IPC_32BIT
-	bool "Use old (Android 4.4 and earlier) 32-bit binder API"
-	depends on !64BIT && ANDROID_BINDER_IPC
-	default y
-	---help---
-	  The Binder API has been changed to support both 32 and 64bit
-	  applications in a mixed environment.
-
-	  Enable this to support an old 32-bit Android user-space (v4.4 and
-	  earlier).
-
-	  Note that enabling this will break newer Android user-space.
-
 config ANDROID_BINDER_IPC_SELFTEST
 	bool "Android Binder IPC Driver Selftest"
 	depends on ANDROID_BINDER_IPC
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index e578eee31589..2ee9fb02dfb8 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -72,10 +72,6 @@
 #include <linux/security.h>
 #include <linux/spinlock.h>
 
-#ifdef CONFIG_ANDROID_BINDER_IPC_32BIT
-#define BINDER_IPC_32BIT 1
-#endif
-
 #include <uapi/linux/android/binder.h>
 #include "binder_alloc.h"
 #include "binder_trace.h"
-- 
2.17.0.441.gb46fe60e1d-goog
