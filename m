Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvSQNpQce2Bo9wCSwg5kk5eLT1GkW8DKDhWPUYZxhK+icvRtiIAYMIkHHrMvJiXzRYBq44a
ARC-Seal: i=1; a=rsa-sha256; t=1519676910; cv=none;
        d=google.com; s=arc-20160816;
        b=M1OQSTS4+Usnd1kQMBFRnShjtoF69NBXuJP+iW8XuoQOl5Gzh3jpUS9Fc9qEGYpU6S
         HGgakQOxPnZoy2vJDb+Llx2ddrQ3uYPmvP4WQuVcll9WACPucY/pqyUe+s/Iv98pr5KU
         +JmS6NNL4NB1a5/hL1GgOev6EYqlLyp/XBu1YbmNhsVg1BHR9T2oveEJl4zgz1Crvvni
         WnFBkys2KuONSOyHYfIAAK5fhfjnkpM0ahwUdPp6Dgc7z676GMuEiqHy8QpVa1Ufb2TP
         MbGaoPIKp+QZIxcxA/cSO7v67q5GNVPm8iquxJF/nblKmTq0+FIT7EkRAYYV1PlQmDdf
         hvhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VGhFRnGB6+sLVFDz0r0q/m+AarCmxnhhxdrtmrYqZYc=;
        b=EEfifUUXnS4irApwkfN5qeSTbEWd3SOi++Xc11IOkAfGVTHmBgwwYOgP4i0xc85VEF
         AgFIvgLhz4OHM/DJ7s2x+UGBaaRrPKwBF1Sh6K7EOy8eIN1oMBPfsUnfAOnzw43+7GLs
         xAvCVk8pFKZOkWmFUbLU6jc2UQDweTJsolqslPtMyLusSInOFD+QUz936o5v3XkZq52Y
         il/eHTw6WrxonTH0b10LJJQjGdqDGq2d5h7z8kXbree7T9YuJ9SG6CIMn/qHrAi/qX2E
         KoG6aLz+o4YrcW4Q6loOB9SKLq4i1ygxZIziuICriDIb1rC1TqBM/NCHiprtvXWZa46A
         eMLg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Sean Paul <seanpaul@chromium.org>
Subject: [PATCH 4.15 54/64] drm/atomic: Fix memleak on ERESTARTSYS during non-blocking commits
Date: Mon, 26 Feb 2018 21:22:31 +0100
Message-Id: <20180226202155.744688286@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496736239059579?=
X-GMAIL-MSGID: =?utf-8?q?1593496736239059579?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leo (Sunpeng) Li <sunpeng.li@amd.com>

commit 54f809cfbd6b4a43959039f5d33596ed3297ce16 upstream.

During a non-blocking commit, it is possible to return before the
commit_tail work is queued (-ERESTARTSYS, for example).

Since a reference on the crtc commit object is obtained for the pending
vblank event when preparing the commit, the above situation will leave
us with an extra reference.

Therefore, if the commit_tail worker has not consumed the event at the
end of a commit, release it's reference.

Changes since v1:
- Also check for state->event->base.completion being set, to
  handle the case where stall_checks() fails in setup_crtc_commit().
Changes since v2:
- Add a flag to drm_crtc_commit, to prevent dereferencing a freed event.
  i915 may unreference the state in a worker.

Fixes: 24835e442f28 ("drm: reference count event->completion")
Cc: <stable@vger.kernel.org> # v4.11+
Signed-off-by: Leo (Sunpeng) Li <sunpeng.li@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com> #v1
Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180117115108.29608-1-maarten.lankhorst@linux.intel.com
Reviewed-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_atomic_helper.c |   15 +++++++++++++++
 include/drm/drm_atomic.h            |    9 +++++++++
 2 files changed, 24 insertions(+)

--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1778,6 +1778,8 @@ int drm_atomic_helper_setup_commit(struc
 		new_crtc_state->event->base.completion = &commit->flip_done;
 		new_crtc_state->event->base.completion_release = release_crtc_commit;
 		drm_crtc_commit_get(commit);
+
+		commit->abort_completion = true;
 	}
 
 	for_each_oldnew_connector_in_state(state, conn, old_conn_state, new_conn_state, i) {
@@ -3327,8 +3329,21 @@ EXPORT_SYMBOL(drm_atomic_helper_crtc_dup
 void __drm_atomic_helper_crtc_destroy_state(struct drm_crtc_state *state)
 {
 	if (state->commit) {
+		/*
+		 * In the event that a non-blocking commit returns
+		 * -ERESTARTSYS before the commit_tail work is queued, we will
+		 * have an extra reference to the commit object. Release it, if
+		 * the event has not been consumed by the worker.
+		 *
+		 * state->event may be freed, so we can't directly look at
+		 * state->event->base.completion.
+		 */
+		if (state->event && state->commit->abort_completion)
+			drm_crtc_commit_put(state->commit);
+
 		kfree(state->commit->event);
 		state->commit->event = NULL;
+
 		drm_crtc_commit_put(state->commit);
 	}
 
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -134,6 +134,15 @@ struct drm_crtc_commit {
 	 * &drm_pending_vblank_event pointer to clean up private events.
 	 */
 	struct drm_pending_vblank_event *event;
+
+	/**
+	 * @abort_completion:
+	 *
+	 * A flag that's set after drm_atomic_helper_setup_commit takes a second
+	 * reference for the completion of $drm_crtc_state.event. It's used by
+	 * the free code to remove the second reference if commit fails.
+	 */
+	bool abort_completion;
 };
 
 struct __drm_planes_state {
