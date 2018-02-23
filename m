Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2253iPpd+SHtnM6Qk/9AS+wwr5+qLHdZ+xtxgWuos5iA2oWNM8poBC69mvvLsyFcD+wSDf+k
ARC-Seal: i=1; a=rsa-sha256; t=1519411454; cv=none;
        d=google.com; s=arc-20160816;
        b=cH8fsuERSoqMgHJQ06YOLoex2udUNtBlG9mgMeOO2Oab9c/ECGTPl5ZIA80kHdHvKT
         kLSIC2cpRSgrn3PZ8zAzW5SrdMkDHlGaqq8ZhoWcGWFdq4xDOXfw3/WAicgY4lf6+xep
         3b1Q7Kxyw3SQxF1QQbI2YoTav8ir/IwW3Alj7bQNZLp08sU9bB42S3zC7nxj5YXC9hkS
         wAh24Ml5uYgS8hdhN+vvnqTfqEIRBNicG/jMnZcU2sTU3i07Pvi064IWODm8z0xV4WUE
         L1EWLYJ8SwrewG2c56izyB7q266dkTEx2FuE1uAwSISQL9NIYjKxvn0MZ8WyIceKTJkX
         7fzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dAiQob/+DwyYl4/S/SPKbq3HlcDhcQZd2NFPonOtsjA=;
        b=dJkNqNosobxyKMqkS2aSgMs/yoEN+TU3oQyIhY24sYwA9v3dCps3s5sjGOQb5GtlGw
         sDx51BlkDhD8TQqD2Y0ODvjcZMcId4bSRQ52mqL1Z2JhTFckE+Wt6C1BEQ0SIN2WzsCm
         xe1nXGkpLoTzkRw6VOp21H6DwkLbxLpxXPlAyW220WwLso0jkYc8Y+NCHJ9wcpwvTUuA
         +uo/cVBQhyZo2Pq99h5s1FJHO3Nhx7niJqVdz5qh4mur7v8zvBzO1ZB9D+bKiO54cVCt
         mf3ECvJypH8g6u7SnGpF0gQozHHbCC+jhe31zOlTXtx68vqOySELnLQHbvqoig6DkjAq
         3UTg==
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
Subject: [PATCH 4.9 011/145] drm: Require __GFP_NOFAIL for the legacy drm_modeset_lock_all
Date: Fri, 23 Feb 2018 19:25:17 +0100
Message-Id: <20180223170726.163622667@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217763110308357?=
X-GMAIL-MSGID: =?utf-8?q?1593218384843058399?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -81,7 +81,7 @@ void drm_modeset_lock_all(struct drm_dev
 	struct drm_modeset_acquire_ctx *ctx;
 	int ret;
 
-	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL | __GFP_NOFAIL);
 	if (WARN_ON(!ctx))
 		return;
 
