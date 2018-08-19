Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A6FC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 23:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C756620C0E
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 23:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C756620C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alum.mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbeHTC3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 22:29:37 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:45814 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726397AbeHTC3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 22:29:37 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Aug 2018 22:29:37 EDT
X-AuditID: 12074412-b03ff70000007a70-a6-5b79f8a49835
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 6E.AE.31344.4A8F97B5; Sun, 19 Aug 2018 19:09:24 -0400 (EDT)
Received: from email-server.localdomain (104-63-242-122.lightspeed.irvnca.sbcglobal.net [104.63.242.122])
        (authenticated bits=0)
        (User authenticated as rian@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id w7JN9Kbj015989
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Sun, 19 Aug 2018 19:09:22 -0400
Received: from nori.lan.thelig.ht (localhost [127.0.0.1])
        (Authenticated sender: rian@thelig.ht)
        by email-server.localdomain (Postfix) with ESMTPA id D1D8A49F04A;
        Sun, 19 Aug 2018 16:09:18 -0700 (PDT)
From:   Rian Hunter <rian@alum.mit.edu>
To:     linux-kernel@vger.kernel.org
Cc:     Rian Hunter <rian@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bpetkov@suse.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dmitry Safonov <dima@arista.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] x86/process: Export start_thread()
Date:   Sun, 19 Aug 2018 16:08:53 -0700
Message-Id: <20180819230854.7275-1-rian@alum.mit.edu>
X-Mailer: git-send-email 2.18.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsUixO6iqLvkR2W0wdoTJhZHWiawW1z8tJLd
        YtpGcYsDP08wWkw+NZfJ4vKuOWwW53etZbW4dGABk0Xv/h5Gi82bpjJbTGq9zGzxY8NjVgce
        j7/vPzB57J7exOixaVUnm8e7c+fYPd7vu8rmsfl0tcfnTXIeJ1q+sAZwRHHZpKTmZJalFunb
        JXBlrDy+lLGgk73iX+Nu5gbGf6xdjJwcEgImEoemb2LvYuTiEBLYwSRxZsERFgjnGZPE08M7
        2CCcc4wS/SsXM4O0sAmoSmxuOQJmiwgoSGzufcYKUsQsMI9Z4uORFewgCWEBY4m/a2aD7WAB
        aljSPhGsgVfAVOJO5yeo3fISD4+3M05g5F7AyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdM
        LzezRC81pXQTIyQQhXYwrj8pd4hRgINRiYd3wdXKaCHWxLLiytxDjJIcTEqivOqHgUJ8Sfkp
        lRmJxRnxRaU5qcWHGCU4mJVEeFsXAuV4UxIrq1KL8mFS0hwsSuK8zCZ7o4QE0hNLUrNTUwtS
        i2CyMhwcShK8Od+BGgWLUtNTK9Iyc0oQ0kwcnCDDeYCGbwep4S0uSMwtzkyHyJ9i1OX4837q
        JGYhlrz8vFQpcd4zIEUCIEUZpXlwc2AJ5BWjONBbwryaIFU8wOQDN+kV0BImoCXsbGBLShIR
        UlINjA27vuycO1Gl3+RMHO/LeqWl/7p9TMRX9wnt+WDuZl/d+1/ySYSjgs35pU+Od2/X3bhr
        lpxIOmP50ZPzbt8wO16gwv1HyOFEwd+H4W9vTUnbtStxt1GXWMHuhKofRszBuZ6rrrFGRdmv
        sWdKmnv/T5yiyPRTU9vXp8YUr20o+tBisOD6/poKUyWW4oxEQy3mouJEANCYipn7AgAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e634d8fc792c ("x86-64: merge the standard and compat
start_thread() functions") removed exporting for the start_thread()
function in what seems like a typo. Add it back to
arch/x86/kernel/process_64.c for parity with process_32.c and other
arch.

Signed-off-by: Rian Hunter <rian@alum.mit.edu>
---
 arch/x86/kernel/process_64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 476e3ddf8890..a451bc374b9b 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -384,6 +384,7 @@ start_thread(struct pt_regs *regs, unsigned long new_ip, unsigned long new_sp)
 	start_thread_common(regs, new_ip, new_sp,
 			    __USER_CS, __USER_DS, 0);
 }
+EXPORT_SYMBOL_GPL(start_thread);
 
 #ifdef CONFIG_COMPAT
 void compat_start_thread(struct pt_regs *regs, u32 new_ip, u32 new_sp)
-- 
2.16.3

