Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+xSuYguXcrPUcCxpu7AoCvodBWh4oyuiXY5SMxbrfwj+MRRgrecP/XWkjADEyZfL8lQpCo
ARC-Seal: i=1; a=rsa-sha256; t=1524405677; cv=none;
        d=google.com; s=arc-20160816;
        b=bUvK0FiP14LrpoaKMfWfkca5Ma6OrsAqLacwo7sIb5bkF2zGeqNU/ovNK9VkXp8my4
         GDPQm1K3gtHVTkDbfu0ZI+bGKz7giPP/vzd1cGaMpKASwE8WA/W2BmghKF61eYgySVQO
         oVsV0e20uzCqgOirOTybCNZkw/82Wcy2Ua/xGKYqHYoh7E8oM04MIolA5Wshlin0rfRG
         FtDWKYaR0Y1sHyFwXo+MXudO7OaM6o+Pb5Rwb7/YLP3gIX/sj9qAXrfnu7HWX1+LW6DD
         UA8UYCBPttUBZBwJGGwmzUQ5lVppa6ru+A0T7Hdgn0EneUXy/CxoDriqM8kyZ7gAZIzZ
         6WXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vPUBYSdr2Mm8S/1mXRxBbG3/acrYlcIlL2ooi/jWMOA=;
        b=l1gpgO4zTm13Et1USwRuOm8q1xJ9upHpAdpmAcftO+SkfK5dedZ2C92Z/oDgyRz1fO
         f8an/g+CbPWbegIicbKgmCEBzwm0IwAJGTfv5X1ulzsRfZMQsFkhCkZnW+6kSDdI9NvV
         Ht9y0/78PK+v8QxFU/+1ttewxaAjt9ukZTHV/gMajqD0Frpjg4WHupjnTH87VRe2h5Xb
         42vHX824Y/+V+xwKVhxNmiEaAPQ23u93+2eaZUdyMxEIo7c9cyiKZrYYpWp8sI9Ficcg
         /UaHp30IJLWKT9YiVLTXnGS1l/veDG9fWxB32LvS6XClWhSr6wTMf8++XX6/lG1lr2Ga
         rg+Q==
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
Subject: [PATCH 4.16 153/196] drm/amdgpu: Fix PCIe lane width calculation
Date: Sun, 22 Apr 2018 15:52:53 +0200
Message-Id: <20180422135112.149399944@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455207423357014?=
X-GMAIL-MSGID: =?utf-8?q?1598455207423357014?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -6370,9 +6370,9 @@ static void si_set_pcie_lane_width_in_sm
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
