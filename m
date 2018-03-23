Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsogPSPZJniatAh+HdNQHbHe2JjkItQQotnD/EMjseXSaqImi/G6R0FJikUnXVerxnjhmLP
ARC-Seal: i=1; a=rsa-sha256; t=1521800129; cv=none;
        d=google.com; s=arc-20160816;
        b=dsZboLwNc7HpMw/1WU+PotYCMow+4mba453AfH816TvfB6W5sGImEnu0FWDZ7cLeDi
         86z6qbc5afMUi/BqcNjPQTZuHYhbq3cdSrnhsYsPRb87mILf0dTETAhH7iTF5ykQaMC3
         2zuHcS5e1TJ4WeQKrqW7CFhHcwxMOOC4ouvN3qs12eLYIachEU+N9536Kymal/mey7pu
         1ekR55KKZ8nSZJRjUER+1a78Mz+EjLwDVPhzNoWJtzc1BB4QA+IPb6QjNf/sVoy4o64M
         kmL/XfL8V39dmKCioh33p/HC/iG3J2XFfRQxjjyn9eL+yACP/Udd4eb1E1QN222bgnUd
         YloA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1rHRyxPUByzwxFwiT9qNDHYsZs5WB4w5caYlPGFyvJg=;
        b=xuuHPyJg8e5GTLwxze6q0y9pfGXGSdafiKPKYMXsKMSZTEHI75LwF1M4aQaOi4mDAm
         DpRewHDCk93+hLTYmEweAHxd3BZSptvNoGCGT2N8iokyPaaR1txc6i8QTolEEfoqWfh1
         uyNYTKGpSfwGv3sO/xFrRlZP5spzKyvtdE3OpGMaTNl9wcXmxvcz9viBGr7u5npTIHa8
         KPVBGcWJ4FyCMYenSBtjJtg6IWNFdipp7qTV+XcsvrWdaVd6krN7oCYmbr5BtAgc1PCC
         GNZvPSssj4KcT9KXCWTPu52jZLqIFUZCZVZe8FamSfvF4N6gxSHoYbclk/BbEG2AuyjX
         HcAw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mario Kleiner <mario.kleiner.de@gmail.com>,
	Ben Skeggs <bskeggs@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 59/97] drm/nouveau/kms: Increase max retries in scanout position queries.
Date: Fri, 23 Mar 2018 10:54:46 +0100
Message-Id: <20180323094200.937228128@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722662809779900?=
X-GMAIL-MSGID: =?utf-8?q?1595723093071029836?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Kleiner <mario.kleiner.de@gmail.com>


[ Upstream commit 60b95d709525e3ce1c51e1fc93175dcd1755d345 ]

So far we only allowed for 1 retry and just failed the query
- and thereby high precision vblank timestamping - if we did
not get a reasonable result, as such a failure wasn't considered
all too horrible. There are a few NVidia gpu models out there which
may need a bit more than 1 retry to get a successful query result
under some conditions.

Since Linux 4.4 the update code for vblank counter and timestamp
in drm_update_vblank_count() changed so that the implementation
assumes that high precision vblank timestamping of a kms driver
either consistently succeeds or consistently fails for a given
video mode and encoder/connector combo. Iow. switching from success
to fail or vice versa on a modeset or connector change is ok, but
spurious temporary failure for a given setup can confuse the core
code and potentially cause bad miscounting of vblanks and confusion
or hangs in userspace clients which rely on vblank  stuff, e.g.,
desktop compositors.

Therefore change the max retry count to a larger number - more than
any gpu so far is known to need to succeed, but still low enough
so that these queries which do also happen in vblank interrupt are
still fast enough to be not disastrously long if something would
go badly wrong with them.

As such sporadic retries only happen seldom even on affected gpu's,
this could mean a vblank irq could take a few dozen microseconds
longer every few hours of uptime -- better than a desktop compositor
randomly hanging every couple of hours or days of uptime in a hard
to reproduce manner.

Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nouveau_display.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -104,7 +104,7 @@ nouveau_display_scanoutpos_head(struct d
 	};
 	struct nouveau_display *disp = nouveau_display(crtc->dev);
 	struct drm_vblank_crtc *vblank = &crtc->dev->vblank[drm_crtc_index(crtc)];
-	int ret, retry = 1;
+	int ret, retry = 20;
 
 	do {
 		ret = nvif_mthd(&disp->disp, 0, &args, sizeof(args));
