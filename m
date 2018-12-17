Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D0CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C56F0206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NG6T0E58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388561AbeLQSCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:02:24 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43379 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733270AbeLQSCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:02:20 -0500
Received: by mail-ed1-f67.google.com with SMTP id f9so11509420eds.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 10:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eB9+JvqWOlyqsBc3VtBL48QhOz1aowu5Yp+uTE3x7CE=;
        b=NG6T0E58fySSChoONLP2phvoeCK0ucSvd3L9VrE1FP1P2ALQMFEL8dGypTODCswMc+
         8ERliNY52J53TZYQWtAOrJYDKozjZn5/J9bl71UwxIM2OWTFOjaCGxLo6SsJDSe7UU3N
         0fucnHt9yUc0+0erox6HrMNxQcTvEnmJBMUdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eB9+JvqWOlyqsBc3VtBL48QhOz1aowu5Yp+uTE3x7CE=;
        b=AEgNgzS3zCMWje09etssLHqTeBTJbEnClulapC4QjWTX/y5iItrTSv8sGjHOqlYO2q
         wHdO6O1tZEEt2HcZwmn1nZX7B5o943eSdOpGOU4OM0fLoRtzR9KkUzn0FWA1WSBYTwJm
         hFXTwQ6GBQg9KCb9rQFW87D4gqPkWzPjJ7iJ5vPM4hAgR371cm2SITwMawn9KCSEYo3Z
         3aP2IqbxN01yWG/zDntyizwXPe+QLbofmIyVo5iToY6el3+AUY+OCi1zszunGGevGrNy
         ZbCGc6AW+n4ItPhvu+2Ev/4Qgt08znqlTFHsGL9OETrsqhAxS/0Oi4To6RZg1O0/Co/a
         quxw==
X-Gm-Message-State: AA+aEWYakRPMW3bBZQY2h+1phjht6F24Bj1lF+lYAvBvzF9Bdlhz+9IU
        Vt1KzIGyvmKQphhgw/j7ovGQZg==
X-Google-Smtp-Source: AFSGD/V20+QRkjWRN7E0Lfud+LAm09Sxi6emK9IjfRMtZPuLDvWHr7Kthwl2yLWpU6YKtlTPGwZeqg==
X-Received: by 2002:a17:906:33d9:: with SMTP id w25-v6mr10862460eja.190.1545069738988;
        Mon, 17 Dec 2018 10:02:18 -0800 (PST)
Received: from mba13.arnhem.chello.nl (dhcp-077-251-017-237.chello.nl. [77.251.17.237])
        by smtp.gmail.com with ESMTPSA id j8sm3947678ede.55.2018.12.17.10.02.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 10:02:18 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>, Qian Cai <cai@gmx.us>
Subject: [PATCH 1/2] efi: let kmemleak ignore false positives
Date:   Mon, 17 Dec 2018 19:02:13 +0100
Message-Id: <20181217180214.9436-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181217180214.9436-1-ard.biesheuvel@linaro.org>
References: <20181217180214.9436-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qian Cai <cai@gmx.us>

unreferenced object 0xffff8096c1acf580 (size 128):
  comm "swapper/63", pid 0, jiffies 4294937418 (age 1201.230s)
  hex dump (first 32 bytes):
    80 87 b5 c1 96 00 00 00 00 00 cc c2 16 00 00 00  ................
    00 00 01 00 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b  ........kkkkkkkk
  backtrace:
    [<000000001d2549ba>] kmem_cache_alloc_trace+0x430/0x500
    [<0000000093a6dfab>] efi_mem_reserve_persistent+0x50/0xf8
    [<000000000a730828>] its_cpu_init_lpis+0x394/0x4b8
    [<00000000edf04e07>] its_cpu_init+0x104/0x150
    [<000000004d0342c5>] gic_starting_cpu+0x34/0x40
    [<000000005d9da772>] cpuhp_invoke_callback+0x228/0x1d68
    [<0000000061eace9b>] notify_cpu_starting+0xc0/0x118
    [<0000000048bc2dc5>] secondary_start_kernel+0x23c/0x3b0
    [<0000000015137d6a>] 0xffffffffffffffff

efi_mem_reserve_persistent+0x50/0xf8:
kmalloc at include/linux/slab.h:546
(inlined by) efi_mem_reserve_persistent at drivers/firmware/efi/efi.c:979

This line,

rsv = kmalloc(sizeof(*rsv), GFP_ATOMIC);

Kmemleak has a known limitation that can only track pointers in the kernel
virtual space. Hence, it will report false positives due to "rsv" will only
reference to other physical addresses,

rsv->next = efi_memreserve_root->next;
efi_memreserve_root->next = __pa(rsv);

Signed-off-by: Qian Cai <cai@gmx.us>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/efi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 415849bab233..7fcfe8a7ae98 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -31,6 +31,7 @@
 #include <linux/acpi.h>
 #include <linux/ucs2_string.h>
 #include <linux/memblock.h>
+#include <linux/kmemleak.h>
 
 #include <asm/early_ioremap.h>
 
@@ -1000,6 +1001,8 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 	if (!rsv)
 		return -ENOMEM;
 
+	kmemleak_ignore(rsv);
+
 	rsv->base = addr;
 	rsv->size = size;
 
-- 
2.17.1

