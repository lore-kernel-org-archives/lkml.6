Return-Path: <astrachan@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525322751; cv=none;
        d=google.com; s=arc-20160816;
        b=Dq2i20pk743ZScdsZ5qz2gHJY2EOVulsmlNO+OQ6C3XVl/HP9yegAlXv5Pre5iPCXa
         Pj9HQgm/pU2VIc5BIDb8mkcyg+OFwYgEb6t+Kl4bbXGAUhe62/GV99XsTVIdZTE//MId
         FYLbya+5ZXq50NfTS892fcMrwHJMUpiuXSJEmZMkbXhyj0Ebi58dFn3ufwY89SPL0nmP
         OHIS7p3HEx1pnel7/OlA/zMM3ueCiAhQTdGAvkame/5ovJSlgOgNRBQQREbxwZVlVDma
         d0l/R5OAAItSwTys9snX+oVom/EZqZya3FfmQoXan68k1JUudZ6QP2lCCTReM0aTEHab
         HuTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:arc-authentication-results;
        bh=dbFvVSZpyG34kCzphsPfkAUR0gkhL6gpP+C7uSTgU3A=;
        b=U88dxmoIbq3BdtRRpssbNY9XchREDWoTUevKC/5b3sqy1VEEOlWKxM62j2qW1aTZx+
         pPTxy79w/rAuxBH8Wgf+Ypt/gyCdChfeLLWEWXC74yv9w3W0R5wM6qE2Uym4x8ljYj5x
         JQp2iqSM5QUm71APErsWXw+iR3wu1cBeyauCJOjwNdUvvMg1fbQyVlmAkS5qA4QQPVSf
         EUowqonNVFlB/J84ck9LQKh0cO7XiZ8SQ2GNjVDTvaYqgLCCfVYpqgFWz7voP0cGyGgl
         wIh54ymSDtMiacupnIc/jUSvLmuOahVUNYY88l7CFUJNUVCELwynNuOsFuuLRBX/eVcB
         JrLg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=i2dzt6mf;
       spf=pass (google.com: domain of astrachan@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=astrachan@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=i2dzt6mf;
       spf=pass (google.com: domain of astrachan@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=astrachan@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AB8JxZryb7Egj1ZuLrULUJ2IVw1grO7whn10PMMMYJs7xFZCMtda5Kv79Wpy8hUMQt14TneKmbmuMg==
From: Alistair Strachan <astrachan@google.com>
To: linux-kernel@vger.kernel.org
Cc: Alistair Strachan <astrachan@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Martijn Coenen <maco@android.com>,
	Greg Hartman <ghartman@google.com>,
	devel@driverdev.osuosl.org,
	kernel-team@android.com
Subject: [PATCH 1/3] staging: Android: vsoc: Create wc kernel mapping for region shm.
Date: Wed,  2 May 2018 21:45:21 -0700
Message-Id: <20180503044521.156965-1-astrachan@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599416828995084429?=
X-GMAIL-MSGID: =?utf-8?q?1599416828995084429?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Map the region shm as write-combining instead of uncachable.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arve Hjønnevåg <arve@android.com>
Cc: Todd Kjos <tkjos@android.com>
Cc: Martijn Coenen <maco@android.com>
Cc: Greg Hartman <ghartman@google.com>
Cc: devel@driverdev.osuosl.org
Cc: kernel-team@android.com
Signed-off-by: Alistair Strachan <astrachan@google.com>
---
 drivers/staging/android/TODO   | 1 -
 drivers/staging/android/vsoc.c | 4 +---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/android/TODO b/drivers/staging/android/TODO
index 2ea6f97b8f0f..ebd6ba3ae02e 100644
--- a/drivers/staging/android/TODO
+++ b/drivers/staging/android/TODO
@@ -18,7 +18,6 @@ vsoc.c, uapi/vsoc_shm.h
    waiting threads. We should eventually use multiple queues and select the
    queue based on the region.
  - Add debugfs support for examining the permissions of regions.
- - Use ioremap_wc instead of ioremap_nocache.
  - Remove VSOC_WAIT_FOR_INCOMING_INTERRUPT ioctl. This functionality has been
    superseded by the futex and is there for legacy reasons.
 
diff --git a/drivers/staging/android/vsoc.c b/drivers/staging/android/vsoc.c
index 587c66d709b9..794137b7751f 100644
--- a/drivers/staging/android/vsoc.c
+++ b/drivers/staging/android/vsoc.c
@@ -802,9 +802,7 @@ static int vsoc_probe_device(struct pci_dev *pdev,
 
 	dev_info(&pdev->dev, "shared memory @ DMA %p size=0x%zx\n",
 		 (void *)vsoc_dev.shm_phys_start, vsoc_dev.shm_size);
-	/* TODO(ghartman): ioremap_wc should work here */
-	vsoc_dev.kernel_mapped_shm = ioremap_nocache(
-			vsoc_dev.shm_phys_start, vsoc_dev.shm_size);
+	vsoc_dev.kernel_mapped_shm = pci_iomap_wc(pdev, SHARED_MEMORY_BAR, 0);
 	if (!vsoc_dev.kernel_mapped_shm) {
 		dev_err(&vsoc_dev.dev->dev, "cannot iomap region\n");
 		vsoc_remove_device(pdev);
