Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3841409-1519418808-2-9949224210601208018
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
    t=1519418807; b=Zwv6Po5XjZWU8qKv4nVhkIQ/CmVrl0ekgWaaRE46nh5oVA5
    VD9gSr4pZgTGRo9HZGZYWqHp8SAV0BW8ajqhBojJmv81Cp0xRGC4qp9ch5TN+4yE
    OGrekOaQXYsTsr9mRTugjGKGzd8XxiQQw7hz/625Lo83GxSDEKgsRhdexdJ8rFpb
    nO7wsIoXF1WiNY++B12DWyOWhdoPiB1SBXvoNzelAt4FFV0E47h3FIW/V85fT4kN
    r/oMafyg6vGcS/OPL7J53HzocKaF801Q23YM4mo41OP7NesHoDkw4AESOY+S49FQ
    393N8TUyUKA2dlOiUlMlxnSlP9avkEt1/fHN6dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519418807; bh=ljPMMUq+sAyP14wDhEm+lGibXu
    sVLrFU4jDcRhjiHqE=; b=A0/xvtppppOPIPglSaZ70eeSgSwF/rl209kBhv1mOq
    Y1ReJHusTQkkJScN5jxmr8jNKclVkurjcF51+L2wMc/aDtDkEGH/qEl2CyYOzmS8
    C26Jq5MHqREgtu/KZohsHv/q7r5vOvx8GqaC74bjuE2YBLnezev6FcDH9Qoh9oUT
    vytarwNTVO085TJ605jni3J8Mraa2UowOhupwJua+ysegwdIicc7yaKQWdSGGR4G
    yB/AR31J/18DvZAkvTroHMd+LLYyRVBIvCHoqVsDaNhE7ZdifLY0AQemzUa40kwQ
    a27QjS3MRsO8r5+bIm3QY2w0r7EuSkWBhTZVtzb09ZkA==
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
        id S1752809AbeBWScV (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:32:21 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36118 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752798AbeBWScR (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:32:17 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia-Ju Bai <baijiaju1990@163.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 56/58] hippi: Fix a Fix a possible sleep-in-atomic bug in rr_close
Date: Fri, 23 Feb 2018 19:26:55 +0100
Message-Id: <20180223170215.513471908@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170206.724655284@linuxfoundation.org>
References: <20180223170206.724655284@linuxfoundation.org>
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

From: Jia-Ju Bai <baijiaju1990@163.com>


[ Upstream commit 6e266610eb6553cfb7e7eb5d11914bd01509c406 ]

The driver may sleep under a spinlock.
The function call path is:
rr_close (acquire the spinlock)
  free_irq --> may sleep

To fix it, free_irq is moved to the place without holding the spinlock.

This bug is found by my static analysis tool(DSAC) and checked by my code review.

Signed-off-by: Jia-Ju Bai <baijiaju1990@163.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hippi/rrunner.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/hippi/rrunner.c
+++ b/drivers/net/hippi/rrunner.c
@@ -1381,8 +1381,8 @@ static int rr_close(struct net_device *d
 			    rrpriv->info_dma);
 	rrpriv->info = NULL;
 
-	free_irq(pdev->irq, dev);
 	spin_unlock_irqrestore(&rrpriv->lock, flags);
+	free_irq(pdev->irq, dev);
 
 	return 0;
 }
