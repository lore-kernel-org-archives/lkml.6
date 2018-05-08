Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr2F8sYqTs4dlA2zj/TeDbOlcB95CUfWWT8CeW5Atw5h3r985elkXSv9IX12Ft2aOqF+mcF
ARC-Seal: i=1; a=rsa-sha256; t=1525767402; cv=none;
        d=google.com; s=arc-20160816;
        b=l+Bjnx65mXTuRp6iWSsCk0iTzfi51dBx2gMpqHOryN7dF2bS5H38HZ3/WJ9wfUf3QX
         tftqdiBTOIdK1R8NNiA8CD1fdidosXRg0l0wJ2Jb9um0mFU21lbIey5MtFo8NCCTTRsG
         nX/LK1L2tyE/0iQJcaA0wBHuGuclJDhOsRGruMaPzSzL9zIQ74uM6H7YxZQYfjP1pkSi
         XjhatGA+nJCc6ZyYGlffhxdSYVKF6fUNJn+cFEWHSc2kfFxplr1izTp7qiHhEzxAV6HI
         mMxGHxHs7hO4RoUJXiPw1X6vJSsg4ZWzZpy5GZIGDWIkhtsWkIp9DEUvhwH+8PBrNTiy
         jeeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=4DqL/19u6lijOtNjcu7EhApKWZ46WBLvKbYMCxf8WUI=;
        b=J/2yXUPpjHq4iA/RdvNzuKk0f5arOups57VxDc/uTtzPaKgx2rCrGyeU78hq84rFKd
         SgHqKXsvsMkfBkuEaZ/4s9tch0AUv3irsBEOt5mklo8liufcq5xEBVPpDYbGsGn9iA8h
         Yd+BGkB/M+baf2BK0c8NcOIeYslPz0ltIu/0C6On4l1GzMsDVpDfr+AcSVGXoohtd6NI
         xvCnWJrgqrFCS/Z5c93WutEOz2oZfAEw75MUKP+jQMvbXrIP45qvpYboVmmSez1WuAtC
         pNqxiWO6FVei0PmJo41KbEcQwxOmb/UXKT/a1/UHULNGybLBuLIeyq2JPAfbWu0ShxrK
         wXww==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=I2lit0qa;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=I2lit0qa;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	=?UTF-8?q?Mika=20Penttil=C3=A4?= <mika.penttila@nextfour.com>,
	Steve Twiss <stwiss.opensource@diasemi.com>,
	Chris Ruehl <chris.ruehl@gtsys.com.hk>
Subject: [PATCH 4.9 06/32] serial: imx: ensure UCR3 and UFCR are setup correctly
Date: Tue,  8 May 2018 10:10:46 +0200
Message-Id: <20180508074009.804763110@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074008.800421598@linuxfoundation.org>
References: <20180508074008.800421598@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599883080080190252?=
X-GMAIL-MSGID: =?utf-8?q?1599883080080190252?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

commit 6df765dca378bddf994cfd2044acafa501bd800f upstream.

Commit e61c38d85b73 ("serial: imx: setup DCEDTE early and ensure DCD and
RI irqs to be off") has a flaw: While UCR3 and UFCR were modified using
read-modify-write before it switched to write register values
independent of the previous state. That's a good idea in principle (and
that's why I did it) but needs more care.

This patch reinstates read-modify-write for UFCR and for UCR3 ensures
that RXDMUXSEL and ADNIMP are set for post imx1.

Fixes: e61c38d85b73 ("serial: imx: setup DCEDTE early and ensure DCD and RI irqs to be off")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Mika Penttilä <mika.penttila@nextfour.com>
Tested-by: Mika Penttilä <mika.penttila@nextfour.com>
Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
Tested-by: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Chris Ruehl <chris.ruehl@gtsys.com.hk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/imx.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2145,7 +2145,9 @@ static int serial_imx_probe(struct platf
 		 * and DCD (when they are outputs) or enables the respective
 		 * irqs. So set this bit early, i.e. before requesting irqs.
 		 */
-		writel(UFCR_DCEDTE, sport->port.membase + UFCR);
+		reg = readl(sport->port.membase + UFCR);
+		if (!(reg & UFCR_DCEDTE))
+			writel(reg | UFCR_DCEDTE, sport->port.membase + UFCR);
 
 		/*
 		 * Disable UCR3_RI and UCR3_DCD irqs. They are also not
@@ -2156,7 +2158,15 @@ static int serial_imx_probe(struct platf
 		       sport->port.membase + UCR3);
 
 	} else {
-		writel(0, sport->port.membase + UFCR);
+		unsigned long ucr3 = UCR3_DSR;
+
+		reg = readl(sport->port.membase + UFCR);
+		if (reg & UFCR_DCEDTE)
+			writel(reg & ~UFCR_DCEDTE, sport->port.membase + UFCR);
+
+		if (!is_imx1_uart(sport))
+			ucr3 |= IMX21_UCR3_RXDMUXSEL | UCR3_ADNIMP;
+		writel(ucr3, sport->port.membase + UCR3);
 	}
 
 	clk_disable_unprepare(sport->clk_ipg);
