Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvAlwH8CBMnJ5QwG6BX/denELotLyoYHRAL+xStkFyQv5aD4cFv30OSK/MCpVgZoiVFA6zx
ARC-Seal: i=1; a=rsa-sha256; t=1520954943; cv=none;
        d=google.com; s=arc-20160816;
        b=HbYgslfz+ifY7E9VjChBHHbED+IKTN8efAb68pZA8zPZMm+NsxQivF9DFlT3FjM+A8
         I0yON2tjk6e9MWfctcKC57fFJJRcQWwlo6KysHz6KiaOtpic1hJBTGTCHgOX/mMiHcZZ
         KwunU5duhGWW2NQoyij1VmxXuzpQY1vVpDvww6fh6Hbm+pdu7csq3PGKC35yGlQlx+3I
         de/6TUuiYzDA5+m3fS87b8hTOY1a5ntVfcMlMXBnzpWBYur5Q2tb9X+MgHI3BYNZsMoW
         sIRbebIXfcmnUozfFyuQNUUkjDB/FwT23lv7oAIdDyISOFcUyNM5ZFlw+Z+8BeJ2/nCq
         K6ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MRl8tfo0n1M+PN788a2bh/nnjKwinOZ8COuk0B2ttJQ=;
        b=jFLSkQ4mbOZBfFbnGjgKS0CZT6cr2V0uZuX163dPytdf+CFLRX/dWav0HMc20gs2PV
         1Bo/Xa13G5M0Jgy1znra0ABrhfWXIMBTqTFg/SEgW0RZ4+Mi/fJh8qyRU6iyKFKxBVu8
         RwFdFPBi7PIJgTZZkGuplq3lb4KAyHKYRbT40PpA8hFnYZwEBDeyJ6G4xLohPDplXETY
         0LDPV2O2kyunrgz+JSNbQzECcnVNlToHuTpSQuoj36f3EqpVGO46AvRztYNrx7ER08Rx
         aOJzz4BwrcGTWU+8WSV1brgBIqwNfwDbPQ7TW6SzR0NlPCLftDv+WgFJWi2AQnxSn+VO
         EBMQ==
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
Subject: [PATCH 4.15 035/146] drm/radeon: fix KV harvesting
Date: Tue, 13 Mar 2018 16:23:22 +0100
Message-Id: <20180313152323.259192103@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836850293387341?=
X-GMAIL-MSGID: =?utf-8?q?1594836850293387341?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3228,35 +3228,8 @@ static void cik_gpu_init(struct radeon_d
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
