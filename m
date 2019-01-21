Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D92C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 060FE20879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079151;
	bh=DbV1FdZPsgUgbzLQGXOpzm6F2sawJjVIYsHSPk0Bdr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B1RML0R0SN+m7JGpeWGFpoMSVrwusqB7z/TXekrsYQCGXmpVN4pP6JVbRNOEIwo+E
	 6cFHZPREqHwF4FekpVkAdoWpKH3OjMQ3Q5zu5z9UeKg2vfP1EKy8g7XDQRtPWcdpNv
	 zUOqjybK8xSaRCFNr8cHv9nZEh9WBBfYGCe0Zqcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732139AbfAUN7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:59:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:45034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731803AbfAUN7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:59:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2775E20879;
        Mon, 21 Jan 2019 13:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079146;
        bh=DbV1FdZPsgUgbzLQGXOpzm6F2sawJjVIYsHSPk0Bdr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1+jLuPkHktKeAhvecmesZF7U4LG14zhb7iDcaUKtN7VGJOfbzfZVe3fs3h/tJQ8CJ
         ru0HX0odDOXoy3QdfT12FjcZn+Sdy+u421Gk09DAgL9RI9+drcToo4+nwuB3Rt+sUa
         NhzSdwrrMGZhlj53PjDgB5PUzsJz8uxpyBfw0p4U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
        Stanislav Fomichev <sdf@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 24/99] tun: publish tfile after its fully initialized
Date:   Mon, 21 Jan 2019 14:48:16 +0100
Message-Id: <20190121134914.823404472@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121134913.924726465@linuxfoundation.org>
References: <20190121134913.924726465@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stanislav Fomichev <sdf@google.com>

[ Upstream commit 0b7959b6257322f7693b08a459c505d4938646f2 ]

BUG: unable to handle kernel NULL pointer dereference at 00000000000000d1
Call Trace:
 ? napi_gro_frags+0xa7/0x2c0
 tun_get_user+0xb50/0xf20
 tun_chr_write_iter+0x53/0x70
 new_sync_write+0xff/0x160
 vfs_write+0x191/0x1e0
 __x64_sys_write+0x5e/0xd0
 do_syscall_64+0x47/0xf0
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

I think there is a subtle race between sending a packet via tap and
attaching it:

CPU0:                    CPU1:
tun_chr_ioctl(TUNSETIFF)
  tun_set_iff
    tun_attach
      rcu_assign_pointer(tfile->tun, tun);
                         tun_fops->write_iter()
                           tun_chr_write_iter
                             tun_napi_alloc_frags
                               napi_get_frags
                                 napi->skb = napi_alloc_skb
      tun_napi_init
        netif_napi_add
          napi->skb = NULL
                              napi->skb is NULL here
                              napi_gro_frags
                                napi_frags_skb
				  skb = napi->skb
				  skb_reset_mac_header(skb)
				  panic()

Move rcu_assign_pointer(tfile->tun) and rcu_assign_pointer(tun->tfiles) to
be the last thing we do in tun_attach(); this should guarantee that when we
call tun_get() we always get an initialized object.

v2 changes:
* remove extra napi_mutex locks/unlocks for napi operations

Reported-by: syzbot <syzkaller@googlegroups.com>
Fixes: 90e33d459407 ("tun: enable napi_gro_frags() for TUN/TAP driver")

Signed-off-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/tun.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -859,10 +859,6 @@ static int tun_attach(struct tun_struct
 		err = 0;
 	}
 
-	rcu_assign_pointer(tfile->tun, tun);
-	rcu_assign_pointer(tun->tfiles[tun->numqueues], tfile);
-	tun->numqueues++;
-
 	if (tfile->detached) {
 		tun_enable_queue(tfile);
 	} else {
@@ -876,6 +872,13 @@ static int tun_attach(struct tun_struct
 	 * refcnt.
 	 */
 
+	/* Publish tfile->tun and tun->tfiles only after we've fully
+	 * initialized tfile; otherwise we risk using half-initialized
+	 * object.
+	 */
+	rcu_assign_pointer(tfile->tun, tun);
+	rcu_assign_pointer(tun->tfiles[tun->numqueues], tfile);
+	tun->numqueues++;
 out:
 	return err;
 }


