Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvPAYyX6qEnCsV4b9tRmoWnpU+IsGlTL2lTk6cQELxhSzFGweAldXt3hUsvE2OJGwEKRwSp
ARC-Seal: i=1; a=rsa-sha256; t=1520954928; cv=none;
        d=google.com; s=arc-20160816;
        b=GQdADGKzB9flTt032zbpoTR2ffdVLS9b0+B98bwL5LuydnmgSP/qUZzBXweXAMlNlR
         gHY3BAxo2zoXaC5PuuKhQxnCPz1j/xzfvG/kCff3SjejALY/PSnnTkaSklrLsFiOiTXy
         Xjwu5IKSA1MYg7EvH965GrT7DOmyj/p87SkfJf2lYwim1ysa5COntcSur8sbR9m6ejBQ
         hF5XzfXlv305Hli0uAzIYPDO4cgbqVayWYl5EQlZ5ZkPGE4z3eAcCZlL+VeDq83S0OXj
         1bPR8R2BspVGDYNLkB0Jh0F5WEZ8oAwrpua2H/1V2zESfQOk/znyuYGP9Om2777+P50g
         903g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8f6cEdSE+UJOL3IXap5+MXQMull7ajfKp5kM/T4Lqo0=;
        b=Nd3qGxB6gZQ/DtILfbmEPlBZJ0nL1EdoaoKERs0Rga0PdTd6YTXlOR0xhYv/kVIs3C
         z1Hu0q8LnjlTrzrg1kTjCSeIdggQSw//1KKWdw8/VTaNFzgRjVjO+cRcJhMxurtyGbI0
         xvxa/J8Ml/T9YwqMNgfp9ScKdjYLui8O4S7Fxle/746qqendtaxh8xD72eO+6LPQ+FBK
         0uvHJLL4uAZd7czG91ATC8GuLEeb5hwW6MwCmj2zj1BuuiHaf8Hy/9pkGHg+Hlo1KqIq
         5YMPKVRy5R9gsYNb7xGa1GnOtKJcHugTfCtdUsQbFKUtRKm/41fUuBUBQsXGzMNq7qZT
         6dnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Huang <JinHuiEric.Huang@amd.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.15 031/146] drm/amd/powerplay: fix power over limit on Fiji
Date: Tue, 13 Mar 2018 16:23:18 +0100
Message-Id: <20180313152322.932778684@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836835121599975?=
X-GMAIL-MSGID: =?utf-8?q?1594836835121599975?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Huang <JinHuiEric.Huang@amd.com>

commit a0aaa03062be252aacad60a776f3374dd53e3f98 upstream.

power containment disabled only on Fiji and compute
power profile. It violates PCIe spec and may cause power
supply failed. Enabling it will fix the issue, even the
fix will drop performance of some compute tests.

Signed-off-by: Eric Huang <JinHuiEric.Huang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c |    7 -------
 1 file changed, 7 deletions(-)

--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -4572,13 +4572,6 @@ static int smu7_set_power_profile_state(
 	int tmp_result, result = 0;
 	uint32_t sclk_mask = 0, mclk_mask = 0;
 
-	if (hwmgr->chip_id == CHIP_FIJI) {
-		if (request->type == AMD_PP_GFX_PROFILE)
-			smu7_enable_power_containment(hwmgr);
-		else if (request->type == AMD_PP_COMPUTE_PROFILE)
-			smu7_disable_power_containment(hwmgr);
-	}
-
 	if (hwmgr->dpm_level != AMD_DPM_FORCED_LEVEL_AUTO)
 		return -EINVAL;
 
