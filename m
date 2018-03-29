Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48XAEyNjiRaQxi1q+inLIKl6UKJSSaMrHgoE7QvMAW0Yp8kfAgSD8+cYJLvOcsQ3CWr9HjV
ARC-Seal: i=1; a=rsa-sha256; t=1522346896; cv=none;
        d=google.com; s=arc-20160816;
        b=GKDKpG7fhqxsVV8vhW0EPWXQSa/qkg3MKXU2eeIXp4PiSdbPz9wZLOI0RtBv4FsGL0
         RdrUsyEB02Je0Q/QL5ce5nuLY998Vw+jEJkzr7nkHbaphoDATMS5684d4kkCrCQJy0Fi
         Bf+0bOEvJVK838z6QnB3P+J2AzabJOCyykXdFjkMbFcrGMOkyQExuNjaDcSDTYrBRjWs
         HgybfCHCCZJPD6fiYEmDFUOu9gGQx0iCNuP2g/RkHlatgo5rZFgjXKXwm0BIJhQI/lER
         +gIfmkvXGxWJbpPBRiP8yYVdJEROg5TcjL9hM4DTMnBbQrlElFephFMvSiAm0W1eMyjn
         3yxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Xn+YMJRel8ESxNXYt3KuIsRCoUpnVyu9notBg+qiuAM=;
        b=U26EmtmzY2Gh0B2WWgHsQw4Pc7rADY2cYjUnsR6R0e+SV8gZZ1+mz6QVUqZzV5xhx4
         mVeLZr72GcDq5/QiyiH4/bNasQmLDIBPTmKvvVP6OPX3Kx3GsnK7tnfKky22Zh/KkFuK
         z42WKibuN0dqR29CddL7GEpoMrRcnr4CafOL3EuujfMfS+6Nm+GFXKQnIWiJA18fhEDH
         L7Z4s7Hq8gvS4+jJFKtX/gBEej5KfkDPmmgrPRSTNNCnJUNlSmoEdEJqiHXxKbfdliC2
         F+Exy08+y9xFoXBoJD98uZuqH9p6P36MgY4BvvaDnc6ELfLyMBtERDGZjhii86PkjGzC
         2i8w==
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
Subject: [PATCH 4.4 16/20] s390/qeth: lock read device while queueing next buffer
Date: Thu, 29 Mar 2018 20:00:52 +0200
Message-Id: <20180329175742.721313684@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175741.886181131@linuxfoundation.org>
References: <20180329175741.886181131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296068868373661?=
X-GMAIL-MSGID: =?utf-8?q?1596296419364951278?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>


[ Upstream commit 17bf8c9b3d499d5168537c98b61eb7a1fcbca6c2 ]

For calling ccw_device_start(), issue_next_read() needs to hold the
device's ccwlock.
This is satisfied for the IRQ handler path (where qeth_irq() gets called
under the ccwlock), but we need explicit locking for the initial call by
the MPC initialization.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_core_main.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -517,8 +517,7 @@ static inline int qeth_is_cq(struct qeth
 	    queue == card->qdio.no_in_queues - 1;
 }
 
-
-static int qeth_issue_next_read(struct qeth_card *card)
+static int __qeth_issue_next_read(struct qeth_card *card)
 {
 	int rc;
 	struct qeth_cmd_buffer *iob;
@@ -549,6 +548,17 @@ static int qeth_issue_next_read(struct q
 	return rc;
 }
 
+static int qeth_issue_next_read(struct qeth_card *card)
+{
+	int ret;
+
+	spin_lock_irq(get_ccwdev_lock(CARD_RDEV(card)));
+	ret = __qeth_issue_next_read(card);
+	spin_unlock_irq(get_ccwdev_lock(CARD_RDEV(card)));
+
+	return ret;
+}
+
 static struct qeth_reply *qeth_alloc_reply(struct qeth_card *card)
 {
 	struct qeth_reply *reply;
@@ -1174,7 +1184,7 @@ static void qeth_irq(struct ccw_device *
 		return;
 	if (channel == &card->read &&
 	    channel->state == CH_STATE_UP)
-		qeth_issue_next_read(card);
+		__qeth_issue_next_read(card);
 
 	iob = channel->iob;
 	index = channel->buf_no;
