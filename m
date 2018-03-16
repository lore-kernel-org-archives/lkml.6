Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsO+8SOqwoHvz6pOIHY7PUL1kUXkcW3jG4U6PKBEyfNsBjmESGz8ANgFuQ4dsFQoXPjwFwE
ARC-Seal: i=1; a=rsa-sha256; t=1521214302; cv=none;
        d=google.com; s=arc-20160816;
        b=kT7xSTfzr+TzoC2udR0ysTnuVDe7EyWsHBNUwoGI0x2aZ0BJ6KB0ZmRSpD/UI82SHg
         BD4cGGNV5pFiwU1Vkk9jytWkd2rRwQy5NaLP3ZSvLSXHD3LvO6F+S684siBSa5tslF8B
         HmsgqymduDk+XfFEpMBr8kmbFjhKfIrfchJvlxsJB38FUZl8FL43kCltyVTeTOb+cuiW
         MLdRD+7CyTxBVt7vrSS2f1jMz4rtXScrotBZEtxjuzzxUFvVM4P9k4c38iyvh/WSby07
         mu3NEg5fgtg2TzzAqCexYo/phFQ5ZMTxTalHPqUg6pOvf1ryfa7eHJEdrjpj3ChBwS4g
         LoeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=txC+v43bK5NGyt1r7RBe2J4VdGGN5vHd3fOSWWhkSRc=;
        b=Fcw3s9RTrSm5O8r6MMFxj5XSxydciqLejUNgPjB+ATCtOymEA+3J3dL2yexdfVH+gT
         93XzOct8OPq2GKBy84tBHGgZMdbh8ouR8kts3IlxndCUtdsrktGtTWLopoLsadszfZEb
         kGpejMVLnNoSOPxqwCsBI/PN3ImXJZw5peaYZ+h8LkIHujWzUKZm3hGjTzFKIQTZ4/1u
         y6cqycGo4eEX6psodnNdo9hPN4XcilSbc/1RMTUXBMskwf3Wql0Zjiao/oC75pEss/r0
         Npj764zXw9CX2Zd6/3vU0zU8xkvc/v+t/qRXQunAh1YeTFfSeCrRq3h2qaKWwMzvDgqu
         RGwQ==
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
Subject: [PATCH 4.9 14/86] drm/amdgpu: fix KV harvesting
Date: Fri, 16 Mar 2018 16:22:37 +0100
Message-Id: <20180316152318.237997308@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108594475030018?=
X-GMAIL-MSGID: =?utf-8?q?1595108808292569847?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4475,34 +4475,8 @@ static void gfx_v7_0_gpu_early_init(stru
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
