Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/OixLgKgnYwTcckS3sgBWoahPBRJdg/DVxRZMLkKNiZDMYjCiKoxVQIuuvaLXb9WRviF21
ARC-Seal: i=1; a=rsa-sha256; t=1523473332; cv=none;
        d=google.com; s=arc-20160816;
        b=m1y4En/LtlPJf5Uolx+jEYKW5ROJIQro2joUlClP4jH0zPeO5qEv0omYAd3Lsp/f2X
         gS3wR20IvLxZbr9BIRln+5h0R7wn0iFF2k82cmzKIcBqquPaZQ1NWfoji0raB1Yjf6Vb
         QnhVrTdPvLN8lfssHy2Qm58U5vmlqHFkVf/L0LP3LbcC2gejKocAvSxZor3x5+IMwjwA
         Ply5w+zfqUcJgbSF35ccVv0chAmzqTFf6J2FGuYztu9x4b3Ttmw6Om1MV/mXM6m9KBs4
         b10vXKw8CZAApaewT4oiGnPaJKCbEeIzsNsjcrXj7JC7gh4/KBKzHMw2l904ZHWhznro
         fuFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=L9VG2k7cf79AgRWzruQNBYf0EC8OlyPs3ESdfJHkXKQ=;
        b=f0YKnrRrjo+T1rv7o6Ao2xvH2oDlLqJ2KDDlo4DzDxAGqKx3VbVQzTa/EU9K9P9CEY
         1TVLofXq7xVL4Xp/8GHjLy3X3+dqtVasD7vWDlwC8/puHngwWaCvrITmcZOhZcJjXfXD
         aH2PB6ejPVCSzdPVOH5zYoDB5fwvGkNZOOqsZazfFJN8zYHrZnCUYqMCB+7NW/IweXCz
         nXnRLvr+BD8zzXCNX3inyXNXhhC+xs5SKBamghE24paeCZiaJAS02SoHh02AeD876wuW
         7tGfYXfQiIDamk1CRM2JjaJoPVF532Ov/l4uVQfR3GD+yEOAbIsSXuSpi23ADgimriba
         QyRA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Pan Bian <bianpan2016@163.com>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 208/310] [media] cx25840: fix unchecked return values
Date: Wed, 11 Apr 2018 20:35:47 +0200
Message-Id: <20180411183631.517331710@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476240306885763?=
X-GMAIL-MSGID: =?utf-8?q?1597477573768435835?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pan Bian <bianpan2016@163.com>


[ Upstream commit 35378ce143071c2a6bad4b59a000e9b9f8f6ea67 ]

In functions cx25840_initialize(), cx231xx_initialize(), and
cx23885_initialize(), the return value of create_singlethread_workqueue()
is used without validation. This may result in NULL dereference and cause
kernel crash. This patch fixes it.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/cx25840/cx25840-core.c |   36 ++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 15 deletions(-)

--- a/drivers/media/i2c/cx25840/cx25840-core.c
+++ b/drivers/media/i2c/cx25840/cx25840-core.c
@@ -420,11 +420,13 @@ static void cx25840_initialize(struct i2
 	INIT_WORK(&state->fw_work, cx25840_work_handler);
 	init_waitqueue_head(&state->fw_wait);
 	q = create_singlethread_workqueue("cx25840_fw");
-	prepare_to_wait(&state->fw_wait, &wait, TASK_UNINTERRUPTIBLE);
-	queue_work(q, &state->fw_work);
-	schedule();
-	finish_wait(&state->fw_wait, &wait);
-	destroy_workqueue(q);
+	if (q) {
+		prepare_to_wait(&state->fw_wait, &wait, TASK_UNINTERRUPTIBLE);
+		queue_work(q, &state->fw_work);
+		schedule();
+		finish_wait(&state->fw_wait, &wait);
+		destroy_workqueue(q);
+	}
 
 	/* 6. */
 	cx25840_write(client, 0x115, 0x8c);
@@ -634,11 +636,13 @@ static void cx23885_initialize(struct i2
 	INIT_WORK(&state->fw_work, cx25840_work_handler);
 	init_waitqueue_head(&state->fw_wait);
 	q = create_singlethread_workqueue("cx25840_fw");
-	prepare_to_wait(&state->fw_wait, &wait, TASK_UNINTERRUPTIBLE);
-	queue_work(q, &state->fw_work);
-	schedule();
-	finish_wait(&state->fw_wait, &wait);
-	destroy_workqueue(q);
+	if (q) {
+		prepare_to_wait(&state->fw_wait, &wait, TASK_UNINTERRUPTIBLE);
+		queue_work(q, &state->fw_work);
+		schedule();
+		finish_wait(&state->fw_wait, &wait);
+		destroy_workqueue(q);
+	}
 
 	/* Call the cx23888 specific std setup func, we no longer rely on
 	 * the generic cx24840 func.
@@ -752,11 +756,13 @@ static void cx231xx_initialize(struct i2
 	INIT_WORK(&state->fw_work, cx25840_work_handler);
 	init_waitqueue_head(&state->fw_wait);
 	q = create_singlethread_workqueue("cx25840_fw");
-	prepare_to_wait(&state->fw_wait, &wait, TASK_UNINTERRUPTIBLE);
-	queue_work(q, &state->fw_work);
-	schedule();
-	finish_wait(&state->fw_wait, &wait);
-	destroy_workqueue(q);
+	if (q) {
+		prepare_to_wait(&state->fw_wait, &wait, TASK_UNINTERRUPTIBLE);
+		queue_work(q, &state->fw_work);
+		schedule();
+		finish_wait(&state->fw_wait, &wait);
+		destroy_workqueue(q);
+	}
 
 	cx25840_std_setup(client);
 
