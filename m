Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35046C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F043521582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Byi9Ido6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F043521582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbeKOP6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 10:58:48 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:38094 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbeKOP6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 10:58:48 -0500
Received: by mail-yw1-f68.google.com with SMTP id i20so879669ywc.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 21:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h11K0AmVrf07I+hu2nU8xySmOw+R/bUvf0+LW2Q+26k=;
        b=Byi9Ido6WYyA6ak3oOwmTntFN6ZvPrWq+jnerI2g4TBQeE/AuJ9l5Xgc5LS+yqFM/G
         cLqhfQmJrhw/n4hQwHh529vaPJWOjbTfW9xLSnpUzBEETZs1YUvjjGk1aQsxuVibqHrb
         vk2e/tcv6SvR7BsOGP2ME0lvkO0W/eiCtsD3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h11K0AmVrf07I+hu2nU8xySmOw+R/bUvf0+LW2Q+26k=;
        b=PlE9yOaW2n49MzkfhTUO/XWWRbE3awfAh4eKlojgBhU+0uITrvP14SOK9vXVtsX7ww
         Afa8z4/Pfh+Z3DO17S+V31cUjXOY7gkBx7g0ZlOPcH+kYgkpI7CfayZ6pwgbJVxTvpf5
         E+u0cmoWw0npWXxyX9D1JXqDuCAm36T+pZToox6JtVBo6uAPwFeYqRAOzzKoZUxwACM6
         ic0UtOeN+u8Kouay3ORCfS5vmkEoYkaUtunhyb3Qg993CAVTHiusJkv5by5nIg7CLmnh
         AcBYy5JQvo+g6ujDBG3uXml0mEH2TGE6RmDhC3KEFeW8mbOEN+VONqsZHsHc6UsKXglf
         nIuw==
X-Gm-Message-State: AGRZ1gLjwcZhTeMCN9hLtKaNxrKUTs8cRpUFsPCjQ01LBZPj/NSMh1Cw
        cwuN0hHwLifUxMhfujA9Z+ajBA==
X-Google-Smtp-Source: AJdET5dpmFtPJo2svldfEWKgza+frX4ezfcIY+u4OwC/s2LZ63sRh11skB0kFgfpgIYZ0IEqd8jVLw==
X-Received: by 2002:a81:4bc1:: with SMTP id y184mr248875ywa.365.1542261142042;
        Wed, 14 Nov 2018 21:52:22 -0800 (PST)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id b186-v6sm9764855ywe.27.2018.11.14.21.52.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 21:52:21 -0800 (PST)
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
Subject: [PATCH v16 02/16] kexec_file: make kexec_image_post_load_cleanup_default() global
Date:   Thu, 15 Nov 2018 14:52:41 +0900
Message-Id: <20181115055254.2812-3-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181115055254.2812-1-takahiro.akashi@linaro.org>
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
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
index 35cf0ad29718..9ce6672f4fa3 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -76,7 +76,7 @@ void * __weak arch_kexec_kernel_image_load(struct kimage *image)
 	return kexec_image_load_default(image);
 }
 
-static int kexec_image_post_load_cleanup_default(struct kimage *image)
+int kexec_image_post_load_cleanup_default(struct kimage *image)
 {
 	if (!image->fops || !image->fops->cleanup)
 		return 0;
-- 
2.19.0

