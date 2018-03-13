Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvFoXa8gB83xfKjekewsyp5oqVLcnL5rp/1VE47B5SnWxH5fI3AzYBhQbeYsbZIsLKa4bl+
ARC-Seal: i=1; a=rsa-sha256; t=1520954931; cv=none;
        d=google.com; s=arc-20160816;
        b=NjOtrBL14zc6ctXjL3e74XTEh5f+lZAUcGvNsG0l4+t9RpfYpP9qhoIuPeY+z3qkAY
         JAvbixNrWXHi18lyrNMzhyuZTwa8HhaK5gH28wQ7K017E/r21kfkaxEtXYhUPWnxalwf
         1pzcP2JVkfCOv4zeSA01BqG/8leSkO19nhguNZe8MmpskEv3vk0VZwB35Cu21JUPbdVj
         V6mqO/e1zZS1ysWLuztCBkxhX4sMoD+Tq3ssM3Tkf9lnSVmhnH6mD7RoJB0U5zW5PsJC
         l+XbfjC7aZWfbCVEhGBIYIzTotnZBhp5WPA6qWI1S8oC+45G8WL+uueEzcyzhagpAETD
         RJhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fCSYK03dlA8X5QgqUU9Sl9wjcvnjMyvbnCELxPIWDRE=;
        b=HjR4gQg3sm58b+T1c6CECFyhMExNcGm9HsiwpBgZi7rbiIAhrFKrwIgUYnpnQro963
         rgq5743oFsAIgaRY9PoKBvfhYAe9brD5HopfM6jTQKnzOGTuFozb2QS/nEOmLmIso0x4
         dlfTZMqKToEG59pyCLmzh0K7jJKRPcB3l4lqfMFA7m0JVJk00h6zeOz/sOZga9rVYiKN
         zH0ThlVOrw7SjAJ0PpDCcUwYpA7YmrhG2ytJKO+DGOYLNKdZm7BfLwDDm1m88MplpKea
         Evk7INgy+FioObUS16qlNZ8YA8Z6wCO80XbN3Y8QWWFaSq61/1eFInNzlK/6VKl2Xuip
         EoQg==
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
Subject: [PATCH 4.15 014/146] drm/i915: Update watermark state correctly in sanitize_watermarks
Date: Tue, 13 Mar 2018 16:23:01 +0100
Message-Id: <20180313152321.663661695@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836838276869942?=
X-GMAIL-MSGID: =?utf-8?q?1594836838276869942?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -14463,6 +14463,8 @@ retry:
 
 		cs->wm.need_postvbl_update = true;
 		dev_priv->display.optimize_watermarks(intel_state, cs);
+
+		to_intel_crtc_state(crtc->state)->wm = cs->wm;
 	}
 
 put_state:
