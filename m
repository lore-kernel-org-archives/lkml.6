Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C95C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C455A20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548080505;
	bh=4l8lSzOQUs8AGf1MqdrguP0uIn6S2FIzRNolASE2D2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FPuK89jukaDncjyMciocOYp8JWYqLvD1nNV0+JIKB+m3PZkUEXNmeJ2RHpU6+PQYC
	 AwpLkjsPptrCwC6suwdOvAPLvX+uLAM8i7S2ESbID1cdL3IB6PzWZw8uBPuonP6R68
	 36ppgXSPEZVKewJqGlJeh8Ve7K1F0QW+HiHeKl0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbfAUNqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:46:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:55740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729290AbfAUNqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:46:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D959C20879;
        Mon, 21 Jan 2019 13:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078406;
        bh=4l8lSzOQUs8AGf1MqdrguP0uIn6S2FIzRNolASE2D2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vd7+wdxCF6Xk3f+Rv+6qzsTWlm29sIHhDmEWGEP0j6vKWUAZR/S4L+LGRf2UWInjI
         aZdX9NMcK4Af/Ncod3vfIBzSM2/vG0SBucSTRkkOxRhtBNczBe2aBUy3I3tAoVYAde
         t/bFR0OUI9pRBXe672RwNBelqTJo8qD3H2gN1A/Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
        Stanislav Fomichev <sdf@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 021/111] tun: publish tfile after its fully initialized
Date:   Mon, 21 Jan 2019 14:42:15 +0100
Message-Id: <20190121122458.098510207@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
@@ -852,10 +852,6 @@ static int tun_attach(struct tun_struct
 		err = 0;
 	}
 
-	rcu_assign_pointer(tfile->tun, tun);
-	rcu_assign_pointer(tun->tfiles[tun->numqueues], tfile);
-	tun->numqueues++;
-
 	if (tfile->detached) {
 		tun_enable_queue(tfile);
 	} else {
@@ -872,6 +868,13 @@ static int tun_attach(struct tun_struct
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


