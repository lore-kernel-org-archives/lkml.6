Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsGYxXOLDKZ8DWPZQkgKehTp0n8WCMaQ7C9+DT1RczLAijqv3ScdIv4auPJHyOWPM0yYAF3
ARC-Seal: i=1; a=rsa-sha256; t=1519981077; cv=none;
        d=google.com; s=arc-20160816;
        b=SQrc1cs9UJ0Wc+WM1SaEBdzOXbKAwLDre/SA452eDWAOexoQtgDyT7zr7PBuELoWuq
         RjRM781qpAHRZN3lis724h8Usax1NP/TsXf2FftEYD7/YesivHiy4y5iZqDfuxKsfxm7
         IkFLsBlndyrLFQtTEJTpvAZ86mWzYSaCAhbzS0y+/4fhMlYIMN1nXAps8iq8/7exEszt
         MWBy6fN0skNo4VsyukNJH9w1cidBPfRJV0cbJ1goHthVLaegTfb8PKS4ksX2ey5Gsl1W
         bcnDHVkD3hWNfKSgAyCH6kV2koRzARlxW8EdBOIKNPt229ct+V6BcIPZiGK62XEAOSm/
         4wxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3StV3OegIm8ZXQ7t8k5Jh3osi2DRhfOnqoVArvgQI8E=;
        b=mwEG5Z0c1lrdiYP/4PxyekV9cIPgjXZKWiTBnwFi0veQJUqdwrtj83xwRzI6bHByEz
         DPbM+UVWlLL+mHOr+CEQsRaX43o5K6GTiO88o8ZmE3GYBcvoSF3yq/Fy95wFt2XI5Uq0
         DKSXkFWWloEogi/Uw7PkvxpMGillJTod1cNADwquq2TOrUcbymWu/6sjDK88P0l2F27n
         xsp+sxYHNliqlincAOiFfK9NuTJ74hNzvyej7gs38F7/hCRNkL2N58pXfxXcn4dMoyOy
         slRA+LiNbXO7N1JTR7Ailr7YKwdy0UzPFJ9vR/E+USE6qxkvzflv5pf4+w78/yc8cOh3
         igyQ==
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
Subject: [PATCH 4.9 41/56] drm/ttm: check the return value of kzalloc
Date: Fri,  2 Mar 2018 09:51:27 +0100
Message-Id: <20180302084451.651166254@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815303183169989?=
X-GMAIL-MSGID: =?utf-8?q?1593815678456815584?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 
