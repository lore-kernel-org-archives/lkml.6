Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2951739-1517591677-2-5374003931294262818
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
    t=1517591676; b=caFsl1RZTZT3yeHLHDjqfqKZWPXH2aQ26Z0jUoMN+P97Zty
    IfI9HU/wa2RpYA0um7bWaUldc/RlkDbwEq7CQt2iyge9w/cZRWwDULLb5Jx/qQLD
    anLD9I+nXqPkqJoQx0Kpesp56pPhg1YX2X0swXlbKfUFBAYD5ipR2Fv1Q9NTlgwj
    LLxnibDr/Fu0B3Gaw+39VHAtmAELTA/v6i/v/3fSanr/M20G96J16rr3dv4yM6HX
    EUmxxUdT5DXP73MkwfQ1lQY89j9Si7FyZH9IZGpvbmWiZ7oWEmqu/KgZBA0EoNN+
    bnPhZ9xr3Kd3SybzV1rSckurhBI7cIizH9133cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591676; bh=JdI086tMnWto2Gt+3IkRZAIPnp
    Nz/VoCij34tHrytNI=; b=wKRkhvO6Z++b9CnPis5y2YWc93+w0w/U7DPXej1EMA
    iFAFKdrkLdLKSxq+zu1lqJ09a+UGCkOBhmh5qa3O0H2bfvHNoov6CbpBCF28Ci7P
    ow7gLWJwEuqsFrKPKW5jwbICdwje4pHTdf45NV1lgS9Jts0l6geW643y2GT98bCQ
    ljEGGGnPz+ieSZrr7WkxPr7Z7dH6WBk2a/5FZQRSFAUCOJlt4xcubSTokTXKktw1
    pF9kR4TeTRo2v2levddmDmfjX7F44OQrodLaZe+Q/PVxKajZJQUJoM+c5a7GVE83
    DNGFAdez8pih2kRorFOc6DXC8Y6LhcIkN09DyiAjZVjQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753644AbeBBROe (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:14:34 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:40370 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753580AbeBBROM (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:14:12 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Fugang Duan <fugang.duan@nxp.com>
Subject: [PATCH 4.14 149/156] serial: imx: Only wakeup via RTSDEN bit if the system has RTS/CTS
Date: Fri,  2 Feb 2018 17:58:50 +0100
Message-Id: <20180202140847.101104163@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
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

From: Fabio Estevam <fabio.estevam@nxp.com>

commit 38b1f0fb42f772b8c9aac53593883a18ff5eb9d7 upstream.

The wakeup mechanism via RTSDEN bit relies on the system using the RTS/CTS
lines, so only allow such wakeup method when the system actually has
RTS/CTS support.

Fixes: bc85734b126f ("serial: imx: allow waking up on RTSD")
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Reviewed-by: Martin Kaiser <martin@kaiser.cx>
Acked-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/imx.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2275,12 +2275,14 @@ static void serial_imx_enable_wakeup(str
 		val &= ~UCR3_AWAKEN;
 	writel(val, sport->port.membase + UCR3);
 
-	val = readl(sport->port.membase + UCR1);
-	if (on)
-		val |= UCR1_RTSDEN;
-	else
-		val &= ~UCR1_RTSDEN;
-	writel(val, sport->port.membase + UCR1);
+	if (sport->have_rtscts) {
+		val = readl(sport->port.membase + UCR1);
+		if (on)
+			val |= UCR1_RTSDEN;
+		else
+			val &= ~UCR1_RTSDEN;
+		writel(val, sport->port.membase + UCR1);
+	}
 }
 
 static int imx_serial_port_suspend_noirq(struct device *dev)
