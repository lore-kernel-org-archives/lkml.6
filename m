Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF48C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8CAA208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYPPR7Sh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8CAA208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbeH1DEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 23:04:22 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36013 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbeH1DEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 23:04:20 -0400
Received: by mail-ed1-f68.google.com with SMTP id f4-v6so7288edq.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 16:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s6qbyyLqbp/XjehlOHGmdLl2HyIigeWX+nXt1s4CT8s=;
        b=rYPPR7Sh1VSXas9/ch6D8wx3B+sB5AzxOCTqFcAY+G2gynOGt/Ov0xhmcPGqZua1er
         dry8z4mgoew7dRoRPDhCIsmV9Fu+2IXpTEzyUTmgwrnyaGPr2Y8SeVXdziqdI7UktsE2
         Q1jnJcOJWSTKDtrF7X2JAxhbSncJaidS/4DcY1ASwuMPI9by7q63mGKGK5cPESTJnJgd
         ajytzNvPBZ8PtpvqyK0c+Q6qSWx91ErONJJo8gcC3y7IZul1Uo7PbFAi0F6YInotvVgh
         MNqJIYwPAxqxFkJ+lLxSMOpZ8BX+qTM6EFP+sp9J7Tbro+/FdF7ojs989UUmYafGisrC
         pgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s6qbyyLqbp/XjehlOHGmdLl2HyIigeWX+nXt1s4CT8s=;
        b=CJNR3q3mj7zjOvt+ZpdCWtHcKDTOdnucjMulyEmlANrMeaQgKedsIMPpDDYR6E1dE/
         0AtpqdoccRKaHV+DWCgRHnlvKd+0nPSJFFjN10zIP8UTeDHDJmV7BwG7IVmKD8YIHsGO
         2ie28anBhL1OY5a5SeSd1h8d9h8DHovcuciIGIKUdUnALZ1sxqPfgXDlmXaFbJPX5but
         nGuPx4H6K+jV7/gDJLG/TsYi9RGrOMAlRzGbAOW4wfPB5mcFB8i86kRGvZc2NpgckmWk
         yXBnhPcAjTLwedo1fOQrh3+py+kTGTZldApH+mNngSfuAvYwqzz8cjDY61Sp9hR+Bdmm
         37VQ==
X-Gm-Message-State: APzg51DgHsvol9wG1oGdyUIABGP9ANNqptp8rLROUgWMKFApSsDCLmz7
        OT54mnrCaGVMWIyGzULoug==
X-Google-Smtp-Source: ANB0VdYs2LFo5PglYatjcfS6cI9OPuy236pQ5ifdfrXb9EiuruXVaM8/QfAkcQcdYFrEAHrcSroL0w==
X-Received: by 2002:a50:8f66:: with SMTP id 93-v6mr18700781edy.248.1535411733651;
        Mon, 27 Aug 2018 16:15:33 -0700 (PDT)
Received: from localhost.localdomain (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id u3-v6sm173918edo.44.2018.08.27.16.15.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 16:15:33 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH 02/13] proc: apply seq_puts() whenever possible
Date:   Tue, 28 Aug 2018 02:14:52 +0300
Message-Id: <20180827231503.26899-2-adobriyan@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180827231503.26899-1-adobriyan@gmail.com>
References: <20180827231503.26899-1-adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

seq_puts() is faster than seq_printf() because it doesn't search for
format specifiers.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/proc/array.c | 16 ++++++++--------
 fs/proc/base.c  |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 0ceb3b6b37e7..5016e03a4dba 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -343,28 +343,28 @@ static inline void task_seccomp(struct seq_file *m, struct task_struct *p)
 #ifdef CONFIG_SECCOMP
 	seq_put_decimal_ull(m, "\nSeccomp:\t", p->seccomp.mode);
 #endif
-	seq_printf(m, "\nSpeculation_Store_Bypass:\t");
+	seq_puts(m, "\nSpeculation_Store_Bypass:\t");
 	switch (arch_prctl_spec_ctrl_get(p, PR_SPEC_STORE_BYPASS)) {
 	case -EINVAL:
-		seq_printf(m, "unknown");
+		seq_puts(m, "unknown");
 		break;
 	case PR_SPEC_NOT_AFFECTED:
-		seq_printf(m, "not vulnerable");
+		seq_puts(m, "not vulnerable");
 		break;
 	case PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE:
-		seq_printf(m, "thread force mitigated");
+		seq_puts(m, "thread force mitigated");
 		break;
 	case PR_SPEC_PRCTL | PR_SPEC_DISABLE:
-		seq_printf(m, "thread mitigated");
+		seq_puts(m, "thread mitigated");
 		break;
 	case PR_SPEC_PRCTL | PR_SPEC_ENABLE:
-		seq_printf(m, "thread vulnerable");
+		seq_puts(m, "thread vulnerable");
 		break;
 	case PR_SPEC_DISABLE:
-		seq_printf(m, "globally mitigated");
+		seq_puts(m, "globally mitigated");
 		break;
 	default:
-		seq_printf(m, "vulnerable");
+		seq_puts(m, "vulnerable");
 		break;
 	}
 	seq_putc(m, '\n');
diff --git a/fs/proc/base.c b/fs/proc/base.c
index ccf86f16d9f0..f96babf3cffc 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -442,7 +442,7 @@ static int proc_pid_schedstat(struct seq_file *m, struct pid_namespace *ns,
 			      struct pid *pid, struct task_struct *task)
 {
 	if (unlikely(!sched_info_on()))
-		seq_printf(m, "0 0 0\n");
+		seq_puts(m, "0 0 0\n");
 	else
 		seq_printf(m, "%llu %llu %lu\n",
 		   (unsigned long long)task->se.sum_exec_runtime,
-- 
2.16.4

