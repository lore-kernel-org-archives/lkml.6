Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0718C04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8444C2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:35:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8444C2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbeKTVED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:04:03 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35465 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbeKTVEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 16:04:01 -0500
Received: by mail-ed1-f65.google.com with SMTP id x30so1477539edx.2;
        Tue, 20 Nov 2018 02:35:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UipYMHSvtb8aOnY17kKqlQt8aWhzlLzqt0JzwQhgn3Q=;
        b=dUZF0MtC11p/3zKul2X6vb8MY1asbCiNuK2tOGTtM8spd8V2bQDXjhurZkGFUed/WU
         zFR73drmuDXzgM8VtchnIeV9zvPukan8NpW17DkHzS25aGlVc3DHZYMHdMaj4eANQ8JR
         MF9xtk2CtDsFQVG4vWUFOYCg6ys6JSYMrsliznPsfv4SGKtKTxRQpPaKpPdI89GmPM+d
         tQfD7BlhZ4JK62Rqi23+uNNc9vrpzRJ7QKfhTb6rRp7Pzw17nsHjxHIQMmG6mVSY5e7v
         Dx1DM9TZchKD0rOH3wjYT0ntPUQu1CP9f+Pr9IDOdGiPIf2PJgfrY/2OYRbRPJPpp4Zm
         HYVA==
X-Gm-Message-State: AA+aEWaWN+3ZVd9zQQZh31WP0gn45F6j6Mx+siLkmgAFGwf0utXxBUrR
        LnH+EeWoHC52Be3uPb+vC5DCFlZc
X-Google-Smtp-Source: AFSGD/V5yVod2Y7gafwz/wymq1xETuPkqzv1mUxA0rNo7S2XrmUm5lrOtF+JGoyJr0YZVRuMcFZIxA==
X-Received: by 2002:a05:6402:144c:: with SMTP id d12mr1853102edx.83.1542710132817;
        Tue, 20 Nov 2018 02:35:32 -0800 (PST)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id a15-v6sm5967233ejj.5.2018.11.20.02.35.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 02:35:32 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     linux-api@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH 3/3] mm, proc: report PR_SET_THP_DISABLE in proc
Date:   Tue, 20 Nov 2018 11:35:15 +0100
Message-Id: <20181120103515.25280-4-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120103515.25280-1-mhocko@kernel.org>
References: <20181120103515.25280-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

David Rientjes has reported that 1860033237d4 ("mm: make
PR_SET_THP_DISABLE immediately active") has changed the way how
we report THPable VMAs to the userspace. Their monitoring tool is
triggering false alarms on PR_SET_THP_DISABLE tasks because it considers
an insufficient THP usage as a memory fragmentation resp. memory
pressure issue.

Before the said commit each newly created VMA inherited VM_NOHUGEPAGE
flag and that got exposed to the userspace via /proc/<pid>/smaps file.
This implementation had its downsides as explained in the commit message
but it is true that the userspace doesn't have any means to query for
the process wide THP enabled/disabled status.

PR_SET_THP_DISABLE is a process wide flag so it makes a lot of sense
to export in the process wide context rather than per-vma. Introduce
a new field to /proc/<pid>/status which export this status.  If
PR_SET_THP_DISABLE is used then it reports false same as when the THP is
not compiled in. It doesn't consider the global THP status because we
already export that information via sysfs

Fixes: 1860033237d4 ("mm: make PR_SET_THP_DISABLE immediately active")
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 Documentation/filesystems/proc.txt |  3 +++
 fs/proc/array.c                    | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
index 06562bab509a..7995e9322889 100644
--- a/Documentation/filesystems/proc.txt
+++ b/Documentation/filesystems/proc.txt
@@ -182,6 +182,7 @@ For example, to get the status information of a process, all you have to do is
   VmSwap:        0 kB
   HugetlbPages:          0 kB
   CoreDumping:    0
+  THP_enabled:	  1
   Threads:        1
   SigQ:   0/28578
   SigPnd: 0000000000000000
@@ -256,6 +257,8 @@ Table 1-2: Contents of the status files (as of 4.8)
  HugetlbPages                size of hugetlb memory portions
  CoreDumping                 process's memory is currently being dumped
                              (killing the process may lead to a corrupted core)
+ THP_enabled		     process is allowed to use THP (returns 0 when
+			     PR_SET_THP_DISABLE is set on the process
  Threads                     number of threads
  SigQ                        number of signals queued/max. number for queue
  SigPnd                      bitmap of pending signals for the thread
diff --git a/fs/proc/array.c b/fs/proc/array.c
index 0ceb3b6b37e7..9d428d5a0ac8 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -392,6 +392,15 @@ static inline void task_core_dumping(struct seq_file *m, struct mm_struct *mm)
 	seq_putc(m, '\n');
 }
 
+static inline void task_thp_status(struct seq_file *m, struct mm_struct *mm)
+{
+	bool thp_enabled = IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE);
+
+	if (thp_enabled)
+		thp_enabled = !test_bit(MMF_DISABLE_THP, &mm->flags);
+	seq_printf(m, "THP_enabled:\t%d\n", thp_enabled);
+}
+
 int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
 			struct pid *pid, struct task_struct *task)
 {
@@ -406,6 +415,7 @@ int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
 	if (mm) {
 		task_mem(m, mm);
 		task_core_dumping(m, mm);
+		task_thp_status(m, mm);
 		mmput(mm);
 	}
 	task_sig(m, task);
-- 
2.19.1

