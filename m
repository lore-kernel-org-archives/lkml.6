Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqf/OG+n3e7bPGnfWMgkJZ+O/d+Eyj4L3b8cxpgEQngL4ARf2dCtxO10GXKB/t2HS5WakAo
ARC-Seal: i=1; a=rsa-sha256; t=1524838284; cv=none;
        d=google.com; s=arc-20160816;
        b=LcBVboXMxfe3wYtNpm6jkLjA0qG6i1+lG2DPRkoFTUA7VGA/ckFn5PboUiLXcisEq2
         mqpFLJT9d27zNhdhKFFFywKZi1FaGxTg7nzs8AKqduJDLHUB25A16ePt4Ybyr1jtyMAf
         MX5fvXgVETHhwes39Kghz26MHuiuoDoMe2rb3Gcit4lLKJ35AAsZ7k/rh2Mvwj42jOE9
         XrGh3NxsSrv545rZfgvNp0p1AXMcxhxRrZIPXwg4WAkCAHJxlt63hevRutsOP8J1vnRh
         P63bnw3NZMJXuBrMp5RJ0ceq8n/nIlAzTTn+tulvufwuO7LTwLXd4LPhNbyguETCHM8F
         OFsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=1qlKvrwbQWPuNKJkY+xSlcw8RoPYMdpvggG0nR7Nyek=;
        b=PhoJBpj77pDB6NsinX15B4KIe/rYQtadqGnobs3ILXcaa7doacGC28kZn7du/3jm4V
         Zm6joVzy8KBeb+rYqnUGVZquuMp+cGHqHA3yYe3X+MKtNJ73gp+KjHQoj9U0oiWP6QJ/
         bkaTvYHspq+gWz8c7VHAqvmxV6YUXagRD6MslshQ2aXAiv0C3ION2k9v9kywddJb0Ast
         mkDSt99DlCEKfsthJKRmP3UszjsFbMy7OHsQPu/SQqNp9vjed0TBw+AaemjUa7b80e9k
         RAmwkhHk3DsZShxHSOvvEJGACZLe0TnOEokawZEv95jEYOJ8V1aeKq0ZvHBdEG8svUF1
         oSaw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445FD21895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Julian Wiedmann <jwi@linux.vnet.ibm.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 48/81] s390/qeth: avoid control IO completion stalls
Date: Fri, 27 Apr 2018 15:58:50 +0200
Message-Id: <20180427135745.960188443@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908829090556921?=
X-GMAIL-MSGID: =?utf-8?q?1598908829090556921?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>


[ Upstream commit 901e3f49facbd31b2b3d1786637b4a35e1022e9b ]

For control IO, qeth currently tracks the index of the buffer that it
expects to complete the next IO on each qeth_channel. If the channel
presents an IRQ while this buffer has not yet completed, no completion
processing for _any_ completed buffer takes place.
So if the 'next buffer' is skipped for any sort of reason* (eg. when it
is released due to error conditions, before the IO is started), the
buffer obviously won't switch to PROCESSED until it is eventually
allocated for a _different_ IO and completes.
Until this happens, all completion processing on that channel stalls
and pending requests possibly time out.

As a fix, remove the whole 'next buffer' logic and simply process any
IO buffer right when it completes. A channel will never have more than
one IO pending, so there's no risk of processing out-of-sequence.

*Note: currently just one location in the code really handles this problem,
       by advancing the 'next' index manually.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_core.h      |    2 --
 drivers/s390/net/qeth_core_main.c |   22 +++++-----------------
 2 files changed, 5 insertions(+), 19 deletions(-)

--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -565,7 +565,6 @@ enum qeth_ip_types {
 enum qeth_cmd_buffer_state {
 	BUF_STATE_FREE,
 	BUF_STATE_LOCKED,
-	BUF_STATE_PROCESSED,
 };
 
 enum qeth_cq {
@@ -609,7 +608,6 @@ struct qeth_channel {
 	struct qeth_cmd_buffer iob[QETH_CMD_BUFFER_NO];
 	atomic_t irq_pending;
 	int io_buf_no;
-	int buf_no;
 };
 
 /**
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -821,7 +821,6 @@ void qeth_clear_cmd_buffers(struct qeth_
 
 	for (cnt = 0; cnt < QETH_CMD_BUFFER_NO; cnt++)
 		qeth_release_buffer(channel, &channel->iob[cnt]);
-	channel->buf_no = 0;
 	channel->io_buf_no = 0;
 }
 EXPORT_SYMBOL_GPL(qeth_clear_cmd_buffers);
@@ -927,7 +926,6 @@ static int qeth_setup_channel(struct qet
 			kfree(channel->iob[cnt].data);
 		return -ENOMEM;
 	}
-	channel->buf_no = 0;
 	channel->io_buf_no = 0;
 	atomic_set(&channel->irq_pending, 0);
 	spin_lock_init(&channel->iob_lock);
@@ -1103,11 +1101,9 @@ static void qeth_irq(struct ccw_device *
 {
 	int rc;
 	int cstat, dstat;
-	struct qeth_cmd_buffer *buffer;
 	struct qeth_channel *channel;
 	struct qeth_card *card;
 	struct qeth_cmd_buffer *iob;
-	__u8 index;
 
 	if (__qeth_check_irb_error(cdev, intparm, irb))
 		return;
@@ -1185,25 +1181,18 @@ static void qeth_irq(struct ccw_device *
 		channel->state = CH_STATE_RCD_DONE;
 		goto out;
 	}
-	if (intparm) {
-		buffer = (struct qeth_cmd_buffer *) __va((addr_t)intparm);
-		buffer->state = BUF_STATE_PROCESSED;
-	}
 	if (channel == &card->data)
 		return;
 	if (channel == &card->read &&
 	    channel->state == CH_STATE_UP)
 		__qeth_issue_next_read(card);
 
-	iob = channel->iob;
-	index = channel->buf_no;
-	while (iob[index].state == BUF_STATE_PROCESSED) {
-		if (iob[index].callback != NULL)
-			iob[index].callback(channel, iob + index);
-
-		index = (index + 1) % QETH_CMD_BUFFER_NO;
+	if (intparm) {
+		iob = (struct qeth_cmd_buffer *) __va((addr_t)intparm);
+		if (iob->callback)
+			iob->callback(iob->channel, iob);
 	}
-	channel->buf_no = index;
+
 out:
 	wake_up(&card->wait_q);
 	return;
@@ -2217,7 +2206,6 @@ time_err:
 error:
 	atomic_set(&card->write.irq_pending, 0);
 	qeth_release_buffer(iob->channel, iob);
-	card->write.buf_no = (card->write.buf_no + 1) % QETH_CMD_BUFFER_NO;
 	rc = reply->rc;
 	qeth_put_reply(reply);
 	return rc;
