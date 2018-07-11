Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208BFC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF5E20862
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SIE6TkGL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF5E20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732418AbeGKHq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:46:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43831 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbeGKHq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:46:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id v13-v6so2688364pgr.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 00:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uQoziQZkHVnlrNNUZNXAOepb9dTdnP1dZcnkI2L9pzA=;
        b=SIE6TkGLdOsMdh5DXKeCj9XxFa424kGQP+vU592YrheWapegYtykabNa2h6p3Z7ZF+
         uzo2EzV2GsH+kHAU04n4Co1PZrY9NY8bZywVXdpjE8EK1OWGKT6nzGW0sVsj0dm4VnMg
         1ag1YVyppqMmEmMrgjDIGpJscQzPOylYVhunA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uQoziQZkHVnlrNNUZNXAOepb9dTdnP1dZcnkI2L9pzA=;
        b=GgFx9ZfccxLCoTc8OoASTjmTZ+kdofG7jXmZ/VcVs0zDHCaHJnjURhapPp1LZJ82PT
         bRLcn4RCPeCP+BQy5cay6LqeD9CdQS5nmbKpmXgxS5BSZcAxepdRLKT8AYk9qsN3gy2J
         JG7rI6zNkBSPyfaNbENrtHxWLNiurT27cGF+qPow3CWKv7Mbwmfx7+iYHTACnrUL2Ril
         a00Bp0huXGztkE8JowLB+WAE6f/YUGFweTTYI8FDPS94bCDYdA357P2ya5zoSmTlWtt3
         iwb8B+uD4nNaKepxhFGiEhMFnjlg82RaIhKWk7LcwPhjh2Re4jNXF31fcxx/153hQizy
         I+6g==
X-Gm-Message-State: APt69E14g/suSkmjd1riOA1JMGKTDMHgHxd0WgObhoRwaOIrcr9PLiQX
        Y9j/wZgyo3lvakR4mWCwHfR1KQ==
X-Google-Smtp-Source: AAOMgpfWQarGW1LorSif8/icF25nRC6CYXWDUVFHIkKPbEH7SMNCec8AqB8zgGnarK26K81pXQzWoA==
X-Received: by 2002:a63:f:: with SMTP id 15-v6mr19477044pga.430.1531295011680;
        Wed, 11 Jul 2018 00:43:31 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id v17-v6sm23357015pfn.177.2018.07.11.00.43.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 00:43:31 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de
Cc:     ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v11 15/15] arm64: kexec_file: add kaslr support
Date:   Wed, 11 Jul 2018 16:42:03 +0900
Message-Id: <20180711074203.3019-16-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180711074203.3019-1-takahiro.akashi@linaro.org>
References: <20180711074203.3019-1-takahiro.akashi@linaro.org>
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
 arch/arm64/kernel/machine_kexec_file.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 261564df7210..99d771afe88e 100644
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
@@ -161,6 +162,12 @@ static int setup_dtb(struct kimage *image,
 		}
 	}
 
+	/* add kaslr-seed */
+	get_random_bytes(&value, sizeof(value));
+	ret = fdt_setprop(buf, nodeoffset, "kaslr-seed", &value, sizeof(value));
+	if (ret)
+		goto out_err;
+
 	/* trim a buffer */
 	fdt_pack(buf);
 	*dtb_buf = buf;
-- 
2.17.0

