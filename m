Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1883814-1518711221-2-9877965733491660088
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518711220; b=CN2inNoPEu3AuFF7YHeNQJuZN3Ci117mU9CaQnWx/jswbtD
    2QhSlVdQyncUSVRIMCZl6OgZMKlK1GHJvt2fn1POlk9SXZFnCw0WJPbZ1Zyvp6dm
    662WUGhlOjW6omirPBTHKPISjkrnTR0B/najdAPpiFKKFqswanr5OPjD/UBXCfdY
    G/LQF6XARkXuPjF+/Ml1VKva7pArZX7RS+HzdaIa2Q+fOuedCJIONU9j0exjvggG
    LiQNIOKpCS1s8pbDX+YM0gMavCaznuIH6eXM9GeJ+ZluY4TWGTGLCQqTiWB57LAE
    Tq+/V61EUFNXkI8XhBbfHbaI9JncvfzzbatgfzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518711220; bh=/rbA6UqYK5VFLAHauV+ImutjQV
    roXz5q1WIOurcYhOU=; b=ZmL3GGmYMR3YCb9BN3rTndtPFlS3OjTPHzptK/AlIJ
    PuEdi4+rCO8l0FQQFirZSggmwdHvHNeDd3oFnvSqANUAdrQ4e3YKryJGnuIveYVt
    lDocktKDQRMlfNf64HbBKOPwI51O3TjdFtTG/f4URLgQ5AhNrh8RxOqbDUiOWswk
    nuiYuw4IRVHFAxxHkONM8ACGL4IqhHtCqBnZs7K6G0WMDcuH4+7I2BW93gUqdo6c
    n+OSrWb2nAtbe8UyjGHhVc87hk73aBDNCs7lhNlIDV4gM7Uz1iqq5s3JrdvSCOTA
    ukF6U295LvAG1B4y7SIO+QhHxE5NUW7rw4WgnnqStjWw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424560AbeBOQNW (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 11:13:22 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34788 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424375AbeBOPpC (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:45:02 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 4.15 141/202] watchdog: imx2_wdt: restore previous timeout after suspend+resume
Date: Thu, 15 Feb 2018 16:17:21 +0100
Message-Id: <20180215151720.454617405@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 
