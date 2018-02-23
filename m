Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuoiqPFR2isiW3wzy46YAj85gyOSip8YwZkTXRim1ik6OlBiJzg7x+BKjfcgJpdUxX3I8MI
ARC-Seal: i=1; a=rsa-sha256; t=1519412237; cv=none;
        d=google.com; s=arc-20160816;
        b=HPWc5c0scDHk7XcSXXgCzSAb10L613xheDmW1z0ktHy9irpPgx5E9QBFJ4gr8oiksx
         SHouB8oiRFcAjjVF9bsMDmeOY83rDE/h2UoVDfPs/EdLAjJzqNIwkwFxqmIGdRUMDdhY
         T6PjIOr270t5y1PUbWQtXBV1wNIad+IL0RhgiNPWCptn/GY0/qQ/fB0oZtMcH7yQWCe2
         UXCBymtdGRBvdt7XgZjyqTEfS84yCwILLMT2wPauSUCrkG0Y7/1Wk6TV1iVgIE8zIZR/
         N5DPhiC1rMuOKHEbBvyA1ZjgVp4La6Quh2Zf8BDLamSqpEW30qTBAm5R4A6IRrpAFV2l
         LKCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DrsHic7Lj23xFvvNVhXz80ryXmI8NdTYkzgFw3GSyf4=;
        b=CokKScwCQbCtyB96NN8q04NSd+gwpW1Ds8zMjidfYecjC4vrvwvfMm8Mce4b/ODjim
         9BKJ4+3oaxV+JeDuYCHZ6Y7PE2tXkuHkjQrwErcwJd6AwvXmEP0f7abmIM3AcCd69u/o
         ZSKJRtWfkIjluhfjj3SO9WdX7XoDDZ5k2imMrNjcdw0JZLs9F2Upwy+bcgf92Sa4uYcq
         4bC0WCttIdmNvMvRdo1PqeN9NJH5LJLD9kCNK0JxaMkN1KgJsSv0zstYRpKQM1ff1OEk
         b3/raPagfckoC0Q5cCzE++GK5WmTRzTzfQDCWFuDAWV09YP1EVlqMPPliePiQC7ElDK1
         Wl5A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 01/45] tun: fix tun_napi_alloc_frags() frag allocator
Date: Fri, 23 Feb 2018 19:28:40 +0100
Message-Id: <20180223170715.496370779@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593219206587212507?=
X-GMAIL-MSGID: =?utf-8?q?1593219206587212507?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 43a08e0f58b3f236165029710a4e3b303815253b upstream.

<Mark Rutland reported>
    While fuzzing arm64 v4.16-rc1 with Syzkaller, I've been hitting a
    misaligned atomic in __skb_clone:

        atomic_inc(&(skb_shinfo(skb)->dataref));

   where dataref doesn't have the required natural alignment, and the
   atomic operation faults. e.g. i often see it aligned to a single
   byte boundary rather than a four byte boundary.

   AFAICT, the skb_shared_info is misaligned at the instant it's
   allocated in __napi_alloc_skb()  __napi_alloc_skb()
</end of report>

Problem is caused by tun_napi_alloc_frags() using
napi_alloc_frag() with user provided seg sizes,
leading to other users of this API getting unaligned
page fragments.

Since we would like to not necessarily add paddings or alignments to
the frags that tun_napi_alloc_frags() attaches to the skb, switch to
another page frag allocator.

As a bonus skb_page_frag_refill() can use GFP_KERNEL allocations,
meaning that we can not deplete memory reserves as easily.

Fixes: 90e33d459407 ("tun: enable napi_gro_frags() for TUN/TAP driver")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/tun.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1317,27 +1317,23 @@ static struct sk_buff *tun_napi_alloc_fr
 	skb->truesize += skb->data_len;
 
 	for (i = 1; i < it->nr_segs; i++) {
+		struct page_frag *pfrag = &current->task_frag;
 		size_t fragsz = it->iov[i].iov_len;
-		unsigned long offset;
-		struct page *page;
-		void *data;
 
 		if (fragsz == 0 || fragsz > PAGE_SIZE) {
 			err = -EINVAL;
 			goto free;
 		}
 
-		local_bh_disable();
-		data = napi_alloc_frag(fragsz);
-		local_bh_enable();
-		if (!data) {
+		if (!skb_page_frag_refill(fragsz, pfrag, GFP_KERNEL)) {
 			err = -ENOMEM;
 			goto free;
 		}
 
-		page = virt_to_head_page(data);
-		offset = data - page_address(page);
-		skb_fill_page_desc(skb, i - 1, page, offset, fragsz);
+		skb_fill_page_desc(skb, i - 1, pfrag->page,
+				   pfrag->offset, fragsz);
+		page_ref_inc(pfrag->page);
+		pfrag->offset += fragsz;
 	}
 
 	return skb;
