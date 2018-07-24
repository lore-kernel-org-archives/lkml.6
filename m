Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D4AECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F69F20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iiggbw/Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F69F20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388453AbeGXIC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:02:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39143 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388245AbeGXIC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:02:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id j8-v6so621324pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 23:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8ScyWDBSkpDCeiO9xWIrh9E1Li1NS358S3v+0v5j+T0=;
        b=iiggbw/YJZIAmCl7wpn67Ovdkz+pycG2Mg51R/BAaen71ZB0eRXijPEyRgy/mq7wcd
         vZuBl7F5EF5rXfpH1vpV/gyllE0ooG8GMxvKSqC0uAnU8aq9M42TGFGK7DAI3m1gVdH5
         IQJsH+l9kVW4XYYkiCKC0zQ/frf8WjM9ggA+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8ScyWDBSkpDCeiO9xWIrh9E1Li1NS358S3v+0v5j+T0=;
        b=RJqgzQNdJO+GFRyyQhqd/uWmeuEwIcuji3l9uUrcKzT9FxKmHydjnJXbcKGg0+l9kT
         ytUJ8e8YJiCeDyo6KGsOAqMVTh9Q8m4F1vKeIKSypf8wWAM5nOB1nSNw89aQ3uXcfS4C
         rxwDDOp7OCF+ssUkh63U7SuElmgY71nuGqnXpdVi0jFqZOY+hWrvwc68TPaAODUY2LeQ
         naxqFEuKdohYbMPlcVtt7d4idfIuSOC0ht+/5jyCLzxyEiwo5KvS2Nwa+2Nadht81DdB
         OmGoPzDx9BmiT+0z6uz44LnqsBQXCAPoSuUT2++poWe/OTEZ2b4r7km4xSaIcuZE1oAg
         o5Uw==
X-Gm-Message-State: AOUpUlF6JoSCDq60SKEZdCwglyD5aKmvBkkaqiPBbwOIl/0/YR8v+g48
        pUaWFwAXHwfE6ILU5DqL4df4iQ==
X-Google-Smtp-Source: AAOMgpd1sndZWCunzrA9HLAAoRE8DF3myXLtZcMYvG+4FiARYJJehM9j7fcL1BGeIM4XeNi2dZC+2A==
X-Received: by 2002:a62:3601:: with SMTP id d1-v6mr16421214pfa.41.1532415450265;
        Mon, 23 Jul 2018 23:57:30 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id z19-v6sm2465351pgi.33.2018.07.23.23.57.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 23:57:29 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v12 03/16] s390, kexec_file: drop arch_kexec_mem_walk()
Date:   Tue, 24 Jul 2018 15:57:46 +0900
Message-Id: <20180724065759.19186-4-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724065759.19186-1-takahiro.akashi@linaro.org>
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
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
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
---
 arch/s390/kernel/machine_kexec_file.c | 10 ----------
 kernel/kexec_file.c                   |  4 ++++
 2 files changed, 4 insertions(+), 10 deletions(-)

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
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 63c7ce1c0c3e..bf39df5e5bb9 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -534,6 +534,10 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
 {
 	int ret;
 
+	/* Arch knows where to place */
+	if (kbuf->mem)
+		return 0;
+
 	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
 
 	return ret == 1 ? 0 : -EADDRNOTAVAIL;
-- 
2.18.0

