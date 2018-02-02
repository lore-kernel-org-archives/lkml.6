Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225iVZe8/M3FIoOX3X33dlLFavvOVql+m3hY2W//IKiXIHnNQlIdcWk6c5PFCuSdNMFyiV7J
ARC-Seal: i=1; a=rsa-sha256; t=1517591796; cv=none;
        d=google.com; s=arc-20160816;
        b=Tn7DoRRf3UUNwJSBuZWTYyk6tA6HFiVk2E2y1BvPUaUXyqJgvqvokxN9mW6pMfcXGN
         PThk9NuhiBWz1mTZM71qMAyFrcxkQUBBw4mr3+5BM479Kca0pfE62+QbF+or7GgVd5WP
         CwQiOvSSd3NKtt+xKNP1wPrfXAfebaxvwC2qy7prZ1MhaBf/7RDuajQY7M2hq5SlvDKu
         TxyyHzmNC+oYKCUsyaF1VyJBXid3R796LOsongkZzXuNRTg7YqJZW+SZVmoDdQ+vNsLO
         iY0nsxf4iyKHDauzVk4IJGcXha8W9edVzrqUwQmiQ+izgOX/8G5ztiJkhz0DjxrgZGM7
         FTgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/6qxaZ347Ycl5u2lgRZkNfOSdQxWgENSEhd9ot2stAQ=;
        b=BRDqEd7UcwbC8khbjJddLuLI6pWYpdp1VXvgrLwAXlqZW4nAFqfnym10v1/U6KvKd1
         iK2llPBxt2ppEgXyJxi1r7d7JrY5xfORJj9WFGbxuwRs8KaHh27qoeeDJe4ejTlIjlPj
         RHNYwz9psX2AuLLfRL7qU1OhmQPi0krDnknV1WOyw+FZQDfx9Q2yg0eKqLUlQJmfc2Fd
         GJ6PyOO5uVuknr960H7nPbEteHRYKRAlTF6gfuD47gjKmm8uHWcuxnRN87X1+IRfKRRI
         3DHJsy3pYSucMbCIjncVEHUZpwCpkqes1hY/tQUIwHEh9SX4e9FYOH5sDsQpH/onozvs
         Jttw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Wei Yongjun <weiyongjun1@huawei.com>,
	Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 4.15 46/55] serial: 8250_uniphier: fix error return code in uniphier_uart_probe()
Date: Fri,  2 Feb 2018 17:59:04 +0100
Message-Id: <20180202140830.565054318@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591310185216144895?=
X-GMAIL-MSGID: =?utf-8?q?1591310335834251567?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Yongjun <weiyongjun1@huawei.com>

commit 7defa77d2baca4d6eb85234f10f38ab618332e75 upstream.

Fix to return a negative error code from the port register error
handling case instead of 0, as done elsewhere in this function.

Fixes: 39be40ce066d ("serial: 8250_uniphier: fix serial port index in private data")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/8250/8250_uniphier.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -250,12 +250,13 @@ static int uniphier_uart_probe(struct pl
 	up.dl_read = uniphier_serial_dl_read;
 	up.dl_write = uniphier_serial_dl_write;
 
-	priv->line = serial8250_register_8250_port(&up);
-	if (priv->line < 0) {
+	ret = serial8250_register_8250_port(&up);
+	if (ret < 0) {
 		dev_err(dev, "failed to register 8250 port\n");
 		clk_disable_unprepare(priv->clk);
 		return ret;
 	}
+	priv->line = ret;
 
 	platform_set_drvdata(pdev, priv);
 
