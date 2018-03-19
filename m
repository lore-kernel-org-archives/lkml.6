Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtXcNXPO4uaM0ArJcyqtGUzNy6hZur1NiqxExkld2ShQZm4sOHsqJRXGLFUdrWEwBqiHjMk
ARC-Seal: i=1; a=rsa-sha256; t=1521483263; cv=none;
        d=google.com; s=arc-20160816;
        b=O/VX6yoboZJBE2Ld7tDmaCJQmIOTkx9RbZ0p5cFrNyqrNfLVEaqK1umj1VhR7pxUWk
         p4d0x0hZ7+HKZdBPA3EtHbBaUNQoHcwBrc96mXkhqwH8SnCTO3VrZHixrdpd+YfkZGO4
         /B8iIsDrF5A5h7K7RMmZKzrhCCxeOAQb/kwQtY/FXhllYdqU4jf7Po89YHtPF8siYeQc
         HpZR0yhDFM895mwIUBt/GukmUnKlBw0FFaPy2CqAGgXY4VGsNhYIsxAStUuLT5LdAmgE
         yq/55qFKxLNpUiaZ1xzQcP/i32pdqS3CORIzRC7fk5ajZCzQFEtXlaC73SendzBUg3it
         lBXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dRkSMllYxYK1eWVXRKBf1+6IN+6j9u/9s924vZk2zgs=;
        b=0fqDIUcUOLMjRliOSwnwwjiXLJKbfTPdbSPhRTMyntCqd+WNBNhe1nS9/nlFoSLll1
         9v26JwzUvkFJuwHLvCH1HJFTQ1y3dmsv7G5m51uHK+jP8M/RDmWKr1XjBNlh7OLnGk6U
         B4ONlFo1Dn/SWuo8cPFbL5VAaP+ZJOPUGx8/Yn5Qnx4payUHRoTWgHPfdJMkbyfT1MXb
         jSEJvoTsWGhb1tYmW+yzFjHsOfjaM+dfE5Un988qYHDBdgfdaYISvR7I3Qz5RIixAOD/
         ZamB7F6sXXcJAhiLxWG7OHjXpHw9C3jH2zoJdF3e6AV0BRxN64wfXBfmEzsNX5itRYKp
         utCg==
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
Subject: [PATCH 4.4 059/134] drm/radeon: Fail fb creation from imported dma-bufs.
Date: Mon, 19 Mar 2018 19:05:42 +0100
Message-Id: <20180319171857.843350088@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390568975323259?=
X-GMAIL-MSGID: =?utf-8?q?1595390834918545494?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1374,6 +1374,12 @@ radeon_user_framebuffer_create(struct dr
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
