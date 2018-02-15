Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227BlL6CMKXFonFrT6IUSbfBkbPoxU8C2pyJlVAipbxMmxhX8dJgRpfbrqYvmqB0EHzswOxR
ARC-Seal: i=1; a=rsa-sha256; t=1518708614; cv=none;
        d=google.com; s=arc-20160816;
        b=y0EErAhAr/mXNPiMRjKxjANaPswBeyAHYeTICYxQv4LPYpyhSDtSxZ73m4DlhcUZct
         QYNt4mRxgHIJOkCHP9a3GYHoQGCjr7esI9wwuG96EEP5n1zaEKyf28/fH0clcwfTJGBA
         RcjrnK8yVUi6WhiCNauGJS2S5uNpCoLatDRHWaEyOxR5qJCLFCtF3jtuD0w98AgiRDhg
         Ko97VLOHbViu5VY0rNKeVeuDoqQpvcpN9tbx91dmWBTpTwHyaE5hdXECv97N5siGCzi5
         GCxnBok2rYmggXZ8dIgFefW8WqZz5trtegv3b9uQmw3HRkS1cxLW1Pi+OIrlVb/XR6eB
         jZOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HVA/JcGKU0kyf0Zo1fJMN5b5pZcRjolA5A/P4sWm/8c=;
        b=KehgB+b/GK1EPPGS/xHmTelQ0eBxK/tx9kP3KBaLBGfNsPh17gbLEPjeGmkXoylO2h
         uwsM3c0rMSQlj4eEvFux/1Z2g1Af4FXUyfKnkK3YWp6jIvlawab1vM4g50LnTQkIDIDo
         F0+/tPKXFzpq8z07ufwGIC97tXppQREIZYKE8abKMDFYtb6GJ5b1K9WIl2Pi9G24QTR9
         6ADJAyPLpzq2jliUQ60ZdMGk1Hi6rtjvqBB2V02fr8eY0c9r+58ikK6KR7LFnviqhTC2
         ds3SmjJRc/c/8KagiWC+nKGJ23bSNyr3g6byUDE5Qe49fMdS0jzd6alY8bisoUiNGZeg
         W+rg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chris Wilson <chris@chris-wilson.co.uk>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 4.14 017/195] drm/i915: Fix deadlock in i830_disable_pipe()
Date: Thu, 15 Feb 2018 16:15:08 +0100
Message-Id: <20180215151706.609701756@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481404180643516?=
X-GMAIL-MSGID: =?utf-8?q?1592481404180643516?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit 4488496d58200c7511842e049a4cc891d928da56 upstream.

i830_disable_pipe() gets called from the power well code, and thus
we're already holding the power domain mutex. That means we can't
call plane->get_hw_state() as it will also try to grab the
same mutex and will thus deadlock.

Replace the assert_plane() calls (which calls ->get_hw_state()) with
just raw register reads in i830_disable_pipe(). As a bonus we can
now get a warning if plane C is enabled even though we don't even
expose it as a drm plane.

v2: Do a separate WARN_ON() for each plane (Chris)

Cc: Chris Wilson <chris@chris-wilson.co.uk>
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
Fixes: d87ce7640295 ("drm/i915: Add .get_hw_state() method for planes")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20171129125411.29055-1-ville.syrjala@linux.intel.com
(cherry picked from commit 5816d9cbc0a0fbf232fe297cefcb85361a3cde90)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_display.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -14717,8 +14717,11 @@ void i830_disable_pipe(struct drm_i915_p
 	DRM_DEBUG_KMS("disabling pipe %c due to force quirk\n",
 		      pipe_name(pipe));
 
-	assert_planes_disabled(intel_get_crtc_for_pipe(dev_priv, PIPE_A));
-	assert_planes_disabled(intel_get_crtc_for_pipe(dev_priv, PIPE_B));
+	WARN_ON(I915_READ(DSPCNTR(PLANE_A)) & DISPLAY_PLANE_ENABLE);
+	WARN_ON(I915_READ(DSPCNTR(PLANE_B)) & DISPLAY_PLANE_ENABLE);
+	WARN_ON(I915_READ(DSPCNTR(PLANE_C)) & DISPLAY_PLANE_ENABLE);
+	WARN_ON(I915_READ(CURCNTR(PIPE_A)) & CURSOR_MODE);
+	WARN_ON(I915_READ(CURCNTR(PIPE_B)) & CURSOR_MODE);
 
 	I915_WRITE(PIPECONF(pipe), 0);
 	POSTING_READ(PIPECONF(pipe));
