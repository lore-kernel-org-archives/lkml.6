Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF8DC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66CBB20842
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:00:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66CBB20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbeH1OvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 10:51:25 -0400
Received: from nautica.notk.org ([91.121.71.147]:53805 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727265AbeH1OvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 10:51:25 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id C84A8C009; Tue, 28 Aug 2018 13:00:14 +0200 (CEST)
Date:   Tue, 28 Aug 2018 12:59:59 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: KASAN error in [PATCH v3 7/8] proc/kcore: optimize multiple page
 reads
Message-ID: <20180828105959.GA29204@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fd346c11090cf93d867e01b8d73a6567c5ac6361.1531953780.git.osandov@fb.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> The current code does a full search of the segment list every time for
> every page. This is wasteful, since it's almost certain that the next
> page will be in the same segment. Instead, check if the previous segment
> covers the current page before doing the list search.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  fs/proc/kcore.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> index e2ca58d49938..25fefdd05ee5 100644
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -428,10 +428,18 @@ read_kcore(struct file *file, char __user *buffer,
> size_t buflen, loff_t *fpos)
>  	if ((tsz = (PAGE_SIZE - (start & ~PAGE_MASK))) > buflen)
>  		tsz = buflen;
>  
> +	m = NULL;
>  	while (buflen) {
> -		list_for_each_entry(m, &kclist_head, list) {
> -			if (start >= m->addr && start < (m->addr+m->size))
> -				break;
> +		/*
> +		 * If this is the first iteration or the address is not within
> +		 * the previous entry, search for a matching entry.
> +		 */
> +		if (!m || start < m->addr || start >= m->addr + m->size) {

This line apparently triggers a KASAN warning since I rebooted on
4.19-rc1

This is 100% reproductible on my machine when the kdump service starts
(fedora28 x86_64 VM), here's the full stack (on 4.19-rc1):
[   38.161102] BUG: KASAN: global-out-of-bounds in read_kcore+0xd5c/0xf20
[   38.162123] Read of size 8 at addr ffffffffa6c0f770 by task kexec/6201

[   38.163386] CPU: 16 PID: 6201 Comm: kexec Not tainted 4.19.0-rc1+ #13
[   38.164374] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.11.2-0-gf9626ccb91-prebuilt.qemu-project.org 04/01/2014
[   38.166211] Call Trace:
[   38.166658]  dump_stack+0x71/0xa9
[   38.167443]  print_address_description+0x65/0x22e
[   38.168194]  ? read_kcore+0xd5c/0xf20
[   38.168778]  kasan_report.cold.6+0x241/0x306
[   38.169458]  read_kcore+0xd5c/0xf20
[   38.170018]  ? open_kcore+0x1d0/0x1d0
[   38.170605]  ? avc_has_perm_noaudit+0x370/0x370
[   38.171291]  ? kasan_unpoison_shadow+0x30/0x40
[   38.171973]  ? kasan_kmalloc+0xbf/0xe0
[   38.172562]  ? kmem_cache_alloc_trace+0x105/0x200
[   38.173289]  ? open_kcore+0x5f/0x1d0
[   38.173858]  ? open_kcore+0x5f/0x1d0
[   38.174428]  ? deref_stack_reg+0xe0/0xe0
[   38.175038]  proc_reg_read+0x18b/0x220
[   38.175652]  ? proc_reg_unlocked_ioctl+0x210/0x210
[   38.176399]  __vfs_read+0xe1/0x6b0
[   38.176930]  ? __x64_sys_copy_file_range+0x450/0x450
[   38.177723]  ? do_filp_open+0x190/0x250
[   38.178313]  ? may_open_dev+0xc0/0xc0
[   38.178886]  ? __fsnotify_update_child_dentry_flags.part.3+0x330/0x330
[   38.179883]  ? __fsnotify_inode_delete+0x20/0x20
[   38.180608]  ? __inode_security_revalidate+0x8e/0xb0
[   38.181378]  vfs_read+0xde/0x2c0
[   38.181889]  ksys_read+0xb2/0x160
[   38.182413]  ? kernel_write+0x130/0x130
[   38.183000]  ? task_work_run+0x74/0x1c0
[   38.183621]  do_syscall_64+0xa0/0x2e0
[   38.184183]  ? async_page_fault+0x8/0x30
[   38.184802]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   38.185610] RIP: 0033:0x7fc525d74091
[   38.186155] Code: fe ff ff 50 48 8d 3d b6 b6 09 00 e8 59 05 02 00 66 0f 1f 84 00 00 00 00 00 48 8d 05 51 39 2d 00 8b 00 85 c0 75 13 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 57 c3 66 0f 1f 44 00 00 41 54 49 89 d4 55 48
[   38.188980] RSP: 002b:00007fffd6802a28 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[   38.190153] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc525d74091
[   38.191240] RDX: 0000000000010000 RSI: 00000000017f90b0 RDI: 0000000000000004
[   38.192329] RBP: 0000000000010000 R08: 00007fc526043420 R09: 0000000000000001
[   38.194593] R10: 00000000017e8010 R11: 0000000000000246 R12: 00000000017f90b0
[   38.196823] R13: 0000000000000004 R14: 00007fffd6802ac8 R15: 00007fffd6802cb0

[   38.200526] The buggy address belongs to the variable:
[   38.202539]  kclist_head+0x10/0x440

[   38.205568] Memory state around the buggy address:
[   38.207411]  ffffffffa6c0f600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   38.209648]  ffffffffa6c0f680: 00 00 00 00 00 00 00 00 04 fa fa fa fa fa fa fa
[   38.211812] >ffffffffa6c0f700: 00 00 00 00 00 fa fa fa fa fa fa fa 00 00 fa fa
[   38.213936]                                                              ^
[   38.216010]  ffffffffa6c0f780: fa fa fa fa 00 00 00 00 00 00 00 00 00 00 00 00
[   38.218178]  ffffffffa6c0f800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   38.220306] ==================================================================

where
[   37.636589]  read_kcore+0xd5c/0xf20
symbolizes to
[<        none        >] read_kcore+0xd5c/0xf20 fs/proc/kcore.c:454
, the above check.


I haven't checked but I think I am in the first case below:
                if (&m->list == &kclist_head) {
meaning no address matched in the list, so you cannot check m->addr and
m->size in this case -- I'm afraid you will have to run through the list
just in case if that happens even if there likely won't be any match for
the next address either.


> +			list_for_each_entry(m, &kclist_head, list) {
> +				if (start >= m->addr &&
> +				    start < m->addr + m->size)
> +					break;
> +			}
>  		}
>  
>  		if (&m->list == &kclist_head) {

-- 
Dominique Martinet
