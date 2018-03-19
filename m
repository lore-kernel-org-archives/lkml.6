Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsKQwEPmnzbxHO7n97t8lu9dCr2UZqmnm2ccnZt4dIvpgHoaFNkW4k36bWbwK2k8IgzByZ9
ARC-Seal: i=1; a=rsa-sha256; t=1521483266; cv=none;
        d=google.com; s=arc-20160816;
        b=s29BlxjiZ80uSh9wQp27CN3z0WlndfsNwB+zrq4nRDsE/zKd2/rKOAFujK94UjRyrf
         aODuGAFvQ9IKOFcUiMAewsvAe/oox5OEbwMNUyhfco6DRz/xQmj2Dcrd2nacWPsV7fAl
         aIJZ7Ag+SZCgRYC1T4T7eERZA0AsJq2LG8VeGN/yS2hh0WzjgMoYq54JRPp5G/9AqvDf
         VLTGlgdkX3AQu1sarFVkGiLvEtyHTDdqyxDzQeB6Wgid+4sqKFPTDdijO8ZA4YVwyB+k
         PJXjpoEAa3GL5ZDcJFTxSdTXQvhiQtmhIsmr455TV0pxd9bP4pXrOBiJ2BERVkpZ0ig+
         ny2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LmAkflzbJ0qvR5NEINntMtlB5LOaeYegx8eDPOProD8=;
        b=oHB5hCtJ57k5v2YkJycCAhE3hNi1QpGZ0PYlpL6WXtA+I0+886zYSGu6sL6PW8aulB
         YdL2ZMOovsAuup8+paAKIuqpYo9NeY2ZHzaLxmQTDCpn3KvX3eQQ+6n0bc2gj7U3QLJq
         MP+Mw9FoqlbWkTQAXl2qXIl53O00V5Pgs+7qVrEExM/Goc6gRdTGD4kB04+ZkxSrhhDG
         d2xiyc6/wy3MxQrKqcO/6fv5LMbLb0q7K+4XVNkxEex/51Q6YxJCmE8A/z8UfrTwvBhL
         R3pXtyCfZds7ekIz6R8h89j4rqfs50fxw7OFhTdLiatxgU3HazqdmV9Kyq3UUo5uvUsy
         j32A==
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
Subject: [PATCH 4.4 060/134] drm/amdgpu: Fail fb creation from imported dma-bufs. (v2)
Date: Mon, 19 Mar 2018 19:05:43 +0100
Message-Id: <20180319171857.980738204@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390837447532927?=
X-GMAIL-MSGID: =?utf-8?q?1595390837447532927?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -560,6 +560,12 @@ amdgpu_user_framebuffer_create(struct dr
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
