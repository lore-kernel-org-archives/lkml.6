Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+PzF9ze3l36PPNjtMOxy9TigAvx1PYMWRWzyyklKfI2R8gpH+c0+zqGz4o9XfmoG/CQIQW
ARC-Seal: i=1; a=rsa-sha256; t=1524652896; cv=none;
        d=google.com; s=arc-20160816;
        b=CMrdFzPY8YEgkmbZJExtRCQEj591PjxjYUjzeBKCyEiG7E+Fq6UKHmyY4Sjz4X9Yww
         zC07nYOIkniJPg+Yf59A582CBQRX6J4rXsB9Wz7SayNL+JcGoRv7Ql4pXzEuAM6tJln4
         uNFUtEb7jf0W2wQlDW13D4S9zL4sKU+0kb7qtfdxf5+zm9F7lTm+Ka1rPqPFmyTB0LJn
         3bdo/hxcmc4bQ3V+ij2FBNLvIDzfkqVuyDASdl8DUATpJe58C8AgLx+ivBhluxDGkG8z
         FooMahWncXRsg7dfcWm0mccVqAuFxAqT/RTBOHWkn58uYSIzJa2EaqvHMzVnsvIGmbPn
         NoDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=k1PpsV/ci/nRJ8yi0Rytqb6A6mLvSB2BrZOrywY2L90=;
        b=YvhXYA2GltyfzJw5jz4Y6skf9N8OC7kUtBzBVrQVR7j5sNwHdPRSoMSBsbJwLVaf1u
         aSyjB/dHWtqr+s2PT9EjTYGwnUl7PWsfcwPi3yu492s8arW4W7lsG/p8LmC2CUo9hJ1/
         EJNyUujcciw72OK4pfPBtOO/IC39luUnwCx6TKaHjVEIKIh+fHjGS5ToNWhvz+peCYBr
         b4DDEl9vzv383YNH7/+rXB2NsQnyZg61rw+eZlCV6NbeQhuJzWCrrlUigq/ku1I16KI9
         NiaZzEudX8XvXYTTCd+rIQytNX3WKn5h/OXkgXMMeHiYu1FAlfMfdnEStv37D/1+xD6m
         HIGg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andi Shyti <andi.shyti@samsung.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 073/183] Input: stmfts - set IRQ_NOAUTOEN to the irq flag
Date: Wed, 25 Apr 2018 12:34:53 +0200
Message-Id: <20180425103245.454700325@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714435450270718?=
X-GMAIL-MSGID: =?utf-8?q?1598714435450270718?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andi Shyti <andi.shyti@samsung.com>


[ Upstream commit cba04cdf437d745fac85220d1d692a9ae23d7004 ]

The interrupt is requested before the device is powered on and
it's value in some cases cannot be reliable. It happens on some
devices that an interrupt is generated as soon as requested
before having the chance to disable the irq.

Set the irq flag as IRQ_NOAUTOEN before requesting it.

This patch mutes the error:

  stmfts 2-0049: failed to read events: -11

received sometimes during boot time.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/touchscreen/stmfts.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/drivers/input/touchscreen/stmfts.c
+++ b/drivers/input/touchscreen/stmfts.c
@@ -687,6 +687,14 @@ static int stmfts_probe(struct i2c_clien
 
 	input_set_drvdata(sdata->input, sdata);
 
+	/*
+	 * stmfts_power_on expects interrupt to be disabled, but
+	 * at this point the device is still off and I do not trust
+	 * the status of the irq line that can generate some spurious
+	 * interrupts. To be on the safe side it's better to not enable
+	 * the interrupts during their request.
+	 */
+	irq_set_status_flags(client->irq, IRQ_NOAUTOEN);
 	err = devm_request_threaded_irq(&client->dev, client->irq,
 					NULL, stmfts_irq_handler,
 					IRQF_ONESHOT,
@@ -694,9 +702,6 @@ static int stmfts_probe(struct i2c_clien
 	if (err)
 		return err;
 
-	/* stmfts_power_on expects interrupt to be disabled */
-	disable_irq(client->irq);
-
 	dev_dbg(&client->dev, "initializing ST-Microelectronics FTS...\n");
 
 	err = stmfts_power_on(sdata);
