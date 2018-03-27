Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/0SnP7lF5i1VSNL40Oqw01KQUaJz2rzBljfJEQt/mNe7n3Q1gDgCe8SovZdQd/IOg68bPC
ARC-Seal: i=1; a=rsa-sha256; t=1522168866; cv=none;
        d=google.com; s=arc-20160816;
        b=DMOErFthDkeX/Xv46N1oUzRQociki8mm/xNzbKrQCywoKzPYl0zRYDISowmLF9z1pa
         9SD/yyo1lvB7btKJEjtRjBAx/G7UfbcvVo2zFVgoMszcUjGLJ5vZfAi5B3Vl/tNmHyZQ
         kPwrbN2sVgxhmPgaYSB8Q+/ILyoVYEyl1OWMpFmywKePTruphX0QeN+Fm9IciQyJBAYB
         opAORnJfMXPN3U/mr8rD73e4tNEA+2zSpwE732BH9mFtJ7gY9ZCeQeGVKNDeP9dxJ78X
         e9RHVnWgP8Ioq83EMDN/6ADAaTtbhsHATbV3Prn3teVtgsBW3Hj1ME/NiCCzuSgvH4R4
         qOCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TJ15ybpqN6vWDX8f5b1sjuu5j9ffWZGGWJhjLtiGaCM=;
        b=x5UHgYV5G+paDBK8iH3BT5XwovGa0pI+kEQPIPPIvRgzOSTxGtBPpwKQOqhAvRVx1+
         Db4lEsZfbND3mAF3h+KT4v4Er1e1rCyFGoJBn/sJz8Okz+P+fTjRNT4tdm1w4SdH8xlq
         Z57oxjNTEaW+YtWEGSR8Ne65Q/ekPkptCMIwdHeDKYlSRjxdSd3+wy+bxMPuRDEdDgKo
         TXyvQrKxbkTH6BEJHfQqKr9C34/lUDtUUr86wdlk9flJ9HV92exE9oLvyH2PomEAHdRi
         N1giJpFYWn0WHUqC4H0v+qcAv8ZRoGE8LcaYSFNNeLS3MVpo1Uc4itYKeSRB8gbeKfSp
         nHDw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Daniel Stone <daniels@collabora.com>,
	Daniel van Vugt <daniel.van.vugt@canonical.com>,
	Rob Clark <robdclark@gmail.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 4.15 060/105] drm: Reject getfb for multi-plane framebuffers
Date: Tue, 27 Mar 2018 18:27:40 +0200
Message-Id: <20180327162801.223025067@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109433637263045?=
X-GMAIL-MSGID: =?utf-8?q?1596109741732200758?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Stone <daniels@collabora.com>

commit b24791fe00f8b089d5b10cb7bcc4e1ae88b4831b upstream.

getfb can only return a single plane, so reject attempts to use it with
multi-plane framebuffers.

Signed-off-by: Daniel Stone <daniels@collabora.com>
Reported-by: Daniel van Vugt <daniel.van.vugt@canonical.com>
Reviewed-by: Rob Clark <robdclark@gmail.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Fixes: 308e5bcbdb10 ("drm: add an fb creation ioctl that takes a pixel format v5")
Cc: stable@vger.kernel.org # v3.3+
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=105518
Link: https://patchwork.freedesktop.org/patch/msgid/20180320225839.30905-1-daniels@collabora.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_framebuffer.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -458,6 +458,12 @@ int drm_mode_getfb(struct drm_device *de
 	if (!fb)
 		return -ENOENT;
 
+	/* Multi-planar framebuffers need getfb2. */
+	if (fb->format->num_planes > 1) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	r->height = fb->height;
 	r->width = fb->width;
 	r->depth = fb->format->depth;
@@ -481,6 +487,7 @@ int drm_mode_getfb(struct drm_device *de
 		ret = -ENODEV;
 	}
 
+out:
 	drm_framebuffer_put(fb);
 
 	return ret;
