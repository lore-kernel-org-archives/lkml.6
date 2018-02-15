Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1883814-1518710560-2-2987679937220670633
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
    t=1518710559; b=snCjE7+VFaKL0r3spDmCZ+S4htDXc2Mfgyvl8hG/lt+Xt1H
    trMz/DQ8Lyh0RsDPdY7mF4MOgZs0lJdxHoTE9CDyIvV7X4fJJvi3RcwEnwP6gEhA
    9K3zfc7IpYNP2RIeRiHotDiX6f0Lq9mpbaXoUAvaj0c2kMvYxlRK274HgFgFck4i
    GliUTc+HHD6nyCTEXtb/eWl1IyAgZtM9CxegcxbkNLQHsIP+w6s8wd7PSk2Oj06t
    UtW0GCbr9QvjMOlyBKW7F32yjzpP6m2Gb8m65WsOikrGbkg1y0/rSE0z3h0mABIk
    5qNT7C5IYJrpFUcpevnN0Ijpt0eQ1ULEZH+zXWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518710559; bh=s/osf1EIb+lepXJLv36k9VZtZX
    eg5pKErILc9SUNRTU=; b=NKEwU79eWUa1hgfXnKi3LRxU4oBvfjgz72Zu1/EVF8
    1e/fvmNRwhN2vFvVxE6ZiC8tQ4iQJluJY3eebaodLB+fF5tq+hIiQ9+K1ThkeVcV
    wXerG5GlSkxH3q1gYaSxd3GbVeUzDk8+imlMn0Su9k+zBgzAgTmlaJ3ne33Knsy8
    RgB0UnBjsE9M3J771Av4IL2LMBTb8OclfiJ7OqzBHPOrmvWj+oH7Y7yIgYDuPud/
    l7BBfevFvUH56Uo/0wt8upE+Z5a0PAZP3pHPRMvqrXfmwax9TMDsgHiVDg8EB4dr
    S48BWlGWP5mvj9bbbpHr27X/yfHOzBw/qtcMTaRLQYmw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424403AbeBOQCX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 11:02:23 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35906 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424703AbeBOPqn (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:46:43 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Mastykin <mastichi@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.15 177/202] pinctrl: mcp23s08: fix irq setup order
Date: Thu, 15 Feb 2018 16:17:57 +0100
Message-Id: <20180215151722.126756239@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Mastykin <mastichi@gmail.com>

commit 02e389e63e3523828fc3832f27e0341885f60f6f upstream.

When using mcp23s08 module with gpio-keys, often (50% of boots)
it fails to get irq numbers with message:
"gpio-keys keys: Unable to get irq number for GPIO 0, error -6".
Seems that irqs must be setup before devm_gpiochip_add_data().

Signed-off-by: Dmitry Mastykin <mastichi@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pinctrl/pinctrl-mcp23s08.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/pinctrl/pinctrl-mcp23s08.c
+++ b/drivers/pinctrl/pinctrl-mcp23s08.c
@@ -896,16 +896,16 @@ static int mcp23s08_probe_one(struct mcp
 			goto fail;
 	}
 
-	ret = devm_gpiochip_add_data(dev, &mcp->chip, mcp);
-	if (ret < 0)
-		goto fail;
-
 	if (mcp->irq && mcp->irq_controller) {
 		ret = mcp23s08_irq_setup(mcp);
 		if (ret)
 			goto fail;
 	}
 
+	ret = devm_gpiochip_add_data(dev, &mcp->chip, mcp);
+	if (ret < 0)
+		goto fail;
+
 	mcp->pinctrl_desc.name = "mcp23xxx-pinctrl";
 	mcp->pinctrl_desc.pctlops = &mcp_pinctrl_ops;
 	mcp->pinctrl_desc.confops = &mcp_pinconf_ops;
