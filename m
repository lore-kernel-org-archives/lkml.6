Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu69J/7WVKyDisr5KRw90Xy1722WjQU1NZ6HYZAKtnKUs1++jt6koJP0Fg+JaCuNXSUH08k
ARC-Seal: i=1; a=rsa-sha256; t=1521214426; cv=none;
        d=google.com; s=arc-20160816;
        b=0/nuByeeYw13se+y4bgNosowzo2zp8LSgFUQYozYmKN7PcGo/fvFJe5dpVwDh0+d74
         S/HmRRCJAniFuqUllOuvAMyNE5d9j5uukAExPmNvKrDtVcdRs1la11Lbn+1RKpew77cb
         dZkJ1Mp4Q3aZ/CN0hWXhg3it2h0nDPz+UXpekkdHLJx1h25mWe5VjYk5rFcu60C1D7gI
         /yliVB++lxUd0H8SSeBa54mvUzYQlPe7fXvcneD12Ra7MAppLuuvOa+TBcksVXhtJetX
         b+XL43vc0BPoLsle3tmpm6ywQ7nzVLUwYuFADeSPedAm0/FKB6wMxribpGg5Xrm8MMTQ
         c3sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4GRmDckP6/zb48EluRs0/aJiz1zxHlEl+NjRVtt6gTM=;
        b=Q561z0qvjTi0ZgSUokuaMxIpNZcWI6AoePkBWSFh73hcM/srCNqezPCEdAmT3pP0kQ
         aM0v7Cc3Ewavqp2PZgJNQ0lIrBf4YLWwX1djaiGLGJmMGAMpVJUi4UAXpx9/9ZarVQlZ
         y3caNvGpbg9x/y5k8BuDg3YySSMEOnDqy8CorQOlyR/5feqLrRCIVNDTit9nOWQLrYax
         KbLU2BFN7jdEaI6XscIF3S2HuY3Qml8ZIoojf2a5wxHyp0zAZSPKnkdJhBw3q47wcO3U
         9pWDY+VT7WF16Tt1jS2de4tPodNZumHs79SuLpapOG8btes4yYlZEQRTEhlgK/cm3hyU
         mGaQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Xinyong <xinyong.fang@linux.alibaba.com>,
	Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.9 82/86] usb: gadget: f_fs: Fix use-after-free in ffs_fs_kill_sb()
Date: Fri, 16 Mar 2018 16:23:45 +0100
Message-Id: <20180316152322.874597805@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108658952453515?=
X-GMAIL-MSGID: =?utf-8?q?1595108938016710550?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1522,7 +1522,6 @@ ffs_fs_kill_sb(struct super_block *sb)
 	if (sb->s_fs_info) {
 		ffs_release_dev(sb->s_fs_info);
 		ffs_data_closed(sb->s_fs_info);
-		ffs_data_put(sb->s_fs_info);
 	}
 }
 
