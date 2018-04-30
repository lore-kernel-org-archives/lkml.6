Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpTsCV/JalMP0Xi5XJfk5gliThlpXjH6PPLwmS8AdiAoLwrxRnHRkwgRL3/9dqUNS134Mnu
ARC-Seal: i=1; a=rsa-sha256; t=1525116506; cv=none;
        d=google.com; s=arc-20160816;
        b=Z0tARhzPFow0Px3Edq2zvnZdMoL8b64Dbia5I+cAn2LvWiWZu4CfGNmNJV6TKAqtom
         yZDYi04lk8aNW89+xSFbmq1FLDIDfjzenXAVuTrqcy7AX/OfXF+plKm/BflNhWT+vcFi
         iBqVSK7DT6BYA0X+fWp/QYrtCKkNfc68koAsNzLWzpp16li9P2ecYsGeBuwOsqqd42yp
         NJwDS36tsamCQ2EGjbBqc9c0OvrVWhsaGlKjW5BZ8CBeJQC9Kj0UgilP+Qa5T2UXwbw0
         YzZ6Q1iEsalchzcnKeexPq4lSZTCWNsT6u/LcUowQKk1fkx/hRaXGA5dVgLojTJ0s7a/
         Ydtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=XOTQlK4ZsFRps23EWQim6t8+jA6G3GFJrYTAVjLQ4Kk=;
        b=mgPVV6GVg+EhTvo7acrJ4JWwN6bCLqxM0Rmg27yUUR1doBYeQ/RefAivTVAszXGTZ4
         JPq1FpBXNG2GT2kZj3RsFyCq7Dup/xHkzwnbjpmvxa7T1YiZul6U9AxXtqfYw+pz3Wx3
         NovLR9QPvEuIt4kkKorc8ll/P463MTKJM74GissrGt0hl4zLC6HhOuHiox6FWw4g78+u
         +8tNuUjwoerrDQPMeGoIrci9koyOf+2ET6oaeHRBsyYgPcI84c2ZpjeHf4j7TjAOrLZP
         ctWPsWk9z7LWAIC1R7YBMGr+VyS30/Hj0ychJhW63ygVCV/87FaUdmULtEcuRXq5Fc7W
         orew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4348322DCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Tejun Heo <tj@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Martin Steigerwald <Martin@Lichtvoll.de>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.16 063/113] blk-mq: start request gstate with gen 1
Date: Mon, 30 Apr 2018 12:24:34 -0700
Message-Id: <20180430184017.887475593@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200566405526555?=
X-GMAIL-MSGID: =?utf-8?q?1599200566405526555?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jianchao Wang <jianchao.w.wang@oracle.com>

commit f4560231ec42092c6662acccabb28c6cac9f5dfb upstream.

rq->gstate and rq->aborted_gstate both are zero before rqs are
allocated. If we have a small timeout, when the timer fires,
there could be rqs that are never allocated, and also there could
be rq that has been allocated but not initialized and started. At
the moment, the rq->gstate and rq->aborted_gstate both are 0, thus
the blk_mq_terminate_expired will identify the rq is timed out and
invoke .timeout early.

For scsi, this will cause scsi_times_out to be invoked before the
scsi_cmnd is not initialized, scsi_cmnd->device is still NULL at
the moment, then we will get crash.

Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Martin Steigerwald <Martin@Lichtvoll.de>
Cc: stable@vger.kernel.org
Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-core.c |    4 ++++
 block/blk-mq.c   |    7 +++++++
 2 files changed, 11 insertions(+)

--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -129,6 +129,10 @@ void blk_rq_init(struct request_queue *q
 	rq->part = NULL;
 	seqcount_init(&rq->gstate_seq);
 	u64_stats_init(&rq->aborted_gstate_sync);
+	/*
+	 * See comment of blk_mq_init_request
+	 */
+	WRITE_ONCE(rq->gstate, MQ_RQ_GEN_INC);
 }
 EXPORT_SYMBOL(blk_rq_init);
 
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2076,6 +2076,13 @@ static int blk_mq_init_request(struct bl
 
 	seqcount_init(&rq->gstate_seq);
 	u64_stats_init(&rq->aborted_gstate_sync);
+	/*
+	 * start gstate with gen 1 instead of 0, otherwise it will be equal
+	 * to aborted_gstate, and be identified timed out by
+	 * blk_mq_terminate_expired.
+	 */
+	WRITE_ONCE(rq->gstate, MQ_RQ_GEN_INC);
+
 	return 0;
 }
 
