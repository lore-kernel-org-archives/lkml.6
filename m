Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3058C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB3E20868
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546709229;
	bh=0A3wHN1FlRtBEAIh2/X6S4m5yzKc1RDtmlswYmPgYqQ=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=imxYl/RsCG4YlvpOVZq+YQEL+mFeHOJ1SDkaVfPYSHSjuHFIBX7ASlg0TJsQTC4dF
	 2MUbbqu4+8dV48I3TtAgdbHX8WZO1fyr52bnzOmDhtMy5GY8GYfre43cKN828vMI05
	 tNZnyx98NiR1dlxbrdzscbBuZZxUajr6cGg0XjLI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfAER1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 12:27:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:52216 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726252AbfAER1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 12:27:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 24DAFAF09;
        Sat,  5 Jan 2019 17:27:07 +0000 (UTC)
Date:   Sat, 5 Jan 2019 18:27:05 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH] mm/mincore: allow for making sys_mincore() privileged
Message-ID: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

There are possibilities [1] how mincore() could be used as a converyor of 
a sidechannel information about pagecache metadata.

Provide vm.mincore_privileged sysctl, which makes it possible to mincore() 
start returning -EPERM in case it's invoked by a process lacking 
CAP_SYS_ADMIN.

The default behavior stays "mincore() can be used by anybody" in order to 
be conservative with respect to userspace behavior.

[1] https://www.theregister.co.uk/2019/01/05/boffins_beat_page_cache/

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 Documentation/sysctl/vm.txt | 9 +++++++++
 kernel/sysctl.c             | 8 ++++++++
 mm/mincore.c                | 5 +++++
 3 files changed, 22 insertions(+)

diff --git a/Documentation/sysctl/vm.txt b/Documentation/sysctl/vm.txt
index 187ce4f599a2..afb8635e925e 100644
--- a/Documentation/sysctl/vm.txt
+++ b/Documentation/sysctl/vm.txt
@@ -41,6 +41,7 @@ Currently, these files are in /proc/sys/vm:
 - min_free_kbytes
 - min_slab_ratio
 - min_unmapped_ratio
+- mincore_privileged
 - mmap_min_addr
 - mmap_rnd_bits
 - mmap_rnd_compat_bits
@@ -485,6 +486,14 @@ files and similar are considered.
 The default is 1 percent.
 
 ==============================================================
+mincore_privileged:
+
+mincore() could be potentially used to mount a side-channel attack against
+pagecache metadata. This sysctl provides system administrators means to
+make it available only to processess that own CAP_SYS_ADMIN capability.
+
+The default is 0, which means mincore() can be used without restrictions.
+==============================================================
 
 mmap_min_addr
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 1825f712e73b..f03cb07c8dd4 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -114,6 +114,7 @@ extern unsigned int sysctl_nr_open_min, sysctl_nr_open_max;
 #ifndef CONFIG_MMU
 extern int sysctl_nr_trim_pages;
 #endif
+extern int sysctl_mincore_privileged;
 
 /* Constants used for minimum and  maximum */
 #ifdef CONFIG_LOCKUP_DETECTOR
@@ -1684,6 +1685,13 @@ static struct ctl_table vm_table[] = {
 		.extra2		= (void *)&mmap_rnd_compat_bits_max,
 	},
 #endif
+	{
+		.procname	= "mincore_privileged",
+		.data		= &sysctl_mincore_privileged,
+		.maxlen		= sizeof(sysctl_mincore_privileged),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
 	{ }
 };
 
diff --git a/mm/mincore.c b/mm/mincore.c
index 218099b5ed31..77d4928cdfaa 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -21,6 +21,8 @@
 #include <linux/uaccess.h>
 #include <asm/pgtable.h>
 
+int sysctl_mincore_privileged;
+
 static int mincore_hugetlb(pte_t *pte, unsigned long hmask, unsigned long addr,
 			unsigned long end, struct mm_walk *walk)
 {
@@ -228,6 +230,9 @@ SYSCALL_DEFINE3(mincore, unsigned long, start, size_t, len,
 	unsigned long pages;
 	unsigned char *tmp;
 
+	if (sysctl_mincore_privileged && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
 	/* Check the start address: needs to be page-aligned.. */
 	if (start & ~PAGE_MASK)
 		return -EINVAL;
-- 
Jiri Kosina
SUSE Labs
