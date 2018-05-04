Return-Path: <maco@android.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525463851; cv=none;
        d=google.com; s=arc-20160816;
        b=oDGGCjQ3PAPbP0r8AFJRdIN42B/1EdvOK8+vZ9WuuAqEyxIxAAMD/mAKQIcaFLILzD
         sWMwOuaYBk7DesUExhw0ec8XQiryk8uEK7lHdCjS20g3hu0Wf2WUp0ET8DoorKu8mF1L
         9sQgSDRY8PaFNnSkVzox/vP/snNFxmWf4Q6Ds55JesCs14Hut1tLstuwruizZ2VDOaWL
         Q2c/b4Gevo/yqqUh2+mHR1UR6NT3963p1TV1XRdEtpyXgr+5UVGa83j6aAmwvLyyixcA
         QGSTq0QRDLiiJPln3ErpOVH3SwBi5bcmX0e2fx/xFhcUyvd/E/K1tRsS1fGQKbJd/LyP
         M1Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=z9Fvghihfq4GmuVJJV3nnfq8fxha6avI8CazqMm2rXc=;
        b=qaUsLNgEGydgm3WU7BCYerVEd+QFtUFY3mz30EhvpQ1TPJ6FbX628JWxA7e+C4+Rnb
         HUmvJVrV/hDwqMVU2jw5z4m9puXVqycMwEUlrFRcZ2eJRWmoBs/WtQ3Wd59L727LruZO
         tnLoLIHHkgUmlCHua8Q2gp6RuhDBr+Itgk/kMwxrAcxwV5k3TE7dhoUJlVLuAyiDGrVJ
         tNA4t5MTASN60JlIFo00nVuYNuxiCGwMxDSKQ1FiPsXixkVMIdtpjNo6IUjSvMox012r
         8ixSkyaBrznHxo7ht3kXllD/Pde2KhjqdEK2tJ1KglzBoUcS0wzny0q+HUNAJrlpywGJ
         nYpg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@android.com header.s=20161025 header.b=s/x7tR9X;
       spf=pass (google.com: domain of maco@android.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=maco@android.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=android.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@android.com header.s=20161025 header.b=s/x7tR9X;
       spf=pass (google.com: domain of maco@android.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=maco@android.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=android.com
X-Google-Smtp-Source: AB8JxZqethqwcYjTOtGR1uiofMJ5y7nFHCTkz7JVf8NRLzBwhgERXcTCFL2FAzhUOqYd27hJm8MtNw==
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
Subject: [PATCH] ANDROID: binder: remove 32-bit binder interface.
Date: Fri,  4 May 2018 12:57:28 -0700
Message-Id: <20180504195728.72932-1-maco@android.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599564783998052037?=
X-GMAIL-MSGID: =?utf-8?q?1599564783998052037?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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

[0]: https://android-review.googlesource.com/c/platform/build/+/595193

Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/android/Kconfig  | 13 -------------
 drivers/android/binder.c |  4 ----
 2 files changed, 17 deletions(-)

diff --git a/drivers/android/Kconfig b/drivers/android/Kconfig
index 7dce3795b887..432e9ad77070 100644
--- a/drivers/android/Kconfig
+++ b/drivers/android/Kconfig
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
