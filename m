Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx486ZDQZKzVKVHwR7V+XfX62Oh4T8Me56BWGx8e9DjiZUMwB3S98ieTftz+zemktb83118Y0
ARC-Seal: i=1; a=rsa-sha256; t=1523981071; cv=none;
        d=google.com; s=arc-20160816;
        b=otwdUwoH6NDJOhfsDSK1iwoN7MvOqSrB0+FbSOFsBuMz14fJ4WHhWXOjFbA22EfrKk
         lu2gf79rMTZB859Qyb0X99x18CSHXWPyzBJ5CusKxNZIymPRnFmNXo9AaJsZ9nr+QYI/
         SkQ4ZJuYtcwrXYeZYs9qMf63cAJHtTL7TDiACvNA52TeVXzKN25CUk5Pok359FVaM6Td
         +dDFmhQ1k+XUWRo1aYNsQyfd3uQNJNP8SLK21GuaglWzqNMiNHbfgKyhk7Yp9Yb+TCwz
         FrXu9Y1sd8n3B+xWyZ1r/bN5ATqPcasevyF4pQixvekZIgWWjvJx4nkudZm781Sl+6tV
         Yf/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MMGiR3xO3Z7g6xX3cQ6iNhZ2c6nrkn8O8HDNeaS+z70=;
        b=DEGZpFqykD1SMCMq+VYEdvSnDXDIQx4vHAzx8m4MI8xetyEOpua6C/OU4zWOwhlPuR
         dqmxshH0xt2bzmgLK9nQBVktA9ka4lKtDjXww7lO+Pmbh/0cYUOE7TJ//0w0cvv9qW0L
         UwK+JaVCUxOd1hE5owrKEa9+TUVhqy3DKlpfGbIs/BdwG9bHG3taExQ36KbcLK5TvEbK
         Yhi5oVPUUh+WKGPmbce91V0XfEEn5Kwt+ojawwxf3Ph9Q46CGaRYnt+9qzezw8gckOFu
         BAcb+xusnzkK8GNJCw9XNZXSfKjQcAXf0iGEtChV+wAB3qHUnjAxzUUxEisPY6r3lhhe
         YbUA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.com>,
	Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Oleksandr Natalenko <oleksandr@natalenko.name>,
	Martin Steigerwald <martin@lichtvoll.de>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.15 28/53] block: Change a rcu_read_{lock,unlock}_sched() pair into rcu_read_{lock,unlock}()
Date: Tue, 17 Apr 2018 17:58:53 +0200
Message-Id: <20180417155724.531278623@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009769995705477?=
X-GMAIL-MSGID: =?utf-8?q?1598009976278568492?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

commit 818e0fa293ca836eba515615c64680ea916fd7cd upstream.

scsi_device_quiesce() uses synchronize_rcu() to guarantee that the
effect of blk_set_preempt_only() will be visible for percpu_ref_tryget()
calls that occur after the queue unfreeze by using the approach
explained in https://lwn.net/Articles/573497/. The rcu read lock and
unlock calls in blk_queue_enter() form a pair with the synchronize_rcu()
call in scsi_device_quiesce(). Both scsi_device_quiesce() and
blk_queue_enter() must either use regular RCU or RCU-sched.
Since neither the RCU-protected code in blk_queue_enter() nor
blk_queue_usage_counter_release() sleeps, regular RCU protection
is sufficient. Note: scsi_device_quiesce() does not have to be
modified since it already uses synchronize_rcu().

Reported-by: Tejun Heo <tj@kernel.org>
Fixes: 3a0a529971ec ("block, scsi: Make SCSI quiesce and resume work reliably")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Martin Steigerwald <martin@lichtvoll.de>
Cc: stable@vger.kernel.org # v4.15
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -823,7 +823,7 @@ int blk_queue_enter(struct request_queue
 		bool success = false;
 		int ret;
 
-		rcu_read_lock_sched();
+		rcu_read_lock();
 		if (percpu_ref_tryget_live(&q->q_usage_counter)) {
 			/*
 			 * The code that sets the PREEMPT_ONLY flag is
@@ -836,7 +836,7 @@ int blk_queue_enter(struct request_queue
 				percpu_ref_put(&q->q_usage_counter);
 			}
 		}
-		rcu_read_unlock_sched();
+		rcu_read_unlock();
 
 		if (success)
 			return 0;
