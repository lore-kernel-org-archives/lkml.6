Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuz68OmrdfTIdZs5JO/irbU5ZP8yvW3de/3phqq8H2aaLhDNPZK6TOS+zEe/eEn4RcYYnCy
ARC-Seal: i=1; a=rsa-sha256; t=1519412238; cv=none;
        d=google.com; s=arc-20160816;
        b=p5ui5ykGaD/HBskuTPlK9TTO52mu4hCbyXSb8xuiG84lho/HeXVlJG/Hwyf7FSPXLi
         JhBsXXFayrMu6GvJdrmST//8+LCgw743tyOJSkRBR42wPNAnoTuTMZ3vh9RwTHyMtCgt
         PBOluTGkiCj9jr7z6mTV79LZ8YVUG6qNMKMm/pmcFHJ2A+kOng7wp8rJnpnkKF4Y0Byi
         9R/ZpPsg9KvsxxSuWJvUWmmbgDnkfsq1UW0magY0r9DNKTWEXP68Pgundo8iRv9Vnlls
         5CgegWeN6CoEmrVGBHDII31KYA6KzBo6zHgMumxYaz5giFjJRry6A/TPBnGTkGJKNPFk
         dddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GluV1uV2rr0c64H4xhiLWi6QkzinZoEbpJt4Sd4nKlk=;
        b=MIS8WeKFEwvGWfWF6bI2x1hSbz+X3XrKFATuiSDP+XxZMNWQe5ektT0l3ODc5r3GB4
         Rorcvj+Or4AJUFzKSCvXs9LL+fEPKtZoAgRcd+YXQM1AljurzRgqtFppzIXQvgHeGF9o
         Fsb+V8ZS1LZXP/MpwX/1Sz0MLBzZjugJRT/WpY/sAFW3dCOVpAoOjyKf6PSQPU51zcIZ
         o4784OCue++ToKMypQ9K9cnyxFGl5B+NKs9Ct7QoxRmP0g0XgZXSnNVftvx6fNZjcuSu
         2eC3BouiVMq0kMQDZDtkH4BXMWuHNCAdYIL5fa/Q0obbKSrZI7UYnm7ws2g41etniO5R
         A4/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Douglas Gilbert <dgilbert@interlog.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.15 10/45] blk_rq_map_user_iov: fix error override
Date: Fri, 23 Feb 2018 19:28:49 +0100
Message-Id: <20180223170716.977053392@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218293614384582?=
X-GMAIL-MSGID: =?utf-8?q?1593219207176204984?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Douglas Gilbert <dgilbert@interlog.com>

commit 69e0927b3774563c19b5fb32e91d75edc147fb62 upstream.

During stress tests by syzkaller on the sg driver the block layer
infrequently returns EINVAL. Closer inspection shows the block
layer was trying to return ENOMEM (which is much more
understandable) but for some reason overroad that useful error.

Patch below does not show this (unchanged) line:
   ret =__blk_rq_map_user_iov(rq, map_data, &i, gfp_mask, copy);
That 'ret' was being overridden when that function failed.

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-map.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -119,7 +119,7 @@ int blk_rq_map_user_iov(struct request_q
 	unsigned long align = q->dma_pad_mask | queue_dma_alignment(q);
 	struct bio *bio = NULL;
 	struct iov_iter i;
-	int ret;
+	int ret = -EINVAL;
 
 	if (!iter_is_iovec(iter))
 		goto fail;
@@ -148,7 +148,7 @@ unmap_rq:
 	__blk_rq_unmap_user(bio);
 fail:
 	rq->bio = NULL;
-	return -EINVAL;
+	return ret;
 }
 EXPORT_SYMBOL(blk_rq_map_user_iov);
 
