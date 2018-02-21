Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225gJULmGfeB6oC7ulkPKDWHLPU+g+DMra/I2xsH6mwTkVtRT6JtB/xwTkHFALLyH+9FfELm
ARC-Seal: i=1; a=rsa-sha256; t=1519218694; cv=none;
        d=google.com; s=arc-20160816;
        b=AvpW4bjGmR31mdHA09yad7yrhJUAoMlx0JYBjXzbstDCHHRoLnKyiBGPRrPBdduPFK
         va1XVKNFi3vxHIgTGN3esyIz7ql5eAy5dBebJu/6TnADAAVxQS3jBYoIVsYU+0B17dJL
         0gZLV8+aLP9dTsqCSe00bZYcWhxgGudP3S3kuw2CQIBJH+mEU2glP33K8PFKSUS/51Ms
         NIpVR8qYPm0JJ+L9FPqkWdyNqJHht9PghSnvdI+iuF1822Nc+CFzeR/lFis3FcYCUpsX
         udYtoFWzZokv2HZPVAImThRxmJeT7t2dkp8IUpEZEpi2Xp1ugb3Wmv2EATx6RswQ0pWG
         lBMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DhUzsGLlodpulo0THDYotSCpTZQGVCjlnIY433K/22E=;
        b=qDH1FDbPG9e0hcoLTyRyMlpMoPvhIME+8AlykYpCjcvDM9d/A5+XMAs7V/7iAiXwe9
         AidmM7Z5/MLNS0jKjl1gxm2rOJj964ByKb841WqziqlrzJFMQB8/cJUNRev4RNfh8Bgw
         glj2lTkvyCCu26q3h4Du4rHOq7Xy/WOwy2fZDDhIdks9cZqFbay7SRUL25y+3DD7YcxL
         ZUo74SKKbEzD47PPg2htMX58jP29SqTGJ134XnIfkcAUmPyJhiEZhoG2KtuJIgTARn+5
         Vo6sojqiHW26NpSAYI0l5lEqh+HBLaCqWEB/eogFk82Fh6lPGhEH9cFahodr6rvOyEMZ
         mzKA==
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
Subject: [PATCH 4.15 096/163] drm/radeon: Add dpm quirk for Jet PRO (v2)
Date: Wed, 21 Feb 2018 13:48:45 +0100
Message-Id: <20180221124535.634215533@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015178749380896?=
X-GMAIL-MSGID: =?utf-8?q?1593016261689646925?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit 239b5f64e12b1f09f506c164dff0374924782979 upstream.

Fixes stability issues.

v2: clamp sclk to 600 Mhz

Bug: https://bugs.freedesktop.org/show_bug.cgi?id=103370
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/radeon/si_dpm.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -2984,6 +2984,11 @@ static void si_apply_state_adjust_rules(
 		    (rdev->pdev->device == 0x6667)) {
 			max_sclk = 75000;
 		}
+		if ((rdev->pdev->revision == 0xC3) ||
+		    (rdev->pdev->device == 0x6665)) {
+			max_sclk = 60000;
+			max_mclk = 80000;
+		}
 	} else if (rdev->family == CHIP_OLAND) {
 		if ((rdev->pdev->revision == 0xC7) ||
 		    (rdev->pdev->revision == 0x80) ||
