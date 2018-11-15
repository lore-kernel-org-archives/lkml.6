Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6142EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14EF22087E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NsKJ0pnb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14EF22087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbeKOQAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 11:00:13 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:40711 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbeKOQAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 11:00:12 -0500
Received: by mail-yw1-f68.google.com with SMTP id l66-v6so8266965ywl.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 21:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z6fpkRKvJjJuOzp7wHTBqPrWgQFd+w1vM5L/3Tpwhps=;
        b=NsKJ0pnbz1wxK7DAjNL7ynj+T731invAf4RnUN/pFf3mEkpgElVGh79yv/MP4BIjW9
         oMsjLQBGyoTfTSJrQ+CIv2CP3QDoesQIUj+Wse6zWsLaY2Vx6tWHv7U0Z4oyZXlB/3vU
         K9LtUxww4zddwC7VpMa1XzXmlpqRwG5oiLy8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z6fpkRKvJjJuOzp7wHTBqPrWgQFd+w1vM5L/3Tpwhps=;
        b=pHS9rqhCVHLDwav8TiRJoIEJxNdzALw6MS+ssupHRQXgx6TfLNPtIam4C+H907loUk
         gXik9UMtBW0tqWEmS1grOx+uYnfZuT1riOsLE4Di24dx0fUGVuveT/ToZ9QaVStFKqbL
         8U+KWJDEb+I9SkzqnDldV0Ie71kM6udqU1mvEcJvY+acHxegy5MDfHmYWP1E+GjVrl8k
         hJZF0MRLDGKnoRL/1ilHp4XKU10YFvK8IMsCSJF0jRp1mNOoWS5rdjAxV2TfIFsVIObZ
         oL5loTtErrWSCIAYmLaH0VRpRUL2tjWVzT/BFnORxy1uOSOfzx+0NGMC3DbgIorC44wF
         VY6g==
X-Gm-Message-State: AGRZ1gK5+g7KFAbWHTLpAaGhJC/PB4pNETXcX5GJXC9VSXBpdshLOktQ
        GjbZcuKugiHDUz3CX7uBnd1Tig==
X-Google-Smtp-Source: AJdET5dRF8aftl5JbSuc+XrJ2uCh54qihW81ZcVe7oEYrH0/OUXVxTU9B5EZOYh77ZobH769wki/1g==
X-Received: by 2002:a81:26d4:: with SMTP id m203-v6mr4471570ywm.327.1542261226677;
        Wed, 14 Nov 2018 21:53:46 -0800 (PST)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id m123-v6sm1526751ywe.86.2018.11.14.21.53.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 21:53:46 -0800 (PST)
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
Subject: [PATCH v16 16/16] arm64: kexec_file: add kaslr support
Date:   Thu, 15 Nov 2018 14:52:55 +0900
Message-Id: <20181115055254.2812-17-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181115055254.2812-1-takahiro.akashi@linaro.org>
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
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
 arch/arm64/kernel/machine_kexec_file.c | 46 +++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index ab296b98d633..a0a730bd9be6 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -16,6 +16,7 @@
 #include <linux/libfdt.h>
 #include <linux/memblock.h>
 #include <linux/of_fdt.h>
+#include <linux/random.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -28,6 +29,7 @@
 #define FDT_PSTR_INITRD_STA	"linux,initrd-start"
 #define FDT_PSTR_INITRD_END	"linux,initrd-end"
 #define FDT_PSTR_BOOTARGS	"bootargs"
+#define FDT_PSTR_KASLR_SEED	"kaslr-seed"
 
 const struct kexec_file_ops * const kexec_file_loaders[] = {
 	&kexec_image_ops,
@@ -46,11 +48,38 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
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
 		     char *cmdline, void *dtb)
 {
 	int nodeoffset;
+	u64 value;
 	int ret;
 
 	nodeoffset = fdt_path_offset(dtb, "/chosen");
@@ -106,12 +135,27 @@ static int setup_dtb(struct kimage *image,
 			return -EINVAL;
 	}
 
+	/* add kaslr-seed */
+	ret = fdt_delprop(dtb, nodeoffset, FDT_PSTR_KASLR_SEED);
+	if (ret && (ret != -FDT_ERR_NOTFOUND))
+		return -EINVAL;
+
+	if (random_ready) {
+		get_random_bytes(&value, sizeof(value));
+		ret = fdt_setprop_u64(dtb, nodeoffset, FDT_PSTR_KASLR_SEED,
+							value);
+		if (ret)
+			return (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
+	} else {
+		pr_notice("kaslr-seed won't be fed\n");
+	}
+
 	return 0;
 }
 
 /*
  * More space needed so that we can add initrd, bootargs,
- * userable-memory-range and elfcorehdr.
+ * userable-memory-range, elfcorehdr and kaslr-seed.
  */
 #define DTB_EXTRA_SPACE 0x1000
 
-- 
2.19.0

