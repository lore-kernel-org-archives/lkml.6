Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227ekIfZT5wQZo6Vaqim+uodMbdW7pFQ1f9JOOpp6frQPkrYjmB4REGmfd/WDrXd7ZPm3C1F
ARC-Seal: i=1; a=rsa-sha256; t=1519411179; cv=none;
        d=google.com; s=arc-20160816;
        b=v2zSMRchSVCWtX/2xWh7nz8jCKyJWwn+uYmuBr056mGXg46472OHj8MMVmqyaBPFqN
         nmp/rOJirRUl5t23+qEZnDcNJ1J3NbnPYfzhHyIU2XSLQqZFDGJ4etH3w5QJGHSDbCXo
         lpFc10yJwqkFR2CSItQ46oSjMc7RAuSjZLwkY06OmAvHtu5GM9IKOiwd+NoV0EMZr9B9
         qgTOsPJ9OrHh0XkYv1CBKG0MI7I7yvthAjw5/D9LC4oMqMvm6bgHMSI8BfATXk8cBM3q
         SSVcOFk5uzfNXOS8imsNqBCq4v7GUJHuph/tl5TOSeiHFkyD/YNND0JTMTkMCrlIzCPH
         OILQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sDEvdRCtHzj4GjkKYzR3APbbqTLrBiPG4dLBfZ6Fh4I=;
        b=j2VcRrQXvSAmhBAO0BMdHQRcmBVUXB/LgiUKI4FVV70Nv4eYv/tyCK8p2gN3q+nxaq
         ru+Hpi3xHSc1RfITv2h6QZPqXetPbmfHTqQfy17HhrYG7wFhiIjryJV6oK3bSnzFKDPE
         1++fWBFTF6YcrzAoqcEBK6r8clZSezjuxaUtW1DVMPq4uU39RBhArV1+je9NdsYInimK
         IybEHo48vLYlEDBVdOlfw6x66negQpjhD7v/RG7g6m7sK8FhPrJvlrYJltM9HualFQMx
         E3KXscT8iup7IuqLMZmlqLdwe/59tODdBt11ewcwmnhMXfYnyT+DVCr2itw3XAWajCFF
         0Pnw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.4 147/193] gpio: xgene: mark PM functions as __maybe_unused
Date: Fri, 23 Feb 2018 19:26:20 +0100
Message-Id: <20180223170348.920384237@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218097512625824?=
X-GMAIL-MSGID: =?utf-8?q?1593218097512625824?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit b115bebc07f282067eccc06fd5aa3060ab1426da upstream.

When CONFIG_PM_SLEEP is disabled, we get a warning about unused functions:

drivers/gpio/gpio-xgene.c:155:12: warning: 'xgene_gpio_resume' defined but not used [-Wunused-function]
 static int xgene_gpio_resume(struct device *dev)
            ^~~~~~~~~~~~~~~~~
drivers/gpio/gpio-xgene.c:142:12: warning: 'xgene_gpio_suspend' defined but not used [-Wunused-function]
 static int xgene_gpio_suspend(struct device *dev)

The warnings are harmless and can be avoided by simplifying the code and marking
the functions as __maybe_unused.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpio-xgene.c |   13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

--- a/drivers/gpio/gpio-xgene.c
+++ b/drivers/gpio/gpio-xgene.c
@@ -42,9 +42,7 @@ struct xgene_gpio {
 	struct gpio_chip	chip;
 	void __iomem		*base;
 	spinlock_t		lock;
-#ifdef CONFIG_PM
 	u32			set_dr_val[XGENE_MAX_GPIO_BANKS];
-#endif
 };
 
 static inline struct xgene_gpio *to_xgene_gpio(struct gpio_chip *chip)
@@ -132,8 +130,7 @@ static int xgene_gpio_dir_out(struct gpi
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int xgene_gpio_suspend(struct device *dev)
+static __maybe_unused int xgene_gpio_suspend(struct device *dev)
 {
 	struct xgene_gpio *gpio = dev_get_drvdata(dev);
 	unsigned long bank_offset;
@@ -146,7 +143,7 @@ static int xgene_gpio_suspend(struct dev
 	return 0;
 }
 
-static int xgene_gpio_resume(struct device *dev)
+static __maybe_unused int xgene_gpio_resume(struct device *dev)
 {
 	struct xgene_gpio *gpio = dev_get_drvdata(dev);
 	unsigned long bank_offset;
@@ -160,10 +157,6 @@ static int xgene_gpio_resume(struct devi
 }
 
 static SIMPLE_DEV_PM_OPS(xgene_gpio_pm, xgene_gpio_suspend, xgene_gpio_resume);
-#define XGENE_GPIO_PM_OPS	(&xgene_gpio_pm)
-#else
-#define XGENE_GPIO_PM_OPS	NULL
-#endif
 
 static int xgene_gpio_probe(struct platform_device *pdev)
 {
@@ -230,7 +223,7 @@ static struct platform_driver xgene_gpio
 	.driver = {
 		.name = "xgene-gpio",
 		.of_match_table = xgene_gpio_of_match,
-		.pm     = XGENE_GPIO_PM_OPS,
+		.pm     = &xgene_gpio_pm,
 	},
 	.probe = xgene_gpio_probe,
 	.remove = xgene_gpio_remove,
