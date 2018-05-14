Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoVaS11gtSKbn1T2N3HoShbfPz5QRkrpoSYsVxNIF2bU68HqjlXX6dMLPEO89VyFQfCSrsu
ARC-Seal: i=1; a=rsa-sha256; t=1526280995; cv=none;
        d=google.com; s=arc-20160816;
        b=06CXa1SKoeF3o3J8zQITVSKnEctf7qvV3l5Be5Yf+Q525XQ14e21gwcxOyyZYIwZ36
         uCkCaaEq4YupgZMEyz8KcP0G2NdNwNk6uTkMxgiF2VAqLNT1/yfmyZE6AGY5f3ASS51r
         xxfX4OwXJO1IgF7VnOxN4XCiNaLlQCs8lTpmddEXU51DCkLDuW8c23OILgujHTDBi5UP
         wIxuORtakDXcekidGQ/DrlRNTyjG+K4LhUfXArPLwf0ilS0LyHhkRvLyIBKK2xX9roP4
         E3UwmQ4WaNF9fm8Z6mDQgRigBOLjaRyQt1+VOPjBNaPiGYg81hOQKaln7kP601xAOjOh
         MC+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=1j4/L5/2PjhIGWI8BpoLAw6WCqKhooeyVaymuEr6mUo=;
        b=qKKiCY2Xp02ZnkfKvSlqsJkraudljEeuBZoNzvYrBWw2wcP+l6SFt5cqR14WiPiBT8
         irKhuZb/tRwUHZSfhXDZ4ZxAuQTWdnzte/8ECkQgyGk9FvXO18M8nA243VSc4ETudTYf
         yBfhLbZdaSwsbpIuaQ7Gl5+sYeXGX2Ue1l+3xVXNfht4EEW7bBYbxZiQWNT9TjEbs3fG
         gepmAE0VU4cQKi7Leflqm72ykmAaqhRZPkmJmr0PniJD4fb0sljaL3lsVtSuZ68YZizu
         yHKcRTiXWSj90DmnrR8ifJvvzxBAzNeqk0IybU6y0ftj0VMF1ySVoZ4RZK9GhqoxCOIi
         2YRA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=qAxcvX+0;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=qAxcvX+0;
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
Subject: [PATCH 4.14 41/62] drm/atomic: Clean private obj old_state/new_state in drm_atomic_state_default_clear()
Date: Mon, 14 May 2018 08:48:57 +0200
Message-Id: <20180514064818.740714880@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421621494070871?=
X-GMAIL-MSGID: =?utf-8?q?1600421621494070871?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -202,6 +202,8 @@ void drm_atomic_state_default_clear(stru
 						 state->private_objs[i].state);
 		state->private_objs[i].ptr = NULL;
 		state->private_objs[i].state = NULL;
+		state->private_objs[i].old_state = NULL;
+		state->private_objs[i].new_state = NULL;
 	}
 	state->num_private_objs = 0;
 
