Return-Path: <willy@infradead.org>
X-Google-Smtp-Source: AB8JxZrH7AsDEWSwI0LE2bn9ZXV8DyDJy8koMugzBq9rQe6Ww9vU2o8j03SwpVBRqw1o2POW5DcU
ARC-Seal: i=1; a=rsa-sha256; t=1526988153; cv=none;
        d=google.com; s=arc-20160816;
        b=0N5mlUwds4aELrb7UgxCQEbOWBFga4OvHgCxfk+UVUhZ4wf+ecd7Fr69voMFAWMV1R
         HvYirgZLPiZULVcaCKzsoKUMrLoqH5DCjSbGFWhoCRaej+1UuA7OA02e77pxXILt8xay
         dTR8PytQ6FRNwSuH8yjHxdBrDl7EGrfjOVtmoNAxHgrpkptYt571s/jCZjtk18cAMmLI
         NOHYfFOxeNTnWmjoI4ehUXfksn2kPxzSRagWq+NNNTn9Ut9/F/2Rl+8vifZj7gl4u1g8
         jdR6bm/KD1cQSlG8H1hddyaFzHCSXvy6elBL0eh3Mx1JKwNBgXkUm/1rWgvMpyBmRVBr
         7g0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=EuGl8foUwa0ZNP+ctiDFqMgb5hlvE3Jb46ubUGK9BHM=;
        b=y/d5HMxiCHYd31ojyFV0ruaTTqai7G3msDGRsLDDy2VI6ty9Vc2eN93ptH4yRa/1mB
         cp+pWDdwPUNJSFblRvQ8JIp3spySniRktm/P9FfKkDFgMDwNYXGF3TLTPKotuuD9Fk4J
         r4hF86lVFHFHg9VpEKY/Lswutec9CNEVPGLmDxjp9C4TNV23G2CwYO9/pfDKZrMrbi68
         W+aWOiU4ZaZL13wHk85iHxEod420I9pjRAuFxYgRg/lPnu2Kafu393Kef+2B16bg4Wl3
         QGghNoZk0P0QW8piw83qYIyJ5pSbx9tKdl+NAEdR+A1NTMZGq9GoA+9UVME0mtvJI0GF
         9zvA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=X7+1F8rl;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=willy@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=X7+1F8rl;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=willy@infradead.org
Date: Tue, 22 May 2018 04:22:30 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Huaisheng Ye <yehs2007@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, mhocko@suse.com,
	vbabka@suse.cz, mgorman@techsingularity.net,
	kstewart@linuxfoundation.org, alexander.levin@verizon.com,
	gregkh@linuxfoundation.org, colyli@suse.de, chengnt@lenovo.com,
	hehy1@lenovo.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
	linux-btrfs@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>,
	Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC PATCH v2 10/12] mm/zsmalloc: update usage of address zone
 modifiers
Message-ID: <20180522112230.GA5412@bombadil.infradead.org>
References: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
 <1526916033-4877-11-git-send-email-yehs2007@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526916033-4877-11-git-send-email-yehs2007@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601087569730678169?=
X-GMAIL-MSGID: =?utf-8?q?1601163130308414751?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 21, 2018 at 11:20:31PM +0800, Huaisheng Ye wrote:
> @@ -343,7 +343,7 @@ static void destroy_cache(struct zs_pool *pool)
>  static unsigned long cache_alloc_handle(struct zs_pool *pool, gfp_t gfp)
>  {
>  	return (unsigned long)kmem_cache_alloc(pool->handle_cachep,
> -			gfp & ~(__GFP_HIGHMEM|__GFP_MOVABLE));
> +			gfp & ~__GFP_ZONE_MOVABLE);
>  }

This should be & ~GFP_ZONEMASK

Actually, we should probably have a function to clear those bits rather
than have every driver manipulating the gfp mask like this.  Maybe

#define gfp_normal(gfp)		((gfp) & ~GFP_ZONEMASK)

	return (unsigned long)kmem_cache_alloc(pool->handle_cachep,
-			gfp & ~(__GFP_HIGHMEM|__GFP_MOVABLE));
+			gfp_normal(gfp));
