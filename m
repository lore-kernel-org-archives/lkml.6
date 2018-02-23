Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3759000-1519415725-2-4532272780244622887
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519415724; b=Jk+uxM+UmgkYeCuyHr0EZTzIV6VFgSzLxXn9AyyjTk2nYjO
    T2L3szlBhKPrZVltvoD+Lx0kh39wh75vCHVrT6dx9fAfdBQr47jF6NaHi94PLNH+
    K1aGytvuGHUbruf1nkwvYeIrmZI8kPE3vGmVsiA5oii7e80tiydakvVqNsms+Bvq
    opfPzrLmDgBAU4KQeqQj1DX0qrerjN5XGQ2v8MBISCI7svioWNiIgI+WYSGSeUXq
    510PVi5gzRF/khrF4qv7MjEZep55alDEbZM0f8jiKMFwGntvGLemBUBRV99rln+C
    6Qxc74/L40MfSA3YWvbdOiPw4s+L5+NJTOWjPYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415724; bh=1y8hzm+viP/bSf7PhhVTBB8Ovq
    +XpnYF1WAnSAELv4c=; b=MW7BoPuIWQs758ptv5xdnvivhURvFhVdrNE7/0FTO3
    +pAM/iAgqYi9PTOLTW3B8UaTNYY/IICNlx6FTnVxJDTm1/YnTw1JvPUFqQFPZj+W
    QQ5HqyIskl26pMciLzwVX6YJ2eooz36CtU29TdrijtLOCpLdblYfXNtrqXLHRxLC
    Ru46RGnM3jAtYlZP7wQn0l7WHM+mcntRiPWlkz+/ZyMRyVuXRYm9/+24p1/5//EL
    QbNMAxr0tBmH1gPQOQcmdt0EW0z34e9fqtQtABnQJwzRFmiBr9ScayAnVxysgn7H
    DGatHGcA/WWEUCU6oDqp7D/yzoUMuMMXOHQdHEexl7Jg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933089AbeBWTzI (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:55:08 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43186 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933692AbeBWSpA (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:45:00 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zumeng Chen <zumeng.chen@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 064/145] gianfar: fix a flooded alignment reports because of padding issue.
Date: Fri, 23 Feb 2018 19:26:10 +0100
Message-Id: <20180223170732.993573270@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zumeng Chen <zumeng.chen@gmail.com>


[ Upstream commit 58117672943734715bbe7565ac9f062effa524f0 ]

According to LS1021A RM, the value of PAL can be set so that the start of the
IP header in the receive data buffer is aligned to a 32-bit boundary. Normally,
setting PAL = 2 provides minimal padding to ensure such alignment of the IP
header.

However every incoming packet's 8-byte time stamp will be inserted into the
packet data buffer as padding alignment bytes when hardware time stamping is
enabled.

So we set the padding 8+2 here to avoid the flooded alignment faults:

root@128:~# cat /proc/cpu/alignment
User:           0
System:         17539 (inet_gro_receive+0x114/0x2c0)
Skipped:        0
Half:           0
Word:           0
DWord:          0
Multi:          17539
User faults:    2 (fixup)

Also shown when exception report enablement

CPU: 0 PID: 161 Comm: irq/66-eth1_g0_ Not tainted 4.1.21-rt13-WR8.0.0.0_preempt-rt #16
Hardware name: Freescale LS1021A
[<8001b420>] (unwind_backtrace) from [<8001476c>] (show_stack+0x20/0x24)
[<8001476c>] (show_stack) from [<807cfb48>] (dump_stack+0x94/0xac)
[<807cfb48>] (dump_stack) from [<80025d70>] (do_alignment+0x720/0x958)
[<80025d70>] (do_alignment) from [<80009224>] (do_DataAbort+0x40/0xbc)
[<80009224>] (do_DataAbort) from [<80015398>] (__dabt_svc+0x38/0x60)
Exception stack(0x86ad1cc0 to 0x86ad1d08)
1cc0: f9b3e080 86b3d072 2d78d287 00000000 866816c0 86b3d05e 86e785d0 00000000
1ce0: 00000011 0000000e 80840ab0 86ad1d3c 86ad1d08 86ad1d08 806d7fc0 806d806c
1d00: 40070013 ffffffff
[<80015398>] (__dabt_svc) from [<806d806c>] (inet_gro_receive+0x114/0x2c0)
[<806d806c>] (inet_gro_receive) from [<80660eec>] (dev_gro_receive+0x21c/0x3c0)
[<80660eec>] (dev_gro_receive) from [<8066133c>] (napi_gro_receive+0x44/0x17c)
[<8066133c>] (napi_gro_receive) from [<804f0538>] (gfar_clean_rx_ring+0x39c/0x7d4)
[<804f0538>] (gfar_clean_rx_ring) from [<804f0bf4>] (gfar_poll_rx_sq+0x58/0xe0)
[<804f0bf4>] (gfar_poll_rx_sq) from [<80660b10>] (net_rx_action+0x27c/0x43c)
[<80660b10>] (net_rx_action) from [<80033638>] (do_current_softirqs+0x1e0/0x3dc)
[<80033638>] (do_current_softirqs) from [<800338c4>] (__local_bh_enable+0x90/0xa8)
[<800338c4>] (__local_bh_enable) from [<8008025c>] (irq_forced_thread_fn+0x70/0x84)
[<8008025c>] (irq_forced_thread_fn) from [<800805e8>] (irq_thread+0x16c/0x244)
[<800805e8>] (irq_thread) from [<8004e490>] (kthread+0xe8/0x104)
[<8004e490>] (kthread) from [<8000fda8>] (ret_from_fork+0x14/0x2c)

Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/gianfar.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -1375,9 +1375,11 @@ static int gfar_probe(struct platform_de
 
 	gfar_init_addr_hash_table(priv);
 
-	/* Insert receive time stamps into padding alignment bytes */
+	/* Insert receive time stamps into padding alignment bytes, and
+	 * plus 2 bytes padding to ensure the cpu alignment.
+	 */
 	if (priv->device_flags & FSL_GIANFAR_DEV_HAS_TIMER)
-		priv->padding = 8;
+		priv->padding = 8 + DEFAULT_PADDING;
 
 	if (dev->features & NETIF_F_IP_CSUM ||
 	    priv->device_flags & FSL_GIANFAR_DEV_HAS_TIMER)
