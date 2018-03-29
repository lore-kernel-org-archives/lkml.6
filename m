Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx491OguefXhzJXHG5pP8eQI1R7lRXTjtjEwJUB7a12fBfQMSa+jJfJsqdW6LsCr+zUCMbKkQ
ARC-Seal: i=1; a=rsa-sha256; t=1522346559; cv=none;
        d=google.com; s=arc-20160816;
        b=SQ/KyHjiAi/iQb2ieWBzZBKgg1J0sRKt1XW3rFkEiVT8i4f1a2PH61IQk+73fvWKYF
         GucQyEVBANnr8CRwXUGPpAZPnpZ0h1svox/3bVuPW1DtmIClaoz+lp9FHwCSVLRgOVdM
         whGjO5iuk3JlgBZk9EFarwcT2/uElIRANbUugpGxaYgPpErBUx2y9l3PGLfjRaQ7pP7L
         zyzhlc+tbh13kOI7elZTvCIbwQZzE1eW7tbbYIIF+JPkgFib95tCFTBIE6rH5kFWsHWN
         rirq4Tg59L9R3qrT3NYaI6Nn2ZTj6ZxMQIgyLgJI0u4X+FaZbL2fhXlkecbLib//0q7e
         YFLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JoxA7dC6UdmxfSobyjYBVuGQNFE6+uDyFxvkMgaKc7E=;
        b=v5S/GuNEt1gPmsRC5KKM7y5uoQaicvkRYKWaIiJLSTZS1sjLDLigjE1t5MclzXvW/i
         mx7+4HUUT6OxHF01gddLatxaHN2eycBWkT4wizs10uk+aKi0fG0GU6OZ7pfdtnXHM0Vh
         rcpA+fQjIHferdLkaeNhOY+hortDuHCuV1dnScDV8/66eWEX1unUR3kbfa/3uXeNcTtq
         A+s1tW9abhH/HJHUwEGXQ3Gsg+ziS81G0bfPzWhdw4GOcBxwVxhWOlWZUPUhl0Hfj/ZD
         lgYqzS1yNUBde9D3iptKnJCVwHy3Xm9ks0f0t8r2hcVVlIBUTNjPSVvr3S+Qn0fvApJz
         gfUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Julian Wiedmann <jwi@linux.vnet.ibm.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 27/47] s390/qeth: when thread completes, wake up all waiters
Date: Thu, 29 Mar 2018 20:00:08 +0200
Message-Id: <20180329175731.367006808@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296066112880212?=
X-GMAIL-MSGID: =?utf-8?q?1596296066112880212?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>


[ Upstream commit 1063e432bb45be209427ed3f1ca3908e4aa3c7d7 ]

qeth_wait_for_threads() is potentially called by multiple users, make
sure to notify all of them after qeth_clear_thread_running_bit()
adjusted the thread_running_mask. With no timeout, callers would
otherwise stall.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_core_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -961,7 +961,7 @@ void qeth_clear_thread_running_bit(struc
 	spin_lock_irqsave(&card->thread_mask_lock, flags);
 	card->thread_running_mask &= ~thread;
 	spin_unlock_irqrestore(&card->thread_mask_lock, flags);
-	wake_up(&card->wait_q);
+	wake_up_all(&card->wait_q);
 }
 EXPORT_SYMBOL_GPL(qeth_clear_thread_running_bit);
 
