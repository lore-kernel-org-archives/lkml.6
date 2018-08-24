Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AABC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725ED20666
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wpJeNlYN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 725ED20666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbeHXSPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 14:15:06 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:37243 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbeHXSPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 14:15:05 -0400
Received: by mail-io0-f194.google.com with SMTP id v14-v6so7316223iob.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 07:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CJ4eDIvUZtJa6MdbWzynjx3pHM/Y3HP6oVnOtrN9UVw=;
        b=wpJeNlYN0VIoHGiI5pdfMIrV7xLf58HhLBFZs2uojaPHRn+fgtqhHbAKkSw+1nbx7d
         4CwrWcXMu0+3N7GFFTZgNKjoWOkItpz1FHBfHF52W15o77waBzDlbU1d3tOL/RSvLDZt
         LqPKTLDLrADOWVoVmmV50PcS2G8OMR3QIghAF64BJIiJPtCetKoiEULLVyb2+CZTIGPv
         DWSlPIS2rQjiS1htiZHUI2xvUyNzDlbOlmCf9XofrA24d+Uh4NZJ/yTSTPqSUhdWPjuU
         Z2CWVF1GfGAjnHeZj/pMQOHF6xhSBJmj4t10z6Zi7FyxXXnm7sOsJo5rIbSbK+hb1Ncl
         JHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CJ4eDIvUZtJa6MdbWzynjx3pHM/Y3HP6oVnOtrN9UVw=;
        b=gKEiy8z5O1jV16MSx/nhPYgNG3Ap/ifDd9l5Vf5ctbB8cBB/BvKIc+OpdO34DSAsmb
         5jf8FASagoENQcfIiq9PsgJBEoqeQFeXHJZNC0/XbKg34XDf8DLL/MIFIAbUu0MlFHMH
         /aSZteqVUEnbUbKrFjDBZD126qADI0Aw270KUMU2WFGHB73w6ZdgeTzNLege8221tw87
         p5sSVhItP1teprgqDYTY+3v1n/ldg1y+x8GiuOdcASuh9XveHfHct2WgaySa091MYBO4
         fhCXIl+h7cN/SSTovwiYgJM9r4kFvrq/0zY4+j9RL3JO2lWEj85EbHqkn6OX6nDV08Sd
         texg==
X-Gm-Message-State: APzg51DR5GLkyYnuCdOiMCSI/jV22vCr3NmR/w0U7r5zo6D4oad3SZsj
        QWdLnwMyoYrjF1pwtfajVHuTXguRC1o=
X-Google-Smtp-Source: ANB0VdZX2IHwPiyziNYbrXAqOGm8WQSnURLgU8tIjR75tzyJPRlaJCi+QlDUWpPMKCaouDBSsZ3sIA==
X-Received: by 2002:a6b:38d6:: with SMTP id f205-v6mr1478913ioa.305.1535121608090;
        Fri, 24 Aug 2018 07:40:08 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id x8-v6sm2528114iog.13.2018.08.24.07.40.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 07:40:06 -0700 (PDT)
Subject: Re: [PATCH] blk-wbt: get back the missed wakeup from __wbt_done
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1535029718-17259-1-git-send-email-jianchao.w.wang@oracle.com>
 <809b2243-7a76-3d8a-5d1b-b6b9d9712f41@kernel.dk>
 <d28bca3a-196d-1520-35cf-bec1e1872d34@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1f2d5ab0-2322-56b7-3544-3cf733a22dd8@kernel.dk>
Date:   Fri, 24 Aug 2018 08:40:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <d28bca3a-196d-1520-35cf-bec1e1872d34@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/18 8:06 PM, jianchao.wang wrote:
> Hi Jens
> 
> On 08/23/2018 11:42 PM, Jens Axboe wrote:
>>> -
>>> -	__set_current_state(TASK_RUNNING);
>>> -	remove_wait_queue(&rqw->wait, &wait);
>>> +	wbt_init_wait(&wait, &data);
>>> +	prepare_to_wait_exclusive(&rqw->wait, &wait,
>>> +			TASK_UNINTERRUPTIBLE);
>>> +	if (lock) {
>>> +		spin_unlock_irq(lock);
>>> +		io_schedule();
>>> +		spin_lock_irq(lock);
>>> +	} else
>>> +		io_schedule();
>> Aren't we still missing a get-token attempt after adding to the
>> waitqueue? For the case where someone frees the token after your initial
>> check, but before you add yourself to the waitqueue.
> 
> I used to think about this.
> However, there is a very tricky scenario here:
> We will try get the wbt budget in wbt_wake_function.
> After add a task into the wait queue, wbt_wake_function has been able to
> be invoked for this task. If we get the wbt budget after prepare_to_wait_exclusive,
> we may get wbt budget twice.

Ah yes good point. But without it, you've got another race that will
potentially put you to sleep forever.

How about something like the below? That should take care of both
situations. Totally untested.


diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 84507d3e9a98..3d36bd158301 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -166,7 +166,7 @@ static void __wbt_done(struct rq_qos *rqos, enum wbt_flags wb_acct)
 		int diff = limit - inflight;
 
 		if (!inflight || diff >= rwb->wb_background / 2)
-			wake_up(&rqw->wait);
+			wake_up_all(&rqw->wait);
 	}
 }
 
@@ -481,6 +481,32 @@ static inline unsigned int get_limit(struct rq_wb *rwb, unsigned long rw)
 	return limit;
 }
 
+struct wbt_wait_data {
+	struct task_struct *curr;
+	struct rq_wb *rwb;
+	struct rq_wait *rqw;
+	unsigned long rw;
+	bool got_token;
+};
+
+static int wbt_wake_function(wait_queue_entry_t *curr, unsigned int mode,
+			     int wake_flags, void *key)
+{
+	struct wbt_wait_data *data = curr->private;
+
+	/*
+	 * If fail to get budget, return -1 to interrupt the wake up
+	 * loop in __wake_up_common.
+	 */
+	if (!rq_wait_inc_below(data->rqw, get_limit(data->rwb, data->rw)))
+		return -1;
+
+	data->got_token = true;
+	wake_up_process(data->curr);
+	list_del_init(&curr->entry);
+	return 1;
+}
+
 /*
  * Block if we will exceed our limit, or if we are currently waiting for
  * the timer to kick off queuing again.
@@ -491,31 +517,46 @@ static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
 	__acquires(lock)
 {
 	struct rq_wait *rqw = get_rq_wait(rwb, wb_acct);
-	DECLARE_WAITQUEUE(wait, current);
+	struct wbt_wait_data data = {
+		.curr = current,
+		.rwb = rwb,
+		.rqw = rqw,
+		.rw = rw,
+	};
+	struct wait_queue_entry wait = {
+		.func		= wbt_wake_function,
+		.private	= &data,
+		.entry		= LIST_HEAD_INIT(wait.entry),
+	};
 	bool has_sleeper;
 
 	has_sleeper = wq_has_sleeper(&rqw->wait);
 	if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))
 		return;
 
-	add_wait_queue_exclusive(&rqw->wait, &wait);
-	do {
-		set_current_state(TASK_UNINTERRUPTIBLE);
+	prepare_to_wait_exclusive(&rqw->wait, &wait, TASK_UNINTERRUPTIBLE);
 
-		if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))
-			break;
+	if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw))) {
+		finish_wait(&rqw->wait, &wait);
+
+		/*
+		 * We raced with wbt_wake_function() getting a token, which
+		 * means we now have two. Put ours and wake anyone else
+		 * potentially waiting for one.
+		 */
+		if (data.got_token) {
+			atomic_dec(&rqw->inflight);
+			wake_up_all(&rqw->wait);
+		}
+		return;
+	}
 
-		if (lock) {
-			spin_unlock_irq(lock);
-			io_schedule();
-			spin_lock_irq(lock);
-		} else
-			io_schedule();
-		has_sleeper = false;
-	} while (1);
-
-	__set_current_state(TASK_RUNNING);
-	remove_wait_queue(&rqw->wait, &wait);
+	if (lock) {
+		spin_unlock_irq(lock);
+		io_schedule();
+		spin_lock_irq(lock);
+	} else
+		io_schedule();
 }
 
 static inline bool wbt_should_throttle(struct rq_wb *rwb, struct bio *bio)

-- 
Jens Axboe

