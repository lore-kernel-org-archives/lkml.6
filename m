Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48Gz3r7zXwzS0Axw30grHxTrIPvpEZYP1TiHxENsIJRpeXj4EcM2ZZ/xUXpsF9tMA0Hqf0Q
ARC-Seal: i=1; a=rsa-sha256; t=1524406886; cv=none;
        d=google.com; s=arc-20160816;
        b=yNk+awxmmaccNWJtqaCQwy6jqPOTT7SLePTixrncVJ7WOknz6qt//MxGcJWA+ymi5p
         SFLgNCTcKjX24fUofjD399Q3jAQTRBmfbSMoxUOSJ2W9LGQhwPUT03iEVTlJSibMn6RC
         be4glg3NvOXV97zSPZy4JcMYUSvXdvMgOZAfFCUF6j6VI2mN7zaTyEhYd81ZyN/3b1ry
         dykrsJ9v1SX9MfP4rSPSUTLEo4xP3Sk6cgjXdvd+Ai7pFGIdsVneOo+Hw/B6mQrSRuAU
         eegUNDu58Jc3YAIm/9QMN/iVlW804tWBjbvxzCbv2ZmFARuELXh+5rf+Cl9E6ypNImBj
         9kfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=E0B4NZq1BDvVqajfnSHcld4GOvmpCUAJjcwXe0/iPJA=;
        b=C1vNFuZv52LCoQQW1P+J2+2HWQ3XFDcwvkkhbOmiYGoI2JSIm5nyuXRFJSiC23AKvW
         HAWpFwoCEaDBduMpOgTUC+tAqXTf/Ja3dIUlWhhzzoyqYbbaskANtj925/7lIwI1mrUI
         Rn2P1iV0S07iOdpJ9W+tq9EIsaHNTiU4Z60yb7UQn/sZ5fc7DF2z2LAUxrG4DZtQAjmE
         VdG3PnW0ITDB3acUwHAZsAPx3HmMm9d3Svwtj/m86O6l0ORJnNt5PIg2gqOghwcgQR4R
         Yz6xtxJ9/Z4NotrJY7+wQYv2hk065LwWdH3t8WgcZoi0BkZIRDo9reAaD4f58Hj71WKr
         i7Ig==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Chunming Zhou <david1.zhou@amd.com>,
	Paul Parsons <lost.distance@yahoo.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3.18 40/52] drm/radeon: Fix PCIe lane width calculation
Date: Sun, 22 Apr 2018 15:54:13 +0200
Message-Id: <20180422135317.241130706@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455237200582440?=
X-GMAIL-MSGID: =?utf-8?q?1598456475310566413?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Parsons <lost.distance@yahoo.com>

commit 85e290d92b4b794d0c758c53007eb4248d385386 upstream.

Two years ago I tried an AMD Radeon E8860 embedded GPU with the drm driver.
The dmesg output included driver warnings about an invalid PCIe lane width.
Tracking the problem back led to si_set_pcie_lane_width_in_smc().
The calculation of the lane widths via ATOM_PPLIB_PCIE_LINK_WIDTH_MASK and
ATOM_PPLIB_PCIE_LINK_WIDTH_SHIFT macros did not increment the resulting
value, per the comment in pptable.h ("lanes - 1"), and per usage elsewhere.
Applying the increment silenced the warnings.
The code has not changed since, so either my analysis was incorrect or the
bug has gone unnoticed. Hence submitting this as an RFC.

Acked-by: Christian König <christian.koenig@amd.com>
Acked-by: Chunming Zhou <david1.zhou@amd.com>
Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/radeon/si_dpm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -5894,9 +5894,9 @@ static void si_set_pcie_lane_width_in_sm
 {
 	u32 lane_width;
 	u32 new_lane_width =
-		(radeon_new_state->caps & ATOM_PPLIB_PCIE_LINK_WIDTH_MASK) >> ATOM_PPLIB_PCIE_LINK_WIDTH_SHIFT;
+		((radeon_new_state->caps & ATOM_PPLIB_PCIE_LINK_WIDTH_MASK) >> ATOM_PPLIB_PCIE_LINK_WIDTH_SHIFT) + 1;
 	u32 current_lane_width =
-		(radeon_current_state->caps & ATOM_PPLIB_PCIE_LINK_WIDTH_MASK) >> ATOM_PPLIB_PCIE_LINK_WIDTH_SHIFT;
+		((radeon_current_state->caps & ATOM_PPLIB_PCIE_LINK_WIDTH_MASK) >> ATOM_PPLIB_PCIE_LINK_WIDTH_SHIFT) + 1;
 
 	if (new_lane_width != current_lane_width) {
 		radeon_set_pcie_lanes(rdev, new_lane_width);
