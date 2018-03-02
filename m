Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsk0mAU2c4Qrpg/XUQv3HFIREHPf0biepsDm4i83U2H+PNqbQYfLDXjXa2jw4m7y9AyXixd
ARC-Seal: i=1; a=rsa-sha256; t=1519981432; cv=none;
        d=google.com; s=arc-20160816;
        b=s1NPpW6OKgwVPqDl3BDtL/FlJsvXHNwMrGrwgOZ9ncYGt2NT8d2WTjqZxxRJjPdEnT
         GClHZvWZ0rYcurW7Snb9P9fGOmZ5sRm+uI6cx8AyoVT7+deH30NXEw5iI2PK/waZs+YD
         ckvY5wagwgHS/pP0aEvKKy2rWT2yObtWejdry9lSVp+bUY537WCA7/XOA1wgyTgLM/kJ
         05wlCqa3E3ZPKvZG/DDbIgUPihsqJKG2EX6WBSCA9fCrO/RmlgAUh7lpMsmMQN+Y1HKo
         Jz5T5W79Om7GQ1yFs6hnQ6aGUv+BM5WJTDT1qBCGTSj58IfOarBjfGvJMFDpkZzPa/UJ
         4iLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jzqIwF1ZA9jOKQzAd5PnzC2nxDsm0mOqiWgUtprat0s=;
        b=GXURfMRQlsk5/PrimvVBGywlERvWA5xzqajtmoXJm+qHY7CArr/j7+K7evxHCcD3nz
         bq8iGDuoUNLHAMKSnMAyuet74VNNf/G91f0dTs0ZtFj8SsnX8WQoCtXT71xGiqfB0N25
         frbLfelbSIVWSSbiDSgzBcl9WQTYX+Kf7CnqhIund/ohNp5XLnShBycG+HzhSBE2iNFS
         9DAfJBiS8g8cybXgf0alCLcN1WnWP+CLbDJ25os6JNSDkezz9ip+czrX5x3LFE1739Wj
         FrRszKCEPzGTN0i/FrKkt94iqjySjULPMMbINeRZWeLZdmt3rNfnr/3/R/lQ9aeyECKU
         jVXw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: [PATCH 4.14 062/115] led: core: Fix brightness setting when setting delay_off=0
Date: Fri,  2 Mar 2018 09:51:05 +0100
Message-Id: <20180302084506.388001450@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815285215753423?=
X-GMAIL-MSGID: =?utf-8?q?1593816051434190819?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthieu CASTET <matthieu.castet@parrot.com>


[ Upstream commit 2b83ff96f51d0b039c4561b9f95c824d7bddb85c ]

With the current code, the following sequence won't work :
echo timer > trigger

echo 0 >  delay_off
* at this point we call
** led_delay_off_store
** led_blink_set
---
 drivers/leds/led-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/leds/led-core.c
+++ b/drivers/leds/led-core.c
@@ -187,7 +187,7 @@ void led_blink_set(struct led_classdev *
 		   unsigned long *delay_on,
 		   unsigned long *delay_off)
 {
-	del_timer_sync(&led_cdev->blink_timer);
+	led_stop_software_blink(led_cdev);
 
 	clear_bit(LED_BLINK_ONESHOT, &led_cdev->work_flags);
 	clear_bit(LED_BLINK_ONESHOT_STOP, &led_cdev->work_flags);
