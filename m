Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BD4C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995612172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="a1qa43cU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 995612172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbeI1NKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:10:38 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32942 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeI1NKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:10:37 -0400
Received: by mail-pf1-f193.google.com with SMTP id d4-v6so3653985pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 23:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pt0GdTUj/ouoBc0plwl0qxBtF8IeFfWdoXUu09cJo+Q=;
        b=a1qa43cUD3aEMCBBW+bPEPzCN0FPKwq7mNCLZT1Q8/I1oH07mIv3ms6vWZ0nRdjueB
         RWCSvRKjgb6jdgEZYiv0PSwrzd6TycaifX8EGVal+obfRXgDcaEMCtDQq3NzhlXgp3jV
         +q/uY98I7cnuQEWg2SjjZxoM4ZG3JndQxgZNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pt0GdTUj/ouoBc0plwl0qxBtF8IeFfWdoXUu09cJo+Q=;
        b=F/OH//pi3QxH+KHVC0oSDJmaVFD0taRXMe1FXCOGWG4A+qJ3AEDyTFRiMPuoJzVztw
         c5cCeRtxIpGphnRr4pTUDsFua1ifYXpx0b+7E8pg//QelcIHgwB3leY4MSZUAHhdBUVN
         oBic5RKcjqd2y/5ZJeQkpfr16BUJQEST3VHw3wZF7CASh5PH9eg2ptIUn8+dWrCDQDNR
         1g2mohk/9UGEVzP2knySl+2JZ0TXqJRth6LftCFKTTuwITIF48gWnmZBvjVcmhkAZdBZ
         ngM7qqY83lnqvNyIIhNaHg+OWSeMVUPAoaY0wbWdmtfWo2wyzLCH/BdsCMv8l3V8hcaW
         17ng==
X-Gm-Message-State: ABuFfoiByeRP0j80wVN5nY6lrSAL4Jj7MEc5hflrgsyXcsaSYZV2xCpq
        vT2Ra/s3XrdUdPfmGwbfF+/8tw==
X-Google-Smtp-Source: ACcGV6132QMgaHUkEnzpOJ34vEDqPCuVCNDWxwxsgSM4vQASkor4Pf8KuOATk2NREZeo2zXkL7a4ZA==
X-Received: by 2002:a17:902:a40e:: with SMTP id p14-v6mr1085759plq.338.1538117302650;
        Thu, 27 Sep 2018 23:48:22 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id 89-v6sm9522313pfk.134.2018.09.27.23.48.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 23:48:21 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     prudo@linux.ibm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v15 06/16] of/fdt: add helper functions for handling properties
Date:   Fri, 28 Sep 2018 15:48:31 +0900
Message-Id: <20180928064841.14117-7-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180928064841.14117-1-takahiro.akashi@linaro.org>
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions will be used later to handle kexec-specific properties
in arm64's kexec_file implementation.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org
---
 drivers/of/fdt.c       | 56 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/of_fdt.h |  4 +++
 2 files changed, 60 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 800ad252cf9c..c65c31562ccb 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -25,6 +25,7 @@
 #include <linux/debugfs.h>
 #include <linux/serial_core.h>
 #include <linux/sysfs.h>
+#include <linux/types.h>
 
 #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
 #include <asm/page.h>
@@ -1323,3 +1324,58 @@ late_initcall(of_fdt_raw_init);
 #endif
 
 #endif /* CONFIG_OF_EARLY_FLATTREE */
+
+#define FDT_ALIGN(x, a)	(((x) + (a) - 1) & ~((a) - 1))
+#define FDT_TAGALIGN(x)	(FDT_ALIGN((x), FDT_TAGSIZE))
+
+int fdt_prop_len(const char *prop_name, int len)
+{
+	return (strlen(prop_name) + 1) +
+		sizeof(struct fdt_property) +
+		FDT_TAGALIGN(len);
+}
+
+static void fill_property(void *buf, u64 val64, int cells)
+{
+	__be32 val32;
+
+	while (cells) {
+		val32 = cpu_to_fdt32((val64 >> (32 * (--cells))) & U32_MAX);
+		memcpy(buf, &val32, sizeof(val32));
+		buf += sizeof(val32);
+	}
+}
+
+int fdt_setprop_reg(void *fdt, int nodeoffset, const char *name,
+						u64 addr, u64 size)
+{
+	int addr_cells, size_cells;
+	char buf[sizeof(__be32) * 2 * 2];
+		/* assume dt_root_[addr|size]_cells <= 2 */
+	void *prop;
+	size_t buf_size;
+
+	addr_cells = fdt_address_cells(fdt, 0);
+	if (addr_cells < 0)
+		return addr_cells;
+	size_cells = fdt_size_cells(fdt, 0);
+	if (size_cells < 0)
+		return size_cells;
+
+	/* if *_cells >= 2, cells can hold 64-bit values anyway */
+	if ((addr_cells == 1) && (addr > U32_MAX))
+		return -FDT_ERR_BADVALUE;
+
+	if ((size_cells == 1) && (size > U32_MAX))
+		return -FDT_ERR_BADVALUE;
+
+	buf_size = (addr_cells + size_cells) * sizeof(u32);
+	prop = buf;
+
+	fill_property(prop, addr, addr_cells);
+	prop += addr_cells * sizeof(u32);
+
+	fill_property(prop, size, size_cells);
+
+	return fdt_setprop(fdt, nodeoffset, name, buf, buf_size);
+}
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index b9cd9ebdf9b9..842af6ea92ea 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -108,5 +108,9 @@ static inline void unflatten_device_tree(void) {}
 static inline void unflatten_and_copy_device_tree(void) {}
 #endif /* CONFIG_OF_EARLY_FLATTREE */
 
+int fdt_prop_len(const char *prop_name, int len);
+int fdt_setprop_reg(void *fdt, int nodeoffset, const char *name,
+						u64 addr, u64 size);
+
 #endif /* __ASSEMBLY__ */
 #endif /* _LINUX_OF_FDT_H */
-- 
2.19.0

