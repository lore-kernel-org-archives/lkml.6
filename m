Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4098462-1520452901-2-9928079541736509660
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
    t=1520452900; b=dC5JVW50pD/ODSI0RqAXy+4w33axWt7OlGI3XsG4ozQDABH
    LwV8YWZ3xqGGjYwDvIq2o7VPXWGfO2kxH0ylurQR8HxEX1v+8PQLZ2vifdh/zPYT
    QPKdg+LBZxcTyuSkZID6g4DGcBr1cep55yifHJuApM49GVn1W887AuuqFurj2D5E
    8tLcjqf1/FGpCgoykvRY1dVG4xF9TwoxYwciVS/lZBhkASvTha7uUQ4c9kp+9tVR
    lyJI+vMcFwOVlYddr9t+K1hKm8gUrHLCBQzfgWR2tJ7ISEL2JvTQUcfy5oXq6GO0
    AceKNIvWeGhRjmmk4dn2ovCflIVNEhk211vtpuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520452900; bh=8Prlxsy4E5jwRGAWWrTHKGWudC
    JPNELiy4zMfYoLv28=; b=UBQLUcv1aaWoj3/2V79Opc0gTDoSp3Q1yF5s4Phd9F
    GZCx2hYOyoTud+Df7KoVDsLEoXulb1N//rKFfYUG4r49UE4i868vJkVugAJcDna/
    pBml/zHIvwnMiU6mRFmLQn3lZPGDrq4wlAla0WU6sLEntmTEuM515LWaFjiDLGec
    ElpK3oZXhzB8p0lqQEv0px470Ompa8v4PyVVDl0j4Te3MUBhtyVHJ3FqJBofaubg
    DJV917UQwBNWekBuY3QvhwIkacFHipVGTvARQ7+X1rpD9vcg+0SRgTzbGJGfixGX
    1BgpNOjGMV645sjCYxOzjx4F79iaWkQFpgyTnpJ9nY4w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
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
        id S965073AbeCGTqz (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:46:55 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44804 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754916AbeCGTqw (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:46:52 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 072/110] tuntap: correctly add the missing XDP flush
Date: Wed,  7 Mar 2018 11:38:55 -0800
Message-Id: <20180307191048.875055335@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
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

From: Jason Wang <jasowang@redhat.com>


[ Upstream commit 1bb4f2e868a2891ab8bc668b8173d6ccb8c4ce6f ]

We don't flush batched XDP packets through xdp_do_flush_map(), this
will cause packets stall at TX queue. Consider we don't do XDP on NAPI
poll(), the only possible fix is to call xdp_do_flush_map()
immediately after xdp_do_redirect().

Note, this in fact won't try to batch packets through devmap, we could
address in the future.

Reported-by: Christoffer Dall <christoffer.dall@linaro.org>
Fixes: 761876c857cb ("tap: XDP support")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/tun.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1333,6 +1333,7 @@ static struct sk_buff *tun_build_skb(str
 			get_page(alloc_frag->page);
 			alloc_frag->offset += buflen;
 			err = xdp_do_redirect(tun->dev, &xdp, xdp_prog);
+			xdp_do_flush_map();
 			if (err)
 				goto err_redirect;
 			rcu_read_unlock();
