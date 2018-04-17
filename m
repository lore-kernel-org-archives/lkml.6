Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48gk6j8TPiNBRFGvog+4WK6Lt5+CG8S0Pdf5oc58BZNvzeea274ia85Y4Led1wDIBbuJJg3
ARC-Seal: i=1; a=rsa-sha256; t=1523980894; cv=none;
        d=google.com; s=arc-20160816;
        b=P0uldYa5HcRmq1/n9nd3g4cX6/ni3otFtmRJyi6wD+oYUzrBfnLgDuoIZ+U3i1cy3q
         av5NUvCu2ymYWpbPnceJQjqvsIKpSzUDekKao2pJTKt0pZA6NCp0TfQMyT/xOtB1LzAM
         ala9e/+DBm+ak3+QG3dSSbq8t2y8bFn55oaUw/htlKXOO++h4zvB61tJG0qboQclfXia
         CWS8oJjhdTncpIZyYb8Ckm/RiNBz8jYS5NRA5x2/BOtLez/HH1ge+aFWAG5dFRXVt5H1
         n5Mt+cPOKxUAAelC017lglrQ9BB0Qg9X9fXz4wVXcAFMdS15VlyGE3/mYSrAeFtTywrw
         0mdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QJhFiCwFsvYs1xjS9Y9LUtdr+Xwo3Eu3uR7Af8s7JfM=;
        b=vch1pHIMHlg3DRkhsJrThMYcpIQeqj4ye1T52AXV941SZGZplINpV30L7rHa7rkLfL
         W4OyVGGt2SLJ6F2RTQpS4a9WM7N49dsA1t/QVCrOJxsk6wMO28ekRZXQqja0NBGUnC0E
         B6kJHJWTiI1feVqdAcDvz9Dir+rLZR8e1kyRYYOaQarzOUiNTrfEo8plV2sprgqjEChu
         ND6FAEg923ZkgCcqbqIXsjFVh5AP/ncwvY84sOwGK9HqZxHCOVKuqU2bxkBDZTy8b5TE
         x/A2LygdomYkip2ZB5vmXG37lJ09LHwLpSeSFCsBAhN/JFS+WEc4XYFz4Ju/F4DpiH7d
         jbVQ==
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
Subject: [PATCH 4.16 43/68] blk-mq: dont keep offline CPUs mapped to hctx 0
Date: Tue, 17 Apr 2018 17:57:56 +0200
Message-Id: <20180417155751.080846191@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009790987535058?=
X-GMAIL-MSGID: =?utf-8?q?1598009790987535058?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
 
