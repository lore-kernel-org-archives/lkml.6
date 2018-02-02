Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225izOx9Drrnh7w28KnHMgj9DLPOJ6bI33Qq5tK6zfqekoK3E/o/SpRwi85/AXHV2atPVeH6
ARC-Seal: i=1; a=rsa-sha256; t=1517591220; cv=none;
        d=google.com; s=arc-20160816;
        b=chiQM6EDKuyOMWg53bNh58aY6+NEhYLOWiCEtR6CMoKUkcDRFWXO3acgYhkhWXJGUR
         qlMqhSO6DkUFZ8+Q2XXeGgVVUMBlGlU5dkzXk+7sxqVJlMu790NePvJbEPDqxCu8J06b
         HBd73MZxEUc8n9nRKUgS3serdVodv62WUI/liGJUVrH66C0aDhEjaQGPXbISkRChO3Ml
         p6HWGGBmItOPFkMofbopFZP42VCxKRMyKP4KP6pPKTuh1xrvP7mtEEgappr2/U+/Oxb8
         Qsuv/ib2LqtFAk+WUAnzUXmbOvH9bSEbTy9attB7SvHbApjSIP304W3Ml8qIQBIsr827
         ve1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EMHZ1GlxNb/ezDwehqG7C5QpgmQZ6sRCXAqflso7T2w=;
        b=S5RnlmKigxN4AsIl9bLlmDdgoulL3dJ/Cg6PQxwFpfQ5evP2v+/xBKUn7/QwfYG3to
         7sRqRJF0I+iHTuAJg3YH55//sTSygTclRLcG0fhxzDugp63gSut35ejjEtjhtQgBZNTg
         /7E2qhR3ucECf2lk/A8r1opQVLoUc94KoEIQiPYFyv5HbLklg+ecs6cezAbluVcbyVC2
         DMzhRBnsm0QRxLILLUT8kOuVLjnsEnlQmfCWlLZWSX0TFU8Ai8sFP2LB+eTcYMQYOCdN
         ZFnsg6bcdB8woXqbF4vLbLtvLvtlbH0fN2D5Qov8sGOun4ek+za4+J3SoUg4GE3DJepv
         HhZg==
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
Subject: [PATCH 4.9 85/86] serial: imx: Only wakeup via RTSDEN bit if the system has RTS/CTS
Date: Fri,  2 Feb 2018 17:58:45 +0100
Message-Id: <20180202140830.562797872@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309461447387498?=
X-GMAIL-MSGID: =?utf-8?q?1591309731755310285?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2239,12 +2239,14 @@ static void serial_imx_enable_wakeup(str
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
