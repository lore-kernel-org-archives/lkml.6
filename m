Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtXB/s/n1Lmf7om5l9ItzKInbEhdt+4raS0JE/iA2cU/E+RWfU3ITjtlMFFsDk6hpoAZN4R
ARC-Seal: i=1; a=rsa-sha256; t=1520955489; cv=none;
        d=google.com; s=arc-20160816;
        b=W1uKAD/wC4Snw1TSQ8l/dfAuEma7WJ4JfetOxg5sRP2DJSLBsXMZOUPW36gyugRfpW
         ebkceIxoHro504g9YnFQ4gt5nVxvFoZ1w2WxfCwywgiwdYDFZYyw2k//ebv4oZiyMi/X
         dTmMVjexMGGZoo9sFSuq9jm9Wmayejhwlq/qlYkpHc15F5x2sX+8VOvGnt0RXtv9PDRH
         m1SH+Rj2Lw2znmamyJRLNDWvJa0Qij3pa47KaX9rlVPz7Lm3sw0CNXJZL3tOOnf6fP44
         osP09kaP9FimUyKshPgcnWoEPkLCjr/BaVYzs3pHQMchUjNwce9Tr/XmYQDoL/QZcAEi
         tdoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RvJGj68fv/hoCr3Ur3brENmHGYoc/4+W8uZV8D9TH2w=;
        b=mtqDCo4nKG2yEETbFqEyTGVEE71d1IhsKrxt1dug/hqdiLfRoCKXUmLIzMtUHhmLoJ
         S9Ui1OisgvCX94qsVghPI70g7KcHDrqESodviVHR4plP67a/vtcRDIIyU28WsE1ZPAEj
         HOogro6BUc++iCe2xSBS2Dk+jChNyMHXAzhPO4kew73/1ZN1V2TNprydQW4dDMhpsebK
         eU/hq+uqED5pOan6g/Wrgg6a50j0XfJ/9FVrxDx69/zXDkCJPdZCFp+s/7IpKtQdegdN
         94F4pKzMPQmEcnHd5rmMW8ZVr/ozwLf3gUiYOeDAF99Dh5j8XWgTdrjhHEovoWde/6dF
         sy3g==
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
Subject: [PATCH 4.14 067/140] drm/amd/powerplay/smu7: allow mclk switching with no displays
Date: Tue, 13 Mar 2018 16:24:30 +0100
Message-Id: <20180313152502.710983642@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836819342367615?=
X-GMAIL-MSGID: =?utf-8?q?1594837423187625707?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2788,10 +2788,13 @@ static int smu7_apply_state_adjust_rules
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
