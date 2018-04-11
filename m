Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/Veux1+fz/HlzYGzbbh7tv34bPrFBEKkJgTlaZJ4CGJRvGOPIbP2fsLVKWG4du8poqgeBe
ARC-Seal: i=1; a=rsa-sha256; t=1523473030; cv=none;
        d=google.com; s=arc-20160816;
        b=l7tUBZVH+EoCHsJVI0dH5TFTVqjrnw3G2UfzTPnrfEphg0lbOWIZ7/CdQ7i4oR4GF8
         JmlPT5Uz8gGe6L3RyX9raAa5MQrT+APLX1dyDlIFuvQ/ck3OOdD/+CP8wg5ScKEgIa3i
         vY7x1D6qXDiLvl20gYjN/Guiw7EadTE6t5wdjYAenzmJblxOvleX26F58BNjFP/rF0sW
         7KELG/QScm/p6JlhS3URl4j5LGkYJj6MS2BhVLy5fRRE8lh+bltY5ZJ4LvCQPZeJ19OD
         gJ3KLZ4UOtjNRKT5a6F0HMoJfRtjF3/iy7Lj7VeH84+CjiRCRE2Ru5BrDeQFkzKq5+GK
         KAfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FPpPRgCjSq/SDeQCy8WK/rfpshgdGdW2d/xZVGnm5p0=;
        b=lzaKB5gxTkxkHebdMDGQuflp4R6ykD4h+B5J1Howh8+EHpms9pplOXh/p6TaDrd1X4
         yOrzKfvu/rKirmcffrIUdbdpe/NHw56Ng0IlUYduL8iQKvCDfIP7mI5x3FgeANzsEYI8
         oeZP/1wCy2Qex95BB6FQQgOygMz5t9DxzRlS0OFjqRk4sseGCy+s9Sw5od/0LSC5arXK
         gB/3HfqakwdiKnakDc6b/iPokELibpt5lGVPBzq6wOd5MfYO2MO9ajqpstHgj4BX6F2P
         e8Mph/mlZ9pAUOiKbGpToZZ5gjWTAFvKNHzqFDniXxO8roLpvtjM9MMyuc8Wt/S1STgu
         JjmA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Vignesh R <vigneshr@ti.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 070/310] serial: 8250: omap: Disable DMA for console UART
Date: Wed, 11 Apr 2018 20:33:29 +0200
Message-Id: <20180411183625.327950621@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476520967202245?=
X-GMAIL-MSGID: =?utf-8?q?1597477256679193758?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vignesh R <vigneshr@ti.com>


[ Upstream commit 84b40e3b57eef1417479c00490dd4c9f6e5ffdbc ]

Kernel always writes log messages to console via
serial8250_console_write()->serial8250_console_putchar() which directly
accesses UART_TX register _without_ using DMA.

But, if other processes like systemd using same UART port, then these
writes are handled by a different code flow using 8250_omap driver where
there is provision to use DMA.

It seems that it is possible that both DMA and CPU might simultaneously
put data to UART FIFO and lead to potential loss of data due to FIFO
overflow and weird data corruption. This happens when both kernel
console and userspace tries to write simultaneously to the same UART
port. Therefore, disable DMA on kernel console port to avoid potential
race between CPU and DMA.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_omap.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -613,6 +613,10 @@ static int omap_8250_startup(struct uart
 	up->lsr_saved_flags = 0;
 	up->msr_saved_flags = 0;
 
+	/* Disable DMA for console UART */
+	if (uart_console(port))
+		up->dma = NULL;
+
 	if (up->dma) {
 		ret = serial8250_request_dma(up);
 		if (ret) {
