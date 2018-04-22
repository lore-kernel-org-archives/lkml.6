Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/LF/XMbH8Tp7+rd7krTaQ2/psQLD+cYn3yZY4K02U92RNSGM34ywj8Im4YD9kjGhpXJ08d
ARC-Seal: i=1; a=rsa-sha256; t=1524405674; cv=none;
        d=google.com; s=arc-20160816;
        b=qBG4fsyUfuKWKfyM3Vf2KwoRhYIHXeq5wuvo+jqdn2ByfLQcs6tnI4pAJwftXrR9fC
         CtF0JIvAvnKnSrEai8PWyoCIRwea3mCJd9+GyXCtqGm99ekjFKsQL9iYYJ7hlf3IRUYu
         yt1M+Oy3zFvJ3tPQ52pBVG0Lfo6JU7aQSAc2G388oqlStqBEuFwTBjOgaqPxORha1AzV
         iYymfSS7nn42D26Ief5O55UeyfIlO4thtYDSXPXqtNHyVNM+PTCBvEIrbyc84ufwsK6g
         HtWJMnqYAQU9/zofmBs6bx/fkKQdohMLn+uadDbwQkV9KAFqUG7/XU7lTZ2m51zMK4zT
         2YkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ew1cLiHZzQjHAwRmSc8RbNxdEiO0YfIBf8BreQTa32A=;
        b=FM3onEtfo5G0sOCDxLrnsG+enJ3pwpVMOvoIIKaHttVTKaVEuL7t00r/7c1x1LqKnB
         9W3ne3OoZC5PKHh9cGeZ7SU5E3d30x2FEPMrm3CPvo/qhbh0OBblJP3OcnMqzy5SkJl0
         ukRxeP8eu+f+GiIiuN152OEbVs+grVdKmYXLKKH580TJjd7fGE7X/Di4WrKac/lj4ygX
         LmTWXvPtlFKIy7UhfaUjKEvlBFyNVpB15RAF28N0tG3dWMPpZfwvQOvHcVi5PNTjyGrf
         ikNpSS7K50HIbt1Z/OxEKmxbbx2tQo4HRkILxpahTf+WN5gI+MBuvmDcpK3gvR/2ions
         lwxA==
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
Subject: [PATCH 4.16 152/196] drm/amdgpu/sdma: fix mask in emit_pipeline_sync
Date: Sun, 22 Apr 2018 15:52:52 +0200
Message-Id: <20180422135112.090723962@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455204934297225?=
X-GMAIL-MSGID: =?utf-8?q?1598455204934297225?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -844,7 +844,7 @@ static void sdma_v2_4_ring_emit_pipeline
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
@@ -1110,7 +1110,7 @@ static void sdma_v3_0_ring_emit_pipeline
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
@@ -1113,7 +1113,7 @@ static void sdma_v4_0_ring_emit_pipeline
 	amdgpu_ring_write(ring, addr & 0xfffffffc);
 	amdgpu_ring_write(ring, upper_32_bits(addr) & 0xffffffff);
 	amdgpu_ring_write(ring, seq); /* reference */
-	amdgpu_ring_write(ring, 0xfffffff); /* mask */
+	amdgpu_ring_write(ring, 0xffffffff); /* mask */
 	amdgpu_ring_write(ring, SDMA_PKT_POLL_REGMEM_DW5_RETRY_COUNT(0xfff) |
 			  SDMA_PKT_POLL_REGMEM_DW5_INTERVAL(4)); /* retry count, poll interval */
 }
