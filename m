Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751659AbeDYG3g (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 02:29:36 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36905 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751320AbeDYG04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 02:26:56 -0400
X-Google-Smtp-Source: AB8JxZqnJeFY4zhhPhr/l1Z50x0Eaj9A31Q/vCk+MNJ2W3QVPo0HCcj3qNHEGoDAjdl59Pmd50NarA==
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de
Cc: ard.biesheuvel@linaro.org, james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v9 02/11] kexec_file: make kexec_image_post_load_cleanup_default() global
Date: Wed, 25 Apr 2018 15:26:20 +0900
Message-Id: <20180425062629.29404-3-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425062629.29404-1-takahiro.akashi@linaro.org>
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change this function from static to global so that arm64 can implement
its own arch_kimage_file_post_load_cleanup() later using
kexec_image_post_load_cleanup_default().

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
---
 include/linux/kexec.h | 1 +
 kernel/kexec_file.c   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 9e4e638fb505..49ab758f4d91 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -143,6 +143,7 @@ extern const struct kexec_file_ops * const kexec_file_loaders[];
 
 int kexec_image_probe_default(struct kimage *image, void *buf,
 			      unsigned long buf_len);
+int kexec_image_post_load_cleanup_default(struct kimage *image);
 
 /**
  * struct kexec_buf - parameters for finding a place for a buffer in memory
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 75d8e7cf040e..eef89d9b1f03 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -78,7 +78,7 @@ void * __weak arch_kexec_kernel_image_load(struct kimage *image)
 	return kexec_image_load_default(image);
 }
 
-static int kexec_image_post_load_cleanup_default(struct kimage *image)
+int kexec_image_post_load_cleanup_default(struct kimage *image)
 {
 	if (!image->fops || !image->fops->cleanup)
 		return 0;
-- 
2.17.0
