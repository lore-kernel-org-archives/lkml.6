Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226Wt3+fwZ2S/JcILLpjX0xAwfnk9A5nUaKYoPezaFBnb4nscV+7k7vnqdgqF217682HWgOw
ARC-Seal: i=1; a=rsa-sha256; t=1519411075; cv=none;
        d=google.com; s=arc-20160816;
        b=U9HWehBpG/+iq4Sk9sD/7XzSev0cfdOACQOg7ccttX4CqerGXpcqYXZPyAmgQbEcKv
         tJ+GLq7oDvuEyaQ4D6bBuCczBp+667IOTDeFomUEbxXUaGZQNXPa4tOuQAWCwxsDLLt9
         OuyXalMziMTELsV4K7ZNEFa+zsKRkpJMYxhFXmN6MFBwZ9enMfStW5wK1zLpd0DbLe6F
         fwjsaBNI6kQyx1gVok3DUtBP1h6/J7l2Us2OzRTN2vnI6vKpBSlSzHAdLMk/ePSh8W2d
         XxEy2+NMYRozvvZVAyp2jfj6o70GhBNbATS6r46DUNoR52BvOqr3ZWtiHOTwo3AiHVi6
         kB3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tvBYzEOtrEphg7avkvYaat5BdxUEoNfSCaXZlna6cQE=;
        b=vjsdVV8XOliqTMEVFg1Mshy0XPRK/KT0WB3IHLyIYWXUBlXwUAMXQMpRTSlqJM4UPY
         9vL9YHAVOqLTo2XmaBZJZ1lP0OQy9E3id7mMvJZMvY2Mm1TRFYFs+GkOOxMttMJPgsA7
         eXyegha9LRGyacEdnApHgmJ/waBK7BAzbBM94vL8XA+2q9ZtkUL7A8y9QNX/zWLBujGV
         fdX0Exxab3FlgR8rbaq6PNvpXgmt1nWdnnWTvGIWXyfMyxZm3mBypDP81OaERDA/Yhl9
         HaXfL9o/x2wFE6KgiV/6PHl/JNmsooOSOsC9EDgrLlzi6TDIhPEZIG6mGY3zM31yYEZ9
         HHHA==
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
Subject: [PATCH 4.4 111/193] fbdev: sm712fb: avoid unused function warnings
Date: Fri, 23 Feb 2018 19:25:44 +0100
Message-Id: <20180223170343.328363047@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217987421546003?=
X-GMAIL-MSGID: =?utf-8?q?1593217987421546003?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 24ed78dc2e8b2428eccc70c3162e70d33ab448c4 upstream.

The sm712fb framebuffer driver encloses the power-management
functions in #ifdef CONFIG_PM, but the smtcfb_pci_suspend/resume
functions are only really used when CONFIG_PM_SLEEP is also
set, as a frequent gcc warning shows:

fbdev/sm712fb.c:1549:12: warning: 'smtcfb_pci_suspend' defined but not used
fbdev/sm712fb.c:1572:12: warning: 'smtcfb_pci_resume' defined but not used

The driver also avoids using the SIMPLE_DEV_PM_OPS macro when
CONFIG_PM is unset, which is redundant.

This changes the driver to remove the #ifdef and instead mark
the functions as __maybe_unused, which is a nicer anyway, as it
provides build testing for all the code in all configurations
and is harder to get wrong.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/fbdev/sm712fb.c |   16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -28,9 +28,7 @@
 #include <linux/console.h>
 #include <linux/screen_info.h>
 
-#ifdef CONFIG_PM
 #include <linux/pm.h>
-#endif
 
 #include "sm712.h"
 
@@ -1545,8 +1543,7 @@ static void smtcfb_pci_remove(struct pci
 	pci_disable_device(pdev);
 }
 
-#ifdef CONFIG_PM
-static int smtcfb_pci_suspend(struct device *device)
+static int __maybe_unused smtcfb_pci_suspend(struct device *device)
 {
 	struct pci_dev *pdev = to_pci_dev(device);
 	struct smtcfb_info *sfb;
@@ -1569,7 +1566,7 @@ static int smtcfb_pci_suspend(struct dev
 	return 0;
 }
 
-static int smtcfb_pci_resume(struct device *device)
+static int __maybe_unused smtcfb_pci_resume(struct device *device)
 {
 	struct pci_dev *pdev = to_pci_dev(device);
 	struct smtcfb_info *sfb;
@@ -1610,20 +1607,13 @@ static int smtcfb_pci_resume(struct devi
 }
 
 static SIMPLE_DEV_PM_OPS(sm7xx_pm_ops, smtcfb_pci_suspend, smtcfb_pci_resume);
-#define SM7XX_PM_OPS (&sm7xx_pm_ops)
-
-#else  /* !CONFIG_PM */
-
-#define SM7XX_PM_OPS NULL
-
-#endif /* !CONFIG_PM */
 
 static struct pci_driver smtcfb_driver = {
 	.name = "smtcfb",
 	.id_table = smtcfb_pci_table,
 	.probe = smtcfb_pci_probe,
 	.remove = smtcfb_pci_remove,
-	.driver.pm  = SM7XX_PM_OPS,
+	.driver.pm  = &sm7xx_pm_ops,
 };
 
 static int __init sm712fb_init(void)
