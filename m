Return-Path: <kernel-hardening-return-12353-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuzvjX0DlsxNeJuW+aJrujcmcgSmiopux+EesYmjNo+Vm33F6ZFNy2dCV6AAGHaP4cVC0oP
ARC-Seal: i=1; a=rsa-sha256; t=1520640684; cv=none;
        d=google.com; s=arc-20160816;
        b=0IFlAWvGmGFmpu25nHdU6RFsWAItUVmqxuj/Ay6TjaVMMgJdOvwYkruRp6+z7cWwDR
         cBANTWJM+5CAjmFOd15Aw9+iRTJiaFRb9RXC1umAL5YLJwLr6y8zSlyWVLGxIEZJL92U
         EPVTjoIrpSwFtttyq6N3jVqBtACMzMOuztmLcGmn5ZUjjbJumriCY+OrlARl9SRz6cnX
         3l5axootjnxGVxjzChrh2Wyiu6jNMRneUlUkIu/jlBRx+gIqO9y8B5xV3mm5+ixWWZVK
         aGlBB9BHjLEvbA+fE6zvfs+l2Q29Qofn3r9eHE5/apODiZB+Ug9JRPyvgxovOvdETBVb
         PsVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=Kjh2dRWQC3XfvJzP9sKUndnJx1a6KsrfaacoJ+FnTYk=;
        b=dElgy9POaXWtuBturRN32lus+/X7pXKIiwMa8bdnArbeKGHWiI7AZZ/K6B+rN3Byum
         Hqfv+uXtGNd50b9CRtTR66C/rv10qmU/nDFY1QpTcXbVOY+C6Sa5DWaSaX4RBS5LnEPX
         yoymWo7UYRIpZo21vHOBwDJWAYB3fSjsByEJxFFLDIvBbT1Q2YhKz92sMkeWsWXioezN
         fHJPmMp/P/9DT8o5R5QWFwSe+DaUL0ITSKVYh9GzgNixPW1R5O++jyT5GNlZfviaSBHA
         Bpe2/Y4tb3PUZDCVvifLOAsyD8ZTWzc/1Q+ce+zvirczltqus9A6mELmJsoOP/QFybCn
         jV/A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12353-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12353-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12353-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12353-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Laura Abbott <labbott@redhat.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	Patrice Chotard <patrice.chotard@st.com>
Cc: Laura Abbott <labbott@redhat.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: [PATCH 4/4] gpio: Remove VLA from stmpe driver
Date: Fri,  9 Mar 2018 16:10:21 -0800
Message-Id: <20180310001021.6437-5-labbott@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180310001021.6437-1-labbott@redhat.com>
References: <20180310001021.6437-1-labbott@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594507326034109383?=
X-GMAIL-MSGID: =?utf-8?q?1594507326034109383?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The new challenge is to remove VLAs from the kernel
(see https://lkml.org/lkml/2018/3/7/621)

This patch replaces a VLA with an appropriate call to kmalloc_array.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 drivers/gpio/gpio-stmpe.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-stmpe.c b/drivers/gpio/gpio-stmpe.c
index f8d7d1cd8488..b7854850bcdb 100644
--- a/drivers/gpio/gpio-stmpe.c
+++ b/drivers/gpio/gpio-stmpe.c
@@ -369,10 +369,14 @@ static irqreturn_t stmpe_gpio_irq(int irq, void *dev)
 	struct stmpe *stmpe = stmpe_gpio->stmpe;
 	u8 statmsbreg;
 	int num_banks = DIV_ROUND_UP(stmpe->num_gpios, 8);
-	u8 status[num_banks];
+	u8 *status;
 	int ret;
 	int i;
 
+	status = kmalloc_array(num_banks, sizeof(*status), GFP_ATOMIC);
+	if (!status)
+		return IRQ_NONE;
+
 	/*
 	 * the stmpe_block_read() call below, imposes to set statmsbreg
 	 * with the register located at the lowest address. As STMPE1600
@@ -424,6 +428,7 @@ static irqreturn_t stmpe_gpio_irq(int irq, void *dev)
 		}
 	}
 
+	kfree(status);
 	return IRQ_HANDLED;
 }
 
-- 
2.14.3
