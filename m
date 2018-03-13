Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuMHWBkYWZwsC+pdPzIS/CO+42CDpdGRfyRXRlP72ZorcUPDuyvrlOadp4ftz1/VDg7kqv6
ARC-Seal: i=1; a=rsa-sha256; t=1520955503; cv=none;
        d=google.com; s=arc-20160816;
        b=riWC6LbMqu4dR69iOroY7f77leRZjofDIWbbs4gak5xMB6ybcnTbktwPUkrQ5aaPfk
         fbhauLrLp6ZQiLNoaI4P4nYUY/IpSTjODWbYPrW2KF/70sPGmh54kTnJKxP0hyhp1o9R
         dEK+vbumMe2fc3vCXhdkPyHAjxyfs4lJ8BqruNOecNhgn+X7LSz81ZNWPt9cDH+zskd1
         C12xraV4x/mGxhFHptQEjubVsuB27IanxhT/ZIw3ETkCDBRlMt1t718JDDy6pdFwKF9X
         uNu3deOZwbHK79MMxYagKSLfGSND9TEJQntgNRK5Lt0gO2qoXMAfBgflqOjRdDIBQWoR
         fYOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oJKQU9+SpGLx7mFyGrY1ROjjeiw+91Ps/OVHhLfKlNg=;
        b=bfvvQFD2/7A/oS8aVslcvuykv8CTZBvvxiOUVz97M12z8XtEpyqdTvFKXSVmQgtgin
         TLfBuzSpHtPyCliYhN71L6aahE/qmXcweO8yiitMQHegMSg3jP1OvTJGAzzi2madGto3
         tYZP7quOg8LbZ0rFUTN0vhDhDfUo+DvNWkphetPT4Xr6tr/mcVsFON32CLwjtyvF5eNc
         S9sfeVFd1AO2PGUqDsUmP2vkd13No93N7igmC47eK3xBUTO/yM1KVH18Ke/h/YV1trD3
         5wsYmQeIt77TuquxKv0D6Z4IxwPO79Ebes0LJrAnnbtg3b6yRHM7aLx6AxNry5GGZ7U+
         b13A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Rex Zhu <rezhu@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.14 072/140] drm/amdgpu: used cached pcie gen info for SI (v2)
Date: Tue, 13 Mar 2018 16:24:35 +0100
Message-Id: <20180313152503.011199984@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836844086230221?=
X-GMAIL-MSGID: =?utf-8?q?1594837438196429199?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit 05656e5e4917a08296300dc0530aed1539202c25 upstream.

Rather than querying it every time we need it.
Also fixes a crash in VM pass through if there is no
root bridge because the cached value fetch already checks
this properly.

v2: fix includes

Fixes: https://bugs.freedesktop.org/show_bug.cgi?id=105244
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Rex Zhu<rezhu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/si.c     |   22 +++++++--------
 drivers/gpu/drm/amd/amdgpu/si_dpm.c |   50 +++++++++---------------------------
 2 files changed, 23 insertions(+), 49 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -31,6 +31,7 @@
 #include "amdgpu_uvd.h"
 #include "amdgpu_vce.h"
 #include "atom.h"
+#include "amd_pcie.h"
 #include "amdgpu_powerplay.h"
 #include "sid.h"
 #include "si_ih.h"
@@ -1461,8 +1462,8 @@ static void si_pcie_gen3_enable(struct a
 {
 	struct pci_dev *root = adev->pdev->bus->self;
 	int bridge_pos, gpu_pos;
-	u32 speed_cntl, mask, current_data_rate;
-	int ret, i;
+	u32 speed_cntl, current_data_rate;
+	int i;
 	u16 tmp16;
 
 	if (pci_is_root_bus(adev->pdev->bus))
@@ -1474,23 +1475,20 @@ static void si_pcie_gen3_enable(struct a
 	if (adev->flags & AMD_IS_APU)
 		return;
 
-	ret = drm_pcie_get_speed_cap_mask(adev->ddev, &mask);
-	if (ret != 0)
-		return;
-
-	if (!(mask & (DRM_PCIE_SPEED_50 | DRM_PCIE_SPEED_80)))
+	if (!(adev->pm.pcie_gen_mask & (CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2 |
+					CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)))
 		return;
 
 	speed_cntl = RREG32_PCIE_PORT(PCIE_LC_SPEED_CNTL);
 	current_data_rate = (speed_cntl & LC_CURRENT_DATA_RATE_MASK) >>
 		LC_CURRENT_DATA_RATE_SHIFT;
-	if (mask & DRM_PCIE_SPEED_80) {
+	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3) {
 		if (current_data_rate == 2) {
 			DRM_INFO("PCIE gen 3 link speeds already enabled\n");
 			return;
 		}
 		DRM_INFO("enabling PCIE gen 3 link speeds, disable with amdgpu.pcie_gen2=0\n");
-	} else if (mask & DRM_PCIE_SPEED_50) {
+	} else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2) {
 		if (current_data_rate == 1) {
 			DRM_INFO("PCIE gen 2 link speeds already enabled\n");
 			return;
@@ -1506,7 +1504,7 @@ static void si_pcie_gen3_enable(struct a
 	if (!gpu_pos)
 		return;
 
-	if (mask & DRM_PCIE_SPEED_80) {
+	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3) {
 		if (current_data_rate != 2) {
 			u16 bridge_cfg, gpu_cfg;
 			u16 bridge_cfg2, gpu_cfg2;
@@ -1589,9 +1587,9 @@ static void si_pcie_gen3_enable(struct a
 
 	pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
 	tmp16 &= ~0xf;
-	if (mask & DRM_PCIE_SPEED_80)
+	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
 		tmp16 |= 3;
-	else if (mask & DRM_PCIE_SPEED_50)
+	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2)
 		tmp16 |= 2;
 	else
 		tmp16 |= 1;
--- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
@@ -26,6 +26,7 @@
 #include "amdgpu_pm.h"
 #include "amdgpu_dpm.h"
 #include "amdgpu_atombios.h"
+#include "amd_pcie.h"
 #include "sid.h"
 #include "r600_dpm.h"
 #include "si_dpm.h"
@@ -3332,29 +3333,6 @@ static void btc_apply_voltage_delta_rule
 	}
 }
 
-static enum amdgpu_pcie_gen r600_get_pcie_gen_support(struct amdgpu_device *adev,
-					       u32 sys_mask,
-					       enum amdgpu_pcie_gen asic_gen,
-					       enum amdgpu_pcie_gen default_gen)
-{
-	switch (asic_gen) {
-	case AMDGPU_PCIE_GEN1:
-		return AMDGPU_PCIE_GEN1;
-	case AMDGPU_PCIE_GEN2:
-		return AMDGPU_PCIE_GEN2;
-	case AMDGPU_PCIE_GEN3:
-		return AMDGPU_PCIE_GEN3;
-	default:
-		if ((sys_mask & DRM_PCIE_SPEED_80) && (default_gen == AMDGPU_PCIE_GEN3))
-			return AMDGPU_PCIE_GEN3;
-		else if ((sys_mask & DRM_PCIE_SPEED_50) && (default_gen == AMDGPU_PCIE_GEN2))
-			return AMDGPU_PCIE_GEN2;
-		else
-			return AMDGPU_PCIE_GEN1;
-	}
-	return AMDGPU_PCIE_GEN1;
-}
-
 static void r600_calculate_u_and_p(u32 i, u32 r_c, u32 p_b,
 			    u32 *p, u32 *u)
 {
@@ -5028,10 +5006,11 @@ static int si_populate_smc_acpi_state(st
 							      table->ACPIState.levels[0].vddc.index,
 							      &table->ACPIState.levels[0].std_vddc);
 		}
-		table->ACPIState.levels[0].gen2PCIE = (u8)r600_get_pcie_gen_support(adev,
-										    si_pi->sys_pcie_mask,
-										    si_pi->boot_pcie_gen,
-										    AMDGPU_PCIE_GEN1);
+		table->ACPIState.levels[0].gen2PCIE =
+			(u8)amdgpu_get_pcie_gen_support(adev,
+							si_pi->sys_pcie_mask,
+							si_pi->boot_pcie_gen,
+							AMDGPU_PCIE_GEN1);
 
 		if (si_pi->vddc_phase_shed_control)
 			si_populate_phase_shedding_value(adev,
@@ -7162,10 +7141,10 @@ static void si_parse_pplib_clock_info(st
 	pl->vddc = le16_to_cpu(clock_info->si.usVDDC);
 	pl->vddci = le16_to_cpu(clock_info->si.usVDDCI);
 	pl->flags = le32_to_cpu(clock_info->si.ulFlags);
-	pl->pcie_gen = r600_get_pcie_gen_support(adev,
-						 si_pi->sys_pcie_mask,
-						 si_pi->boot_pcie_gen,
-						 clock_info->si.ucPCIEGen);
+	pl->pcie_gen = amdgpu_get_pcie_gen_support(adev,
+						   si_pi->sys_pcie_mask,
+						   si_pi->boot_pcie_gen,
+						   clock_info->si.ucPCIEGen);
 
 	/* patch up vddc if necessary */
 	ret = si_get_leakage_voltage_from_leakage_index(adev, pl->vddc,
@@ -7320,7 +7299,6 @@ static int si_dpm_init(struct amdgpu_dev
 	struct si_power_info *si_pi;
 	struct atom_clock_dividers dividers;
 	int ret;
-	u32 mask;
 
 	si_pi = kzalloc(sizeof(struct si_power_info), GFP_KERNEL);
 	if (si_pi == NULL)
@@ -7330,11 +7308,9 @@ static int si_dpm_init(struct amdgpu_dev
 	eg_pi = &ni_pi->eg;
 	pi = &eg_pi->rv7xx;
 
-	ret = drm_pcie_get_speed_cap_mask(adev->ddev, &mask);
-	if (ret)
-		si_pi->sys_pcie_mask = 0;
-	else
-		si_pi->sys_pcie_mask = mask;
+	si_pi->sys_pcie_mask =
+		(adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_MASK) >>
+		CAIL_PCIE_LINK_SPEED_SUPPORT_SHIFT;
 	si_pi->force_pcie_gen = AMDGPU_PCIE_GEN_INVALID;
 	si_pi->boot_pcie_gen = si_get_current_pcie_speed(adev);
 
