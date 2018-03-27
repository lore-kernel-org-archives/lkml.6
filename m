Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49GP3aVSYzUd+TGhO1pHVSNjax+DXR9z6itJOMnwrDd5xU9am1kIlMkXfrnlkWTOPNbEOaz
ARC-Seal: i=1; a=rsa-sha256; t=1522168572; cv=none;
        d=google.com; s=arc-20160816;
        b=zZo0okDe9cleVFQITE+ZnBjMX/1aXKy3fmJGDBu7Lj2A3qhmLVxKfD5Mnwj2Dvj+Q0
         UWyy2CmBiFm35wLLHEDqNd45gt7APdBtWGLg81ezkMOQmS37/AvhiYpNYp/Kmi/OUjw4
         GZ1fnUPWU6YiXEHYu5BiR7mldkpz9SxMtGosxqy5C705YvTqlwitk7KvS+WmiNFJy4eM
         b2HYOWzlO/3ZMXOXCEXtc7sPY97tadZn35jDMiE/kdX/g7s2WtOExzVeoWVzf4Dip7xt
         ZDRep3P9mBpvWjIj69EmLVHUtVcWaAybKicEI8emoYfT1zKKziz5dR/gC66OwKwaETPj
         W7cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZCsyUMXV6yvUBP5m00WCRPteo0JfCBbh420Zz4kVYmM=;
        b=CkvON+GirQ1XnP2+xDkCRmbLjgwhBLXtK5qJ50npQyDixF/QmNPhRbchh3Ct0ngkro
         FG10ZmpfxwPFl/eWtdOFuNrujDmcuSI6LW8Fk/UEQ2v3l3CDaY7Cc85UMcCzEgbaGJ6n
         36+zoa40dShWK/uAU9Ocndiei40T+zm0LGmX5jsosmgGbc23KQLE0F2bpXeZ29uBv/7Y
         oAwk/8m8E7q3vquE/WOQaJatwLNn+eMGFIqjGzI2pBUznkrUe09yOFS5ADotpoK0mP+p
         tZsluqIla+OtgHfKHjYPswco8MJqT4ZJjJYecCdKvqWbIW3mn5cF+kcXaulYl2oEw+R+
         Thsw==
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
Subject: [PATCH 4.14 056/101] drm: Reject getfb for multi-plane framebuffers
Date: Tue, 27 Mar 2018 18:27:28 +0200
Message-Id: <20180327162753.435586616@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109433637263045?=
X-GMAIL-MSGID: =?utf-8?q?1596109433637263045?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
