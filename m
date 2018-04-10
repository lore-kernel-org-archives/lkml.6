Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48pZkXfK7uQOjWlF+Ygp54/KWrobiLseGzNcUWLXi+COrAUaf5WMRO7XUJzm17gLo8vkzAy
ARC-Seal: i=1; a=rsa-sha256; t=1523399801; cv=none;
        d=google.com; s=arc-20160816;
        b=ywHNxyNYQnKAdwZwfGq4IMczvvcuF2xpPobQvRHWkpFtQB932yQ7eM41vZedQQVrXt
         ZJnud/92cUTtu37hiEKRNF30z1ospis9qXrx4P23JP8s9ZsAstZTmYvOGBTftIJj6fhA
         kcNY/lTH3lI8XWQXxUbcnxkoNjfsAFJI/Ax6jmEaOPBbbKddgxGT2gR9MdbQR2K4ksmx
         NVm7NWaCqQKqWPF+fMdWP/AqX7C/3EzpeRWdeAP0VpYcsSPAje+uVqQZNfLWa6ho7pI0
         B3lsQk3R4f3FqmePlHuqPXi0JnPnV/kTmIq0+ZZLVjlkY6e+3BLajL8hfqxE+4zxSGn+
         +ybA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9YFXTmDovVsW2oAdhiaQK1VN6Q2JygjMAINtwLeoWuM=;
        b=C0n225Tpi19hVCsSzEvukgYVcRBBUvsCTASReWa5LDIVghO/Eial6lhoej1C3CTDEJ
         Bx3LwWEYDdoYKzLbvYN52gf/LPKyz2H+gT2UZVxDzm5RsTYFh9Q6b9GLaWCGtdQ4q2ak
         B7LIPgCACX5buRkSxbYCKFs8xVqXuBqPfvTiPV/aa0YVlCKKRsmuy03GfsREMv3cZ/oq
         t+9M8fPEX5Kt2Bz9xrVmgocKKpftupH2s3MJlx3xmrEx7pNxHKDe/sXTBjBJMLZcr8xq
         RktCje+nlLLf8J2FT4d8z6q2QsASUY2mn6OwVwP5O4WGYI4BguvJXsMnyn+4ELGNkMfh
         DVDQ==
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
Subject: [PATCH 4.14 065/138] block, bfq: put async queues for root bfq groups too
Date: Wed, 11 Apr 2018 00:24:15 +0200
Message-Id: <20180410212909.661995840@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400019023760328?=
X-GMAIL-MSGID: =?utf-8?q?1597400470880486053?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -749,10 +749,11 @@ static void bfq_pd_offline(struct blkg_p
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
@@ -783,6 +784,8 @@ static void bfq_pd_offline(struct blkg_p
 	}
 
 	__bfq_deactivate_entity(entity, false);
+
+put_async_queues:
 	bfq_put_async_queues(bfqd, bfqg);
 
 	spin_unlock_irqrestore(&bfqd->lock, flags);
