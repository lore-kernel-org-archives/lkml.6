Return-Path: <kernel-hardening-return-12352-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELteOfX9Wo1r6ZkdneWigMdF2MiP5NRzwNdWNEcBgPFCUbRENb0wR9LXy53nSuksS2PZL6Do
ARC-Seal: i=1; a=rsa-sha256; t=1520640677; cv=none;
        d=google.com; s=arc-20160816;
        b=SUDhqzwYEyNusewUEXE5+veSZQ9HNhhkohtOA0HIigsyF2vpvELzuIzcra8wXk/PyO
         PNGG2FPTjzWzFlwjsoggN4LAJmaZZO0CRGMu2aee/8EGzf8XLWjY4ESJDpuh8CX7dnPW
         0GBrgMLF3vz5gU7uK0b4UaDfaMh/NRu2a4DHdveZpr4gIJBRZkCShDAQIfUCq6fqupC+
         DG19BTcsFnACiR8vZourQKB//Qryvdv/hnr6SSlFfCxRdSzYVcpVuWwIWhyo6vxy0GtY
         Dk4WajW/Z5+mzPhHjEn54AULiveS3ihu+dAVqzWC2xkav8zGmd9Mhp5rQpNuUJY3guXK
         BNQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=17zt0Sf3Wd3XozX5xGu4WLBb9pLFNLfrxbzuq8iiG7g=;
        b=W45TRmVDZvyZQQkQ1MjkGFc5Q8x4C83tHofx/buDqZTIxgY+luHRSAIMA7XY8vL4tO
         DagYwzuJhx+nRZ09ljsO95wWSc8asUEujyZvpWi5e79njYEpqUvBrtTghVGVMU53Pknr
         0PLvonlDoe3q0f4nKePLZqnWCAegtIP0qwi9hOlI8yXW873ekGyx6nqaDyrVKLFK601r
         HSy1Bl5FDtW7ToGcqc6uoPA3E/YjuzHdtp9AxfWGkOQ869My2KDoAtiYjEK2iIF49wsa
         LELjItOFmj+vBYSjTp+aHX4JSk7QY0o9h+3NIsreEIlr9kifWmy6nunNZ0YbXh99l+Zn
         IyFw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12352-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12352-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12352-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12352-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Laura Abbott <labbott@redhat.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	Nandor Han <nandor.han@ge.com>,
	Semi Malinen <semi.malinen@ge.com>
Cc: Laura Abbott <labbott@redhat.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: [PATCH 3/4] gpio: Remove VLA from xra1403 driver
Date: Fri,  9 Mar 2018 16:10:20 -0800
Message-Id: <20180310001021.6437-4-labbott@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180310001021.6437-1-labbott@redhat.com>
References: <20180310001021.6437-1-labbott@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594507318656304803?=
X-GMAIL-MSGID: =?utf-8?q?1594507318656304803?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


The new challenge is to remove VLAs from the kernel
(see https://lkml.org/lkml/2018/3/7/621)

This patch replaces a VLA with an appropriate call to kmalloc_array.

Signed-off-by: Laura Abbott <labbott@redhat.com>
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
