Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49kRJnF1UCrjrmYdonsAuUmMYvThA0ZnGrv6NgteRaG/hjXVx5yjZzpel/tF6OfQgSGsQTX
ARC-Seal: i=1; a=rsa-sha256; t=1524406522; cv=none;
        d=google.com; s=arc-20160816;
        b=0Jwj8TcStY4FYpdTF3ajn7r5MO1JZFt//3R35Ce37vL/70ePmK9UhzQW0VaVlnRRCV
         yM3BM9eP4fUKL6abxm6RaG9Mh/H4CmMaXwBHPR8/Amv14GjexCoLL+d/7qjRemK5PvlE
         Nflq9FNv7DvMlHsEsAM0bsWWmuLtSKr2/6lZShESqOGiLTa8e8KG/ubo7DW/xKN0kyTR
         RmlymGAwrn1GXgc3fPQ4lcWnyBUTfkcqgq0V0GKAc6IlXC42cCUO9a6IPMinbXNNxY2o
         /ihbtNOQX7SbJ8f/7tkuKOYsSv4Ls7ehOPT6oOpw0kJJcDN2nK4WAAS0/qMW8UKcalc/
         SoLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nvgnX0mVCW5DUn/LBOLujB/UcHeISZ40ACiqaie75As=;
        b=vLoz2xXrNrDWLf/6hciYTBzGG4Ku3r7JHeg+nBvsLMLzuPE38Ha6AK1JzDh1SIyzub
         PTGy3IHWFYJUsxwz+Z4ZlE5VxCsLIP7FJrIWqDE8F+hXF4vwrNTyp6GJ6hkDN9XArN+/
         OG0NDK3C7xHzlnQ1ZY1XNHpHZnhl7TDj1eePFNFGkMHQ+KuzO1wYVp7wYA8QTYzeD0Za
         jka3pPrXeJZhMXyYzl3xzUH/WNJKWjjNA/UeKuIJoaOspvW40ZhsYRih5mrPrCaHvD4P
         mlEVaqe0NBmJtaeFczwpkr/4PxXgA75/fN4VlXKwsG7AwR2gEFBbF6yKpHYT2Mf0tQVL
         dbdg==
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
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.9 68/95] drm/amdgpu: Fix PCIe lane width calculation
Date: Sun, 22 Apr 2018 15:53:37 +0200
Message-Id: <20180422135213.210189738@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455207423357014?=
X-GMAIL-MSGID: =?utf-8?q?1598456093354288129?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit 41212e2fe72b26ded7ed78224d9eab720c2891e2 upstream.

The calculation of the lane widths via ATOM_PPLIB_PCIE_LINK_WIDTH_MASK and
ATOM_PPLIB_PCIE_LINK_WIDTH_SHIFT macros did not increment the resulting
value, per the comment in pptable.h ("lanes - 1"), and per usage elsewhere.
Port of the radeon fix to amdgpu.

Acked-by: Christian König <christian.koenig@amd.com>
Acked-by: Chunming Zhou <david1.zhou@amd.com>
Bug: https://bugs.freedesktop.org/show_bug.cgi?id=102553
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/si_dpm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
@@ -6449,9 +6449,9 @@ static void si_set_pcie_lane_width_in_sm
 {
 	u32 lane_width;
 	u32 new_lane_width =
-		(amdgpu_new_state->caps & ATOM_PPLIB_PCIE_LINK_WIDTH_MASK) >> ATOM_PPLIB_PCIE_LINK_WIDTH_SHIFT;
+		((amdgpu_new_state->caps & ATOM_PPLIB_PCIE_LINK_WIDTH_MASK) >> ATOM_PPLIB_PCIE_LINK_WIDTH_SHIFT) + 1;
 	u32 current_lane_width =
-		(amdgpu_current_state->caps & ATOM_PPLIB_PCIE_LINK_WIDTH_MASK) >> ATOM_PPLIB_PCIE_LINK_WIDTH_SHIFT;
+		((amdgpu_current_state->caps & ATOM_PPLIB_PCIE_LINK_WIDTH_MASK) >> ATOM_PPLIB_PCIE_LINK_WIDTH_SHIFT) + 1;
 
 	if (new_lane_width != current_lane_width) {
 		amdgpu_set_pcie_lanes(adev, new_lane_width);
