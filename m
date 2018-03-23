Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133089-1521806057-2-15678650950606620410
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
    t=1521806057; b=bsSr5k9G5g2s2ktCEaJ6ZsWVNGl8HcXazRT1wh2tSOmMcwq
    rbMJ1bgSK4HqAdTCP0QpfwZN8DQg6WQueYNdSmaudzr2+ADDaHLQWUwLel/YJrS9
    bRi2rZub+Vv/dp2yrNwzblAnm+kBzTK37aMDsvcQdY8N9VrrYx8QoHzDY5gziOVw
    FVZ3SFoMNCK+ojmVXCzLhjSYj1ndDDmbxnnQgZj+ET42Hxa7dhWMFpurIyIsUr35
    99BBZolrxllHHo8nQa0DYO1lTmGB6bzYYghW7IyUWtCqMxudDyaR3w2JyOYkN0eq
    PD/WIml7G2huFsTDBnkRIWE1upzKfMHB0nrhLfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806057; bh=TuRFUbQJmB5uYWWLsf8kkvPoEi
    fyLyc9WxzBMZkpV+0=; b=JsD7qJCNbmeycA2l1hbQyBKrW7HxOKWySkybWxPv7m
    s+TNicombJCEpeZCmxkp92CesN98AKW83SvUKe7zx71xoAoOiKdCn3HyuNh/xM78
    0R8UUPkn/Zk+fIlX7WiwgwZH5qBThjolKVwHVxssrMvJjd5iDiLkl4S9rPhmzeNz
    pF6H/2xgJ4PluP/BPyeY1ejxR7D2Cq8Pc9TkxspjUcNAmpxeUZVFXaAY5NIgSsS/
    FslI2j3qFKX/uIY2FXU/TWlvW7wyEVvj0VAorkNoqgJh9Cgk7WXxjEPYetxfQuEm
    ylHBZqgSfTL7d7jDfVYRXX0CPbLNVzsYji4zxXxquAhQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
        id S1753949AbeCWKBh (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:01:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37916 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753580AbeCWKBe (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:01:34 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Stefan Potyra <Stefan.Potyra@elektrobit.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 20/77] serial: 8250_dw: Disable clock on error
Date: Fri, 23 Mar 2018 10:53:54 +0100
Message-Id: <20180323094143.572199307@linuxfoundation.org>
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

From: Stefan Potyra <Stefan.Potyra@elektrobit.com>


[ Upstream commit 8af016aa5a27c6a2505460eb4d83f1e70c38dc43 ]

If there is no clock rate for uartclk defined, disable the previously
enabled clock again.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: 23f5b3fdd04e serial: 8250_dw: only get the clock rate in one place
Signed-off-by: Stefan Potyra <Stefan.Potyra@elektrobit.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_dw.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -513,7 +513,8 @@ static int dw8250_probe(struct platform_
 	/* If no clock rate is defined, fail. */
 	if (!p->uartclk) {
 		dev_err(dev, "clock rate not defined\n");
-		return -EINVAL;
+		err = -EINVAL;
+		goto err_clk;
 	}
 
 	data->pclk = devm_clk_get(dev, "apb_pclk");
