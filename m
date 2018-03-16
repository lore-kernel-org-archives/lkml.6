Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtwQv7yKed1uL29tnRxxlZe9qtkiVtUtXtYF1RFqkUUHEok9p8DxoeF3J2VyTUL1vyvosNy
ARC-Seal: i=1; a=rsa-sha256; t=1521214466; cv=none;
        d=google.com; s=arc-20160816;
        b=AM7JI0xHZhtLjwox6oWKeZCt29eQJXnvZ8Lp7tsrVaE1BVNdSQEa8liifjyr63eluK
         D4MGbkfzJBPtBDcmUnhSs7KTubYS2LrGUdlaq89WVBHo9JMasO8JjEZQHYHDYWvaAa09
         UHi3g68qC9gyHxu8+TH393n4w+EkI9ADrDSX4eisUan0EwL6jMN59rFab4SR1R5mlTrJ
         LP6mBTuynVel8OpVYSQ5ti0GtzPz8xhvrGgqtR6nEaZGLQw23f3kGEXKJO0ZfvC3eW8B
         HcL/sGVJBI4gZlagjwnKHhyqRH8kWgB3dYr57qsDSq4pxqsiE307vyQ42sQHeI9IOXcN
         Oj6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EE21BYHr4lJ4IZgI1PmB3fYhMboj9BO4YzDsnQTWngE=;
        b=lFQ+h2zuLAK94D09ajIqBB1UICXbAmU9MIL+BAzxVwEr098tjv1/qveA+SIOmAsKew
         jnJtMn45Ngr+PCLW/VY2hRkYHoS3pWe2I6ZsMZj2FYvXaUS4tKhaK3u87WEL+XWiT7ZV
         2WJmrBX5cV758Lw5xvMK/PPbLLs0XEGiJCjih9A1DAb0LKsYYrdrmocrdyp46ZBmImlj
         3pQyFgCCkfNbL3vCCI/HZev5bzcEDLonkOjoCeS7xX5K6RGpCm0D1gXRG698JtoL5P7f
         hhDUblswHnVyGkmPg11nm5iH05D1AYjTvYGZc/cqP9BiDNOk2b9DOMzyIthyx/kkiX19
         l2yQ==
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
Subject: [PATCH 4.14 017/109] usbip: vudc: fix null pointer dereference on udc->lock
Date: Fri, 16 Mar 2018 16:22:46 +0100
Message-Id: <20180316152330.899540834@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108911326820981?=
X-GMAIL-MSGID: =?utf-8?q?1595108979842271721?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
