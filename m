Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E97C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32D5E21841
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbeLSPQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:16:58 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36816 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729995AbeLSPQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:16:57 -0500
Received: by mail-wm1-f67.google.com with SMTP id p6so6550839wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 07:16:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jQEgjSv0p+0t9lP58YylQUqO3+AtSiTF9GKFD/e/dj4=;
        b=oNmwEl+4KO8MjUpcynfLTOFPWqL9gJSnHjysASHfVq+ll62rTeu8falm0xrNIsI0Mo
         XjnjafqazHk6ffsxtux4/WHSUBv90d+0YqgmgocZf1OnA1G+4qxvnQoZBsmq7cNMMIvE
         N4AI75hZsMbOJytCBRWdY2zmQZbR+pWFrCXwCFetWDxXavd+3mO9vNS65471U34YC5N1
         9C6af9X4PgapoWYXWsePsV44Ju9G0wrSpz0XXcvI+2PcxWz0aOJAoT1EyGjAjcaZOhYJ
         ASAOoUAZTku+4s+5bO4dzfMX10q9sGA8oMFKhDpUbrcw8wtWrE0ztdtNOiagF+oYCCDU
         JlxA==
X-Gm-Message-State: AA+aEWYMHZVNWTEBBCZLgnIrdSzHlO4InPwTEYy6gkBXkL6Li964YxiH
        upOlZhEKDvfgdLcrKvxJvYPUPA==
X-Google-Smtp-Source: AFSGD/W+1FnnhrhbmSMCDhKSNF5vgr3dlRdMVBEABlD4aThzpcLlqDDzCPiUXN2OJLty4/1nvZ/Qyw==
X-Received: by 2002:a1c:f207:: with SMTP id s7mr7425336wmc.87.1545232615958;
        Wed, 19 Dec 2018 07:16:55 -0800 (PST)
Received: from localhost.localdomain.home ([151.15.249.65])
        by smtp.gmail.com with ESMTPSA id f187sm5004081wma.4.2018.12.19.07.16.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 07:16:55 -0800 (PST)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     fenghua.yu@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH] arch/x86/kernel/topology: Make DEBUG_HOTPLUG_CPU0 pr_info more descriptive
Date:   Wed, 19 Dec 2018 16:16:47 +0100
Message-Id: <20181219151647.15073-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DEBUG_HOTPLUG_CPU0 debug feature offlines a CPU as early as possible
allowing userspace to boot up without that CPU (so that it is possible
to check for unwanted dependencies towards the offlined CPU). After
doing so it emits a "CPU %u is now offline" pr_info, which is not enough
descriptive of why the CPU was offlined (e.g., one might be running with
a config that triggered some problem, not being aware that CONFIG_DEBUG_
HOTPLUG_CPU0 is set).

Add a bit more of informative text to the pr_info, so that it is
immediately obvious why a CPU has been offlined in early boot stages.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

---

Got to scratch my head a bit while debugging a WARNING splat related to
the offlining of CPU0. Without being aware yet of this debug option it
wasn't immediately obvious why CPU0 was being offlined by the kernel.

Hope this makes sense and is acceptable. :-)
---
 arch/x86/kernel/topology.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/topology.c b/arch/x86/kernel/topology.c
index 738bf42b0218..c3c2400e30b1 100644
--- a/arch/x86/kernel/topology.c
+++ b/arch/x86/kernel/topology.c
@@ -71,7 +71,8 @@ int _debug_hotplug_cpu(int cpu, int action)
 	case 0:
 		ret = cpu_down(cpu);
 		if (!ret) {
-			pr_info("CPU %u is now offline\n", cpu);
+			pr_info("DEBUG_HOTPLUG_CPU0: CPU %u is now offline\n",
+				cpu);
 			dev->offline = true;
 			kobject_uevent(&dev->kobj, KOBJ_OFFLINE);
 		} else
-- 
2.17.2

