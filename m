Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr8OanwTv7Sc9OVpAc4VFdJEXXxZHnQipgPa+Oed3CS7EV1sB31i2J5i3HwBzywrZmxDJ0e
ARC-Seal: i=1; a=rsa-sha256; t=1526281072; cv=none;
        d=google.com; s=arc-20160816;
        b=Um5KpfURuk/kn0V5pFWBpiWK2iUODNfjtziZOieVBVNqPYtJYzc6cEyRJn55RjituZ
         ILLfXpToIA8fVU1IA0b3jZb9pqNRfdFTC7zNeDj2GJ2pIRUBDwi5x9lGU9kkABumlVSK
         zY9H9+SeKQz/iL4K5SM+OpZE7fThEGNRrObSqsKneXxQPNtaRbO/e3eTyfK8yAcm90AE
         KmO1zRq0xSbF6LPWfnOJK8ugzII1N6GlZztv7j7haf5Kz2zAdFANM5PFxRMQ3pBDwRFr
         ZfDaU7nxvMZj38y2EBT3MzgqAf3lNaBvdFog88NRTYZVfR6sfn7x0/C93gK2Kx2pdfVg
         XkPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=xXMh6mvdPGFtLUDd0KXCsPiCMYaa3rzGQugylA0unzw=;
        b=sTtmi3s0LPPYXXF6Q6a4XNz2nXH7AkvUf2RWDWynv1xMET23VMFR7bTe5IbWBmocYm
         FdD/+zcqKlBrwIC+hDy6+4CSBF6fGzllfM4cGg5Bc/usC+NpZvLcC0cc8ecKYrD9lODT
         fY1vYr3yo2LIBxBZzxBU/qSFLazG44p2jSeIHVM0oJNiEc3Bhi5gkNutHHvki4tB/1TT
         uwkDYN8DC3ubOO1LCEAP6X4/Dl2ywg2vc/+7NvWW44FYJlcyI7uutaqCtYOk0g6Wqr7J
         nHCi2RXp3Fika5e+vc7Kxw5SjP5tTKjP+lQ4cI/L7jM5Sd1OD9OnHwMDW/KTo+TJKVXO
         u0LA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=aoeKb3D6;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=aoeKb3D6;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.14 26/62] rfkill: gpio: fix memory leak in probe error path
Date: Mon, 14 May 2018 08:48:42 +0200
Message-Id: <20180514064817.831588617@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421258890786882?=
X-GMAIL-MSGID: =?utf-8?q?1600421701637641616?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 4bf01ca21e2e0e4561d1a03c48c3d740418702db upstream.

Make sure to free the rfkill device in case registration fails during
probe.

Fixes: 5e7ca3937fbe ("net: rfkill: gpio: convert to resource managed allocation")
Cc: stable <stable@vger.kernel.org>	# 3.13
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/rfkill/rfkill-gpio.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -137,13 +137,18 @@ static int rfkill_gpio_probe(struct plat
 
 	ret = rfkill_register(rfkill->rfkill_dev);
 	if (ret < 0)
-		return ret;
+		goto err_destroy;
 
 	platform_set_drvdata(pdev, rfkill);
 
 	dev_info(&pdev->dev, "%s device registered.\n", rfkill->name);
 
 	return 0;
+
+err_destroy:
+	rfkill_destroy(rfkill->rfkill_dev);
+
+	return ret;
 }
 
 static int rfkill_gpio_remove(struct platform_device *pdev)
