Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EFBC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF1EC206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PUuXrmrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF1EC206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbeIGMlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:41:40 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35645 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbeIGMlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:41:40 -0400
Received: by mail-pl1-f194.google.com with SMTP id g2-v6so5274058plo.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 01:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hvAWBPxjHLCiuG/UDQDc1Nu8BX1v01gDGjuspChhtac=;
        b=PUuXrmrhzXKdXLed1SIuT8fjgiUdG2uDYfqr82pc5ulwV00S7s0y1ONHe+4D9P0HS3
         Xa74+tT+vF3yEETwBlMtSnKWua/f6afVjTDULUfRHaQMYEoegvwXamIHA+dGYRpr9fXw
         lp/17gfVbPnFF3OVqd0Ziwek3IQizPPI7r8NE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hvAWBPxjHLCiuG/UDQDc1Nu8BX1v01gDGjuspChhtac=;
        b=s0VDoMzTVt++iCfR1ZG/ludwkBr5fioMZatWNX4x+ZjGD0Dk26ZJ76c1hs3pD5UfmX
         HFQs5tT1nS6p6Znmi71vPveL5Ed3MC8xBCN8xkPK2D8LgN9VVU/2ZQwUkDSIXmXQ24RQ
         BugYqSwlpzSx5Y1rHTRRuR0nifq4c8vEDzqq0X4bk1czvLOw/63HDLFewtfrBUsNmF6J
         pi5RgApa5dOB10XIYNZkCOQiERTtG+uvim8CqZq6Ta7HQh0g8gWbYzyKVx7bQh5jQ9n+
         bIqzQ3pKjS6ee1+7r6tiR7bLtgMN/8e6E7+PtUmQj+yYa0AfIS+Yrl2C0yhimeC8Ca4n
         XhSg==
X-Gm-Message-State: APzg51BQCMFVLXdBoRLmh0WZGZhBbDJZyX/tE1WDdBc/MYFaaJmF6zOa
        RKRODU9pb17x6VosqCh3s748Nw==
X-Google-Smtp-Source: ANB0VdaAw4JGA5PGH3LsHjF7IpXsyUJhuSDjAZIZWuFsc1UDQYp/duZAnmUOwq2146Neg1ZDJaaAVw==
X-Received: by 2002:a17:902:6b47:: with SMTP id g7-v6mr6800958plt.128.1536307314969;
        Fri, 07 Sep 2018 01:01:54 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id 22-v6sm11078582pfl.126.2018.09.07.01.01.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 01:01:54 -0700 (PDT)
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
Subject: [PATCH v14 16/16] arm64: kexec_file: add kaslr support
Date:   Fri,  7 Sep 2018 17:00:40 +0900
Message-Id: <20180907080040.4967-11-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907080040.4967-1-takahiro.akashi@linaro.org>
References: <20180907080040.4967-1-takahiro.akashi@linaro.org>
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
index ecaecb122cad..967db9824e3f 100644
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
@@ -53,6 +81,7 @@ static int setup_dtb(struct kimage *image,
 	void *buf = NULL;
 	size_t buf_size, range_size;
 	int nodeoffset;
+	u64 value;
 	int ret;
 
 	/* check ranges against root's #address-cells and #size-cells */
@@ -85,6 +114,8 @@ static int setup_dtb(struct kimage *image,
 		/* can be redundant, but trimmed at the end */
 		buf_size += fdt_prop_len(FDT_PSTR_BOOTARGS, cmdline_len);
 
+	buf_size += fdt_prop_len(FDT_PSTR_KASLR_SEED, sizeof(u64));
+
 	buf = vmalloc(buf_size);
 	if (!buf) {
 		ret = -ENOMEM;
@@ -164,6 +195,20 @@ static int setup_dtb(struct kimage *image,
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
2.18.0

