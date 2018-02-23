Return-Path: <dan.j.williams@intel.com>
X-Google-Smtp-Source: AH8x227dxpUpphnTzQFb7OpaRvpVL3WjVqTUIYkwL+fLf4gdkMVoMM5NHqjjozQ0SqJb8Rf9hiPF
ARC-Seal: i=1; a=rsa-sha256; t=1519424100; cv=none;
        d=google.com; s=arc-20160816;
        b=CMD+3vQdpv7oecyADNuHBeIIu7vvz6Ucikedz45df2hwnFqlzQqo1VwDdSzFvt70io
         kkEbfAPEGH07dH9N+a5E5EULzHkK0mUoygbNObAYKq6qPlQ5WLue/m25Vh4ZIDY+DGMJ
         UcVfiee7O6QBStq0xDTB5GjE5ccef3HNmLxF1P+Ee9qOLkKBdW9/UZjoFnSaLufGmmLN
         OOrEtN1NPp1Cvkz3Ujpnvj76eEoqnLiM8EI33bGjQayRvpkbXDzuoEnvRqw+1OseAe8O
         rVp7KgcNHAKDezOyFtB1s68OBqE3g0HXlT1T4dhzJpWSZKUi2T4sDokkCUdwKmg+5Hsd
         mzXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject
         :arc-authentication-results;
        bh=7ecC+RsWIhOHu+HKMG2yvUfLbzBLrS6MLd9U/UCPSLM=;
        b=jfCMd0L6h7NrmYUU8GNNks9wj+YbDKEQF7WQgfh7RtzYMBT0cUfpeHyznekA8DFJLF
         btBhxjlKJCdzthFV2BfRHbgLztZeQOKtW5FkggG1vADOhlSBzBncGGNvwvJGwuPb1BLh
         9ePPeKV2bXJosiwd26XMRSS8c4N+eauD8RWs6K0xzFYtyPEalIv6Sv372G1ov690dOr6
         jyNat4WbXUbBeRBSCR88uH+q+TgaTYVClZzXzQRv8jiAeGS4xCC/TJsYvtNFFWpnESqw
         sP33uZVGT8SDBcvVU176cLLnP2vkq7+4GF8DujJ/Uj6PtVDt9PB3K9S7fA1mWi+pv8QC
         c6oA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dan.j.williams@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=dan.j.williams@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dan.j.williams@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=dan.j.williams@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,383,1515484800";
   d="scan'208";a="22639784"
Subject: [4.9-stable PATCH 06/11] v4l2: disable filesystem-dax mapping
 support
From: Dan Williams <dan.j.williams@intel.com>
To: gregkh@linuxfoundation.org
Cc: Jan Kara <jack@suse.cz>, Joonyoung Shim <jy0922.shim@samsung.com>,
 linux-kernel@vger.kernel.org, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Doug Ledford <dledford@redhat.com>, stable@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Inki Dae <inki.dae@samsung.com>,
 Jeff Moyer <jmoyer@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>,
 Mel Gorman <mgorman@suse.de>, Andrew Morton <akpm@linux-foundation.org>,
 Ross Zwisler <ross.zwisler@linux.intel.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Sean Hefty <sean.hefty@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Hal Rosenstock <hal.rosenstock@gmail.com>, Vlastimil Babka <vbabka@suse.cz>
Bcc: dan.j.williams@intel.com
Date: Fri, 23 Feb 2018 14:05:54 -0800
Message-ID: <151942355435.21775.3892492011172127062.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <151942352167.21775.16852023419062929165.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151942352167.21775.16852023419062929165.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.17.1-9-g687f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593231645761720959?=
X-GMAIL-MSGID: =?utf-8?q?1593231645761720959?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

commit b70131de648c2b997d22f4653934438013f407a1 upstream.

V4L2 memory registrations are incompatible with filesystem-dax that
needs the ability to revoke dma access to a mapping at will, or
otherwise allow the kernel to wait for completion of DMA.  The
filesystem-dax implementation breaks the traditional solution of
truncate of active file backed mappings since there is no page-cache
page we can orphan to sustain ongoing DMA.

If v4l2 wants to support long lived DMA mappings it needs to arrange to
hold a file lease or use some other mechanism so that the kernel can
coordinate revoking DMA access when the filesystem needs to truncate
mappings.

Link: http://lkml.kernel.org/r/151068940499.7446.12846708245365671207.stgit@dwillia2-desk3.amr.corp.intel.com
Fixes: 3565fce3a659 ("mm, x86: get_user_pages() for dax mappings")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reported-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Hal Rosenstock <hal.rosenstock@gmail.com>
Cc: Inki Dae <inki.dae@samsung.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Jeff Moyer <jmoyer@redhat.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Sean Hefty <sean.hefty@intel.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 drivers/media/v4l2-core/videobuf-dma-sg.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/v4l2-core/videobuf-dma-sg.c b/drivers/media/v4l2-core/videobuf-dma-sg.c
index 1db0af6c7f94..b6189a4958c5 100644
--- a/drivers/media/v4l2-core/videobuf-dma-sg.c
+++ b/drivers/media/v4l2-core/videobuf-dma-sg.c
@@ -185,12 +185,13 @@ static int videobuf_dma_init_user_locked(struct videobuf_dmabuf *dma,
 	dprintk(1, "init user [0x%lx+0x%lx => %d pages]\n",
 		data, size, dma->nr_pages);
 
-	err = get_user_pages(data & PAGE_MASK, dma->nr_pages,
+	err = get_user_pages_longterm(data & PAGE_MASK, dma->nr_pages,
 			     flags, dma->pages, NULL);
 
 	if (err != dma->nr_pages) {
 		dma->nr_pages = (err >= 0) ? err : 0;
-		dprintk(1, "get_user_pages: err=%d [%d]\n", err, dma->nr_pages);
+		dprintk(1, "get_user_pages_longterm: err=%d [%d]\n", err,
+			dma->nr_pages);
 		return err < 0 ? err : -EINVAL;
 	}
 	return 0;
