Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZokTGX8qjILVyGFM6r8zyS+K4V0Oa8oPY44JHAn9U26/ThjhJlV/nFbsjJjGOtjkqC1pJ44
ARC-Seal: i=1; a=rsa-sha256; t=1526631558; cv=none;
        d=google.com; s=arc-20160816;
        b=Ovn1bPrDu+5dGRYc34BrYaJCAyqqhoZD23Eo17yGnr1YQjB1UkRLeRC7ff8W4XbIlD
         aInfous7Kzm2DgwalwrGpLWjuVzhiKbKSKfHms7v8BcQgK1V6ZM9/O/xVWhb5YGxZkUw
         GdOEC8A6fJEaT+V0Ru9gXgtLm/JKtyhOcIeY9VmeRtq0DQSFuubdQHe1zDereIFqh3Cc
         X+grN3hjfiOY0QzipYFzVFVqymEYn0TszWcBGwdC5GhQ/1LJ+a4XuUj+tyTraux4/fzk
         7G+U/7GhYq5oy/hy93oWxeSuhZIobjqmiJgKaF641LGvJublH4cjZ0JcoZXTStHVUuvu
         stuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=akVtorD+MC++YIj0MZySHqqIsVaHQBJOEVJvQnH1l1M=;
        b=aBruwoMgFXsrUvnU3H0MtUIF4bTvxowN0cJkz/O9yjcu3ItsJH7LDZauSr+SJb8YEx
         oAtuunS5oh4Mrmn4NOwGmiaTEag6+lSkx+4UdUoZX/rkmujVj5NxSqzAU1IYRjD9rqOI
         jg462yxQtOocKZZcCb4fUKrYNZ3O854w2FpfGN+PnVCVkm84aazN/3ZYANSVsAdQ+4yw
         3Hm5gD+zSIHwIc6USEswte5OOSORrmQ3l2BlEZ7Fe/N295FK78rjGEgCZBxaO2S1bZaZ
         Id5+0EAQ7DZkeT1D+Qyzo4doFv+c7DDHQExzk+HrDAq4qlrmeRPKg1QJ25O7a+KnXMGB
         vIbg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=P4BVAOHV;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=P4BVAOHV;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 01/45] 8139too: Use disable_irq_nosync() in rtl8139_poll_controller()
Date: Fri, 18 May 2018 10:15:18 +0200
Message-Id: <20180518081530.397151033@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
References: <20180518081530.331586165@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789055660573430?=
X-GMAIL-MSGID: =?utf-8?q?1600789212690050301?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2224,7 +2224,7 @@ static void rtl8139_poll_controller(stru
 	struct rtl8139_private *tp = netdev_priv(dev);
 	const int irq = tp->pci_dev->irq;
 
-	disable_irq(irq);
+	disable_irq_nosync(irq);
 	rtl8139_interrupt(irq, dev);
 	enable_irq(irq);
 }
