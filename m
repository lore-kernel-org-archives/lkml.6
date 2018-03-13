Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvyFAuW95UWTw0RM7iZGChyE6poMpttRjA6zcOws9NEjpk10tSYITslhtk0INqn2gYBNzFB
ARC-Seal: i=1; a=rsa-sha256; t=1520955468; cv=none;
        d=google.com; s=arc-20160816;
        b=zj5Zjcmmb693i+a7ikAalc+mvxBo0SvdUUlfc3W44E+swBDMuqIdYIIb5QLp/lbfpG
         idnBRYktHrR0aGn8UslGFF+F1KXb5XXDbuf+oxiI/2Ih9HugYZJfmJDX3U6yjxbNienR
         w23gRi5wt14HoJLzNJOHoDg0Ziwjf+LGLK7w6eeCmNdeQ5ejKspJDqgK2a5Htg4/trzF
         4nJGiYx2DXWv2Io6tjeXJbhBdlFARF01/0UEH2N78oRXLxm0ftOKL7Cca1lcc13uxqpJ
         cp/mBU9XR+fd/PKhEcj64HV1cNymz4s/80HxV8xTply7zd9r8MZYBD2clcKSClbeND6T
         jNOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LY7Qw90q5nti+PISUGFb/DuRixzwDnVgofQ2i1yJZ+I=;
        b=v0PhEBHjO6MAkgSgknTReRmB/vCMMjlGliCY9bomqYLa6ZPTfa9wFLhIFQpgX6bbDF
         XxHcfKn54BTaqBeoFpZ7Hc3nrIZCjP7HUSHrmDfPGa4egVB5yH1shjv8fsiIQwWvoCP7
         f8h4EVgOIQbfyr+emE82niFbhbtFjz46Q7vUpafNvaPmM/t2xsTb6wPutmXuJ5mSihZY
         qFoXyR19q5Ea4QqdMVSPMr85PYHn4NLWbUQKuiV7M/ICWEdnhDmann3LZKo5FQKnH0Em
         rLbAhK1X9v5X1cR6ym7gkWpJhNx5cdsoI7mhh5aMrUgY9L8gzNdEQ0j9Waqw5izZI97Y
         YvMw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Subject: [PATCH 4.14 055/140] drm/i915: Update watermark state correctly in sanitize_watermarks
Date: Tue, 13 Mar 2018 16:24:18 +0100
Message-Id: <20180313152501.975207959@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836838276869942?=
X-GMAIL-MSGID: =?utf-8?q?1594837401626984401?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

commit 556fe36d09da5f82879e92bafa0371b4b79f7d6f upstream.

We no longer use intel_crtc->wm.active for watermarks any more,
which was incorrect. But this uncovered a bug in sanitize_watermarks(),
which meant that we wrote the correct watermarks, but the next
update would still use the wrong hw watermarks for calculating.
This caused all further updates to fail with -EINVAL and the
log would reveal an error like the one below:

[   10.043902] [drm:ilk_validate_wm_level.part.8 [i915]] Sprite WM0 too large 56 (max 0)
[   10.043960] [drm:ilk_validate_pipe_wm [i915]] LP0 watermark invalid
[   10.044030] [drm:intel_crtc_atomic_check [i915]] No valid intermediate pipe watermarks are possible

Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Fixes: b6b178a77210 ("drm/i915: Calculate ironlake intermediate watermarks correctly, v2.")
Cc: stable@vger.kernel.org #v4.8+
Link: https://patchwork.freedesktop.org/patch/msgid/20171110113503.16253-1-maarten.lankhorst@linux.intel.com
Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_display.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -14498,6 +14498,8 @@ retry:
 
 		cs->wm.need_postvbl_update = true;
 		dev_priv->display.optimize_watermarks(intel_state, cs);
+
+		to_intel_crtc_state(crtc->state)->wm = cs->wm;
 	}
 
 put_state:
