Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224j9mDiHqCkQzWpubbrCh+WifVtumnarp86gEDHNhA2ZM/nVryKHDpWPIeSLejcjvjF+C9g
ARC-Seal: i=1; a=rsa-sha256; t=1519676530; cv=none;
        d=google.com; s=arc-20160816;
        b=oy0vVrix0Y5jMydqbcy3c8Ltl2BERLrpzrU9lhg5ve9T13I6FP+F6keA4QIwV5IvQJ
         ckLj/PUuGvbU6DMFClE+hlNJoXZrasCVSO3G5AL3kUSXtwEIMz3OPWmiZrVnTXhWomX/
         aCJWQe28k7B6T25PJhg5zlyjWFf71MELzOmw02vYMpqzy+dH1kcrGyDzEDEqhEjhd05O
         W0/yNfwZa5BHHEpK89HC2bugk5JTU/t0ChBVIg3/rzVE/cCxcoaA27PUQXF+umC9BG78
         qDhUnk9xzGiziUjwaRKaTASNnSm6KdIY66tIbMATzkozxdJ+rzBcnIaJ8VH8oSJH1RTr
         Dkww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CYUu6XaLPskbbf4D9B+LZ4/svso39B9QYcZElzVkIJQ=;
        b=i9iseZfL3YMnXhZwoJ4VylhtkZQIjiYJ/KrgcBsDk7+vN9+yaN8SkMxNtYw631mbhI
         Nmf3d6gSL2D/T1XZapwaY6dBjE4ENDtMgUH/TKSTCX7NP4P93mOHbsTCOcmL9O6MDh1P
         o2unrSJUo261nQYPcIdX9LeZUzV6WDh7O9t1qQtMR9HE50y/uw3HsOKU50r3PsE5FG60
         YfgBVCyPLS3gYDvOLMd8vFKC3mJWvxmXTId6Xj+y7i3+G66UMxuzyBEnoL3djiOszjtz
         jJdVJqmpcCvwEXVxZEw6Q0nVJL3j2rJuJTzvt4g4131THjGMvCPiIlyNt98nJsv5LkLi
         +RNA==
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
Subject: [PATCH 4.9 24/39] drm/amdgpu: add atpx quirk handling (v2)
Date: Mon, 26 Feb 2018 21:20:45 +0100
Message-Id: <20180226201644.725963235@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201643.660109883@linuxfoundation.org>
References: <20180226201643.660109883@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496337704083909?=
X-GMAIL-MSGID: =?utf-8?q?1593496337704083909?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
