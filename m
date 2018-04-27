Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpPPWUv4CgegRrKOpej7RU3RVwr6cSX6ZN9LupG9RYPQHdf2NA/UDkBQzlIBffZWiPitKjL
ARC-Seal: i=1; a=rsa-sha256; t=1524837783; cv=none;
        d=google.com; s=arc-20160816;
        b=iOTyNxbagIFxTGEImgL0hzFTmRRO3aMlF2GiMc8ZM/PWeaNoLM5kMZidrq6NE3mC6H
         OlFhN4y2eLtOCPrJ4xEIE+YaW9laZNFL1kwGPFWPYhz4Z1hKf7CpjJJSON7RkzIPAt99
         ByAVDjb24bMH4cx1lYSm2obmJosTEK6hSpVBROljpyUSCBFAPi2KCsDWnx66xdoczOEE
         LqYSsx/zkW2Mqto12E36d2smoxYLs2DKSqt8Gd/hYpek+O0Lu3B8JRFqGLlEJF2WYkPr
         XU4dVrpeq3d8r8lwdD8xazId8BsMh0yumM8BH/bicMaer0eTXhFfC55/yKh69q3u7IsK
         Xbig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=QpAIJzE0aqrPaptJ0ydabaTVOOccPhlc0NdlESawe7c=;
        b=oVUCsdM0X4EEVhF76v3esOOvzRtIk/aDe0x6M0SYuQIrzFHotAuLZt5v9Aeyx53Jm7
         3y1kgBXwYaXO/XSPHLyP8NQGx60AbCyrsz/9sk0eWEfFlr8lA8RJwN8lHaihkOuFQuS+
         8VXUhQExLUfUt1WkBuyJVrxX+oBB4ncQZ7kkJR+lZKpXKtHKb8Ighsksn/rFSw/Q/OLC
         1sGS8K5RVGBqlgLWEMLq9k6MkOvq0TuVz+ddRpBaubaFRWLlOnhgB/1E0ft5pb5o+yWs
         vbDuAchCKeAN+XEFKuRq+T66Z6vKFNXCf8GyPNFi5wNGoF5OfVOunhk6IsEukssugXU1
         N9pQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B01218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Jean Delvare <jdelvare@suse.de>
Subject: [PATCH 4.9 05/74] i2c: i801: store and restore the SLVCMD register at load and unload
Date: Fri, 27 Apr 2018 15:57:55 +0200
Message-Id: <20180427135710.123455520@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908303391011194?=
X-GMAIL-MSGID: =?utf-8?q?1598908303391011194?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

commit 22e94bd6779e1140350c0792e85c79552ec43673 upstream.

Also do not override any other configuration in this register.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-i801.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -243,6 +243,7 @@ struct i801_priv {
 	struct i2c_adapter adapter;
 	unsigned long smba;
 	unsigned char original_hstcfg;
+	unsigned char original_slvcmd;
 	struct pci_dev *pci_dev;
 	unsigned int features;
 
@@ -962,13 +963,26 @@ static int i801_enable_host_notify(struc
 	if (!priv->host_notify)
 		return -ENOMEM;
 
-	outb_p(SMBSLVCMD_HST_NTFY_INTREN, SMBSLVCMD(priv));
+	priv->original_slvcmd = inb_p(SMBSLVCMD(priv));
+
+	if (!(SMBSLVCMD_HST_NTFY_INTREN & priv->original_slvcmd))
+		outb_p(SMBSLVCMD_HST_NTFY_INTREN | priv->original_slvcmd,
+		       SMBSLVCMD(priv));
+
 	/* clear Host Notify bit to allow a new notification */
 	outb_p(SMBSLVSTS_HST_NTFY_STS, SMBSLVSTS(priv));
 
 	return 0;
 }
 
+static void i801_disable_host_notify(struct i801_priv *priv)
+{
+	if (!(priv->features & FEATURE_HOST_NOTIFY))
+		return;
+
+	outb_p(priv->original_slvcmd, SMBSLVCMD(priv));
+}
+
 static const struct i2c_algorithm smbus_algorithm = {
 	.smbus_xfer	= i801_access,
 	.functionality	= i801_func,
@@ -1666,6 +1680,7 @@ static void i801_remove(struct pci_dev *
 	pm_runtime_forbid(&dev->dev);
 	pm_runtime_get_noresume(&dev->dev);
 
+	i801_disable_host_notify(priv);
 	i801_del_mux(priv);
 	i2c_del_adapter(&priv->adapter);
 	i801_acpi_remove(priv);
