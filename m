Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELunVQVCvM7O+e0tmJzaVV6e/Pi3JxL1rmdOmGT4sR37FVlZnXxkQlEPPrKRWTw7EFTAsLPJ
ARC-Seal: i=1; a=rsa-sha256; t=1519676720; cv=none;
        d=google.com; s=arc-20160816;
        b=eBgaClUXbeEKvqJazZETuNVGra4YqDUoiWeMesCPhkdxx8voEHk7N/ABzPK0zg6va9
         Pgnro3DDpp+j3utJTXTpORwK31bb1N6euNMyvl8aVexci+xCMy0j8Dxgwj7opPsUX5xN
         v1CUt40JAYO0Y3jQeA/4KIcpTbXArIuA8j9tQ70o8i7Vl5ZbXeIF6TM6xAVErFKLW55X
         FBm82fa1QI/V358TTrCja2PTOITC0apOqpjiOIQ7ahrR8JJl81NYbWPqhxuJVaHBI/JD
         0Nu0QoQpeYvc5XhhuZ+0Vtdvj+/2eRFXJSsxOSlpwezrPP+FXxYkQJOb7zDQdOLTfGIl
         NUCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EEnbC4oE0tIyLdRvzulqiZFRCnZnroj9Ao679+PZaMM=;
        b=IsHNZuS208hRS3pJVJ/n0jZQUGKDYOZJCzwttkZXDm/zyv5848qtOow18QAauc87UF
         F7rlW+TGAHBniZ5HyfMDQN1p5feFwDEm4aZqsENrqG2P+T+T1c/wezhEwcyiGGeSN25J
         4oA/dfLODtT+5KLAUMa7A9z3F0Q30IpuG3dMsXjfuYtV7Wny8MtmEeQZchd5GknbkXcu
         2CFArjWzrl4OtKHTYGtp4OMQzWUJVR5GnaELS36YYXBZnOlux1vJlCYR/N7IXZbuMUZA
         v9XkYfxrrbog35YMYDdogFr/iJxhGSujCibeFupQ8OWoKjPTG3mPQAsv/DYPo3mESQMx
         Y+Ug==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Xiangliang Yu <Xiangliang.Yu@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.14 50/54] drm/amdgpu: only check mmBIF_IOV_FUNC_IDENTIFIER on tonga/fiji
Date: Mon, 26 Feb 2018 21:22:27 +0100
Message-Id: <20180226202147.172418849@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496537116574874?=
X-GMAIL-MSGID: =?utf-8?q?1593496537116574874?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit 57ad33a307bf85cafda3a77c03a555c9f9ee4139 upstream.

We only support SR-IOV on tonga/fiji.  Don't check this register
on other VI parts.

Fixes: 048765ad5af7c89 (amdgpu: fix asic initialization for virtualized environments (v2))
Reviewed-by: Xiangliang Yu <Xiangliang.Yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/vi.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -448,14 +448,19 @@ static bool vi_read_bios_from_rom(struct
 
 static void vi_detect_hw_virtualization(struct amdgpu_device *adev)
 {
-	uint32_t reg = RREG32(mmBIF_IOV_FUNC_IDENTIFIER);
-	/* bit0: 0 means pf and 1 means vf */
-	/* bit31: 0 means disable IOV and 1 means enable */
-	if (reg & 1)
-		adev->virt.caps |= AMDGPU_SRIOV_CAPS_IS_VF;
+	uint32_t reg = 0;
 
-	if (reg & 0x80000000)
-		adev->virt.caps |= AMDGPU_SRIOV_CAPS_ENABLE_IOV;
+	if (adev->asic_type == CHIP_TONGA ||
+	    adev->asic_type == CHIP_FIJI) {
+	       reg = RREG32(mmBIF_IOV_FUNC_IDENTIFIER);
+	       /* bit0: 0 means pf and 1 means vf */
+	       /* bit31: 0 means disable IOV and 1 means enable */
+	       if (reg & 1)
+		       adev->virt.caps |= AMDGPU_SRIOV_CAPS_IS_VF;
+
+	       if (reg & 0x80000000)
+		       adev->virt.caps |= AMDGPU_SRIOV_CAPS_ENABLE_IOV;
+	}
 
 	if (reg == 0) {
 		if (is_virtual_machine()) /* passthrough mode exclus sr-iov mode */
