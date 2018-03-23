Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtW01Z5+sweqEj45I8OZnIwqRKQMRq/VJiVAXGisNBIAKnW8IvCrf1mRs1ID3ndMWLYzOI5
ARC-Seal: i=1; a=rsa-sha256; t=1521800386; cv=none;
        d=google.com; s=arc-20160816;
        b=iLDTUmKsB5wmkV0CVikWnRPVYeyr9wOPL6zO+h+HT8oBAAoCaSUPXHKQbLRHdPZseb
         p3tUHMg71Pz3beggzvObDkkY5cj1CHuYUv36J+HtM4kee6uwoVme2TSqJYGrcs3Swicr
         nZlO1X6YYrt0J/MWo4MhdDG9oxlZH5QmW2CX5Lbt1IlYb1KYxZ5a+BLAi8Cc3wAC/9gf
         IIkmcuxNha7qHtgFZ0d2PrSiNs2g1ttmYLTIc5em0umTX979Zvz1ZgYEl7I440as5l/S
         aIAS5ZQYW04pgu3D+wb1ssNBCs3HpxABm+JJCZypmEFN6r3irr8Rpy4+ebQCaQ6QdJD5
         zZUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7VvVlf5epVKF/8K9bI6CNzTs7fzeSzPmRkoWvKNKU5g=;
        b=INLagtaggRtSNgqAq2L5BicavI6BN/R8T+CCEdznGz5S4h6EF4YEq1LsphfO7kJnnw
         eCXbteP9PS7GtWPXlaP62oKC2BmXRQqKKJmSx5iRtbD3qBm90vasUoR/2D+WC7MJtbRe
         uLJMdv6wNOKkAX62rkeqapIafj5jHhovp6L5D2E14NthXPaEtfp4+kP1BxOQMdMx+onD
         vsekZi0xb638KOaubh/dF983L+frHw91V7d2uEmxe+nRHoRz05qOfLA5eGOFfGuhJ0rB
         7xbVd4j/I5A/PUyQnrG0nzrpY/r1fxnIa/XLisvFlJOFclC0j8n8sr+dd+LqpzrIDwu9
         LnLA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Prakash Kamliya <pkamliya@codeaurora.org>,
	Sharat Masetty <smasetty@codeaurora.org>,
	Rob Clark <robdclark@gmail.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 37/47] drm/msm: fix leak in failed get_pages
Date: Fri, 23 Mar 2018 10:55:28 +0100
Message-Id: <20180323094249.700767402@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595721904913881579?=
X-GMAIL-MSGID: =?utf-8?q?1595723361805894186?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Prakash Kamliya <pkamliya@codeaurora.org>


[ Upstream commit 62e3a3e342af3c313ab38603811ecdb1fcc79edb ]

get_pages doesn't keep a reference of the pages allocated
when it fails later in the code path. This can lead to
a memory leak. Keep reference of the allocated pages so
that it can be freed when msm_gem_free_object gets called
later during cleanup.

Signed-off-by: Prakash Kamliya <pkamliya@codeaurora.org>
Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>
Signed-off-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/msm/msm_gem.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -83,14 +83,17 @@ static struct page **get_pages(struct dr
 			return p;
 		}
 
+		msm_obj->pages = p;
+
 		msm_obj->sgt = drm_prime_pages_to_sg(p, npages);
 		if (IS_ERR(msm_obj->sgt)) {
+			void *ptr = ERR_CAST(msm_obj->sgt);
+
 			dev_err(dev->dev, "failed to allocate sgt\n");
-			return ERR_CAST(msm_obj->sgt);
+			msm_obj->sgt = NULL;
+			return ptr;
 		}
 
-		msm_obj->pages = p;
-
 		/* For non-cached buffers, ensure the new pages are clean
 		 * because display controller, GPU, etc. are not coherent:
 		 */
@@ -113,7 +116,10 @@ static void put_pages(struct drm_gem_obj
 		if (msm_obj->flags & (MSM_BO_WC|MSM_BO_UNCACHED))
 			dma_unmap_sg(obj->dev->dev, msm_obj->sgt->sgl,
 					msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
-		sg_free_table(msm_obj->sgt);
+
+		if (msm_obj->sgt)
+			sg_free_table(msm_obj->sgt);
+
 		kfree(msm_obj->sgt);
 
 		if (iommu_present(&platform_bus_type))
