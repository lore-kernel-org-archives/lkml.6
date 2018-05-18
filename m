Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqj84mxnLnE67wRe7H1g/O0emEEdi9rd2qKObHqyVk+uNaC8/lvucWWnZ7L4buEo8vO/eex
ARC-Seal: i=1; a=rsa-sha256; t=1526631680; cv=none;
        d=google.com; s=arc-20160816;
        b=S6zJUVrkcGtukFWYyBHPvgt/gAbgntbQFRSlBnPFsdN9nclYPUdXrsonmrpIQQ1iRk
         S1ghM9rzqgM0I2+NL23Q5u+4CDkA/RMcIfneqEf0j9iQ9fZcsib7z2lF4SKnYQ12vJPZ
         TUIKGzgvk8rDSkS3l3sdBFGoxuQbZAigkOtgqKr1jE3H7Ha3kUWF1l8Z7sIz8MLgEdVp
         Jya97ABwbSuBrUY8QxLnh9v7GuTIPEenqQ1y9xLp0FBx7bcckadLnYNQMlXRnC13g2NV
         iLgIgeQfZwiRh4b66Aacdz+kjsDEiC9dRWQHCp/MNXZ8i/f/g0XvScEcnQA04kBGi35Q
         8cgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=3jFvtrzdlajHPwEYcKwPzIse4DtnvjeFoQ+NYeEjDa0=;
        b=OOQSO0gMkiFs6M6XQa8HbbACrbim/nbuCXQDvuimq40K+xgyOEDHQ4UCWudQqkABPE
         Zyq4Z0feNrQ4WhRO48Fm0vtk4PDT1IYjeT+Rbib3lIAtPt8lf0J05PiCzVsMOHLaa1f4
         Ds0kQf39Nw58AXHAMn9pp2goGVicSZ/GFrptheNoLxtFCfnLEM5Aamlf9ZHUxwq1g8lf
         TeTnbtgtNThoSFbsY87ACJdsX2BYtfs2xGolRZL+Y0qHdD93cEtn3aTprJ6rvIJrQ6je
         leImetnuTFFiFU4xgZZ9YZebpTPLcaP6ZJRFNgT0q+HThOz3L+YU7kCKTxlrlMKR0DHE
         KVxQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=2hljzX19;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=2hljzX19;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 01/33] 8139too: Use disable_irq_nosync() in rtl8139_poll_controller()
Date: Fri, 18 May 2018 10:15:40 +0200
Message-Id: <20180518081535.162711959@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081535.096308218@linuxfoundation.org>
References: <20180518081535.096308218@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789055660573430?=
X-GMAIL-MSGID: =?utf-8?q?1600789341346770548?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ingo Molnar <mingo@elte.hu>

[ Upstream commit af3e0fcf78879f718c5f73df0814951bd7057d34 ]

Use disable_irq_nosync() instead of disable_irq() as this might be
called in atomic context with netpoll.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/8139too.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/realtek/8139too.c
+++ b/drivers/net/ethernet/realtek/8139too.c
@@ -2233,7 +2233,7 @@ static void rtl8139_poll_controller(stru
 	struct rtl8139_private *tp = netdev_priv(dev);
 	const int irq = tp->pci_dev->irq;
 
-	disable_irq(irq);
+	disable_irq_nosync(irq);
 	rtl8139_interrupt(irq, dev);
 	enable_irq(irq);
 }
