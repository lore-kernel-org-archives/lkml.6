Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+gT2BD1TcxA7KyPe7nbMJa1mjMrNnykOn7Ljvae892eyBD07g7zpZrxKBys6fGq4FjiYNX
ARC-Seal: i=1; a=rsa-sha256; t=1523981076; cv=none;
        d=google.com; s=arc-20160816;
        b=oiRS/3kosagRATh1/V8BlkzCqFvq4ggkii9D4l54aMZiy4uAg8pVMEufMwSwFu6kPS
         hslegwzBKj5sCEQrsmEyAlnLeM864WbmofiFNAIzybcWXBdbt5/bPfLqqUaJ5x5kMW4K
         clrrfl9IaMgcGuOFYSDEtENKx0WqmmIfeTyM0APV6A6IS8KLGPXzT+dbOJBbJwtLiAU0
         4KeLKIA1ktbjAGiN0K1q/6LDRf9/WnDk4xPprQhBhmENqt2OI0ABQCcDDi8+QFvC81Go
         EYRGnu7JbnIFGDu9rn0epOEPVFJqA9PLE62aXAmFffuFW9+dKFE8vxBdGlVHu+5TuebB
         slWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=R4p7u+dbD63NmP/nXk0DdduDRZ9cgbIVHSmykSxKTqc=;
        b=Lq90EPR74IK2RSfFQrb3LF59PGZTE4gzLAj5GM21TbqYOQHGCT1FzOoKA45VBeNkmG
         RMiKtqkjup7q4xROAtzyjgWY4PgZVnxqjH8gyF4zqBrkf4SfxyNeeY8FMKzQKvjuHF/X
         udynBruaBQt3ywpu2jx+K+G1edEzYgPsFsXpegFarTmiBYLODG/slxWc5f3eFGuW4KQN
         cg3TVzHx4SMpaW1rUlUz+o87phGgEgMSg3SlKDZV8OkDQK7zUGkRBN2HjN5OtM23M1rq
         I659v1xK+Cv9HoPJfENPmPd2PUffg3ac/YmL5u5gmp+rKrM6pcKo3FUkr9NPDWl0r6Nh
         o70A==
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
Subject: [PATCH 4.15 32/53] blk-mq: dont keep offline CPUs mapped to hctx 0
Date: Tue, 17 Apr 2018 17:58:57 +0200
Message-Id: <20180417155724.713605978@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009790987535058?=
X-GMAIL-MSGID: =?utf-8?q?1598009981309990381?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 
