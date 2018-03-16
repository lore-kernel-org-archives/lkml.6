Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtMGuEI6pwveaKpCmvZ6p5M7DgFtwXk7i5NcicdcLz8g7wzY1C1UUTSQtOqg+xgjLg61Sy2
ARC-Seal: i=1; a=rsa-sha256; t=1521214777; cv=none;
        d=google.com; s=arc-20160816;
        b=TLd9X4KStMvwnkJmkIg5CK+rwOfRnWK7Ed7ZhzjM08V3Ta2k9RpRbC/WcofinMf93D
         YzhMF+ZopkZhec8hRCj0J1bSOQ31AK1egvri5vZ3FqNySTCv9ewIjqwApKujxKyKz1p5
         FXUANja3A3xPlql/2sKD/9nP6G8C76+N15NWomqiXcSaUbw0+aZL8Z+gvHpigH69vj3z
         LsOuTd18b/iit83MZtktEr7jua+7SNh+WjAzkIYknZKGn9Wyjw1MytmXc6fo3o9a7JRb
         vllo/BLaBDKGPM5wDKrMdFLXvLA0gVKIjmb6BDjXKs6JN/9KKMfE/StDtkZPgA6CZiwV
         Bn6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=no+fIsZ82Drx+o2muN/Bc7yiWhpsOrpyBGz9x3ooDso=;
        b=E5GYH00mJTn79jYEJcB/vxdE1IqpTWW7nKkyeGalPVlCgRKCiDnb6fUf94vy1SxfLO
         EHPc1XfUlzp15MsN6NQuE1s0M8bCGduksRldZrLE0JvrGwVLNMaE/cnWQ9sbvtZdQWwL
         jAclJoPFQ6ZRSQh/vEDaWJ42D0BzxKSDI+2/4sfoPIKsQO3Q14lxPKkU857SRmPBs57K
         xdiTIxJ8OC3qZzXfhNMM7oI1gKu3Hv90HV9rhDiyBA4LBIQLn2H/3YiY8lEOdow0NB5f
         YameZLIFWYdXZzzBYJgRIiDwkuWaHx3Bfk9V9V9jnL+xDOSZ4MVkfb1jMpDmKMSgx/kk
         Vs4Q==
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
Subject: [PATCH 4.15 016/128] usbip: vudc: fix null pointer dereference on udc->lock
Date: Fri, 16 Mar 2018 16:22:37 +0100
Message-Id: <20180316152337.208011989@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108911326820981?=
X-GMAIL-MSGID: =?utf-8?q?1595109306602039578?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -105,10 +105,14 @@ static ssize_t store_sockfd(struct devic
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
