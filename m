Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752735AbeEUNi7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 09:38:59 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:62485 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752650AbeEUNi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 09:38:56 -0400
From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
To: netdev@vger.kernel.org, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: davem@davemloft.net, viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        stephen@networkplumber.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, ganeshgr@chelsio.com,
        nirranjan@chelsio.com, indranil@chelsio.com,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Subject: [PATCH net-next] vmcore: move get_vmcore_size out of __init
Date: Mon, 21 May 2018 19:07:50 +0530
Message-Id: <1526909870-27630-1-git-send-email-rahul.lakkireddy@chelsio.com>
X-Mailer: git-send-email 2.5.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below build warning:

WARNING: vmlinux.o(.text+0x422bb8): Section mismatch in reference from
the function vmcore_add_device_dump() to the function
.init.text:get_vmcore_size.constprop.5()

The function vmcore_add_device_dump() references
the function __init get_vmcore_size.constprop.5().
This is often because vmcore_add_device_dump lacks a __init
annotation or the annotation of get_vmcore_size.constprop.5 is wrong.

Fixes: 7efe48df8a3d ("vmcore: append device dumps to vmcore as elf notes")
Signed-off-by: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
---
 fs/proc/vmcore.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 247c3499e5bd..cfb6674331fd 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -649,8 +649,8 @@ static struct vmcore* __init get_new_element(void)
 	return kzalloc(sizeof(struct vmcore), GFP_KERNEL);
 }
 
-static u64 __init get_vmcore_size(size_t elfsz, size_t elfnotesegsz,
-				  struct list_head *vc_list)
+static u64 get_vmcore_size(size_t elfsz, size_t elfnotesegsz,
+			   struct list_head *vc_list)
 {
 	u64 size;
 	struct vmcore *m;
-- 
2.14.1
