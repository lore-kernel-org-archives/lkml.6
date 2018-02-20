Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2549902-1519120727-2-16432965661975628950
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='be',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519120726; b=VEAWAYg3UThlmRhG3iM/jp8duL2dh0+yvE53N4zPelsdWN9
    6XOOi79o7IH+pnrFaB+t1CN5myVBPAvRKsewqDiJ3tFiS0k1jTVUM9W8NAhOseQz
    h/JMwh5mk9o+HnGb88L67dZf7pNtKeH9Elw32CTxGWk9DNUSrrsucotIempYocW+
    oSsXKklE0VTAB82hPt/5soDqCKJ1VhPir9MWGlVo3sHc/PhZkGg5BReD3vhSEdBh
    ctWzfB/hCKCPqOscOjfL1WwBDe/pJaxNWeYkYNHncOGS6TJeettLtKqyadJRhZ5z
    JUBvOhedBUJI3FpJCawy7shtCgplZ5ruJdYa+Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519120726;
    bh=u+RH+gLNaP+BtkBbAwPIocKATWpThI7evuDmmNjl4DY=; b=l9d4FB+DqZs8
    YeZNSxkmS7Za870ftfM4wT7xsvb3cElLzTPcZFfPhtnj2hhb3ispmwR3ejB/YXcs
    S59khKO/wAwCqeDC2e0qwzcpv4BaJi7Fk01dTibHTbCqmiWKjF4VlIGGOhvWnB9j
    fG0xyiGnk6v/8XwUWRjx//8cGMjAWSy7PmsGkV++AO9tEadtI2OTPKy+X71+MKTX
    1evBciSWZILm7k0O5vtja21gcL9kfUwWC16rjzRJ3BvKiv0s0u1lbTMrGWN+8lDs
    R2dk4rs8ANEoFPwRAgaqUWYMlQ7kkQIm9pRB2o6pUVIbnCkPU6bKoSM6bOnCdpcy
    gjQ4Hk07CQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=glider.be;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=glider.be header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=glider.be;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=glider.be header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751435AbeBTJ6D (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 04:58:03 -0500
Received: from albert.telenet-ops.be ([195.130.137.90]:59782 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751432AbeBTJ51 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Feb 2018 04:57:27 -0500
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Barry Song <baohua@kernel.org>, Vineet Gupta <vgupta@synopsys.com>,
        Jiri Slaby <jslaby@suse.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-serial@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/9] serial: arc_uart: Fix out-of-bounds access through DT alias
Date: Tue, 20 Feb 2018 10:40:16 +0100
Message-Id: <1519119624-1268-2-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The arc_uart_ports[] array is indexed using a value derived from the
"serialN" alias in DT, which may lead to an out-of-bounds access.

Fix this by adding a range check.

Note that the array size is defined by a Kconfig symbol
(CONFIG_SERIAL_ARC_NR_PORTS), so this can even be triggered using a
legitimate DTB.

Fixes: 10640deb04b7949a ("serial: arc_uart: Fix out-of-bounds access through DT alias")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/arc_uart.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
index 2599f9ecccfe7769..1cb827a6b836d0dd 100644
--- a/drivers/tty/serial/arc_uart.c
+++ b/drivers/tty/serial/arc_uart.c
@@ -593,6 +593,11 @@ static int arc_serial_probe(struct platform_device *pdev)
 	if (dev_id < 0)
 		dev_id = 0;
 
+	if (dev_id >= CONFIG_SERIAL_ARC_NR_PORTS) {
+		dev_err(&pdev->dev, "serial%d out of range\n", dev_id);
+		return -EINVAL;
+	}
+
 	uart = &arc_uart_ports[dev_id];
 	port = &uart->port;
 
-- 
2.7.4

