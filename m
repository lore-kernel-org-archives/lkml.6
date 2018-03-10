Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1715849-1520641161-2-4820404866577156994
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
    t=1520641160; b=UM2yJpLfpsj541Qmj3gND81t6U6OJr/Q7xbPXrX0jJhHZDq
    TV32JN1Ww2hw2buvG5ykQzzwhWIJOhhF35Do86pWOHkSWPo1fiTAAOGxRnQ4EA65
    PK46std++wfRZNvRBRTSYcuwqqJGiJ0mQ0lwQDhM37nb3ns00vqzG5YxZKE7CMWI
    cRXWgKvbWT2hHdz05bu/1XpQTKbOTWuaypqm7av251wz+vZNmKGa6vybBDNZtbI0
    NWOTBGkY1Sv6qNrn17zl8bJEZD88tWgN9p6+odc9rBWz0qnuybQbeMwqSCkG0OY/
    ifnLW5NoRh6RQs+GJco3FAs1XZRWOjKZ2fFgHpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520641160; bh=utwtOJmo4blI7nGKrVRrAu20WW
    LBPsMp76IEUwyiXRU=; b=rSpFkOmOlGA9rBh0kdhMROS3dUSAoKplgIYTGBVsqH
    mGscgCm1qUeo9WQ7ldkMUVVt6Vd6OD9XL3P1VqCSKoT1RNXORMIzxkZ98ipdiabR
    tuo07DrYWqXCH7h3OMtJtclPcLzNUCrxj3YpA+QTnLzSG7c08t2n9xCRDo9cfmLH
    mCtiQPmEi5D11G+G+rePinL3fHg6bzzGkF6ibbADoG84EUoGB08X07toRfXXAqYw
    FOlII41y1dSOgd7772JXUq//o3fAJESTNYx1hbxZI9VUC97ArCBihANhN/XAvchK
    Z+hizft4lzo4u+7oEDAO/xR6EuaHfSm8sr/Y9/TbE6QA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
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
        id S932960AbeCJATQ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 19:19:16 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38566 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932771AbeCJATO (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Mar 2018 19:19:14 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guillaume Nault <g.nault@alphalink.fr>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 13/21] ppp: prevent unregistered channels from connecting to PPP units
Date: Fri,  9 Mar 2018 16:18:35 -0800
Message-Id: <20180310001801.864075868@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001801.045114869@linuxfoundation.org>
References: <20180310001801.045114869@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guillaume Nault <g.nault@alphalink.fr>


[ Upstream commit 77f840e3e5f09c6d7d727e85e6e08276dd813d11 ]

PPP units don't hold any reference on the channels connected to it.
It is the channel's responsibility to ensure that it disconnects from
its unit before being destroyed.
In practice, this is ensured by ppp_unregister_channel() disconnecting
the channel from the unit before dropping a reference on the channel.

However, it is possible for an unregistered channel to connect to a PPP
unit: register a channel with ppp_register_net_channel(), attach a
/dev/ppp file to it with ioctl(PPPIOCATTCHAN), unregister the channel
with ppp_unregister_channel() and finally connect the /dev/ppp file to
a PPP unit with ioctl(PPPIOCCONNECT).

Once in this situation, the channel is only held by the /dev/ppp file,
which can be released at anytime and free the channel without letting
the parent PPP unit know. Then the ppp structure ends up with dangling
pointers in its ->channels list.

Prevent this scenario by forbidding unregistered channels from
connecting to PPP units. This maintains the code logic by keeping
ppp_unregister_channel() responsible from disconnecting the channel if
necessary and avoids modification on the reference counting mechanism.

This issue seems to predate git history (successfully reproduced on
Linux 2.6.26 and earlier PPP commits are unrelated).

Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ppp/ppp_generic.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -2908,6 +2908,15 @@ ppp_connect_channel(struct channel *pch,
 		goto outl;
 
 	ppp_lock(ppp);
+	spin_lock_bh(&pch->downl);
+	if (!pch->chan) {
+		/* Don't connect unregistered channels */
+		spin_unlock_bh(&pch->downl);
+		ppp_unlock(ppp);
+		ret = -ENOTCONN;
+		goto outl;
+	}
+	spin_unlock_bh(&pch->downl);
 	if (pch->file.hdrlen > ppp->file.hdrlen)
 		ppp->file.hdrlen = pch->file.hdrlen;
 	hdrlen = pch->file.hdrlen + 2;	/* for protocol bytes */
