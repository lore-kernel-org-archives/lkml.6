Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/NIODONEMzvKyO/3piGI6HeW2lBpzQtPGm4GcSvbLkLfbnaGwfxbq636/oXL1HGAtnh0eK
ARC-Seal: i=1; a=rsa-sha256; t=1522346741; cv=none;
        d=google.com; s=arc-20160816;
        b=teYmxcqQIncOU+LmOyVGu9lzU2L9tXj3z02QqGVy3SwDih7tgietvaqFN+bNymJG2n
         U1G6Ho3mNgYUiDpJ2AAh1FapcBOfpORNf5Bo189Dvhl9d+VYYBCfOyJAg/528lNRX6Oc
         Qdz9g3jTTA7/jZ1JKvAKX0YRart2tcR2KodFl1yYXB//WsDFwcdLh+fCJZc2Nrz43gz0
         S7HAJO9Ootz2nhLbo6fPSSSDZ1SM4dmWb3W/fcz3rQzAW12oudsbjxLj07orFLhm2e3j
         DFCUy04UzEJiPSUGheaVtxezzOQBh6FFbPCJcDy9dMz2QXs7NbFBVL5yR+FKewEkC/h8
         uqkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nizjFHjNXexOuiTNUDNBT58t6ZYyNEs4A2iq6WlAFQE=;
        b=jRVLEU6/hAWL9ph+kuYj5lvnT/ZOzktWQGpxU+XgvahvTqd01pZoogIO2LkExIAA/V
         1KJFotB0UDmvlU4oUpWjktCFfHKnCcHduqTsEyjYOTjVkzB6PhMVY5v6hxF0310AieEX
         JmUFoVU/03WYBBlBmX9PtyP4vUhio+Fg0ytLz9An5JMfJLR/HESOL6sAdKUxNcX0ekfW
         i00OgAfQdwGkGlAumCInLzB625rzOrC2woaK4qMHLi06I0E4gyWz1sHF3h3XwWh9MN9O
         RNsJ4nEmXPQgXBCiQBFlBwhga4gbcZhCqrKg6CuoRkP5fsrFxPV+3nHI1rc1D/usYRro
         rDlw==
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
Subject: [PATCH 4.14 41/43] s390/qeth: when thread completes, wake up all waiters
Date: Thu, 29 Mar 2018 20:00:36 +0200
Message-Id: <20180329175734.630100590@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175730.190353692@linuxfoundation.org>
References: <20180329175730.190353692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296066112880212?=
X-GMAIL-MSGID: =?utf-8?q?1596296256904133476?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
