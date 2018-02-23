Return-Path: <geert@linux-m68k.org>
X-Google-Smtp-Source: AH8x227C+/suDgF5y2WeJreXaMWklf6S6j+BxX8mSCz9pCSjYvXRhQOcD0acKY/NlmxvoFKOWUgb
ARC-Seal: i=1; a=rsa-sha256; t=1519393121; cv=none;
        d=google.com; s=arc-20160816;
        b=Ej0NfGT4bCenawNGiKVAjEzgM6LnfLsTcXgX1VciymNgnWVszTd+d7TTJY6ONFw88V
         lV2s8iAXX2FgSHEUlqRYf8LAsSXizE5eGar2dkEsfcYJ3NrDSAwsa0ftbaDFdVjtJIDe
         Vr+7hqKBlgF5YUlzufXHy0JuwhMNyxVr5/Nq89ceDCMcwpPAVycP47H06BdoeoZLlPKa
         m0R1VpmjTsBaOna+LnvgeRLlV8LBYIi11wZktFdfA6Dsk0LhLpENXDn+fTq2Li1/XKWW
         ogZMTzf7/R+uIpCidQk65zm2zm7PkcF3AxuBBGmUazvROEPC9NrbE7YJYkLygsFBMRP5
         1QxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=txxZxplb1LWUXxFvfsoLh0vMquPdezEjs4yNBqSSJpo=;
        b=PHSuDxCShpnREW3WzOrqfEOvSdybr6HGdLGKFnNFESJHMLeTrpHrUQfV6S9cSSOVze
         rvFLxnQmh79CPg60ZuY3fKffuAaozDd/ei3yT+3ekCqMsMQotD9ULY5PlaHVu2R6XT6e
         Bx83nuj4PRvET9beMO6bTQWPyT6Abeckrd0bEfBM1fEZE70Q99HsbgcRuu8VMnrDzCae
         5QvFADbgTkwBuwqH52ianuLGZMZmQV+ARUhguMY6knbm7IJhyTFl5h4n4EtU7qGL9fQT
         8HUfzKROIGNNaiAq75zCGOlWlB73/5oph5Asy1ZUlWKGSJIbgEh1pAEJe23R35bf5iTi
         otZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2a02:1800:110:4::f00:18 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2a02:1800:110:4::f00:18 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Barry Song <baohua@kernel.org>,
	Vineet Gupta <vgupta@synopsys.com>,
	Jiri Slaby <jslaby@suse.com>,
	Michal Simek <michal.simek@xilinx.com>,
	linux-serial@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 9/9] serial: xuartps: Fix out-of-bounds access through DT alias
Date: Fri, 23 Feb 2018 14:38:37 +0100
Message-Id: <1519393117-31998-10-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519393117-31998-1-git-send-email-geert+renesas@glider.be>
References: <1519393117-31998-1-git-send-email-geert+renesas@glider.be>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593199161902642180?=
X-GMAIL-MSGID: =?utf-8?q?1593199161902642180?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The cdns_uart_port[] array is indexed using a value derived from the
"serialN" alias in DT, which may lead to an out-of-bounds access.

Fix this by adding a range check.

Fixes: 928e9263492069ee ("tty: xuartps: Initialize ports according to aliases")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Michal Simek <michal.simek@xilinx.com>
---
v2:
  - Fix Fixes reference.
---
 drivers/tty/serial/xilinx_uartps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index b9b2bc76bcac606c..abcb4d09a2d866d0 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1110,7 +1110,7 @@ static struct uart_port *cdns_uart_get_port(int id)
 	struct uart_port *port;
 
 	/* Try the given port id if failed use default method */
-	if (cdns_uart_port[id].mapbase != 0) {
+	if (id < CDNS_UART_NR_PORTS && cdns_uart_port[id].mapbase != 0) {
 		/* Find the next unused port */
 		for (id = 0; id < CDNS_UART_NR_PORTS; id++)
 			if (cdns_uart_port[id].mapbase == 0)
-- 
2.7.4
