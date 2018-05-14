Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpnF/xA3apzXeejy43Rn6E/VNqk71CjHCcoF3fqPej6d0eyLWd9ZbZJlyQW0zolnFq5/rN1
ARC-Seal: i=1; a=rsa-sha256; t=1526281183; cv=none;
        d=google.com; s=arc-20160816;
        b=bljxvlv5OHZzhk43qThluF0/8/SypSN5RIWP7BgHCj7dCbouRTR4s10Z1CzMsv1zv8
         d6okdw4JUtF1R4675Mon+Dr+6Ix4Q3wz/xBfYfGFh2ZL3xYuRqtUcPWwQqkejQZ8zNpi
         LDsu+jCaGoLYYAXj9Ppoafly4oAgN77pmwqEV27GC4b9s6rNbvjNTtNQD2ML10XgoM34
         VM2Fd7QKLnluudy9Y554hJfKc/i84JcA9rleOahZYmhnChF0kw6MPN/NHIKx/2indNp0
         TIVXgzn7seGwQSF83sqI559nDaBzNH/fHAobp/WZi7TI8Tgw0blPH8mjo+wA+DJIcjMA
         F77w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=ytFZXFqe5Jg6xj5rHSCqTS+Vz5wAySTOjhsnwk/lKqE=;
        b=QVz85Mwjya6mAHFJstMoL52WpYdr52s0jvjqyiafNAh530HrslVxIxpi8fjVJ1Zu6l
         CkP2rIIlPiNZ2UM0oRNMTYIoQ+rKim2HRE1B/vKgnKHKGj61tPeL5kjXJzoRvWwTa4d2
         c182Idk5peiknOX7pL/pvJqpvn7y67jB0BtqPTPdth9xxodyzX+Ea4ECgFMY7v1WfESA
         57VRArcZw993JIT5R7De7qmW3tAmreMVDzYtFl5av/5Ozwhx5cLVcDQ+YQ6m4wc6x4XV
         toiPxltBGCZIuXVk83D0kk2UsM1dJz+SSCQ0w13cLGt0S7IsFHYpex1khR10hnosrAlC
         JfSg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=asAdxj1E;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=asAdxj1E;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Abhay Kumar <abhay.kumar@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Sean Paul <seanpaul@chromium.org>
Subject: [PATCH 4.16 48/72] drm/atomic: Clean old_state/new_state in drm_atomic_state_default_clear()
Date: Mon, 14 May 2018 08:49:05 +0200
Message-Id: <20180514064825.244393480@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421619250429245?=
X-GMAIL-MSGID: =?utf-8?q?1600421818989383483?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit f0b408eebc993310bea3f2daae286c40bd3f063b upstream.

Clear the old_state and new_state pointers for every object in
drm_atomic_state_default_clear(). Otherwise
drm_atomic_get_{new,old}_*_state() will hand out stale pointers to
anyone who hasn't first confirmed that the object is in fact part of
the current atomic transcation, if they are called after we've done
the ww backoff dance while hanging on to the same drm_atomic_state.

For example, handle_conflicting_encoders() looks like it could hit
this since it iterates the full connector list and just calls
drm_atomic_get_new_connector_state() for each.

And I believe we have now witnessed this happening at least once in
i915 check_digital_port_conflicts(). Commit 8b69449d2663 ("drm/i915:
Remove last references to drm_atomic_get_existing* macros") changed
the safe drm_atomic_get_existing_connector_state() to the unsafe
drm_atomic_get_new_connector_state(), which opened the doors for
this particular bug there as well.

v2: Split private objs out to a separate patch (Daniel)

Cc: stable@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Abhay Kumar <abhay.kumar@intel.com>
Fixes: 581e49fe6b41 ("drm/atomic: Add new iterators over all state, v3.")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180502183247.5746-1-ville.syrjala@linux.intel.com
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_atomic.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -155,6 +155,8 @@ void drm_atomic_state_default_clear(stru
 						       state->connectors[i].state);
 		state->connectors[i].ptr = NULL;
 		state->connectors[i].state = NULL;
+		state->connectors[i].old_state = NULL;
+		state->connectors[i].new_state = NULL;
 		drm_connector_put(connector);
 	}
 
@@ -169,6 +171,8 @@ void drm_atomic_state_default_clear(stru
 
 		state->crtcs[i].ptr = NULL;
 		state->crtcs[i].state = NULL;
+		state->crtcs[i].old_state = NULL;
+		state->crtcs[i].new_state = NULL;
 	}
 
 	for (i = 0; i < config->num_total_plane; i++) {
@@ -181,6 +185,8 @@ void drm_atomic_state_default_clear(stru
 						   state->planes[i].state);
 		state->planes[i].ptr = NULL;
 		state->planes[i].state = NULL;
+		state->planes[i].old_state = NULL;
+		state->planes[i].new_state = NULL;
 	}
 
 	for (i = 0; i < state->num_private_objs; i++) {
