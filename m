Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225fKmNU//icPx1HBpdgL5TFCd9oc179IHe+qaaKCVArVe6oEft18QDY9iejgzuA8i5XFXyc
ARC-Seal: i=1; a=rsa-sha256; t=1517590934; cv=none;
        d=google.com; s=arc-20160816;
        b=aWfcxJ6firVZRQQ9tSp5RkiTsR2pkJ1ikwUsiXcxxIoP7PSJPWaXnKfkaWkIs6P4aN
         96D1VHDlUuBLWBtDpIu3vJPBRucAgIV9FTwGDiV8OVeodFGAYfEKjno/IKd6ZUE2hHOv
         Ts+EfqJwUc675J10pmStN+/K0Sr7E9RRBEx6MIiWtjFoBgyFgGBcZUKQUASuFvFH6CHQ
         6nyCaLGDFJH4C5uPM0cISR/+XPqaLyNu1QVUOFHd/zMKoL6AeEUQTwm/7fak2rlBfsOn
         +fqMZK/pI3ihr/+azbrKur2xaw7LEeWIhKelgpOtVG6URfM6O9c0P7fXl2k7OZFqTqaK
         Qu+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AaeysHwaSA0Z/sJYV+PNxuLPKfP7BXE8NpQE17StgT8=;
        b=HSQKDX5fZonExkTDBRHI58UGGFA3+cNMe7sJJHJGTsFEsRIYr4ID1LZzBu0prExaY4
         S7MmyeBIDWHQ27E/gaIusOv4dXNFiUU6IuqKW+CwpsjDO0XHAAHyb5kE9w443c/KvqsN
         c+f2YUBBuyBHdS4lhRgDHCZthrhIXoSJO7oz9jZISiVJJFbz2JX3xJ1dMNRYpw/yFVTk
         u776PAHh06lotAq28HW3aa5VAcVXihYZvQJSBYoXzj8kwVQZcYEdmZeAowxtq7jtb+CD
         6Q0fpVkBuE+OCDg+iEanbm9COaHq6irGq7sg9Y5StjPOHoz6iklhT+FjvgxAbOsbPK5g
         QIPQ==
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
Subject: [PATCH 4.4 30/67] drm/amdgpu: Fix SDMA load/unload sequence on HWS disabled mode
Date: Fri,  2 Feb 2018 17:57:59 +0100
Message-Id: <20180202140818.934236769@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309431766878115?=
X-GMAIL-MSGID: =?utf-8?q?1591309431766878115?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
 
@@ -492,9 +513,9 @@ static int kgd_hqd_sdma_destroy(struct k
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
