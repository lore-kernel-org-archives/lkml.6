Return-Path: <kernel-hardening-return-12351-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELs5PF/WonO7AgODM+yGbm0kJdPPD/E6jH6hVQNvYPGgmthGan+0rcerYyemB3o/CNXMiaP8
ARC-Seal: i=1; a=rsa-sha256; t=1520640669; cv=none;
        d=google.com; s=arc-20160816;
        b=MGjdARLg3rjUlNivFVDQ0WCNLkZmRgSciTmEq+kUxQgO0TEkxmG2zrwklsUIwvvgSE
         pibVnVRIA4APsDCARL+sL2BAyIHHxxR5Xbz0OC6CQ6tCKrcf8tgB32efkO841CvnNnsO
         roj0q26i3xBUzIgYzgyA7o9wyyg+X9MPpWA0Z4q271OGpLdenG0sAFiuNaBQVkLW65T1
         lU0GziH7F4WlbuuL0zDAhbIBj+kO1YRjT1RZZ+HhZ/dOn+uFKTXEBSP4h9JgEJcQmssQ
         z0oI8RBRCgDXsdQQEBCwmlmsz8JcXAetdYx1qTaKC2II6rAn/q12Fcip6oGeqNFWhcWC
         Ofng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=474AYZ35G8oYHx5uigfs25WvIcdFL+8l79GX75PnAwU=;
        b=pFRqSBmHl+I4TdQ9lIlhCL0W3YhMkpkp0aMLQLm3PQlZIk8y5eHQ7L8fncTeupDsnu
         UuWi2X6HM9xdGF/His3qfG9k0eXK/FMZF81gLbVrrsnLhjZh9CwUba0OMMsuJqaSR8tj
         yearWYW88RPQYOvbse0CIpk+Da8wYbnq38WbhZsEc1IBkmyBdnt2+7dQbOwk1opX5lmx
         SReikThnHhfpW9szeZ7MPk8UKB1D9joJiRJwKPiw8masB+C7KrbPVjm+6M0/Nt22PrJI
         oSyMgCLdiVmzv2eXMPHSOnZGrNMeipiGWlJil7a76egwkEkg3EWqT5BM/ee22kqkbm3/
         VV8w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12351-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12351-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12351-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12351-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Laura Abbott <labbott@redhat.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	Lukas Wunner <lukas@wunner.de>
Cc: Laura Abbott <labbott@redhat.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	Mathias Duckeck <m.duckeck@kunbus.de>
Subject: [PATCH 2/4] gpio: Remove VLA from MAX3191X driver
Date: Fri,  9 Mar 2018 16:10:19 -0800
Message-Id: <20180310001021.6437-3-labbott@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180310001021.6437-1-labbott@redhat.com>
References: <20180310001021.6437-1-labbott@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594507311207261604?=
X-GMAIL-MSGID: =?utf-8?q?1594507311207261604?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


The new challenge is to remove VLAs from the kernel
(see https://lkml.org/lkml/2018/3/7/621)

This patch replaces several a VLA with an appropriate call to
kmalloc_array.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 drivers/gpio/gpio-max3191x.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-max3191x.c b/drivers/gpio/gpio-max3191x.c
index f74b1072e84b..b5b9cb1fda50 100644
--- a/drivers/gpio/gpio-max3191x.c
+++ b/drivers/gpio/gpio-max3191x.c
@@ -315,12 +315,17 @@ static void gpiod_set_array_single_value_cansleep(unsigned int ndescs,
 						  struct gpio_desc **desc,
 						  int value)
 {
-	int i, values[ndescs];
+	int i, *values;
+
+	values = kmalloc_array(ndescs, sizeof(*values), GFP_KERNEL);
+	if (!values)
+		return;
 
 	for (i = 0; i < ndescs; i++)
 		values[i] = value;
 
 	gpiod_set_array_value_cansleep(ndescs, desc, values);
+	kfree(values);
 }
 
 static struct gpio_descs *devm_gpiod_get_array_optional_count(
-- 
2.14.3
