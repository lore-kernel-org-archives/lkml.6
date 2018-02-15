Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2241641-1518720609-2-10060033403038630260
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
    t=1518720608; b=AvN0B3UQom3r16JZvAuYeGrCHj351zGx0wnafM0I5cuKgHr
    btwvLGztmXwphOzumq5SpfCuyquy1QIEdKGOwCBick5vhzhggnQHs+MEhy/KOFTR
    82sHLKSdlKB3JtSZ8l60xc+5k8hENUkgqhaVVedxkJhkRDAU1zvyRvpsrnh7rRCX
    nhg2ivqSGZgnrk76hJRiuAKa3WglRDQRg4M17Tp6FKO241fMPSdRBoSXbMXcs32A
    dBHU/Io3zn3KzHEarjD9HxtnKTleE4kJefSNdhzuXOaB0762AsMk1skhT305hWss
    17azmkYOYazDIOxX5gYk/Gjn9FS0T+ZqXqap/5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720608; bh=/3nBy/FJz3JxSyoXSU65VPLOqv
    WJq8Spe3bp9dHy9ys=; b=tiOZHMqfKVoWtxC4hgt/G3YnTEnW8dxHrc6+l0SwFO
    VT8XUzNYbHo0gU9ML+CuIzK9G0DU3ctIWREyZ1sysF4lkNaef7InlysqI9rSqSPi
    I9Cq1ZVr5vwaJ4QOg5Qh7GUI6jL2guE//VBL3MeJCXd7a7gUJx/106z41r88cR+D
    0QFZHsv8Vg7wOxeA3WxrqBePOqlvF0ozzAbGB9AYtKO+aZFv5mSY5yazjIcIABAO
    7vbh+pPSLulVn45NgwKn3d/CC6OyUkFZI2hkq7nLZrPbUGSHzXr2uOGB+RvbdZw8
    eVRyuZNke98/8k45a0rg+AG7y7G25UyzMGFqRiRmpLQQ==
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
        id S1162270AbeBOStw (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:49:52 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49210 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162080AbeBOPVo (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:21:44 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chunhao Lin <hau@realtek.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 030/108] r8169: fix RTL8168EP take too long to complete driver initialization.
Date: Thu, 15 Feb 2018 16:16:27 +0100
Message-Id: <20180215151226.622691968@linuxfoundation.org>
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

From: Chunhao Lin <hau@realtek.com>


[ Upstream commit 086ca23d03c0d2f4088f472386778d293e15c5f6 ]

Driver check the wrong register bit in rtl_ocp_tx_cond() that keep driver
waiting until timeout.

Fix this by waiting for the right register bit.

Signed-off-by: Chunhao Lin <hau@realtek.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/r8169.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -1387,7 +1387,7 @@ DECLARE_RTL_COND(rtl_ocp_tx_cond)
 {
 	void __iomem *ioaddr = tp->mmio_addr;
 
-	return RTL_R8(IBISR0) & 0x02;
+	return RTL_R8(IBISR0) & 0x20;
 }
 
 static void rtl8168ep_stop_cmac(struct rtl8169_private *tp)
@@ -1395,7 +1395,7 @@ static void rtl8168ep_stop_cmac(struct r
 	void __iomem *ioaddr = tp->mmio_addr;
 
 	RTL_W8(IBCR2, RTL_R8(IBCR2) & ~0x01);
-	rtl_msleep_loop_wait_low(tp, &rtl_ocp_tx_cond, 50, 2000);
+	rtl_msleep_loop_wait_high(tp, &rtl_ocp_tx_cond, 50, 2000);
 	RTL_W8(IBISR0, RTL_R8(IBISR0) | 0x20);
 	RTL_W8(IBCR0, RTL_R8(IBCR0) & ~0x01);
 }
