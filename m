Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuRV9h9DvkKX/waySTEwbvZ0OVqZ9W5WFCvMz1p9KhwUL/2baCAGqQtRGrcn1K7L/oD9lGK
ARC-Seal: i=1; a=rsa-sha256; t=1520955512; cv=none;
        d=google.com; s=arc-20160816;
        b=mMGtUq3INFhIC3gu2D5uMYyBzX4/fugwm7Du3+xuYYXlr0YzxwEI4kZupyE9AeTaIZ
         hy4dS1v8KTmxcOgrMqcUoMFamyk0l8D1yuqinoRofR9+SHY72/zJUkWJcDj76pfE4E39
         iBzWD8Eo7vH8fyt+nhWhJXPtgMyoMStXMhN+jfnDjQ3y6f3RR/15T1/b5acL7jg4hz3x
         v+g2zMRIHQQhJ3wIiBf4ddjjLZCTZt+EcEcVn7HDWFvdJ62iuI+5zdCnYuy6k4jPHbsT
         ivOxrgM00/iS+Y/PUzOX2BIyLl+wENru0y8Qnpj0YGP8kwApIHXpbr5FLV9S6pw7FdoF
         2yFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TMOFNny6J9zmWmWRuxEjqEPhqP5Dkn6zyWw7FtuRD0A=;
        b=HL5AMajgN0Ojr48NdXArppmMaupWTZxnPT+EIBU4JuIJ300hZmayf/TFfLavx1Jreq
         zrlvp8uLbx+R5qgpGvWqxcY8kXiRP8LsffrdH4Y6L9c5i3WZXmSsOSKT1CHJDFsYbK6w
         qWG6vFc6Fb7NYQ8Zqg7bJ6QtwcD3PDmCKQP4lytc/9BSc6wjph35pLNCuk8tO17Kr3/k
         90f9uL4AGziJo/yZ53rlrLIS2eXaYz/3B/P7DpvWTJ5THpZ+/n0VGb6B9k7keI7/LIJy
         4R/ACvqObgQSIMhLgJKDjclNZ/NGYGAuRsAebCGRMKHtK8jhyIAkrqE2FlKfZWbHuZi8
         V9cw==
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
Subject: [PATCH 4.14 075/140] drm/amdgpu: fix KV harvesting
Date: Tue, 13 Mar 2018 16:24:38 +0100
Message-Id: <20180313152503.211616751@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836854498238630?=
X-GMAIL-MSGID: =?utf-8?q?1594837447738611631?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4387,34 +4387,8 @@ static void gfx_v7_0_gpu_early_init(stru
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
