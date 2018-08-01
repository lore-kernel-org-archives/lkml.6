Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A625C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9BA20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9BA20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436536AbeHAT0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:26:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52920 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436512AbeHATSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:18:37 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C6CF3E53;
        Wed,  1 Aug 2018 16:54:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Scott Mayhew <smayhew@redhat.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 027/336] nfsd: fix potential use-after-free in nfsd4_decode_getdeviceinfo
Date:   Wed,  1 Aug 2018 18:46:02 +0200
Message-Id: <20180801165030.095099460@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Scott Mayhew <smayhew@redhat.com>

[ Upstream commit 3171822fdcdd6e6d536047c425af6dc7a92dc585 ]

When running a fuzz tester against a KASAN-enabled kernel, the following
splat periodically occurs.

The problem occurs when the test sends a GETDEVICEINFO request with a
malformed xdr array (size but no data) for gdia_notify_types and the
array size is > 0x3fffffff, which results in an overflow in the value of
nbytes which is passed to read_buf().

If the array size is 0x40000000, 0x80000000, or 0xc0000000, then after
the overflow occurs, the value of nbytes 0, and when that happens the
pointer returned by read_buf() points to the end of the xdr data (i.e.
argp->end) when really it should be returning NULL.

Fix this by returning NFS4ERR_BAD_XDR if the array size is > 1000 (this
value is arbitrary, but it's the same threshold used by
nfsd4_decode_bitmap()... in could really be any value >= 1 since it's
expected to get at most a single bitmap in gdia_notify_types).

[  119.256854] ==================================================================
[  119.257611] BUG: KASAN: use-after-free in nfsd4_decode_getdeviceinfo+0x5a4/0x5b0 [nfsd]
[  119.258422] Read of size 4 at addr ffff880113ada000 by task nfsd/538

[  119.259146] CPU: 0 PID: 538 Comm: nfsd Not tainted 4.17.0+ #1
[  119.259662] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.9.3-1.fc25 04/01/2014
[  119.261202] Call Trace:
[  119.262265]  dump_stack+0x71/0xab
[  119.263371]  print_address_description+0x6a/0x270
[  119.264609]  kasan_report+0x258/0x380
[  119.265854]  ? nfsd4_decode_getdeviceinfo+0x5a4/0x5b0 [nfsd]
[  119.267291]  nfsd4_decode_getdeviceinfo+0x5a4/0x5b0 [nfsd]
[  119.268549]  ? nfs4svc_decode_compoundargs+0xa5b/0x13c0 [nfsd]
[  119.269873]  ? nfsd4_decode_sequence+0x490/0x490 [nfsd]
[  119.271095]  nfs4svc_decode_compoundargs+0xa5b/0x13c0 [nfsd]
[  119.272393]  ? nfsd4_release_compoundargs+0x1b0/0x1b0 [nfsd]
[  119.273658]  nfsd_dispatch+0x183/0x850 [nfsd]
[  119.274918]  svc_process+0x161c/0x31a0 [sunrpc]
[  119.276172]  ? svc_printk+0x190/0x190 [sunrpc]
[  119.277386]  ? svc_xprt_release+0x451/0x680 [sunrpc]
[  119.278622]  nfsd+0x2b9/0x430 [nfsd]
[  119.279771]  ? nfsd_destroy+0x1c0/0x1c0 [nfsd]
[  119.281157]  kthread+0x2db/0x390
[  119.282347]  ? kthread_create_worker_on_cpu+0xc0/0xc0
[  119.283756]  ret_from_fork+0x35/0x40

[  119.286041] Allocated by task 436:
[  119.287525]  kasan_kmalloc+0xa0/0xd0
[  119.288685]  kmem_cache_alloc+0xe9/0x1f0
[  119.289900]  get_empty_filp+0x7b/0x410
[  119.291037]  path_openat+0xca/0x4220
[  119.292242]  do_filp_open+0x182/0x280
[  119.293411]  do_sys_open+0x216/0x360
[  119.294555]  do_syscall_64+0xa0/0x2f0
[  119.295721]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

[  119.298068] Freed by task 436:
[  119.299271]  __kasan_slab_free+0x130/0x180
[  119.300557]  kmem_cache_free+0x78/0x210
[  119.301823]  rcu_process_callbacks+0x35b/0xbd0
[  119.303162]  __do_softirq+0x192/0x5ea

[  119.305443] The buggy address belongs to the object at ffff880113ada000
                which belongs to the cache filp of size 256
[  119.308556] The buggy address is located 0 bytes inside of
                256-byte region [ffff880113ada000, ffff880113ada100)
[  119.311376] The buggy address belongs to the page:
[  119.312728] page:ffffea00044eb680 count:1 mapcount:0 mapping:0000000000000000 index:0xffff880113ada780
[  119.314428] flags: 0x17ffe000000100(slab)
[  119.315740] raw: 0017ffe000000100 0000000000000000 ffff880113ada780 00000001000c0001
[  119.317379] raw: ffffea0004553c60 ffffea00045c11e0 ffff88011b167e00 0000000000000000
[  119.319050] page dumped because: kasan: bad access detected

[  119.321652] Memory state around the buggy address:
[  119.322993]  ffff880113ad9f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  119.324515]  ffff880113ad9f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  119.326087] >ffff880113ada000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  119.327547]                    ^
[  119.328730]  ffff880113ada080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  119.330218]  ffff880113ada100: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
[  119.331740] ==================================================================

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4xdr.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1585,6 +1585,8 @@ nfsd4_decode_getdeviceinfo(struct nfsd4_
 	gdev->gd_maxcount = be32_to_cpup(p++);
 	num = be32_to_cpup(p++);
 	if (num) {
+		if (num > 1000)
+			goto xdr_error;
 		READ_BUF(4 * num);
 		gdev->gd_notify_types = be32_to_cpup(p++);
 		for (i = 1; i < num; i++) {


