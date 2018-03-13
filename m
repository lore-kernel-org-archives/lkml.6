Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtDyG7AZzlV20wPsO/5Z9luH6W9c1HGR7Wsd1Y6ku55qw8M/bEZae8xK6X5m760/eFHIh6v
ARC-Seal: i=1; a=rsa-sha256; t=1520954913; cv=none;
        d=google.com; s=arc-20160816;
        b=jqh4L0S7E9anz0GcaJ0YGlth3ui+pLyAJdZ4uL7AlVsJdRACCB9hcirOgOY6AuVhXj
         gD3FxA/Ga4szVcl4bZJgyZUJz1ut5w2c9AZ5sKCa7yc2lP34KRJjDG/xUgtTzIwS/XA0
         omf6iSQ0DFcj7+f1oB9dejClysiP4Da6RX2lF7Ch016r2EAd8fIFzf/YcHh+uHjHQmq/
         /QJNDE7cRLFuknIfw2TEfwU1gyztgdNIkKuX5WSz+PKB74M/A7q0r4ePfwqkg6oDTa80
         YyInGvhtiBW+4lqiMzpi6EY1Mlr+mCljWkhkIdoqY32lRL0hn5iBPireTUG+BemOcksG
         W9PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0TXhH9e4pSIUsiyPiamNssyzo5uOKDX0r9Sc4r5kubM=;
        b=UNTsCDmAze8MwwT9kWrj7zlxj5Ui1/fzNFzUscaMFgkvMF69egy4Qp0fKSatiPvEWJ
         Mg/Wq5H7C5y3k25/ijL6slE/6Am1DFIHS0mo5it7mxeb/cs5kDUDJ/X86uEmPOZ84zSs
         jB3Z+d2/BSZz9xNZYFggJLlFMDgX8mkQNOT/QaJwdQbP3oNxtsa5SnWU4g55Y+3UU23J
         tmuydQEE14/rHCfAxXwzIPxkrSNUy+1PUvKKFTtbwDno/arq9kKw+iZlJM7+8g35m4vg
         o269n35X4r3jglXeUlOzhRHo0DRhAdqprZ6ZXUmJ6FVePJLrLDAms3a4AD04oBBJre1e
         AmoA==
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
Subject: [PATCH 4.15 026/146] drm/amd/powerplay/smu7: allow mclk switching with no displays
Date: Tue, 13 Mar 2018 16:23:13 +0100
Message-Id: <20180313152322.493843393@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836819342367615?=
X-GMAIL-MSGID: =?utf-8?q?1594836819342367615?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit 51954e17914aaadf18d97b21c2a2cee16fa29513 upstream.

If there are no displays attached, there is no reason to disable
mclk switching.

Fixes mclks getting set to high when there are no displays attached.

Reviewed-by: Eric Huang <JinhuiEric.Huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -2791,10 +2791,13 @@ static int smu7_apply_state_adjust_rules
 				    PHM_PlatformCaps_DisableMclkSwitchingForFrameLock);
 
 
-	disable_mclk_switching = ((1 < info.display_count) ||
-				  disable_mclk_switching_for_frame_lock ||
-				  smu7_vblank_too_short(hwmgr, mode_info.vblank_time_us) ||
-				  (mode_info.refresh_rate > 120));
+	if (info.display_count == 0)
+		disable_mclk_switching = false;
+	else
+		disable_mclk_switching = ((1 < info.display_count) ||
+					  disable_mclk_switching_for_frame_lock ||
+					  smu7_vblank_too_short(hwmgr, mode_info.vblank_time_us) ||
+					  (mode_info.refresh_rate > 120));
 
 	sclk = smu7_ps->performance_levels[0].engine_clock;
 	mclk = smu7_ps->performance_levels[0].memory_clock;
