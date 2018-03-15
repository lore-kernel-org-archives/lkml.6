Return-Path: <kernel-hardening-return-12635-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELu6/Hyst0aBziKCWeA7H+x1s/R5DI7+MIl+XNT0pAa1Ocm6+diVeXGTP4U4xG5EQm0Dahvc
ARC-Seal: i=1; a=rsa-sha256; t=1521136885; cv=none;
        d=google.com; s=arc-20160816;
        b=ynGvuofVqbrZ06wGS8ey0TCX7bmpJX2ZcASSSBozb8lI6KZU2Ni1kc/MNUTFaFPQ2C
         sjHUubLCrUd9tU8GQeU/gYibyJXxHSWFPMjdouhRmkLvbh9oDQNP8/1l+shr9C1m4hyS
         Y9RXT9rcMr6etjko7HI1gaUDXj/1HsSWZSGibk/kUEZiIPqDfukSxyCGYykY/1FFRjuQ
         jqebXQo60dkHNO02/+8+ySN25HkcrNpbiyHH2msL999L0OG292KiAGrDqwiEg5Y73zdl
         4crVXXGDQwxOlSYTbb87h+8XF9+NuxVM0FEVoNF99RDrG/LLWDcZttSnk+jCBF0MTyTZ
         loMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=NPn+bd/tFVjdueEmk5C7pFyl4Z5oi6dsiT5tuveRGEc=;
        b=z2ljNkQsv2jZe+ZToHvH7GYYYzV78Yu8Ncr2TUNzMua4H4mEHkoE18cQs2xDv2aa7V
         NqQ+yik+dsGNHgJsOvxyyO68iL1qW6Zc1NHuXKifoPUeFqivQHcPTAbvYm9yFGfHOy3Y
         muSnFzi52kyWeRaMyfGfHQQTQpGrsFCYyeSfIOVJh5ltKBc652PCv66eOnRReMVeUh9A
         0fb9Dp8M2fJaGG3IpBjJT5YT0RV5HRa2Mc/ivNIT2ll+qxYwRK3wW0f7CmtGF7Sn3v9V
         NIUQtHf852CsxsKEVsHPzKtztm/jAcwl0ADth4g4lROXnGTxNa9VnU+FBC7zAi7WDlGA
         MuoA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12635-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12635-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12635-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12635-gregkh=linuxfoundation.org@lists.openwall.com;
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
Subject: [PATCHv2 2/4] gpio: Remove VLA from MAX3191X driver
Date: Thu, 15 Mar 2018 11:00:28 -0700
Message-Id: <20180315180030.20001-3-labbott@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180315180030.20001-1-labbott@redhat.com>
References: <20180315180030.20001-1-labbott@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595027631574096060?=
X-GMAIL-MSGID: =?utf-8?q?1595027631574096060?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


The new challenge is to remove VLAs from the kernel
(see https://lkml.org/lkml/2018/3/7/621)

This patch replaces several a VLA with an appropriate call to
kmalloc_array.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v2: No changes
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
