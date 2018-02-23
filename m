Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224jcIM8NnmOEMzWqyD6C5bhTkTQT0/vPyc0ypTQDEvuQIioyeLdOO8Iar0gl5Hk3Hz6u7mx
ARC-Seal: i=1; a=rsa-sha256; t=1519411217; cv=none;
        d=google.com; s=arc-20160816;
        b=whwOgAkFGhvYfuaFHRktceAU+mEEwpiIB5ZTnbd4E+JEvpQKFio4cfUmZB2aDvq7Z0
         1MW7YSyMXkfM4JXzI8tAGTpiZJI1RWl1P/R6xhIYlIIq9GoZeWGlBUAxQ22Qc24z8CFV
         VdgsElq3jQ3VEYd7BYaCbRx4K/oNLJUivXvYDDScNbPZUmdkvKZW66D+7meFtlr/Zc9v
         /ai0g4YLbHiXFDbt0xWKFU9eZRO5aMOdooYjc6SX80MbRzi44jL9bbD7HAEY3NupCsU8
         07DMr6MUuDUuyU/LqaWiItq3M9thcsELVgUmYguqb1vfoJSBa/6MkHkD24S93Xeh1O/Z
         Bu+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FLEDddNFq5n5MQbXVBIuGUbQY1+Bysmsdu77RwlElVs=;
        b=CaULOcjvgXnnvyu/ZItvK2VLHN33D0mIs7KDF0BPBwSWf6yZge57HF751ADodkKBxH
         zrJTFyebJUJ6N/q2134GUTRZCBRebFv2mBi23zDzBcMNqcCMnOHp82FVza78xfmlKA4f
         wa24YSjceQte2oJYo0nVNkWcXAkB3fzObE8E1vEPqfyKDgXkc7LY0giOopS2cq3OLRYh
         xyj+Xge4o/OBh7snIkTfL6DLKHkGni42Ktoqi3ZOO863nbCMs3bRmdivjd13mqoPy+8c
         plMTL9/iSLE8411aJGrga8BFhjVWlCT5AEuZxYv86G2WNTVMGTVHHOAIhRU1FocLQnDb
         XE1w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.4 154/193] usb: phy: msm add regulator dependency
Date: Fri, 23 Feb 2018 19:26:27 +0100
Message-Id: <20180223170350.064144126@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218137165972717?=
X-GMAIL-MSGID: =?utf-8?q?1593218137165972717?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

On linux-4.4 and linux-4.9 we get a warning about an array that is
never initialized when CONFIG_REGULATOR is disabled:

drivers/usb/phy/phy-msm-usb.c: In function 'msm_otg_probe':
drivers/usb/phy/phy-msm-usb.c:1911:14: error: 'regs[0].consumer' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  motg->vddcx = regs[0].consumer;
  ~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
drivers/usb/phy/phy-msm-usb.c:1912:14: error: 'regs[1].consumer' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  motg->v3p3  = regs[1].consumer;
  ~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
drivers/usb/phy/phy-msm-usb.c:1913:14: error: 'regs[2].consumer' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  motg->v1p8  = regs[2].consumer;

This adds a Kconfig dependency for it. In newer kernels, the driver no
longer exists, so this is only needed for stable kernels.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/phy/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -140,6 +140,7 @@ config USB_MSM_OTG
 	tristate "Qualcomm on-chip USB OTG controller support"
 	depends on (USB || USB_GADGET) && (ARCH_QCOM || COMPILE_TEST)
 	depends on RESET_CONTROLLER
+	depends on REGULATOR
 	depends on EXTCON
 	select USB_PHY
 	help
