Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E09C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B7F24454
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jd7r2+BP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B7F24454
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965475AbeF2SxG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:53:06 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33641 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935265AbeF2Sw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:52:57 -0400
Received: by mail-pf0-f195.google.com with SMTP id b17-v6so4617613pfi.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 11:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=HYF+SyGoIuhrWleA6Wu31rpb31Ax1tSkr+IFmINSfT8=;
        b=Jd7r2+BPJbJunloyRpdsP2Csep72xfcFfLJcC6Sy0XdPm6SyThLQFlUCVjJ+SWNe79
         PPD+vVR3kfSLz5RYE+lph7EKCoR944bkWBbT6w0vJScYI5S8ACfl52cHhtTChBovb09I
         SL8DbS9kXXRu7Mq3UbzdGiB7UkbQLWPk2oxcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=HYF+SyGoIuhrWleA6Wu31rpb31Ax1tSkr+IFmINSfT8=;
        b=bXL3lckVl6Nww4gpH/xPgA70Tb+yUY9S3MM5TiubMq5+6kttQ3Gs2Bhbt5urqKMWr2
         hx6a628/1OHCCRl39XwvUefaUU4nVU9Str3A3Q4pwHd6dGRDiWtl6qoYmT7ne4meU6ip
         Ebxa9+8pVu+sYKD6u5k7mXxl0jkaQWp7FgHawqGYzeEjZYNe4nHRIGp46MsJQiQmZCdf
         FS6PFIMN/XIrJ/Wglgeqe2vR6R/goUp/TcM+qQ651Xi597qwVNQ49odGHeY4WdPC404R
         vFSNGp+EnLq2YIK2l2r8dQ5m8PUIy/3B4MwTcq4C2NeqgJHNlMNmxsaPwqZEACeNzLBK
         gmxQ==
X-Gm-Message-State: APt69E3E7PdkGn+55jR2GrM7FriCmrV2vKFIt1e5WFnzWKzLL1imB2dy
        1qlhDCbx8ybE1KLUUlRHaOlwOQ==
X-Google-Smtp-Source: ADUXVKJyM9U7KZzRRmSYlyCWjbhxJCucioEHFeIcXgk+4Y6auKXUbpGcqn9EBZQ36acl7EKjLZoH5Q==
X-Received: by 2002:a65:61af:: with SMTP id i15-v6mr13770689pgv.349.1530298376720;
        Fri, 29 Jun 2018 11:52:56 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id d15-v6sm22611861pfh.92.2018.06.29.11.52.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 11:52:55 -0700 (PDT)
Date:   Fri, 29 Jun 2018 11:52:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Rob Herring <robh@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/msi: Remove VLA usage
Message-ID: <20180629185254.GA37557@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
switches from an unchanging variable to a constant expression to eliminate
the VLA generation.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/powerpc/sysdev/msi_bitmap.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/sysdev/msi_bitmap.c b/arch/powerpc/sysdev/msi_bitmap.c
index 6243a7e537d0..e64a411d1a00 100644
--- a/arch/powerpc/sysdev/msi_bitmap.c
+++ b/arch/powerpc/sysdev/msi_bitmap.c
@@ -225,22 +225,23 @@ static void __init test_of_node(void)
 	struct device_node of_node;
 	struct property prop;
 	struct msi_bitmap bmp;
-	int size = 256;
-	DECLARE_BITMAP(expected, size);
+#define SIZE_EXPECTED 256
+	DECLARE_BITMAP(expected, SIZE_EXPECTED);
 
 	/* There should really be a struct device_node allocator */
 	memset(&of_node, 0, sizeof(of_node));
 	of_node_init(&of_node);
 	of_node.full_name = node_name;
 
-	WARN_ON(msi_bitmap_alloc(&bmp, size, &of_node));
+	WARN_ON(msi_bitmap_alloc(&bmp, SIZE_EXPECTED, &of_node));
 
 	/* No msi-available-ranges, so expect > 0 */
 	WARN_ON(msi_bitmap_reserve_dt_hwirqs(&bmp) <= 0);
 
 	/* Should all still be free */
-	WARN_ON(bitmap_find_free_region(bmp.bitmap, size, get_count_order(size)));
-	bitmap_release_region(bmp.bitmap, 0, get_count_order(size));
+	WARN_ON(bitmap_find_free_region(bmp.bitmap, SIZE_EXPECTED,
+					get_count_order(SIZE_EXPECTED)));
+	bitmap_release_region(bmp.bitmap, 0, get_count_order(SIZE_EXPECTED));
 
 	/* Now create a fake msi-available-ranges property */
 
@@ -256,8 +257,8 @@ static void __init test_of_node(void)
 	WARN_ON(msi_bitmap_reserve_dt_hwirqs(&bmp));
 
 	/* Check we got the expected result */
-	WARN_ON(bitmap_parselist(expected_str, expected, size));
-	WARN_ON(!bitmap_equal(expected, bmp.bitmap, size));
+	WARN_ON(bitmap_parselist(expected_str, expected, SIZE_EXPECTED));
+	WARN_ON(!bitmap_equal(expected, bmp.bitmap, SIZE_EXPECTED));
 
 	msi_bitmap_free(&bmp);
 	kfree(bmp.bitmap);
-- 
2.17.1


-- 
Kees Cook
Pixel Security
