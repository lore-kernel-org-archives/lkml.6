Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C710C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 02:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA7D2148E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 02:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Xq8RopHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbeL1CGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 21:06:51 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:47061 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeL1CGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 21:06:50 -0500
Received: by mail-qt1-f196.google.com with SMTP id y20so22088661qtm.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 18:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jeotiuDVoAXBD8bBhdnEFNFA+yIhydpgnnuKWR3Opek=;
        b=Xq8RopHW5CAh8l35Ps/bGcWCWwPFmcGaoeqC0HYOsb932pCisBWasoWRSQdh4mL6Zb
         W6D3YaNV3aA22iP3FlTFkAt35Lq+bxqV7tOmSwCBnxF0oTrwbj4+5nuyhKahKrFrLAxf
         wl9vVtNxKJZi+1mqHx753ARLdeyZ23f2RSknp4xXmK4zF18n9nbirizJ+zFEC64J51Dh
         0u87bEjO/mKgoeLU4ltZecmx5Xc9MTO/TJLrCh3YUXHUVYWzyvb/y3Gz6sU3rqo69p5O
         /oi0trgzrECr0bVYCJr8p5aQuD1Jr85MTFuOTW78z5qtHh08nNOevKurKuxffWmAcQ2z
         dCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jeotiuDVoAXBD8bBhdnEFNFA+yIhydpgnnuKWR3Opek=;
        b=Wz/DnnkUKSAdjiRb+dHaUs5H0Yk4JFPxOTxaVuFIu06egwFdScXAPHKTruc66tsS6O
         Gx2Bwy9jhyABXsYTm4QSw50UzpAVPb3tvACC5plC2LDBvbWu8zeuPfyyPXRphd561V6o
         EZk5BvSZc3m7QmP2Ze53uf7q7dxpXRFWQE3C3QIY+9tnTIdR2wqPCPS1RI8AZceNmCNL
         T8i6pto4wuD0qNX2vTX6kY4dspKaPdEmcRmo7+jrb6WzbRw0dhFOegxVR4pdwsvSAa1B
         Mt/O7ZwqiLMBIrxsh5mLOd+0vjxIyiax81eKQkXb2kSkpzLlwWDTuPNTv2za/qDN4UYJ
         PFmA==
X-Gm-Message-State: AJcUukdN7jUYesX1H4+J0RgNc1Djk/0yRJYEXmaJ1dO8Txipqf4IkNb4
        kNKdLXa/yMcvWSEVIYAXr3imj8rHnvnrZw==
X-Google-Smtp-Source: ALg8bN7tdzOC612m7U9Uz25m9hNSDZd7CqYeobARddMqCHj3K0tgfYG5xA752T/osNgARLMIj+f1AQ==
X-Received: by 2002:a0c:b24f:: with SMTP id k15mr24965183qve.72.1545962808610;
        Thu, 27 Dec 2018 18:06:48 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id m20sm13081127qkk.66.2018.12.27.18.06.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 18:06:48 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] x86_64: increase stack size for KASAN_EXTRA
Date:   Thu, 27 Dec 2018 21:06:39 -0500
Message-Id: <20181228020639.80425-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the kernel is configured with KASAN_EXTRA, the stack size is
increasted significantly due to enable this option will set
"-fstack-reuse" to "none" in GCC [1]. As the results, it could trigger
stack overrun quite often with 32k stack size compiled using GCC 8. For
example, this reproducer

https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/\
syscalls/madvise/madvise06.c

could trigger a "corrupted stack end detected inside scheduler" very
reliably with CONFIG_SCHED_STACK_END_CHECK enabled.

There are just too many functions that could have a large stack with
KASAN_EXTRA due to large local variables that have been called over and
over again without being able to reuse the stacks. Some noticiable ones
are,

size
7648 shrink_page_list
3584 xfs_rmap_convert
3312 migrate_page_move_mapping
3312 dev_ethtool
3200 migrate_misplaced_transhuge_page
3168 copy_process

There are other 49 functions are over 2k in size while compiling kernel
with "-Wframe-larger-than=" even with a related minimal config on this
machine. Hence, it is too much work to change Makefiles for each object
to compile without "-fsanitize-address-use-after-scope" individually.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715#c23

Although there is a patch in GCC 9 to help the situation, GCC 9 probably
won't be released in a few months and then it probably take another
6-month to 1-year for all major distros to include it as a default.
Hence, the stack usage with KASAN_EXTRA can be revisited again in 2020
when GCC 9 is everywhere. Until then, this patch will help users avoid
stack overrun.

This has already been fixed for arm64 for the same reason via
6e8830674ea (arm64: kasan: Increase stack size for KASAN_EXTRA).

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/x86/include/asm/page_64_types.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index 8f657286d599..0ce558a8150d 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -7,7 +7,11 @@
 #endif
 
 #ifdef CONFIG_KASAN
+#ifdef CONFIG_KASAN_EXTRA
+#define KASAN_STACK_ORDER 2
+#else
 #define KASAN_STACK_ORDER 1
+#endif
 #else
 #define KASAN_STACK_ORDER 0
 #endif
-- 
2.17.2 (Apple Git-113)

