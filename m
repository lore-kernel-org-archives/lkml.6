Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtVeG6ioGDhxgKGFEtZRKpp5ZQRRec+Cx9V+HEJnJwsA1HsNC4ZMct4CQ199Tnpf+4b1/ZX
ARC-Seal: i=1; a=rsa-sha256; t=1520955509; cv=none;
        d=google.com; s=arc-20160816;
        b=jUq1OUViYJYT1kUxhnhX6Wj6o10Se+bwaLGa8zfSeARqCWxzRaJoavlln+60iEkCB8
         NXVd54l4v/PhXxwoZ02H9kzoV8RRTaNWgh379EPHrh8RSX+XodGpyMvnFuT0a9uoKlSN
         oxXwXESkgshAWv3n4AxljJNANARS7+GE5m7PLjWY740k3p5D3CXiOjszaDnGc5RawKmi
         XiD3UxxfDWjhM7QP6ZqHgh63GuZJ84P/l64Juj+LVT3APJn6WNgqvhhOMD82/bY1pyWM
         QLyxLG28GR8+XeES5W5NJ3MgR3PmLEZtyLj8iiWP188iZ7FXMbrxv/m6OsYmyUEpiqEP
         XXEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VmRdVNzjygVn/BNnncTGZNSzxTMkfiO+a3j5KGGAP0Y=;
        b=LJbzIiEEf0KJAbbIfQlcM41P/8y3pJGSlhvFxW9vL1Gf9RM08EPxqh3F/Yeb8qaAXZ
         4+/2LKWWy6T81bt0+5YbB52j/yr/7HLKNexKCH0V8DI3R7hrLTijF7iAEJPhmXzPSnzf
         QQwqHNBNd5z1todIgw6pBxxM2w5aTjGCDBEtsJ8wtb81ghwSeahZg7vrO+sqqNpa97cD
         QDucirIUfl8FYKdUzedwwiYxvXEapZY0u+idShkmnvvbt5ynMN6pCdxeYaZvHHK55IXC
         zbsWtRxuevm7G2lDHyXrPepWT68ex80vw2pykiI1UAWjuRFDKZxEmE0GN1nKeWu05g0c
         M1AA==
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
Subject: [PATCH 4.14 074/140] drm/radeon: fix KV harvesting
Date: Tue, 13 Mar 2018 16:24:37 +0100
Message-Id: <20180313152503.140850095@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836850293387341?=
X-GMAIL-MSGID: =?utf-8?q?1594837444174274197?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3229,35 +3229,8 @@ static void cik_gpu_init(struct radeon_d
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
