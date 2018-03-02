Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu5iGNZ7djdduTcJGOcEcmXnZMLZ+wCVCunaRCdWUHkjeu5+0f3bFFydSHvmOS8dXjHXrz5
ARC-Seal: i=1; a=rsa-sha256; t=1519981389; cv=none;
        d=google.com; s=arc-20160816;
        b=JXPW/NTctm5cm4Gnfr8BmOR6JG9PZjZPWMoBpwQO8UQftyl75ay2JAwQWBddqmXaRo
         pIHbx0mZ6OyU4iMhM+5me68kVFzS+YfIxogzk0xgelC8/LfIwguoYqkZXa5+1MtfeoIp
         3iJsv02RgrfBzPxIUY31pMVKXPc6yyQxzZQK2bn9CJ+ZxCgX9MgG0bGIubYHAT6E9XT9
         n8n/+FLOqOyK7UMwaWTN32KWz+IYLof5009tcczlPx3nCQ8Ro8aZ/cbbkbCRk846Jej3
         MT/lwvZb223jQ0vU1Jn1R+58iGLRDf4MEtpmYeACM76PZJMD8bsM7YnFek2Um++fp2VO
         QvBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=csmhDmM0LDPVUm+81+Eu8iN002ex2qPELeF9y/fIv64=;
        b=RtUvGsawPg0x+080DS39KBV1kzPb5SilXpH4eG+qBZMYtCvfWndrytEEqQmC9K+w9T
         HWNm0C4LaDhvE5sh63SHgaBGW0ZWubKGjY0/m38Nc1oEFOQWg3WIamhkaEoSfjycscyp
         2KP3iBkZsMXAk8ET0t8ymgpx5i86DVaMNIAWU7et+3P+h7aXLcq40QKUoiCwe959kGO6
         OuQPt/bnfK/+ugUUjAcyIPJhi/YyJv70rKh0yV6xrhl8YxCcWDz0CrB9hpzXYbCbqeg8
         uw7qD8qVafyFNDffiuEz2kam9cmAYB2ZImtyIuLJMgv4QJ0y7zuI9Lin0W2nKCRXVG80
         zakg==
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
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 077/115] drm/ttm: check the return value of kzalloc
Date: Fri,  2 Mar 2018 09:51:20 +0100
Message-Id: <20180302084506.970362081@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815303183169989?=
X-GMAIL-MSGID: =?utf-8?q?1593816005483427803?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiongwei Song <sxwjean@gmail.com>


[ Upstream commit 19d859a7205bc59ffc38303eb25ae394f61d21dc ]

In the function ttm_page_alloc_init, kzalloc call is made for variable
_manager, we need to check its return value, it may return NULL.

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/ttm/ttm_page_alloc.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/gpu/drm/ttm/ttm_page_alloc.c
+++ b/drivers/gpu/drm/ttm/ttm_page_alloc.c
@@ -821,6 +821,8 @@ int ttm_page_alloc_init(struct ttm_mem_g
 	pr_info("Initializing pool allocator\n");
 
 	_manager = kzalloc(sizeof(*_manager), GFP_KERNEL);
+	if (!_manager)
+		return -ENOMEM;
 
 	ttm_page_pool_init_locked(&_manager->wc_pool, GFP_HIGHUSER, "wc");
 
