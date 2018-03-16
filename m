Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuekAaum/51YYA3rCnsDeRR/6wKsAd4nRKPfre4KlAZnCBHq4rbU/ojF5SedUxFeW9Kcvdp
ARC-Seal: i=1; a=rsa-sha256; t=1521214299; cv=none;
        d=google.com; s=arc-20160816;
        b=pVRJZMh3ry4QkxLgDm0+o+RGK5MLGiaqX8UgkSf0yC96ejNn9JT0uo7hVq6RqMYDi8
         0aKVtVMIrCmpIMzwHWVxwxPeCxGBmPKBA/+rzCf06yL7KBCytU4fFefmeDbSvrh58cK9
         D2IqzEekJvml/MGlKeyRP7lwMbMf3Pohrdy+M+2R5m4ghXJPafHWlTqNdAbyAclfTYRN
         rNd9pWkihLJOtHBWJF6lXbHVdV9WwwNrvScCPPaEnwoeJnf/tKnfsIV6n82HeHdJh6ma
         W4VP5vGki7adM2gPHQy8ZysPN4RmPXJ6YHE/9H+ZxFF4/RjV7rE0NCtO/3ZNHm6xVfpo
         tFig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2XnRbIoP+g2MGYzp2JWpCQ4+uQvZxWfC9HA+MJJv4ok=;
        b=0bgg2Dgwe8TiLox5WxiJtk7YQA4F1N8SWqjHbpw+L8D/Jx0LaLvR6x5/KEr/POLX1z
         m3wApgZm1AF5OR5B7MJpBzqA8f3iVHwE0tSFJFQ07WXbu1mcOPJcDrXaj/ToyAtrCAd/
         oDR+ceP/a4SzVju4mWVIcWm9waPgIz2XXzZ/m6ODsoPa11eDtau38PGSoJhmzKBF+8sx
         QQg8RvCvGbaGC4sLorYpgjfxsEDK9Qho1ldUjvgDwp+/cZ67+mMukWqduhigeJ4m2PUA
         aRlRwSZ/YRB3h5yb3bqTdFnBJ71tJqXG3Q+CkghCSDMoxFlPIXwgWwAgPMeZGHArljT2
         kIMQ==
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
Subject: [PATCH 4.9 13/86] drm/radeon: fix KV harvesting
Date: Fri, 16 Mar 2018 16:22:36 +0100
Message-Id: <20180316152318.181357017@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108561510314044?=
X-GMAIL-MSGID: =?utf-8?q?1595108805824503758?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit 0b58d90f89545e021d188c289fa142e5ff9e708b upstream.

Always set the graphics values to the max for the
asic type.  E.g., some 1 RB chips are actually 1 RB chips,
others are actually harvested 2 RB chips.

Fixes: https://bugs.freedesktop.org/show_bug.cgi?id=99353
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/radeon/cik.c |   31 ++-----------------------------
 1 file changed, 2 insertions(+), 29 deletions(-)

--- a/drivers/gpu/drm/radeon/cik.c
+++ b/drivers/gpu/drm/radeon/cik.c
@@ -3244,35 +3244,8 @@ static void cik_gpu_init(struct radeon_d
 	case CHIP_KAVERI:
 		rdev->config.cik.max_shader_engines = 1;
 		rdev->config.cik.max_tile_pipes = 4;
-		if ((rdev->pdev->device == 0x1304) ||
-		    (rdev->pdev->device == 0x1305) ||
-		    (rdev->pdev->device == 0x130C) ||
-		    (rdev->pdev->device == 0x130F) ||
-		    (rdev->pdev->device == 0x1310) ||
-		    (rdev->pdev->device == 0x1311) ||
-		    (rdev->pdev->device == 0x131C)) {
-			rdev->config.cik.max_cu_per_sh = 8;
-			rdev->config.cik.max_backends_per_se = 2;
-		} else if ((rdev->pdev->device == 0x1309) ||
-			   (rdev->pdev->device == 0x130A) ||
-			   (rdev->pdev->device == 0x130D) ||
-			   (rdev->pdev->device == 0x1313) ||
-			   (rdev->pdev->device == 0x131D)) {
-			rdev->config.cik.max_cu_per_sh = 6;
-			rdev->config.cik.max_backends_per_se = 2;
-		} else if ((rdev->pdev->device == 0x1306) ||
-			   (rdev->pdev->device == 0x1307) ||
-			   (rdev->pdev->device == 0x130B) ||
-			   (rdev->pdev->device == 0x130E) ||
-			   (rdev->pdev->device == 0x1315) ||
-			   (rdev->pdev->device == 0x1318) ||
-			   (rdev->pdev->device == 0x131B)) {
-			rdev->config.cik.max_cu_per_sh = 4;
-			rdev->config.cik.max_backends_per_se = 1;
-		} else {
-			rdev->config.cik.max_cu_per_sh = 3;
-			rdev->config.cik.max_backends_per_se = 1;
-		}
+		rdev->config.cik.max_cu_per_sh = 8;
+		rdev->config.cik.max_backends_per_se = 2;
 		rdev->config.cik.max_sh_per_se = 1;
 		rdev->config.cik.max_texture_channel_caches = 4;
 		rdev->config.cik.max_gprs = 256;
