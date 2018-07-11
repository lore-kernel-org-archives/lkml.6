Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC07C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7110820854
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HRWt8TQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7110820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbeGKHo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:44:27 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:43067 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbeGKHo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:44:27 -0400
Received: by mail-pf0-f170.google.com with SMTP id y8-v6so17862471pfm.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 00:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+CuyitM4U+PQMgPnwkmGxBBf2FkG58yPNy8pZ5fB6pc=;
        b=HRWt8TQ3Cl6oR0kcTXEgGxozpWcG8baNcKuE3hUjeWekTYbX/K612I9/00RKjjn/nt
         w48krRd3k5N/YCrjzCEWqZREhCx/lVfmhLWttOU9Ot0b/XAXa7Ji7lVc7DsPWeX/7XA1
         zJrrsE5i6W+57sRp/SRgUED9kq1NfsPaMIu8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+CuyitM4U+PQMgPnwkmGxBBf2FkG58yPNy8pZ5fB6pc=;
        b=V70Bg6lUrI58lndezp39hvsn1iJGCKM4MEjf6lU34x0cZByy5RQ7cMfrQpClAXI75E
         ECOFcC4p47MEaR1v8NAEYW4vIaF9YOnLEmHaLUkTVOLgeHBXmhwHbQOc+V5uqXiIAgzw
         9SkHMOfCVwQ+gBQeEYBeyDDbncxL/fla4RgEYLpyV1PaNB1eRjb1oaFAWWCsm5Oc1+Jh
         ioK3/U/XhvuJVCrSV0fu4h5A29bcX/ScypMNHawr6NMvyy1Bn3S/9UF8+5qO4IQOjJ+L
         4e/G+z7/ZDqhAs2O73/DtY3ctXqfjojTivUVB8Zh9SD3KhD7xwarCDVtNb3AKN2E3HZ1
         onHg==
X-Gm-Message-State: APt69E3qr2WYZBZa3R09UIgPZHBQFvYXbS9TUhFtIZi7W6ZcnqECRP+H
        n96DRxVRQPRcbe0D/uTPdcq5/g==
X-Google-Smtp-Source: AAOMgpcVJh+R2IcdiYaPapIbulJWPGyUFLzPCpxwQCf+sotDDzx0HwKJD3jzNRcJYIR1xiCCqwQZIw==
X-Received: by 2002:a63:4e5f:: with SMTP id o31-v6mr23988056pgl.256.1531294891841;
        Wed, 11 Jul 2018 00:41:31 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id a191-v6sm4362266pge.45.2018.07.11.00.41.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 00:41:31 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de
Cc:     ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v11 02/15] kexec_file: make kexec_image_post_load_cleanup_default() global
Date:   Wed, 11 Jul 2018 16:41:50 +0900
Message-Id: <20180711074203.3019-3-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180711074203.3019-1-takahiro.akashi@linaro.org>
References: <20180711074203.3019-1-takahiro.akashi@linaro.org>
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
2.17.0

