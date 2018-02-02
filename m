Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225g0F0afWbXsKjsCOc2kGvV+Ypl8UiFyn5/Ra3A74GPHdbOeDcNIuNZ0gCpxTpFB/mAHTUX
ARC-Seal: i=1; a=rsa-sha256; t=1517591392; cv=none;
        d=google.com; s=arc-20160816;
        b=vRvHBDt4TLF2r2PIOZrxVbWyzL/3PYk0Vil90GvhnQRi+PHZDc3WoUmHqChpRym7a4
         A5aJTt5xJuAIhLw+6ZA2w2j+7hqCI5Fmlx3H4oOC2Arr4urZ9xTL7oMCCVGcZHLsEmxO
         UOP0O6cLAJPb03/l7qTTWGLj39UKQaWI/8EnxKRHKMmnWLRcR13eR04yi8szMKQLeKTa
         Ng2Hmp5v/EtGvl9u12lHVQ0uMRKiHTdLGv9eOOTIB/GnpcWezJu8Ww8sLy7obtDK+s8e
         QS1qmQOyOnf/kzteK7C4AFRFqSKB2uhwYLmM4IL9fOsBYivq1/RA5g1MmzdWLP8yhcvb
         QpZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zD9Z2Tg6Aj9bRAehCXhKOZN+pbIQR1owPWgDow2xeis=;
        b=h9bXvCvw1vjPsqVMm9nfCNPjIqjlGJ6PJJPxmb1mracwKmW0NUkMluJ6jl82SZ1DLn
         A9JGiy0aM0ihay9oYB1LiPJtj2H0icb8IYELY9G8ajSNOMhaGH1WcodzU8zXFToWbx9R
         zjf4lBTTM3zCvrwWQJJEI5TBNO0hnrWaMGgLsmfA0iOus087wdiZ5lctjcdvHKFDiSNt
         JhacYIhZ5lVYqUXCpyTRxVZ7BVghufm71iOITJ8CWg1m+tMq9aDBKdE8Q1DTkgELc27R
         q2wDt99eQsFOOU8EhrY7Bji8qwfyzBV57Y88kqr9CCRtjM9/ib6LBT+rhH5HQPGD1WFF
         UEJA==
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
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 062/156] drm/amdgpu: Fix SDMA load/unload sequence on HWS disabled mode
Date: Fri,  2 Feb 2018 17:57:23 +0100
Message-Id: <20180202140843.100000679@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309431766878115?=
X-GMAIL-MSGID: =?utf-8?q?1591309911813134142?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Kuehling <Felix.Kuehling@amd.com>


[ Upstream commit cf21654b40968609779751b34e7923180968fe5b ]

Fix the SDMA load and unload sequence as suggested by HW document.

Signed-off-by: shaoyun liu <shaoyun.liu@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Acked-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c |   47 +++++++++++++++-------
 1 file changed, 34 insertions(+), 13 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
@@ -369,29 +369,50 @@ static int kgd_hqd_sdma_load(struct kgd_
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
 
@@ -564,9 +585,9 @@ static int kgd_hqd_sdma_destroy(struct k
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
