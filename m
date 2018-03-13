Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu0V+3bfCqUnYtHE590bW0QoVHs6h923wcEwn0VHTf1WDW5RNSYlwtjsUFXj9ZgnNcnbO71
ARC-Seal: i=1; a=rsa-sha256; t=1520955492; cv=none;
        d=google.com; s=arc-20160816;
        b=KOT4XSG6MiFo311+EglvVWT7FXdB3qjvPrU4duR2KaKccKFWxu9rhj+AkQyWwRfxbg
         kh6S0DEJwrlRDJ3l2ExDP1Q0hrw+0VIShRdsQYcrUxFqghVHEnFQsITGLyZiND+TJlkQ
         6dZVpVRKgBSFYf68sSxifbgMdlvVNzUOdzsiuoe7ezunBYtb1iGIereUzhi1dJLBp6KH
         VNuxhIQCeVUjULn44/hwWLagvvwT4yL3PcL4WglTNk5VMRT/KuRLOhi8DPD+7a1DW2Gx
         qSOFrrVGQCgTzrF5u6IuFwSKiNACCmNxQPnHDFtwm5oYiJ0J7zPaitFchq+D5qHrjiRH
         vdQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HSLInpdMuRRZEfWvTZy0iWAesYqFPqsXjbGBbhQ35ZE=;
        b=F9nBVQCp3dRAq0bDQNeQEsCEh30gbgFnijgCnHUal2AjE1+CWOOJdXJ+IchC7iz7eh
         7xmrts43pjm9ItHRWFYsU06pDQJaulEI+vPSyPlfiDMmuvWqgFTeHhNjMXf78IAJMMGW
         T20C3eLsVFGkt4N1L2FmDjz9YuQDqJ39tstRLqBs+EDAIxVgHtdFhK2F1TLZqWcsKpUs
         Xh9KQK3IDv53j4d0hsUuYwBd5yW0VnhMSLFBTSG1zzIKM8ul52kSiiwt30xb0yKxqLT/
         31+SkaMllvt4thOIch5yp2aGC6LDkNsAEWKfOajnzlV+09p7cdfDnmAxGTWGvm3xS467
         dLqA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Huang <JinhuiEric.Huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.14 068/140] drm/amd/powerplay/vega10: allow mclk switching with no displays
Date: Tue, 13 Mar 2018 16:24:31 +0100
Message-Id: <20180313152502.770326816@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836822557317094?=
X-GMAIL-MSGID: =?utf-8?q?1594837426201572090?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit 5825acf5c958a6820b04e9811caeb2f5e572bcd8 upstream.

If there are no displays attached, there is no reason to disable
mclk switching.

Fixes mclks getting set to high when there are no displays attached.

Reviewed-by: Eric Huang <JinhuiEric.Huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
@@ -3243,10 +3243,13 @@ static int vega10_apply_state_adjust_rul
 	force_mclk_high = phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
 			PHM_PlatformCaps_ForceMclkHigh);
 
-	disable_mclk_switching = (info.display_count > 1) ||
-				    disable_mclk_switching_for_frame_lock ||
-				    disable_mclk_switching_for_vr ||
-				    force_mclk_high;
+	if (info.display_count == 0)
+		disable_mclk_switching = false;
+	else
+		disable_mclk_switching = (info.display_count > 1) ||
+			disable_mclk_switching_for_frame_lock ||
+			disable_mclk_switching_for_vr ||
+			force_mclk_high;
 
 	sclk = vega10_ps->performance_levels[0].gfx_clock;
 	mclk = vega10_ps->performance_levels[0].mem_clock;
