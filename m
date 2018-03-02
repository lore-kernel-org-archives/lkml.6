Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsJ8Wn8odqcgMqW+LwQSFien3/UnVHq1lsrmrETPMIlDViwqLYOg1rjgo8YEcvbM43NtfDe
ARC-Seal: i=1; a=rsa-sha256; t=1519980719; cv=none;
        d=google.com; s=arc-20160816;
        b=xCeYkNfSLuGOyuhsF0BWryiwLNHS0FOZrL2fYBCIDxyfrlW5XolAYMBHjijOWEvj9r
         3xaD+b/aT8u2ttsGlbgnJu0RVaUqxYKy4qNUD0/wDFIdsqsBvltBvlvec+qx4vwJab4O
         /jsnMOkbLqjNyxMsP5bUaT3iKbJz7wIH95uDbMoBk8SNL+Ann8Tc5mZp5okxfEpgyuWj
         9bwnwsyb9UeA5uhT10YxIJ4x5VgSigWzH604qqlkPkhT+U/BGR0s106X4VaE1+riNzQG
         OcVl1yhZqvVLPeRZB6uWhaOQPXIPtQ30N/gsWyxk5eSHmI9YtX/H+WFkso/17aqXWE/u
         sr8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fH8T9nzzkPNbhh4wwOiGBL3IuyrKcvQqPEljeNiTVdk=;
        b=vpkx2xB4KUE8M7z9AM7Bda/gawOxbfzBHisSY+SBq8D8JkdrGheqadEIHKK6V1rDT8
         0e+YiqWMiiBOo2MWpITspCCxuGBxvyh4mud9FJexGlX0yLFdPgfb2iSZN5ybCgYHn+eD
         4LTTKYSLvBQIpdsh4sjloWhTgX7qz3Qx1S7zSPrTP3eDd8eynH3umfrfugI7SogL1feF
         bvpekGVxBOnzdirHDb9k2NE1+PRxnaGWxdDvqaR02Wv2iSkTC08yhiH2X+5jwBrR4Z7e
         H2+YibqDPTT0DFNKr+voGtStWnAgpVTJK3gXXB50u7USSAWAjphMRqyBR/0oNNjo1SVB
         kDkw==
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
Subject: [PATCH 3.18 17/24] drm/ttm: check the return value of kzalloc
Date: Fri,  2 Mar 2018 09:51:14 +0100
Message-Id: <20180302084239.990044316@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084239.157503766@linuxfoundation.org>
References: <20180302084239.157503766@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815303183169989?=
X-GMAIL-MSGID: =?utf-8?q?1593815303183169989?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
 
