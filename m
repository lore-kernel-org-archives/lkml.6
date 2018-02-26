Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227m2WYvZKAS/s/bPL1amnFTcU1QqrQBdrfT9B3Hd19D4e7Hgu/cmaJe3xMaCv2usJ3zlpws
ARC-Seal: i=1; a=rsa-sha256; t=1519676723; cv=none;
        d=google.com; s=arc-20160816;
        b=mty82bXZvY3dX9RwlsJmmqowMVYhLjSTkIwqGECu/YgTrUL0asf47dbqQzTLXcu35b
         4ZBCmQLKcvaUaFTCKWjp0KHEtMhKEUi8U38ZXa9gGXUXmq0E8p1rdupAoQ08gwCoAYiG
         dmGMJRulAJjXlrpPx+aW1bC6j3L9tbR/Bf2gkG0kud6wWagdg9ZQ/Zgk4uF2YmqKg6ac
         paee4mYVe86v65Y0/Pf4stK499om8B2abJ5wjg9jl6Q9emwUCfpNjDPEH0shoC+zQX7L
         CT5fxmHr4YFrU3LbuD+31XHZcva2DMi1z2MZDMWQ8dRvKneND4/F+Wy64sDSKKLBeGb7
         HyLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RLWBpaLWQrTxwGR2zjNVN7wT5Yg/qGvNl3fpISZvFNs=;
        b=AY0MkAlAWCfbejWFoFfhWUbRaJEA7eJnbkpdPr22n0/jISAK8Yh58gNPa5V4UEtqnV
         cqy5b8tjXLwaoao1b7Z+g36VrdKfdFcvfW3VxsyU2RXN7iuAIDJSBDCXKO2uLvbrES5N
         Bps3FtreuUieLsb6Zl1pEXAM6JC+vJiQuaBxMRgRxq/cP922HpqUdNY/QkO8ZcgOIThG
         NfyJC4zij5wpRsEXmOZeiKmPP8VEZxXrwvNfRm5x4M80Ex6VHCgMj3+nZkPcLzWnH6HJ
         vimRJKm2j1wDCjAIeP0hvPjcRBzXsbCy+D/sXfNYgL/uZ3hMd4UNMPFsJwmoC8O3a1Ji
         3mcA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Junwei Zhang <Jerry.Zhang@amd.com>
Subject: [PATCH 4.14 51/54] drm/amdgpu: add atpx quirk handling (v2)
Date: Mon, 26 Feb 2018 21:22:28 +0100
Message-Id: <20180226202147.245923634@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496540331149794?=
X-GMAIL-MSGID: =?utf-8?q?1593496540331149794?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit 052c299080cd6859f82a8154a7a673fafabe644c upstream.

Add quirks for handling PX/HG systems.  In this case, add
a quirk for a weston dGPU that only seems to properly power
down using ATPX power control rather than HG (_PR3).

v2: append a new weston XT

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Junwei Zhang <Jerry.Zhang@amd.com> (v2)
Reviewed-and-Tested-by: Junwei Zhang <Jerry.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c |   57 ++++++++++++++++++++---
 1 file changed, 50 insertions(+), 7 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
@@ -14,6 +14,16 @@
 
 #include "amd_acpi.h"
 
+#define AMDGPU_PX_QUIRK_FORCE_ATPX  (1 << 0)
+
+struct amdgpu_px_quirk {
+	u32 chip_vendor;
+	u32 chip_device;
+	u32 subsys_vendor;
+	u32 subsys_device;
+	u32 px_quirk_flags;
+};
+
 struct amdgpu_atpx_functions {
 	bool px_params;
 	bool power_cntl;
@@ -35,6 +45,7 @@ struct amdgpu_atpx {
 static struct amdgpu_atpx_priv {
 	bool atpx_detected;
 	bool bridge_pm_usable;
+	unsigned int quirks;
 	/* handle for device - and atpx */
 	acpi_handle dhandle;
 	acpi_handle other_handle;
@@ -205,13 +216,19 @@ static int amdgpu_atpx_validate(struct a
 
 	atpx->is_hybrid = false;
 	if (valid_bits & ATPX_MS_HYBRID_GFX_SUPPORTED) {
-		printk("ATPX Hybrid Graphics\n");
-		/*
-		 * Disable legacy PM methods only when pcie port PM is usable,
-		 * otherwise the device might fail to power off or power on.
-		 */
-		atpx->functions.power_cntl = !amdgpu_atpx_priv.bridge_pm_usable;
-		atpx->is_hybrid = true;
+		if (amdgpu_atpx_priv.quirks & AMDGPU_PX_QUIRK_FORCE_ATPX) {
+			printk("ATPX Hybrid Graphics, forcing to ATPX\n");
+			atpx->functions.power_cntl = true;
+			atpx->is_hybrid = false;
+		} else {
+			printk("ATPX Hybrid Graphics\n");
+			/*
+			 * Disable legacy PM methods only when pcie port PM is usable,
+			 * otherwise the device might fail to power off or power on.
+			 */
+			atpx->functions.power_cntl = !amdgpu_atpx_priv.bridge_pm_usable;
+			atpx->is_hybrid = true;
+		}
 	}
 
 	atpx->dgpu_req_power_for_displays = false;
@@ -547,6 +564,30 @@ static const struct vga_switcheroo_handl
 	.get_client_id = amdgpu_atpx_get_client_id,
 };
 
+static const struct amdgpu_px_quirk amdgpu_px_quirk_list[] = {
+	/* HG _PR3 doesn't seem to work on this A+A weston board */
+	{ 0x1002, 0x6900, 0x1002, 0x0124, AMDGPU_PX_QUIRK_FORCE_ATPX },
+	{ 0x1002, 0x6900, 0x1028, 0x0812, AMDGPU_PX_QUIRK_FORCE_ATPX },
+	{ 0, 0, 0, 0, 0 },
+};
+
+static void amdgpu_atpx_get_quirks(struct pci_dev *pdev)
+{
+	const struct amdgpu_px_quirk *p = amdgpu_px_quirk_list;
+
+	/* Apply PX quirks */
+	while (p && p->chip_device != 0) {
+		if (pdev->vendor == p->chip_vendor &&
+		    pdev->device == p->chip_device &&
+		    pdev->subsystem_vendor == p->subsys_vendor &&
+		    pdev->subsystem_device == p->subsys_device) {
+			amdgpu_atpx_priv.quirks |= p->px_quirk_flags;
+			break;
+		}
+		++p;
+	}
+}
+
 /**
  * amdgpu_atpx_detect - detect whether we have PX
  *
@@ -570,6 +611,7 @@ static bool amdgpu_atpx_detect(void)
 
 		parent_pdev = pci_upstream_bridge(pdev);
 		d3_supported |= parent_pdev && parent_pdev->bridge_d3;
+		amdgpu_atpx_get_quirks(pdev);
 	}
 
 	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_OTHER << 8, pdev)) != NULL) {
@@ -579,6 +621,7 @@ static bool amdgpu_atpx_detect(void)
 
 		parent_pdev = pci_upstream_bridge(pdev);
 		d3_supported |= parent_pdev && parent_pdev->bridge_d3;
+		amdgpu_atpx_get_quirks(pdev);
 	}
 
 	if (has_atpx && vga_count == 2) {
