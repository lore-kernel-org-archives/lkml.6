Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+sSfCFO4ZmDBVmXVjeQD2xWaJD+hjcCzi3YrDd3PwxqEnNvVo5K/IuO87k1SLdL/Lu+PNV
ARC-Seal: i=1; a=rsa-sha256; t=1524652771; cv=none;
        d=google.com; s=arc-20160816;
        b=awAbY+YuN1TaeG6XJwsd6aazBTkkSCBNUlQuSO6QUAwLG0tlHaeQAsOi2KNOlv2B0c
         /Hp1EASJh3ReX7c4xSR0BJxIIs18KGaoBnNzyIRcKhI1z5zSLAQsRvYUgatUYc5PNin+
         qsXdl6xJP1WVxvO3hJ0KRcZ3kX+9uRboOqZCduwO1n5MUx4bP6Txh5ynWt1vUqgn7tZ/
         omtjGo4uDTElIw0dpPO082GsKvmjXZLdwoWsX7sX1m3DLGUhRtvqZuPIGsTGUvFHiT5k
         X+cI3Yd5IXCCcqQDyn5QAt59RY9dPTOOhW3mP9n724Lk5VEw22LUBAeQTd61o0KmzNXj
         8vpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JVdhodRvBuFs1ScLrseb2DkcHoWjeDxs2E+7UoIznWU=;
        b=K86lzQr3UChXqVstyrMzedWBVCYuA6yhSZg/vjB2oT10XRsACCECWhIVvkkj9Ued2Z
         yJB1r7sVnKOjXkVztibG6y7mWmODZGu6/jffXbZel4HgdCrjImifJ4TDby/yN5FYSEJD
         ciw56XY3hKCDw1LnizY9GQCF28TaHD00CHljsEtoj7RJ6hGY4tnvw+xVjj+amzZLvGkD
         1KYJihIg9WzV+rl633AjgmdytbphaCZ+USPDiTRb6EGM5LN+wL3d8eFzAwmYj4xSRM6U
         4m5OXG3SCNCide2RFtBwsm1rLt9BYyotjLR2r7HJgGRgt6p6TWW9EKhcZwdkqQTrahSh
         m2HQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Wei Yongjun <weiyongjun1@huawei.com>,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	Corey Minyard <cminyard@mvista.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 062/183] ipmi/powernv: Fix error return code in ipmi_powernv_probe()
Date: Wed, 25 Apr 2018 12:34:42 +0200
Message-Id: <20180425103245.022758740@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714304377141492?=
X-GMAIL-MSGID: =?utf-8?q?1598714304377141492?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Yongjun <weiyongjun1@huawei.com>


[ Upstream commit e749d328b0b450aa78d562fa26a0cd8872325dd9 ]

Fix to return a negative error code from the request_irq() error
handling case instead of 0, as done elsewhere in this function.

Fixes: dce143c3381c ("ipmi/powernv: Convert to irq event interface")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/ipmi/ipmi_powernv.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/char/ipmi/ipmi_powernv.c
+++ b/drivers/char/ipmi/ipmi_powernv.c
@@ -251,8 +251,9 @@ static int ipmi_powernv_probe(struct pla
 		ipmi->irq = opal_event_request(prop);
 	}
 
-	if (request_irq(ipmi->irq, ipmi_opal_event, IRQ_TYPE_LEVEL_HIGH,
-				"opal-ipmi", ipmi)) {
+	rc = request_irq(ipmi->irq, ipmi_opal_event, IRQ_TYPE_LEVEL_HIGH,
+			 "opal-ipmi", ipmi);
+	if (rc) {
 		dev_warn(dev, "Unable to request irq\n");
 		goto err_dispose;
 	}
