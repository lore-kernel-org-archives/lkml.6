Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49PGGrVaxiYRakKJ4/7wPvvUl3JTqjKXuyqtCPJjAX8mIwipnrmNk0aPVJgKHHmsho5ptXT
ARC-Seal: i=1; a=rsa-sha256; t=1523981247; cv=none;
        d=google.com; s=arc-20160816;
        b=DMyc1Fiqdt9cc0lUGJd3jUM9uEH8BiezOXi5Dqtd5KOCufQsdSKgzXVx2mWrlJ8tjo
         /DlgtGRMsU+oYRSESkzr01Ow5cXZoOaBzHze13M3Kpli3bhqc5QNXfOM+9AynYUsqhvE
         x/KqlGM02Buvz0AtKA9z3fPt8PPLsg0zPCOoX1lcs9pE5yPQCa4VKXjXk3YHoBMdLw9A
         YdyBGNroDx9dTS4Uhl+/lwBJR0Ahg070YfD6QSRrLvFDuPTsULrM/pxrH7hS9qaIjuHY
         So2VrBY7lUMkz+xJkjPs14JzEhR7FH4Vryb3c8A24muU3NGMm6B+4tjMZSk0e8z3OKq7
         1HgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UjXN6V6euj5s/y6jwP1V8/odKnprgcocPi+WMC6xceY=;
        b=k+nMv2NEq7p7VXy7DjGGU3Swo/cxJxttH8129+NK3EOX/kxdCi/cBrcscPgTssH2i5
         2yWQtWVySTWGR9Ea1glbAYqqeM/wAAo4T0mACWzmhwi/UgG71nrRDLJWf7UqJ0j1LDvF
         ODTAuhDpvPJGaH4+Jl5XQVUAq8z7wNS/rFTjSVtXV4uLUBhvYOlWv0EDCKXlxf0qXW4G
         vtz5Ywhj5iExqZK8xjwNNaPPzHpA1p0F3cTiJ0XvWj36JcMD7XZ7QadvIymvEyKHFTKl
         AJQNLeDF8d+e1e7FmiizKaw7buNdbOweACmftbS71x747W1HC+7JQohhhSZA2b1UOLTq
         vTPw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Stefan Haberland <sth@linux.vnet.ibm.com>,
	Keith Busch <keith.busch@intel.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14 45/49] blk-mq: dont keep offline CPUs mapped to hctx 0
Date: Tue, 17 Apr 2018 17:59:24 +0200
Message-Id: <20180417155717.187039680@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155715.032245882@linuxfoundation.org>
References: <20180417155715.032245882@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009790987535058?=
X-GMAIL-MSGID: =?utf-8?q?1598010160665028020?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>

commit bffa9909a6b48d8ca3398dec601bc9162a4020c4 upstream.

>From commit 4b855ad37194 ("blk-mq: Create hctx for each present CPU),
blk-mq doesn't remap queue after CPU topo is changed, that said when
some of these offline CPUs become online, they are still mapped to
hctx 0, then hctx 0 may become the bottleneck of IO dispatch and
completion.

This patch sets up the mapping from the beginning, and aligns to
queue mapping for PCI device (blk_mq_pci_map_queues()).

Cc: Stefan Haberland <sth@linux.vnet.ibm.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: stable@vger.kernel.org
Fixes: 4b855ad37194 ("blk-mq: Create hctx for each present CPU)
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-mq-cpumap.c |    5 -----
 1 file changed, 5 deletions(-)

--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -16,11 +16,6 @@
 
 static int cpu_to_queue_index(unsigned int nr_queues, const int cpu)
 {
-	/*
-	 * Non present CPU will be mapped to queue index 0.
-	 */
-	if (!cpu_present(cpu))
-		return 0;
 	return cpu % nr_queues;
 }
 
