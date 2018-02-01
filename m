Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbeBAKlt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 05:41:49 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40078 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751766AbeBAKlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 05:41:46 -0500
X-Google-Smtp-Source: AH8x224Nj93xHziZuyJTpjzGlFVUL/FNE1x0RLTn9wHmRqBnteUc4GjBf4ik3amaEslQoWNg/Ap97w==
Date: Thu, 1 Feb 2018 02:41:43 -0800
From: Kees Cook <keescook@chromium.org>
To: syzbot+e2d6cfb305e9f3911dea@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Eric Biggers <ebiggers3@gmail.com>, james.morse@arm.com,
        keun-o.park@darkmatter.ae, labbott@redhat.com, linux-mm@kvack.org,
        mingo@kernel.org
Subject: [PATCH] socket: Provide bounce buffer for constant sized put_cmsg()
Message-ID: <20180201104143.GA10983@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most callers of put_cmsg() use a "sizeof(foo)" for the length argument.
Within put_cmsg(), a copy_to_user() call is made with a dynamic size, as a
result of the cmsg header calculations. This means that hardened usercopy
will examine the copy, even though it was technically a fixed size and
should be implicitly whitelisted. Since most whitelists for put_cmsg()
would need to be in skbuff_head_cache on a per-protocol basis, avoid this
complexity by just providing small bounce buffers where the size is fixed.

Original report was:

Bad or missing usercopy whitelist? Kernel memory exposure attempt detected from SLAB object 'skbuff_head_cache' (offset 64, size 16)!
WARNING: CPU: 0 PID: 3663 at mm/usercopy.c:81 usercopy_warn+0xdb/0x100 mm/usercopy.c:76
...
 __check_heap_object+0x89/0xc0 mm/slab.c:4426
 check_heap_object mm/usercopy.c:236 [inline]
 __check_object_size+0x272/0x530 mm/usercopy.c:259
 check_object_size include/linux/thread_info.h:112 [inline]
 check_copy_size include/linux/thread_info.h:143 [inline]
 copy_to_user include/linux/uaccess.h:154 [inline]
 put_cmsg+0x233/0x3f0 net/core/scm.c:242
 sock_recv_errqueue+0x200/0x3e0 net/core/sock.c:2913
 packet_recvmsg+0xb2e/0x17a0 net/packet/af_packet.c:3296
 sock_recvmsg_nosec net/socket.c:803 [inline]
 sock_recvmsg+0xc9/0x110 net/socket.c:810
 ___sys_recvmsg+0x2a4/0x640 net/socket.c:2179
 __sys_recvmmsg+0x2a9/0xaf0 net/socket.c:2287
 SYSC_recvmmsg net/socket.c:2368 [inline]
 SyS_recvmmsg+0xc4/0x160 net/socket.c:2352
 entry_SYSCALL_64_fastpath+0x29/0xa0

Reported-by: syzbot+e2d6cfb305e9f3911dea@syzkaller.appspotmail.com
Fixes: 6d07d1cd300f ("usercopy: Restrict non-usercopy caches to size 0")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/socket.h | 18 +++++++++++++++++-
 net/core/scm.c         |  4 ++--
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 9286a5a8c60c..b3c5a075b7b3 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -342,7 +342,23 @@ struct ucred {
 #define IPX_TYPE	1
 
 extern int move_addr_to_kernel(void __user *uaddr, int ulen, struct sockaddr_storage *kaddr);
-extern int put_cmsg(struct msghdr*, int level, int type, int len, void *data);
+extern int __put_cmsg(struct msghdr*, int level, int type, int len, void *data);
+/*
+ * Provide a bounce buffer for copying cmsg data to userspace when the size
+ * is constant. Without this, hardened usercopy will see the dynamic size
+ * calculation in __put_cmsg and try to block it. Constant sized copies
+ * should not trigger hardened usercopy checks.
+ */
+#define put_cmsg(_msg, _level, _type, _len, _ptr) ({			\
+	int _rc;							\
+	if (__builtin_constant_p(_len)) {				\
+		typeof(*(_ptr)) _val = *(_ptr);				\
+		BUILD_BUG_ON(sizeof(_val) != (_len));			\
+		_rc = __put_cmsg(_msg, _level, _type, sizeof(_val), &_val); \
+	} else {							\
+		_rc = __put_cmsg(_msg, _level, _type, _len, _ptr);	\
+	}								\
+	_rc;})
 
 struct timespec;
 
diff --git a/net/core/scm.c b/net/core/scm.c
index b1ff8a441748..3a3ecf528800 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -213,7 +213,7 @@ int __scm_send(struct socket *sock, struct msghdr *msg, struct scm_cookie *p)
 }
 EXPORT_SYMBOL(__scm_send);
 
-int put_cmsg(struct msghdr * msg, int level, int type, int len, void *data)
+int __put_cmsg(struct msghdr *msg, int level, int type, int len, void *data)
 {
 	struct cmsghdr __user *cm
 		= (__force struct cmsghdr __user *)msg->msg_control;
@@ -250,7 +250,7 @@ int put_cmsg(struct msghdr * msg, int level, int type, int len, void *data)
 out:
 	return err;
 }
-EXPORT_SYMBOL(put_cmsg);
+EXPORT_SYMBOL(__put_cmsg);
 
 void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm)
 {
-- 
2.7.4


-- 
Kees Cook
Pixel Security
