Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+9XDzPTFHyXr5aFq8QsTRYEQ6iJ+7PSHdnx0daqKb5mjSaRIhT8Zx00o/j5pmgA1MGfygs
ARC-Seal: i=1; a=rsa-sha256; t=1524405680; cv=none;
        d=google.com; s=arc-20160816;
        b=ZbAgQWrk/l3ooVhL6iyUR8EAG7B8+o58fbGB03UP/Ypuu6hqg2fZTOHCPHmK0m9zbj
         dVZ5tlp1ARoUXhhpfK6nRMMPf+ZCzTN0SkvKUO/dIjmw/01kxPAWiG/Pp++oQskzc/D9
         4X59LPoH+kJ8c97NYjq3tYoyYaNAfOvW6k9WQWIgj+H3/YzC2Db3AdHYosuMqRUVCzvm
         mN6xAU9n1Al3lEPibeEOan23UuoBafJn9JtpJjCiYNtugROF+y3tklXyP6dC6iSzX4tq
         rc7X2epI5Nk16CyjDNjD1jPqFIupRqSADP+0PYaC9MxQGJYblu1GFzeQ3YGoAqEvJ4Bb
         kX6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gNJF27+0TmYnt2h0PwQKMioZ35U1R1q21uKpVXbTGpg=;
        b=NR2EU/2J9LWmuwf2THf/tKyg+e1Fi6sge4+zg77Z2cyiokkQneTGA7BeUlIV8nUm68
         m510sViscaCTh3EKzkjRLIajc8GsJjElsYqjV4/v5ksuZpYBuPiZ9o5017ZtPJbgbZep
         dYGDvB9aXT+4T/m4PkqYEERFS+dfk1tDN3zMbUIHNYAigC4uG/FmuBMXAGCOGmfyvVD0
         ja4E0y9ZjUTiGtQyz23Oqjs9dT1j9qVsKqLtVfp1nIQ0IiBaknnTY+u9XwhXKVLn3BzZ
         xVzaeR3GBxiabCvxVF4DXOP3gahsAcg8MjCIaabdRx6YXZLpBrQOdzGfDvOCh0GqNPUq
         tUJg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Abel Garcia Dorta <mercuriete@yahoo.es>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.16 154/196] drm/amdgpu/si: implement get/set pcie_lanes asic callback
Date: Sun, 22 Apr 2018 15:52:54 +0200
Message-Id: <20180422135112.188207406@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455210813140585?=
X-GMAIL-MSGID: =?utf-8?q?1598455210813140585?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit 20ca25e86c56f5490bdc80318f4fc06466e4c21b upstream.

Required for dpm setup on some asics. Fixes a NULL dereference
on asics that require it.

Acked-by: Christian König <christian.koenig@amd.com>
Bug: https://bugs.freedesktop.org/show_bug.cgi?id=102553
Tested-by: Abel Garcia Dorta <mercuriete@yahoo.es>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/si.c |   67 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1231,6 +1231,71 @@ static void si_detect_hw_virtualization(
 		adev->virt.caps |= AMDGPU_PASSTHROUGH_MODE;
 }
 
+static int si_get_pcie_lanes(struct amdgpu_device *adev)
+{
+	u32 link_width_cntl;
+
+	if (adev->flags & AMD_IS_APU)
+		return 0;
+
+	link_width_cntl = RREG32_PCIE_PORT(PCIE_LC_LINK_WIDTH_CNTL);
+
+	switch ((link_width_cntl & LC_LINK_WIDTH_RD_MASK) >> LC_LINK_WIDTH_RD_SHIFT) {
+	case LC_LINK_WIDTH_X1:
+		return 1;
+	case LC_LINK_WIDTH_X2:
+		return 2;
+	case LC_LINK_WIDTH_X4:
+		return 4;
+	case LC_LINK_WIDTH_X8:
+		return 8;
+	case LC_LINK_WIDTH_X0:
+	case LC_LINK_WIDTH_X16:
+	default:
+		return 16;
+	}
+}
+
+static void si_set_pcie_lanes(struct amdgpu_device *adev, int lanes)
+{
+	u32 link_width_cntl, mask;
+
+	if (adev->flags & AMD_IS_APU)
+		return;
+
+	switch (lanes) {
+	case 0:
+		mask = LC_LINK_WIDTH_X0;
+		break;
+	case 1:
+		mask = LC_LINK_WIDTH_X1;
+		break;
+	case 2:
+		mask = LC_LINK_WIDTH_X2;
+		break;
+	case 4:
+		mask = LC_LINK_WIDTH_X4;
+		break;
+	case 8:
+		mask = LC_LINK_WIDTH_X8;
+		break;
+	case 16:
+		mask = LC_LINK_WIDTH_X16;
+		break;
+	default:
+		DRM_ERROR("invalid pcie lane request: %d\n", lanes);
+		return;
+	}
+
+	link_width_cntl = RREG32_PCIE_PORT(PCIE_LC_LINK_WIDTH_CNTL);
+	link_width_cntl &= ~LC_LINK_WIDTH_MASK;
+	link_width_cntl |= mask << LC_LINK_WIDTH_SHIFT;
+	link_width_cntl |= (LC_RECONFIG_NOW |
+			    LC_RECONFIG_ARC_MISSING_ESCAPE);
+
+	WREG32_PCIE_PORT(PCIE_LC_LINK_WIDTH_CNTL, link_width_cntl);
+}
+
 static const struct amdgpu_asic_funcs si_asic_funcs =
 {
 	.read_disabled_bios = &si_read_disabled_bios,
@@ -1241,6 +1306,8 @@ static const struct amdgpu_asic_funcs si
 	.get_xclk = &si_get_xclk,
 	.set_uvd_clocks = &si_set_uvd_clocks,
 	.set_vce_clocks = NULL,
+	.get_pcie_lanes = &si_get_pcie_lanes,
+	.set_pcie_lanes = &si_set_pcie_lanes,
 	.get_config_memsize = &si_get_config_memsize,
 };
 
