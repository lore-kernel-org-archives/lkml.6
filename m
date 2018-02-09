Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1420212-1518184410-2-15843086857366774101
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
    t=1518184409; b=R8hgEi9gNuw1EgVVAr6Mx6eUFMNQ4Yqhy466HAga1I9EC13
    51uXzD58MQctkCnT3BVPuVLGkXzZM1ViysreoJ3tNCf+jGLR0BdBYmqf67Ab5agO
    pZflAC21EJj8A0GgFOpD63dRyNY5PFuDzWTfw8dRiA4di1j/DWDFw7aIbEn0w83G
    JQRWjL8VlJiuGvaDVn2RSXPLorH9FcSO6AXgwJL8KLCA4uwMJTOYnqBFMbCqAL/Z
    ZxYtMpGoU4XpFf3uYGz1Z3wtSBnLa7nNzyYAcSxQSRa2uVKXPX11XDeeg99lAVnA
    J4Nad+BTnChwdTg9qm7EbaAgTbkS5K367JPKkYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184409; bh=abJHj47hnMpAn7G/owfdoYMwdi
    z6oj5yw5c/NASORtg=; b=GDh22F2KVBjRI7Gnl6O1+QVj2ceWMyYbMMWodcbLGc
    ZGdKiYGtU875U/YhWib4IXXqPRvhWMEoqerrHjfR5l2CLAvx0e1khwsSOysVrJ/h
    xruJbXEyM8A7KH5KXdGHaZcAJpTS5MCAINzf/xRI7+By1cMfFdBAKY4kG3z57Wea
    ldV3rjipQCgopv5GxFwdBbBta6MA3nrgGn1TkkNUJdGN4dhVRTFUZstyXw/7xQfE
    XFZ/B4zjIgBZcwAWi/JDNVJnIpugewBLvhGiM+d19Ex+jiNUKe+iRTKnkR80c1XM
    3JKxPKSoNY+9v5/lB87y6y/acwYkBzkUfidT/QvAu+6A==
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
        id S1753718AbeBINqB (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:46:01 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:52272 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753707AbeBINp6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:45:58 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chunhao Lin <hau@realtek.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 08/22] r8169: fix RTL8168EP take too long to complete driver initialization.
Date: Fri,  9 Feb 2018 14:39:57 +0100
Message-Id: <20180209133934.661753199@linuxfoundation.org>
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
@@ -1388,7 +1388,7 @@ DECLARE_RTL_COND(rtl_ocp_tx_cond)
 {
 	void __iomem *ioaddr = tp->mmio_addr;
 
-	return RTL_R8(IBISR0) & 0x02;
+	return RTL_R8(IBISR0) & 0x20;
 }
 
 static void rtl8168ep_stop_cmac(struct rtl8169_private *tp)
@@ -1396,7 +1396,7 @@ static void rtl8168ep_stop_cmac(struct r
 	void __iomem *ioaddr = tp->mmio_addr;
 
 	RTL_W8(IBCR2, RTL_R8(IBCR2) & ~0x01);
-	rtl_msleep_loop_wait_low(tp, &rtl_ocp_tx_cond, 50, 2000);
+	rtl_msleep_loop_wait_high(tp, &rtl_ocp_tx_cond, 50, 2000);
 	RTL_W8(IBISR0, RTL_R8(IBISR0) | 0x20);
 	RTL_W8(IBCR0, RTL_R8(IBCR0) & ~0x01);
 }
