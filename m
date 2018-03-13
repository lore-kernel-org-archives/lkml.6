Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3463848-1520955442-2-284453851060261007
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
    t=1520955441; b=AFa2E+XyH1Pzyo0MjTSnu+sys8691YtqXbH7i3Rr0AIURW6
    bWdEF+TvZvlPAwNT71NHyfktb+//1/5ChwOonOnfgQWKAY2SkGvssrBzvVZ9Rey3
    xAhDbFqI/4MmtB9avGu05gFVIv/NXmmNez/tvqPQ17ETAWzEGSMBOra1cxQi0D5z
    pkP27Hb6rVt9rISaTfz33SyTQ0P1rcXP2f/NCVjDW/6RrQoPQ+QIca43Osvdt0nO
    /GeXrUnSAS0uJBb2D5LatdDg/mvOoFAU7xTiw4m5RsyS8QCrdPyQMUnA0aE2qm29
    ik5chsPHlErdyhUHKg+Vbl6oOXJLuAtmzZNSNuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520955441; bh=9RmDutlfQw+NeWwep9YZ2KPnPk
    eeRtHYJiIG2suXQGI=; b=ttk/ly2H0u2lo9sEZFmht8T8XnLFBlutNdL7v220aq
    qloZ7bhXK1RNRRR9+eNxnlMA5bjs3w2ZXJDaTCwcAcnrXv5zUXpiM/xLUBfx/nUf
    2Sn/hjP1I7sYDQAsP5o/IZdaFtRrbSnTV3RXy5FqAL5MEvj9UGgYZGVfZxI8kWGv
    JKq9KFYKV6xgFDr3bWaqWq4IKXqpHtg13dwQG3ouEIAcVFnnrWIu3T5tH+VRXoeU
    IjwFm2+uRv6Ts6/gyYDhbqBSLCMjSD2Omjam19TZTPvegjmHbID8NGu3+2OkMEuu
    Pcx8Bdvsuj983i5UwaTXaJhyWztJXrBBrz8J2zyDlq9g==
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
        id S934014AbeCMPhP (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 11:37:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33850 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934343AbeCMPhN (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 11:37:13 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzkaller <syzkaller@googlegroups.com>,
        Noa Osherovich <noaos@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.14 048/140] RDMA/mlx5: Fix integer overflow while resizing CQ
Date: Tue, 13 Mar 2018 16:24:11 +0100
Message-Id: <20180313152501.544233979@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@mellanox.com>

commit 28e9091e3119933c38933cb8fc48d5618eb784c8 upstream.

The user can provide very large cqe_size which will cause to integer
overflow as it can be seen in the following UBSAN warning:

=======================================================================
UBSAN: Undefined behaviour in drivers/infiniband/hw/mlx5/cq.c:1192:53
signed integer overflow:
64870 * 65536 cannot be represented in type 'int'
CPU: 0 PID: 267 Comm: syzkaller605279 Not tainted 4.15.0+ #90 Hardware
name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.7.5-0-ge51488c-20140602_164612-nilsson.home.kraxel.org 04/01/2014
Call Trace:
 dump_stack+0xde/0x164
 ? dma_virt_map_sg+0x22c/0x22c
 ubsan_epilogue+0xe/0x81
 handle_overflow+0x1f3/0x251
 ? __ubsan_handle_negate_overflow+0x19b/0x19b
 ? lock_acquire+0x440/0x440
 mlx5_ib_resize_cq+0x17e7/0x1e40
 ? cyc2ns_read_end+0x10/0x10
 ? native_read_msr_safe+0x6c/0x9b
 ? cyc2ns_read_end+0x10/0x10
 ? mlx5_ib_modify_cq+0x220/0x220
 ? sched_clock_cpu+0x18/0x200
 ? lookup_get_idr_uobject+0x200/0x200
 ? rdma_lookup_get_uobject+0x145/0x2f0
 ib_uverbs_resize_cq+0x207/0x3e0
 ? ib_uverbs_ex_create_cq+0x250/0x250
 ib_uverbs_write+0x7f9/0xef0
 ? cyc2ns_read_end+0x10/0x10
 ? print_irqtrace_events+0x280/0x280
 ? ib_uverbs_ex_create_cq+0x250/0x250
 ? uverbs_devnode+0x110/0x110
 ? sched_clock_cpu+0x18/0x200
 ? do_raw_spin_trylock+0x100/0x100
 ? __lru_cache_add+0x16e/0x290
 __vfs_write+0x10d/0x700
 ? uverbs_devnode+0x110/0x110
 ? kernel_read+0x170/0x170
 ? sched_clock_cpu+0x18/0x200
 ? security_file_permission+0x93/0x260
 vfs_write+0x1b0/0x550
 SyS_write+0xc7/0x1a0
 ? SyS_read+0x1a0/0x1a0
 ? trace_hardirqs_on_thunk+0x1a/0x1c
 entry_SYSCALL_64_fastpath+0x1e/0x8b
RIP: 0033:0x433549
RSP: 002b:00007ffe63bd1ea8 EFLAGS: 00000217
=======================================================================

Cc: syzkaller <syzkaller@googlegroups.com>
Cc: <stable@vger.kernel.org> # 3.13
Fixes: bde51583f49b ("IB/mlx5: Add support for resize CQ")
Reported-by: Noa Osherovich <noaos@mellanox.com>
Reviewed-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/mlx5/cq.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -1154,7 +1154,12 @@ static int resize_user(struct mlx5_ib_de
 	if (ucmd.reserved0 || ucmd.reserved1)
 		return -EINVAL;
 
-	umem = ib_umem_get(context, ucmd.buf_addr, entries * ucmd.cqe_size,
+	/* check multiplication overflow */
+	if (ucmd.cqe_size && SIZE_MAX / ucmd.cqe_size <= entries - 1)
+		return -EINVAL;
+
+	umem = ib_umem_get(context, ucmd.buf_addr,
+			   (size_t)ucmd.cqe_size * entries,
 			   IB_ACCESS_LOCAL_WRITE, 1);
 	if (IS_ERR(umem)) {
 		err = PTR_ERR(umem);
