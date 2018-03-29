Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+fdu5kzbM8Dw2W6cp1WNwQlvcteaxzFItGF+TxoPxBuhF1A5gdyIGEYA/qt1C4eqdOc1+N
ARC-Seal: i=1; a=rsa-sha256; t=1522346562; cv=none;
        d=google.com; s=arc-20160816;
        b=lAl39ae0t8k7bIB2qKIuHlRSr55lWTt7rOg2UVoP6P8JuDedp8VMXLGTSKKoM/GtZq
         3+WyC5z4yRYWB7/qJt/0ul9G1cIBiZoIXSDIy3qBUYfvPNLKS0cKn/VUw9O0pIZdErsY
         UKGfjbXXdVhlCvF8+4g45M0xwy1OCSOAhQn2br1RyH7U6Rtr3PFvNnqeXwEAFRml+i/d
         mKOtf9gMIH81CAYVp00ZybnpXILFL7QqPpK3IENQzeAamplgszQixWO3vkUiz5t4DhEL
         xvRur7kYi/ENSZuR6s1fwNuA08/Iqh0ZkEUIq9OIfYiUh2kCwbGAb12/oeyUUZqutAUd
         gjLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7TWBjXP1mc/kPOOKDLEbvCB5VPZFGujbmGOxbJHC2Ug=;
        b=Rkp+csUqvZzbTjrQ7il2SQH8TqD6Xc6kjioRRp+2TqN9DTIFLqjqVg/DI4K/3GveSR
         xkAiM11vDrd6mNlUqhIxIhHVv5jeoOGngMu5GtxLiVTjF5YKmBH2LDMWRZ5Qy5Rh3R7n
         RZzRwKWgB48J+37Bs/7964JUn5YX0VjsF46Vthi0f4u8e5ek5xYoP34becaj6zoCc2kv
         iuPZmJrmJrf1Gi8MuDEEUzOdzJo1EVFt4tm+8AenYxHfFKa9nIUDP05ie/n+uS8PRiWn
         E5mL9vvDpEQQesieSA/vIP71kZLamZM91PsdT/5Lz7qPQgLZQpeAtGf8TTsAPwKuu5Jp
         wS3Q==
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
Subject: [PATCH 4.15 28/47] s390/qeth: lock read device while queueing next buffer
Date: Thu, 29 Mar 2018 20:00:09 +0200
Message-Id: <20180329175731.452004879@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296068868373661?=
X-GMAIL-MSGID: =?utf-8?q?1596296068868373661?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -526,8 +526,7 @@ static inline int qeth_is_cq(struct qeth
 	    queue == card->qdio.no_in_queues - 1;
 }
 
-
-static int qeth_issue_next_read(struct qeth_card *card)
+static int __qeth_issue_next_read(struct qeth_card *card)
 {
 	int rc;
 	struct qeth_cmd_buffer *iob;
@@ -558,6 +557,17 @@ static int qeth_issue_next_read(struct q
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
@@ -1183,7 +1193,7 @@ static void qeth_irq(struct ccw_device *
 		return;
 	if (channel == &card->read &&
 	    channel->state == CH_STATE_UP)
-		qeth_issue_next_read(card);
+		__qeth_issue_next_read(card);
 
 	iob = channel->iob;
 	index = channel->buf_no;
