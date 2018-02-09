Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1472218-1518185699-2-6255406424084970315
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518185698; b=d+ahb6StC0sCOSL6w47XoGMC1NLExF78rIGc8/ysc/hxgOJ
    i1SNFKny0DgaCBv67tILsMcot+l3TkrucsKVJERntVf74xeGaNFCCJGTW9raGVZh
    kNAJP5pT4gpvc/ZdyR2qyS0zzQp0nIjhJzO6mi5mZmzJHSfRtYNblpY1IhssMtxr
    uCy+UIfapvqKBpIn6s4yNJA8yjvD6bBwuMWJEfLNp5O3uhnrcCpW/30ImHG1aDpv
    GcMXnTi7KS+stnNJ97j21gc5/+UXr8fU6RGyBdJMuVUsUTVwUXIxjY0n+CWVGku6
    4hne+kgO5knTQh8RdtQC5XecZuGIeceI8+DVr0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518185698; bh=uPjpGBUiZJ9ULMZNVP9K+g2xMh
    iSyn5xlSTWzm1eu1g=; b=d2p0YizF2Fj8wMk7heEHQf7DDTesbhqPIebsKfaRxP
    1eKcsNRLzt2PgICEl+fSNa7pU+X5tU/x5Sn7fhRM6ZMD0uQ7cXbHAPsY/so0S7GE
    Mc2Ru/SG6WsanuBtgngSPZhHC/bFOrpWAVvIqtyXxsOZlKWhhLGlb20SvQAtSEH5
    qq1F3c2SinMUXhebGqQMjiFMOQxe7ebYRtSrba2FlC5crlfIzmoJltqWU3KsVHjI
    iz3/D7vqjdcVzgo+H+rnVrrnuNdZGX7h/W5jOzRM5PF+dT4GwK03HztmdBjx/SV7
    fJa7xGK4aLmdqdvg2zErCyH16GHNZA/XM6pwhMu9x8Nw==
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
        id S1752497AbeBIOOo (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 09:14:44 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48558 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752539AbeBINlU (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:41:20 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+eb17c6162478cc50632c@syzkaller.appspotmail.com,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 25/92] vhost_net: stop device during reset owner
Date: Fri,  9 Feb 2018 14:38:54 +0100
Message-Id: <20180209133933.053777448@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Wang <jasowang@redhat.com>


[ Upstream commit 4cd879515d686849eec5f718aeac62a70b067d82 ]

We don't stop device before reset owner, this means we could try to
serve any virtqueue kick before reset dev->worker. This will result a
warn since the work was pending at llist during owner resetting. Fix
this by stopping device during owner reset.

Reported-by: syzbot+eb17c6162478cc50632c@syzkaller.appspotmail.com
Fixes: 3a4d5c94e9593 ("vhost_net: a kernel-level virtio server")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vhost/net.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1078,6 +1078,7 @@ static long vhost_net_reset_owner(struct
 	}
 	vhost_net_stop(n, &tx_sock, &rx_sock);
 	vhost_net_flush(n);
+	vhost_dev_stop(&n->dev);
 	vhost_dev_reset_owner(&n->dev, umem);
 	vhost_net_vq_reset(n);
 done:
