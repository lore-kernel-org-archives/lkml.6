Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtVsnCr1RplJYhEUs/igLVSfs79S/7igul+gy0Tu3RDe43y+9mD4Knd8y6b3zA/q6nyOA7q
ARC-Seal: i=1; a=rsa-sha256; t=1521484083; cv=none;
        d=google.com; s=arc-20160816;
        b=J5wibaReBRgkq9nNhwcNONEY8NeYXvJAGDgkk0UfiDpg7n8i60UO8pvNHXzBXgxlX2
         0KOmarCKdXFj6ZNbkhjM7nP08QYtGWrKGsTh2YjdBJLH23G3siyk1WGQrUNPWnwXl5Wd
         /b+sIaIxyDfWK9CEcTYbsanNP6YhiZTx5sP6Eefyr67iv+x/hwgkwkqbxnTkAObzS70g
         +j99L9atBujiFVkCdEDX4l5Nj0b/BgA4oLd+BjjWDn4/Od5BPLz5Odk1YkEo864T6Pdn
         iH/26beqJWLFGaCejQ72tjmZ6PT/fqcUaBBzjOesI8BRJSKe+bp9J8wu6elQqbqyoHTV
         d5jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=s6dWLI825xQ9fXLGfcxns2nZKhUiuWnM4dXmWvxjo7Q=;
        b=W9uxtMzSx6YexhMV4B3VOhxElnloYqQBq7ZMhCdKBP2Ej1z4bgiwkqCocuK1kIfJf6
         sYMv1WwtE9LyEQ2T2l2yu2ECUvpqbbU92yFJkiR33UswFFb52fYzJjachELc9UkCzmmf
         JAM9FRHgWYk/vtdyfrUeHyYf5Uct2AppxH82mh+wOy/PEj3Md4jxUcJkwjV7jseHWqff
         ufgc2oOv5jLiQN0Fw9jsCVDSMJod3qjik98SF9afIlqeVd5lutpwr10MPINd5hZ3PHeZ
         BpiLkB0unGJqvue/+kjuBVK1PAPFuDWIY2+prQ/nhtgXoLTWf7WUbo1Fb7j3Wz4mj8Wl
         r6IQ==
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
Subject: [PATCH 4.9 226/241] drm/amdgpu: fix prime teardown order
Date: Mon, 19 Mar 2018 19:08:11 +0100
Message-Id: <20180319180800.529160974@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391693879496506?=
X-GMAIL-MSGID: =?utf-8?q?1595391693879496506?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -94,6 +94,8 @@ static void amdgpu_ttm_bo_destroy(struct
 
 	amdgpu_update_memory_usage(bo->adev, &bo->tbo.mem, NULL);
 
+	if (bo->gem_base.import_attach)
+		drm_prime_gem_destroy(&bo->gem_base, bo->tbo.sg);
 	drm_gem_object_release(&bo->gem_base);
 	amdgpu_bo_unref(&bo->parent);
 	if (!list_empty(&bo->shadow_list)) {
