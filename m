Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx492KnkQNOtIonsQ3ItpCJchYdPU+VNsF3Cl12M05TycohIfvvw4majhkEHkFmkVkaUpD2Wk
ARC-Seal: i=1; a=rsa-sha256; t=1524406126; cv=none;
        d=google.com; s=arc-20160816;
        b=ipbsiOhLF0Scq6ME3TT6rmYtaeJ73BKxRlBKEPwzWICcJf4Xfv7ibcBIgNou28vuAw
         sM/LpZn9qZEPfrKVPnKAWH5GoWMOhA+ip+znwaFwCYLSL99fb+beWnEwQj/qFVdmF/H3
         vgvPfPr4oNW16wqNkakZ7/pQBLnvOCgWJRqWDl59FNPj/UeyFrCqO2bjujO8M4S7URDr
         ah9DmDAarV0XD8AGpf6U722eKOWDcOpU9JJ0qcHPeFvbmz/sCBrq7KUQS0SQMZtcxPFn
         RqyjOMIoftffOGqfl+4s2xXE6uEYtomdztv8xsJjPmEqNZ+9mbEHkYMIpWcUw+Z74ATY
         K1qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jMqIUcb6TIshwsGYPlJq//rS/YoMty8g6ViMg4IeaYw=;
        b=qigA4M6vQ1omb8eSlP3cXBXRe62IxMHZqecDQOdQs07WgfzaasGGLxAHRM3P064VpJ
         K/r5Nn67K36Q8hYM7tJ+vkaTCjA5ynxPsqQr3djklT3n/Fj8cBva85EjGvPnBrJ/5XI+
         oPZbkAWlalI4uNr30GEO1N6kRJGaHFeZXs7fZrVr3l/Zsgi8qihIefLnWxVELZapjxWV
         QjtNoJAM87spd+TfwlPdlNBDaypnVtBC+zinM6wE44rz8DErRkOvQmQmBm4WdMsPSgNt
         N5xRS4trdSY5Y428F6ntuUKWRbx9Ys/3m9+XRm3uFwpKo7YONuh+V9DvyErElA1flhGI
         SCRA==
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
Subject: [PATCH 4.14 123/164] drm/amdgpu: Fix PCIe lane width calculation
Date: Sun, 22 Apr 2018 15:53:10 +0200
Message-Id: <20180422135140.440508446@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455207423357014?=
X-GMAIL-MSGID: =?utf-8?q?1598455678288072566?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -6374,9 +6374,9 @@ static void si_set_pcie_lane_width_in_sm
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
