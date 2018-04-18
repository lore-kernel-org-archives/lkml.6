Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753002AbeDRKvW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 06:51:22 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:47455 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbeDRKvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 06:51:21 -0400
Subject: Re: [PATCH 2/2] fs, elf: drop MAP_FIXED usage from elf_map
To: Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>
Cc: linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
References: <20171213092550.2774-1-mhocko@kernel.org>
 <20171213092550.2774-3-mhocko@kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <0b5c541a-91ee-220b-3196-f64264f9f0bc@I-love.SAKURA.ne.jp>
Date: Wed, 18 Apr 2018 19:51:05 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20171213092550.2774-3-mhocko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From 0ba20dcbbc40b703413c9a6907a77968b087811b Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Wed, 18 Apr 2018 15:31:48 +0900
Subject: [PATCH] fs, elf: don't complain MAP_FIXED_NOREPLACE if mapping
 failed.

Commit 4ed28639519c7bad ("fs, elf: drop MAP_FIXED usage from elf_map") is
printing spurious messages under memory pressure due to map_addr == -ENOMEM.

 9794 (a.out): Uhuuh, elf segment at 00007f2e34738000(fffffffffffffff4) requested but the memory is mapped already
 14104 (a.out): Uhuuh, elf segment at 00007f34fd76c000(fffffffffffffff4) requested but the memory is mapped already
 16843 (a.out): Uhuuh, elf segment at 00007f930ecc7000(fffffffffffffff4) requested but the memory is mapped already

Don't complain if IS_ERR_VALUE(), and use %px for printing the address.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Andrei Vagin <avagin@openvz.org>
Cc: Khalid Aziz <khalid.aziz@oracle.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Kees Cook <keescook@chromium.org>
Cc: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 fs/binfmt_elf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 41e0418..559d35b 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -377,10 +377,10 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
 	} else
 		map_addr = vm_mmap(filep, addr, size, prot, type, off);
 
-	if ((type & MAP_FIXED_NOREPLACE) && BAD_ADDR(map_addr))
-		pr_info("%d (%s): Uhuuh, elf segment at %p requested but the memory is mapped already\n",
-				task_pid_nr(current), current->comm,
-				(void *)addr);
+	if ((type & MAP_FIXED_NOREPLACE) && BAD_ADDR(map_addr) &&
+	    !IS_ERR_VALUE(map_addr))
+		pr_info("%d (%s): Uhuuh, elf segment at %px requested but the memory is mapped already\n",
+			task_pid_nr(current), current->comm, (void *)addr);
 
 	return(map_addr);
 }
-- 
1.8.3.1
