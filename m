Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvnrhBVHPWSCZSc5ggt1ELw8UOivmwviLuAxW6IAxvrrFnYgkLTTrjGksBpbfkKqT6qjwFV
ARC-Seal: i=1; a=rsa-sha256; t=1521214097; cv=none;
        d=google.com; s=arc-20160816;
        b=KYxhY9nfhvY4etfWKS8QWvMdnswHyHhyE92qN3wYBTT1dU+fb2NsnsSPu2BIJdws8I
         ubMkk3ibB1fnopqklgIcWiUt1KHchOinCvzE9Hkm5k7kTV8Q497oIglbDve9okhPqyyK
         UEBlh9AVB1NRiEA3ho4nEmBqNEVyYKElz4rd2jzGJA6IubWm50XTNT3p1olvHDhd80Mk
         xVjs6qSvbVzz2pCvdlSNGsoORA8cZazFpINZKtrBMAerdPK4oyh+bgxT3c4t0KQRBaYc
         D/SkOpf4pUuinhO/Sj+cEgDj1IjlTV8bNy+Fdpam2Yc5mc+FZcIi4KU5epeeBirGj53H
         6Yyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=B4gkG41waqlhJ9Shi21J2mX4oWvyIbKHHoUN2QADbwQ=;
        b=K4//JKE4sQsno2MhMksXesP3AJzl2W2+BQ3c8WahlnM5tonpyHw3nUpJhGi1vjTGSD
         7kcdXVXbF23CTN21ewWPsD55An1ogA99VChQE7tD9F5dJ1LivcMSf3KYWvOb/vQ31frY
         J3lrrk8Ww11sOJPg9DheM7lrq4W7e41aUG/vJsSVF3KzYlmX6A9B3HMpsw/4WvMThAYE
         EE4ptx1ypX8wUjO8TFVMgUV2JisfJ621QVHb9qGLZGQ459w6ndF/FhX+bh6mZcF8r57O
         EFgkzm2BNA0g7Wrj06kQ1c1Gh7zhu7y69VJVNvKliHqRBNGGD7w+Sy+ZaKLEwsSu2BRq
         1zjA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.4 12/63] drm/amdgpu: fix KV harvesting
Date: Fri, 16 Mar 2018 16:22:44 +0100
Message-Id: <20180316152301.428011454@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108594475030018?=
X-GMAIL-MSGID: =?utf-8?q?1595108594475030018?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2104,34 +2104,8 @@ static void gfx_v7_0_gpu_init(struct amd
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
