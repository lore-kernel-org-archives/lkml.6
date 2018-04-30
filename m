Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpcXPDa+39tCAiB94VbxKRtvw7yFr6hoHvKNPYxvj/O/hOia8IHsaJXynzZOcdgiLK8N4FH
ARC-Seal: i=1; a=rsa-sha256; t=1525116404; cv=none;
        d=google.com; s=arc-20160816;
        b=wqXzhSgJQ/j+WaNa3GllEH/hDqvQYcFBjAudpbdO7bPbmoELTOr7e5bQYXoc3ndd7v
         WBG8JI66XOeNTxYFoLLPzdu71sC2lJxQYhIZTRCOJPnrXyj8SGboNPjsidmA8/wttAIe
         GkobfQQfrUbMjI6MadWS5+iS0sTylPsYN3hBI8GQdDU/WCmYEPMHZh1q0k/TZkKnBKzF
         +Q7YrzehfuAU299CMfLDLz7zxk65ePWO9Y8wc/9tGelQsnXSYDfumnj3dXag77+8bn0l
         07RaLIhSw7quwRh8vxlgr4vAxnNL8GoBSNsLOZqI8wxXmm3f8/05O3ebhRnXi7fmDqS8
         FdIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=5qZEyJNnpBu5fqsEJUBJc20yp/LodcsN0Op2qdEA0rQ=;
        b=nvJl6t+VuEMXrSbINKRtoq00SIli+YlixV8ZuIkpuTBLckZY8hHJKb8kKT8WxlLiL2
         pJde+35bEOJdGI1+lo7dYpfv1FWls7HkLj1MEVJ83+DSYnUfgRVeOVwTQQAQ35fp8Ag7
         HIrxmSB4ILF0NZUP9A15Q+h61Oj6k1Ku4HiXhJtJrLTUIFIXMZLgiKvtl4koguQ19xyi
         mlI/IqwTdfqmbdtmRtSSPQ1n3W8ERif1dKOcPZ049x6Q6+m/E0/Vehc6JrXmqkuu3DGH
         uATCbHVIEwTg65jGFQsTK6BVdYl/VXuBPQnAfbC2dmPxpo5x5wh9BDIRhF/Rn+28MGGc
         Mo+g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EFBC22E01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.9 55/61] drm/amdgpu: set COMPUTE_PGM_RSRC1 for SGPR/VGPR clearing shaders
Date: Mon, 30 Apr 2018 12:24:58 -0700
Message-Id: <20180430183955.969482304@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200516863841946?=
X-GMAIL-MSGID: =?utf-8?q?1599200459058027657?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolai Hähnle <nicolai.haehnle@amd.com>

commit 75569c182e4f65cd8826a5853dc9cbca703cbd0e upstream.

Otherwise, the SQ may skip some of the register writes, or shader waves may
be allocated where we don't expect them, so that as a result we don't actually
reset all of the register SRAMs. This can lead to spurious ECC errors later on
if a shader uses an uninitialized register.

Signed-off-by: Nicolai Hähnle <nicolai.haehnle@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1484,10 +1484,11 @@ static const u32 sgpr_init_compute_shade
 static const u32 vgpr_init_regs[] =
 {
 	mmCOMPUTE_STATIC_THREAD_MGMT_SE0, 0xffffffff,
-	mmCOMPUTE_RESOURCE_LIMITS, 0,
+	mmCOMPUTE_RESOURCE_LIMITS, 0x1000000, /* CU_GROUP_COUNT=1 */
 	mmCOMPUTE_NUM_THREAD_X, 256*4,
 	mmCOMPUTE_NUM_THREAD_Y, 1,
 	mmCOMPUTE_NUM_THREAD_Z, 1,
+	mmCOMPUTE_PGM_RSRC1, 0x100004f, /* VGPRS=15 (64 logical VGPRs), SGPRS=1 (16 SGPRs), BULKY=1 */
 	mmCOMPUTE_PGM_RSRC2, 20,
 	mmCOMPUTE_USER_DATA_0, 0xedcedc00,
 	mmCOMPUTE_USER_DATA_1, 0xedcedc01,
@@ -1504,10 +1505,11 @@ static const u32 vgpr_init_regs[] =
 static const u32 sgpr1_init_regs[] =
 {
 	mmCOMPUTE_STATIC_THREAD_MGMT_SE0, 0x0f,
-	mmCOMPUTE_RESOURCE_LIMITS, 0x1000000,
+	mmCOMPUTE_RESOURCE_LIMITS, 0x1000000, /* CU_GROUP_COUNT=1 */
 	mmCOMPUTE_NUM_THREAD_X, 256*5,
 	mmCOMPUTE_NUM_THREAD_Y, 1,
 	mmCOMPUTE_NUM_THREAD_Z, 1,
+	mmCOMPUTE_PGM_RSRC1, 0x240, /* SGPRS=9 (80 GPRS) */
 	mmCOMPUTE_PGM_RSRC2, 20,
 	mmCOMPUTE_USER_DATA_0, 0xedcedc00,
 	mmCOMPUTE_USER_DATA_1, 0xedcedc01,
@@ -1528,6 +1530,7 @@ static const u32 sgpr2_init_regs[] =
 	mmCOMPUTE_NUM_THREAD_X, 256*5,
 	mmCOMPUTE_NUM_THREAD_Y, 1,
 	mmCOMPUTE_NUM_THREAD_Z, 1,
+	mmCOMPUTE_PGM_RSRC1, 0x240, /* SGPRS=9 (80 GPRS) */
 	mmCOMPUTE_PGM_RSRC2, 20,
 	mmCOMPUTE_USER_DATA_0, 0xedcedc00,
 	mmCOMPUTE_USER_DATA_1, 0xedcedc01,
