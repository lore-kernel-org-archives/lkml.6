Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/rWiUBGn8jxWL20RxYDYQFaLMkEWHBDP2+ybWNXUrmtkP/H900I4z2mCGchV9XYMqZtV3s
ARC-Seal: i=1; a=rsa-sha256; t=1522346816; cv=none;
        d=google.com; s=arc-20160816;
        b=nrzelvRO7izh5kHC197WSQ5w+qXMTjAiAZbJHtIc6rbtNdM5fhh6BmaVoQCfZIDCgr
         +pMlCTLtv0UZwGKtlZg8fJj+wG5nsv9omlUh4IrFZXQPu5dGYuqhHjkisEr6O9Lhx1Yx
         mEfvyOM9U23Nxi09PzijZ+osAeWi53r0ufQXHoMBegh9XBz4m6t2nZQzee+MabkVLTsG
         Y3cQqutvyAOz76NiuyijvVMQodN8HGRXC7M5U/onqVMW3/5D+YtqxC94LNexSONjU6Z9
         yn6TIEUS2isSxMYt0SeJKj7cohbBko5Pqj/J47NGNzoviZpMuz+20Ez7uMYwYRKTS3fs
         F0Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CAVb/FIqo6nxlYSLMHBAE0AAecQYU8mu1QUTCJKE6VA=;
        b=YyaskGDWjvKA1DXfrOqANunvIBwpgQbHyBPZHi+5Ckbmn/1gi2UU+IyhYZyKI0Uvd6
         33tmYt2SHOfpPOEWRhkxLlk3k6/0JiL0uf2dCZ1eM5ABQbM6AL3NHEeSPsGpt0iJsOVt
         XS/zQ80pLjQn7JOF+V9p6PJcI3W+wju408+GoxlCoiIASsyCoyycW+Acdm4jnFeq7QJT
         vETxomTGQXrGY2IZdpEDVEGH/kqph2HbScF9xZdifT3dj9HRwns1WELFmv0deunazXIO
         9vWK6he3Tg7LXeyOavB9WqMrjV+89mLMT39vZIgshqi3kaqoUrFwjf2fsaPZPrGhGCxU
         3G1A==
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
Subject: [PATCH 4.9 24/28] s390/qeth: lock read device while queueing next buffer
Date: Thu, 29 Mar 2018 20:00:43 +0200
Message-Id: <20180329175736.156599671@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175733.447823703@linuxfoundation.org>
References: <20180329175733.447823703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296068868373661?=
X-GMAIL-MSGID: =?utf-8?q?1596296335669710861?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -522,8 +522,7 @@ static inline int qeth_is_cq(struct qeth
 	    queue == card->qdio.no_in_queues - 1;
 }
 
-
-static int qeth_issue_next_read(struct qeth_card *card)
+static int __qeth_issue_next_read(struct qeth_card *card)
 {
 	int rc;
 	struct qeth_cmd_buffer *iob;
@@ -554,6 +553,17 @@ static int qeth_issue_next_read(struct q
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
@@ -1179,7 +1189,7 @@ static void qeth_irq(struct ccw_device *
 		return;
 	if (channel == &card->read &&
 	    channel->state == CH_STATE_UP)
-		qeth_issue_next_read(card);
+		__qeth_issue_next_read(card);
 
 	iob = channel->iob;
 	index = channel->buf_no;
