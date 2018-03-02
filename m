Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuE9Ddi3l82uQ8SQD+v+UHNrdM51I6i3wLzhfzjCQBDDJufa0cc9iHE+Y8iQVg8whavugIk
ARC-Seal: i=1; a=rsa-sha256; t=1519980893; cv=none;
        d=google.com; s=arc-20160816;
        b=o7CnYthozJjFVZjOVf98TR+mAyZiT5WphEp0O3hllJ2zZgI4X9AXmilFreMKjasj8s
         EmzABDF/Fefpr8qUn82k0MMyCzsFIx0YFYSoOlGk4jhlBIIZkyghyj2zLQE8VwGTI3ok
         MtD9xKXjXttebw5BJ5RqIkINM/wAhDabFTM+1Bf0ndZQGk5kKeqIrKwY+WS0iIcPn4Gj
         M/2dUw/d5WqgWO9fy1gQBlQmFsvVrSOZAsPpxLOHoE/Rsgyz8IuNKeiogAmgbcRJwb7S
         kukcs+FNSerRwiBH568tmHT/+fiXSoVDg2Ca2dKwBkTPz+2S5AqmfWo7Icbw5gF1qS51
         UPzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RodYCVExXASpgTAmtPKxok6FuY7Y5A/Z3sSpX2Xnnyw=;
        b=Ta5LF6LvgYkEq3aDfEcUtadfuJ0BnoPcDOK/IJMzEVy4Rkmxx5WPkiK9J+QCV3xMO2
         1Ip8WhncZ9E25DUZmZTF2O4eM/PNGTeI23wKX+3tcKk6rdstA8gZHv5mEamnWWiTVHK6
         u9UFRihzX3hrVwq7H7GYmn03y7wnbb8W+zZiVAz31Yj+xQCwtqUn0ov5R//41PzgVnLU
         mwT87izp3+MRfBxwYTxNVqjHPkP/YU/Ld8LW6lcbE5fDweBE23Czh+0XpyYNaxE4IZO1
         ZC41+z+DlDcSDkh+LjgEs4Zk5PH1hEzW5mSns3f7PPefMZHI0f424qHCkekzRz9FRf3X
         CZ3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Xiongwei Song <sxwjean@gmail.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 23/34] drm/ttm: check the return value of kzalloc
Date: Fri,  2 Mar 2018 09:51:19 +0100
Message-Id: <20180302084437.535534570@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084435.842679610@linuxfoundation.org>
References: <20180302084435.842679610@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815303183169989?=
X-GMAIL-MSGID: =?utf-8?q?1593815485522915694?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiongwei Song <sxwjean@gmail.com>


[ Upstream commit 19d859a7205bc59ffc38303eb25ae394f61d21dc ]

In the function ttm_page_alloc_init, kzalloc call is made for variable
_manager, we need to check its return value, it may return NULL.

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/ttm/ttm_page_alloc.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/gpu/drm/ttm/ttm_page_alloc.c
+++ b/drivers/gpu/drm/ttm/ttm_page_alloc.c
@@ -818,6 +818,8 @@ int ttm_page_alloc_init(struct ttm_mem_g
 	pr_info("Initializing pool allocator\n");
 
 	_manager = kzalloc(sizeof(*_manager), GFP_KERNEL);
+	if (!_manager)
+		return -ENOMEM;
 
 	ttm_page_pool_init_locked(&_manager->wc_pool, GFP_HIGHUSER, "wc");
 
