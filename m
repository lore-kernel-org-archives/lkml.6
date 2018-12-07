Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12335C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99192083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D99192083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbeLGKO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:14:56 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40994 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbeLGKOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:14:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD678EBD;
        Fri,  7 Dec 2018 02:14:54 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CC8F3F5AF;
        Fri,  7 Dec 2018 02:14:51 -0800 (PST)
From:   James Morse <james.morse@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kexec@lists.infradead.org, Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Howells <dhowells@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>, dyoung@redhat.com,
        Baoquan He <bhe@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        prudo@linux.ibm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        bhsharma@redhat.com, Frank Rowand <frowand.list@gmail.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH arm64/kexec] arm64: kexec_file: forbid kdump via kexec_file_load()
Date:   Fri,  7 Dec 2018 10:14:39 +0000
Message-Id: <20181207101439.190918-1-james.morse@arm.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that kexec_walk_memblock() can do the crash-kernel placement itself
architectures that don't support kdump via kexe_file_load() need to
explicitly forbid it.

We don't support this on arm64 until the kernel can add the elfcorehdr
and usable-memory-range fields to the DT. Without these the crash-kernel
overwrites the previous kernel's memory during startup.

Add a check to refuse crash image loading.

Signed-off-by: James Morse <james.morse@arm.com>
---

Context: http://lore.kernel.org/r/20181206155424.GA4422@arm.com

 arch/arm64/kernel/kexec_image.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index 1ad1d5f8f024..07bf740bea91 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -47,6 +47,10 @@ static void *image_load(struct kimage *image,
 	struct kexec_segment *kernel_segment;
 	int ret;
 
+	/* We don't support crash kernels yet. */
+	if (image->type == KEXEC_TYPE_CRASH)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	/*
 	 * We require a kernel with an unambiguous Image header. Per
 	 * Documentation/booting.txt, this is the case when image_size
-- 
2.19.2

