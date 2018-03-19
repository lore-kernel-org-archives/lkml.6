Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu7mVpvq2+eZAd/ZO9fRLAj/OqUvEntC2ArDfbNVjlse+7PWQHMG4mJ6uRdZhF0KUdPc3lj
ARC-Seal: i=1; a=rsa-sha256; t=1521483010; cv=none;
        d=google.com; s=arc-20160816;
        b=nrMXdbOySXt60viTfFFW0qcJzbxQ41vqPk35vRONGoyE7OcVCZZj4c4yGPjy3sdszh
         AtO86XByzmNpLsm6K7nKavVz568zuYJhBVOX2Q9gj18rNu0tomKyXjYoh91rJv7dpF+z
         MPGrkPq5YeunaN1LbkIWpeDRDaXtFHqKPSJELGDmQs+LD4Ph/eutUTo65kCubl53hbWT
         n/ij+BYqRb/FrzPSL4cVn0um17MlPul+cE236igeVbIbvFgdMsNVtYHSPIOqKHlVq0sU
         5zrxhsxh1GDSLO1dmAR142urVAuxPnqMCq6ikkDLcvUU6PiWTl5LBIVfxFlFpx+lHZQe
         CSTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=APgrhFFnz5F/rKmynD7LhwNhl8qjoWwaEbObtmIuF2M=;
        b=Q1cQTJ9WgixCgg1Kq0iOA0xkSsrlUtrwSFuxd+WhjN940AciLdtqlKcqTeInAdRGFY
         /FQdNuiDIWGaHPO+fdowcW59D8A1+CArlPmmOEMHdlhktvrAjCpiNT0BBu3UJbAp92dR
         DiRgNlAisiDJU3GZHq2XegqMkNY8BdWlDjwh7xrpJbYao57OJOb8WslcCi1q09oKkPmC
         dc5BkCFlBvoPqKpJKye3egZGqn6oR/preGIaEoRWr8dIKimAAvmyW4MaPIudgz9BOQfR
         ZqnY1AZmFoV5l7GKTHSvomDOUB1ae/mB5yz08si8lnJfX7YbH6a5gAkZc/GP9JoGSDJc
         1GmA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Christopher James Halse Rogers <christopher.halse.rogers@canonical.com>,
	amd-gfx@lists.freedesktop.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 33/68] drm/radeon: Fail fb creation from imported dma-bufs.
Date: Mon, 19 Mar 2018 19:06:11 +0100
Message-Id: <20180319171832.433485054@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390568975323259?=
X-GMAIL-MSGID: =?utf-8?q?1595390568975323259?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christopher James Halse Rogers <christopher.halse.rogers@canonical.com>


[ Upstream commit a294043b2fbd8de69d161457ed0c7a4026bbfa5a ]

Any use of the framebuffer will migrate it to VRAM, which is not sensible for
an imported dma-buf.

v2: Use DRM_DEBUG_KMS to prevent userspace accidentally spamming dmesg.

Reviewed-by: Michel Dänzer <michel.daenzer@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Christopher James Halse Rogers <christopher.halse.rogers@canonical.com>
CC: amd-gfx@lists.freedesktop.org
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/radeon/radeon_display.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -1320,6 +1320,12 @@ radeon_user_framebuffer_create(struct dr
 		return ERR_PTR(-ENOENT);
 	}
 
+	/* Handle is imported dma-buf, so cannot be migrated to VRAM for scanout */
+	if (obj->import_attach) {
+		DRM_DEBUG_KMS("Cannot create framebuffer from imported dma_buf\n");
+		return ERR_PTR(-EINVAL);
+	}
+
 	radeon_fb = kzalloc(sizeof(*radeon_fb), GFP_KERNEL);
 	if (radeon_fb == NULL) {
 		drm_gem_object_unreference_unlocked(obj);
