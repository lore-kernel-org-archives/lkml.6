Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361BEC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0CE121746
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IkRQaACF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0CE121746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbeI1NKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:10:25 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:36552 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeI1NKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:10:24 -0400
Received: by mail-pg1-f181.google.com with SMTP id f18-v6so222557pgv.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 23:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GkP10Cl5MP4nxVesufI8pOCjA8cWm/ywpOEKb9ueudc=;
        b=IkRQaACFLS0lvXgRp3LiGqnUuHtzQt5Y9M7/3TW1yIkM8S+qtrisT+jwz/Z+t5Mtt6
         EwAYVYbezOlY0HkVAPEh813zdFagQ85MAMNEph2blAqjyEocIINOAM1T8nVMc2kK+wSs
         lYdOPoCwYjU5W4wPToawZjAor310uRDhp2A/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GkP10Cl5MP4nxVesufI8pOCjA8cWm/ywpOEKb9ueudc=;
        b=SfHHPyIT7EeRSfai41KXKyA6T5G0vf1sryjV+LLrVA/ENy8slDAv6dNgiwXkIU8PkW
         1O8oTNf6KcN3ek8esbc0Sud/p4ApcAZTNv8WbvLHszaoM/nY2L3n3LYXcOL4KVDtQUV+
         lffCbqadcNXAfO1hvycIW5mvEvdu8PqbVp9zQSjblSjiUY3Dy8b1fZNbjhV+CQLahaeI
         ATmFMfGQxN2ZnGICAdUIny55Ea0QxyOalD+EnaUa8QP4Bu49z+aqURTm6N/D2BO38gwm
         UO+2spYme+unNfbAQyA/nVQAWG0NzLnFAGrXWsBnhpxwPht6I438BiFfh1qaXQoifB/L
         p25Q==
X-Gm-Message-State: ABuFfogXfFEIwSc8uvhN90rDDDz/j/48a5+eEdd8mTeGZMG6qJL7p76z
        04tkrVBlfHfRwnsgAmDatcY5nw==
X-Google-Smtp-Source: ACcGV63YSylKyCjjqizFkyw8WfxTANncmJVizh2MBUkwGi/GB112j0mSsGtUxJMIwL8i7lNilwkwQA==
X-Received: by 2002:a17:902:543:: with SMTP id 61-v6mr14871971plf.126.1538117289637;
        Thu, 27 Sep 2018 23:48:09 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id e68-v6sm7165147pfg.93.2018.09.27.23.48.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 23:48:08 -0700 (PDT)
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
Subject: [PATCH v15 03/16] s390, kexec_file: drop arch_kexec_mem_walk()
Date:   Fri, 28 Sep 2018 15:48:28 +0900
Message-Id: <20180928064841.14117-4-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180928064841.14117-1-takahiro.akashi@linaro.org>
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
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
index 63c7ce1c0c3e..0fcaa86219d1 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -534,6 +534,10 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
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

