Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C735C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA886206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QT7DAb1V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA886206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbeIGMhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:37:14 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:38870 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbeIGMhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:37:14 -0400
Received: by mail-pf1-f177.google.com with SMTP id x17-v6so6638673pfh.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 00:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DIzV6aso3cBbRwIPS8DL9LqPtHHeWZam6wO8uhZIhTo=;
        b=QT7DAb1VW3TTiSKno3oN+Ds4oOesrprs8hlPrzWly0uu8ex49FZI44yQkoCeR0AXlO
         rybOkj+45dEks0DMV0i9PMQOIkw6nwa/FjlkvSv4OVSPeAJXQMgs3oMmfIxbSwMei4TJ
         ARQiZQOCdCx9TdJVynK7qupICR+kH/Nwc/Ic8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DIzV6aso3cBbRwIPS8DL9LqPtHHeWZam6wO8uhZIhTo=;
        b=Er/4BgXdGvmt0dHg/LsU8lN36xXYcnydi4XKUWRQn4xi0tTrK1HjLXbZnmdnj0ycGk
         BGDuunAvyzyZWyaxWl2nwkdIHYVCr0MWPtlbY3P3EAeg92C9g/PmTKc6LBk9BPYX8JOb
         jKQ949pCSV0g9INW8GfG9cPbCd3qkZQjtjuSIVLFA4HYXyAt0WzMNiMB3HFUVK4sveIo
         8JkYHUQRrZ9gb581mVlbVItx5HTEbXLniwU2fDZgOvnNeAx+AOZR+8BSVvYnNr9x3A7B
         IP65gcmvOZpB4tcvyrXP7QDdVV/i+V9PVIomTyUGSxl0XC41JNXWvO6R7zW01h6CnJY4
         OcKQ==
X-Gm-Message-State: APzg51DUTUna0lpif/uPz1f8nqCalHKtcvs7L3Tnlbc/HomQpYrEyN0j
        93/YCDnQV6q7XqZCCbJXPOfU3Q==
X-Google-Smtp-Source: ANB0VdZKCSZYPTHErK18CnoV+IImlHiXf3hiM7VeJ1mpWoKXKrCERdaZAtds77TdKqODX62E2tFSiA==
X-Received: by 2002:a63:555c:: with SMTP id f28-v6mr6968922pgm.37.1536307050029;
        Fri, 07 Sep 2018 00:57:30 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id q26-v6sm12593771pfj.127.2018.09.07.00.57.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 00:57:29 -0700 (PDT)
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
Subject: [PATCH v14 02/16] kexec_file: make kexec_image_post_load_cleanup_default() global
Date:   Fri,  7 Sep 2018 16:56:39 +0900
Message-Id: <20180907075653.4696-3-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907075653.4696-1-takahiro.akashi@linaro.org>
References: <20180907075653.4696-1-takahiro.akashi@linaro.org>
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
2.18.0

