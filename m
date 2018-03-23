Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1092440-1521803517-2-16218058653724903055
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
    t=1521803517; b=UnwrN9f8vYUzu45RRf7AKb97FPTkP6kRp1v6Q64+L+2VWA2
    3mcLMvxfkdBWgHwiT3iQR+IUhgGbU21V4cYlDczcicdPON01dLsbmPG38iiM7iiy
    7jVPkf3WVjF0ANYXj3v8cJAGj5ROUTUTBYAMXqPhuQVFPjuyosKpDXi4VL2n0nOA
    b0IY9YgctvAWOQWhC/XyZe5tYspMBRCKpmOCcPaYXFNrK9JF9z45hE3yySGXuB97
    5f+qAOBIBoAInoAy/H+KJUVq1SQbuICBsWtDr0kvWOo3v97nwrRif/AwCt0VzKf1
    sD5XDJJsk9UAeR0fbh5Sq2+da82VeIYr+6eykvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803517; bh=Irfkqzv6WeXUzMKcZBlXRJlQZT
    l2PeIJv7p20aHjZb8=; b=CiHnx9fQF6orWiqBYgcagTi+deBbiJZtx6RtFZs986
    a8t49p1rC12rRlUd5ZZMyztkW+qhESO/3kkIsuvCoYgUBT1zdgPJ4Zkiy/cPEQM1
    fUPNaVb8TCvGR8oKtRyOCw7lOhwxMycukvdFM/e6s/nfecwlATbEPhyvK4MaJ6XX
    d8u365WoTBlz9GkxSMQ7CCcSJHv4QHErliDPGHDwLf/wN8CFFK+2C2cMJo6jc8Qw
    NST5zGKd0VDqf5eb4TvZfLr3FpCK/hPx4twtjCoEl2gUDS0K2zySrAt9CCKKpxm2
    R6+sCAxg+0i7mO2cYPylpoKTDJK4/cS2Xa+PFBpKsDpA==
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
        id S932838AbeCWKK5 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:10:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43394 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932734AbeCWKKs (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:10:48 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 130/177] rtc: ds1374: wdt: Fix stop/start ioctl always returning -EINVAL
Date: Fri, 23 Mar 2018 10:54:18 +0100
Message-Id: <20180323094210.960608038@linuxfoundation.org>
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


[ Upstream commit 538c08f4c89580fc644e2bc64e0a4b86c925da4e ]

The WDIOC_SETOPTIONS case in the watchdog ioctl would alwayss falls
through to the -EINVAL case. This is wrong since thew watchdog does
actually get stopped or started correctly.

Fixes: 920f91e50c5b ("drivers/rtc/rtc-ds1374.c: add watchdog support")
Signed-off-by: Moritz Fischer <mdf@kernel.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/rtc-ds1374.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/rtc/rtc-ds1374.c
+++ b/drivers/rtc/rtc-ds1374.c
@@ -548,14 +548,15 @@ static long ds1374_wdt_ioctl(struct file
 		if (options & WDIOS_DISABLECARD) {
 			pr_info("disable watchdog\n");
 			ds1374_wdt_disable();
+			return 0;
 		}
 
 		if (options & WDIOS_ENABLECARD) {
 			pr_info("enable watchdog\n");
 			ds1374_wdt_settimeout(wdt_margin);
 			ds1374_wdt_ping();
+			return 0;
 		}
-
 		return -EINVAL;
 	}
 	return -ENOTTY;
