Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqzwzBe+08ytlKbcp3+g3Lwhw04nIS+E0kTBwLdn+AuqssAtI89s0W7x7Ah8Zy/GdHwGbYR
ARC-Seal: i=1; a=rsa-sha256; t=1526280900; cv=none;
        d=google.com; s=arc-20160816;
        b=Py2yXJEkAie9wJqKvLf0+O4YDOIIfXRc6DN/dZ/cX8e5vmZwrHgLlIkX94B5W1bKjB
         cE/Bcxf/v9HbOciRe9ZhO3bC+sHHqDfCGHo4wMlCNzjevoiJKm16Oft9nSLwz1t3Fuf/
         Ka76ZHXS6IO/oPtoq/XPiG6xKCVPiFGWlhB/+eDNqTU5EPqVBlv6v9W0pvKlJHN9sTha
         seuU1KCWEHrxET/VXW20ZGzDoOJqVch64hCl9jAszH4UtkJMFLBdg9e9AxJsQD2i78Rp
         aFFd3goW56xpzh11sechuJ0oFk9kVIgNeSoz1sCwiHypd68NC5JZnEibrGV5PNkZKZBB
         0h5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=8sK8DwHucXxp1UgRyGkhuPwNiAlBUt1PV8bdh2vLUHs=;
        b=noL9eJWalMFapRE/9Jd3GncxatZOQRDeqaT7aeAfNT2Pv+fgAfuqlK+qkGBlBVvhhi
         vYzG6dxLMB7wieOVhholzcpYUYHtSc7nP2hpVO/ztu9h69y6BMvoPRoL3tPAUkvxEd9y
         6l77hjga5dRwJlI4YlJuhqLe2z3vfbbaeiZfnDppNmB6x79NTcJwR+nnpvM5qtqg9Wmq
         Zl5p5aShinmfVr3Ys9+6A8E2ra7pXE9xGkSJWbHTI/E/WGFtBBxp9MaKHXe9WwW7e4LN
         vBQ8g3prz9U4nrycg2Qc2DoT5bBIjc7JL+v++VUTpjLXElOaJHurSSlSm8kQdrE6FVdv
         H6wA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=IAFe3Vpx;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=IAFe3Vpx;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.9 20/36] rfkill: gpio: fix memory leak in probe error path
Date: Mon, 14 May 2018 08:48:54 +0200
Message-Id: <20180514064805.849077502@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064804.252823817@linuxfoundation.org>
References: <20180514064804.252823817@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421258890786882?=
X-GMAIL-MSGID: =?utf-8?q?1600421521127062869?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -138,13 +138,18 @@ static int rfkill_gpio_probe(struct plat
 
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
