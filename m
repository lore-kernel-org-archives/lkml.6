Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8988AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E02922419
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SWInm5I8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E02922419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbeKOP6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 10:58:52 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:45819 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbeKOP6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 10:58:51 -0500
Received: by mail-yb1-f196.google.com with SMTP id 131-v6so7889194ybe.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 21:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eQVF/NE5LgDyDCoQh0ftmhN/0hZKHUsKcfSHpKIBIX8=;
        b=SWInm5I83ZSSOs6Oky+TLdEe+XVLwX+bqxuLVQQgTl88XpOcoinPwkYI+tOOOTsO7n
         am1IVi9JIJYDZ6Ew3fn3vMEfaOurkJV/Lq1FVbuFxPN/BqJUd1dWb5lwbD9suCMIZ42u
         XVhdIVsHj37uVaAxN1tR5PVJ2GURTvxxka/94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eQVF/NE5LgDyDCoQh0ftmhN/0hZKHUsKcfSHpKIBIX8=;
        b=KsRkJuQD1xbpvLwj7j9yYfYMVfsmt2R4eiqoeclLSmq6XIniGLqFScgNhLTfi86I4T
         p/snNq+1v6omHuRBuv2wcNKT4hxqUNGitKcXEcGVoav4gmTw0QJ+jij3hb2pt9HqJ3+9
         X79xgbJAWvAVrRBJcy0AKkvNN/dnFKw8QodSxk67FVvMgxd2OmwEc6f+Zo1isrK2gxam
         jyVHx3+STX5UXOe/rKTyNSUGutX0+DelWUQOmcnbqfqxUZgjkB4Wa3b028yjeftoBYYz
         VlTa01FmkdoXEGFvPWR1tccVOKMua1YcOpUhptJv0XUfgs8YTooB2vOLM/+0tgdEHx77
         B4LA==
X-Gm-Message-State: AGRZ1gIstYnj2v4aXqeeEt7R19HmMb2PKcyZd3UlKvZXDKhRcHkYMvYF
        O5EvYWAFVcEJdZmSJT+NeRKEKQ==
X-Google-Smtp-Source: AJdET5eoU0+q3M0HQPYUhYaHvFr9ychd7XlFTSupZz6V8HiyT8N9roETbqi5SXGMlye4WKAoeWq5pA==
X-Received: by 2002:a25:ae92:: with SMTP id b18-v6mr4695234ybj.286.1542261145471;
        Wed, 14 Nov 2018 21:52:25 -0800 (PST)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id j185-v6sm7067497ywf.4.2018.11.14.21.52.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 21:52:25 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     prudo@linux.ibm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v16 03/16] s390, kexec_file: drop arch_kexec_mem_walk()
Date:   Thu, 15 Nov 2018 14:52:42 +0900
Message-Id: <20181115055254.2812-4-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181115055254.2812-1-takahiro.akashi@linaro.org>
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since s390 already knows where to locate buffers, calling
arch_kexec_mem_walk() has no sense. So we can just drop it as kbuf->mem
indicates this while all other architectures sets it to 0 initially.

This change is a preparatory work for the next patch, where all the
variant memory walks, either on system resource or memblock, will be
put in one common place so that it will satisfy all the architectures'
need.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Philipp Rudo <prudo@linux.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
---
 arch/s390/kernel/machine_kexec_file.c | 10 ----------
 include/linux/kexec.h                 |  8 ++++++++
 kernel/kexec_file.c                   |  4 ++++
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index f413f57f8d20..32023b4f9dc0 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -134,16 +134,6 @@ int kexec_file_add_initrd(struct kimage *image, struct s390_load_data *data,
 	return ret;
 }
 
-/*
- * The kernel is loaded to a fixed location. Turn off kexec_locate_mem_hole
- * and provide kbuf->mem by hand.
- */
-int arch_kexec_walk_mem(struct kexec_buf *kbuf,
-			int (*func)(struct resource *, void *))
-{
-	return 1;
-}
-
 int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 				     Elf_Shdr *section,
 				     const Elf_Shdr *relsec,
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 49ab758f4d91..f378cb786f1b 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -145,6 +145,14 @@ int kexec_image_probe_default(struct kimage *image, void *buf,
 			      unsigned long buf_len);
 int kexec_image_post_load_cleanup_default(struct kimage *image);
 
+/*
+ * If kexec_buf.mem is set to this value, kexec_locate_mem_hole()
+ * will try to allocate free memory. Arch may overwrite it.
+ */
+#ifndef KEXEC_BUF_MEM_UNKNOWN
+#define KEXEC_BUF_MEM_UNKNOWN 0
+#endif
+
 /**
  * struct kexec_buf - parameters for finding a place for a buffer in memory
  * @image:	kexec image in which memory to search.
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 9ce6672f4fa3..9e6529da12ed 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -532,6 +532,10 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
 {
 	int ret;
 
+	/* Arch knows where to place */
+	if (kbuf->mem != KEXEC_BUF_MEM_UNKNOWN)
+		return 0;
+
 	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
 
 	return ret == 1 ? 0 : -EADDRNOTAVAIL;
-- 
2.19.0

