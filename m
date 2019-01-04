Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90938C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5756621872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="mmj7MDQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfADPfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 10:35:46 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12393 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfADPfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 10:35:46 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c2f7d430002>; Fri, 04 Jan 2019 07:35:31 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 04 Jan 2019 07:35:45 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 04 Jan 2019 07:35:45 -0800
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 4 Jan
 2019 15:35:45 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Fri, 4 Jan 2019 15:35:45 +0000
Received: from amhetre.nvidia.com (Not Verified[10.24.229.42]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c2f7d4f0000>; Fri, 04 Jan 2019 07:35:45 -0800
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <vdumpa@nvidia.com>, <mcgrof@kernel.org>, <keescook@chromium.org>,
        <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <Snikam@nvidia.com>, Ashish Mhetre <amhetre@nvidia.com>
Subject: [PATCH] mm: Expose lazy vfree pages to control via sysctl
Date:   Fri, 4 Jan 2019 21:05:41 +0530
Message-ID: <1546616141-486-1-git-send-email-amhetre@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1546616131; bh=4R4q8oXPqNXWmbjw0o+m2JY9q8qMM6s7EEs/ePoMyR0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=mmj7MDQLasXZ5eBDuMNI1GNjQ83NexJDUotENXYFfQhRZiqj2C3qWkRAuo1PID1KR
         2TNlI8waSpNYPSSe0/x7Vgk/7zawqgSVfi0x1oV5oU3VdsSkhIzNNdlkwk/BJnQ9K5
         qcvAaOF/pUfDRCyf/92dZp/MS6nVOpixdCcFcmHCOXaFKrWHf4LZASkcBIRM1xcVEB
         /w5oespn5VhwSDU0bgCP4K72tg24xlqXVIgEJCV66fxiUfrq3MGrIxg/RrVonhUXAW
         GXAnoAXLwLX0WLbXJLSFIVL9BL1CxwGwKgfYdqK65l7OYbym+/a/7QwdI+q4Vl8jSD
         jIORxwJ4mmPLA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hiroshi Doyu <hdoyu@nvidia.com>

The purpose of lazy_max_pages is to gather virtual address space till it
reaches the lazy_max_pages limit and then purge with a TLB flush and hence
reduce the number of global TLB flushes.
The default value of lazy_max_pages with one CPU is 32MB and with 4 CPUs it
is 96MB i.e. for 4 cores, 96MB of vmalloc space will be gathered before it
is purged with a TLB flush.
This feature has shown random latency issues. For example, we have seen
that the kernel thread for some camera application spent 30ms in
__purge_vmap_area_lazy() with 4 CPUs.
So, create "/proc/sys/lazy_vfree_pages" file to control lazy vfree pages.
With this sysctl, the behaviour of lazy_vfree_pages can be controlled and
the systems which can't tolerate latency issues can also disable it.
This is one of the way through which lazy_vfree_pages can be controlled as
proposed in this patch. The other possible solution would be to configure
lazy_vfree_pages through kernel cmdline.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 kernel/sysctl.c | 8 ++++++++
 mm/vmalloc.c    | 5 ++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 3ae223f..49523efc 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -111,6 +111,7 @@ extern int pid_max;
 extern int pid_max_min, pid_max_max;
 extern int percpu_pagelist_fraction;
 extern int latencytop_enabled;
+extern int sysctl_lazy_vfree_pages;
 extern unsigned int sysctl_nr_open_min, sysctl_nr_open_max;
 #ifndef CONFIG_MMU
 extern int sysctl_nr_trim_pages;
@@ -1251,6 +1252,13 @@ static struct ctl_table kern_table[] = {
 
 static struct ctl_table vm_table[] = {
 	{
+		.procname	= "lazy_vfree_pages",
+		.data		= &sysctl_lazy_vfree_pages,
+		.maxlen		= sizeof(sysctl_lazy_vfree_pages),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+	{
 		.procname	= "overcommit_memory",
 		.data		= &sysctl_overcommit_memory,
 		.maxlen		= sizeof(sysctl_overcommit_memory),
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 97d4b25..fa07966 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -619,13 +619,16 @@ static void unmap_vmap_area(struct vmap_area *va)
  * code, and it will be simple to change the scale factor if we find that it
  * becomes a problem on bigger systems.
  */
+
+int sysctl_lazy_vfree_pages = 32UL * 1024 * 1024 / PAGE_SIZE;
+
 static unsigned long lazy_max_pages(void)
 {
 	unsigned int log;
 
 	log = fls(num_online_cpus());
 
-	return log * (32UL * 1024 * 1024 / PAGE_SIZE);
+	return log * sysctl_lazy_vfree_pages;
 }
 
 static atomic_t vmap_lazy_nr = ATOMIC_INIT(0);
-- 
2.7.4

