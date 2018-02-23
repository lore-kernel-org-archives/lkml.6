Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226fii6aoE4CBtRox4hqHkV+77tBi74/GUPC5A1TYCqbgq3ehOd/k9Os19dzoYFxIJn5Zn6n
ARC-Seal: i=1; a=rsa-sha256; t=1519410861; cv=none;
        d=google.com; s=arc-20160816;
        b=f+fTSPSloDpfdcJmGgsUtVoFc24D+92SprkaPdS25wjH7D/GvyTHy7UnIXsEQe1PH7
         /+O8G7dfeIt61aYsxqmH5/vhYvlKq0gQzigb+ZchbrWjpNp/lMy0qI1MmieJS8ewYuCI
         V59+3f67HfgUttwNz17NK9gkXx7pG63fXWeEb4dM3E4Zzmicy+MbV61fx8+Xy6XFmAol
         L6aKWRy5NHq5RUBdKQyR4UVJN+ootAWXKj8xeZ1eHeX+hRMUd+9XnknSrHhE1twR0RLR
         Z0p/Nqmsro59VyG5sNomHI33cF7xb7lDZXHSiJFmeczvDhfP5R83KeI1AlUFURzQaI6b
         jAdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ChL/6ytNaKvoD5Sue/uEaml+pXZnMkFOyFN+p1KyQIE=;
        b=wHoxZejwH48XB/ZUifDinBD7ZaorI56QCYNKTz3bCEx9OIOfKUboeTQt37H5vA5Jso
         XxsW2yLPTcEuGFyFYKyMTYqy/TyLRqOXd7gL6Uslh5PkNNL+iKnvTYHRbpRq0hPKXKyY
         q8+pZnNwFI7nlnqvLOpRF9X08XHhOWdcEN6Cx3agDqky0E2n/0o7gjDF7y2MSuOrxfR2
         f2EOFSdKVyEoQTAL3tcDNGrFU4cJJO6lbijL6huV+y9KCRSXriIdHFmO29fc8Vbq0zkM
         A38TUXFzs/4H0ogyZLt6KpJalQEJwAz2BiGdxQ28TmRudocp+7qrU/KL+8KXYUM07TF3
         Ev+Q==
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
Subject: [PATCH 4.4 008/193] drm: Require __GFP_NOFAIL for the legacy drm_modeset_lock_all
Date: Fri, 23 Feb 2018 19:24:01 +0100
Message-Id: <20180223170327.352765228@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217763110308357?=
X-GMAIL-MSGID: =?utf-8?q?1593217763110308357?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -69,7 +69,7 @@ void drm_modeset_lock_all(struct drm_dev
 	struct drm_modeset_acquire_ctx *ctx;
 	int ret;
 
-	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL | __GFP_NOFAIL);
 	if (WARN_ON(!ctx))
 		return;
 
