Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C6CC18E01
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0CB206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t83HAtYU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB0CB206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbeKUAZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:25:34 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42888 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeKUAZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:25:33 -0500
Received: by mail-pg1-f195.google.com with SMTP id d72so935042pga.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 05:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6pmlTDFihEBurm1dLJqxoC6KqTTJxAXpBV9ussy6bQU=;
        b=t83HAtYUh91BViAkEApdq7rcZRf9JtcAbAe+Dj5y7eXmG8gX0nZjPmILkTXYlwneVp
         jkGWYFgV5dgbsXhe9TzxEZe9Ag/YsMhUpYNM4oSuSd/EdRktXHSvclBAUFyB6e5kohJ8
         NIgtNily3kx0bfPJyZQ3japSWLNZIf8cBE4kyO3rbMXZ2lymgR08n1RTehHeZMEJsVTa
         2Q7IlpIvhTnN6aB7RmGfDLfnTC+a8Tsk6ta2SMzn8QHdMyZ9j52Jws8fMLN1skZ2zoGl
         ZOkKm8Wad/tDZQnLGHtn5rKZ0+5uu8l/Xf0+/SLZAv5MEJhKTSnkWZ3FPygcMYUL08Ra
         E+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6pmlTDFihEBurm1dLJqxoC6KqTTJxAXpBV9ussy6bQU=;
        b=mssPz0GgK0A+IAQXzShZPtxEVzCgyECQl6wy94mQJF/GxRq7rYOa53cwlQJ0p5M2xx
         eH5HTgwynvdv/ZL+5+XGui/KrfHKLzXHAPgLvVZZEA42SYdpq/zbPJw8A1goN8qabv/B
         Q6RWpyrVmALGd7HmA2LJ3ijA4NxVwktRFQd+tGFDBmsGlDcbFyRugL9UJ1qUM2yAhMYk
         Pro0DcwnXKZT+goih7NQswS8yMZFgjGuXCglBa7zl4Zah1svZojpFv1ziy7xRve3ifpb
         k5zmU5lEvf7UJfnt83Qdu5xO0rsc3BUK/qc6YJSaDZxscKXKpLD+RkFUNc9JoysBASuo
         Uc0g==
X-Gm-Message-State: AGRZ1gLkwwn6OowhXL3aUZisjnkvwOuN4m/W5Ur87SUC/Byyc6k8Us7+
        /rV3tYQFgtIwVI3q+445WKvCMDuu7mo=
X-Google-Smtp-Source: AJdET5dBOMfbIDqeIx3eW0bfrdCurno1vpsxWSZnkEORK0HbwIPU9AIgtoLNTHWbqsF7RVWTnTIUIA==
X-Received: by 2002:a62:d2c1:: with SMTP id c184mr2283706pfg.248.1542722177304;
        Tue, 20 Nov 2018 05:56:17 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id o189sm20501945pfg.117.2018.11.20.05.56.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 05:56:16 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     linux@armlinux.org.uk, akpm@linux-foundation.org, mhocko@suse.com,
        rppt@linux.vnet.ibm.com, robh@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] arm: add missing of_node_put()
Date:   Tue, 20 Nov 2018 08:56:13 -0500
Message-Id: <20181120135613.20249-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm/kernel/devtree.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index e3057c1b55b9..9576adf0d15b 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -101,7 +101,7 @@ void __init arm_dt_init_cpu_maps(void)
 		if (!cell || prop_bytes < sizeof(*cell)) {
 			pr_debug(" * %pOF missing reg property\n", cpu);
 			of_node_put(cpu);
-			return;
+			goto out;
 		}
 
 		/*
@@ -115,7 +115,7 @@ void __init arm_dt_init_cpu_maps(void)
 
 		if (prop_bytes || (hwid & ~MPIDR_HWID_BITMASK)) {
 			of_node_put(cpu);
-			return;
+			goto out;
 		}
 
 		/*
@@ -129,7 +129,7 @@ void __init arm_dt_init_cpu_maps(void)
 			if (WARN(tmp_map[j] == hwid,
 				 "Duplicate /cpu reg properties in the DT\n")) {
 				of_node_put(cpu);
-				return;
+				goto out;
 			}
 
 		/*
@@ -171,7 +171,7 @@ void __init arm_dt_init_cpu_maps(void)
 
 	if (!bootcpu_valid) {
 		pr_warn("DT missing boot CPU MPIDR[23:0], fall back to default cpu_logical_map\n");
-		return;
+		goto out;
 	}
 
 	/*
@@ -184,6 +184,8 @@ void __init arm_dt_init_cpu_maps(void)
 		cpu_logical_map(i) = tmp_map[i];
 		pr_debug("cpu logical map 0x%x\n", cpu_logical_map(i));
 	}
+out:
+	of_node_put(cpus);
 }
 
 bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
-- 
2.17.0

