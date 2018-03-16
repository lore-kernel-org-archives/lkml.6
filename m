Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303463-1521214792-2-1186398854084942839
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521214791; b=Buapg4kj6WflxoJ/MOCpR/L0XKiLjVc5NfzYQflHeR466K7
    ZMA/xwWlgIBc1RuaglMkURWAyDzKVVPTr53Gtce/6A2orPALppPhQu4RKLAAdlXP
    83IT537PPYZu7VEXqXzBCd81NMQ6RVPcI9e2iJKauEBdbc7bNIp6G43QZY7qFgNV
    nBLHJiTzTtgkNG0DAgX54uUdy47CwrbSiiGwYm+Jkwb93fXloehzELYeP2Bnhdpc
    4JEoIQQZt6IPzYAx5L5CvBO3DAr8izs5YHraZi9+LU401fUYG3eCPH4Ilmb3NQ7c
    dldr4bzxFGiLJbSesnAa0s5X9baSkmNrKKxlqJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521214791; bh=ur0BUjMBzvmtIt55+NSHoZj/vP
    xv2d2e1iQ15qsG0O4=; b=bs/yGy4HyxIiZrla4bBM9DVkNLMKPivcBQsC+Sakmq
    tZk9oTVOJN0d+p6QR2++sP0JM+XSE095i+BbikcqR/qN1O47Krhg8nkpq8ggEnSV
    9KbwJsrM5z1dF8l5SpdnSblobyBEaReCdxsbQEnYC0hC8qJJvB6Cq5gOCPDnd337
    /A7JKyUA/0BteFUkqYcxKClnhWvHqRUXUmd9jRlzT2r/EcSlP5bJxfafcwudXrO1
    zz/CyDm2wOmeGzXIqYD7jtLCUs2ELdOu08f9dWawfq6RxLCnmN2wQFKG0DlGQaJj
    MEhXnKotTM7fQpFR1B2KkTcMgGfSWWrRW6RqDQ6GOEKA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753268AbeCPPjs (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:39:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43368 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964934AbeCPPjq (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:39:46 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xinyong <xinyong.fang@linux.alibaba.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.15 019/128] usb: gadget: f_fs: Fix use-after-free in ffs_fs_kill_sb()
Date: Fri, 16 Mar 2018 16:22:40 +0100
Message-Id: <20180316152337.404010833@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xinyong <xinyong.fang@linux.alibaba.com>

commit 1a087f032111a88e826877449dfb93ceb22b78b9 upstream.

When I debug a kernel crash issue in funcitonfs, found ffs_data.ref
overflowed, While functionfs is unmounting, ffs_data is put twice.

Commit 43938613c6fd ("drivers, usb: convert ffs_data.ref from atomic_t to
refcount_t") can avoid refcount overflow, but that is risk some situations.
So no need put ffs data in ffs_fs_kill_sb, already put in ffs_data_closed.

The issue can be reproduced in Mediatek mt6763 SoC, ffs for ADB device.
KASAN enabled configuration reports use-after-free errro.

BUG: KASAN: use-after-free in refcount_dec_and_test+0x14/0xe0 at addr ffffffc0579386a0
Read of size 4 by task umount/4650
====================================================
BUG kmalloc-512 (Tainted: P        W  O   ): kasan: bad access detected
-----------------------------------------------------------------------------

INFO: Allocated in ffs_fs_mount+0x194/0x844 age=22856 cpu=2 pid=566
    alloc_debug_processing+0x1ac/0x1e8
    ___slab_alloc.constprop.63+0x640/0x648
    __slab_alloc.isra.57.constprop.62+0x24/0x34
    kmem_cache_alloc_trace+0x1a8/0x2bc
    ffs_fs_mount+0x194/0x844
    mount_fs+0x6c/0x1d0
    vfs_kern_mount+0x50/0x1b4
    do_mount+0x258/0x1034
INFO: Freed in ffs_data_put+0x25c/0x320 age=0 cpu=3 pid=4650
    free_debug_processing+0x22c/0x434
    __slab_free+0x2d8/0x3a0
    kfree+0x254/0x264
    ffs_data_put+0x25c/0x320
    ffs_data_closed+0x124/0x15c
    ffs_fs_kill_sb+0xb8/0x110
    deactivate_locked_super+0x6c/0x98
    deactivate_super+0xb0/0xbc
INFO: Object 0xffffffc057938600 @offset=1536 fp=0x          (null)
......
Call trace:
[<ffffff900808cf5c>] dump_backtrace+0x0/0x250
[<ffffff900808d3a0>] show_stack+0x14/0x1c
[<ffffff90084a8c04>] dump_stack+0xa0/0xc8
[<ffffff900826c2b4>] print_trailer+0x158/0x260
[<ffffff900826d9d8>] object_err+0x3c/0x40
[<ffffff90082745f0>] kasan_report_error+0x2a8/0x754
[<ffffff9008274f84>] kasan_report+0x5c/0x60
[<ffffff9008273208>] __asan_load4+0x70/0x88
[<ffffff90084cd81c>] refcount_dec_and_test+0x14/0xe0
[<ffffff9008d98f9c>] ffs_data_put+0x80/0x320
[<ffffff9008d9d904>] ffs_fs_kill_sb+0xc8/0x110
[<ffffff90082852a0>] deactivate_locked_super+0x6c/0x98
[<ffffff900828537c>] deactivate_super+0xb0/0xbc
[<ffffff90082af0c0>] cleanup_mnt+0x64/0xec
[<ffffff90082af1b0>] __cleanup_mnt+0x10/0x18
[<ffffff90080d9e68>] task_work_run+0xcc/0x124
[<ffffff900808c8c0>] do_notify_resume+0x60/0x70
[<ffffff90080866e4>] work_pending+0x10/0x14

Cc: stable@vger.kernel.org
Signed-off-by: Xinyong <xinyong.fang@linux.alibaba.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/function/f_fs.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1535,7 +1535,6 @@ ffs_fs_kill_sb(struct super_block *sb)
 	if (sb->s_fs_info) {
 		ffs_release_dev(sb->s_fs_info);
 		ffs_data_closed(sb->s_fs_info);
-		ffs_data_put(sb->s_fs_info);
 	}
 }
 
