Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvr0NK6gkyCqjAXynwdgrjExroom/dvhXs6P4cyS/sorA/VExs2+tgCZOZieDkp6jnKwWC2
ARC-Seal: i=1; a=rsa-sha256; t=1520955501; cv=none;
        d=google.com; s=arc-20160816;
        b=oPMIBPaWhcw7RI69e5jTOCG1i553a1pF10l924a5tjqGopgVdHFTuXJuTEbBXt9lRe
         Hq5Fwmajybczrz8FbOBKzSmlG5p/47fAWLwcKaOt5Ndq3hiF9nRltGuKdTUT0QWnNR/m
         09Qu6a5PhnwmkKRJPCKxPJiY4PEFPG9Yt9IVlgmFegsFUshQVJqlwKEJ7ktsUE4jTEyc
         5VqMQciPKXXAvC/rhMHLak9duAsVFHqsdUPLT0UJWVmA8kGTfM5zCAuMmMUWEpMWjf5J
         egHkcoDK2v0Pi9V5euMN6jgXZo/P6w7wyI0SUNDNDKokTJhtYDzxEh3o44mMwoNrma2d
         KiLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HUj8MIt9eQJD8qKP9d39uQTANjBDqvBwG2SGUcT/UOU=;
        b=dRbkYszH/rE8avI5sXB/kkkiPzuxoejA3KG1QfaJflfyO4x6FS6QnwBsgwFsPS1pHd
         MglnNB1wfTtye/GpeeDTpLfT3sjE3YABnIi4R4qIvoqk+v/t6IpZ3Au7TYzrojiVbiFY
         wNKH3C99PVFnocNpnbSK8HbKYBx31mVTe+cNJJv/ot5Cch8RYAEzglTff6LOAoeb0nTz
         cxbe8+PQrwdd+7dHJ6JHjZAVJBE2oM2OA7+jtt7RN6LUFgEjLEsbaEFyNlJbgYhS5jNb
         k/utHHCNN7jWW6OT45YLh9uScLIoIu782fzZo3n+F+9oWfClLiiS0JqhzTud5nqkPi69
         dhDg==
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
Subject: [PATCH 4.14 071/140] drm/amd/powerplay: fix power over limit on Fiji
Date: Tue, 13 Mar 2018 16:24:34 +0100
Message-Id: <20180313152502.949428907@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836835121599975?=
X-GMAIL-MSGID: =?utf-8?q?1594837435125384361?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4579,13 +4579,6 @@ static int smu7_set_power_profile_state(
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
 
