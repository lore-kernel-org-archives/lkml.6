Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoKO0ILiwV1UsP6afHCHmVk+V5N8Ab8YLcv1GubdFnr01nq4P5z1bkFp52NYBLhpvJDylu0
ARC-Seal: i=1; a=rsa-sha256; t=1525116529; cv=none;
        d=google.com; s=arc-20160816;
        b=MYDiDaG9guSnMi8xWqnwE41D2jF2EU1uHm1HrmbF2+QvNpc4Y49Heh7W42XYAbkUPD
         dYKUrFekll9KVUg6DnLQcrewQ7LwkcaN2GT2RdLxffdjoxrnj/n5CCvHFrxpMghPHzEZ
         ET+9nW5ntvHT3/mAObsGA1XhT7kULzlwzSwa52SGNb4arPIRAOieUKp6HVzwMcbCYcQb
         BTWsqJiosUG7Q1vO9ifNz4pkoilwlrceih2bC4PRSqtd9NyCj6gvnzzXfU//2bmgrSh1
         3rKPSFhfVIF1deoTeqxtPBjQwkAU2Z8KzJoaXNXAzcUmsxzwOBTnpAE8METZtTjVguBr
         Z6gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=cTAHoUTmr4iv7gN9nnNrIvsFLP9oLVk7pHP2RPFIMBc=;
        b=qjpSihS6TMfYonwbVHpx2fXHhbkJfJgaR5F7rEj7Wx+RH7qaW1qAoR1Do6cyCSVmc0
         l23r6a9DiuPa9WQwkbd4FrMZbfHHmcyOOYD/W5D4VeWS0KG8KIOZoODTbVYtRO+wvHVR
         ktzkW4GrHfF50XtVFfvo5++IGynqO50eHoYnFv13P0l4tH3cvGuO7FolbkjF7RIbkqSS
         qb+XLibUYHiu9mOKo8eATCxxdwwIPO6KOSPZ5Aq/NxIWxOJeLL7i/iiizo80zl2fDdNL
         NUqy3SLgHUnjQMqAndYxfB5PvV3GKN7VuZiuqOQS/WpNAmn1sMm23Xyxz3Be5/jREYr4
         7VNw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B924E22DCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.16 099/113] drm/amdgpu: set COMPUTE_PGM_RSRC1 for SGPR/VGPR clearing shaders
Date: Mon, 30 Apr 2018 12:25:10 -0700
Message-Id: <20180430184019.401072969@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200516863841946?=
X-GMAIL-MSGID: =?utf-8?q?1599200589729909744?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1459,10 +1459,11 @@ static const u32 sgpr_init_compute_shade
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
@@ -1479,10 +1480,11 @@ static const u32 vgpr_init_regs[] =
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
@@ -1503,6 +1505,7 @@ static const u32 sgpr2_init_regs[] =
 	mmCOMPUTE_NUM_THREAD_X, 256*5,
 	mmCOMPUTE_NUM_THREAD_Y, 1,
 	mmCOMPUTE_NUM_THREAD_Z, 1,
+	mmCOMPUTE_PGM_RSRC1, 0x240, /* SGPRS=9 (80 GPRS) */
 	mmCOMPUTE_PGM_RSRC2, 20,
 	mmCOMPUTE_USER_DATA_0, 0xedcedc00,
 	mmCOMPUTE_USER_DATA_1, 0xedcedc01,
