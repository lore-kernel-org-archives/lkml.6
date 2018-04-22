Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/zP4XkgD+WP69pqvOcke6YOK5OewUl+fps+NHcUEp5QUiaU2KunrdOMkhYKTmheqkQD907
ARC-Seal: i=1; a=rsa-sha256; t=1524405626; cv=none;
        d=google.com; s=arc-20160816;
        b=Wr3o7LdQlcsKbxZfqPKGLJeXgj5Sv8sqzYsW+6WeyhcEKEtmx9R7Xju1c+0AsQVhoi
         WSKkzAKcK5nWZLVeYBqh7Khh57bYt9tifXclc//8K7pycQbcl4yCCOyFtiAxjUeMZsv6
         4u7aGsI6Y6JlUVKFJX6KQ8AHaTqraNvo6X8/wvQyS9CiX+7j/4yhvB9ayzO4J6Lghthe
         zEC1dhCKVd8lx7kQYoeNcn8Qn5HMwQOzkJEWfctPgxoYABvoqdiozJRsOtmQbCXaillT
         TFnpiKWuM4aTr4BZwaXkXGgsqH5Vbc/SOHltQeManQCgTKB7pozWRuxtuEP5Y3kf4kUs
         446w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Rang+NjCxvE6irwpVRfV5x4oUZkZBuP8wFs5vzyp9WM=;
        b=RiMoHkqLhihD5+JKYeoAoSENL1VsMWtXE6Ohzpd8o4mdARiXDSVG6j0mAthZbTgeRB
         1jDTfeKZEuD78cNFlrAFxsOwAXvHZ5uthoJnV7D7QqrgilsfISwPB8xrZsYXLw52bHoi
         92Ln8CAQK455aVebjSTn+n6nAcLOsgF64irA4tZM5nzsU/8yTAOzD96xCMr8q9/aeQnV
         AGEGxOiXoU/sTbOxVcTtUJAkvPuMZrruHlUZU2K0kJddoYxwjrXhW3iI5RFOlxsBh8OW
         gmoYSQcy9Id/dfXCJ2QFXDDKvlqm0RbeFwc0eyLffp4Vazi5mO1pkCJgOzL1FgVgfPw2
         u23g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Charlene Liu <charlene.liu@amd.com>,
	Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.16 136/196] drm/amd/display: HDMI has no sound after Panel power off/on
Date: Sun, 22 Apr 2018 15:52:36 +0200
Message-Id: <20180422135111.284793502@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455154608042358?=
X-GMAIL-MSGID: =?utf-8?q?1598455154608042358?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Charlene Liu <charlene.liu@amd.com>

commit af2ac326087da632e9580f65205f4cc4205caf85 upstream.

Signed-off-by: Charlene Liu <charlene.liu@amd.com>
Reviewed-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
@@ -736,6 +736,8 @@ static void dce110_stream_encoder_update
 		if (info_frame->avi.valid) {
 			const uint32_t *content =
 				(const uint32_t *) &info_frame->avi.sb[0];
+			/*we need turn on clock before programming AFMT block*/
+			REG_UPDATE(AFMT_CNTL, AFMT_AUDIO_CLOCK_EN, 1);
 
 			REG_WRITE(AFMT_AVI_INFO0, content[0]);
 
