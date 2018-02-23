Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3684173-1519413564-2-14773121584568749182
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
    t=1519413563; b=EyQOatmCh5FEXp5AwK1LSY3VAeDJTDaMANHy6Kdoi0J29kN
    uQ+c312g4G8gIcH99glJzjCJ9QWHydIgiJfeyilL5hWVUEFUoZFCZSutcWksUlKl
    aRdoOMZLJ0BR+QATp5TxGhjirpaYWE5/TVlmCB46xLvUdoqLA2881Ntm0itEgBkB
    Y6UdJYY14gcBFOL1jtWsPwytdtupeu7NdmK5tTPJb4jYSaIouvjmK6qcqjbNvbSX
    Ol+5uKUYXDsUGZuhZfVGnosnXjNmJ6kH4imQ9L+bc5hWA7uPU7gLgTaUcUm7b/gf
    bhqFoC1PmooeWvyxWL4YOMS+PohfWJY8jHL1hag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519413563; bh=+NiAy74gQJdNU4loPjwOYi6JXh
    7zTedFGrOi8+zOcbI=; b=Sh2U4QhEyyrodBA7CM7k+hY0Rcu3k/WMVxszxVM/if
    FYuh+90xljMZu7eiYHbW7N8OhsCLrf66c0eOv5M5rIaHyJr0TriCYnbd4XUGGVSM
    U9fptKGqnvqBAT/9qo460niNunohiVJTrWtWKXZgkgnaVKQVPYy20WrXvBj3O2fb
    jxCE44viksmOPdrK8SKCCvqeUnRLx4Ph0CDyQVzjevEHztoprmHE6Qo4aBCRa3NC
    LN36ffgGOdMh0bROZTLBD73l/HNEsL7NrleTZ84a4RQtoN/gV+e7UP4zxQQV/8eB
    l6gtNYjAs5gMpPk7Xd6Tm01JCNTW85p6OMVHm6PNTIRA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751707AbeBWTTT (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:19:19 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47768 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964956AbeBWSyX (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:54:23 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zumeng Chen <zumeng.chen@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 111/159] gianfar: fix a flooded alignment reports because of padding issue.
Date: Fri, 23 Feb 2018 19:26:59 +0100
Message-Id: <20180223170756.778421568@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
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
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/gianfar.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -1378,9 +1378,11 @@ static int gfar_probe(struct platform_de
 
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
