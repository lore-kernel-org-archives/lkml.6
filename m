Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuAU1DzZN8DCNJ7cE8iOg3gt44ZVs+6taHXXNfou5k+1i8jmwz0COttgqalRcCf9b0Xdkpk
ARC-Seal: i=1; a=rsa-sha256; t=1519676929; cv=none;
        d=google.com; s=arc-20160816;
        b=DjpStvbaVRQ88qYHtgGQUox52uJeunzCLO4shsMZ0BQr270dqU2ZU7fb8Bv+Ug+7md
         L56Z78IzbZjQ6n6UhxjanppQ7F7a0WcHGE+Glg9zJXK7Xrg5SD4t3qy1uFba74jPC1X0
         suwib6wb5JgnYqhdx++K2ri7EwzO0nguNqA0vifFs5kX9B9j7Sqkmt1ivkqlIk5Uch3C
         YMbcq+4RLY1Dg7VFt+J6TG7vgoemSiQ3bjdieBA18xYhN+CUyc7B+qeIG64JIM7pArP5
         YZ1npiY/B6uccuyARKRBc6YXaQu9moDv0RgQoA4CrB1YgjSvrdp9QnnG7VlEuu9FlkZI
         v6BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WeTwzZr25idPxkvhSwY5j4k0jeU35BJztQHnsu6zWR8=;
        b=BdFf1KOo30dL3TM7nOIZ8+9UNClVYhIaZuWcFxtzW3B8TaYKetbUF4IPDCbWYKKfhj
         tpeon1m6OCNiy6yYf1llRsfMJPxk28D0C2SbQtRqWAsfGSUl6fxj6W6j/eXew9L/Ltpe
         FQ9+pvf6H5B7cWt8qzM9719ry9MinQGhJxEInHOY7HKZRj6/BsmGoCqdPcIFtqS+GeGl
         cxnE1+p1c4Ne0dTW4L+cC19T37VblDSJ9v4OtBdENSXkPfHa3P2U6BTpkRh6NY3UK0cG
         YqEkBActTlXqx1qDD+4SfDP0qghQuXfm9lvMmT9WWJWbHJqYf7emma9/Xr7QyN7A7BXt
         KiGQ==
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
Subject: [PATCH 4.15 59/64] drm/amdgpu: only check mmBIF_IOV_FUNC_IDENTIFIER on tonga/fiji
Date: Mon, 26 Feb 2018 21:22:36 +0100
Message-Id: <20180226202155.971692043@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496537116574874?=
X-GMAIL-MSGID: =?utf-8?q?1593496756415197128?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -449,14 +449,19 @@ static bool vi_read_bios_from_rom(struct
 
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
