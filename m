Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsJu02Wh9oTUv/W6o9WMnOlU3vzXII1jFITPje/dDGffkxNO7m1DW4JwJb+3TP8aqVPzzre
ARC-Seal: i=1; a=rsa-sha256; t=1521214994; cv=none;
        d=google.com; s=arc-20160816;
        b=LMI/FY0/496HHrDImqcH94n1ITQuDEWPOtuadE3OonY1RnZ3urkqHT6DCy5gt+jQZj
         CXZZ0LzuaCps9Fn6rW/pFiakrvAxrmhTGpbneRLkwkhNn94HUjnDiWf86qC7wtYii2/t
         839i+VtD7FL50GE11+hs4i7CAVhuJc36Lv/0uXJQlwpRUFiExOvKCYKCOo7xs7uw8/uV
         9S1DipqrOW7Qa1dUMcRIdvmLCkzhsfw6Nhg6XK/UDCQxNmf8DY+h597msTZ5SnDbkQVg
         wcgz1zdeXaGvEnvdVz/ZOwzagqryfhhf7VErH7s5iRIhhBvzpszgUzlraWTZd5ieXgzY
         Xcsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZtDPPOXUrw4ydZYafn2Mc5mCj5w2TOFBMxioQ8remPg=;
        b=SLrhxjnDpNvXFbTVguhh9j/Urtk3PzRznYZrW+FsdVGm93f3CAuoeSL5XoTmiAUQmi
         K6CUB01hgLunmse5jmr18XLj7zDwYNfvvkpiPlqU/v3T31LvyPLZLCaS143ZRTq3qB7G
         ygF8dFHLm6bhDRyqS6HUyaoe7hdtVzeOJPgRkbDpvCoknc6tciQAiZQo6dakLShrE1DI
         f7uyDIy6OI6S0eOO299n95HRtqT4/UHRt5OcBR5JwOosTkIul398zmx0iwp7SzGHVZRQ
         qNDNXZ3MhQgVXMXPnY2xBtt85OXtvobWPKPbLjTgoUjUDOCeAazS0HPfNvBD8+LY0/pZ
         kysQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Andres Rodriguez <andresx7@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 091/128] drm/amdgpu: fix amdgpu_sync_resv v2
Date: Fri, 16 Mar 2018 16:23:52 +0100
Message-Id: <20180316152341.090731364@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109534219532544?=
X-GMAIL-MSGID: =?utf-8?q?1595109534219532544?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Christian König" <christian.koenig@amd.com>


[ Upstream commit d4b7648d6d1774f961f3f6a758d9b009f1f34f05 ]

Fixes a bug introduced by AMDGPU_GEM_CREATE_EXPLICIT_SYNC. We still need
to wait for pipelined moves in the shared fences list.

v2: fix typo

Signed-off-by: Christian KÃ¶nig <christian.koenig@amd.com>
Reviewed-by: Andres Rodriguez <andresx7@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -191,9 +191,6 @@ int amdgpu_sync_resv(struct amdgpu_devic
 	f = reservation_object_get_excl(resv);
 	r = amdgpu_sync_fence(adev, sync, f);
 
-	if (explicit_sync)
-		return r;
-
 	flist = reservation_object_get_list(resv);
 	if (!flist || r)
 		return r;
@@ -212,11 +209,11 @@ int amdgpu_sync_resv(struct amdgpu_devic
 			     (fence_owner == AMDGPU_FENCE_OWNER_VM)))
 				continue;
 
-			/* Ignore fence from the same owner as
+			/* Ignore fence from the same owner and explicit one as
 			 * long as it isn't undefined.
 			 */
 			if (owner != AMDGPU_FENCE_OWNER_UNDEFINED &&
-			    fence_owner == owner)
+			    (fence_owner == owner || explicit_sync))
 				continue;
 		}
 
