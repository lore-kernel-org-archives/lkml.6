Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs1OTT2JIX6KH0yvCpCH5CGu+MBER6xeVy3GoIFBoOA8jyVWBGdzch98UXJib9WZxagi6wy
ARC-Seal: i=1; a=rsa-sha256; t=1521484289; cv=none;
        d=google.com; s=arc-20160816;
        b=uVt9o6ATCod0c2FwkIep3bLE0HcfmEosMKhX4aXDv8zPNsk5HvnKnRAYTLir7xleVi
         Y+PRI3UIn73ufzbqLTfLlu8S5KiKBpaWE3CjFB4otHEG8a/qfLC96bUy/47je58glLXP
         XZULTmo8YNVeYuKwnLE0XOyrzOX+UnJOeFip4dBkjrUpR42+8vJD6YT02HJD3vwhWdwi
         sI8tM72RB5/UVbk+uNR8RJDrODg7BR+Qa0srw7i95Yn7ekaeVSQZ9RsAnG1StkMxvklv
         mOdkNugv6+VbB6VwoAwtifS+T+UtAM/ivnTABsuo0N+b/fG+v8/D0QGYer5oMNKB/2np
         rYcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wtdC36hpHhICenNmhgDuEOQp2/XeolDPyU94RgenfbM=;
        b=rBJd91uSCxLs/n2ohK0sc2KQX7eXKHp/w1fexsgTrsnO0nDZzdMfUWE+VP2duVXVOo
         //Ki3vOVzvwvjNn7i6WxgWmS6GvYd8w8PNNhAkvaYglVLMo16ZLpP8B/K5KVuVMl9qw4
         AsbrfU0Reqp01SqxzJ5iGNiw2pq5/O4DOvX8gfH9L+I2NyUfAc7QmcOthT0Czj0hUmgk
         mgeu6fVS6R9lgrwGF1byqNGHivSWfQ1gul3z5x6DR9b4fMtAZ8vWj/A4AFfOnQ9Lb7wJ
         iTx3cXspadFX1P4txrWvzf8nhaR9N9o39/SSsZfyEYc4Tu6iCXbIwpcF8FxGiBsnn8UP
         Arqg==
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
Subject: [PATCH 4.15 17/52] drm/amdgpu: fix prime teardown order
Date: Mon, 19 Mar 2018 19:08:15 +0100
Message-Id: <20180319180736.118516188@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180734.976730813@linuxfoundation.org>
References: <20180319180734.976730813@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391693879496506?=
X-GMAIL-MSGID: =?utf-8?q?1595391910425737958?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian König <christian.koenig@amd.com>

commit 342038d92403b3efa1138a8599666b9f026279d6 upstream.

We unmapped imported DMA-bufs when the GEM handle was dropped, not when the
hardware was done with the buffere.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Michel Dänzer <michel.daenzer@amd.com>
CC: stable@vger.kernel.org
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    |    2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |    2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -36,8 +36,6 @@ void amdgpu_gem_object_free(struct drm_g
 	struct amdgpu_bo *robj = gem_to_amdgpu_bo(gobj);
 
 	if (robj) {
-		if (robj->gem_base.import_attach)
-			drm_prime_gem_destroy(&robj->gem_base, robj->tbo.sg);
 		amdgpu_mn_unregister(robj);
 		amdgpu_bo_unref(&robj);
 	}
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -44,6 +44,8 @@ static void amdgpu_ttm_bo_destroy(struct
 
 	amdgpu_bo_kunmap(bo);
 
+	if (bo->gem_base.import_attach)
+		drm_prime_gem_destroy(&bo->gem_base, bo->tbo.sg);
 	drm_gem_object_release(&bo->gem_base);
 	amdgpu_bo_unref(&bo->parent);
 	if (!list_empty(&bo->shadow_list)) {
