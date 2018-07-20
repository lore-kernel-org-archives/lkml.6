Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C887ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 01:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59072084C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 01:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V/ow4tfM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D59072084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731336AbeGTCdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 22:33:52 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41594 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731283AbeGTCdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 22:33:51 -0400
Received: by mail-pl0-f67.google.com with SMTP id w8-v6so4433415ply.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 18:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qOa+Lf5zVsBgxcSLC3sLa0St+7nZBpqptye8Lhy5gjc=;
        b=V/ow4tfMcm7/tJ4XYhJoEg0EbNiF2+5ac6quOFS6yBhn3RXipv0DpjMCvq8ny98wSN
         cFAB408AMzo9ZWP0ZOa1wzGbBo0JuLC5paV8SSx3VH0SC8swIBR5MQrwGnf3/U+JANb/
         OZ5N2huf84e8PG55MWHAbHWM9PzAWdAR8K/jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qOa+Lf5zVsBgxcSLC3sLa0St+7nZBpqptye8Lhy5gjc=;
        b=E4mSESsE+vX1DWZ3AnKqiZDZZAuxk6hTGgxTs8pcFSeeuE68FAoePWflXJtNtWVN3o
         0z1TJpeYqPcYByWQGf5qprZd9YOZGi9HxlC7uDay22HfYI/Y5pkCjQ9fSHq8jS634C92
         vtbQNs2wBlmmZGdOWxRrwIe6uVaDWzUmXvqEJbvGzCz/JpTGRWgB9TvNIcTCZfaUJCEx
         3in+YhLjFsjz/v6dLjo4A3OweScs8qjbJeQv+TG4hCeWqmwDM/0MtZCC+EN3zcj+kx0t
         qzWkhfd1tRRWI/O+tzaPfbw0H3kwld4Pg0K+xcxMbZVyUYBgKfRjuUNk49uR/lVIqtN8
         M8tA==
X-Gm-Message-State: AOUpUlGhs7ool4l2Hr0eo/UbHyxINmvyMMBY1mans6DIicgKiKIxwgY/
        wVs/UKgem1tcsq54oXhHQvisAg==
X-Google-Smtp-Source: AAOMgpcamKIYdOTA1hmhAdDYbOrCpQ32sWCEZBMt1wUUI+CGHmqjIDF9oAVYj1b4GPI5YanYBQNqjA==
X-Received: by 2002:a17:902:4a0c:: with SMTP id w12-v6mr71797pld.289.1532051279783;
        Thu, 19 Jul 2018 18:47:59 -0700 (PDT)
Received: from localhost.localdomain (fs76eedbeb.tkyc508.ap.nuro.jp. [118.238.219.235])
        by smtp.gmail.com with ESMTPSA id 203-v6sm475868pgb.14.2018.07.19.18.47.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 18:47:59 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 5/9] efi/x86: add missing NULL initialization in UGA draw protocol discovery
Date:   Fri, 20 Jul 2018 10:47:22 +0900
Message-Id: <20180720014726.24031-6-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180720014726.24031-1-ard.biesheuvel@linaro.org>
References: <20180720014726.24031-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UGA draw protocol discovery routine looks for a EFI handle that has
both the UGA draw protocol and the PCI I/O protocol installed. It checks
for the latter by calling handle_protocol() and pass it a PCI I/O
protocol pointer variable by reference, but fails to initialize it to
NULL, which means the non-NULL check later on in the code could produce
false positives, given that the return code of the handle_protocol() call
is ignored entirely. So add the missing initialization.

Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/boot/compressed/eboot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index ac8e442db71f..92b573fd239c 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -359,6 +359,7 @@ setup_uga(struct screen_info *si, efi_guid_t *uga_proto, unsigned long size)
 		if (status != EFI_SUCCESS)
 			continue;
 
+		pciio = NULL;
 		efi_call_early(handle_protocol, handle, &pciio_proto, &pciio);
 
 		status = efi_call_proto(efi_uga_draw_protocol, get_mode, uga,
-- 
2.17.1

