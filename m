Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3709765-1519676327-2-13791487443387403227
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
    t=1519676327; b=V9TGWQ59U+bnhzFG6AxGSjwdOOQNt1FIvixnCPzEpLJX9eA
    +flsbvk4rgfl+ZwYkLVoouzhSWXg/Z1lJyHTqpxYBeVnYtB0nzUjpZkbieCWZhAG
    S9GIWx7aHaeF2GQc8Vh3WHhmObq1/rZrhT1ee+CGWR+CZIUO3EN1j/R3qF2sU89w
    9mBLbQFzmtMN7otp78PxEYb2F4tp02+gEgI/K9zjlm4dwg24q25VaxELGV9j7LcW
    qClyytAdFKpCorfPy3pOWMm6/VL3SF6WOdG0W7T9G+EbiPXDprVwj5/yAIe2toR5
    u6hDEITQ/O29Ak8hHeoRqT6vAiZ0+kAmsNeAv7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519676327; bh=NcaO8VLiGVwwIYk7FGcYocAUMt
    XnINP0CjBcMwQwobM=; b=nTDY7jJtEaa8QfOY8G5YESiHbK4eipvSAIzyJ3BUD1
    /XgsPG3+CpBQt0c/W8pLGirGFkGzcl0P5IrqApP1Lp/O40tarUDl26Iu7M4VAmLa
    rw6xOxdO/aULuimfp0xFceteuwKVRGU1cbVrThHSWzKZie+utEOU8oXZMNo+MIXv
    rnoF5cHWbMTpTrahw+hkN/msDp2Y5g7EUP/mICPO/PJ560fm64pGBqFfAKBCl/h0
    Sjc8swt14a16PqiudxyQZsWNIt9Z+I6zrgEz+1e5W5d/l07ZITg/PCIiLv/HSfD+
    jkA/p+0L1MZ49yyQIg5jFTPuWXiJs93D2MN10Yg1t3zA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751022AbeBZURZ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 15:17:25 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:59868 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752179AbeBZURY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 15:17:24 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.4 05/22] ip_tunnel: fix preempt warning in ip tunnel creation/updating
Date: Mon, 26 Feb 2018 21:16:05 +0100
Message-Id: <20180226201558.975134267@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201558.681421374@linuxfoundation.org>
References: <20180226201558.681421374@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

commit f27337e16f2d0e52a8d05ea599ed13cd266ac291 upstream.

After the commit e09acddf873b ("ip_tunnel: replace dst_cache with generic
implementation"), a preemption debug warning is triggered on ip4
tunnels updating; the dst cache helper needs to be invoked in unpreemptible
context.

We don't need to load the cache on tunnel update, so this commit fixes
the warning replacing the load with a dst cache reset, which is
preempt safe.

Fixes: e09acddf873b ("ip_tunnel: replace dst_cache with generic implementation")
Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/ip_tunnel.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -327,12 +327,12 @@ static int ip_tunnel_bind_dev(struct net
 
 		if (!IS_ERR(rt)) {
 			tdev = rt->dst.dev;
-			dst_cache_set_ip4(&tunnel->dst_cache, &rt->dst,
-					  fl4.saddr);
 			ip_rt_put(rt);
 		}
 		if (dev->type != ARPHRD_ETHER)
 			dev->flags |= IFF_POINTOPOINT;
+
+		dst_cache_reset(&tunnel->dst_cache);
 	}
 
 	if (!tdev && tunnel->parms.link)
