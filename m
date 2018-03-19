Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs+SRT7Owo6YuPgjF1zsTqNbx5D9hPflR28ejyGoIHXPYSzpYG2ED//UxBfuBQ88HitZTuJ
ARC-Seal: i=1; a=rsa-sha256; t=1521483026; cv=none;
        d=google.com; s=arc-20160816;
        b=V8Kq9bhaadJzKMg8enYEt1pqxt+l4qmQsXB79YTl0aOSMZEhdE0/e36+2uP5vLjfs9
         seakv53KUO/xdD3ld8GVei1kHnah2C/sUmMGHAdjc7D86f7N7sT+RCoXWlqO1cauWIg5
         gcLjOURPGmBv5ZewSgcs6OSsTyE9HDMTY1R+Z+690R6C7/tfYA16cB8pH1ARXxpwOCyp
         2bn4MH/PkXBATQxQjhFvAkCnA75hfEMGKDciGnrBSRN0PZDpS7TeX6sdAQlhIXuSMO54
         9yQUp6Mi9UsDr1GwG8WpAM7xIR0gUJ6j5BC2VGGPDZC0q6GULaDpYTcGB86JE16/4FKW
         OMFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VPMQWGBt4wxI0gRhkLoFpFluqr7lDMmzkJ07f3mDb3c=;
        b=J5us2eoLof8o0GA26nocO6ooqn6eMbjNZoVlu0YS47dvgetOmkkT7iDXusRAT17XJ4
         wga6XlRQ5Cx9uICmhAU9nUswCsXKV5kUYNjjMAfIE+stU+gBYMOQw89GxL5qmWnyGzo0
         lmOgJ6PFcFbAMPPWud6MgvZp92C+fsZ7RPyiez85LwlgaFBzWYmjLOMzgzDe3dFE1OMN
         AZYTHq8LFbmR32N0+Lzp8yp9H2r1ydTss5emc15JIRMyJEkZ6F9bZVX7ZXI9tHZluAKS
         eciSXPbdoRFlnYXElgQDOaLxmdPoWi4R7HfT1IaFqwmHFyS84KnWBQ1BsdFb55VJyAgq
         Nr7A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chris Wilson <chris@chris-wilson.co.uk>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	=?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mario Kleiner <mario.kleiner.de@gmail.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Sasha Levin <alexander.levin@microsoft.com>,
	Dave Airlie <airlied@redhat.com>
Subject: [PATCH 3.18 08/68] drm: Defer disabling the vblank IRQ until the next interrupt (for instant-off)
Date: Mon, 19 Mar 2018 19:05:46 +0100
Message-Id: <20180319171829.114021358@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390585617290166?=
X-GMAIL-MSGID: =?utf-8?q?1595390585617290166?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Wilson <chris@chris-wilson.co.uk>


[ Upstream commit 608b20506941969ea30d8c08dc9ae02bb87dbf7d ]

On vblank instant-off systems, we can get into a situation where the cost
of enabling and disabling the vblank IRQ around a drmWaitVblank query
dominates. And with the advent of even deeper hardware sleep state,
touching registers becomes ever more expensive.  However, we know that if
the user wants the current vblank counter, they are also very likely to
immediately queue a vblank wait and so we can keep the interrupt around
and only turn it off if we have no further vblank requests queued within
the interrupt interval.

After vblank event delivery, this patch adds a shadow of one vblank where
the interrupt is kept alive for the user to query and queue another vblank
event. Similarly, if the user is using blocking drmWaitVblanks, the
interrupt will be disabled on the IRQ following the wait completion.
However, if the user is simply querying the current vblank counter and
timestamp, the interrupt will be disabled after every IRQ and the user
will enabled it again on the first query following the IRQ.

v2: Mario Kleiner -
After testing this, one more thing that would make sense is to move
the disable block at the end of drm_handle_vblank() instead of at the
top.

Turns out that if high precision timestaming is disabled or doesn't
work for some reason (as can be simulated by echo 0 >
/sys/module/drm/parameters/timestamp_precision_usec), then with your
delayed disable code at its current place, the vblank counter won't
increment anymore at all for instant queries, ie. with your other
"instant query" patches. Clients which repeatedly query the counter
and wait for it to progress will simply hang, spinning in an endless
query loop. There's that comment in vblank_disable_and_save:

"* Skip this step if there isn't any high precision timestamp
 * available. In that case we can't account for this and just
 * hope for the best.
 */

With the disable happening after leading edge of vblank (== hw counter
increment already happened) but before the vblank counter/timestamp
handling in drm_handle_vblank, that step is needed to keep the counter
progressing, so skipping it is bad.

Now without high precision timestamping support, a kms driver must not
set dev->vblank_disable_immediate = true, as this would cause problems
for clients, so this shouldn't matter, but it would be good to still
make this robust against a future kms driver which might have
unreliable high precision timestamping, e.g., high precision
timestamping that intermittently doesn't work.

v3: Patch before coffee needs extra coffee.

Testcase: igt/kms_vblank
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Michel Dänzer <michel@daenzer.net>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Dave Airlie <airlied@redhat.com>,
Cc: Mario Kleiner <mario.kleiner.de@gmail.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: http://patchwork.freedesktop.org/patch/msgid/20170315204027.20160-1-chris@chris-wilson.co.uk
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/drm_irq.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/drm_irq.c
+++ b/drivers/gpu/drm/drm_irq.c
@@ -1038,9 +1038,9 @@ void drm_vblank_put(struct drm_device *d
 	if (atomic_dec_and_test(&vblank->refcount)) {
 		if (drm_vblank_offdelay == 0)
 			return;
-		else if (dev->vblank_disable_immediate || drm_vblank_offdelay < 0)
+		else if (drm_vblank_offdelay < 0)
 			vblank_disable_fn((unsigned long)vblank);
-		else
+		else if (!dev->vblank_disable_immediate)
 			mod_timer(&vblank->disable_timer,
 				  jiffies + ((drm_vblank_offdelay * HZ)/1000));
 	}
@@ -1664,6 +1664,16 @@ bool drm_handle_vblank(struct drm_device
 	wake_up(&vblank->queue);
 	drm_handle_vblank_events(dev, crtc);
 
+	/* With instant-off, we defer disabling the interrupt until after
+	 * we finish processing the following vblank. The disable has to
+	 * be last (after drm_handle_vblank_events) so that the timestamp
+	 * is always accurate.
+	 */
+	if (dev->vblank_disable_immediate &&
+	    drm_vblank_offdelay > 0 &&
+	    !atomic_read(&vblank->refcount))
+		vblank_disable_fn((unsigned long)vblank);
+
 	spin_unlock_irqrestore(&dev->event_lock, irqflags);
 
 	return true;
