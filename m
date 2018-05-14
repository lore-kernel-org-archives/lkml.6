Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZod9QUczIJvps9mamxeuZznTsxrVJ5OJFc4/2ACofGmJl+tkmY2fYTrVVUJhXQBPa6Rhl7f
ARC-Seal: i=1; a=rsa-sha256; t=1526281186; cv=none;
        d=google.com; s=arc-20160816;
        b=VV4s7KoxQ9YLZDv6VnHrJ+IJOuy7SGM/xhZw48JbAC8/r3eIZuaAxGczHXTKQKEVCA
         +iN6EKoaezmMrYreUswnu0h0Zvmp+F0Jm/r+ThWcnHZzvmfIeydtczSWkMEMgVJEMawh
         H9+NwGqrzsk71iHxs4yQZb1Ibh4t0eN12b2FCeC4e0T6Rhtt0lTD0d+KLDJ/Dva+zbaT
         +laXgt+Y9vG0GPP2d6IYHnf/AWgEB9HJVocNdOKhPpx4WUXRrAaloVE5tfxuqYSHk4i8
         7fI7TJ1ScJKO73ynaInErl4Jm7w8EE9XKYBz8NQiIwMLRRdvX1gLH/2P3T9r8L4A2b1q
         u4tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=q9uaCGaAU0PLwqlBsqGxUhdNfTy0dsqoopzYe6LdEyY=;
        b=o3mEDuRwM5AM/Iz3qBkQX23uPZ9BZAqKUJzp9aCI8uVbRcXaWLJSlwOc5gC/VGn8Bg
         ZLBMrTa/kHLwSP5UyO2DIoMs6hY9ZNjnzRg9ur5nQ1G6yBigrjIQLM/x5+gJC2v0UrJe
         fto/WsWwDELSHf1Firp0Fs5vnteipsB1kvItuI0pAE4Uz4vn0yRzqhPamJ6MSJRSkrgK
         IJrA+ljjMWDQflWFOKRXe4A9do2F+xPlZ1W959EEyJyM6Eq12giX8VbODxFaBxhPpgju
         XagLIm6bXWSn2HsSXhMZjk+ktWxUkSA7nC5MPA0K6JhSbq4NLRMH4mo19FWZAV17sh8Z
         rkdA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=oLcW3Ipl;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=oLcW3Ipl;
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
Subject: [PATCH 4.16 49/72] drm/atomic: Clean private obj old_state/new_state in drm_atomic_state_default_clear()
Date: Mon, 14 May 2018 08:49:06 +0200
Message-Id: <20180514064825.309069748@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421621494070871?=
X-GMAIL-MSGID: =?utf-8?q?1600421821320333877?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit b5cb2e5a1f64d882a155add7522247ab0523051e upstream.

Clear the old_state and new_state pointers for private objects
in drm_atomic_state_default_clear(). We don't actually have
functions to get the new/old state for private objects so
getting access to the potentially stale pointers requires a
bit more manual labour than for other object types. But let's
clear the pointers for private objects as well, if only to
avoid future surprises when someone decides to add the functions
to get at them.

v2: Split private objs to a separate patch (Daniel)

Cc: <stable@vger.kernel.org> # v4.14+
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Abhay Kumar <abhay.kumar@intel.com>
Fixes: a4370c777406 (drm/atomic: Make private objs proper objects)
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180502183247.5746-1-ville.syrjala@linux.intel.com
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_atomic.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -196,6 +196,8 @@ void drm_atomic_state_default_clear(stru
 						 state->private_objs[i].state);
 		state->private_objs[i].ptr = NULL;
 		state->private_objs[i].state = NULL;
+		state->private_objs[i].old_state = NULL;
+		state->private_objs[i].new_state = NULL;
 	}
 	state->num_private_objs = 0;
 
