Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELviq0hUB+FOpfQ557e3KsogqbtlLQwj/4DnKhpTjHtUd3XS//M1xZDfjE+wXZVz9rwFMJCF
ARC-Seal: i=1; a=rsa-sha256; t=1521484292; cv=none;
        d=google.com; s=arc-20160816;
        b=T2cUiLtcgZOO0jsgQKQat5BpQpqGESK8EdKGeoVSvW7Jlp+2V2hH9gxUMoMCvtq0lH
         C7TBBKHiSWiZ2arEgqdtlGn56bwhB43E/GBuuil0ppYxx+WEt3s7mVy8xj8OHaCF2myz
         LvDhmyod+gk9VmPnNO6zAiZIlix5MntuAWZrbnEJ6SPi9m42SKRhDK/ydsAoqf5D5dQN
         G9tgtEkErMis5jX473vfo1/F9bVQxckkGVvKo9sbNXXJ25gciW3vpHu1qtX/er+eYLYF
         U7y6I49rmaj3tPvpBZaQ+8PSr8yni6j1x2ORN9AVMxhylz3+73DYkU3KWv/sfpSLFyj8
         xpig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HnsDKGnAJo8H00i63epp0dgIPEMV7qyWTLDIdZ8I57M=;
        b=ahWnkC0QA5DENxd5CVAOnwySpEOG3hhLdw9izamhXnUPN3YZFMwFe3UC6Tbvv2Fjl4
         z1riGjpNg4mFqrojAQ2LqXyvtY3volLsGALiinObihrRwS5Me6EJMIm2zP3IkC8+krDF
         KzS6nE2NCDjESFTRksj2oBTo2lSytP2Ay5Cn4sqdt9ouweS96R0OpEYCmpO/cYAUZ94W
         JuQ1Y5jwxxdrvROpU2MkRrlKr9p85/YWHkcLOreXwUtoFLrSLEXO6P2L6EgDtrUKXYGS
         1XDdN1Y/EBBFvC3i309hSWvxj2lTuKX2AAvsUe9wVv/rJL4fH3hUMzZHGR0VxIyEM/3R
         66aw==
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
Subject: [PATCH 4.15 18/52] drm/radeon: fix prime teardown order
Date: Mon, 19 Mar 2018 19:08:16 +0100
Message-Id: <20180319180736.158011282@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180734.976730813@linuxfoundation.org>
References: <20180319180734.976730813@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391794340930448?=
X-GMAIL-MSGID: =?utf-8?q?1595391913312678425?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
