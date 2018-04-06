Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/1fQgqjmfKnkSC87oqvGZyLWc+BmFx8AY4pj72Yqfj53aBOkl7vz+/Ia3cFdh4swEnHknU
ARC-Seal: i=1; a=rsa-sha256; t=1523021175; cv=none;
        d=google.com; s=arc-20160816;
        b=tSUMZbj8JCr9Uca54PF+9eBqdVINXH0Zwxy6IG6SuSbcQAxeUWnBxDjw/tqqQmsSTX
         avsXbve/kfQsYBiOrkSX528jDaT0dZ46SIWy2JliFdyOqFuvPE9G+u/XuhDVxAzdNuZF
         dF6W1WC6/JLSJFxLlKJI4J9cGYPow4+KzsHoUMmM8nFh3Bf44mm9zTT/WxrScEW1G2mx
         nuBc4JhsdoXJN5FDQX+l9P0gpOCEY7K1z1uBAnpkl2Lkl33kbLn6BeWi2dqihnafl9ny
         Q24J0iVUBJQ5IFz5+wL6L5HG3kJ2igsKTG3R5ovpLW3u5Dm2imQdkuTT3JOd+RdyH/Ms
         n8vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kf97MUoFN3oIVFznvFxW8AVcLHuBrJZ1l0pxEA8I9yk=;
        b=Pbb6W9G5/HNIzI+R1ajXIFbbsU6jPdNBbifC8cb+Z5GjSJs1jM16FENjt50CI4+RYv
         XxXXuASlong3d2eQblyJmixELBZOZLlRa3sf8SIjcVwD8qBNgPd/iJdfEHq7dLepk9Ee
         yOx3Msmu56y3ugu7Z7yvfhfqwo2SnVwHCfqvyk+UoWoerWT2aafllJmNbcTLDMXadz7b
         N5vrn8tc3HSL9DSfO9j5ObFDcjr8qhQeQuS5iXZ6JGGuQPjD721VhaZwawgXNhk60zFp
         iHNLRYMzcaP53nqmkrI+2idHcNstAk7i9pQHbpUXyWYDVLlkEfp0p2pyAybdbLku3VLW
         cymQ==
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
Subject: [PATCH 3.18 34/93] s390/qeth: lock read device while queueing next buffer
Date: Fri,  6 Apr 2018 15:23:03 +0200
Message-Id: <20180406084226.422048110@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003452882083165?=
X-GMAIL-MSGID: =?utf-8?q?1597003452882083165?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1166,7 +1176,7 @@ static void qeth_irq(struct ccw_device *
 		return;
 	if (channel == &card->read &&
 	    channel->state == CH_STATE_UP)
-		qeth_issue_next_read(card);
+		__qeth_issue_next_read(card);
 
 	iob = channel->iob;
 	index = channel->buf_no;
