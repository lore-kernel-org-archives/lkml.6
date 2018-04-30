Return-Path: <npiggin@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525100195; cv=none;
        d=google.com; s=arc-20160816;
        b=drpNpdUsu8KXZu15QqEDcAs6HY39/pqaDmARfjJLwAd3lTPMQqNsleCCdYtesRrB+M
         x9g92pJyjhoomjdphQr2azpfRXGT4vgTZCFHWVDr9yDRppZtb9xSL+7eJg96aF/IrM19
         KDuiH6TTYwTzhLK/iP9Huqq8+YE7otyQAJhxevIV75H1YQtgwJfl906zFDqVnr3hARiP
         7Rc4VgV6N9BUpnA5ugi/E0zHqlF9aAxcaccT++vckxVXjhf5SlzEnEzgVUBI94EbxECi
         V5bObrmTyCbOyXHqgA1VZm9VQpUXWhXvvUd6HGCkcCEBCeB7eYX+l4iro89hX1E+GwTJ
         luvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=gLL0iD7Se+4qGM6YbXK3aymkd8q1kqbXfwTSaXfqol8=;
        b=GbAnpTqemrwyjgU3IRMi/bLQS5cZRU+qS/rmOXq1BclvQLiPWFa4NGcpFEtyq/GwTB
         x9fiUvHrbFWcfe9VYrt5F5IuIdWar55Ma2muwAPBVQFQYvPnUexkxl/GO9Dy+Y2/8+Xv
         UQCV7Nk8PPOyw5qWmRQGkylBKNvbLMzxZaigYLX9bhhx2C1dXdZSeC05XqnmlnRqg+7+
         fczHlELTCwUaR/vloA6lHpX6PBE4K9FDKVpIYDESU1/5Lsaj69RSV1420NpHd6EwaiWe
         rMB5rKfSm4K1RiehgOtGERb/XFswATeroX1t2OPx//+zEIRWWlbEHVzPZMT8pCGF3Vg1
         Vvcg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=AXLbkXRZ;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=AXLbkXRZ;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZrd3VrVt50PrdLjpR885W9yw81CqcAuGjdS+VmIi7Ui2zrWqhVbTVtlj8zcaQ4/3GJT++96+g==
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/15] powerpc/powernv: move opal console flushing to udbg
Date: Tue,  1 May 2018 00:55:50 +1000
Message-Id: <20180430145558.4308-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430145558.4308-1-npiggin@gmail.com>
References: <20180430145558.4308-1-npiggin@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599183463282479322?=
X-GMAIL-MSGID: =?utf-8?q?1599183463282479322?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

OPAL console writes do not have to synchronously flush firmware /
hardware buffers unless they are going through the udbg path.

Remove the unconditional flushing from opal_put_chars. Flush if
there was no space in the buffer as an optimisation (callers loop
waiting for success in that case). udbg flushing is moved to
udbg_opal_putc.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/powernv/opal.c | 12 +++++++-----
 drivers/tty/hvc/hvc_opal.c            |  5 +++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 0ddb63226695..55d4b1983110 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -400,12 +400,14 @@ int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
 out:
 	spin_unlock_irqrestore(&opal_write_lock, flags);
 
-	/* This is a bit nasty but we need that for the console to
-	 * flush when there aren't any interrupts. We will clean
-	 * things a bit later to limit that to synchronous path
-	 * such as the kernel console and xmon/udbg
+	/* In the -EAGAIN case, callers loop, so we have to flush the console
+	 * here in case they have interrupts off (and we don't want to wait
+	 * for async flushing if we can make immediate progress here). If
+	 * necessary the API could be made entirely non-flushing if the
+	 * callers had a ->flush API to use.
 	 */
-	opal_flush_console(vtermno);
+	if (written == -EAGAIN)
+		opal_flush_console(vtermno);
 
 	return written;
 }
diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index 2ed07ca6389e..af122ad7f06d 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -275,6 +275,11 @@ static void udbg_opal_putc(char c)
 			count = hvc_opal_hvsi_put_chars(termno, &c, 1);
 			break;
 		}
+
+		/* This is needed for the cosole to flush
+		 * when there aren't any interrupts.
+		 */
+		opal_flush_console(termno);
 	} while(count == 0 || count == -EAGAIN);
 }
 
-- 
2.17.0
