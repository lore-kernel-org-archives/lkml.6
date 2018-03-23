Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-977995-1521799852-2-1429825159354234275
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
    t=1521799851; b=II1Yw4yeiC3pbDu3HoZEr/+WAD4rUy/2Un/MSC8VGOx6Tg0
    mT/+roGoXRvnlrNV4PaMwVyHXXj+Z6PvxM9elToiaxfAKWKyV6riAtZc/7mqPSMs
    SNgqX6pqGnjNaTnwxUAS8a4h+MR1JJHz0fCcU1PvCSCrMMrmJ/ApbV7EJ7mbNo+h
    yb6xv71zYEpiYqrgB5VA9DMNpCDeLnXy94oHjMOkSEx3xcFm+qzCLhGvarQYh9R7
    zmFNb4JxzjXMNvByArg4qGjFv7MmNSEgXZgC4Vn5sva0CfsZ0lbkMhznC244UwpQ
    KKXKCkFMYAQRUZOfMiDF7J7kpoWfSrRYWP+K51Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521799851; bh=+S2gLYotMX6qHHEmQLpVwKocnF
    /qz6zfzbnS/8Htwxo=; b=ibN+8AVU6ISFecNWwGFAMWzbkDSj5Fi6/kkTOuMb9v
    p2fw4pzmejZNqDRV7GxN4Y9nAbnEvyR5R54OpibyF9KtoaPPvsrJtaPAImYDAhcF
    Bf2R6bVCgzKLrhLQEz3yisuVnPQ92Rtbhehm/YkV0yqbFTEm5arLK9g6MWmAfmDi
    nmzvHne4Sh7JurZJmVaqwJyXuZ06ZAZMy7nagc1dhYn+Z0fZ02WU9ZrxD++P80AL
    mz0tDijRfLYL0bpgMlwxcvjqM70qdh8G29AN//ejE3Zhd5tJO456yo6Sg8/2KOQw
    76wfQq+FC4GXevozmDM0ET8Gq1ypN1KiwThLqUH+05PA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
        id S932800AbeCWKKt (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:10:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43188 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932799AbeCWKKq (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:10:46 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 129/177] rtc: ds1374: wdt: Fix issue with timeout scaling from secs to wdt ticks
Date: Fri, 23 Mar 2018 10:54:17 +0100
Message-Id: <20180323094210.918293118@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Moritz Fischer <mdf@kernel.org>


[ Upstream commit 453d0744f6c6ca3f9749b8c57c2e85b5b9f52514 ]

The issue is that the internal counter that triggers the watchdog reset
is actually running at 4096 Hz instead of 1Hz, therefore the value
given by userland (in sec) needs to be multiplied by 4096 to get the
correct behavior.

Fixes: 920f91e50c5b ("drivers/rtc/rtc-ds1374.c: add watchdog support")
Signed-off-by: Moritz Fischer <mdf@kernel.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/rtc-ds1374.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/rtc/rtc-ds1374.c
+++ b/drivers/rtc/rtc-ds1374.c
@@ -527,6 +527,10 @@ static long ds1374_wdt_ioctl(struct file
 		if (get_user(new_margin, (int __user *)arg))
 			return -EFAULT;
 
+		/* the hardware's tick rate is 4096 Hz, so
+		 * the counter value needs to be scaled accordingly
+		 */
+		new_margin <<= 12;
 		if (new_margin < 1 || new_margin > 16777216)
 			return -EINVAL;
 
@@ -535,7 +539,8 @@ static long ds1374_wdt_ioctl(struct file
 		ds1374_wdt_ping();
 		/* fallthrough */
 	case WDIOC_GETTIMEOUT:
-		return put_user(wdt_margin, (int __user *)arg);
+		/* when returning ... inverse is true */
+		return put_user((wdt_margin >> 12), (int __user *)arg);
 	case WDIOC_SETOPTIONS:
 		if (copy_from_user(&options, (int __user *)arg, sizeof(int)))
 			return -EFAULT;
