Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuq/z29NtjqvI09Kf+MjJcwIfK+uDvXKwyB5PQCwn7I1Se+5old00QJo0gjL6i1Q7eSTkGt
ARC-Seal: i=1; a=rsa-sha256; t=1521483799; cv=none;
        d=google.com; s=arc-20160816;
        b=onVwQrfOfrz0623V1K90p6R1U6BJiyD892Tp2OBfy0V9dHw8zQl8iM5QCdK8HfHQRV
         Z1Pe/UrqGRsP3Nk9ZIMX4pH/MxMbNL0l9sKUKYPe8dRgD+XLHS8VU+3DH1W7CBjGgvwv
         faOgrVR4AVU5OOLTKkFMEh546G8svwzzMaJiT8dF8YeUbXCX2Oz9lFup1Fz6W6IPQGfh
         MVDEXWGDE/aRF358scYXHs58M1GTb/n1Xu3PlS2WEwLzwt+RUQkiNDU6ZE7xNaGvMDLF
         Bm2qGMyzTWKNeTI0yBH1k1qvEcti67ok5pvTo6WozD4DPTidgm2bjI2YUzrXKPyMKQdj
         8XVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=whYHpsAcbCHlX/uDBv5u1NtWlK/cH3LRVM2QYguc2qA=;
        b=mIRca4Y/3ti9IiAK8BMiQSGnpk2YfPk1Cs4X5E6NlsTG3uhwkupUJqjc2EnXqWok07
         45BmWYVDkVH7m3SLv3hyb/i1NCWZg1/hrng77m9jWJGUPJpsAzR6/10OlmKym6YPz3J6
         EisqQ6kiGTqOwAzYvLPbhL8Y6om3uFHRNsIqDoXpCooA+yXnUjP92XiofFS9rQVUskEd
         lJEkYX8+qRbaXVTe0Y/kNGQyzTSsh1Df4chFa7Xz1vsvIdGyeUgmDZ3LsDwPfxRvy2O/
         uTBdt9F3vjjk5ErfWd+fYcEyu4q0NpXMI3Aow2m+SR8D5YfUH8pur61UnCMY71TNnzPs
         Mi4Q==
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
Subject: [PATCH 4.9 121/241] drm/radeon: Fail fb creation from imported dma-bufs.
Date: Mon, 19 Mar 2018 19:06:26 +0100
Message-Id: <20180319180756.211122225@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390568975323259?=
X-GMAIL-MSGID: =?utf-8?q?1595391397114607257?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1352,6 +1352,12 @@ radeon_user_framebuffer_create(struct dr
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
