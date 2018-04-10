Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+AgBSrqiemi0jixmZmp1+IuT72iAcR5axuSQGkc0NA3amSvy8s9YFS55EJ4WuIHxuKnkH6
ARC-Seal: i=1; a=rsa-sha256; t=1523399254; cv=none;
        d=google.com; s=arc-20160816;
        b=pb3sxyznGUDO/H2SjaL4lUA3ljxpQQW+HksU1RzfOdgtlgbQ6Xj2udlaMoK7LXL5rD
         2t9k5CYD8iIuxRhqRyztT2kMN1f6S+X3Dzr5hMeaJX1Ge2tnIpjjI6jqQZRmBZGSW/6K
         2tCWD9vA0iOr8gdq+YAyWz88pg2m0pFGyJteWfspo9udL+EFuuYfRgroMLdaoV37L9G5
         Nlzfx28YbkTXboXbFOyTUNGnkwUJHSXgfW0l3Y3jRElSylX3s1LJF1gAoUGtG1Q3CkLA
         cms5wndw0BiDmDB3wgPMKU7d68zrDFbHkwtnZ3GCdDv5bKxAhG55Zkchmi1CBwzvtVqG
         y/Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZFqV/FZDeAL2la2l7jm3FnhP4v0WLagaSTQJuYFgnow=;
        b=RnBcYGKnjn8nWZgfJrAdl6e2FWOkMzV+mV2WznrjGLheOotXTK9xZWysLxNYstvuSV
         d0ONo0AAUxM1I/lruQdf+UnjTUuZx1hzEZQ85/Mw4YdyZL1Tl9CNldkLj72VvTf+pSsI
         BWLbuAsc2c2doum6O6T8v9JmYCYZCskoeccmuG8zQy9k+VQH2ZuKGB9txj3cuESLRF3o
         I+IIxU5XQKNKawfCjflgRRdq4kj3Ulxdg1XThbEVVEidJNW+/kaocfoBSH1XzBZz2IMH
         BIau/oRTeJBk60mA5TZxXrN0rJB6WnDC+L1WS95T9ueXbLRgsCPDI6lN22avKJ4Hrv1Q
         yDZA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Stafford Horne <shorne@gmail.com>,
	Wei Yongjun <weiyongjun1@huawei.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 042/168] irqchip/ompic: fix return value check in ompic_of_init()
Date: Wed, 11 Apr 2018 00:23:04 +0200
Message-Id: <20180410212801.998320075@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399896405460783?=
X-GMAIL-MSGID: =?utf-8?q?1597399896405460783?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Yongjun <weiyongjun1@huawei.com>


[ Upstream commit 404e6bea10662f0e142748353169d25378271e49 ]

In case of error, the function ioremap() returns NULL pointer not
ERR_PTR(). The IS_ERR() test in the return value check should be
replaced with NULL test.

Fixes: 9b54470afd83 ("irqchip: add initial support for ompic")
Acked-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/irqchip/irq-ompic.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/irqchip/irq-ompic.c
+++ b/drivers/irqchip/irq-ompic.c
@@ -171,9 +171,9 @@ static int __init ompic_of_init(struct d
 
 	/* Setup the device */
 	ompic_base = ioremap(res.start, resource_size(&res));
-	if (IS_ERR(ompic_base)) {
+	if (!ompic_base) {
 		pr_err("ompic: unable to map registers");
-		return PTR_ERR(ompic_base);
+		return -ENOMEM;
 	}
 
 	irq = irq_of_parse_and_map(node, 0);
