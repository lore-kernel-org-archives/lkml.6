Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDCDC64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 21:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18410217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 21:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="SIoyOpYW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbeLXVDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 16:03:44 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34419 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbeLXVDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 16:03:43 -0500
Received: by mail-qt1-f193.google.com with SMTP id r14so13887725qtp.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 13:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=z2lsF+TBDpeiWvqL7wDxMIoC2RgUz+CNn0rz7Fq+S1A=;
        b=SIoyOpYWo276H1Mj+8K7jPL1CMK+A4yiGmSLmIEB4Spmi2rZ8v2FCz5m05b5VhKahI
         l06Txc1Fk2CFjgYs15h/MlGL6udHmoKE6xQhb5yPNJM/ffGv7OtJmVaYtePhKqE/7l7L
         BIOmO4UomO5oXMtcowszBdwF/ql0bPV9WxGgbpH0V8lXAqWbqdUN9Xl/HFhcYj+b799f
         Yr+3ssaEazBFb7b1Kto5sqVfcGsz5l9YMfgYkE00mTTv3DPmIl9mKd3dZdF0miBct6k1
         Izb1GqNI+TnZPPh42l3a9Mhxi2sanEyRbDANWEJ4HIECdtgPey6kVnlG5Qr1LBL56vQK
         oxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=z2lsF+TBDpeiWvqL7wDxMIoC2RgUz+CNn0rz7Fq+S1A=;
        b=fcykY0GjuKC5vii/HoPJuEJLujzCLvRfjYiR76Wjtm+uSGIpjEQ7c5xUo7Vc5mgw+k
         yoSP2ImIqU0R8mo6MtyabSNot4Hzam4pK6lKHH0tQv3fk0RGAW+eaQRBIzLH65abqjTc
         HZj/PvjBSoGzQLFAl5xGqAGKCyzDBFwM0POnGPnVna8YQ8uJgjsaYs6I9/LMw5yY4HZL
         bDSrygfYk0yesHLq5iXYNAccHNwv3BEBgdBMAf1uXIpyvfbqIt6Ed10D/xBLHZyMFKN4
         NtvjXizACqnuM+/V+fv9OBqqMyTCBC587bTqEoTvchZFa2RVhy5vv4tP/k+PM/ThpSFH
         mtBQ==
X-Gm-Message-State: AA+aEWZFJo5snfIWtOoXs8PdY5JrWO5Pl4BghTxiBxws6T/z2prLsAhf
        cKDoIBOS9hQgJqUMFnfoYHfOow==
X-Google-Smtp-Source: AFSGD/Ubq9RtSYm9E4FeHtuZLM+mnlRqYUJjv4gPNmdOzEDpISzGXUTe/bak/X9pqlDlMToXWcCM6g==
X-Received: by 2002:ac8:3d91:: with SMTP id v17mr13019381qtf.204.1545685422980;
        Mon, 24 Dec 2018 13:03:42 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id m49sm10996306qtb.40.2018.12.24.13.03.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Dec 2018 13:03:42 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     will.deacon@arm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -mmotm] arm64: fix build for MAX_USER_VA_BITS
Date:   Mon, 24 Dec 2018 16:03:12 -0500
Message-Id: <20181224210312.56539-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some code in 9b31cf493ff was lost during merging into the -mmotm tree
for some reasons,

In file included from ./arch/arm64/include/asm/processor.h:46,
                 from ./include/linux/rcupdate.h:43,
                 from ./include/linux/rculist.h:11,
                 from ./include/linux/pid.h:5,
                 from ./include/linux/sched.h:14,
		 from arch/arm64/kernel/asm-offsets.c:22:
./arch/arm64/include/asm/pgtable-hwdef.h:83:30: error:
'MAX_USER_VA_BITS' undeclared here (not in a function); did you mean
'MAX_USER_PRIO'?
 #define PTRS_PER_PGD  (1 << (MAX_USER_VA_BITS - PGDIR_SHIFT))
                              ^~~~~~~~~~~~~~~~
./arch/arm64/include/asm/pgtable.h:442:26: note: in expansion of macro
'PTRS_PER_PGD'
 extern pgd_t init_pg_dir[PTRS_PER_PGD];
                          ^~~~~~~~~~~~

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/arm64/include/asm/memory.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 1df0bb19117f..e1ec947e7c0c 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -67,6 +67,12 @@
 #define KERNEL_START      _text
 #define KERNEL_END        _end
 
+#ifdef CONFIG_ARM64_USER_VA_BITS_52
+#define MAX_USER_VA_BITS	52
+#else
+#define MAX_USER_VA_BITS	VA_BITS
+#endif
+
 /*
  * Generic and tag-based KASAN require 1/8th and 1/16th of the kernel virtual
  * address space for the shadow region respectively. They can bloat the stack
-- 
2.17.2 (Apple Git-113)

