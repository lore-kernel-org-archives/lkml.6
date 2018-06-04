Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753956AbeFDHOf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:14:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:56106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753644AbeFDHD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:03:58 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sachin Grover <sgrover@codeaurora.org>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH 4.16 21/47] selinux: KASAN: slab-out-of-bounds in xattr_getsecurity
Date: Mon,  4 Jun 2018 08:58:33 +0200
Message-Id: <20180604065550.380736131@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065549.468488465@linuxfoundation.org>
References: <20180604065549.468488465@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sachin Grover <sgrover@codeaurora.org>

commit efe3de79e0b52ca281ef6691480c8c68c82a4657 upstream.

Call trace:
 [<ffffff9203a8d7a8>] dump_backtrace+0x0/0x428
 [<ffffff9203a8dbf8>] show_stack+0x28/0x38
 [<ffffff920409bfb8>] dump_stack+0xd4/0x124
 [<ffffff9203d187e8>] print_address_description+0x68/0x258
 [<ffffff9203d18c00>] kasan_report.part.2+0x228/0x2f0
 [<ffffff9203d1927c>] kasan_report+0x5c/0x70
 [<ffffff9203d1776c>] check_memory_region+0x12c/0x1c0
 [<ffffff9203d17cdc>] memcpy+0x34/0x68
 [<ffffff9203d75348>] xattr_getsecurity+0xe0/0x160
 [<ffffff9203d75490>] vfs_getxattr+0xc8/0x120
 [<ffffff9203d75d68>] getxattr+0x100/0x2c8
 [<ffffff9203d76fb4>] SyS_fgetxattr+0x64/0xa0
 [<ffffff9203a83f70>] el0_svc_naked+0x24/0x28

If user get root access and calls security.selinux setxattr() with an
embedded NUL on a file and then if some process performs a getxattr()
on that file with a length greater than the actual length of the string,
it would result in a panic.

To fix this, add the actual length of the string to the security context
instead of the length passed by the userspace process.

Signed-off-by: Sachin Grover <sgrover@codeaurora.org>
Cc: stable@vger.kernel.org
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/selinux/ss/services.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1448,7 +1448,7 @@ static int security_context_to_sid_core(
 				      scontext_len, &context, def_sid);
 	if (rc == -EINVAL && force) {
 		context.str = str;
-		context.len = scontext_len;
+		context.len = strlen(str) + 1;
 		str = NULL;
 	} else if (rc)
 		goto out_unlock;
