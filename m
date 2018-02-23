Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225wVjynLjy7qMkyxjKMKx/o4QuPOGwZAvyTIFgV70h8GR2pn13Cqt610YZ2ON5DZTBaJ0Vf
ARC-Seal: i=1; a=rsa-sha256; t=1519411065; cv=none;
        d=google.com; s=arc-20160816;
        b=Ipf2xQ1qv0tIqOY5ALuJw04die+GUajrXv9/wiwAplzf7Ng+j+zdl2X46pAa6ayEUw
         24Sg1lFMUGkhFPwKUUZcCaEcyhM7bSR34C4GFzaIWHt/kFjo+tEsubB6AxmJ0suMhx2u
         zWwdrA58jMf/5F75ROIPO+tPvolBYMEUT9+NxETRL933fSlxAj36g7d+k96w3yxCejmT
         gQyeo4zxjJYOp54/z41xLpVcxVHkSq25YGoRUhLvpuFAhNS5H++Oj7gnFU2zA5pC7def
         DHKKzQRbAL59ZYIIXrqYn9vMoSlFKI/R7MRf6cMJrgbDuUYtw5c5uEiHfEEyP9D+ra4V
         l+QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AeEpOEnA4hW7FaYxxblmZY/GzwK8gjQwH1PLW3tSvcs=;
        b=oxtqv//NnPlY5OWVs1e1TJ5EIp6zOUywtrVPNmNPtNOksUprkNMh33oZE8m6HSp3pi
         EpCHdGqEZBBCGhUkKdysEfJ8XevW53VWmlyn2xPJAxG3yO22Ohg9+31I60RcMs1bFvad
         qpvHcZtHnJ6hWbseZrzwuVPmGp6Q6FDqxC9KyuAUjHdfzsQWUtB4nJvQUvZyXbliIPyS
         gdYi3zJdtHb6GJxJOA4OmPTvJ1hYjfVJMDUZRRUAANgv7Tvc3Ijlw8W8ZJGOY34vrOsy
         PvABJsT9/TudPTeDS/uWEpdj1fgQrOCDkY4u5aF+fbL9mSogifZqF0R3/GvZd9+blVEy
         h/LA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 4.4 108/193] fbdev: s6e8ax0: avoid unused function warnings
Date: Fri, 23 Feb 2018 19:25:41 +0100
Message-Id: <20180223170342.858514771@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217977587001623?=
X-GMAIL-MSGID: =?utf-8?q?1593217977587001623?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit b54729b6cea7d1f46b1ed70cb7065c6bdefaa780 upstream.

The s6e8ax0 suspend/resume functions are hidden inside of an #ifdef
when CONFIG_PM is set to avoid unused function warnings, but they
call some other functions that nothing else calls, and we get warnings
about those:

drivers/video/fbdev/exynos/s6e8ax0.c:449:13: error: 's6e8ax0_sleep_in' defined but not used [-Werror=unused-function]
drivers/video/fbdev/exynos/s6e8ax0.c:485:13: error: 's6e8ax0_display_off' defined but not used [-Werror=unused-function]

This marks the PM functions as __maybe_unused so the compiler can
silently drop them when they are not referenced.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/fbdev/exynos/s6e8ax0.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

--- a/drivers/video/fbdev/exynos/s6e8ax0.c
+++ b/drivers/video/fbdev/exynos/s6e8ax0.c
@@ -829,8 +829,7 @@ static int s6e8ax0_probe(struct mipi_dsi
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int s6e8ax0_suspend(struct mipi_dsim_lcd_device *dsim_dev)
+static int __maybe_unused s6e8ax0_suspend(struct mipi_dsim_lcd_device *dsim_dev)
 {
 	struct s6e8ax0 *lcd = dev_get_drvdata(&dsim_dev->dev);
 
@@ -843,7 +842,7 @@ static int s6e8ax0_suspend(struct mipi_d
 	return 0;
 }
 
-static int s6e8ax0_resume(struct mipi_dsim_lcd_device *dsim_dev)
+static int __maybe_unused s6e8ax0_resume(struct mipi_dsim_lcd_device *dsim_dev)
 {
 	struct s6e8ax0 *lcd = dev_get_drvdata(&dsim_dev->dev);
 
@@ -855,10 +854,6 @@ static int s6e8ax0_resume(struct mipi_ds
 
 	return 0;
 }
-#else
-#define s6e8ax0_suspend		NULL
-#define s6e8ax0_resume		NULL
-#endif
 
 static struct mipi_dsim_lcd_driver s6e8ax0_dsim_ddi_driver = {
 	.name = "s6e8ax0",
@@ -867,8 +862,8 @@ static struct mipi_dsim_lcd_driver s6e8a
 	.power_on = s6e8ax0_power_on,
 	.set_sequence = s6e8ax0_set_sequence,
 	.probe = s6e8ax0_probe,
-	.suspend = s6e8ax0_suspend,
-	.resume = s6e8ax0_resume,
+	.suspend = IS_ENABLED(CONFIG_PM) ? s6e8ax0_suspend : NULL,
+	.resume = IS_ENABLED(CONFIG_PM) ? s6e8ax0_resume : NULL,
 };
 
 static int s6e8ax0_init(void)
