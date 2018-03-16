Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsGXhEAYBObWIgu430MjlAUS0WhVWg2kTJ9l6qre0zNtdwuzKgtSMA0fx5Gp9b8PxWIe6aE
ARC-Seal: i=1; a=rsa-sha256; t=1521214400; cv=none;
        d=google.com; s=arc-20160816;
        b=s0sCnd4Sv0XdrATeneH/ylK1Jd1wQBNduKgj5hvTaAdhm6X8u2IsmFY6wRndOkEpzF
         wXqg4sYnBiAqG6kHAJMHaPumYtRZs+c/j86oJPe/8sdUPRNibkczIrRcLJu5ZDignuIA
         fwMGkF4EJGf180Mv0ULfNmGoVB0+Jr7h3t+A434JEOqQPkhRTwDO6i28sYFqfi7P37cN
         D/YrCxhzzKEcFt6jPO3+qlK+011TJAtILu/febwI9qqIGoR3iD1wQ6a8wZjrlFBaNjwR
         GzTE/5N2k9q4h4fRKBp5p3PTFuuDiY8mWBBVyHJRVODtaNepu1oElws+ZeKDwu1wxNS0
         pq2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4VQe5BJdvEl88oQ7OPDy65gZ6IOGVUy/KWgdzeYYW3Q=;
        b=Lc7j12WRZpoR5fhda2d5AHpyvnnNkPx1rU3n7ebalRxlZCCJNgKXCIZBQlti8n3Tq1
         VVRtoA2Xy/Xt1dfc7YVCaTF1ln1W0cWSoj47YwIuEqAlldQ4OtpqtfxtO+YXbiixERYC
         LSML7u23ZrT+vfuvg18YOiRRVyGll+jFxNplRiErHPYt+uc9XThq/+RYW1VSw0fzQOhe
         ClgnUA5dP4v6iaIasleRYgxll5yP5yAe/re1+ZCDaQBB4vNZlOzpr+1GPznCpOSuq+wT
         rdAyWrOLshSsPhFIjMOICGgiz1yKV4NnJl8dt30ahzm/oCCnGB6hdd2ctv2WX2q1zzft
         AWVQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Colin Ian King <colin.king@canonical.com>,
	Shuah Khan <shuahkh@osg.samsung.com>,
	Krzysztof Opasiak <k.opasiak@samsung.com>
Subject: [PATCH 4.9 79/86] usbip: vudc: fix null pointer dereference on udc->lock
Date: Fri, 16 Mar 2018 16:23:42 +0100
Message-Id: <20180316152322.671262250@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108911326820981?=
X-GMAIL-MSGID: =?utf-8?q?1595108911326820981?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

commit df3334c223a033f562645712e832ca4cbb326bbf upstream.

Currently the driver attempts to spin lock on udc->lock before a NULL
pointer check is performed on udc, hence there is a potential null
pointer dereference on udc->lock.  Fix this by moving the null check
on udc before the lock occurs.

Fixes: ea6873a45a22 ("usbip: vudc: Add SysFS infrastructure for VUDC")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Shuah Khan <shuahkh@osg.samsung.com>
Reviewed-by: Krzysztof Opasiak <k.opasiak@samsung.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/usbip/vudc_sysfs.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/usb/usbip/vudc_sysfs.c
+++ b/drivers/usb/usbip/vudc_sysfs.c
@@ -117,10 +117,14 @@ static ssize_t store_sockfd(struct devic
 	if (rv != 0)
 		return -EINVAL;
 
+	if (!udc) {
+		dev_err(dev, "no device");
+		return -ENODEV;
+	}
 	spin_lock_irqsave(&udc->lock, flags);
 	/* Don't export what we don't have */
-	if (!udc || !udc->driver || !udc->pullup) {
-		dev_err(dev, "no device or gadget not bound");
+	if (!udc->driver || !udc->pullup) {
+		dev_err(dev, "gadget not bound");
 		ret = -ENODEV;
 		goto unlock;
 	}
