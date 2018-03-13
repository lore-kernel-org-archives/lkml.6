Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsagL+vW6iRZIbKW+yNwICCjZRqvB0VVqKVisR7033vXDUkMRWuVuyOD0iptd208a+xxunC
ARC-Seal: i=1; a=rsa-sha256; t=1520954922; cv=none;
        d=google.com; s=arc-20160816;
        b=Q6nm4Qf3qI3VFemzSJl71Xt2OiD4NoQOLPhGNTbutrNfZvJ389BKjNUVwL3sYeqZFu
         tSpdHrbhziWdG8ws01pNLEMRI9wBLHCTKE9yv/tLyahnsFfE3ec4aXO/rGFCO4kT4JPP
         CflP7gzLJGZCukpaHSPVeYCuMmLZdKRSm+IWSXB24eoSh06sia0iSoatjuQumA3j+VgX
         cqqFbVmQ/7TF79iZmGW/oaa6M0IdkRXlzjRnzpooLg285+akbBmMSckfgpuiZObBzOpc
         CVKd1n6ruqK+/Zsa0XXKGRhNGSUIa63P7sc2F2OXn3MHlvAnBdryKGkz5gNHY6MFRLH6
         f6Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1bGI0z9DGhfbH/c5b/BVHa3AlUAXtWUcPHoAtttE/mQ=;
        b=jIjPoK6N+1gHTxdcX7SM1q08s/h+IoEzvBi7Tx0T2y7N1QsM2+Ogb/APR9jnVQuhx1
         S3HrFOG5FMlaUbIyZHRXcLrEzaUxlQ80ktrizV+2HNHwVb3W+7xk6kfBjwtz4DSXEhb9
         yoHom1RHb9qIXYK9uAlib6qCqKts903UMo8U/h9I5yydGDvfd6KXnd9RGc7VMaUuH/Ap
         jCXI6jTulmiC5i4YHIXQxetELacr6JKW4yOLWH+kici3vjnKBcH0+uR62DuEywirs/T3
         KkMqOashqXffVqLQjnR3IWuiGfPsBHd6BUlBT6dBvTv+hk/KIs6Z4Rl2A9mrORAQ9HsH
         AkHg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shirish S <shirish.s@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.15 029/146] drm/amd/display: check for ipp before calling cursor operations
Date: Tue, 13 Mar 2018 16:23:16 +0100
Message-Id: <20180313152322.764598321@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836828563293329?=
X-GMAIL-MSGID: =?utf-8?q?1594836828563293329?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shirish S <shirish.s@amd.com>

commit d6b6669762898dfc99e9273b8d8603bc47014aa9 upstream.

Currently all cursor related functions are made to all
pipes that are attached to a particular stream.
This is not applicable to pipes that do not have cursor plane
initialised like underlay.
Hence this patch allows cursor related operations on a pipe
only if ipp in available on that particular pipe.

The check is added to set_cursor_position & set_cursor_attribute.

Signed-off-by: Shirish S <shirish.s@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -200,7 +200,8 @@ bool dc_stream_set_cursor_attributes(
 	for (i = 0; i < MAX_PIPES; i++) {
 		struct pipe_ctx *pipe_ctx = &res_ctx->pipe_ctx[i];
 
-		if (pipe_ctx->stream != stream || (!pipe_ctx->plane_res.xfm && !pipe_ctx->plane_res.dpp))
+		if (pipe_ctx->stream != stream || (!pipe_ctx->plane_res.xfm &&
+		    !pipe_ctx->plane_res.dpp) || !pipe_ctx->plane_res.ipp)
 			continue;
 		if (pipe_ctx->top_pipe && pipe_ctx->plane_state != pipe_ctx->top_pipe->plane_state)
 			continue;
@@ -276,7 +277,8 @@ bool dc_stream_set_cursor_position(
 		if (pipe_ctx->stream != stream ||
 				(!pipe_ctx->plane_res.mi  && !pipe_ctx->plane_res.hubp) ||
 				!pipe_ctx->plane_state ||
-				(!pipe_ctx->plane_res.xfm && !pipe_ctx->plane_res.dpp))
+				(!pipe_ctx->plane_res.xfm && !pipe_ctx->plane_res.dpp) ||
+				!pipe_ctx->plane_res.ipp)
 			continue;
 
 		if (pipe_ctx->plane_state->address.type
