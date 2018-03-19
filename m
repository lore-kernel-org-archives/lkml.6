Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELscHeAjASK2iJLXI0uiuE0rFV3XWlMIPP6ko8KbHKs/Ftfj+OjnjmOumMJi8w7nl4XvpdVN
ARC-Seal: i=1; a=rsa-sha256; t=1521483802; cv=none;
        d=google.com; s=arc-20160816;
        b=byUPogmQBNmF/vcTnsQapAIgrY2SUbDeVAF1RTdDk/8bARwCmnPATFyjxNP2hEVufx
         JjzhCxJ276FUjSw5Ef+PDW9oiVYdrotHNqDnx0K18CDLJWj7qLXC29+eFUj8GSqWfNtN
         Zm7S3h7dwRnizztxqOZJrUeQeQTbTVVkIjwOvX9JIFmQt2zRMJhSfre1rVDzpr13aijV
         aroFEc9zi/TI5U/QIgM4HnT/Dr93F3eKaRrOSfHzHIke0zDj3ST+yTdQ26ywqSUC1Wbl
         mQrY0EcoROWatvbhSOym7IHA6KvV26csnJ+xMvC6XP/I9VNawMO+Ww6ikA1OPGV2jAXt
         SSew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=z0O9phKlOl7QOPQvEH/7KZqXtPV12j1vDqJ9e1hdTKI=;
        b=BZ+Q126AfJ6D3ywcUn7O7Q9DyArS00AuAGjMCKe+qIz5pyG4JHSMDRvtrnsvh+kyMD
         EnT+I39i6p+p1poLSVcpFhuSVGiYtc75XuGltaNNczwgK4na30wQcjkoRAjxAw2PTSdm
         hjQNFWBllk2sgjX4DICuU13zcyBza0tH2FuwYfLWh9CjSUtH9hkwKqbwsrc1xO6lqdHM
         3MEe1QbbHh8+ZcQsGS7CHH4lrJ0LKwtX72OBA067XI3K4iyvd/ETVbK7AyZ+hnzQBxuM
         Z+cFq8HXj+ydwnDWwWkwbxx291LZxizcrZ9hEWu0D893b3ZO99dToNHuxdC3wk9t6GPD
         aDNA==
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
Subject: [PATCH 4.9 122/241] drm/amdgpu: Fail fb creation from imported dma-bufs. (v2)
Date: Mon, 19 Mar 2018 19:06:27 +0100
Message-Id: <20180319180756.257022623@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390837447532927?=
X-GMAIL-MSGID: =?utf-8?q?1595391399768905419?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christopher James Halse Rogers <christopher.halse.rogers@canonical.com>


[ Upstream commit 1769152ac64b0b07583f696b621624df2ca4c840 ]

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
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -533,6 +533,12 @@ amdgpu_user_framebuffer_create(struct dr
 		return ERR_PTR(-ENOENT);
 	}
 
+	/* Handle is imported dma-buf, so cannot be migrated to VRAM for scanout */
+	if (obj->import_attach) {
+		DRM_DEBUG_KMS("Cannot create framebuffer from imported dma_buf\n");
+		return ERR_PTR(-EINVAL);
+	}
+
 	amdgpu_fb = kzalloc(sizeof(*amdgpu_fb), GFP_KERNEL);
 	if (amdgpu_fb == NULL) {
 		drm_gem_object_unreference_unlocked(obj);
