Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2549902-1519120670-2-16729385950789369852
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
    t=1519120670; b=JYmap1tu21qjyqNM2li6kDbkRc3/+MvHYpf8M94ifCo7/5t
    GKOtv1ZpXbbHM7Fi5mg76nRyStRRXiG0EvE0T0Of8HZ5LDzqNdhhB1hq0BB906Nm
    l+//I537BCVtvtr34MQAAMTiDakUozqnRRTeMcmC21FT4qVgqQ03kZ5dtD22RFsQ
    AkejmF03oPhk0kwlT/HGONmTps21f9r5KtJUNrekRKVyHq262nJuDLFE3tzvVG+d
    fthnKiZCxBhg/WoawGvT1I4nehremsoFXV7AZ2vxilWdhw7Zkr89tiIEHDrTxxoe
    S9i1qYmScVsEA1E/95GdLJa+G0fqdKdW143UmDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519120670;
    bh=bmgHSioZLtof27zF144/WhKgm89x4BHiWIK1NdD0Xnw=; b=R5xm0OzKY2V1
    5CyVRMsERudPpKhZqW6ezGizZwICPdFacILA+sY2VmClgshkiJmPHf56eKn07ygB
    mI/c7hDqf+RJe9/p9SCf+aaHarwEhqu84QSFd1KpNjVFDCx2e8UE5nsfPshbBeQo
    AWvgbcpxzbsP4CFy0qy5GNa0pEAmtb3o67n/gGzSeXHX63PYqaQ6GVGUZR3zzZS2
    DLtQqeQDYefOri2ddKAuofYTJ7oEUONjnmXmiN/LkJUaM+4215XkqNnmw3Xytz9M
    mpiFbNKumJpt0oen6OqehFVZj/kSeWsmuxxC+Ianb59dVFY4Cq8t+zQQlp4p/tzn
    G8TC3RzHmw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=glider.be;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=glider.be header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=glider.be;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=glider.be header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751463AbeBTJ5b (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 04:57:31 -0500
Received: from laurent.telenet-ops.be ([195.130.137.89]:60186 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751401AbeBTJ5Z (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Feb 2018 04:57:25 -0500
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
Subject: [PATCH 8/9] serial: sirf: Fix out-of-bounds access through DT alias
Date: Tue, 20 Feb 2018 10:40:23 +0100
Message-Id: <1519119624-1268-9-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The sirf_ports[] array is indexed using a value derived from the
"serialN" alias in DT, which may lead to an out-of-bounds access.

Fix this by adding a range check.

Fixes: 66c7ab1120585d18 ("serial: sirf: Fix out-of-bounds access through DT alias")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sirfsoc_uart.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 9925b00a97772a1b..701df3319ff7579d 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -1283,6 +1283,11 @@ static int sirfsoc_uart_probe(struct platform_device *pdev)
 		goto err;
 	}
 	sirfport->port.line = of_alias_get_id(np, "serial");
+	if (sirfport->port.line >= SIRFSOC_UART_NR) {
+		dev_err(&pdev->dev, "serial%d out of range\n",
+			sirfport->port.line);
+		return -EINVAL;
+	}
 	sirf_ports[sirfport->port.line] = sirfport;
 	sirfport->port.iotype = UPIO_MEM;
 	sirfport->port.flags = UPF_BOOT_AUTOCONF;
-- 
2.7.4

