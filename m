Return-Path: <andresx7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523979204; cv=none;
        d=google.com; s=arc-20160816;
        b=wDqgHWwKzcRpE/dyIDVLIpmG6t9A3kVnxUsynEVVTpoiSC2LdDlALIZCrYWmekzSBj
         lJs6ZhlQMPN7g/s66YHJ3Ri+yeIS1msFgjt28GS+r6zBd7LQGV9NP103ECjzX6Hly05O
         5rNbQVgtdT2xLrf/JlJkoMwrTqvdmr4cwRv+4g++717r+DjWB5bXBdfYd/Jk5sHkYLen
         ImRkO6g8v4fjo7k2E4ZdO/EGNoWy6cpLtLVK1rtMOyCwTVBruEH/KLQNz0EbYIq8XfaS
         zbkjmLBqacQKbANA/tJrJFANr1gF5wfs9sEv9h1V1fnrfeDCN5WI+m379XwvtDxWqTho
         2t7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=qM+Sdo7TVyEMr37E5H0oqybLBlV0bcVCTP3uyJ8QuS8=;
        b=ItGQUiJKtNnMuE5GLyC+n4ySb6NSYZiW5EfXaSXWu+Ehc8BTlOYTXyX8VPzxCUGZPR
         xDiQz9vlIw3HJrghtrKv9iYfyWQOz1JmHAIzZ7SH0EOXm4ez7HVQPX/tsM+q4yL5Osh0
         nu8vdcqYFXRq7z8B+De2UFOoGcE3ANKbOdN6PMb4ilY/tMxWiJ4WR9XBm3W4dchD9f9n
         7dZFb8N1tGfnXv+QC49/UsBhZftAqkY8UlcIGUvl3vx2pe5fHAdDFfenk3DIPAkseRo+
         ywiCrPEiNDR8DqoNaEku+PPhvaow2M/JTqB2wC1X+D4zF3cKPUI0sKajbyBq4sWeJbg4
         cF0A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=LPPdoaw3;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=LPPdoaw3;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+0adpm+0eMfzpv4UCjzIgpLh4DcuVcKo+9wDMNL6fkovO+c4uhi+11scIYi25h+3uvy/GtrA==
From: Andres Rodriguez <andresx7@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: andresx7@gmail.com,
	gregkh@linuxfoundation.org,
	mcgrof@kernel.org,
	alexdeucher@gmail.com,
	ckoenig.leichtzumerken@gmail.com,
	kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com
Subject: [PATCH 7/9] drm/amdgpu: use firmware_request_nowarn to load firmware
Date: Tue, 17 Apr 2018 11:33:05 -0400
Message-Id: <20180417153307.3693-8-andresx7@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180417153307.3693-1-andresx7@gmail.com>
References: <20180417153307.3693-1-andresx7@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597943307609478014?=
X-GMAIL-MSGID: =?utf-8?q?1598008018937939661?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently, during the normal boot process the amdgpu driver will produce
spew like the following in dmesg:
Direct firmware load for amdgpu/polaris10_mec_2.bin failed with error -2

This happens when amdgpu tries to load optional firmware files. So the
error does not affect the startup sequence.

This patch switches the amdgpu to use firmware_request_nowarn(), which
will not produce the warnings mentioned above. Hopefully resulting in a
cleaner bootup log.

Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/ci_dpm.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c      |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c      | 12 +++++------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      | 32 +++++++++++++++---------------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 12 +++++------
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c      |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/si_dpm.c        |  2 +-
 21 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
index 4466f3535e2d..6c950811c0a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
@@ -811,7 +811,7 @@ static int amdgpu_cgs_get_firmware_info(struct cgs_device *cgs_device,
 				return -EINVAL;
 			}
 
-			err = request_firmware(&adev->pm.fw, fw_name, adev->dev);
+			err = firmware_request_nowarn(&adev->pm.fw, fw_name, adev->dev);
 			if (err) {
 				DRM_ERROR("Failed to request firmware\n");
 				return err;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index af1b879a9ee9..d6225619e69f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -696,7 +696,7 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 		if (adev->asic_type == CHIP_FIJI) {
 			int err;
 			uint32_t fw_ver;
-			err = request_firmware(&adev->pm.fw, "amdgpu/fiji_smc.bin", adev->dev);
+			err = firmware_request_nowarn(&adev->pm.fw, "amdgpu/fiji_smc.bin", adev->dev);
 			/* force vPost if error occured */
 			if (err)
 				return true;
@@ -1133,7 +1133,7 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 	}
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_gpu_info.bin", chip_name);
-	err = request_firmware(&adev->firmware.gpu_info_fw, fw_name, adev->dev);
+	err = firmware_request_nowarn(&adev->firmware.gpu_info_fw, fw_name, adev->dev);
 	if (err) {
 		dev_err(adev->dev,
 			"Failed to load gpu_info firmware \"%s\"\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 30b5500dc152..0acd1f3d14c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -196,7 +196,7 @@ enum AMDGPU_UCODE_STATUS {
 struct amdgpu_firmware_info {
 	/* ucode ID */
 	enum AMDGPU_UCODE_ID ucode_id;
-	/* request_firmware */
+	/* firmware_request */
 	const struct firmware *fw;
 	/* starting mc address */
 	uint64_t mc_addr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index b2eae86bf906..4de018d45081 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -171,7 +171,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
-	r = request_firmware(&adev->uvd.fw, fw_name, adev->dev);
+	r = firmware_request_nowarn(&adev->uvd.fw, fw_name, adev->dev);
 	if (r) {
 		dev_err(adev->dev, "amdgpu_uvd: Can't load firmware \"%s\"\n",
 			fw_name);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index d274ae535530..b6af824a2f44 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -138,7 +138,7 @@ int amdgpu_vce_sw_init(struct amdgpu_device *adev, unsigned long size)
 		return -EINVAL;
 	}
 
-	r = request_firmware(&adev->vce.fw, fw_name, adev->dev);
+	r = firmware_request_nowarn(&adev->vce.fw, fw_name, adev->dev);
 	if (r) {
 		dev_err(adev->dev, "amdgpu_vce: Can't load firmware \"%s\"\n",
 			fw_name);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 837962118dbc..bd650b87e281 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -67,7 +67,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
-	r = request_firmware(&adev->vcn.fw, fw_name, adev->dev);
+	r = firmware_request_nowarn(&adev->vcn.fw, fw_name, adev->dev);
 	if (r) {
 		dev_err(adev->dev, "amdgpu_vcn: Can't load firmware \"%s\"\n",
 			fw_name);
diff --git a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
index a0943aa8d1d3..95e1edc1311d 100644
--- a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
@@ -5849,7 +5849,7 @@ static int ci_dpm_init_microcode(struct amdgpu_device *adev)
 	}
 
 	snprintf(fw_name, sizeof(fw_name), "radeon/%s_smc.bin", chip_name);
-	err = request_firmware(&adev->pm.fw, fw_name, adev->dev);
+	err = firmware_request_nowarn(&adev->pm.fw, fw_name, adev->dev);
 	if (err)
 		goto out;
 	err = amdgpu_ucode_validate(adev->pm.fw);
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 6e8278e689b1..93c8acca0360 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -135,7 +135,7 @@ static int cik_sdma_init_microcode(struct amdgpu_device *adev)
 			snprintf(fw_name, sizeof(fw_name), "radeon/%s_sdma.bin", chip_name);
 		else
 			snprintf(fw_name, sizeof(fw_name), "radeon/%s_sdma1.bin", chip_name);
-		err = request_firmware(&adev->sdma.instance[i].fw, fw_name, adev->dev);
+		err = firmware_request_nowarn(&adev->sdma.instance[i].fw, fw_name, adev->dev);
 		if (err)
 			goto out;
 		err = amdgpu_ucode_validate(adev->sdma.instance[i].fw);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 9870d83b68c1..8aebab5edf15 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -335,7 +335,7 @@ static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
 	}
 
 	snprintf(fw_name, sizeof(fw_name), "radeon/%s_pfp.bin", chip_name);
-	err = request_firmware(&adev->gfx.pfp_fw, fw_name, adev->dev);
+	err = firmware_request_nowarn(&adev->gfx.pfp_fw, fw_name, adev->dev);
 	if (err)
 		goto out;
 	err = amdgpu_ucode_validate(adev->gfx.pfp_fw);
@@ -346,7 +346,7 @@ static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
 	adev->gfx.pfp_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
 
 	snprintf(fw_name, sizeof(fw_name), "radeon/%s_me.bin", chip_name);
-	err = request_firmware(&adev->gfx.me_fw, fw_name, adev->dev);
+	err = firmware_request_nowarn(&adev->gfx.me_fw, fw_name, adev->dev);
 	if (err)
 		goto out;
 	err = amdgpu_ucode_validate(adev->gfx.me_fw);
@@ -357,7 +357,7 @@ static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
 	adev->gfx.me_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
 
 	snprintf(fw_name, sizeof(fw_name), "radeon/%s_ce.bin", chip_name);
-	err = request_firmware(&adev->gfx.ce_fw, fw_name, adev->dev);
+	err = firmware_request_nowarn(&adev->gfx.ce_fw, fw_name, adev->dev);
 	if (err)
 		goto out;
 	err = amdgpu_ucode_validate(adev->gfx.ce_fw);
@@ -368,7 +368,7 @@ static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
 	adev->gfx.ce_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
 
 	snprintf(fw_name, sizeof(fw_name), "radeon/%s_rlc.bin", chip_name);
-	err = request_firmware(&adev->gfx.rlc_fw, fw_name, adev->dev);
+	err = firmware_request_nowarn(&adev->gfx.rlc_fw, fw_name, adev->dev);
 	if (err)
 		goto out;
 	err = amdgpu_ucode_validate(adev->gfx.rlc_fw);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index a066c5eda135..35a0e46464a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -926,7 +926,7 @@ static int gfx_v7_0_init_microcode(struct amdgpu_device *adev)
 	}
 
 	snprintf(fw_name, sizeof(fw_name), "radeon/%s_pfp.bin", chip_name);
-	err = request_firmware(&adev->gfx.pfp_fw, fw_name, adev->dev);
+	err = firmware_request_nowarn(&adev->gfx.pfp_fw, fw_name, adev->dev);
 	if (err)
 		goto out;
 	err = amdgpu_ucode_validate(adev->gfx.pfp_fw);
@@ -934,7 +934,7 @@ static int gfx_v7_0_init_microcode(struct amdgpu_device *adev)
 		goto out;
 
 	snprintf(fw_name, sizeof(fw_name), "radeon/%s_me.bin", chip_name);
-	err = request_firmware(&adev->gfx.me_fw, fw_name, adev->dev);
+	err = firmware_request_nowarn(&adev->gfx.me_fw, fw_name, adev->dev);
 	if (err)
 		goto out;
 	err = amdgpu_ucode_validate(adev->gfx.me_fw);
@@ -942,7 +942,7 @@ static int gfx_v7_0_init_microcode(struct amdgpu_device *adev)
 		goto out;
 
 	snprintf(fw_name, sizeof(fw_name), "radeon/%s_ce.bin", chip_name);
-	err = request_firmware(&adev->gfx.ce_fw, fw_name, adev->dev);
+	err = firmware_request_nowarn(&adev->gfx.ce_fw, fw_name, adev->dev);
 	if (err)
 		goto out;
 	err = amdgpu_ucode_validate(adev->gfx.ce_fw);
@@ -950,7 +950,7 @@ static int gfx_v7_0_init_microcode(struct amdgpu_device *adev)
 		goto out;
 
 	snprintf(fw_name, sizeof(fw_name), "radeon/%s_mec.bin", chip_name);
-	err = request_firmware(&adev->gfx.mec_fw, fw_name, adev->dev);
+	err = firmware_request_nowarn(&adev->gfx.mec_fw, fw_name, adev->dev);
 	if (err)
 		goto out;
 	err = amdgpu_ucode_validate(adev->gfx.mec_fw);
@@ -959,7 +959,7 @@ static int gfx_v7_0_init_microcode(struct amdgpu_device *adev)
 
 	if (adev->asic_type == CHIP_KAVERI) {
 		snprintf(fw_name, sizeof(fw_name), "radeon/%s_mec2.bin", chip_name);
-		err = request_firmware(&adev->gfx.mec2_fw, fw_name, adev->dev);
+		err = firmware_request_nowarn(&adev->gfx.mec2_fw, fw_name, adev->dev);
 		if (err)
 			goto out;
 		err = amdgpu_ucode_validate(adev->gfx.mec2_fw);
@@ -968,7 +968,7 @@ static int gfx_v7_0_init_microcode(struct amdgpu_device *adev)
 	}
 
 	snprintf(fw_name, sizeof(fw_name), "radeon/%s_rlc.bin", chip_name);
-	err = request_firmware(&adev->gfx.rlc_fw, fw_name, adev->dev);
+	err = firmware_request_nowarn(&adev->gfx.rlc_fw, fw_name, adev->dev);
 	if (err)
 		goto out;
 	err = amdgpu_ucode_validate(adev->gfx.rlc_fw);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 4e694ae9f308..c16cd96a1557 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -936,14 +936,14 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 
 	if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
 		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp_2.bin", chip_name);
-		err = request_firmware(&adev->gfx.pfp_fw, fw_name, adev->dev);
+		err = firmware_request_nowarn(&adev->gfx.pfp_fw, fw_name, adev->dev);
 		if (err == -ENOENT) {
 			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", chip_name);
-			err = request_firmware(&adev->gfx.pfp_fw, fw_name, adev->dev);
+			err = firmware_request_nowarn(&adev->gfx.pfp_fw, fw_name, adev->dev);
 		}
 	} else {
 		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", chip_name);
-		err = request_firmware(&adev->gfx.pfp_fw, fw_name, adev->dev);
+		err = firmware_request_nowarn(&adev->gfx.pfp_fw, fw_name, adev->dev);
 	}
 	if (err)
 		goto out;
@@ -956,14 +956,14 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 
 	if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
 		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me_2.bin", chip_name);
-		err = request_firmware(&adev->gfx.me_fw, fw_name, adev->dev);
+		err = firmware_request_nowarn(&adev->gfx.me_fw, fw_name, adev->dev);
 		if (err == -ENOENT) {
 			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", chip_name);
-			err = request_firmware(&adev->gfx.me_fw, fw_name, adev->dev);
+			err = firmware_request_nowarn(&adev->gfx.me_fw, fw_name, adev->dev);
 		}
 	} else {
 		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", chip_name);
-		err = request_firmware(&adev->gfx.me_fw, fw_name, adev->dev);
+		err = firmware_request_nowarn(&adev->gfx.me_fw, fw_name, adev->dev);
 	}
 	if (err)
 		goto out;
@@ -977,14 +977,14 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 
 	if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
 		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce_2.bin", chip_name);
-		err = request_firmware(&adev->gfx.ce_fw, fw_name, adev->dev);
+		err = firmware_request_nowarn(&adev->gfx.ce_fw, fw_name, adev->dev);
 		if (err == -ENOENT) {
 			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce.bin", chip_name);
-			err = request_firmware(&adev->gfx.ce_fw, fw_name, adev->dev);
+			err = firmware_request_nowarn(&adev->gfx.ce_fw, fw_name, adev->dev);
 		}
 	} else {
 		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce.bin", chip_name);
-		err = request_firmware(&adev->gfx.ce_fw, fw_name, adev->dev);
+		err = firmware_request_nowarn(&adev->gfx.ce_fw, fw_name, adev->dev);
 	}
 	if (err)
 		goto out;
@@ -1007,7 +1007,7 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 		adev->virt.chained_ib_support = false;
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", chip_name);
-	err = request_firmware(&adev->gfx.rlc_fw, fw_name, adev->dev);
+	err = firmware_request_nowarn(&adev->gfx.rlc_fw, fw_name, adev->dev);
 	if (err)
 		goto out;
 	err = amdgpu_ucode_validate(adev->gfx.rlc_fw);
@@ -1057,14 +1057,14 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 
 	if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
 		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec_2.bin", chip_name);
-		err = request_firmware(&adev->gfx.mec_fw, fw_name, adev->dev);
+		err = firmware_request_nowarn(&adev->gfx.mec_fw, fw_name, adev->dev);
 		if (err == -ENOENT) {
 			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
-			err = request_firmware(&adev->gfx.mec_fw, fw_name, adev->dev);
+			err = firmware_request_nowarn(&adev->gfx.mec_fw, fw_name, adev->dev);
 		}
 	} else {
 		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
-		err = request_firmware(&adev->gfx.mec_fw, fw_name, adev->dev);
+		err = firmware_request_nowarn(&adev->gfx.mec_fw, fw_name, adev->dev);
 	}
 	if (err)
 		goto out;
@@ -1079,14 +1079,14 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 	    (adev->asic_type != CHIP_TOPAZ)) {
 		if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
 			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2_2.bin", chip_name);
-			err = request_firmware(&adev->gfx.mec2_fw, fw_name, adev->dev);
+			err = firmware_request_nowarn(&adev->gfx.mec2_fw, fw_name, adev->dev);
 			if (err == -ENOENT) {
 				snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2.bin", chip_name);
-				err = request_firmware(&adev->gfx.mec2_fw, fw_name, adev->dev);
+				err = firmware_request_nowarn(&adev->gfx.mec2_fw, fw_name, adev->dev);
 			}
 		} else {
 			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2.bin", chip_name);
-			err = request_firmware(&adev->gfx.mec2_fw, fw_name, adev->dev);
+			err = firmware_request_nowarn(&adev->gfx.mec2_fw, fw_name, adev->dev);
 		}
 		if (!err) {
 			err = amdgpu_ucode_validate(adev->gfx.mec2_fw);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index c06479615e8a..9f70012c81ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -370,7 +370,7 @@ static int gfx_v9_0_init_microcode(struct amdgpu_device *adev)
 	}
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", chip_name);
-	err = request_firmware(&adev->gfx.pfp_fw, fw_name, adev->dev);
+	err = firmware_request_nowarn(&adev->gfx.pfp_fw, fw_name, adev->dev);
 	if (err)
 		goto out;
 	err = amdgpu_ucode_validate(adev->gfx.pfp_fw);
@@ -381,7 +381,7 @@ static int gfx_v9_0_init_microcode(struct amdgpu_device *adev)
 	adev->gfx.pfp_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", chip_name);
-	err = request_firmware(&adev->gfx.me_fw, fw_name, adev->dev);
+	err = firmware_request_nowarn(&adev->gfx.me_fw, fw_name, adev->dev);
 	if (err)
 		goto out;
 	err = amdgpu_ucode_validate(adev->gfx.me_fw);
@@ -392,7 +392,7 @@ static int gfx_v9_0_init_microcode(struct amdgpu_device *adev)
 	adev->gfx.me_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce.bin", chip_name);
-	err = request_firmware(&adev->gfx.ce_fw, fw_name, adev->dev);
+	err = firmware_request_nowarn(&adev->gfx.ce_fw, fw_name, adev->dev);
 	if (err)
 		goto out;
 	err = amdgpu_ucode_validate(adev->gfx.ce_fw);
@@ -403,7 +403,7 @@ static int gfx_v9_0_init_microcode(struct amdgpu_device *adev)
 	adev->gfx.ce_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", chip_name);
-	err = request_firmware(&adev->gfx.rlc_fw, fw_name, adev->dev);
+	err = firmware_request_nowarn(&adev->gfx.rlc_fw, fw_name, adev->dev);
 	if (err)
 		goto out;
 	err = amdgpu_ucode_validate(adev->gfx.rlc_fw);
@@ -449,7 +449,7 @@ static int gfx_v9_0_init_microcode(struct amdgpu_device *adev)
 		adev->gfx.rlc.register_restore[i] = le32_to_cpu(tmp[i]);
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
-	err = request_firmware(&adev->gfx.mec_fw, fw_name, adev->dev);
+	err = firmware_request_nowarn(&adev->gfx.mec_fw, fw_name, adev->dev);
 	if (err)
 		goto out;
 	err = amdgpu_ucode_validate(adev->gfx.mec_fw);
@@ -461,7 +461,7 @@ static int gfx_v9_0_init_microcode(struct amdgpu_device *adev)
 
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2.bin", chip_name);
-	err = request_firmware(&adev->gfx.mec2_fw, fw_name, adev->dev);
+	err = firmware_request_nowarn(&adev->gfx.mec2_fw, fw_name, adev->dev);
 	if (!err) {
 		err = amdgpu_ucode_validate(adev->gfx.mec2_fw);
 		if (err)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 8e28270d1ea9..4192a5a0c444 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -136,7 +136,7 @@ static int gmc_v6_0_init_microcode(struct amdgpu_device *adev)
 		snprintf(fw_name, sizeof(fw_name), "radeon/si58_mc.bin");
 	else
 		snprintf(fw_name, sizeof(fw_name), "radeon/%s_mc.bin", chip_name);
-	err = request_firmware(&adev->mc.fw, fw_name, adev->dev);
+	err = firmware_request_nowarn(&adev->mc.fw, fw_name, adev->dev);
 	if (err)
 		goto out;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 86e9d682c59e..06deba7f707d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -151,7 +151,7 @@ static int gmc_v7_0_init_microcode(struct amdgpu_device *adev)
 	else
 		snprintf(fw_name, sizeof(fw_name), "radeon/%s_mc.bin", chip_name);
 
-	err = request_firmware(&adev->mc.fw, fw_name, adev->dev);
+	err = firmware_request_nowarn(&adev->mc.fw, fw_name, adev->dev);
 	if (err)
 		goto out;
 	err = amdgpu_ucode_validate(adev->mc.fw);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 9a813d834f1a..cbce96198dbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -235,7 +235,7 @@ static int gmc_v8_0_init_microcode(struct amdgpu_device *adev)
 	}
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mc.bin", chip_name);
-	err = request_firmware(&adev->mc.fw, fw_name, adev->dev);
+	err = firmware_request_nowarn(&adev->mc.fw, fw_name, adev->dev);
 	if (err)
 		goto out;
 	err = amdgpu_ucode_validate(adev->mc.fw);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
index 5a9fe24697f9..718722ef1835 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
@@ -105,7 +105,7 @@ int psp_v10_0_init_microcode(struct psp_context *psp)
 	}
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_asd.bin", chip_name);
-	err = request_firmware(&adev->psp.asd_fw, fw_name, adev->dev);
+	err = firmware_request_nowarn(&adev->psp.asd_fw, fw_name, adev->dev);
 	if (err)
 		goto out;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
index 19bd1934e63d..dd5261577d9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
@@ -111,7 +111,7 @@ int psp_v3_1_init_microcode(struct psp_context *psp)
 	}
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sos.bin", chip_name);
-	err = request_firmware(&adev->psp.sos_fw, fw_name, adev->dev);
+	err = firmware_request_nowarn(&adev->psp.sos_fw, fw_name, adev->dev);
 	if (err)
 		goto out;
 
@@ -131,7 +131,7 @@ int psp_v3_1_init_microcode(struct psp_context *psp)
 				le32_to_cpu(hdr->sos_offset_bytes);
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_asd.bin", chip_name);
-	err = request_firmware(&adev->psp.asd_fw, fw_name, adev->dev);
+	err = firmware_request_nowarn(&adev->psp.asd_fw, fw_name, adev->dev);
 	if (err)
 		goto out;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index d4787ad4d346..a2afbaacc7e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -146,7 +146,7 @@ static int sdma_v2_4_init_microcode(struct amdgpu_device *adev)
 			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma.bin", chip_name);
 		else
 			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma1.bin", chip_name);
-		err = request_firmware(&adev->sdma.instance[i].fw, fw_name, adev->dev);
+		err = firmware_request_nowarn(&adev->sdma.instance[i].fw, fw_name, adev->dev);
 		if (err)
 			goto out;
 		err = amdgpu_ucode_validate(adev->sdma.instance[i].fw);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 521978c40537..75d2a9cc9268 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -298,7 +298,7 @@ static int sdma_v3_0_init_microcode(struct amdgpu_device *adev)
 			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma.bin", chip_name);
 		else
 			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma1.bin", chip_name);
-		err = request_firmware(&adev->sdma.instance[i].fw, fw_name, adev->dev);
+		err = firmware_request_nowarn(&adev->sdma.instance[i].fw, fw_name, adev->dev);
 		if (err)
 			goto out;
 		err = amdgpu_ucode_validate(adev->sdma.instance[i].fw);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 91cf95a8c39c..e1ebfb9e2650 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -176,7 +176,7 @@ static int sdma_v4_0_init_microcode(struct amdgpu_device *adev)
 			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma.bin", chip_name);
 		else
 			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma1.bin", chip_name);
-		err = request_firmware(&adev->sdma.instance[i].fw, fw_name, adev->dev);
+		err = firmware_request_nowarn(&adev->sdma.instance[i].fw, fw_name, adev->dev);
 		if (err)
 			goto out;
 		err = amdgpu_ucode_validate(adev->sdma.instance[i].fw);
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
index ce675a7f179a..5538a5269417 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
@@ -7687,7 +7687,7 @@ static int si_dpm_init_microcode(struct amdgpu_device *adev)
 	}
 
 	snprintf(fw_name, sizeof(fw_name), "radeon/%s_smc.bin", chip_name);
-	err = request_firmware(&adev->pm.fw, fw_name, adev->dev);
+	err = firmware_request_nowarn(&adev->pm.fw, fw_name, adev->dev);
 	if (err)
 		goto out;
 	err = amdgpu_ucode_validate(adev->pm.fw);
-- 
2.14.1
