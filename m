Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EDEC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA06321746
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NOu5gWVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA06321746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbeI1NKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:10:19 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:42593 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeI1NKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:10:19 -0400
Received: by mail-pg1-f173.google.com with SMTP id i4-v6so3116249pgq.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 23:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SFnjB8OZwPCkN/cF+2XtrYPYnwjUqNvYjNJ7CAWxc5o=;
        b=NOu5gWVY0xlMpxIclXnxjYR6bEPT29dU0ZklbtpXSY5Ypq8qCjjvQMi2SgJVNEJjEP
         YjEWlJKbjI/9XcoxOVGYN5Q1V5+A2MHBdjMa4vVEreAt9quWR2PwMrjes2N0vi6SeW66
         3wKxN/9fSi1KQdhlDw7G7H7TV99dhfTxGOYoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SFnjB8OZwPCkN/cF+2XtrYPYnwjUqNvYjNJ7CAWxc5o=;
        b=CTL/ijlo/RkZY0JqLWhgAAbLSK+IwWNCcES6+edTCpjS6eaVEyEWlLZBW/VHfN/z2o
         Kw0+H/O+w+R+8u3aS3g7MDvwdJ5t2KYtgtnSjUeulML4zX6ga8DtRf/zNk+DQ4XwuFKr
         8jhkrEEr8QiXJooLgSCVYBKOIBvL305uP812maGviDPfc7lZI9HJ+xg9xFcgwxwDMq24
         NcEi+txtJddS4UA0OjJ7SAlaUTqdSv28Cqr8LMsRl0oUjpdsLTL5d7M1mP3TwxjbZbP3
         NH7dcwzSLRtJOWW7AEQo4uUzVMW2pCk/PgeUhlZWTn5lXeThNQu7PhtZwdcK2vfaoHWH
         BwmQ==
X-Gm-Message-State: ABuFfojfu0Q4c+g7yFToYnsWBKoBrIUvtF1B208nKLvrSmPiQqaQT8IC
        NtcWHinmCLQ2QpMUSMDgK4Ngkw==
X-Google-Smtp-Source: ACcGV62wHSCQDbe2gCAXySgK0gjx4k7VnV1SvMRCcldq9IaLlCj1mgGONJsIMITlezJ/ohUP9yWyoA==
X-Received: by 2002:aa7:8895:: with SMTP id l21-v6mr2833137pfo.74.1538117284863;
        Thu, 27 Sep 2018 23:48:04 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id a1-v6sm9770651pfc.28.2018.09.27.23.48.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 23:48:03 -0700 (PDT)
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
Subject: [PATCH v15 02/16] kexec_file: make kexec_image_post_load_cleanup_default() global
Date:   Fri, 28 Sep 2018 15:48:27 +0900
Message-Id: <20180928064841.14117-3-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180928064841.14117-1-takahiro.akashi@linaro.org>
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change this function from static to global so that arm64 can implement
its own arch_kimage_file_post_load_cleanup() later using
kexec_image_post_load_cleanup_default().

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Acked-by: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
---
 include/linux/kexec.h | 1 +
 kernel/kexec_file.c   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 9e4e638fb505..49ab758f4d91 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -143,6 +143,7 @@ extern const struct kexec_file_ops * const kexec_file_loaders[];
 
 int kexec_image_probe_default(struct kimage *image, void *buf,
 			      unsigned long buf_len);
+int kexec_image_post_load_cleanup_default(struct kimage *image);
 
 /**
  * struct kexec_buf - parameters for finding a place for a buffer in memory
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index c6a3b6851372..63c7ce1c0c3e 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -78,7 +78,7 @@ void * __weak arch_kexec_kernel_image_load(struct kimage *image)
 	return kexec_image_load_default(image);
 }
 
-static int kexec_image_post_load_cleanup_default(struct kimage *image)
+int kexec_image_post_load_cleanup_default(struct kimage *image)
 {
 	if (!image->fops || !image->fops->cleanup)
 		return 0;
-- 
2.19.0

