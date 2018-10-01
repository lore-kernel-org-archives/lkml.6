Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCC1C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13ECE20684
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ao1xQ2Ll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13ECE20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbeJATQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:16:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32775 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729333AbeJATQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:16:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id y18-v6so9414491pge.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 05:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G+ZhbjziC642b1eH4/+/2vgJPs1mdcz2f+MeBZpXx04=;
        b=ao1xQ2LlTlpMDkVxJEG+bk984hAcHv1qrEkfU/NYsxPAMQeoTjO4fOemHHthNkuDyR
         scx1IP0LQ6awQpOTCEYtzzfLHwO1z9Rvdk+5P1HSnew9AaaptmsHeiuufwA0OJ0HyGwG
         yYqOro8qmUwaDn6z5fQT3pZtVgYbxnqd4+W5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G+ZhbjziC642b1eH4/+/2vgJPs1mdcz2f+MeBZpXx04=;
        b=bhKFgH5n//ZeKD3ogHV6MEico4Pew/XENOMIIh54w6SlSDekziX2PEGzvBaulH9TJT
         PvezpgPfJFqgHveCBhLBGDauJFykGJChwoDEXYcJ7LlNOFMse6b+ousGOJCcOlJa8CgZ
         Up0U28yDCJNS3l5oLZUgf52O90b2IYgZtwIISYUO4/OPPFza9LkkyZcFmQrvuLlCUeiI
         /64SBOz5vO3EhrDp5GZUjp4UD2j66X70fKASk5GXYgy1hwL2WEO64iO8PSh7gpza2AND
         WeLTOqHxBO4mxD+bjQIMMSMxno0FeIU/NufBllKLJjy77uHN27OjryRNFZQhQ04h/49q
         AaCg==
X-Gm-Message-State: ABuFfohvSgTV79f0nmGpz1PULydqwnRSyazCp8mbiFLNThxqvaXKfFvX
        lcuVlB0vBPwv0jOC5p0O0l+Ubw==
X-Google-Smtp-Source: ACcGV62qTK2X5wSv88CQpsCd0uvVEzyd1I9joGklUIn4C31/jsdWWXNkc240B73QSWmXax294SRF1g==
X-Received: by 2002:a62:1c06:: with SMTP id c6-v6mr11408987pfc.41.1538397523566;
        Mon, 01 Oct 2018 05:38:43 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([49.207.59.231])
        by smtp.gmail.com with ESMTPSA id o12-v6sm21329345pfh.20.2018.10.01.05.38.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Oct 2018 05:38:43 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v3 1/5] m68k: rename system call table file name
Date:   Mon,  1 Oct 2018 18:07:53 +0530
Message-Id: <1538397477-4003-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538397477-4003-1-git-send-email-firoz.khan@linaro.org>
References: <1538397477-4003-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The system call table entries are present in syscalltable.S. One of
the patch in this patch series will auto-generate the system call
table entries using the system call table generation script and
which'll replace the existig table file.

In order to come up with a common naming convention across all
architecture, we need to change the file name to syscall_table.S.
This change will unify the implementation across all architecture.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/m68k/kernel/Makefile                            | 2 +-
 arch/m68k/kernel/{syscalltable.S => syscall_table.S} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/m68k/kernel/{syscalltable.S => syscall_table.S} (100%)

diff --git a/arch/m68k/kernel/Makefile b/arch/m68k/kernel/Makefile
index dbac7f8..5f40ce6 100644
--- a/arch/m68k/kernel/Makefile
+++ b/arch/m68k/kernel/Makefile
@@ -15,7 +15,7 @@ extra-$(CONFIG_SUN3)	:= sun3-head.o
 extra-y			+= vmlinux.lds
 
 obj-y	:= entry.o irq.o module.o process.o ptrace.o
-obj-y	+= setup.o signal.o sys_m68k.o syscalltable.o time.o traps.o
+obj-y	+= setup.o signal.o sys_m68k.o syscall_table.o time.o traps.o
 
 obj-$(CONFIG_MMU_MOTOROLA) += ints.o vectors.o
 obj-$(CONFIG_MMU_SUN3) += ints.o vectors.o
diff --git a/arch/m68k/kernel/syscalltable.S b/arch/m68k/kernel/syscall_table.S
similarity index 100%
rename from arch/m68k/kernel/syscalltable.S
rename to arch/m68k/kernel/syscall_table.S
-- 
1.9.1

