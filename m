Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvNGfRlFNWXTfyu+GMa5Yd0yLZLM/ED9pqI6EOUOa6A+CbVRpgQHIEOlTwqrr5G67jOkZ5k
ARC-Seal: i=1; a=rsa-sha256; t=1520955506; cv=none;
        d=google.com; s=arc-20160816;
        b=L1JrdrVogVn9K/S0PDVxDQKSlSHMpG5pT4npQHzTKBKoiuH4dr3XtioJMwkJkudVnu
         Vwza71XD48sS5q3JMpcfl+P0sFCX6cUa1mA23Mp/4MWsoVx8UgMsKdcxyNy5+RnoVqyj
         q5QLgxQYNwxbmORIuYhisaGBQFNFbd17E/H4AKk3vaMq2FqZ5s4qNwSyFeva/UFnLrHQ
         +kIlT2yRAVgtlETzi0QjmjiB+tOBCRalbTjpJXousFCQTXhovmSHyiJzaHYM3rdRhyPe
         KcMC8AFSEvKGqivmG30xGm7LqAcRGMngMQBU3K0myehC9gCwclzRIlBWVPOdfbCMU/5P
         dZFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LF/l4PAhO7HXPh1nKfVH1GH7kN7fH6aTzi1Ka/ut85I=;
        b=yeEMYo/af0VIWxmOnFHLyq9cU5uCS+KvIlWbMjPtEIcjXxxHqj8GKEQwkpAevbm6vf
         ciUF+uwWhT0G61E09U4gEHzPA2GlKQRQPuKI8Zhg4OTOTrtsDddWrmGabCna7pl2ZdnP
         HMr30vRMbMpRFunwvStkN4vhN5tO/mAe/LK9eQB0HjwzHhsH9Xbn4r74wUz4M1FE7tw9
         d7aXFXRhjin/lEPiQoyUt7Lh35tLsXtVjhV4GyDj628z7SwPPrbZotog1GYpmMxla0M8
         GZp9W0zIZOZugxaSl/3nG/htowKPJgnRdlC/v4fyRnXcUVltgmtlrkFvgzX7CffqzkC/
         x/Pg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.14 069/140] Revert "drm/radeon/pm: autoswitch power state when in balanced mode"
Date: Tue, 13 Mar 2018 16:24:32 +0100
Message-Id: <20180313152502.848984957@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836826095220800?=
X-GMAIL-MSGID: =?utf-8?q?1594837441763165440?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit 53bf277b487eb5ae6695db01bede0fe406792119 upstream.

This reverts commit 1c331f75aa6ccbf64ebcc5a019183e617c9d818a.

Breaks resume on some systems.

Bug: https://bugs.freedesktop.org/show_bug.cgi?id=100759
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/radeon/radeon_pm.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/drivers/gpu/drm/radeon/radeon_pm.c
+++ b/drivers/gpu/drm/radeon/radeon_pm.c
@@ -47,7 +47,6 @@ static bool radeon_pm_in_vbl(struct rade
 static bool radeon_pm_debug_check_in_vbl(struct radeon_device *rdev, bool finish);
 static void radeon_pm_update_profile(struct radeon_device *rdev);
 static void radeon_pm_set_clocks(struct radeon_device *rdev);
-static void radeon_pm_compute_clocks_dpm(struct radeon_device *rdev);
 
 int radeon_pm_get_type_index(struct radeon_device *rdev,
 			     enum radeon_pm_state_type ps_type,
@@ -80,8 +79,6 @@ void radeon_pm_acpi_event_handler(struct
 				radeon_dpm_enable_bapm(rdev, rdev->pm.dpm.ac_power);
 		}
 		mutex_unlock(&rdev->pm.mutex);
-		/* allow new DPM state to be picked */
-		radeon_pm_compute_clocks_dpm(rdev);
 	} else if (rdev->pm.pm_method == PM_METHOD_PROFILE) {
 		if (rdev->pm.profile == PM_PROFILE_AUTO) {
 			mutex_lock(&rdev->pm.mutex);
@@ -885,8 +882,7 @@ static struct radeon_ps *radeon_dpm_pick
 		dpm_state = POWER_STATE_TYPE_INTERNAL_3DPERF;
 	/* balanced states don't exist at the moment */
 	if (dpm_state == POWER_STATE_TYPE_BALANCED)
-		dpm_state = rdev->pm.dpm.ac_power ?
-			POWER_STATE_TYPE_PERFORMANCE : POWER_STATE_TYPE_BATTERY;
+		dpm_state = POWER_STATE_TYPE_PERFORMANCE;
 
 restart_search:
 	/* Pick the best power state based on current conditions */
