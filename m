Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqCXCQ73adRr+JulIGs6l5n7AExsSPmhTb1Erc9VizaoOT57UNM+Y8n9jZSdqTzSOEUNKtL
ARC-Seal: i=1; a=rsa-sha256; t=1526281170; cv=none;
        d=google.com; s=arc-20160816;
        b=x1kYAxNDIRL3+nozHZoDYq9hp+qsQezuIFEYpBVCUSbkh2QKNump2J0l0HzfqtgLam
         OTCKcx0ghh0oWO0oCZsS7ul1j49WnNwXcDFkUfJvr2pYivEkR0UMkP1OS3ZsnbES4mOz
         d4yCJTD3unZuJa9joCF1dtIPUHctMf32vML4Ywt9iPk46Nfvi2o7/wZU3CAWNpCFv5hh
         QF/oyOYTHkUsPeY8uQKLOzQ/MnXM2LyyvuCSUsdao/Ewq4j6pD9PcClMnkKCOS26/kEo
         Nx+ogIi+7svRjKNXgZTeRHc3fia3KTcB5/ZIYVAZNqkIu0qfqEuYo3zFXrHVkknuhS9T
         bhhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=CkU7M9kUr11ZGdBLQArPDD4oWgpysD+Li9mi4W1vOUA=;
        b=RbMiWWSo/7fcfXy1m+aBczqgZVWPlnIdvqDk40JqVqJFWGd4ohxDiITlBV/zIm6kvE
         A28dqAHEK0soVwt5uRc9rcfrl6awr+uisIRfyhkOsrnBEwUVXn/V/NRSJc52wcwvwIF9
         sQeJSRWV1DRFH9qKBaA4EERsnRfzMAEKq5goYVjVxwHFa4YCyoJRrENYDaaOrJas/tUo
         7bGncTj3ILn3V7iQ9orBgkSeQrDXJnMtTZpJyFSxrUenkr/Pd/+2pzMVpXold7Mw9ykH
         E4d69EkZoDEO2hcVrbukgxVu+zlNdhEhzuKpKGsFY+jkkQ/Wr6+UBXWy1iDwxsch+t+5
         wEXw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=wleV3YWD;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=wleV3YWD;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	=?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.16 43/72] drm/ttm: Use GFP_TRANSHUGE_LIGHT for allocating huge pages
Date: Mon, 14 May 2018 08:49:00 +0200
Message-Id: <20180514064825.022994719@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421804879220288?=
X-GMAIL-MSGID: =?utf-8?q?1600421804879220288?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michel Dänzer <michel.daenzer@amd.com>

commit da291320baec914f0bb4e65a9dccb86bd6c728f2 upstream.

GFP_TRANSHUGE tries very hard to allocate huge pages, which can result
in long delays with high memory pressure. I have observed firefox
freezing for up to around a minute due to this while restic was taking
a full system backup.

Since we don't really need huge pages, use GFP_TRANSHUGE_LIGHT |
__GFP_NORETRY instead, in order to fail quickly when there are no huge
pages available.

Set __GFP_KSWAPD_RECLAIM as well, in order for huge pages to be freed
up in the background if necessary.

With these changes, I'm no longer seeing freezes during a restic backup.

Cc: stable@vger.kernel.org
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/ttm/ttm_page_alloc.c     |   11 ++++++++---
 drivers/gpu/drm/ttm/ttm_page_alloc_dma.c |    3 ++-
 2 files changed, 10 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/ttm/ttm_page_alloc.c
+++ b/drivers/gpu/drm/ttm/ttm_page_alloc.c
@@ -904,7 +904,8 @@ static int ttm_get_pages(struct page **p
 			while (npages >= HPAGE_PMD_NR) {
 				gfp_t huge_flags = gfp_flags;
 
-				huge_flags |= GFP_TRANSHUGE;
+				huge_flags |= GFP_TRANSHUGE_LIGHT | __GFP_NORETRY |
+					__GFP_KSWAPD_RECLAIM;
 				huge_flags &= ~__GFP_MOVABLE;
 				huge_flags &= ~__GFP_COMP;
 				p = alloc_pages(huge_flags, HPAGE_PMD_ORDER);
@@ -1021,11 +1022,15 @@ int ttm_page_alloc_init(struct ttm_mem_g
 				  GFP_USER | GFP_DMA32, "uc dma", 0);
 
 	ttm_page_pool_init_locked(&_manager->wc_pool_huge,
-				  GFP_TRANSHUGE	& ~(__GFP_MOVABLE | __GFP_COMP),
+				  (GFP_TRANSHUGE_LIGHT | __GFP_NORETRY |
+				   __GFP_KSWAPD_RECLAIM) &
+				  ~(__GFP_MOVABLE | __GFP_COMP),
 				  "wc huge", order);
 
 	ttm_page_pool_init_locked(&_manager->uc_pool_huge,
-				  GFP_TRANSHUGE	& ~(__GFP_MOVABLE | __GFP_COMP)
+				  (GFP_TRANSHUGE_LIGHT | __GFP_NORETRY |
+				   __GFP_KSWAPD_RECLAIM) &
+				  ~(__GFP_MOVABLE | __GFP_COMP)
 				  , "uc huge", order);
 
 	_manager->options.max_size = max_pages;
--- a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
+++ b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
@@ -915,7 +915,8 @@ static gfp_t ttm_dma_pool_gfp_flags(stru
 		gfp_flags |= __GFP_ZERO;
 
 	if (huge) {
-		gfp_flags |= GFP_TRANSHUGE;
+		gfp_flags |= GFP_TRANSHUGE_LIGHT | __GFP_NORETRY |
+			__GFP_KSWAPD_RECLAIM;
 		gfp_flags &= ~__GFP_MOVABLE;
 		gfp_flags &= ~__GFP_COMP;
 	}
