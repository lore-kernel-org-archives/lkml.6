Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt4POry6YlFmwncC1WQiB7JqMkiG6BNTcIUPackSzO9hwipWBBXAVhErNJfw+guhopkzygI
ARC-Seal: i=1; a=rsa-sha256; t=1519676920; cv=none;
        d=google.com; s=arc-20160816;
        b=tRwydRONrkIGGQAZB6x3G2TwWcmcPjlttS2R5SLq4p5l2yYBtxpqKwW1IQ4Q/i4zrF
         TGATMxwB0HcNEpZpmOLg0LUBWjtOhn5+Uvoj/xapEUQKCoqvBp9hbLrawiYEytnaECGH
         rUyx2yZ9O6c8aeHWW1ZgnrXq0zLcpjsJqfZqOAkojJKQd1Ct7ddllz7ho2UVATCDMu1y
         CEK5L36osPvpSdQap+yLeYWzmmrA3WhMG2EAiVUN7S3M8bg1WNbR+JVUoln5XkLmyxji
         2qE1N8zLhs4p2B7X91Nj0oIY6849VKwNHcdZFTiIHVvxP5L/9l1dIN/Y9QBLMEyn8EFG
         P4iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kjosdx1DeCAwLNMYYj1fiLYsvTt2nm1DTkeDuwl4Xas=;
        b=x3AT6PgPk8mEYISAqhvKGhrneq+2uelVh1RxNrALesUlrhcLDG5zypAXXF9fVg75eF
         OvTn2SMOS9IvZ/S2t5M5t6+QF23wydgOP5vJ3CrATk8NqT5sSW8cDfZObgf58sqd27ln
         BXkEYjo4IyHszpZCm9blkOO0pd8csT/08K4cJCyfVQMZ/Cg07mgpLf3R6kM2PoZttL7H
         A8YVKaAKXvFcSQuuPAZFRHIKi7SuPMvLO/KH5mU26OisGDAMnug7elW5sfGqq2EvnfC/
         BMVgsOe7cLcuAdFemPbFpHJ6FCz84OWSw/2fPT8VxFjaF5Jc+hpBcBIyh7SOkuKX7xUu
         JgCQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.15 57/64] drm/amdgpu: fix VA hole handling on Vega10 v3
Date: Mon, 26 Feb 2018 21:22:34 +0100
Message-Id: <20180226202155.872987785@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496746045842058?=
X-GMAIL-MSGID: =?utf-8?q?1593496746045842058?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian König <christian.koenig@amd.com>

commit bb7939b2030ab55acd203c86160c37db22f5796a upstream.

Similar to the CPU address space the VA on Vega10 has a hole in it.

v2: use dev_dbg instead of dev_err
v3: add some more comments to explain how the hw works

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
CC: stable@vger.kernel.org
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  |   10 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c |   11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |    4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |   13 +++++++++++++
 4 files changed, 32 insertions(+), 6 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -865,8 +865,8 @@ static int amdgpu_cs_ib_vm_chunk(struct
 			struct amdgpu_bo_va_mapping *m;
 			struct amdgpu_bo *aobj = NULL;
 			struct amdgpu_cs_chunk *chunk;
+			uint64_t offset, va_start;
 			struct amdgpu_ib *ib;
-			uint64_t offset;
 			uint8_t *kptr;
 
 			chunk = &p->chunks[i];
@@ -876,14 +876,14 @@ static int amdgpu_cs_ib_vm_chunk(struct
 			if (chunk->chunk_id != AMDGPU_CHUNK_ID_IB)
 				continue;
 
-			r = amdgpu_cs_find_mapping(p, chunk_ib->va_start,
-						   &aobj, &m);
+			va_start = chunk_ib->va_start & AMDGPU_VA_HOLE_MASK;
+			r = amdgpu_cs_find_mapping(p, va_start, &aobj, &m);
 			if (r) {
 				DRM_ERROR("IB va_start is invalid\n");
 				return r;
 			}
 
-			if ((chunk_ib->va_start + chunk_ib->ib_bytes) >
+			if ((va_start + chunk_ib->ib_bytes) >
 			    (m->last + 1) * AMDGPU_GPU_PAGE_SIZE) {
 				DRM_ERROR("IB va_start+ib_bytes is invalid\n");
 				return -EINVAL;
@@ -896,7 +896,7 @@ static int amdgpu_cs_ib_vm_chunk(struct
 			}
 
 			offset = m->start * AMDGPU_GPU_PAGE_SIZE;
-			kptr += chunk_ib->va_start - offset;
+			kptr += va_start - offset;
 
 			memcpy(ib->ptr, kptr, chunk_ib->ib_bytes);
 			amdgpu_bo_kunmap(aobj);
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -563,6 +563,17 @@ int amdgpu_gem_va_ioctl(struct drm_devic
 		return -EINVAL;
 	}
 
+	if (args->va_address >= AMDGPU_VA_HOLE_START &&
+	    args->va_address < AMDGPU_VA_HOLE_END) {
+		dev_dbg(&dev->pdev->dev,
+			"va_address 0x%LX is in VA hole 0x%LX-0x%LX\n",
+			args->va_address, AMDGPU_VA_HOLE_START,
+			AMDGPU_VA_HOLE_END);
+		return -EINVAL;
+	}
+
+	args->va_address &= AMDGPU_VA_HOLE_MASK;
+
 	if ((args->flags & ~valid_flags) && (args->flags & ~prt_flags)) {
 		dev_err(&dev->pdev->dev, "invalid flags combination 0x%08X\n",
 			args->flags);
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -586,7 +586,9 @@ static int amdgpu_info_ioctl(struct drm_
 		if (amdgpu_sriov_vf(adev))
 			dev_info.ids_flags |= AMDGPU_IDS_FLAGS_PREEMPTION;
 		dev_info.virtual_address_offset = AMDGPU_VA_RESERVED_SIZE;
-		dev_info.virtual_address_max = (uint64_t)adev->vm_manager.max_pfn * AMDGPU_GPU_PAGE_SIZE;
+		dev_info.virtual_address_max =
+			min(adev->vm_manager.max_pfn * AMDGPU_GPU_PAGE_SIZE,
+			    AMDGPU_VA_HOLE_START);
 		dev_info.virtual_address_alignment = max((int)PAGE_SIZE, AMDGPU_GPU_PAGE_SIZE);
 		dev_info.pte_fragment_size = (1 << adev->vm_manager.fragment_size) * AMDGPU_GPU_PAGE_SIZE;
 		dev_info.gart_page_size = AMDGPU_GPU_PAGE_SIZE;
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -96,6 +96,19 @@ struct amdgpu_bo_list_entry;
 /* hardcode that limit for now */
 #define AMDGPU_VA_RESERVED_SIZE			(8ULL << 20)
 
+/* VA hole for 48bit addresses on Vega10 */
+#define AMDGPU_VA_HOLE_START			0x0000800000000000ULL
+#define AMDGPU_VA_HOLE_END			0xffff800000000000ULL
+
+/*
+ * Hardware is programmed as if the hole doesn't exists with start and end
+ * address values.
+ *
+ * This mask is used to remove the upper 16bits of the VA and so come up with
+ * the linear addr value.
+ */
+#define AMDGPU_VA_HOLE_MASK			0x0000ffffffffffffULL
+
 /* max vmids dedicated for process */
 #define AMDGPU_VM_MAX_RESERVED_VMID	1
 
