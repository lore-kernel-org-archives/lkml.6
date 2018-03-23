Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133089-1521805115-2-15787658033871795848
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521805114; b=LacTUBSC8DXLcK6M99zQyAfuymQR1qupiwCAmD+3ImYwDlN
    HEvZ8VTMmyYFV//CY3UKzDevCxPwyZEmC/f/OA99jRleYclj+rK7WuSmQ6z657nU
    0Lrafy0pHLSCBxgY5h2OrpYQagYgairYtvBp4rLx2yYx8GQ1R7y7kQKka7zvPpHk
    3rEJBvgdTQE0f5mGWoTHXX6dYPkdjkTOPhRqfV+kjkCDJvT810y1YlM5C8KFAyR3
    mhZ0ybVggcoPltn/SD/YKteDnvAM/prm6TUs7Tzd94ksxwM6UkRtKui9z+2fysZO
    dBaPXPyIdxBq4U4dT5Yr6S2c5xnzGpNvt6RyaqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521805114; bh=8Fsa6cTn3g3pzsuM/ka2hJwY8q
    qFBKRdL1W8YY32Jrg=; b=nuv05Vh/vmIx9dvKbMa6K3ayRomCjxG2qNsMM3dqLL
    BDcTcuqutbh1qz2oshxwISHaE2/craxtVYborfJp2NJ/AQLArOKNvxcQtW3C+DJf
    8KPoROAEF0JFAgiJ7+3LTRoXjCxqFg63UXfIqZaLgNu15qHvtEzoI5tVGTqu8/fL
    Lf7F3xMlnEAQRYlO/Dw/Bs25tGIq4w0q9juBCXKhdEaqCKlzX5hX1QW1sKHPo5Kg
    mV0SIlCfBixBikVM63JmJyKFsC/+becyhIsguf60b7YOBOA6CJ3RoYkRTlAT+gJn
    An4FZ+AOLvj+HbXy1vIfklydfnzENmr/yvKsFKn05FRg==
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
        id S1754775AbeCWKEn (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:04:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39220 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754747AbeCWKEh (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:04:37 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Liam Breck <kernel@networkimprov.net>,
        Sebastian Reichel <sre@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 011/177] power: supply: bq24190_charger: Limit over/under voltage fault logging
Date: Fri, 23 Mar 2018 10:52:19 +0100
Message-Id: <20180323094205.712019635@linuxfoundation.org>
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

From: Liam Breck <kernel@networkimprov.net>


[ Upstream commit d63d07c6fc25182af6d3ab5b3b8737b0c1025ebd ]

If the charger is unplugged before the battery is full we may
see an over/under voltage fault. Ignore this rather then emitting
a message or uevent.

This fixes messages like these getting logged on charger unplug + replug:
bq24190-charger 15-006b: Fault: boost 0, charge 1, battery 0, ntc 0
bq24190-charger 15-006b: Fault: boost 0, charge 0, battery 0, ntc 0

Cc: Tony Lindgren <tony@atomide.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Liam Breck <kernel@networkimprov.net>
Acked-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/supply/bq24190_charger.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1184,8 +1184,13 @@ static irqreturn_t bq24190_irq_handler_t
 		}
 	} while (f_reg && ++i < 2);
 
+	/* ignore over/under voltage fault after disconnect */
+	if (f_reg == (1 << BQ24190_REG_F_CHRG_FAULT_SHIFT) &&
+	    !(ss_reg & BQ24190_REG_SS_PG_STAT_MASK))
+		f_reg = 0;
+
 	if (f_reg != bdi->f_reg) {
-		dev_info(bdi->dev,
+		dev_warn(bdi->dev,
 			"Fault: boost %d, charge %d, battery %d, ntc %d\n",
 			!!(f_reg & BQ24190_REG_F_BOOST_FAULT_MASK),
 			!!(f_reg & BQ24190_REG_F_CHRG_FAULT_MASK),
