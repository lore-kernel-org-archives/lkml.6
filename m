Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+5QaDKOsHDkfienNqKcGwInzVUZK9fPMvOZmd7lm+Iz1Csyij1a1zTyHs+82WRpXVA/eKK
ARC-Seal: i=1; a=rsa-sha256; t=1523021173; cv=none;
        d=google.com; s=arc-20160816;
        b=E7dSHP/OUQt/14de+obkTkpwXgh+VRUB7pq5sp1x3/9k/RecaBsSeDBV5kBkj1vkor
         CUbE3LLiTvzmptQSQqTiZd9ZlivW4efTsJ7CyNxTwGFx0bbETCXc0siOOxBvomcBURgv
         FRq4/7ZknvU6eSv7Vp67GS+yTIfCMoW6e/pFSsuYH29QGKI9BK6OlDAWjCUxfKpGJmRP
         YBmUykMsOKFK8aEpkSsV3uwItGoDgvGIq0Nc8bS0bKKyAvdTGItQkffDvQ83rrw+cbb+
         9av/pGsO7q3nhX5UTe9PcU+T7cBUgZxUk0DlWPyVi/kQHjZr+6LRRzr1q2jaXNCpvhwi
         Fo+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2Z+jOK3dFZzlIBHWmkWYet5cc4kxvM4rcqrjMdPIWgI=;
        b=QpppBsOEHZFO0ZccbCygUpDHU0kSqsDAClgmAIPTzlgbBeashwrJa/2e8sr4XpG9jq
         lGMkJlSwq28ILeO0jAlEDVgfdyJQ1JfQ2j/YjSMR/6ijznSrv4o3L5pc/WkgbCQi1a2o
         6bBZLu94GSfmfqfaDrgKYLvPA31NkY+MH4XF6uWRCFpWvcfdGlv87xQUNk7C3L1IIdGa
         a7Vn+iZpvKCqaQxqUTO9V5WwToRXSe6ztbI6+PoFbGZKktrhAecbKcJIBCLfzYBCvSvK
         Eae8ASLjrbZuAxgsTH9uWhfvvpnh/8Ji20EboHNBJ7npmHBaK8IBdAvsRcHIS//zTCaL
         dv4w==
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
Subject: [PATCH 3.18 33/93] s390/qeth: when thread completes, wake up all waiters
Date: Fri,  6 Apr 2018 15:23:02 +0200
Message-Id: <20180406084226.385964034@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003449320362855?=
X-GMAIL-MSGID: =?utf-8?q?1597003449320362855?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -944,7 +944,7 @@ void qeth_clear_thread_running_bit(struc
 	spin_lock_irqsave(&card->thread_mask_lock, flags);
 	card->thread_running_mask &= ~thread;
 	spin_unlock_irqrestore(&card->thread_mask_lock, flags);
-	wake_up(&card->wait_q);
+	wake_up_all(&card->wait_q);
 }
 EXPORT_SYMBOL_GPL(qeth_clear_thread_running_bit);
 
