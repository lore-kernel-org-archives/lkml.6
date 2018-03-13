Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELurek6zpuM0wy1GIhs9coYxXAYGOtOFjVSPvnM58Pvh65kLuzkAg+LCMuhSSeU6hQcUg09t
ARC-Seal: i=1; a=rsa-sha256; t=1520954916; cv=none;
        d=google.com; s=arc-20160816;
        b=rRkxcNsgzAnidWqgG/32lSaYrUZzoOIULwgcw0ljzB9g4aJ5kRKdQCipU/03fp4nVt
         kQnIkz1m9+A4CwwW1WUhXlL9fp/zJBj/Xry4iq4kZSVi4wZLOP/igtJfdlPlUOVjxb/S
         n9COxP+7uCBtX8yJUm3O5Fx5yTW1Kh5HyPJIidCzRKqS/ow9hOuyt0Xs3kpTgZitP7t/
         n+7tdsF/uOSs61Gqu0Idgc7yOeCpJ14WL4R975jwg8YqN67gqV+kXUywwrzRs2y0LRNg
         lCle0b4kXhBOzYiJF9Eq7CZzHVwI0HuXS+xdKTotU3u2TuZZos3LNWlRtckkunfLYdzc
         xssw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pM+wfUC8UzkXbwWmSPVE65P/3b6zk+HfT4YP68ob/ac=;
        b=pw3P17GBT7MmCIhFTpkGdQy8Jej1VECf+Y7AMsnLYIBInCZtaffun9f3TTIvjW4K9v
         4wIz+kFu07762rU5lsgqEQXIAyHRAH5N+21I8JkSmskTGyFpZ+z8yHqVPb1XnNmBxTB3
         weozNloAgCK42imf3kNQNUM+p1OrkrQrzEt6xEjUNsR4J8y3Y1MqN2ilV9XBmZAbtWBR
         8x/rdEzPp5sQW0Y5w8wFoJRmJpj+s4HPc1ycW+efy1CYIbDT85PJNZ4ef7407ns854Nk
         iHU7kONwb6DcJgjSEE9vFUBWfvetPYWtXKpVlnWiHricZs+cH6tqm553kGLWHQis5DYX
         YRbA==
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
Subject: [PATCH 4.15 027/146] drm/amd/powerplay/vega10: allow mclk switching with no displays
Date: Tue, 13 Mar 2018 16:23:14 +0100
Message-Id: <20180313152322.569006620@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836822557317094?=
X-GMAIL-MSGID: =?utf-8?q?1594836822557317094?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3208,10 +3208,13 @@ static int vega10_apply_state_adjust_rul
 	disable_mclk_switching_for_vr = PP_CAP(PHM_PlatformCaps_DisableMclkSwitchForVR);
 	force_mclk_high = PP_CAP(PHM_PlatformCaps_ForceMclkHigh);
 
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
