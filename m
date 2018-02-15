Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2243538-1518720556-2-10453909194322395760
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
    t=1518720556; b=Fg0EU9Vgf5ED82ko5NKhbgXrFjhyLRURPRGaJy6XWDEj9Xv
    QEHsWW5uvWtGDpOSQd36zCw4dokCpiWcgBapSL31NFVPKX96Um0zlFqjLOhH2PIo
    bN0WgxwKFY1uAxSNY78CZNx2LEx03ZGIBLInQgv15nkoeyyjwSawwjHCUyI371pM
    4stVgP74JTEci9GqJVlqvepk7hYDuXBBJ/w/xxOA0blfZPpz8pCawmaGB+c/iXm8
    KPCrEde74PV7v5J18Xk9/dGMC8NDQZ6RgJy0bLGDQhp1jKvVJD6neXDa4gicaXzD
    pFytdoYf2+/W+SH+3ra1yBqC37IY1Hj4OGtA38A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720556; bh=YvQ+Y/rMtQFhV4+RpwjbmeHo/i
    kF4seTfabZXf8pDss=; b=d5sxCNE1thvahma6SfreQVBirf4hefWsUWAK050QQ9
    GDWHzrhbiG08ay9qiseaNSppVOtjx+iba+pxpFcdZEjrApY1z1Hj1lMqE5mWeInW
    sFofgCvSXqsZaJpaoj71Vbn+dXoeDcr5CD36TnyUOxiXNLb/eYNMFlYIHCbIi5yl
    TZxaNhVAArt/U68ov/BVTxDb5ZFuw2I0MZYx0c56jCTHRQKIp2Al1sTkuFBZ7XGf
    pw5Cp0Gm4rQhWly94G+DN00XC8+ZVXyx5th3pOcpDKwQ8HnaHSWzqdjX7OauA1lu
    pHZ//964rbUxP2hN7WCHAa64wJqko3yTNl1JnoL/WEGg==
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
        id S1162194AbeBOPVw (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:21:52 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49252 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162138AbeBOPVu (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:21:50 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+eb17c6162478cc50632c@syzkaller.appspotmail.com,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 032/108] vhost_net: stop device during reset owner
Date: Thu, 15 Feb 2018 16:16:29 +0100
Message-Id: <20180215151226.915629314@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -981,6 +981,7 @@ static long vhost_net_reset_owner(struct
 	}
 	vhost_net_stop(n, &tx_sock, &rx_sock);
 	vhost_net_flush(n);
+	vhost_dev_stop(&n->dev);
 	vhost_dev_reset_owner(&n->dev, memory);
 	vhost_net_vq_reset(n);
 done:
