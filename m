Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48yrDbhb/u1IvGoS1xV+5gBhOvX5TBquwmKjrziQxzgcw9hop5cx4BFwpgk61zO6Fs0JYVx
ARC-Seal: i=1; a=rsa-sha256; t=1523472547; cv=none;
        d=google.com; s=arc-20160816;
        b=aKa8UeAjgaUXRBkrk6zDJ1T4SQUkpRRMojqSuBvh4dDh96BJ4l+bsCKGacthTe5Q0R
         BbvQ8k/yugBP8K4hw4LbI2KKIh3cGTS9GKmUxeLVKkm+GtF/SiNlmv3MNHT4N2Ws4tcz
         P4E49fIQNTcm4T9iStkuG5nW0WLo1jHdlX/3y9CYmq+6c1Na19pZPy2NNr3o4DU45gdi
         bko3rSEeFaHWSLeHc6Bul83zH/jPCZNo08+Fm6oWz/WO/K36ZwEzfWkEPg0ehXnHRfTK
         4r0jDu77YZ7XIafJtFT24wBVqj88HtC4acMN5tC5OHxQd0OjYXaSzz5GK2MnZzcAh/GO
         dQEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=P/cDHo51mYzTyjm2pwTILD7jXm1NRkV3HsOo1QCaoAk=;
        b=w3mN9Ggcv0a4tq11JI6YC3KP4yfU3iAreAkcWUSWd6Cx7XanOlwHLMWxr+BCAO0vzW
         2++LxpvjVT6ioLGy5BDO2JTMYIonB7axOt3Ac4VJb/1JIWIwSiwslTasUDozO9W8nloN
         b3g+zBlODjo5nziumuDYvFst36Dc93EB44lQ3GU5EESdMcz8j8uVcvOQFYZEluvIa3RG
         JSqljGoDxONAdE7iNw3Af44fZEs+LOFgtsPp45BKwLGGagKvGq3KoAgPhibKhp5yORSd
         o7CE1k2NOvnkk1wHfOPvhpW716pGqzwmTALY+qCviqfOl9sb0vVmDRphPMtq4wQXMHFA
         KfjQ==
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
Subject: [PATCH 4.4 125/190] [media] cx25840: fix unchecked return values
Date: Wed, 11 Apr 2018 20:36:11 +0200
Message-Id: <20180411183559.391845365@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476240306885763?=
X-GMAIL-MSGID: =?utf-8?q?1597476750046620586?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -631,11 +633,13 @@ static void cx23885_initialize(struct i2
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
@@ -746,11 +750,13 @@ static void cx231xx_initialize(struct i2
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
 
