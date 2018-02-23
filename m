Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225vt5lNNTqz5lAOrj2du4gmHFP6Fa1ehRmEZSTeGFj2fQHT9qJV4m86cHXLOmwgMxVWBEEb
ARC-Seal: i=1; a=rsa-sha256; t=1519411142; cv=none;
        d=google.com; s=arc-20160816;
        b=PyW1Vzi+a3VQ2vZCI1SEyqKMs+Im/TekNv2X64Xibxvk/95OlpamA1ElGIaLOEG0Qk
         ZeARysyvt8zPTMpa+Td7stcc5u7jW/EB32G3sYf6JmtzuXXdgPS+3Ucaluyqu3oFPFIh
         84GRvU3OUMq2pAFkhveDxVoXgHvresSNKvBh40G//526tHZ02v+2pMRJSB+c3x//a9jz
         MoW/QxYhlvwr+HkUT7Ys1syD5zij6nraWTOUJjuZ0PwrXNDQpXcnlx0/xFxtSADeKK1A
         eFm80biwyWwA7F6znphIfMMMEs3qxOWhwri+r8zf2JWauffidv5j0u9Lwsrdzh1XPDMD
         GCZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=b5zvYft1iCEgNBC7/ilvZ1WFtB2s6fWrS2Esna3IviI=;
        b=x/AkhdLfIh9r6V37tyX7XAuf839qneZoJMN2QgfWID2YFb8fxNeCoceuLBdpfBXJ4P
         3Ma2j2odxR68ubw7t70tZDkfy00sXZqTLbWtybCSamaF5Yjp0go/wDCQO+hjUA8vMHsb
         SNUgD4YDSKvDbk/Rpl1+/98PtV/I1CtLdZoor4WdQHUcpWlioZnMqWxd8BUBJFvX6OoK
         rt/qZmuwV3ep7LKj7R9mbtYgcxhd2O6YgHij37woLcJ8/4xdR/4vrNGwCno25DpGkdZV
         AI/1CuTW3s5VTwT9gVmkteIDq9My2W1Ivk+F3kayS3da4BJVMJaqLYqN9S+5VedxJFyl
         u6qA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.4 135/193] [media] em28xx: only use mt9v011 if camera support is enabled
Date: Fri, 23 Feb 2018 19:26:08 +0100
Message-Id: <20180223170346.972995069@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218058252482575?=
X-GMAIL-MSGID: =?utf-8?q?1593218058252482575?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 190b23b4eb997767afad186bd8c96badceabf39e upstream.

In randconfig builds that select VIDEO_EM28XX_V4L2 and
MEDIA_SUBDRV_AUTOSELECT, but not MEDIA_CAMERA_SUPPORT, we get
a Kconfig warning:

 warning: (VIDEO_EM28XX_V4L2) selects VIDEO_MT9V011 which has unmet direct dependencies (MEDIA_SUPPORT && I2C && VIDEO_V4L2 && MEDIA_CAMERA_SUPPORT)

This avoids the warning by making that 'select' conditional on
MEDIA_CAMERA_SUPPORT. Alternatively we could mark EM28XX as
'depends on MEDIA_CAMERA_SUPPORT', but it does not seem to
have any real dependency on that itself.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/em28xx/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/usb/em28xx/Kconfig
+++ b/drivers/media/usb/em28xx/Kconfig
@@ -11,7 +11,7 @@ config VIDEO_EM28XX_V4L2
 	select VIDEO_SAA711X if MEDIA_SUBDRV_AUTOSELECT
 	select VIDEO_TVP5150 if MEDIA_SUBDRV_AUTOSELECT
 	select VIDEO_MSP3400 if MEDIA_SUBDRV_AUTOSELECT
-	select VIDEO_MT9V011 if MEDIA_SUBDRV_AUTOSELECT
+	select VIDEO_MT9V011 if MEDIA_SUBDRV_AUTOSELECT && MEDIA_CAMERA_SUPPORT
 
 	---help---
 	  This is a video4linux driver for Empia 28xx based TV cards.
