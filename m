Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+Gky0w2pwvy0sU4Lm3c/jkosd1+hjRI6a4P63QckxPpY32iPzG6H6DASNvMaXkIzaaJU+D
ARC-Seal: i=1; a=rsa-sha256; t=1524406123; cv=none;
        d=google.com; s=arc-20160816;
        b=lrmxOsfAfMK7GVfLjefoIgkiXyZCP/KAHgnLqgyeQ4lrdQXUaqegWb00aHQ0IeF20N
         d0hzM94RACsLN7r2NBwraHo5cmYtk1aViWVHJ2lCq5qoOcLT5+vYsNufuvivoKfatBmR
         CUtlNQGoFjjPaFuyEt11nd4uhUzgnOiAijDQ7tcojnVZOKYl2WaT7eqiFdZ6pfKn10Qu
         bfID/RxuPrj2hGcT+e/EAyI+AIxxwxnCuqAl5y9Y+ABc1uBddRlBofziM2sOXiL623jk
         dWVDgdQ3ZSgXkPD5OBdDOYCsvmAcV7n3S59oBGhLb/qHkp166vOdFCo3o27mly64puI7
         TTUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9AXYMvO0Z7tjXWmrHeWxTyAhIRTXHBccr8BaRHEreOY=;
        b=wqs1wxvnqhAri3zFRQJdQ9ubOA021KyPxFYJxyRLk4dx+CPzRKkgzhbB8/y9i7TGhn
         /14KTpjPPKs4HYQB4NjkVgo1U0o2EFlKBlZWROiHV0Lpqg83knJf4nZlqLYnpKYpiBfL
         kyzGDSkI3wW9YdAmeN21TbR6EazwGJXpt1atMW8BLH7a+3EjXiG9lErUjX4tSPmKNa/R
         wgHQSlShCR7QpXADNmORioiTxqRYsOuefPBSEoll2ibrrfNrDLA0rLPXGmwUwN/GUOsK
         b08ezrUIKBjFXkNrARUr7gpW1hPMflJNVhMhtHIYW7KsJrAiG7wA76JKT6W86Ow+UyIa
         raeA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Huang Rui <ray.huang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.14 122/164] drm/amdgpu/sdma: fix mask in emit_pipeline_sync
Date: Sun, 22 Apr 2018 15:53:09 +0200
Message-Id: <20180422135140.398951891@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455204934297225?=
X-GMAIL-MSGID: =?utf-8?q?1598455675516423496?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit 4a8e06f7aad797e92413a3042d09d3b385fa1fda upstream.

Needs to be a 32 bit mask.

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c  |    2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c |    2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c |    2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -866,7 +866,7 @@ static void cik_sdma_ring_emit_pipeline_
 	amdgpu_ring_write(ring, addr & 0xfffffffc);
 	amdgpu_ring_write(ring, upper_32_bits(addr) & 0xffffffff);
 	amdgpu_ring_write(ring, seq); /* reference */
-	amdgpu_ring_write(ring, 0xfffffff); /* mask */
+	amdgpu_ring_write(ring, 0xffffffff); /* mask */
 	amdgpu_ring_write(ring, (0xfff << 16) | 4); /* retry count, poll interval */
 }
 
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -856,7 +856,7 @@ static void sdma_v2_4_ring_emit_pipeline
 	amdgpu_ring_write(ring, addr & 0xfffffffc);
 	amdgpu_ring_write(ring, upper_32_bits(addr) & 0xffffffff);
 	amdgpu_ring_write(ring, seq); /* reference */
-	amdgpu_ring_write(ring, 0xfffffff); /* mask */
+	amdgpu_ring_write(ring, 0xffffffff); /* mask */
 	amdgpu_ring_write(ring, SDMA_PKT_POLL_REGMEM_DW5_RETRY_COUNT(0xfff) |
 			  SDMA_PKT_POLL_REGMEM_DW5_INTERVAL(4)); /* retry count, poll interval */
 }
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1099,7 +1099,7 @@ static void sdma_v3_0_ring_emit_pipeline
 	amdgpu_ring_write(ring, addr & 0xfffffffc);
 	amdgpu_ring_write(ring, upper_32_bits(addr) & 0xffffffff);
 	amdgpu_ring_write(ring, seq); /* reference */
-	amdgpu_ring_write(ring, 0xfffffff); /* mask */
+	amdgpu_ring_write(ring, 0xffffffff); /* mask */
 	amdgpu_ring_write(ring, SDMA_PKT_POLL_REGMEM_DW5_RETRY_COUNT(0xfff) |
 			  SDMA_PKT_POLL_REGMEM_DW5_INTERVAL(4)); /* retry count, poll interval */
 }
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1136,7 +1136,7 @@ static void sdma_v4_0_ring_emit_pipeline
 	amdgpu_ring_write(ring, addr & 0xfffffffc);
 	amdgpu_ring_write(ring, upper_32_bits(addr) & 0xffffffff);
 	amdgpu_ring_write(ring, seq); /* reference */
-	amdgpu_ring_write(ring, 0xfffffff); /* mask */
+	amdgpu_ring_write(ring, 0xffffffff); /* mask */
 	amdgpu_ring_write(ring, SDMA_PKT_POLL_REGMEM_DW5_RETRY_COUNT(0xfff) |
 			  SDMA_PKT_POLL_REGMEM_DW5_INTERVAL(4)); /* retry count, poll interval */
 }
