Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+JzUFrD5bT6fqMtbAHyrlsGSD/yyj6N6yqPcXYrlSBhi3ub+u9GNVBOgYXYPosc3iEoTj+
ARC-Seal: i=1; a=rsa-sha256; t=1522346814; cv=none;
        d=google.com; s=arc-20160816;
        b=oVkGhX6b8Suaar8A1MROpJbF8QRljFZpoGt2AaqCde4fg2L5RjmhzYHcKJNMy87ZbZ
         C9ITCidJmMuKwyVQwUUmZ0BwHrKlj3MYwAb2jzMYiDtbxMUNOnMB7N695kL7Uxrbh9cB
         kJ8HJrKpl9Ud6dcTsjQU4SwQoZylWDRHUyO+3l+w5MxOJLs4bxKX7t3cPZuF4dHTZwSZ
         aZOMrclKe4cwUEz0pJGpaz2PNasM3dgyfKdnZ4hIVXD6X8+7gDUNbbXCZu3AEGwlGf0l
         ukBtVgbCiW+x2x8hGDCoAk1n145OVyg8rhsBWnArnh7SIBQAsXwmY6LtEfQwvKjZAUu8
         pfHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yA35Ju4coayLt6xqiZikx++GFkNSjsNEcvh2W7wqsVA=;
        b=D9LeDHY9uL72Mo5/z6o5ZZwcCEE97Mc0y9/Arl+43g8FcdTs3PnP2tMWaC7+k5i03Z
         H5tAij1a7VCwFmT+FXc30QfOSKE72OtKaNw+Yjya5gsjWv2xG5v444E7WOgvgQ0os77m
         x1JkZI8x3vMjhIInfe4yvHzeuNzoEP3Am3cFvzmS1UiO4AyWolkoM0lL8HtKvr+GtagZ
         JpMmDS9Eg6o2NGSsBmiuq4UUtgsyQK9Q798KQZC4kX4a1+GUJXqQ+OddNAw+tMxpKaNH
         mGtR/E1vEzvICHZce0ON8XPqwOvCYTZ8SLK94Eisa4KcebhNHrPM4r5S0x1m46J23477
         QPiQ==
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
Subject: [PATCH 4.9 23/28] s390/qeth: when thread completes, wake up all waiters
Date: Thu, 29 Mar 2018 20:00:42 +0200
Message-Id: <20180329175735.968129458@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175733.447823703@linuxfoundation.org>
References: <20180329175733.447823703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296066112880212?=
X-GMAIL-MSGID: =?utf-8?q?1596296333092182841?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -957,7 +957,7 @@ void qeth_clear_thread_running_bit(struc
 	spin_lock_irqsave(&card->thread_mask_lock, flags);
 	card->thread_running_mask &= ~thread;
 	spin_unlock_irqrestore(&card->thread_mask_lock, flags);
-	wake_up(&card->wait_q);
+	wake_up_all(&card->wait_q);
 }
 EXPORT_SYMBOL_GPL(qeth_clear_thread_running_bit);
 
