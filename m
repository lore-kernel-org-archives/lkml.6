Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsym31TBM5vS61wjEa1d9AXEJvPheDPWWhPDC8ywIUmbsCJ5Eg5hVrQgf+2KZesa9JOGINR
ARC-Seal: i=1; a=rsa-sha256; t=1521484175; cv=none;
        d=google.com; s=arc-20160816;
        b=Rt13YIYB9CVw7PaoXaKfcc6LHDmhwWzaNGeFazTs0JRoCEq+PnHIQrp8kS5EfTxab+
         1fwKhymmJ9wMJaj7Yba69C3TW16GgqIhzcv6kjAXmJsEOmGKhpT/4JQuryvVWM/D4ENe
         C6nhEz1mKNAGRTHykxsKE/f8oQlGgoN1c4TZNO7Rs3iF6OKzUurp0QZWuquyRUEQFF3p
         hiLe83PHF0GLhMWlzRLV0Vwn675XR8/OhP5BxRDek5/Snr9dp0vEGVoWt6Pi5GBeP6bJ
         Qc7e17Wo0bAedpKuUd7u8hmK/hTrLN+/1IAxzvmsi3ZpBbnYHa/Q1vSJHPRpSRQMMnuN
         axHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bgigQL8GMuGAGVwYNFArfogdEoa3Ij3isgPEdxzlh/E=;
        b=Lxsys/GlfFW9q5tSpyU3HzjNdpZQboUzqDvnw3tZPJTCy14nQ1RMQHCPiAD/ZTspl4
         2Ur4SnaVmJc2du3CPwX9oActYykTUNWq1Yy5SQtCKNw4isDyIt67Z21kaeMoIbFmeTYQ
         ufIPqostduto9jNpZYxAN38Q/XvRGa5RbRA2LZ1OZGu0zTRaiZ+Idkji/CoFUpSdBbr7
         vhHVTYxg1/oNJF16TficF+bgsFEKJ7eLSAiOPuD99KSIM265owTKb4QhpgGXzZGjGRB3
         SNF+0Nycp+PmyXWIzFsMxjASkD3CAsjSGMG9RXPXRwtibtRzmbhFt+h9/s/VQQtpS54v
         SPdA==
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
Subject: [PATCH 4.14 18/41] drm/amdgpu: fix prime teardown order
Date: Mon, 19 Mar 2018 19:08:18 +0100
Message-Id: <20180319180733.429608106@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180732.195217948@linuxfoundation.org>
References: <20180319180732.195217948@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391693879496506?=
X-GMAIL-MSGID: =?utf-8?q?1595391791086350676?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -46,6 +46,8 @@ static void amdgpu_ttm_bo_destroy(struct
 
 	amdgpu_bo_kunmap(bo);
 
+	if (bo->gem_base.import_attach)
+		drm_prime_gem_destroy(&bo->gem_base, bo->tbo.sg);
 	drm_gem_object_release(&bo->gem_base);
 	amdgpu_bo_unref(&bo->parent);
 	if (!list_empty(&bo->shadow_list)) {
