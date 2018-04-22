Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49BUDAgg4Hs4HoTAMyR3QyCspOggLP/E4iVDU9w7zsPebWsYUIik2TJq74iUYGVUs+WxfBy
ARC-Seal: i=1; a=rsa-sha256; t=1524406128; cv=none;
        d=google.com; s=arc-20160816;
        b=UM/XdRwuPQ/QygDDgUVqzeqc9ZhE5j++R1cpQgHXoDi96bH8wXM8uZESLYCxsEDcKt
         4z+dkV5mBBpMhvZLsUaAreoqkeuVSLYJOdvm3ps8fXqtEvu7kMjBh3GBVOvbBKLFDEv8
         A0QCjsMeOk3xbMIx8Qowcqbg2rwo20PXzSgrVGhVyi4+GVlSFx2bn81zYHfORVw8JyhT
         Iuoe6vgz6wBESkXvm2s5068mPNPoXCQMqesRvJsA8ZFAU7/Mp1eC/O0ro0KT7LW/tH4H
         yL+tJ/S+QiydiJOlw8GR9qfz2rDh02AOuaHKRawFqjF0r6Pb8m2kcjmk3fSruJAliLUI
         WzTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=OGYcsD01jUn1luQ32ciIF9HIAsfUlU0suq3MJbKTh3I=;
        b=KNCMgfPJg7mDrJHWLnW2Kto9Zc5l6eTyxIVKM1AXF0V/p220zeozhflylOZMpAyZel
         gfdteiF8+iHaTjsuiyHUVAK7g2yUP58ufzoVHcVNgHdZeLQc3nfHykeSeqoChlNrDkup
         MPBvDY9ynvJmpWN9o/Jy26/kSEhX+LmucHD02gZ5BRM66ETY1d4ag+YBJUnHfFeJfqpe
         qLeCtLyQKaAjxBDcXzKLG5vXD8eTwoSmAwh0Yy41Hb6h4l6lYli6qxJi8RRDZ/bV359l
         pA6v8BwjGCIB730gUgFuNiTa/Zx97VBQac/AT4Cu1TU7nDyc+PTr8waFRKx7f84RQjJf
         eS8g==
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
Subject: [PATCH 4.14 124/164] drm/amdgpu/si: implement get/set pcie_lanes asic callback
Date: Sun, 22 Apr 2018 15:53:11 +0200
Message-Id: <20180422135140.478804164@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455210813140585?=
X-GMAIL-MSGID: =?utf-8?q?1598455681194509239?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
