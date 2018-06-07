Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 4LNHEnBDGVsXCAAAmS7hNA
	; Thu, 07 Jun 2018 14:40:27 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 24CAE608BA; Thu,  7 Jun 2018 14:40:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7AD25607DC;
	Thu,  7 Jun 2018 14:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7AD25607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934474AbeFGOkY (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:40:24 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40543 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932912AbeFGOkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:40:18 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbX-0005Zl-Cl; Thu, 07 Jun 2018 15:09:31 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbA-0003AK-P0; Thu, 07 Jun 2018 15:09:08 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Ulrich Hecht" <ulrich.hecht+renesas@gmail.com>,
        "Nguyen Viet Dung" <dung.nguyen.aj@renesas.com>,
        "Yoshihiro Shimoda" <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.197204780@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 308/410] serial: sh-sci: prevent lockup on full TTY
 buffers
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

commit 7842055bfce4bf0170d0f61df8b2add8399697be upstream.

When the TTY buffers fill up to the configured maximum, a system lockup
occurs:

[  598.820128] INFO: rcu_preempt detected stalls on CPUs/tasks:
[  598.825796]  0-...!: (1 GPs behind) idle=5a6/2/0 softirq=1974/1974 fqs=1
[  598.832577]  (detected by 3, t=62517 jiffies, g=296, c=295, q=126)
[  598.838755] Task dump for CPU 0:
[  598.841977] swapper/0       R  running task        0     0      0 0x00000022
[  598.849023] Call trace:
[  598.851476]  __switch_to+0x98/0xb0
[  598.854870]            (null)

This can be prevented by doing a dummy read of the RX data register.

This issue affects both HSCIF and SCIF ports. Reported for R-Car H3 ES2.0;
reproduced and fixed on H3 ES1.1. Probably affects other R-Car platforms
as well.

Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Nguyen Viet Dung <dung.nguyen.aj@renesas.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/tty/serial/sh-sci.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -734,6 +734,8 @@ static void sci_receive_chars(struct uar
 		/* Tell the rest of the system the news. New characters! */
 		tty_flip_buffer_push(tport);
 	} else {
+		/* TTY buffers full; read from RX reg to prevent lockup */
+		serial_port_in(port, SCxRDR);
 		serial_port_in(port, SCxSR); /* dummy read */
 		serial_port_out(port, SCxSR, SCxSR_RDxF_CLEAR(port));
 	}
