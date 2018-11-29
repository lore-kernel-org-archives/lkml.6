Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6400C64EB4
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8085E20673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jxDGC1dJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8085E20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbeK3KQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:16:07 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44827 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbeK3KQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:16:07 -0500
Received: by mail-pl1-f196.google.com with SMTP id k8so1777433pls.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 15:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tZ1ANa+h2UBjtVpsGd+gI1f/ON/w0NtBaZ9yRTzwZr4=;
        b=jxDGC1dJf9Mzs+DuEj0mkwfM8wN+qDieU0by68vQFHEwEbQtqcBH1x/IUOdeDGURvP
         sJ/AMtbi4idvcWdaKHVccfeqnHUv/gV5LD3/+fBhkde3En/jEz5ZNMkEyRk1JsfbrARP
         Q4R/SnALNU9Kxo4RbDjaLh0WAhm9azo8eHs6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tZ1ANa+h2UBjtVpsGd+gI1f/ON/w0NtBaZ9yRTzwZr4=;
        b=JXUf5Cqcg9uf4Wu4KhyDk0yeGGRJzTQosZFjhMB6W4nWqj2w68W1OeFkhUCEc9l+qr
         yXKt2MGirEncs/dNOrt32UKUi0me1Oo2Tdmq/hjs/Kh/ZuwEHckJaTQtZZYunqnGK9Me
         K1szsLgvLVRmIzH9tqMcIkv6871tGulhL2YP/BgYdB6wjQt/GmoDvdnK5Pf6euP8rIWK
         IQV1qVJbkUbPFLVBgmi6k8OnN38MTe6J2lGlBbNbZJ+HQdJ+wH4ZBinOkYEjyDT04Mck
         C+GPR7qYi4s93cG1hxVcrcfxfn6NTnXf1tM9RWAcXeS4c/6mj2HsFzzlf1VP3+45ae8d
         E+Pw==
X-Gm-Message-State: AA+aEWZBT726D9V7fJp8uqMs4XD+zpcSBRVk+l0YXGDwOXRroSfH0u2Y
        Eqjo+TTdggTN6Dj6jlWXwprICA==
X-Google-Smtp-Source: AFSGD/UVHUPl3O8sGsu70An1ijtvRfzVL/EjSE7lBgCOqe/D2OMmpQDde7pCj1jSDPtXx3KvQWYt3w==
X-Received: by 2002:a17:902:468:: with SMTP id 95mr3338372ple.3.1543532938326;
        Thu, 29 Nov 2018 15:08:58 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id y89sm4181377pfa.136.2018.11.29.15.08.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 15:08:56 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH -next v2 06/12] pstore/ram: Report backend assignments with finer granularity
Date:   Thu, 29 Nov 2018 15:08:35 -0800
Message-Id: <20181129230841.29955-7-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129230841.29955-1-keescook@chromium.org>
References: <20181129230841.29955-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to more easily perform automated regression testing, this
adds pr_debug() calls to report each prz allocation which can then be
verified against persistent storage. Specifically, seeing the dividing
line between header, data, any ECC bytes. (And the general assignment
output is updated to remove the bogus ECC blocksize which isn't actually
recorded outside the prz instance.)

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/ram.c      | 4 ++--
 fs/pstore/ram_core.c | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 768759841491..10ac4d23c423 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -853,9 +853,9 @@ static int ramoops_probe(struct platform_device *pdev)
 	ramoops_pmsg_size = pdata->pmsg_size;
 	ramoops_ftrace_size = pdata->ftrace_size;
 
-	pr_info("attached 0x%lx@0x%llx, ecc: %d/%d\n",
+	pr_info("using 0x%lx@0x%llx, ecc: %d\n",
 		cxt->size, (unsigned long long)cxt->phys_addr,
-		cxt->ecc_info.ecc_size, cxt->ecc_info.block_size);
+		cxt->ecc_info.ecc_size);
 
 	return 0;
 
diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index f5d0173901aa..62830734deee 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -576,6 +576,12 @@ struct persistent_ram_zone *persistent_ram_new(phys_addr_t start, size_t size,
 	if (ret)
 		goto err;
 
+	pr_debug("attached %s 0x%zx@0x%llx: %zu header, %zu data, %zu ecc (%d/%d)\n",
+		prz->label, prz->size, (unsigned long long)prz->paddr,
+		sizeof(*prz->buffer), prz->buffer_size,
+		prz->size - sizeof(*prz->buffer) - prz->buffer_size,
+		prz->ecc_info.ecc_size, prz->ecc_info.block_size);
+
 	return prz;
 err:
 	persistent_ram_free(prz);
-- 
2.17.1

