Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753222AbeE3Lda (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:33:30 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60877 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751508AbeE3LHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:04 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Nguyen Viet Dung" <dung.nguyen.aj@renesas.com>,
        "Ulrich Hecht" <ulrich.hecht+renesas@gmail.com>,
        "Yoshihiro Shimoda" <yoshihiro.shimoda.uh@renesas.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.980952913@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 112/153] serial: sh-sci: prevent lockup on full TTY
 buffers
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.2:
 - Use sci_in()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/tty/serial/sh-sci.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -668,6 +668,8 @@ static void sci_receive_chars(struct uar
 		/* Tell the rest of the system the news. New characters! */
 		tty_flip_buffer_push(tty);
 	} else {
+		/* TTY buffers full; read from RX reg to prevent lockup */
+		sci_in(port, SCxRDR);
 		sci_in(port, SCxSR); /* dummy read */
 		sci_out(port, SCxSR, SCxSR_RDxF_CLEAR(port));
 	}
