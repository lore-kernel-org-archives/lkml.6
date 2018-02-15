Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225Y3qJ5Zz0Xu9aqhRFPbUEb8IAnYGgKP/mRrxZPD8rLPU1a4fae+Hl/S9xhBrCmqUSXersC
ARC-Seal: i=1; a=rsa-sha256; t=1518708588; cv=none;
        d=google.com; s=arc-20160816;
        b=JXIlXM35eLS1GgEH33pcB0fAAZyX2JKVg+Odx8vwKPFBAbIJgPtUhXcVLAlqQ96F4H
         R3jb4Q856kaP+3R4XmHxSV4rqObV5x1zBzIp5+M7V4uutR2r3IxUTMsco8Af/rqjvEdV
         cNu+v1H3YRZe8ppUkeMtv85KVPytAkOO37Iphu1XL2gcYb0YAUw9lAe69wqJrfja/aTM
         9doN9bVBwOobTV5cgsXpE54WBoHX3I/00uB2Cau2iJtGxF5fcz/la4HxUNKZ4jBnSzuY
         DD18oAisBN5/E87BLvZGieTbI1GrBXuQNHD2Dt/YezHmiCilxaD0ChA5rCM8RvP0REhk
         4ZKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rrMWz/DhWg8YR/MU4MifNMWvkuCGBknKWDRql1ZRYTg=;
        b=DwBl6L48405frgTPvdvqhKKCsWqa9vYo3eV/UQn3BLf3nTAcFPUVIA5mRRuAdVaUcv
         SzhN+pnkcrU9Kf6Q7wmuzt80evnyTOZAd8PRCTvb2g7QWqDFHdAgFaiIhnGc92wVS0/E
         sJ4TH2gyRfe/CY9rJfyLoVYEyzcQgHlzVuhAbKrSCKkFt4FDqoquc9i7SEi7ACcjELaw
         jswL9cxjT4kitm3gmeDwpaqd3eGKY7QoMPQcpxjTQnspFQHgRm47gcqyP2xaGeaKAPxL
         kJhEss8wNfTAwTP6xsk4nO8iZ9QDMvHOqZp/kHZr1PJW6MpFGIoGLz8eTHY/rTVU20B3
         Tblg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 4.9 57/88] watchdog: imx2_wdt: restore previous timeout after suspend+resume
Date: Thu, 15 Feb 2018 16:17:24 +0100
Message-Id: <20180215151230.590362280@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481116779538843?=
X-GMAIL-MSGID: =?utf-8?q?1592481377243652673?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Kaiser <martin@kaiser.cx>

commit 0be267255cef64e1c58475baa7b25568355a3816 upstream.

When the watchdog device is suspended, its timeout is set to the maximum
value. During resume, the previously set timeout should be restored.
This does not work at the moment.

The suspend function calls

imx2_wdt_set_timeout(wdog, IMX2_WDT_MAX_TIME);

and resume reverts this by calling

imx2_wdt_set_timeout(wdog, wdog->timeout);

However, imx2_wdt_set_timeout() updates wdog->timeout. Therefore,
wdog->timeout is set to IMX2_WDT_MAX_TIME when we enter the resume
function.

Fix this by adding a new function __imx2_wdt_set_timeout() which
only updates the hardware settings. imx2_wdt_set_timeout() now calls
__imx2_wdt_set_timeout() and then saves the new timeout to
wdog->timeout.

During suspend, we call __imx2_wdt_set_timeout() directly so that
wdog->timeout won't be updated and we can restore the previous value
during resume. This approach makes wdog->timeout different from the
actual setting in the hardware which is usually not a good thing.
However, the two differ only while we're suspended and no kernel code is
running, so it should be ok in this case.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/watchdog/imx2_wdt.c |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -169,15 +169,21 @@ static int imx2_wdt_ping(struct watchdog
 	return 0;
 }
 
-static int imx2_wdt_set_timeout(struct watchdog_device *wdog,
-				unsigned int new_timeout)
+static void __imx2_wdt_set_timeout(struct watchdog_device *wdog,
+				   unsigned int new_timeout)
 {
 	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
 
-	wdog->timeout = new_timeout;
-
 	regmap_update_bits(wdev->regmap, IMX2_WDT_WCR, IMX2_WDT_WCR_WT,
 			   WDOG_SEC_TO_COUNT(new_timeout));
+}
+
+static int imx2_wdt_set_timeout(struct watchdog_device *wdog,
+				unsigned int new_timeout)
+{
+	__imx2_wdt_set_timeout(wdog, new_timeout);
+
+	wdog->timeout = new_timeout;
 	return 0;
 }
 
@@ -371,7 +377,11 @@ static int imx2_wdt_suspend(struct devic
 
 	/* The watchdog IP block is running */
 	if (imx2_wdt_is_running(wdev)) {
-		imx2_wdt_set_timeout(wdog, IMX2_WDT_MAX_TIME);
+		/*
+		 * Don't update wdog->timeout, we'll restore the current value
+		 * during resume.
+		 */
+		__imx2_wdt_set_timeout(wdog, IMX2_WDT_MAX_TIME);
 		imx2_wdt_ping(wdog);
 	}
 
