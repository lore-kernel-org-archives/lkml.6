Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48hkTZH78NykkMgRB8sdy/u+7xTRtEYtnmVyv3OAq0uJRUsNQPDa2/nNaxmP0e4Thsi2/kZ
ARC-Seal: i=1; a=rsa-sha256; t=1523980886; cv=none;
        d=google.com; s=arc-20160816;
        b=Kf/hxozwGQc1g3+EOI4+C0k30CQQG9T0guZQ+TTQEH62yRar7rH5jYu1KI210DgIpi
         x+A/MF0vhSFDUeNrF0/5lB5H9b3dwEUJh4E6Z5dqYtLV3FZF3ATZLNQdMe5JWwb/kO8p
         6LcCQxmEQ1lAsANT3gx3ZPIKURZti1TzehcNwtrV8vUD3KK6HhS8kPibqP3RfdhgbihH
         drofvkpG2GqJjyOP+4+Bu4aLVwPhWwdlEGE89NnXije2fLQtinCef0Vzpm999hFgeKZm
         KAOv6nm2zS8JDlwMQUpxdDqqiInRS/bShIkitPmdqT1Muto4ZGlSNYnsShlSuvtHak84
         HdEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5pug+/fM1nkMIeyM8zjl4hcJXYV7gw+q4nxjA6LY2zQ=;
        b=oizdeT+29HKqmiOcEVVk/2Jgw//xo84y+gThm9dNtQh3/ZCiOONT4N6WcAMEr6PfMU
         9NpbXQ12kFS+l+oHSmgaSmNlfU09OGxPBBjPMGe62Tg0+Z14W94JBEgN1QC3I5VnMKvL
         Ulhnz911CXdytS/bSFZUWlWoU52qmTyZb88O/IgfHOGJqYtUw/jCW9PpAS9HNeGKkApT
         0bFAHg82rz+xAMR5oKjSu99H89O7AZO+fwC6V4xS/a1GG4NLW8cTaTjMQxsN+Z1s9gex
         q5JR/O3wFtGDbFUGPoDdwFJA2nJ4qE3fV+JfkYnjx04HVfqnKzGKumhwxNcdTl/bXSd9
         MGKA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Sitsofe Wheeler <sitsofe@gmail.com>,
	Meelis Roos <mroos@linux.ee>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.16 40/68] blk-mq: Directly schedule q->timeout_work when aborting a request
Date: Tue, 17 Apr 2018 17:57:53 +0200
Message-Id: <20180417155750.961000016@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009781951336252?=
X-GMAIL-MSGID: =?utf-8?q?1598009781951336252?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tejun Heo <tj@kernel.org>

commit bc6d65e6dc89c3b7ff78e4ad797117c122ffde8e upstream.

Request abortion is performed by overriding deadline to now and
scheduling timeout handling immediately.  For the latter part, the
code was using mod_timer(timeout, 0) which can't guarantee that the
timer runs afterwards.  Let's schedule the underlying work item
directly instead.

This fixes the hangs during probing reported by Sitsofe but it isn't
yet clear to me how the failure can happen reliably if it's just the
above described race condition.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Sitsofe Wheeler <sitsofe@gmail.com>
Reported-by: Meelis Roos <mroos@linux.ee>
Fixes: 358f70da49d7 ("blk-mq: make blk_abort_request() trigger timeout path")
Cc: stable@vger.kernel.org # v4.16
Link: http://lkml.kernel.org/r/CALjAwxh-PVYFnYFCJpGOja+m5SzZ8Sa4J7ohxdK=r8NyOF-EMA@mail.gmail.com
Link: http://lkml.kernel.org/r/alpine.LRH.2.21.1802261049140.4893@math.ut.ee
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-timeout.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -165,7 +165,7 @@ void blk_abort_request(struct request *r
 		 * No need for fancy synchronizations.
 		 */
 		blk_rq_set_deadline(req, jiffies);
-		mod_timer(&req->q->timeout, 0);
+		kblockd_schedule_work(&req->q->timeout_work);
 	} else {
 		if (blk_mark_rq_complete(req))
 			return;
