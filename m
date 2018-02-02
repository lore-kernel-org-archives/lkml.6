Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226vZTx/lxz8aNzCT4bszN/A5Qs8Z26fqBtatG9xzapPHXoD5ZPFmxw6+xeZalmWWhaZDgDi
ARC-Seal: i=1; a=rsa-sha256; t=1517591824; cv=none;
        d=google.com; s=arc-20160816;
        b=SmUebSqR3sf+f2KcCvxDS/RWTZWTZmE92WQwu319ri8l1PvE13z1VbxDBQO2Afkmkb
         V8sjM0yCHs2O2JrpLC6Wn24nRS7lqyzygiXThzhyo9yARkn48I0p9+20F5rTo0fzmQYo
         Sbwx6kTr3htc27Pg45BLDmM6iNOfSearp97+4LVJUPS7o4ONz/EAzGZ+Vmkok6adBlG+
         Sd2tS3wGxA5PwZZLzm0JPFC/m1AT+/4pGSJk0hhr0Yadq6O43DJMwCqcOt+F/IiDtnzx
         P1PQRZrVyNIq50MB/YE9NPhuMH64NIzZ3UWzv3hTOWlTUcZw3eT/geyf/CSr3RzytyOH
         AeVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=u/RqF+9/Ftbnf9RJAzesXa/TMUNjEBYt+SQ3t67KmUE=;
        b=sFIxwcTGbgXSN1EMg6RjdWfyyB9UZIwrrsOO3tWzbjkGPyutSbhqeafHkUdGpJgcl5
         GapV5aVdYbiHx9u2CjxVmEsN8s/tE8LDm8Ffrz5liiMo4Na787uF9s2JjjIvWLswOJqG
         arGsrJeZuVtmdmzk8u2Ixrq0Sd+VWnU2ZzBvHiDkvi9ARV5ZiAZkDGrGEhlwvsC8D/wR
         eybvNHWfgBt4zlaQOuON02p6a3Os4bnu0mEIRX6sL5ZRbwW+cUNUoOWhOZoo2XKiLJov
         AIFsiDfz+E/wHqvxvgkB+qSwtmT5J2y3cZXfTWOcxW8sxi/9JSkbbd9sMTBaj98dJZGL
         SC5A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Martin Kaiser <martin@kaiser.cx>,
	Fugang Duan <fugang.duan@nxp.com>
Subject: [PATCH 4.15 48/55] serial: imx: Only wakeup via RTSDEN bit if the system has RTS/CTS
Date: Fri,  2 Feb 2018 17:59:06 +0100
Message-Id: <20180202140830.749103783@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309461447387498?=
X-GMAIL-MSGID: =?utf-8?q?1591310364575549821?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabio Estevam <fabio.estevam@nxp.com>

commit 38b1f0fb42f772b8c9aac53593883a18ff5eb9d7 upstream.

The wakeup mechanism via RTSDEN bit relies on the system using the RTS/CTS
lines, so only allow such wakeup method when the system actually has
RTS/CTS support.

Fixes: bc85734b126f ("serial: imx: allow waking up on RTSD")
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Reviewed-by: Martin Kaiser <martin@kaiser.cx>
Acked-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/imx.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2238,12 +2238,14 @@ static void serial_imx_enable_wakeup(str
 		val &= ~UCR3_AWAKEN;
 	writel(val, sport->port.membase + UCR3);
 
-	val = readl(sport->port.membase + UCR1);
-	if (on)
-		val |= UCR1_RTSDEN;
-	else
-		val &= ~UCR1_RTSDEN;
-	writel(val, sport->port.membase + UCR1);
+	if (sport->have_rtscts) {
+		val = readl(sport->port.membase + UCR1);
+		if (on)
+			val |= UCR1_RTSDEN;
+		else
+			val &= ~UCR1_RTSDEN;
+		writel(val, sport->port.membase + UCR1);
+	}
 }
 
 static int imx_serial_port_suspend_noirq(struct device *dev)
