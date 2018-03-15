Return-Path: <kernel-hardening-return-12637-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELubDDJ5vPmq28QGmMGBVpdpDQZwjY/gnstTGyiEYz9j43I8kmKJhC3zgPUePibgEXrN36VV
ARC-Seal: i=1; a=rsa-sha256; t=1521136906; cv=none;
        d=google.com; s=arc-20160816;
        b=uEkJVUVKgYVV7zhlqa1GCah8mMJtlTxwpwA06qlrRiR1pXtURAS72b0/TTxm1bpv94
         xKTWX1kv7U3QXV7vhJL0X7G2gv4orYbtX9AGlJ7ZdJZYjz/UZ3JN5ENkXKnW68AJEsEC
         ltsSgpF3vkbOG3tv4AEpmJdra06UYfeYanI/JWZ/tCSdux4X/Bfhkt9JLtXxy2o1+M2+
         R19YsuC0qYWNHww0L5cvD7Pqq0Mkg40qM90NTVvArjA6jpSJ2U6F8Ouhd7Pp/eaLnVxb
         +nryzoOzOcwP9v7aN4ZEWtBEcmT3qyQ3ORfD0OaRrHsJ1uD67fSoDGAMSQQ/TaWF0gn8
         VHyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=BogRfGPOdj8BNG2vMq34fZkUxMAfVJNs4hyWBbuR5qg=;
        b=eYF3VZi9l6OAr6W6OxylTVn3EiRp9Nu7nT7wt5O0yOAw0OFeSC9liMI9P5oSVXVcLX
         C/XhbEOOqz7BLu+D+w58q49wv353eDmyd0w4Df4PS4GuHYibj2RyL9+w9gV2IDIkbsPO
         xIslLoTqGeP0k+9psHQQ1uKIQoUzdI0GJb7KCNFptwNkJc73DDCdYHN6FrwTYOVTED7/
         USzsmrJLP3wsDAQvuFgoopwHNUQ2t8mrcWDDou2EmkSufupxLKa4tdyQn21PeAo0ave6
         17zufK7ojAj9Z4Z8m5JJSjzCow6gQV2MFRGzFZNucww/FAQeWhQsr+SEmqTvPbDy0vbh
         1hQw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12637-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12637-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12637-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12637-gregkh=linuxfoundation.org@lists.openwall.com;
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
Subject: [PATCHv2 4/4] gpio: Remove VLA from stmpe driver
Date: Thu, 15 Mar 2018 11:00:30 -0700
Message-Id: <20180315180030.20001-5-labbott@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180315180030.20001-1-labbott@redhat.com>
References: <20180315180030.20001-1-labbott@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595027652990122948?=
X-GMAIL-MSGID: =?utf-8?q?1595027652990122948?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The new challenge is to remove VLAs from the kernel
(see https://lkml.org/lkml/2018/3/7/621)

This patch replaces a VLA with an appropriate call to kmalloc_array.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v2: Switch to GFP_KERNEL. There was some discussion about if we should
be doing the allocation at all but given a) the allocation is pretty
small and b) we can possibly take a mutex in a called function I think
this is fine.
---
 drivers/gpio/gpio-stmpe.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-stmpe.c b/drivers/gpio/gpio-stmpe.c
index f8d7d1cd8488..c2bb20ace6f5 100644
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
 
+	status = kmalloc_array(num_banks, sizeof(*status), GFP_KERNEL);
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
