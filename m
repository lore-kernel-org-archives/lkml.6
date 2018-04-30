Return-Path: <npiggin@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525100184; cv=none;
        d=google.com; s=arc-20160816;
        b=fPUFR+fu2YiTAGn2U4n2PcNirSjMtb8xSYTZp2sbiHMGhfqTOSifsy3GxYPIku34yp
         VZaJ50fHR1j7N+AV139WH56+WQWn1kwbc7Yw5VegxtbENOSJe2yMEwPW4M+xJUgUxX/F
         qoDwMuOT3satekm0ffKqY9oQYokTlMUgkA+cOwX6yjVyWioZvCiBJ/HhREzNd82v3cZc
         MBEaHW+DbOMw4lhKNA26Ta/vDy0a0N7N0DvnJpOHGsWxrzcBPTgv6u7PJ6ZnkMMepjZK
         b4KE4m34gIwBg8yVLnDzacP9bEfG6sfC6l6g5Ub8d3qZhRdAb26vqaHWTVLOcfTzpGQi
         wH0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=gKi6xnv7EUWhskjW3Xqh2A/mZDswLun3Bgs43yLefco=;
        b=Z7ommmSEPZu2HYGPVSwbrOHMvVV/kY7yNKdU8xXYjjAHxoNgwn87YWaZPKjZhamJ9o
         mRQKqbfIsoY2grzedOxSDkzsdsEfaAKumAMMoOIZtyP+WbnK1kPgd++GerED3qKhRekr
         LFzH0E1LARDRTf/KtKWuBWDvTCOw/VC0i5A8WTJ+rELPmfQzCYMtsmalgMtIM0lZm4pe
         h8ceGUwNUz4/JDnQdk/eNzf38+3qS01Tbksyb8cH7yFrhAfJhKX2ZcUXpRLzgfo8Ysma
         QbS2dPvGmYtynzJ/TfBR4nFwP7QA3PK3btr/0ffSpf9Z0WdVItd9NJsFektr0passo45
         rM7A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=jLI4pqdL;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=jLI4pqdL;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZoqhqtZ+qCcvCFxOe06MP+RczFpYuWdXL2VrNvuTnPRDDoG4MNrg7lB+xa05TNH0k9yJWsYhw==
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/15] powerpc/powernv: opal-kmsg use flush fallback from console code
Date: Tue,  1 May 2018 00:55:47 +1000
Message-Id: <20180430145558.4308-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430145558.4308-1-npiggin@gmail.com>
References: <20180430145558.4308-1-npiggin@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599183451122520462?=
X-GMAIL-MSGID: =?utf-8?q?1599183451122520462?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use the more refined and tested event polling loop from opal_put_chars
as the fallback console flush in the opal-kmsg path. This loop is used
by the console driver today, whereas the opal-kmsg fallback is not
likely to have been used for years.

Use WARN_ONCE rather than a printk when the fallback is invoked to
prepare for moving the console flush into a common function.

Reviewed-by: Russell Currey <ruscur@russell.cc>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/powernv/opal-kmsg.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-kmsg.c b/arch/powerpc/platforms/powernv/opal-kmsg.c
index f8f41ccce75f..fd2bbf4fd6dc 100644
--- a/arch/powerpc/platforms/powernv/opal-kmsg.c
+++ b/arch/powerpc/platforms/powernv/opal-kmsg.c
@@ -51,20 +51,17 @@ static void force_opal_console_flush(struct kmsg_dumper *dumper,
 		} while (rc == OPAL_PARTIAL); /* More to flush */
 
 	} else {
-		int i;
+		__be64 evt;
 
+		WARN_ONCE(1, "opal: OPAL_CONSOLE_FLUSH missing.\n");
 		/*
 		 * If OPAL_CONSOLE_FLUSH is not implemented in the firmware,
 		 * the console can still be flushed by calling the polling
-		 * function enough times to flush the buffer.  We don't know
-		 * how much output still needs to be flushed, but we can be
-		 * generous since the kernel is in panic and doesn't need
-		 * to do much else.
+		 * function while it has OPAL_EVENT_CONSOLE_OUTPUT events.
 		 */
-		printk(KERN_NOTICE "opal: OPAL_CONSOLE_FLUSH missing.\n");
-		for (i = 0; i < 1024; i++) {
-			opal_poll_events(NULL);
-		}
+		do {
+			opal_poll_events(&evt);
+		} while (be64_to_cpu(evt) & OPAL_EVENT_CONSOLE_OUTPUT);
 	}
 }
 
-- 
2.17.0
