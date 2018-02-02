Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2248WXq7WzkM/oEFURUuo/blXyCfirPE1QUQChYQmTChBZcVv+NACsjiWvX++9UEFLNj72Kx
ARC-Seal: i=1; a=rsa-sha256; t=1517591653; cv=none;
        d=google.com; s=arc-20160816;
        b=0bvY86hAC44MZFCUvCdRP+TB8ytk1BZvjsY9URjNOdPNGl/QyvOCJaDkwdXQI+sBSa
         XzrN56JWcgB8dxu8U7+WZ18tQ+6WuwpAwPo9Td3XnfxsZDPrFfLZ9v2xBa6Vs4E2AgoQ
         pd/Z2OgL6daayUxvYlJMxfDNfnmg5fAOEWl7GLZD7cd2237xQALmHFbwFa3hF1ol9f+M
         tBvJCBxEKDqeubPNsofDEW3K1RfsaLkcoR8ChZxl1wODEZBWB0lOtuCC+QPOhx72Y2Z5
         rqD8OoPXpEcp3eqL207G+umMMIB65lRkOO/OslwMkr1Q+kS5Nlcd2KUxXVm+r7hMg2ME
         YDBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=m8YzTU0b6I/Q9SLgB1KK+QVv3wFUfAjm7u9q6FdRk4g=;
        b=t6UdOGdRuxKY5kcAbz0OljC/bAXQTRYZyFsPscOyV6qxbqnJqghtdgFrlvuM015Kgg
         AzY4BnraJydhbU6J3jwDXw88VoeMsqhCd+BIcdIuijXuiMeFXDSMn95EA+iVchuLCoZv
         KA7ya1/wjvkLDlUK7qez1W+VPKzSDl7jybtE6+nQJRnQh2gH7lfNkuTFXaWz/TqcAtC5
         Tta3nwfW//chwADIaUbkV1vSsOnJMGMonnSNBepohtymOx+RUh+Qlijctw1OhHx33XrK
         8R+IK8CF/dfPkaA0YhxPwVC909bbopEetsV0h9UyEYkXmWIXYzxHz6I49W7WrR6ZD/AW
         GQTg==
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
Subject: [PATCH 4.14 148/156] serial: 8250_uniphier: fix error return code in uniphier_uart_probe()
Date: Fri,  2 Feb 2018 17:58:49 +0100
Message-Id: <20180202140847.061624606@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591310185216144895?=
X-GMAIL-MSGID: =?utf-8?q?1591310185216144895?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -259,12 +259,13 @@ static int uniphier_uart_probe(struct pl
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
 
