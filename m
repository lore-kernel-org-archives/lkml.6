Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AG47ELu0h47+G2XLFKJt9tueVa7Zv0sahvE7ihiYio36bWTIBOsBEmx0+BFa1X6RWFK/ZJLOQBgK
ARC-Seal: i=1; a=rsa-sha256; t=1519947183; cv=none;
        d=google.com; s=arc-20160816;
        b=pnSJQtiHildTBBPDy+BLoIEgKlLLoqRq57vvMQnJArZigV4yG2k/1Kpn2h+qKbSvQ1
         +/57QIyoshpf/p8nQUfa48ihbX4Ga3aIKg6wVK6spqjx7zPEJbDJ6f78OnQqL/9qkxBh
         mZHFpfIeCBdI3YaBRFkRHgpc0nkSXTOhRxNihRkvHvGeHn5BnXvPnujjAuA9Eiw3PsmN
         MY41oEH4NKSAoQylAGEV5b8iUhFDrrsQ614kG70IxLu2nI4W8lb+S+jMwBgMXRtaOjCQ
         LBwHJwyiBxJoaSEcqq85cqcbN83GnNgWYc/KS4jdN+cXhf7Y1PX+EcRLuzzTR9eWM+1f
         kEKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=I/1EEtdpeoCgWmEhyExZuR/IQGbspF3x2D+zWhmUkuA=;
        b=EfLPunzBQT32Jfbw2auIJI1gTuoA5T/4sZOoQ2ee7rVgV76q1DcRTB9wFwQdZcH47J
         lWq5qu9esCnFN1W6t5UvBdmLGFyPkq6YNKU57tehoot3RvzVLbMoPxvya8+F89AaUuF6
         UYl7XQO1+hmPxjI2lChNajnDCQcw/1t0mOHGnbOMEZKkvtLYEFJpO7aNSF0mcgbCmHit
         lYndhN8hRx+I9AqdqW8ZSSKEa3F7O4yuyZOfehAvgNnSxnyaIVga3misHiGspvhGTxYt
         Wu7a5pxCWrq2jGg3Y+HeVydegClbXZKz1FeREkLizcyDUp9Z4IBoypmNpgEz3xpI8zf4
         81lg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Fri, 02 Mar 2018 10:31:25 +1100
Subject: [PATCH 07/17] staging: lustre: ptlrpc: change GFP_NOFS to GFP_KERNEL
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <151994708527.7628.4121961365281382022.stgit@noble>
In-Reply-To: <151994679573.7628.1024109499321778846.stgit@noble>
References: <151994679573.7628.1024109499321778846.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593780137676490305?=
X-GMAIL-MSGID: =?utf-8?q?1593780137676490305?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

These allocations are performed during initialization,
so they don't need GFP_NOFS.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/lustre/ptlrpc/sec_bulk.c |    2 +-
 drivers/staging/lustre/lustre/ptlrpc/service.c  |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/lustre/lustre/ptlrpc/sec_bulk.c b/drivers/staging/lustre/lustre/ptlrpc/sec_bulk.c
index 577c5822b823..625b9520d78f 100644
--- a/drivers/staging/lustre/lustre/ptlrpc/sec_bulk.c
+++ b/drivers/staging/lustre/lustre/ptlrpc/sec_bulk.c
@@ -377,7 +377,7 @@ static inline void enc_pools_alloc(void)
 	page_pools.epp_pools =
 		kvzalloc(page_pools.epp_max_pools *
 				sizeof(*page_pools.epp_pools),
-				GFP_NOFS);
+				GFP_KERNEL);
 }
 
 static inline void enc_pools_free(void)
diff --git a/drivers/staging/lustre/lustre/ptlrpc/service.c b/drivers/staging/lustre/lustre/ptlrpc/service.c
index 49417228b621..f37364e00dfe 100644
--- a/drivers/staging/lustre/lustre/ptlrpc/service.c
+++ b/drivers/staging/lustre/lustre/ptlrpc/service.c
@@ -2046,7 +2046,7 @@ static int ptlrpc_main(void *arg)
 			goto out;
 	}
 
-	env = kzalloc(sizeof(*env), GFP_NOFS);
+	env = kzalloc(sizeof(*env), GFP_KERNEL);
 	if (!env) {
 		rc = -ENOMEM;
 		goto out_srv_fini;
@@ -2072,7 +2072,7 @@ static int ptlrpc_main(void *arg)
 	}
 
 	/* Alloc reply state structure for this one */
-	rs = kvzalloc(svc->srv_max_reply_size, GFP_NOFS);
+	rs = kvzalloc(svc->srv_max_reply_size, GFP_KERNEL);
 	if (!rs) {
 		rc = -ENOMEM;
 		goto out_srv_fini;
