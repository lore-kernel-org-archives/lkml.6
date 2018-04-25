Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48GTKgE92NoADYMmX7wpZc+XSkSXEji5gqPTgNx0/LNcAecAUYl4LufzJDyor0QhgJ5pfIG
ARC-Seal: i=1; a=rsa-sha256; t=1524652728; cv=none;
        d=google.com; s=arc-20160816;
        b=fbV3XWJ7zxvKN/xXkKhKLw5G0qG16HPB7UEhKeg0RW6QQKhw2DE/fpTfv0KPZupqLf
         /PyOJkZPWNzJ2MKGxpzkc6tM9fBINOPN5gf/fuKH/7BulE+TCgcBq0/QlaahcRpY7nkC
         BHWJyRyiuR+H4igudQMymMS9n+9swgyTWqlOSvAEUzeVeIm1hIiq44w5ckEVWf3azbT4
         TbeKm9gTr6cK5++wTyfUo3VlDY+DK/Ijn/+Uqq9lGFbh6cccqnAfMMdI7mX1XXasNx2Q
         mNiXokm0SHvyHxcmvcrbyKmDNK3NlSjULLNiJKH10Gajjg5vqw9D22rvIr74Wzn4lNCO
         BpJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=og0TpxR1x/UTlATeGxD/kf0Q4SVM17ci7gdjuXVp7GQ=;
        b=c2iST1i4OBicM4m6CzNc8yOfx93sFgMNLOsJMYNgYtm67dmRozMZRmKtt0wWc7+zOl
         8a/yy803PyJ5hnth7MzfhlaRZaIVHHHBiLJZ3EPsDxtaXf+Gi6gSa1A25/Ull1VrL11I
         7WaIpDIb2ZG/CFHay2X+ACOTknHkZcYNi+jv/laTJP8vAXg9d6szH4Ol0kL26ojxnj9s
         sMCJY9w0dd9hXPwG7+eUqx/TzbSTz8bCeplZejD6vfbhvq25F+IBZwdxbQMsDKIHw/u/
         bzkFt3t0f4yBj+tUcDAUpCDxHTlFP4ofnP0lgSRml17Y0OPVkIX7/GSOUIKh+EP7K260
         jKmQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Mike Snitzer <snitzer@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 047/183] dm mpath: return DM_MAPIO_REQUEUE on blk-mq rq allocation failure
Date: Wed, 25 Apr 2018 12:34:27 +0200
Message-Id: <20180425103244.450168940@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714258841274040?=
X-GMAIL-MSGID: =?utf-8?q?1598714258841274040?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>


[ Upstream commit 050af08ffb1b62af69196d61c22a0755f9a3cdbd ]

blk-mq will rerun queue via RESTART or dispatch wake after one request
is completed, so not necessary to wait random time for requeuing, we
should trust blk-mq to do it.

More importantly, we need to return BLK_STS_RESOURCE to blk-mq so that
dequeuing from the I/O scheduler can be stopped, this results in
improved I/O merging.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-mpath.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -502,8 +502,20 @@ static int multipath_clone_and_map(struc
 		if (queue_dying) {
 			atomic_inc(&m->pg_init_in_progress);
 			activate_or_offline_path(pgpath);
+			return DM_MAPIO_DELAY_REQUEUE;
 		}
-		return DM_MAPIO_DELAY_REQUEUE;
+
+		/*
+		 * blk-mq's SCHED_RESTART can cover this requeue, so we
+		 * needn't deal with it by DELAY_REQUEUE. More importantly,
+		 * we have to return DM_MAPIO_REQUEUE so that blk-mq can
+		 * get the queue busy feedback (via BLK_STS_RESOURCE),
+		 * otherwise I/O merging can suffer.
+		 */
+		if (q->mq_ops)
+			return DM_MAPIO_REQUEUE;
+		else
+			return DM_MAPIO_DELAY_REQUEUE;
 	}
 	clone->bio = clone->biotail = NULL;
 	clone->rq_disk = bdev->bd_disk;
