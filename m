Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvapyetuTM1nsk8/tETBatgwSLZ02jq+xuYA/RoRVsq4kD4r4d3zkyvlKllmbS6kDvcRWb9
ARC-Seal: i=1; a=rsa-sha256; t=1520451633; cv=none;
        d=google.com; s=arc-20160816;
        b=r9y/TPRVbLgcR27ekU+jmgXQSWpC4u+jeWVo8xYsc3TouXkFe8aFo8TUvqjnTux4ln
         xAT4sCfu03LBMyBmbjXK4oucgbhjLXxyv60Q6hXJxNPoZ9OjZMYaCLe/oJvQx++DTVlj
         nhrA8LBe6EPdz4dzjXSQO1uFuaRPoibPF2WEADZLWX3igu6F6O4rC6Agtq6TGB/pCqwb
         buKxQEHvyM8wCe+kiNnNWEKbslgA8Mj0EeOaTT8e//cm1XNHc3tQX3bIGZRstxd3ACMN
         nyz1TvIWkGc0XNAOTxMRnkJhBYedhFeZENecEVSTUNUm0JIkhv5i8modl6hRkepP2uux
         /IGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JAvQC81HXDYeNLm3p2RgVWH/N1HKJyMGLRpakMQ8Am0=;
        b=hNfHv6Xz+mKSqYuXb8ZErA65bDnjzLrxpPQvjBVYOkhYNhQ3LHOkBp5gpJ/dA6aqiY
         Ph0ois4eMpOmUVQW293kixHAkMpjmaHyzbE+tSu6JDirxgVY2qPBj4nzimRxQ0kYBa4G
         Fz0IhaAGtwqqnG5plN86+SmTWV/AwxyrpcLZQbolzosKu6vuzBKiO7qCxPEvQS/e1ZKe
         H63NK0yGYyk87ufYViEBoIV5Xi4CDpdt9UefXUf4mgtOfvXs+dKHPLAhaij679g5cMCi
         GR2eLFxrV9wrsfdgNKt+A6G0upVTKnJUf0SPkSTm65dR795gFJee3qWY72uIiU2GsIsG
         ZAyA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Omar Sandoval <osandov@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Jiufei Xue <jiufei.xue@linux.alibaba.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.15 029/122] block: fix the count of PGPGOUT for WRITE_SAME
Date: Wed,  7 Mar 2018 11:37:21 -0800
Message-Id: <20180307191733.475730582@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309092397136741?=
X-GMAIL-MSGID: =?utf-8?q?1594309092397136741?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiufei Xue <jiufei.xue@linux.alibaba.com>

commit 7c5a0dcf557c6511a61e092ba887de28882fe857 upstream.

The vm counters is counted in sectors, so we should do the conversation
in submit_bio.

Fixes: 74d46992e0d9 ("block: replace bi_bdev with a gendisk pointer and partitions index")
Cc: stable@vger.kernel.org
Reviewed-by: Omar Sandoval <osandov@fb.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2401,7 +2401,7 @@ blk_qc_t submit_bio(struct bio *bio)
 		unsigned int count;
 
 		if (unlikely(bio_op(bio) == REQ_OP_WRITE_SAME))
-			count = queue_logical_block_size(bio->bi_disk->queue);
+			count = queue_logical_block_size(bio->bi_disk->queue) >> 9;
 		else
 			count = bio_sectors(bio);
 
