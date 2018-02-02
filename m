Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226RQuq3bapnC8Ia3z+RP7aE6y3FLEP7b8607krBXgnQJ711802lqz5N69VxgffohtHiDLS8
ARC-Seal: i=1; a=rsa-sha256; t=1517591032; cv=none;
        d=google.com; s=arc-20160816;
        b=f00lTWnVFhGbGo5tI64/1YwuJKaB9bihVNvdJHMyNK3JHouOca0vx+vuznIz38VsCP
         AOZpDR3NjrodflakaHilUpHEXvdbCZp/fx+CWuUBiZ+gVELaZ3IF9hdp9wXMkUvrNXXF
         dIgELZ5HNiIw5NsKGdMe41DyU4QCsow+yoFuGD1bbwtZah3FIK9jI51p95VI1wZNhSrG
         DHg/TResIlQ3Ua51TRKPZC/DWDTyGt6fXZAWrr+hFcmpoKd5GSCQiKBzPlf5snEFjs3p
         1AQCWpnsogXViETHXUmZR+5AAIuGWuAH3JZEpx+CpZOZWNZCEcINwh28gmnGJ7DJ/WCU
         M1MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=slBHFEub50hE4gbfahRGu6V7dVJFmUhGJbGXP+E6pwQ=;
        b=LramotoMVfTyA3dHNC8jpSJGNNW4a29m7BQ+hCf6LFLLel6Nwex+xTsar+0cNgaJzS
         qJbFLzi+/e+4dGgmaLXpP/S+zAuT7p/TmppSUbaAdSnI4r94qgIoDhKHtRDhSd6CaKPg
         9eq7eb2WtzjvuRQDuPoP58nxx78pOr8Wd8GN0dWzrLPVW7GwU/kLdxjIOG54eNi1xe6i
         HY0fB4TpxabuqJIK1V/5q/hhQPGlka4F6rNAYlRc5B4IV60jDaBMXB2ca6aOUMvPX3kO
         Xl4wP6AsSCAiq9+CpfjF/mxBLERP2ov5haDmnx8UEzsqw8JhSmCOLqpS9o58R+EXcDP+
         +aAg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	shaoyun liu <shaoyun.liu@amd.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Oded Gabbay <oded.gabbay@gmail.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 29/86] drm/amdgpu: Fix SDMA load/unload sequence on HWS disabled mode
Date: Fri,  2 Feb 2018 17:57:49 +0100
Message-Id: <20180202140825.301671017@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309431766878115?=
X-GMAIL-MSGID: =?utf-8?q?1591309535021267430?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Kuehling <Felix.Kuehling@amd.com>


[ Upstream commit cf21654b40968609779751b34e7923180968fe5b ]

Fix the SDMA load and unload sequence as suggested by HW document.

Signed-off-by: shaoyun liu <shaoyun.liu@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Acked-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c |   47 +++++++++++++++-------
 1 file changed, 34 insertions(+), 13 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
@@ -367,29 +367,50 @@ static int kgd_hqd_sdma_load(struct kgd_
 {
 	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct cik_sdma_rlc_registers *m;
+	unsigned long end_jiffies;
 	uint32_t sdma_base_addr;
+	uint32_t data;
 
 	m = get_sdma_mqd(mqd);
 	sdma_base_addr = get_sdma_base_addr(m);
 
-	WREG32(sdma_base_addr + mmSDMA0_RLC0_VIRTUAL_ADDR,
-			m->sdma_rlc_virtual_addr);
+	WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL,
+		m->sdma_rlc_rb_cntl & (~SDMA0_RLC0_RB_CNTL__RB_ENABLE_MASK));
 
-	WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_BASE,
-			m->sdma_rlc_rb_base);
+	end_jiffies = msecs_to_jiffies(2000) + jiffies;
+	while (true) {
+		data = RREG32(sdma_base_addr + mmSDMA0_RLC0_CONTEXT_STATUS);
+		if (data & SDMA0_RLC0_CONTEXT_STATUS__IDLE_MASK)
+			break;
+		if (time_after(jiffies, end_jiffies))
+			return -ETIME;
+		usleep_range(500, 1000);
+	}
+	if (m->sdma_engine_id) {
+		data = RREG32(mmSDMA1_GFX_CONTEXT_CNTL);
+		data = REG_SET_FIELD(data, SDMA1_GFX_CONTEXT_CNTL,
+				RESUME_CTX, 0);
+		WREG32(mmSDMA1_GFX_CONTEXT_CNTL, data);
+	} else {
+		data = RREG32(mmSDMA0_GFX_CONTEXT_CNTL);
+		data = REG_SET_FIELD(data, SDMA0_GFX_CONTEXT_CNTL,
+				RESUME_CTX, 0);
+		WREG32(mmSDMA0_GFX_CONTEXT_CNTL, data);
+	}
 
+	WREG32(sdma_base_addr + mmSDMA0_RLC0_DOORBELL,
+				m->sdma_rlc_doorbell);
+	WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_RPTR, 0);
+	WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_WPTR, 0);
+	WREG32(sdma_base_addr + mmSDMA0_RLC0_VIRTUAL_ADDR,
+				m->sdma_rlc_virtual_addr);
+	WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_BASE, m->sdma_rlc_rb_base);
 	WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_BASE_HI,
 			m->sdma_rlc_rb_base_hi);
-
 	WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_RPTR_ADDR_LO,
 			m->sdma_rlc_rb_rptr_addr_lo);
-
 	WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_RPTR_ADDR_HI,
 			m->sdma_rlc_rb_rptr_addr_hi);
-
-	WREG32(sdma_base_addr + mmSDMA0_RLC0_DOORBELL,
-			m->sdma_rlc_doorbell);
-
 	WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL,
 			m->sdma_rlc_rb_cntl);
 
@@ -493,9 +514,9 @@ static int kgd_hqd_sdma_destroy(struct k
 	}
 
 	WREG32(sdma_base_addr + mmSDMA0_RLC0_DOORBELL, 0);
-	WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_RPTR, 0);
-	WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_WPTR, 0);
-	WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_BASE, 0);
+	WREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL,
+		RREG32(sdma_base_addr + mmSDMA0_RLC0_RB_CNTL) |
+		SDMA0_RLC0_RB_CNTL__RB_ENABLE_MASK);
 
 	return 0;
 }
