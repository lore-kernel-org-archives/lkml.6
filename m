Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9160EC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4129E20866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4129E20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbeIMTZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:25:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60400 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728536AbeIMSxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:53:18 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2CF1DD19;
        Thu, 13 Sep 2018 13:43:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Philipp Rudo <prudo@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 039/115] s390/kdump: Fix memleak in nt_vmcoreinfo
Date:   Thu, 13 Sep 2018 15:30:59 +0200
Message-Id: <20180913131826.128092819@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131823.327472833@linuxfoundation.org>
References: <20180913131823.327472833@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Philipp Rudo <prudo@linux.ibm.com>

[ Upstream commit 2d2e7075b87181ed0c675e4936e20bdadba02e1f ]

The vmcoreinfo of a crashed system is potentially fragmented. Thus the
crash kernel has an intermediate step where the vmcoreinfo is copied into a
temporary, continuous buffer in the crash kernel memory. This temporary
buffer is never freed. Free it now to prevent the memleak.

While at it replace all occurrences of "VMCOREINFO" by its corresponding
macro to prevent potential renaming issues.

Signed-off-by: Philipp Rudo <prudo@linux.ibm.com>
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/crash_dump.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -404,11 +404,13 @@ static void *get_vmcoreinfo_old(unsigned
 	if (copy_oldmem_kernel(nt_name, addr + sizeof(note),
 			       sizeof(nt_name) - 1))
 		return NULL;
-	if (strcmp(nt_name, "VMCOREINFO") != 0)
+	if (strcmp(nt_name, VMCOREINFO_NOTE_NAME) != 0)
 		return NULL;
 	vmcoreinfo = kzalloc_panic(note.n_descsz);
-	if (copy_oldmem_kernel(vmcoreinfo, addr + 24, note.n_descsz))
+	if (copy_oldmem_kernel(vmcoreinfo, addr + 24, note.n_descsz)) {
+		kfree(vmcoreinfo);
 		return NULL;
+	}
 	*size = note.n_descsz;
 	return vmcoreinfo;
 }
@@ -418,15 +420,20 @@ static void *get_vmcoreinfo_old(unsigned
  */
 static void *nt_vmcoreinfo(void *ptr)
 {
+	const char *name = VMCOREINFO_NOTE_NAME;
 	unsigned long size;
 	void *vmcoreinfo;
 
 	vmcoreinfo = os_info_old_entry(OS_INFO_VMCOREINFO, &size);
-	if (!vmcoreinfo)
-		vmcoreinfo = get_vmcoreinfo_old(&size);
+	if (vmcoreinfo)
+		return nt_init_name(ptr, 0, vmcoreinfo, size, name);
+
+	vmcoreinfo = get_vmcoreinfo_old(&size);
 	if (!vmcoreinfo)
 		return ptr;
-	return nt_init_name(ptr, 0, vmcoreinfo, size, "VMCOREINFO");
+	ptr = nt_init_name(ptr, 0, vmcoreinfo, size, name);
+	kfree(vmcoreinfo);
+	return ptr;
 }
 
 /*


