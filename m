Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49b1QJOtd6uJcRQaOdQ8QZu+B0HYHnQCQW5n2pnHPAAKNckqL5GGYDr2jHsJgX74fPVynhR
ARC-Seal: i=1; a=rsa-sha256; t=1523399371; cv=none;
        d=google.com; s=arc-20160816;
        b=Jxz4ihtYeiXdLdYM9A98gzJaLEdiu3bjnMxabopWS4yn9lbglbD0cP97DXXFOsCG+U
         nIOH6O9GADfh0D644/V+fh/WD+L0/16apqeUfRl0zVlcLPJTBzwpUx37KHDGr7Dva2NI
         RRJOLuUe6gJxRElOpq5O0iEfM2ZAB2SD/O9+1DXM0ETqM4oYmtMg+mR03kDQm/9aZk0L
         DZdjFRu4J7MdTq312+qlMJp1Ku+4Avo4VmA/XjLXweCK2sn4c2pJW0ohkHHUKbX4FbJd
         F2BLuasIHr+qLbS451cTnc5CDRVCoYOhtlo6/IbVQtGx1U7zwZLa7BsI7QI8YcMA57N3
         5now==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gAedeUjXZfb9ejG1DHJksxHhiDxGLSmOVc4Ok/VJxKk=;
        b=AUQaCbf44nSNZY45mEIvaLOR7d3lPCzef1dlrInr0LmYhDcJTVmexA52b954Z/YLrx
         gMZnCLLlIZF3MryplttMNQnaTq0lr5gzNDzSIWpdeKAqImx2jl92cJNCG7KRLLYnhBUo
         ZZPpfK8ihYgml330BfDZGiN6sH706FEFwqKtHzm1Rd/puBz4HJ9AYR1uuXIqzlPgux7c
         TBakip/Bfgjk/pLiiMfWaRW4OfixSBzhzIa0OJYZW1s7uFQ0BvpFKWhlebUR9ChRKTeO
         O9vTq4SYmx9MwAIcATvXxzFKrFUgbb3a59BEXb6cmK0qiRKCTFYng3tuz2dxAOc9OrJQ
         iBGw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Holger=20Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
	Guoqing Jiang <gqjiang@suse.com>,
	Davide Ferrari <davideferrari8@gmail.com>,
	Paolo Valente <paolo.valente@linaro.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 083/168] block, bfq: put async queues for root bfq groups too
Date: Wed, 11 Apr 2018 00:23:45 +0200
Message-Id: <20180410212803.805737821@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400019023760328?=
X-GMAIL-MSGID: =?utf-8?q?1597400019023760328?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Valente <paolo.valente@linaro.org>


[ Upstream commit 52257ffbfcaf58d247b13fb148e27ed17c33e526 ]

For each pair [device for which bfq is selected as I/O scheduler,
group in blkio/io], bfq maintains a corresponding bfq group. Each such
bfq group contains a set of async queues, with each async queue
created on demand, i.e., when some I/O request arrives for it.  On
creation, an async queue gets an extra reference, to make sure that
the queue is not freed as long as its bfq group exists.  Accordingly,
to allow the queue to be freed after the group exited, this extra
reference must released on group exit.

The above holds also for a bfq root group, i.e., for the bfq group
corresponding to the root blkio/io root for a given device. Yet, by
mistake, the references to the existing async queues of a root group
are not released when the latter exits. This causes a memory leak when
the instance of bfq for a given device exits. In a similar vein,
bfqg_stats_xfer_dead is not executed for a root group.

This commit fixes bfq_pd_offline so that the latter executes the above
missing operations for a root group too.

Reported-by: Holger Hoffstätte <holger@applied-asynchrony.com>
Reported-by: Guoqing Jiang <gqjiang@suse.com>
Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>
Signed-off-by: Davide Ferrari <davideferrari8@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/bfq-cgroup.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -775,10 +775,11 @@ static void bfq_pd_offline(struct blkg_p
 	unsigned long flags;
 	int i;
 
+	spin_lock_irqsave(&bfqd->lock, flags);
+
 	if (!entity) /* root group */
-		return;
+		goto put_async_queues;
 
-	spin_lock_irqsave(&bfqd->lock, flags);
 	/*
 	 * Empty all service_trees belonging to this group before
 	 * deactivating the group itself.
@@ -809,6 +810,8 @@ static void bfq_pd_offline(struct blkg_p
 	}
 
 	__bfq_deactivate_entity(entity, false);
+
+put_async_queues:
 	bfq_put_async_queues(bfqd, bfqg);
 
 	spin_unlock_irqrestore(&bfqd->lock, flags);
