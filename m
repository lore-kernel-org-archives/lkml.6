Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225kr/e3CJ2i7mpo/Paf89oez9xBKl9zyo5Csme65u6JNPAPFTeIRJxY5sWDbdO0vb7T8LWg
ARC-Seal: i=1; a=rsa-sha256; t=1519411054; cv=none;
        d=google.com; s=arc-20160816;
        b=KGTfB7QaZsZzdsM6/mxSayGJjGIsIG014ELA75XDWiKUW7G1WSFuF5/FJTakpoy5cs
         kvg1T6if3QIJlZo1a30lXIv4uuWEkcPic3qm7iS+MDkYzI4lniaAm09iJDEASq2BPaof
         25nnMqiaTnM/yiGBU0LkFT0rGjoKNjrhcBGTcM5i6epd5dauBhz4xXVlp8HuZ0Y8P8Jh
         smF16wggGyRFwIz7w0PGVFnRw+RWr4NKPEmbwzkx9TTpq0PUeLTTJI4l8/OiCDhJ1NHZ
         Jvj3kczU4UFuMrdj2nzxSCKt9mky78TRfvA2sbRjxCXcP/7xyZFpRLupcDSOJ/lDDfs5
         WvTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Jnd4kX1NyzLRTiHNHo69scU2fqHxYmK44+XdVCDLw9c=;
        b=Dm4/SNZzGpwTNn8Ah7BNskDYbiJtr54+AUksdWpxpXzf3Fxyo4sFUvPB9HgPXsYK8D
         IHoLMiz7GrK/8R0tWmL9ITOna5TsvJ31i7Eh+ZYFBjtSEQVh+/TuSalq57bIXIHUG6CN
         PdqVkjCYK20LtyXNeeuYPpMqJZkjX+rsDV1GE81BGLzmetjjN9QQYedSgo6MpTcw++DT
         ZoiJGlgTf9Z7lTBgDE2Pze02pR3ObHp6pUMU9/WnNgF5xdZklfyGEMRofn6xHqGUdGaS
         kXHy2fUGQ1m3vZROnxSbk2z9RBwP61FFyhiiA8apm7GXdH6OSMmzLiyYTafp0v+t+yIw
         Ollw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 4.4 104/193] fbdev: auo_k190x: avoid unused function warnings
Date: Fri, 23 Feb 2018 19:25:37 +0100
Message-Id: <20180223170342.232618179@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217966120288358?=
X-GMAIL-MSGID: =?utf-8?q?1593217966120288358?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit a8a31afad5ffa1c7de0cef1c4bc383b50f426bf8 upstream.

The auo_k190x framebuffer driver encloses the power-management
functions in #ifdef CONFIG_PM, but the auok190x_suspend/resume
functions are only really used when CONFIG_PM_SLEEP is also
set, as a frequent gcc warning shows:

drivers/video/fbdev/auo_k190x.c:859:12: warning: 'auok190x_suspend' defined but not used
drivers/video/fbdev/auo_k190x.c:899:12: warning: 'auok190x_resume' defined but not used

This changes the driver to remove the #ifdef and instead mark
the functions as __maybe_unused, which is a nicer anyway, as it
provides build testing for all the code in all configurations
and is harder to get wrong.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/fbdev/auo_k190x.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

--- a/drivers/video/fbdev/auo_k190x.c
+++ b/drivers/video/fbdev/auo_k190x.c
@@ -773,9 +773,7 @@ static void auok190x_recover(struct auok
 /*
  * Power-management
  */
-
-#ifdef CONFIG_PM
-static int auok190x_runtime_suspend(struct device *dev)
+static int __maybe_unused auok190x_runtime_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct fb_info *info = platform_get_drvdata(pdev);
@@ -822,7 +820,7 @@ finish:
 	return 0;
 }
 
-static int auok190x_runtime_resume(struct device *dev)
+static int __maybe_unused auok190x_runtime_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct fb_info *info = platform_get_drvdata(pdev);
@@ -856,7 +854,7 @@ static int auok190x_runtime_resume(struc
 	return 0;
 }
 
-static int auok190x_suspend(struct device *dev)
+static int __maybe_unused auok190x_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct fb_info *info = platform_get_drvdata(pdev);
@@ -896,7 +894,7 @@ static int auok190x_suspend(struct devic
 	return 0;
 }
 
-static int auok190x_resume(struct device *dev)
+static int __maybe_unused auok190x_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct fb_info *info = platform_get_drvdata(pdev);
@@ -933,7 +931,6 @@ static int auok190x_resume(struct device
 
 	return 0;
 }
-#endif
 
 const struct dev_pm_ops auok190x_pm = {
 	SET_RUNTIME_PM_OPS(auok190x_runtime_suspend, auok190x_runtime_resume,
