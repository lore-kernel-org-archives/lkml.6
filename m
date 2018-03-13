Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvEPmu1wegPlkV8gKkcjzr/aZw7GQl9b/UKwkk806zIw604DkcstwQqugwR10ppFLPYp6QJ
ARC-Seal: i=1; a=rsa-sha256; t=1520954934; cv=none;
        d=google.com; s=arc-20160816;
        b=xx0i4Iy6yZ7OtqL4Omh+etB8Vc+61jqIWHm+65lG4FQ7i/Fj7q/OS5x3dpZEKzAw7n
         qvunEVBHTvOh/Mn/VBo/WaO1Wv23wePClMsfXGgm63czZLcbfS7q9msvItDXUGJrVq8C
         6MFK4jEGdgxOAMfxpfq2lDtw6ivlEvQA3pDkwN6eixOz5ZKN4pRF/94M68Np3mgvqiX0
         2h7UVShOzxa4iXz1xm8C01Ohx6AYxZ0y9iRHYRMNIIluVas7J8+GIdWYuousgoSwDaTH
         VpyTxhgbbe6g3GZ3e/fUMusg2rioXXE2OEL1PzT+mAp5dqNEtlpMcl5H1M5dwRTCBFNf
         eyqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=R5HgvYStK97cq6mt11JgmlWUK1jqByRrqlw3s7XYy3E=;
        b=jaAtSCz5hAI6IOUM5CTaOX7ctbyZzb8ckj7NOKrfLi1N2moZK/dz8NHpIBv05JAzHc
         Qz3Mced1PBwVmnAwmsrH+ZFNbgo5bcgIq5mSKW4pZvBGzvRPXcO+Skg6qmuwZLK/DGN7
         x+/IfNWz79hr3a9bTWw0O06pLQKOhkQDLaYcbWKsHul66dCdmZ56BF+2d2ITbjVzMA6G
         e31NJOVuOm03U1ZzmflSc1IYmDaTEylrKz5FDLNkGh9rVPzT4CWCTirCqGAv9kT7buY+
         GgZNRC5V5/MHHQAnGuonAMJ3UP9EbEzQGN4yqqP+xhly7pzxsPjemFghgn5Iw+np6z+8
         UPFw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Harry Wentland <harry.wentland@amd.com>,
	Roman Li <Roman.Li@amd.com>,
	Tony Cheng <Tony.Cheng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.15 032/146] drm/amd/display: Default HDMI6G support to true. Log VBIOS table error.
Date: Tue, 13 Mar 2018 16:23:19 +0100
Message-Id: <20180313152323.002850685@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836841238132336?=
X-GMAIL-MSGID: =?utf-8?q?1594836841238132336?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harry Wentland <harry.wentland@amd.com>

commit caf0a9030d75509f3cacefe466d6d69d26e3dee6 upstream.

There have been many reports of Ellesmere and Baffin systems not being
able to drive HDMI 4k60 due to the fact that we check the HDMI_6GB_EN
bit from VBIOS table. Windows seems to not have this issue.

On some systems we fail to the encoder cap info from VBIOS. In that case
we should default to enabling HDMI6G support.

This was tested by dwagner on
https://bugs.freedesktop.org/show_bug.cgi?id=102820

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Roman Li <Roman.Li@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
@@ -683,6 +683,7 @@ void dce110_link_encoder_construct(
 {
 	struct bp_encoder_cap_info bp_cap_info = {0};
 	const struct dc_vbios_funcs *bp_funcs = init_data->ctx->dc_bios->funcs;
+	enum bp_result result = BP_RESULT_OK;
 
 	enc110->base.funcs = &dce110_lnk_enc_funcs;
 	enc110->base.ctx = init_data->ctx;
@@ -757,15 +758,24 @@ void dce110_link_encoder_construct(
 		enc110->base.preferred_engine = ENGINE_ID_UNKNOWN;
 	}
 
+	/* default to one to mirror Windows behavior */
+	enc110->base.features.flags.bits.HDMI_6GB_EN = 1;
+
+	result = bp_funcs->get_encoder_cap_info(enc110->base.ctx->dc_bios,
+						enc110->base.id, &bp_cap_info);
+
 	/* Override features with DCE-specific values */
-	if (BP_RESULT_OK == bp_funcs->get_encoder_cap_info(
-			enc110->base.ctx->dc_bios, enc110->base.id,
-			&bp_cap_info)) {
+	if (BP_RESULT_OK == result) {
 		enc110->base.features.flags.bits.IS_HBR2_CAPABLE =
 				bp_cap_info.DP_HBR2_EN;
 		enc110->base.features.flags.bits.IS_HBR3_CAPABLE =
 				bp_cap_info.DP_HBR3_EN;
 		enc110->base.features.flags.bits.HDMI_6GB_EN = bp_cap_info.HDMI_6GB_EN;
+	} else {
+		dm_logger_write(enc110->base.ctx->logger, LOG_WARNING,
+				"%s: Failed to get encoder_cap_info from VBIOS with error code %d!\n",
+				__func__,
+				result);
 	}
 }
 
