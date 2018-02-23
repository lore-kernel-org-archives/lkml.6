Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3704313-1519413751-5-4426785396333787040
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
    t=1519413751; b=qDxvJLx/vm9Or9fQTiIUP68ovqYK6SxU12m1mCM8qn11zRt
    qfYLnxur6czaJANj/DQTYv2othgbytLZe8X5wPpVH2JmzZ/m24exHjL6xURpnF+D
    E4rNIkskVEOUpoU8B36dBddbWdjyKuzO/dWOv75n35sD6YVizD0nv9CTwCS5o+fS
    Ty7IVEmgmaOo/6GWSNCk0qMOw9YANI8l1z/vISEZd9MPG0kzhp+u3nXtStB9SbIE
    MBPaKZTcc5vnnhuY79bL3n6Y0V9ri1/ZgEL7KVPORUnKZTb1hnoHv8smPBsrQPOf
    UltjFAycurR8EH65J/re5gHJgrh8iLC05mPx9OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519413751; bh=jxXe3phS+Mcy2m1z5K5p2ItSWG
    SPVxaTS61IBbci7Ok=; b=GjvKPnqGlNhFGTmAeXnYF3QfF6hSXXmyOPVneeu5Zd
    vwlylJ6zfVUWnlkWrvVOir4nog56tRcIyr3t86j8xCQ+tnEQ6yoUUvR4voN0p1wp
    197vUnSYas2FrvBk2qYMwOJexkyzsq6xC8d0uMB7GRdIChB3WBHF4gylYFdTjgn0
    CXgR0YF5UcGTxjISyKrXnPm4tviMZ1DJtOhnddRVnyZawBMSqcvy6iycMEVirH09
    ANIEh8q8ynkb/9QudyCsy2Ieg1xo8+XOjJAPYZtfdFbrsafP2Lga3WDjoGdxQXQn
    EcXFDJp+3o4CVtVkXAygaf9zpsFdUljANjLb+hfYNzmA==
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
        id S934942AbeBWSxn (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:53:43 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47450 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964785AbeBWSxl (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:53:41 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 097/159] phylink: ensure we take the link down when phylink_stop() is called
Date: Fri, 23 Feb 2018 19:26:45 +0100
Message-Id: <20180223170755.230232109@linuxfoundation.org>
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

From: Russell King <rmk+kernel@armlinux.org.uk>


[ Upstream commit 2012b7d6b2868c532f22d9172c8b24611637eb48 ]

Ensure that we tell the MAC to take the link down when phylink_stop()
is called, and that this completes prior to phylink_stop() returns.

Reported-by: Florian Fainelli <f.fainelli@gmail.com>
Tested-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/phylink.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -772,6 +772,7 @@ void phylink_stop(struct phylink *pl)
 		sfp_upstream_stop(pl->sfp_bus);
 
 	set_bit(PHYLINK_DISABLE_STOPPED, &pl->phylink_disable_state);
+	queue_work(system_power_efficient_wq, &pl->resolve);
 	flush_work(&pl->resolve);
 }
 EXPORT_SYMBOL_GPL(phylink_stop);
