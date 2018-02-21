Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227aa54VsM8qZxa5Pw7OEq9tRVC47ol0MUKJdycdBcFd9/CRVSwB42IuWrfHH3DFYa63QiFf
ARC-Seal: i=1; a=rsa-sha256; t=1519218126; cv=none;
        d=google.com; s=arc-20160816;
        b=TVoJGqBUN2RpF8CKqSc0E8f+cdTdUKV2GRFko0SYimJ4kpHyIpgKWEQ1hR+/AeEJGI
         iButqxG9gfP/MLDCIaMvBo5Dc1a1tOt/IP8SH4zsiikfykstdkrhCCiG0L0fR8RFRfGG
         WScl3Q2rGClNLuZW9cTSwtVsa1CMrtQj/mwarNjknMdiBniMNZNwf/dN91qLhX3j1JUC
         TJQcaBjNGLMqgkqiElratV68ULR4K/ou+rTCynvuIPEohBjYR8B0ThTTkwCEm2vvPUmh
         ncU+Jkw8pZNujzFm8ARUddLQDyoSSu2oWKcl4YzYbBy7ZinTbOcqN0NTmO9vu3e+Q7li
         gEoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Gfo75UsbqhBRN2n9elV/539YFiw/uVpRfP4o7nlwh8U=;
        b=BdyMiSr3A8gq6Blv+pKTlm/RtL0Mr2UBfeH59bCN6Ro6olwMedwGkLoYtrvGio6X+8
         l0k8WFMCW0x9j6cg1od542XIiDnmlJuh6CGEKyRPbyoUvWXJPPadclL9C8gvKV9/x5Px
         FkW8hmRlbRT4kndxGYibvcib8tLNZk68wZ90C3bvKTihtkOiXi2rZQtdPNgN1cOLd955
         aNagKdlQ5WQ3O7wLyaqeWIP+QoDynEe6KzjAWlvgwCcP/iBZubhH/Dgu3MNMyq/tb7qN
         5y0XyullBYjyYAM6Js+M+jwtOx9mv/hC0kmOT/nJ7M38zLD2aAeti19ZpGAEdBR14cTM
         XrIg==
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
Subject: [PATCH 4.14 096/167] drm/radeon: Add dpm quirk for Jet PRO (v2)
Date: Wed, 21 Feb 2018 13:48:27 +0100
Message-Id: <20180221124529.597127832@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015178749380896?=
X-GMAIL-MSGID: =?utf-8?q?1593015666206083426?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
