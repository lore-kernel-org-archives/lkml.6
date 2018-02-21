Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2247ZHu4aho/3zMFtTzpBx+LKqSVI8G9C+LVb2ykEZ4BBhSxwxgOyUrgIVCCn2OPo7ckomZW
ARC-Seal: i=1; a=rsa-sha256; t=1519218579; cv=none;
        d=google.com; s=arc-20160816;
        b=yLPqRH7ArBRtHfHNN2qSzOGSOzNHYgwYyIwlud2WwB4H3DU1AMdoQ+jzAOjKJNDu3V
         uN5UwFHVPfVshfibPbWvexL9nDGWVAQtqMVDnkjz0ubk2aMvQ5fL5G7UCDeq3Es7m0lS
         bi/MSDMrFe8LwgLDjpdru1QJo98kDm6F/wCI1ueYPSSIinj9QVjc8K7/ChKmHHmWpCBc
         A1c40V4UdE6XwG8q/KeHgEkOMggQYhfXtd2OqoGhDSa2tYMiFpSs1pn2W4C7Bap5dcck
         MfAf8RaPmZsLX/6Ak2LF/YoGpj64SivoeBQHDUDU9T28UqVwTQZoz/Wp+NboQzyrgK3l
         BaOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=46xLsvLO+Js4lfd8DZujKlJw5FWxNM9tcloni4boFa4=;
        b=K93pkD1ImAp9YdsyLl5uuuuO087dodnQjf/pyonvSdqgmjLvtKICCdwpaInzwEr43W
         6USTRKYX24hhN5NGAOFF2EnCUEv49LGPxfCVvGD7VcguDMgbbgWC1pbqmrDeyXd3iaGL
         fjkulULKEzzMZ5EcfJMF9FYMbX7Hbi3eNQsENYB8AuEizdWr44+uXN4JDIu/Z5cujbo6
         vU5KEyQwTL9N4EHKcWqc1DWZpsx+LLcTURSSF4oyB7fH54j79dIjQxWIfrFRaoJSJoeM
         jARr0me9cjUcjtrbbYfz4J2Rx5nyD5iTyz3Mb497iG2hT/fcTdghKg1JpRoqTKCR1Xrn
         HDHw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.15 088/163] drm/ttm: Dont add swapped BOs to swap-LRU list
Date: Wed, 21 Feb 2018 13:48:37 +0100
Message-Id: <20180221124535.228959261@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015655531949481?=
X-GMAIL-MSGID: =?utf-8?q?1593016141060524832?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Kuehling <Felix.Kuehling@amd.com>

commit fd5002d6a3c602664b07668a24df4ef7a43bf078 upstream.

A BO that's already swapped would be added back to the swap-LRU list
for example if its validation failed under high memory pressure. This
could later lead to swapping it out again and leaking previous swap
storage.

This commit adds a condition to prevent that from happening.

v2: Check page_flags instead of swap_storage

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/ttm/ttm_bo.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -175,7 +175,8 @@ void ttm_bo_add_to_lru(struct ttm_buffer
 		list_add_tail(&bo->lru, &man->lru[bo->priority]);
 		kref_get(&bo->list_kref);
 
-		if (bo->ttm && !(bo->ttm->page_flags & TTM_PAGE_FLAG_SG)) {
+		if (bo->ttm && !(bo->ttm->page_flags &
+				 (TTM_PAGE_FLAG_SG | TTM_PAGE_FLAG_SWAPPED))) {
 			list_add_tail(&bo->swap,
 				      &bo->glob->swap_lru[bo->priority]);
 			kref_get(&bo->list_kref);
