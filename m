Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt1tuNH1JyZz08du6BNGM/rOkxkUKz1tly++QiB1WtrouC356jm0Qekjzloc/tpSQdhiUoz
ARC-Seal: i=1; a=rsa-sha256; t=1519411023; cv=none;
        d=google.com; s=arc-20160816;
        b=NIJbo1t9BgMUWjpOZbxjvDEImxIXamV1PpiLP0LZoTHifdVtc0n2B3OPicLfxoLLlu
         OMF3si30R6KxUD52tV0Vea220/aELxJEYCIiYdL11GCVk4GgSZtD73Dhng4J+ly3/+Ry
         nVF9200IKOkAs/gINefFKwd5e9pMopht1HZsxCVeFeF8jiQniflVhQYY/GnzvqQL0A7v
         NLQ4Posxmv1hom/uZm1sGFj6A71KrA7ONgEs1trwJJJAqiZR9tGAEDAXpJeqDvFd3abp
         6c1ARAVRMGp/NAstRdeKhoV8AhAhsWvgDYAjxOq6mVmWdwLrG626/U3eyyx7wUvnALWA
         BB9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=auT36D+I8882IG7bmvl5icimmvk+byl9pHutnc2JHss=;
        b=wN9JFUYmaxTnG8uIjV0LjwSq64yz5YHsHTvTGFpQIULW4VswNbEBNzla2HzIOWiSkL
         ul+8Z+Sx6gcuro3V0EUkaA0O8PZkRiVXYetVebDSQQPfCTjoxgC7CsFr1K857sGlSgC6
         LBDSq6RqWlLY88FJUN0/4lujW8CSZYDBBnOm8dJytkjn9pbpoNfSEJZfzgOR0C37Ll8g
         M+tSAqWqKOjVoAmfb2A+1gJTA7OAFGAvZXxeozLD7TRO4YS898sZ1zBrDwIC+wf2DVnh
         rUmAgJsdLHUMWl2Q+2/fP0Uq/EhUnbHzVkokHcmEcvc8QkkvplIwCBClP748b1+WquYl
         eP1Q==
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
Subject: [PATCH 4.4 094/193] staging: ste_rmi4: avoid unused function warnings
Date: Fri, 23 Feb 2018 19:25:27 +0100
Message-Id: <20180223170340.748931974@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217932766414877?=
X-GMAIL-MSGID: =?utf-8?q?1593217932766414877?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 9045a4a7e686a6316129d6d0b21b4fe2520968e4 upstream.

The rmi4 touchscreen driver encloses the power-management
functions in #ifdef CONFIG_PM, but the smtcfb_pci_suspend/resume
functions are only really used when CONFIG_PM_SLEEP is also
set, as a frequent gcc warning shows:

ste_rmi4/synaptics_i2c_rmi4.c:1050:12: warning: 'synaptics_rmi4_suspend' defined but not used
ste_rmi4/synaptics_i2c_rmi4.c:1084:12: warning: 'synaptics_rmi4_resume' defined but not used

This changes the driver to remove the #ifdef and instead mark
the functions as __maybe_unused, which is a nicer anyway, as it
provides build testing for all the code in all configurations
and is harder to get wrong.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c
+++ b/drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c
@@ -1039,7 +1039,6 @@ static int synaptics_rmi4_remove(struct
 	return 0;
 }
 
-#ifdef CONFIG_PM
 /**
  * synaptics_rmi4_suspend() - suspend the touch screen controller
  * @dev: pointer to device structure
@@ -1047,7 +1046,7 @@ static int synaptics_rmi4_remove(struct
  * This function is used to suspend the
  * touch panel controller and returns integer
  */
-static int synaptics_rmi4_suspend(struct device *dev)
+static int __maybe_unused synaptics_rmi4_suspend(struct device *dev)
 {
 	/* Touch sleep mode */
 	int retval;
@@ -1081,7 +1080,7 @@ static int synaptics_rmi4_suspend(struct
  * This function is used to resume the touch panel
  * controller and returns integer.
  */
-static int synaptics_rmi4_resume(struct device *dev)
+static int __maybe_unused synaptics_rmi4_resume(struct device *dev)
 {
 	int retval;
 	unsigned char intr_status;
@@ -1112,8 +1111,6 @@ static int synaptics_rmi4_resume(struct
 	return 0;
 }
 
-#endif
-
 static SIMPLE_DEV_PM_OPS(synaptics_rmi4_dev_pm_ops, synaptics_rmi4_suspend,
 			 synaptics_rmi4_resume);
 
