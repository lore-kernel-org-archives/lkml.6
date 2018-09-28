Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E689FC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49862172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WPP9Dm8h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49862172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbeI1NLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:11:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36368 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728765AbeI1NLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:11:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id b7-v6so3642319pfo.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 23:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A1to76Muk1fdla+xjmMFJtb5BFlQOFVgZ1KKX32hm3g=;
        b=WPP9Dm8h5cUbvm4Vfgv7CG3sbSL7MvhM+E7czCqoCAP7d5W0p+jJMUvGc6ekYRON7Q
         WjHEuVNSOUEXW6cep8nc4kw9iwIZywVej83PvFnvtFRAHMXDWfv8pwR4EjzmQK/Mxkp0
         mCmlN2yGuQ9kXGuD2d1zUrHD3hAQAk7WOD/H0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A1to76Muk1fdla+xjmMFJtb5BFlQOFVgZ1KKX32hm3g=;
        b=H9gHTr7VW7Kp1HeMACiptZ2S5D77PSZTmCiInRlOkjD/sPmndzuuS0Fc20nMQehK6n
         R9m3JIrZwazThMDWbjZDKfmEHPXvQuk4ss17gV9Hh6TTWZI0KAbl/sp8E6R7OVbzPJE7
         FSkcHc52+goYlRfbjLZxp7iAoUb1UqmiFThMwT6KJ+Sy6pfHxBEs0ufr2+2lvhEp2mCC
         JNl6aefv8rixaIu3PTrOULRXh2xRZ6gNJYQgk4HhMX+00AHju70z07LYUXSfw0vblgUq
         Vy6nNRYrXMIsMR4QITTZ6HfInatXGczuSj5kpMBQ7/VjJSypEE5ycCoO0KspGTGjM4is
         CdmA==
X-Gm-Message-State: ABuFfojclXGjdVuwFOJnSuu3pnAFhoAeMEWryYYajM+CCdgh6QUTSfkM
        fJh0GBjo8Ltk1TMcyYra+BD3Og==
X-Google-Smtp-Source: ACcGV62mEVMP4yeRl5oKUOSiQjF8auBWlkh6aFE/N6Azq43A328TlDptRmNL7cSZUf8D4XMBy2zjuw==
X-Received: by 2002:a63:5816:: with SMTP id m22-v6mr13507559pgb.332.1538117376233;
        Thu, 27 Sep 2018 23:49:36 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id r12-v6sm5024997pfh.79.2018.09.27.23.49.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 23:49:35 -0700 (PDT)
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
Subject: [PATCH v15 16/16] arm64: kexec_file: add kaslr support
Date:   Fri, 28 Sep 2018 15:48:41 +0900
Message-Id: <20180928064841.14117-17-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180928064841.14117-1-takahiro.akashi@linaro.org>
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding "kaslr-seed" to dtb enables triggering kaslr, or kernel virtual
address randomization, at secondary kernel boot. We always do this as
it will have no harm on kaslr-incapable kernel.

We don't have any "switch" to turn off this feature directly, but still
can suppress it by passing "nokaslr" as a kernel boot argument.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/machine_kexec_file.c | 45 ++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 4b5ea256c84c..c2ca7c921e7a 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -16,6 +16,7 @@
 #include <linux/libfdt.h>
 #include <linux/memblock.h>
 #include <linux/of_fdt.h>
+#include <linux/random.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/vmalloc.h>
@@ -27,6 +28,7 @@
 #define FDT_PSTR_INITRD_STA	"linux,initrd-start"
 #define FDT_PSTR_INITRD_END	"linux,initrd-end"
 #define FDT_PSTR_BOOTARGS	"bootargs"
+#define FDT_PSTR_KASLR_SEED	"kaslr-seed"
 
 const struct kexec_file_ops * const kexec_file_loaders[] = {
 	&kexec_image_ops,
@@ -45,6 +47,32 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	return kexec_image_post_load_cleanup_default(image);
 }
 
+/* crng needs to have been initialized for providing kaslr-seed */
+static int random_ready;
+
+static void random_ready_notified(struct random_ready_callback *unused)
+{
+	random_ready = 1;
+}
+
+static struct random_ready_callback random_ready_cb = {
+	.func = random_ready_notified,
+};
+
+static __init int init_random_ready_cb(void)
+{
+	int ret;
+
+	ret = add_random_ready_callback(&random_ready_cb);
+	if (ret == -EALREADY)
+		random_ready = 1;
+	else if (ret)
+		pr_warn("failed to add a callback for random_ready\n");
+
+	return 0;
+}
+late_initcall(init_random_ready_cb)
+
 static int setup_dtb(struct kimage *image,
 		unsigned long initrd_load_addr, unsigned long initrd_len,
 		char *cmdline, unsigned long cmdline_len,
@@ -54,6 +82,7 @@ static int setup_dtb(struct kimage *image,
 	int addr_cells, size_cells;
 	size_t buf_size, range_size;
 	int nodeoffset;
+	u64 value;
 	int ret;
 
 	/* duplicate dt blob */
@@ -81,6 +110,8 @@ static int setup_dtb(struct kimage *image,
 		/* can be redundant, but trimmed at the end */
 		buf_size += fdt_prop_len(FDT_PSTR_BOOTARGS, cmdline_len);
 
+	buf_size += fdt_prop_len(FDT_PSTR_KASLR_SEED, sizeof(u64));
+
 	buf = vmalloc(buf_size);
 	if (!buf) {
 		ret = -ENOMEM;
@@ -160,6 +191,20 @@ static int setup_dtb(struct kimage *image,
 		}
 	}
 
+	/* add kaslr-seed */
+	fdt_delprop(buf, nodeoffset, FDT_PSTR_KASLR_SEED);
+	if (random_ready) {
+		get_random_bytes(&value, sizeof(value));
+		ret = fdt_setprop_u64(buf, nodeoffset, FDT_PSTR_KASLR_SEED,
+							value);
+		if (ret) {
+			ret = -EINVAL;
+			goto out_err;
+		}
+	} else {
+		pr_notice("kaslr-seed won't be fed\n");
+	}
+
 	/* trim a buffer */
 	fdt_pack(buf);
 	*dtb_buf = buf;
-- 
2.19.0

