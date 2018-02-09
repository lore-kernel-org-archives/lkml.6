Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1427278-1518184589-2-2207021374583626916
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
    t=1518184588; b=eKosz5ynzEgewh+yxR0cob6TFBy012hnJp9kqrMPoPd8g0p
    T664aeevsp5BDQ9X5RKBMkAD4EPYiJDbrwRnOUIHtlC3Ve2HTFNk6u67Fd40ciG6
    aFEN6EutGZiNLkIeYqrO+3AsNQktCuAq8eBIar7pwhOrP/YRM6fxfd5x+TEnjGla
    hC68zIzsgBMSziq96Rl1A5YqmsP6HMxjMh8kyn47mrh+umMONwmZ9+/hOD7ovKQo
    Lggj7sYFaUORnZWBp/wnqmXHfTUMIefydZejxNQkrt5AHJHQBVFpMijMxXiAjb0N
    likdVhmd5R77n8EShIXbGNSLknUBTzB+9F/O5ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184588; bh=xoUKUGve1Le95uOxASYIxFLjUE
    5gxZVbTfigc7IfD0s=; b=lRdstdHa4GDroH5Uf0/nZCo4+owmSidf8qqUwmo9EE
    zc5tkk5dS/1pXx0hr7vIgZQlI5xs7d2Cx0vznJydfewHzO2dKqFdJgC9slA4LbZ/
    LdceS2nBcc3qG6uMpduA1WvTB/8TP2UqBtFLkLo6cKPEfzE9ja8o+/84XHIetlhl
    uqBtzJtvkUZS6b0QZGUXb1ceZqJJORl2WE/d8d4nDwEhNjHBpl4RFc1rqWet/nGj
    yLn0VIshVysETfj2V0m9y5lKOIdOrI2FQQfzlEkOM5VaDoBhp0Ao25joZkm3zMt7
    pZPZnGBEoIjcBvPY9lMPjWPSL5tqzfSQNMLXG7xY6vRQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753686AbeBIN4G (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:56:06 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51738 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753567AbeBINpK (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:45:10 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 13/22] rocker: fix possible null pointer dereference in rocker_router_fib_event_work
Date: Fri,  9 Feb 2018 14:40:02 +0100
Message-Id: <20180209133935.020219288@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133934.024795822@linuxfoundation.org>
References: <20180209133934.024795822@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Pirko <jiri@mellanox.com>


[ Upstream commit a83165f00f16c0e0ef5b7cec3cbd0d4788699265 ]

Currently, rocker user may experience following null pointer
derefence bug:

[    3.062141] BUG: unable to handle kernel NULL pointer dereference at 00000000000000d0
[    3.065163] IP: rocker_router_fib_event_work+0x36/0x110 [rocker]

The problem is uninitialized rocker->wops pointer that is initialized
only with the first initialized port. So move the port initialization
before registering the fib events.

Fixes: 936bd486564a ("rocker: use FIB notifications instead of switchdev calls")
Signed-off-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/rocker/rocker_main.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2902,6 +2902,12 @@ static int rocker_probe(struct pci_dev *
 		goto err_alloc_ordered_workqueue;
 	}
 
+	err = rocker_probe_ports(rocker);
+	if (err) {
+		dev_err(&pdev->dev, "failed to probe ports\n");
+		goto err_probe_ports;
+	}
+
 	/* Only FIBs pointing to our own netdevs are programmed into
 	 * the device, so no need to pass a callback.
 	 */
@@ -2918,22 +2924,16 @@ static int rocker_probe(struct pci_dev *
 
 	rocker->hw.id = rocker_read64(rocker, SWITCH_ID);
 
-	err = rocker_probe_ports(rocker);
-	if (err) {
-		dev_err(&pdev->dev, "failed to probe ports\n");
-		goto err_probe_ports;
-	}
-
 	dev_info(&pdev->dev, "Rocker switch with id %*phN\n",
 		 (int)sizeof(rocker->hw.id), &rocker->hw.id);
 
 	return 0;
 
-err_probe_ports:
-	unregister_switchdev_notifier(&rocker_switchdev_notifier);
 err_register_switchdev_notifier:
 	unregister_fib_notifier(&rocker->fib_nb);
 err_register_fib_notifier:
+	rocker_remove_ports(rocker);
+err_probe_ports:
 	destroy_workqueue(rocker->rocker_owq);
 err_alloc_ordered_workqueue:
 	free_irq(rocker_msix_vector(rocker, ROCKER_MSIX_VEC_EVENT), rocker);
@@ -2961,9 +2961,9 @@ static void rocker_remove(struct pci_dev
 {
 	struct rocker *rocker = pci_get_drvdata(pdev);
 
-	rocker_remove_ports(rocker);
 	unregister_switchdev_notifier(&rocker_switchdev_notifier);
 	unregister_fib_notifier(&rocker->fib_nb);
+	rocker_remove_ports(rocker);
 	rocker_write32(rocker, CONTROL, ROCKER_CONTROL_RESET);
 	destroy_workqueue(rocker->rocker_owq);
 	free_irq(rocker_msix_vector(rocker, ROCKER_MSIX_VEC_EVENT), rocker);
