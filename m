Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvDjcxL3t7X1tJOt9IrABb5fKAK4g9odxhsh1H6M+KeJMmqGGwYdlgqaxqqliFE55xAPxr/
ARC-Seal: i=1; a=rsa-sha256; t=1521484178; cv=none;
        d=google.com; s=arc-20160816;
        b=BtqZPAytB8ER0145bJWj1rl4if8ikx3T95NhA/kzla3ub5oY23kVL6Oau0f9iypy1I
         h/EzEhmFfrpFVv3LjpSb0KDDy0dAWeErNP9y3dGsYDM9PwBrpO0w+bmwKLvrkzn2OeJi
         Dg90yNwqLhsJaAC8KJAci55TFeZZAIoHmndPYlLZSFy9b0BHATIMkoGIjjrTdpLQ1T14
         dErdehOxt3QvmkRITJeP9Soh+QFSfqyfsr7oqbSZ9c9kEgMfOJu/Bh14JYJxhWqevtxA
         VIXJyrzzxWxs/Q9FVyETbvQp45RzuQDh5SB59MwSZYrJtF2y/fUDGGShJhJ+raL/iSXr
         MPQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mX3Cos5V3f7kW+EY81xfqqh/0qUWVfm9+sKMZAHQuyQ=;
        b=R8pCMZwnpedVoxgBpeJ2SLM+mWh/d1I67Rd3FIttIpHFB8LAAruQE+JBh9kqrrL+dL
         XBPbnpCuy5UTrKav1cts3KiHbZTYS+zPeeLkq+9nlb9qkLUb6YUl/eV+SNvm7lkf/aJ7
         Q0zRxp7v57bgnciOd0wB50aALtXy8IEkbEuLO88MQEiT/aGnZk+NL/q77pnDcfdRqQNK
         wBpkiWdKg4q5Yi9TYkxbkWaBrHqgDEK7vwQ+I7W2EeX+rEpju9F+ASbHbdmbWuIaVJVy
         02cnJfM4V24Q4PcECYnZjKDCVU4ZOyiU3FM/0u/yQBGlV4aLL0SNsQor7J1/4nqhbkB9
         twxw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	=?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.14 19/41] drm/radeon: fix prime teardown order
Date: Mon, 19 Mar 2018 19:08:19 +0100
Message-Id: <20180319180733.525120748@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180732.195217948@linuxfoundation.org>
References: <20180319180732.195217948@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391794340930448?=
X-GMAIL-MSGID: =?utf-8?q?1595391794340930448?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian König <christian.koenig@amd.com>

commit 0f4f715bc6bed3bf14c5cd7d5fe88d443e756b14 upstream.

We unmapped imported DMA-bufs when the GEM handle was dropped, not when the
hardware was done with the buffere.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Michel Dänzer <michel.daenzer@amd.com>
CC: stable@vger.kernel.org
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/radeon/radeon_gem.c    |    2 --
 drivers/gpu/drm/radeon/radeon_object.c |    2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -34,8 +34,6 @@ void radeon_gem_object_free(struct drm_g
 	struct radeon_bo *robj = gem_to_radeon_bo(gobj);
 
 	if (robj) {
-		if (robj->gem_base.import_attach)
-			drm_prime_gem_destroy(&robj->gem_base, robj->tbo.sg);
 		radeon_mn_unregister(robj);
 		radeon_bo_unref(&robj);
 	}
--- a/drivers/gpu/drm/radeon/radeon_object.c
+++ b/drivers/gpu/drm/radeon/radeon_object.c
@@ -82,6 +82,8 @@ static void radeon_ttm_bo_destroy(struct
 	mutex_unlock(&bo->rdev->gem.mutex);
 	radeon_bo_clear_surface_reg(bo);
 	WARN_ON_ONCE(!list_empty(&bo->va));
+	if (bo->gem_base.import_attach)
+		drm_prime_gem_destroy(&bo->gem_base, bo->tbo.sg);
 	drm_gem_object_release(&bo->gem_base);
 	kfree(bo);
 }
