Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A639EC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA9C2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544539026;
	bh=A9tI16gImqVtUqmild2k3OknX4Gzc1otd8HuiaCL7wI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kkbnbtd8Z/jMD6IzqaTgVYWQ2ZJpt92EraELqSXTzPUbmM/aGBctA2o9+a/48TUkq
	 jiXTpFFAizNwOU6OnhA7FUcPivvtvQKgWD9rKdXApY2vOUyvBU4rTaJYWQBRSsK4Mu
	 Hwa6PDQn85da9ACfhxg0qBnXoum47W5XxO3RP6iw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA9C2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbeLKOhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:37:00 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39715 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbeLKOgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:36:54 -0500
Received: by mail-ed1-f66.google.com with SMTP id b14so12695023edt.6;
        Tue, 11 Dec 2018 06:36:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AyqbHZLKGmThJTrdoLh3HA5rnpO95hPXZGeWvc40dsA=;
        b=nfRgz4MIK+UUd6Hb6/raw0KlGLFdOXu4JHN9SUYcGP8lsZsHPKuYoq8tdXPRoSa9kD
         3HnOML9joMQG7tn2UQ7R7+C87tdFpUC9ehp5RJoQ/ogiYnku6fwxXUN5P/JG7hGLyDpe
         hK7XRmhkGeNzoVqjubzDMy+BasNMsjHxkuWKkzdpI7cuolmHMvY5yksFQtWNEt8cLM6G
         HlDNdt+up/nRUnRjNKe7ObMAd/+VVka8PsdGLoTR/IDVw4JugyYmSgKbs2U99twNEOZX
         bV99P6N5RdC47NPfadZbmlSSunM8uoNZlejMvn4KwCwHkfYAhlEoFWWtDksI1BY6dINr
         Uuaw==
X-Gm-Message-State: AA+aEWYJZnPzueVzpp0Wequpo88e+rOwoMp0+85Xp04HEqqyrXp7cVRi
        u2yojkX/ytCWuHh578K49d8=
X-Google-Smtp-Source: AFSGD/X7KLzdI7d7PZLo/hrL6aPDD+b2i67B2umVhARl/QOcSpLVm+N2KaswALPenC4TARVGpLhuOQ==
X-Received: by 2002:a50:a086:: with SMTP id 6mr15066935edo.88.1544539012411;
        Tue, 11 Dec 2018 06:36:52 -0800 (PST)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id z40sm4017084edz.86.2018.12.11.06.36.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 06:36:51 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-api@vger.kernel.org, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 3/3] mm, proc: report PR_SET_THP_DISABLE in proc
Date:   Tue, 11 Dec 2018 15:36:41 +0100
Message-Id: <20181211143641.3503-4-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181211143641.3503-1-mhocko@kernel.org>
References: <20181211143641.3503-1-mhocko@kernel.org>
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
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 Documentation/filesystems/proc.txt |  3 +++
 fs/proc/array.c                    | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
index cd465304bec4..b24fd9bccc99 100644
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
2.19.2

