Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224jnCmu6VHJBiQyZBeVgQUiVuHUkYKSxDD+7DVzxGL1n/zKnVL4Fn8sMGxBwsWuT6qqUF8R
ARC-Seal: i=1; a=rsa-sha256; t=1519217778; cv=none;
        d=google.com; s=arc-20160816;
        b=arXTbpKeJy8wcRqan8+SPHPGd1PS6essMLasgFJvxkkerqczz6qb+h3VVwCkosHNCX
         kOstqMiFP4WaaJO7Rlqdfr/puH5/vfcu51RxnAJlxD0HvTthYAJjqXFOeWRx1GDeJFm9
         v/oasBNuXPVSTtnHiKvlba3f60vNRPxP4xmERzZHPu1RYIoaLhRMmcZHY817RqUqmhG9
         Uk+zFulwjCPcp0aK66HRVbm2l5O4WsPVFCZGcTCMHRJANeibR2XgqpjUpxHSu2YjxuHL
         gZdUrYu8NivDJW3gDi2Yt9z0eSaPIjL38gzuuXCv6xcLmFXXktmAgHLJZdYk+Yx97PQj
         n5zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7lkwW6svWujFH7SvJ5w2i3iqwOpJLGqRaJGkqrX8btA=;
        b=xAiu8JwGQ6uxudJFbnnHxnhtT6WHtb/SQyzD886cFqsu26onEMFIOe1XB0nE8DD0br
         /m6ZdmvpfCObW2UV4Ah4dQUn/fuzrSOmbqJkl6AcK1IJ6hs/2jQHO1XfdZ0NffFAdenr
         L+YalxTiAONOfNa06rbcUYu3E4elUC3kq6z4Z7ofPH8EExggKZrrdE/RbLPtPLvO4W9x
         NHMQJ5TjMgbApnACvv/JqPl4mBpiMdVNl8I6ptaaO+Ag6BSt/9vCueK5q2WCtTprrt3+
         R7SvT7nZUTaDKwoCuQLh54RmSKOea1C6zqFyHyUpXHPpgSA010/cPiwCLdAvEJXsl0wf
         adTA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexander Potapenko <glider@google.com>,
	Eric Biggers <ebiggers@google.com>
Subject: [PATCH 4.9 05/77] mbcache: initialize entry->e_referenced in mb_cache_entry_create()
Date: Wed, 21 Feb 2018 13:48:14 +0100
Message-Id: <20180221124432.394552147@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015301228685105?=
X-GMAIL-MSGID: =?utf-8?q?1593015301228685105?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Potapenko <glider@google.com>

commit 3876bbe27d04b848750d5310a37d6b76b593f648 upstream.

KMSAN reported use of uninitialized |entry->e_referenced| in a condition
in mb_cache_shrink():

==================================================================
BUG: KMSAN: use of uninitialized memory in mb_cache_shrink+0x3b4/0xc50 fs/mbcache.c:287
CPU: 2 PID: 816 Comm: kswapd1 Not tainted 4.11.0-rc5+ #2877
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs
01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:16 [inline]
 dump_stack+0x172/0x1c0 lib/dump_stack.c:52
 kmsan_report+0x12a/0x180 mm/kmsan/kmsan.c:927
 __msan_warning_32+0x61/0xb0 mm/kmsan/kmsan_instr.c:469
 mb_cache_shrink+0x3b4/0xc50 fs/mbcache.c:287
 mb_cache_scan+0x67/0x80 fs/mbcache.c:321
 do_shrink_slab mm/vmscan.c:397 [inline]
 shrink_slab+0xc3d/0x12d0 mm/vmscan.c:500
 shrink_node+0x208f/0x2fd0 mm/vmscan.c:2603
 kswapd_shrink_node mm/vmscan.c:3172 [inline]
 balance_pgdat mm/vmscan.c:3289 [inline]
 kswapd+0x160f/0x2850 mm/vmscan.c:3478
 kthread+0x46c/0x5f0 kernel/kthread.c:230
 ret_from_fork+0x29/0x40 arch/x86/entry/entry_64.S:430
chained origin:
 save_stack_trace+0x37/0x40 arch/x86/kernel/stacktrace.c:59
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:302 [inline]
 kmsan_save_stack mm/kmsan/kmsan.c:317 [inline]
 kmsan_internal_chain_origin+0x12a/0x1f0 mm/kmsan/kmsan.c:547
 __msan_store_shadow_origin_1+0xac/0x110 mm/kmsan/kmsan_instr.c:257
 mb_cache_entry_create+0x3b3/0xc60 fs/mbcache.c:95
 ext4_xattr_cache_insert fs/ext4/xattr.c:1647 [inline]
 ext4_xattr_block_set+0x4c82/0x5530 fs/ext4/xattr.c:1022
 ext4_xattr_set_handle+0x1332/0x20a0 fs/ext4/xattr.c:1252
 ext4_xattr_set+0x4d2/0x680 fs/ext4/xattr.c:1306
 ext4_xattr_trusted_set+0x8d/0xa0 fs/ext4/xattr_trusted.c:36
 __vfs_setxattr+0x703/0x790 fs/xattr.c:149
 __vfs_setxattr_noperm+0x27a/0x6f0 fs/xattr.c:180
 vfs_setxattr fs/xattr.c:223 [inline]
 setxattr+0x6ae/0x790 fs/xattr.c:449
 path_setxattr+0x1eb/0x380 fs/xattr.c:468
 SYSC_lsetxattr+0x8d/0xb0 fs/xattr.c:490
 SyS_lsetxattr+0x77/0xa0 fs/xattr.c:486
 entry_SYSCALL_64_fastpath+0x13/0x94
origin:
 save_stack_trace+0x37/0x40 arch/x86/kernel/stacktrace.c:59
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:302 [inline]
 kmsan_internal_poison_shadow+0xb1/0x1a0 mm/kmsan/kmsan.c:198
 kmsan_kmalloc+0x7f/0xe0 mm/kmsan/kmsan.c:337
 kmem_cache_alloc+0x1c2/0x1e0 mm/slub.c:2766
 mb_cache_entry_create+0x283/0xc60 fs/mbcache.c:86
 ext4_xattr_cache_insert fs/ext4/xattr.c:1647 [inline]
 ext4_xattr_block_set+0x4c82/0x5530 fs/ext4/xattr.c:1022
 ext4_xattr_set_handle+0x1332/0x20a0 fs/ext4/xattr.c:1252
 ext4_xattr_set+0x4d2/0x680 fs/ext4/xattr.c:1306
 ext4_xattr_trusted_set+0x8d/0xa0 fs/ext4/xattr_trusted.c:36
 __vfs_setxattr+0x703/0x790 fs/xattr.c:149
 __vfs_setxattr_noperm+0x27a/0x6f0 fs/xattr.c:180
 vfs_setxattr fs/xattr.c:223 [inline]
 setxattr+0x6ae/0x790 fs/xattr.c:449
 path_setxattr+0x1eb/0x380 fs/xattr.c:468
 SYSC_lsetxattr+0x8d/0xb0 fs/xattr.c:490
 SyS_lsetxattr+0x77/0xa0 fs/xattr.c:486
 entry_SYSCALL_64_fastpath+0x13/0x94
==================================================================

Signed-off-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Cc: stable@vger.kernel.org # v4.6
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/mbcache.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/mbcache.c
+++ b/fs/mbcache.c
@@ -93,6 +93,7 @@ int mb_cache_entry_create(struct mb_cach
 	entry->e_key = key;
 	entry->e_block = block;
 	entry->e_reusable = reusable;
+	entry->e_referenced = 0;
 	head = mb_cache_entry_head(cache, key);
 	hlist_bl_lock(head);
 	hlist_bl_for_each_entry(dup, dup_node, head, e_hash_list) {
