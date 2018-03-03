Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752300AbeCCULW (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 15:11:22 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33868 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbeCCULU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 15:11:20 -0500
X-Google-Smtp-Source: AG47ELvMRsPncBmgZnufvfxAa+ITUqevghaYxcUkspjZbsPifI5xJJzIql6GyyQ3zx+NYKOTNbQRVg==
Date: Sat, 3 Mar 2018 23:11:16 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, yeohc@au1.ibm.com, jann@thejh.net
Subject: [PATCH] mm: relax ptrace mode in process_vm_readv(2)
Message-ID: <20180303201116.GA10031@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is more natural to check for read-from-memory permissions in case of
process_vm_readv() as PTRACE_MODE_ATTACH is equivalent to write
permissions.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 mm/process_vm_access.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/process_vm_access.c
+++ b/mm/process_vm_access.c
@@ -204,7 +204,7 @@ static ssize_t process_vm_rw_core(pid_t pid, struct iov_iter *iter,
 		goto free_proc_pages;
 	}
 
-	mm = mm_access(task, PTRACE_MODE_ATTACH_REALCREDS);
+	mm = mm_access(task, vm_write ? PTRACE_MODE_ATTACH_REALCREDS : PTRACE_MODE_READ_REALCREDS);
 	if (!mm || IS_ERR(mm)) {
 		rc = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
 		/*
