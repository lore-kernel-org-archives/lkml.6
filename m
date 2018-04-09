Return-Path: <kernel-hardening-return-12939-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx492NUYBbcwU6BPwPeE8CXw+PFWOgf+LOUsfSJKWZYB7Cc6ENEmTUc7cMk1PNTTjcJx6rKmc
ARC-Seal: i=1; a=rsa-sha256; t=1523308064; cv=none;
        d=google.com; s=arc-20160816;
        b=lWHoe3zeW81l6sa/FvipHJcMSpOSSgL3NM3ZZRzIiexWs2n8spc0JCmYx2ZmBLZyg1
         uSqtfxAYG+u9xdix4jNrg43+sGtJzsQmGXHEWsVZ1VYKMSOmOQA8glycmivtNzScxtE1
         9/Iyjdp9h7mrX3Q6MdkI7ufQI+HDWpiOWnzd/mnJ2dEDOU+lDwHEOB9E/LVNzUv1YlTE
         FcmVIZ0iiiInKMM21x/Zd1plCTF5NEs/9aflu/+Ln7ZJzzSBObl1zHswd1pMM1gGde50
         lyIj/7P2n6Lm+LOswb3X6a8eD8wtuJMcT5Yauu1Tk+6Q3+0PTyHeiCipCDkcTQFaASom
         7f0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=+qQJUVs3iNILz8Wjx4uqhYEnePzSmf/kBge1FKloxw4=;
        b=fufKXPRIUem6gkfO6crBfqAs6qqnr+mFWF5UxGMEOlA2F6TuD7O6omerHhar3MTAEt
         A7sNjJKS4TsgyCE+VfTIGhwDlNd2kf9XiWcRNAEckjXHTen8vujlIMKJhCpZOQvsnV/L
         gGw+LF7jB/dBqS5X/uS6rcqtcPqFO15fwAYYwfvdkUlUmQXp8/ThMXLgM2R2mxq4hN92
         A1ccpbxwgT32MvhlEwV6m9JfwhAK2hECWlYzs9bXibyGbRQO7k2Taf/mrErb9lOYb0Ql
         nYfazTh36Tl/3+o5xofbfunND5ufarscBphaVbQE6E25znm3XWRZ8Usz4cFdR6B05XDk
         j9dQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12939-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12939-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12939-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12939-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Laura Abbott <labbott@redhat.com>
To: Nandor Han <nandor.han@ge.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <keescook@chromium.org>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Laura Abbott <labbott@redhat.com>,
	linux-gpio@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	kernel-hardening@lists.openwall.com
Subject: [PATCH] gpio: xra1403: Switch to a fixed upper bound for registers
Date: Mon,  9 Apr 2018 14:07:17 -0700
Message-Id: <20180409210717.3852-1-labbott@redhat.com>
X-Mailer: git-send-email 2.14.3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597304277503728499?=
X-GMAIL-MSGID: =?utf-8?q?1597304277503728499?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Geert Uytterhoeven pointed out that the number of register was a
fixed upper bound so there's no need to use a dynamically allocated
array in place of a VLA. Use the defined upper bound.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 drivers/gpio/gpio-xra1403.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-xra1403.c b/drivers/gpio/gpio-xra1403.c
index 8d4c8e99b251..8711a7907568 100644
--- a/drivers/gpio/gpio-xra1403.c
+++ b/drivers/gpio/gpio-xra1403.c
@@ -39,6 +39,7 @@
 #define XRA_REIR  0x10 /* Input Rising Edge Interrupt Enable */
 #define XRA_FEIR  0x12 /* Input Falling Edge Interrupt Enable */
 #define XRA_IFR   0x14 /* Input Filter Enable/Disable */
+#define XRA_LAST  0x15 /* Bounds */
 
 struct xra1403 {
 	struct gpio_chip  chip;
@@ -50,7 +51,7 @@ static const struct regmap_config xra1403_regmap_cfg = {
 		.pad_bits = 1,
 		.val_bits = 8,
 
-		.max_register = XRA_IFR | 0x01,
+		.max_register = XRA_LAST,
 };
 
 static unsigned int to_reg(unsigned int reg, unsigned int offset)
@@ -126,21 +127,16 @@ static void xra1403_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 {
 	int reg;
 	struct xra1403 *xra = gpiochip_get_data(chip);
-	int *value;
+	int value[XRA_LAST];
 	int i;
 	unsigned int gcr;
 	unsigned int gsr;
 
-	value = kmalloc_array(xra1403_regmap_cfg.max_register, sizeof(*value),
-				GFP_KERNEL);
-	if (!value)
-		return;
-
 	seq_puts(s, "xra reg:");
-	for (reg = 0; reg <= xra1403_regmap_cfg.max_register; reg++)
+	for (reg = 0; reg <= XRA_LAST; reg++)
 		seq_printf(s, " %2.2x", reg);
 	seq_puts(s, "\n  value:");
-	for (reg = 0; reg < xra1403_regmap_cfg.max_register; reg++) {
+	for (reg = 0; reg < XRA_LAST; reg++) {
 		regmap_read(xra->regmap, reg, &value[reg]);
 		seq_printf(s, " %2.2x", value[reg]);
 	}
@@ -159,7 +155,6 @@ static void xra1403_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 			   (gcr & BIT(i)) ? "in" : "out",
 			   (gsr & BIT(i)) ? "hi" : "lo");
 	}
-	kfree(value);
 }
 #else
 #define xra1403_dbg_show NULL
-- 
2.14.3
