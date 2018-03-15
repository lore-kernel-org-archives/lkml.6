Return-Path: <kernel-hardening-return-12636-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtOEhpYlYq/AG1mn/dJhkvc7mnY+ka3m99GItaOhRYzLQN1ne5e1HcdfZwGgngMplkeFsoW
ARC-Seal: i=1; a=rsa-sha256; t=1521136896; cv=none;
        d=google.com; s=arc-20160816;
        b=EgHjuAt6BEb8OsXkbzIt+sII94B1oXY+b07ZGqj8eFKf3Ru8VgLByIPWo4XIMqDL/N
         lc5unNNtiA/S9CQ7aG5K/fTiQAHWtjiea7gJcpMcRI03e0i9bRdFK41Fz9p/aXXlT2vm
         8+wrXHioIyvICoDgccd76xCyjX3BbAaXCBods9ZGJDAlTJT8eOMArqa/85I9CfFzR4k8
         QJmbb1UL3a0mQc7tgK0qQ7DYndWpYsfOKMwpzqrJkCwt5g/dJWMAajEol1v7QWlK8I84
         lEHSN4WOE+o9Ge5MRvqKD4VMSf87bWinJW7hSorXSOFVWqCd6J4feLjh0/lzYJsKUQQa
         BTGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=OJRRUYXa2nf7MtQGjeAPzjgvCAFxixxF/zHKjjjHHig=;
        b=js4MAQInGXyarwTu0MEd9EI0caprdYTrw9bdnVW1VSVVfufcr5aA68Al9wqixYtSep
         ywXBamdn1AfC2+1znSx9TJQ0U/RCobiwsVhIzVXHEOHRJGRQeBF3tWRgoD9Pr2ijy997
         /Lxgol6+uE/WCJSW9+XTmib8Kh6zYrOWs2rDfBbtBzaBaisXztrxEoegfRf2fW8IoSoP
         Pft157YAFSdkd0jWjE0QYKYrzdTl31fPUkxlCLY0jDAtPkq7NebCYq6cAGoJoBPNzGBv
         2h9IPcph9T+yVjOVwHcNbOecdR6lFGFn3YI6Hxihb1jQBxdWjNMq9eQx8IyNyAm1migv
         Vlfg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12636-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12636-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12636-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12636-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Laura Abbott <labbott@redhat.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	Nandor Han <nandor.han@ge.com>
Cc: Laura Abbott <labbott@redhat.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: [PATCHv2 3/4] gpio: Remove VLA from xra1403 driver
Date: Thu, 15 Mar 2018 11:00:29 -0700
Message-Id: <20180315180030.20001-4-labbott@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180315180030.20001-1-labbott@redhat.com>
References: <20180315180030.20001-1-labbott@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595027642286122397?=
X-GMAIL-MSGID: =?utf-8?q?1595027642286122397?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


The new challenge is to remove VLAs from the kernel
(see https://lkml.org/lkml/2018/3/7/621)

This patch replaces a VLA with an appropriate call to kmalloc_array.

Reviewed-by: Nandor Han <nandor.han@ge.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v3: Add reviwed-by
---
 drivers/gpio/gpio-xra1403.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-xra1403.c b/drivers/gpio/gpio-xra1403.c
index 0230e4b7a2fb..8d4c8e99b251 100644
--- a/drivers/gpio/gpio-xra1403.c
+++ b/drivers/gpio/gpio-xra1403.c
@@ -126,11 +126,16 @@ static void xra1403_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 {
 	int reg;
 	struct xra1403 *xra = gpiochip_get_data(chip);
-	int value[xra1403_regmap_cfg.max_register];
+	int *value;
 	int i;
 	unsigned int gcr;
 	unsigned int gsr;
 
+	value = kmalloc_array(xra1403_regmap_cfg.max_register, sizeof(*value),
+				GFP_KERNEL);
+	if (!value)
+		return;
+
 	seq_puts(s, "xra reg:");
 	for (reg = 0; reg <= xra1403_regmap_cfg.max_register; reg++)
 		seq_printf(s, " %2.2x", reg);
@@ -154,6 +159,7 @@ static void xra1403_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 			   (gcr & BIT(i)) ? "in" : "out",
 			   (gsr & BIT(i)) ? "hi" : "lo");
 	}
+	kfree(value);
 }
 #else
 #define xra1403_dbg_show NULL
-- 
2.14.3
