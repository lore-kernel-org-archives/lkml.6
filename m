Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtwJ/TCbTTsmn0OsDHyimgScKx7D3BdQnOoGdUbnLP4/1ugx3o9aXHexPd9T8G3VIdz75gZ
ARC-Seal: i=1; a=rsa-sha256; t=1520954947; cv=none;
        d=google.com; s=arc-20160816;
        b=MtNI3VuHfmjNVLswSv1TCkRjhWn0CEmm+gPTPoeHd0YqYFdOfAAkkQnuZpC9/sxWGR
         VvxTY5KDtsPwPipYPz62YQRQByOLVtN4oM131nyaP3Wp6VVIjDGXcqIMom2/JiabuGg9
         fd0mudFycJd9V1XhT/qsgeULQSntyAbGyjk+onkoXL7V6u8pB4wcdDdUWUlSdGvV+ljN
         etkHWKBx3kPEz/lF2EahFBG4DC0qGh1y1TEDUQJ70hBFuSPNja06USj3JmIiY0UKtsvc
         ucfI+cjrJY11lQoJBrpGtXfZwMzoayHAahKVwgJMxzhUyRm15Aq1OrpJSulnCR3S7Lpm
         KfGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3r4OWjtImDiUKQWspHucPsEortBFI2toMeigr7Y5K/E=;
        b=SE24JjIWsIxoaH5H+2Sb0dCi99jMNN0oippTdoXnSpHBJw6z5n5spxXU2C5qrxybay
         3G+C4xixn4sHehbjY1YCtBEzC1NF/Cf/WA1Vk7B5/0SvgGVzBxN12mp27DYY91n5T765
         6ZBM4QlM114vrVOpk1j4VDh7s6C3RkOGTyrvq2EYJ09qnSvZ62B/0uSzbOz2sac8Sg/c
         x/X/RZZ+EYYgvtwWaVQeJNyZp30sULzkdneahDaTfc/57pVbj9vkhKKh/x5zNHx5OqLy
         p6YYq390Tv7Jx7/aXVzUhrFs0MPxjRwzh//MEp/r2o6MV2rVnSy5JxfC26tEjPSIwtfA
         MgvA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.15 036/146] drm/amdgpu: fix KV harvesting
Date: Tue, 13 Mar 2018 16:23:23 +0100
Message-Id: <20180313152323.326840298@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836854498238630?=
X-GMAIL-MSGID: =?utf-8?q?1594836854498238630?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit 545b0bcde7fbd3ee408fa842ea0731451dc4bd0a upstream.

Always set the graphics values to the max for the
asic type.  E.g., some 1 RB chips are actually 1 RB chips,
others are actually harvested 2 RB chips.

Fixes: https://bugs.freedesktop.org/show_bug.cgi?id=99353
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c |   30 ++----------------------------
 1 file changed, 2 insertions(+), 28 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4403,34 +4403,8 @@ static void gfx_v7_0_gpu_early_init(stru
 	case CHIP_KAVERI:
 		adev->gfx.config.max_shader_engines = 1;
 		adev->gfx.config.max_tile_pipes = 4;
-		if ((adev->pdev->device == 0x1304) ||
-		    (adev->pdev->device == 0x1305) ||
-		    (adev->pdev->device == 0x130C) ||
-		    (adev->pdev->device == 0x130F) ||
-		    (adev->pdev->device == 0x1310) ||
-		    (adev->pdev->device == 0x1311) ||
-		    (adev->pdev->device == 0x131C)) {
-			adev->gfx.config.max_cu_per_sh = 8;
-			adev->gfx.config.max_backends_per_se = 2;
-		} else if ((adev->pdev->device == 0x1309) ||
-			   (adev->pdev->device == 0x130A) ||
-			   (adev->pdev->device == 0x130D) ||
-			   (adev->pdev->device == 0x1313) ||
-			   (adev->pdev->device == 0x131D)) {
-			adev->gfx.config.max_cu_per_sh = 6;
-			adev->gfx.config.max_backends_per_se = 2;
-		} else if ((adev->pdev->device == 0x1306) ||
-			   (adev->pdev->device == 0x1307) ||
-			   (adev->pdev->device == 0x130B) ||
-			   (adev->pdev->device == 0x130E) ||
-			   (adev->pdev->device == 0x1315) ||
-			   (adev->pdev->device == 0x131B)) {
-			adev->gfx.config.max_cu_per_sh = 4;
-			adev->gfx.config.max_backends_per_se = 1;
-		} else {
-			adev->gfx.config.max_cu_per_sh = 3;
-			adev->gfx.config.max_backends_per_se = 1;
-		}
+		adev->gfx.config.max_cu_per_sh = 8;
+		adev->gfx.config.max_backends_per_se = 2;
 		adev->gfx.config.max_sh_per_se = 1;
 		adev->gfx.config.max_texture_channel_caches = 4;
 		adev->gfx.config.max_gprs = 256;
