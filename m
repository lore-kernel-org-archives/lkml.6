Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133089-1521806029-2-14280198337128647714
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
    t=1521806029; b=hImJVPpWB2WcmSmk1fXMt4Ec8962XAJHryZttwRDAmBFOA/
    GPHh7cdlgDc3BkD1c8kDB6xh8a4pJdVk78KyvdOa1xLbgBisjKBe1gD+Q+X6rJf1
    uAMAh4kUKG4DNDxoUOAXTV0dUrrm+pzX6IoPRuXTslyxcDUsdY912p2JTdGitzTc
    Lrm1Jwe+HcY44K/bFHgBz8nBvz30Pk+9ILUnnM1OsNQNaKFiwHnvH2QJjb+mbP1M
    FFE2/CL4g/SLTOPTlkGzlDkmEjqqM9LalyjEwPCv87BoN1g7S6HEvoI44cxC1jIA
    XKbXowz2cLy4w/SEkPKmMeR7tc6doR0OXQRoekg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806029; bh=RGxsYxVdyZYCKDDxPVIoh5aIUX
    AGyRxF5z1+aByyRgA=; b=QSRY+R9MvzJaUwEjeC1krWXql8TZaV0vfTl77IfLzX
    LMb7u5wwliAcPxmniRi21D/ritjtnQhlLeMzKzSgPSvluWNaZIbSzxT9CQkNkaD/
    uJ8kyrQ5lQTB6OQKfOEjX6Gp6gTBfiK+PAD0S5F0KEzM0wnI+2/z2exZMg3MYPyt
    wawY3X/kS9rRSOlZdMohfeXZVZHf+VLmlKU3vd0PtrNWivsesYFI20xK6XFk8oF9
    3uCvemlWSwQucvNboix/9epcsR9oqtRzOwiizabQWWVs+MkMSlbO1iZ1+QW5TCzX
    AlqGBMruQFGTNANl//P/Krjr6yy+CoV5YH0J3R/YuESg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754157AbeCWLxh (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:53:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38044 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753974AbeCWKBm (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:01:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 23/77] watchdog: Fix kref imbalance seen if handle_boot_enabled=0
Date: Fri, 23 Mar 2018 10:53:57 +0100
Message-Id: <20180323094143.750833773@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
References: <20180323094142.260022880@linuxfoundation.org>
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

From: Guenter Roeck <linux@roeck-us.net>


[ Upstream commit 914d65f3f013ba2556c7beec5d3baac7b3292504 ]

If handle_boot_enabled is set to 0, the watchdog driver module use
counter will not be increased and kref_get() will not be called when
registering the watchdog. Subsequently, on open, this does not happen
either because the code believes that it was already done because the
hardware watchdog is marked as running.

We could introduce a state variable to indicate this state, but let's
just increase the module use counter and call kref_get() unconditionally
if the hardware watchdog is running when a driver is registering itself
to keep the code simple.

Fixes: 2501b015313fe ("watchdog: core: add option to avoid early ...")
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/watchdog/watchdog_dev.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -966,14 +966,13 @@ static int watchdog_cdev_register(struct
 	 * and schedule an immediate ping.
 	 */
 	if (watchdog_hw_running(wdd)) {
-		if (handle_boot_enabled) {
-			__module_get(wdd->ops->owner);
-			kref_get(&wd_data->kref);
+		__module_get(wdd->ops->owner);
+		kref_get(&wd_data->kref);
+		if (handle_boot_enabled)
 			queue_delayed_work(watchdog_wq, &wd_data->work, 0);
-		} else {
+		else
 			pr_info("watchdog%d running and kernel based pre-userspace handler disabled\n",
-					wdd->id);
-		}
+				wdd->id);
 	}
 
 	return 0;
