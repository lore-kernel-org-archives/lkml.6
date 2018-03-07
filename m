Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4098462-1520452902-2-15198346691503882265
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
    t=1520452902; b=bNazBqqoMMnbX4sXmYdQnHo3WzB0Z5UcLuVKSsB0okX3Klo
    9IGTMlbotOmUJnRxwSeSee1Sg1atZE1fCvs36ZaIlRUZAtMxgQF87rYqnLtMVNdC
    eX79rKPrCdD1ir8VKnIhjnoTHpizlUzKcjeLDh4X2wzF1vbAh1Ljgp1bvCptw8UM
    WM3/FA7xtq0nEgpUaI5nEJAus5dmP7GQewSN9QHl3yZ75mx1Is2vzZRSM2lMwy3h
    P1mmqaPnEK6wBMZBgisPLV3ubnv3Xctn6LtE96eZmdt80ikr1G+NnQs91cEGEt6V
    bqx7X14wINukQH3GCqwKc/JwRYEA/6+3KhkV7Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520452902; bh=D0gKV+vw4JBvpcSdvLkQlqb7zs
    8dLId/5eD7RgRxHds=; b=J+jqCu2sWWHAfQqVgq0HbnOOPNNb/JOUDykR587ECm
    dEZwzMMB0OdtRqJQQ0wAnuvpDtG6SMM2qi8hEvKgbjLiZhM+6r1UetOCK06jlmbW
    Fz4o2SOrvkGtAo9oBoHrbHRvGXFFVq5ihSaLUTe3N1E/P6HjPJc2Tb9GpaNPnEUv
    YFp+9Gx5QgtlVbevHkQQJYtiUAY93NNMkTXJdLTu6xi2FB5L6T3YDtZNwbMCbvIc
    CqVvK7QwCRoLntHdVb3SkxZ5dRF3kLdsrbjvJVPrQGGnApyHZ6qolnKhu4nrxlqE
    ojIjvZ+nMOtpRO1judWYPdv4QgIYw/blEqXGbeJEQyhQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
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
        id S934938AbeCGUBi (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 15:01:38 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44818 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965061AbeCGTqz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:46:55 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 073/110] tuntap: disable preemption during XDP processing
Date: Wed,  7 Mar 2018 11:38:56 -0800
Message-Id: <20180307191049.011708276@linuxfoundation.org>
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


[ Upstream commit 23e43f07f896f8578318cfcc9466f1e8b8ab21b6 ]

Except for tuntap, all other drivers' XDP was implemented at NAPI
poll() routine in a bh. This guarantees all XDP operation were done at
the same CPU which is required by e.g BFP_MAP_TYPE_PERCPU_ARRAY. But
for tuntap, we do it in process context and we try to protect XDP
processing by RCU reader lock. This is insufficient since
CONFIG_PREEMPT_RCU can preempt the RCU reader critical section which
breaks the assumption that all XDP were processed in the same CPU.

Fixing this by simply disabling preemption during XDP processing.

Fixes: 761876c857cb ("tap: XDP support")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/tun.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1315,6 +1315,7 @@ static struct sk_buff *tun_build_skb(str
 	else
 		*skb_xdp = 0;
 
+	preempt_disable();
 	rcu_read_lock();
 	xdp_prog = rcu_dereference(tun->xdp_prog);
 	if (xdp_prog && !*skb_xdp) {
@@ -1337,6 +1338,7 @@ static struct sk_buff *tun_build_skb(str
 			if (err)
 				goto err_redirect;
 			rcu_read_unlock();
+			preempt_enable();
 			return NULL;
 		case XDP_TX:
 			xdp_xmit = true;
@@ -1358,6 +1360,7 @@ static struct sk_buff *tun_build_skb(str
 	skb = build_skb(buf, buflen);
 	if (!skb) {
 		rcu_read_unlock();
+		preempt_enable();
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -1370,10 +1373,12 @@ static struct sk_buff *tun_build_skb(str
 		skb->dev = tun->dev;
 		generic_xdp_tx(skb, xdp_prog);
 		rcu_read_unlock();
+		preempt_enable();
 		return NULL;
 	}
 
 	rcu_read_unlock();
+	preempt_enable();
 
 	return skb;
 
@@ -1381,6 +1386,7 @@ err_redirect:
 	put_page(alloc_frag->page);
 err_xdp:
 	rcu_read_unlock();
+	preempt_enable();
 	this_cpu_inc(tun->pcpu_stats->rx_dropped);
 	return NULL;
 }
