Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtJjJvUH9sCe6zw57b/NUbMd5JGAAbadYo5/6mH86AT9O1BJ6gN5E0AXtquGwmzaY4MDHYB
ARC-Seal: i=1; a=rsa-sha256; t=1519411795; cv=none;
        d=google.com; s=arc-20160816;
        b=Flz9SHwgsIefas3wZ+m/EBKx6jI56H0dXcSSXVucSw+fYNy14kfJ4n9DS4DUbplsFW
         U62cYgiSnX+HMo/oiFwXQkwXxS827j+fTE/GJ1OpUbwgv2BGN2/q4OtF7WxPg4Nh8b5u
         01RMdr2M/ZUKLh6KKxlzjkhTtkQ1KfmIx2RwvPzfATyzkDcbw4S0neC592J58yTE9XVO
         5WF/VaN2RMHcY7ySqR99jxtZkXLeLdnNAWnXqylkZJ7qe/bJIyT+/aMS22ukhOQHBUBr
         WRZtPCidiFSWcyzi0OIwncnWC+XpkwvWqsvXdHjzobWmMreb4xjuznRQJeqlprfJgkS+
         c6ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ejoIGdJL87V8SWXOgh1oZCfwjssEl450/XOjqoThDcI=;
        b=VpfAJ75QxZuO316xGw58nJc6/eYzDRC42dhyijGhgufFsgAUb2PkmwbLRgQJXA8+vv
         1eo1XrAoJBpjnqZlaBNz0iOs4ikt1dmxytJHjI15AbQLoUvqVaQNGGP14llAt9WMJO8t
         2sUYapdwKas3H6nl8K2Fe97QRi4BWFcNukwPoHE2tO4t5UqnZyS1LKUyB9Og+N/zomvs
         QXMPhfDsnYmNlaAv3a5XLBvNPEtFJELQFr7/Vrrezt1bfCqJXlnrkfftlUAmDV86pJzB
         rcsshkMzW1UpypgtmuEWeHYT7ImVQsj9ZoWS7XkTrkWcCDnNPzzlnFSqVwO2eFjUOxJA
         02Cw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chris Wilson <chris@chris-wilson.co.uk>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	syzbot <syzkaller@googlegroups.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Subject: [PATCH 4.14 020/159] drm: Require __GFP_NOFAIL for the legacy drm_modeset_lock_all
Date: Fri, 23 Feb 2018 19:25:28 +0100
Message-Id: <20180223170745.630059985@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217763110308357?=
X-GMAIL-MSGID: =?utf-8?q?1593218743012950154?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Wilson <chris@chris-wilson.co.uk>

commit d18d1a5ac811d12f7ebc1129230312b5f2c50cb8 upstream.

To acquire all modeset locks requires a ww_ctx to be allocated. As this
is the legacy path and the allocation small, to reduce the changes
required (and complex untested error handling) to the legacy drivers, we
simply assume that the allocation succeeds. At present, it relies on the
too-small-to-fail rule, but syzbot found that by injecting a failure
here we would hit the WARN. Document that this allocation must succeed
with __GFP_NOFAIL.

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20171031115535.15166-1-chris@chris-wilson.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_modeset_lock.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/drm_modeset_lock.c
+++ b/drivers/gpu/drm/drm_modeset_lock.c
@@ -88,7 +88,7 @@ void drm_modeset_lock_all(struct drm_dev
 	struct drm_modeset_acquire_ctx *ctx;
 	int ret;
 
-	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL | __GFP_NOFAIL);
 	if (WARN_ON(!ctx))
 		return;
 
