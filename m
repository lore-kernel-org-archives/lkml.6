Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698AFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF3D2087E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NlwwTDBl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF3D2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbeKOP7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 10:59:01 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:37496 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbeKOP7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 10:59:00 -0500
Received: by mail-yb1-f193.google.com with SMTP id d18-v6so7926233yba.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 21:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q/fq5bZ27j9TjpABnmRVQDUsaoFNf4lBmEvm436b7+U=;
        b=NlwwTDBlmA0fPIJo73KUlSBR/mJEba1O118YChkrG+s1/ZraNj0Y01Tr0TFVBwvcqE
         b3VP3vfW5vtlKY/Yaut01gBNk/g90XX5pObDWWY1scgLt7FWnLNwf0k/f/ZJAMsfodDT
         75tdAFCP5GXJcGbY8269qap+A6eZpP3OQmtvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q/fq5bZ27j9TjpABnmRVQDUsaoFNf4lBmEvm436b7+U=;
        b=mFVP+Jvi7sdjIJm89CcOm9khfz1Vf/eu8YuAyk57wY04Hh0l1cxqkspEGynlkkK7c6
         rAmAqwGk8TIZbYlUa6fYl4HK8qdCUrpDjGRxZC8sn/OlH8C7W8nToWgk+ITHXO0FGTTP
         HVdcW5e8UAMPMbgCD+hY4HueZO0Ky1zsrXCpVq2mz0y4n9bpdybw4YZqxscVYHaNHmOs
         IAzIknkSvLCfGy+Jlj01SjkLmHNQ/YnbKXv5PvMm6xVQCpAEmxC16jj3EwwY6ZskEvQl
         1yXSX8zbKQfwi3T8I4A2pxhTKk41r1slmslJQa24Wjv8QhIRibJHzLcteU6ZnwXQMAUb
         aSow==
X-Gm-Message-State: AGRZ1gLddAJEDjee/Cvde8wxt6sfL0AK5g26Be/5l9coo556zpFZWw3l
        p5Azi619SsK1wRx39sZNrN56GA==
X-Google-Smtp-Source: AJdET5dV1cECJynsv29Nko5CWSDppNLoqAh4iDzCukPadApvjHVw3IyQVZdv0pPSnKHwEVXokEeW1A==
X-Received: by 2002:a25:5983:: with SMTP id n125-v6mr4130285ybb.209.1542261154572;
        Wed, 14 Nov 2018 21:52:34 -0800 (PST)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id 207-v6sm7416843ywo.87.2018.11.14.21.52.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 21:52:33 -0800 (PST)
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
Subject: [PATCH v16 05/16] kexec_file: kexec_walk_memblock() only walks a dedicated region at kdump
Date:   Thu, 15 Nov 2018 14:52:44 +0900
Message-Id: <20181115055254.2812-6-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181115055254.2812-1-takahiro.akashi@linaro.org>
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kdump case, there exists only one dedicated memblock region as usable
memory (crashk_res). With this patch, kexec_walk_memblock() runs a given
callback function on this region.

Cosmetic change: 0 to MEMBLOCK_NONE at for_each_free_mem_range*()

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Acked-by: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
---
 kernel/kexec_file.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index d03195a8cb6e..f1d0e00a3971 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -515,8 +515,11 @@ static int kexec_walk_memblock(struct kexec_buf *kbuf,
 	phys_addr_t mstart, mend;
 	struct resource res = { };
 
+	if (kbuf->image->type == KEXEC_TYPE_CRASH)
+		return func(&crashk_res, kbuf);
+
 	if (kbuf->top_down) {
-		for_each_free_mem_range_reverse(i, NUMA_NO_NODE, 0,
+		for_each_free_mem_range_reverse(i, NUMA_NO_NODE, MEMBLOCK_NONE,
 						&mstart, &mend, NULL) {
 			/*
 			 * In memblock, end points to the first byte after the
@@ -530,8 +533,8 @@ static int kexec_walk_memblock(struct kexec_buf *kbuf,
 				break;
 		}
 	} else {
-		for_each_free_mem_range(i, NUMA_NO_NODE, 0, &mstart, &mend,
-					NULL) {
+		for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE,
+					&mstart, &mend, NULL) {
 			/*
 			 * In memblock, end points to the first byte after the
 			 * range while in kexec, end points to the last byte
-- 
2.19.0

