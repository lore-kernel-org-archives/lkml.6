Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtcnCzkRw+XJ1hi0ljlrvM62JYjFh6Rqfr9Ru9V1z23AucWajiczdSwc2dA3JcrKtDTZiPH
ARC-Seal: i=1; a=rsa-sha256; t=1521483852; cv=none;
        d=google.com; s=arc-20160816;
        b=VAJrgt8JBfkptjVhLNrTnNbRIZnE06nffaBxR3IPYC1MXxpwDmG40wDR0nPaxO0JWQ
         LbhwX8aplk82bqx+J1UTznRZdC/JNZmmo82el4xI1w3PUkbhE5rBsG3WiOr0EO7oXkHR
         imJuZBF2CFJj8YAPq0ckCI0KPQvsMhA7PauOdwwimOZh/lY6Sb0HZsCQykzP4oE3MhQj
         R11w0nV6F+AqSrceirACJMMHl7ThsnW1er3yUSnn89i64eEEcLyoqhlcuZ+3W/YpzZyJ
         RzZmB3vst0AGEfnSrLBEDtaI4pGuly0QrkJS5mlRY7qUTmO0Tl/hMx/gdrIpdwXvdgI8
         rEVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bf/+yzQMKUJ2xkNq3lgrF3ASVTK8uUIS6H/l84lZv80=;
        b=yrlFNrOby58BpWSdfbycsbdw9efIGm6Kcp16l2AVnJmUaAS4kuxxcEkIzMNprpDX/f
         X12wr5EsEgfJCoTXXVLqLuBsvb3ICF90ErHuHy36nOAhD+Awa4JlF2bTYQQrCJbYVq53
         MuTSvcUL54U3m3BxNo2ZsmXrf8VIAuKaT7jHmWfrOOgp2Xg8mGfBvNrLOI9/BDV3q3bw
         oLQDkJan+Q1zqlcYUSbk9efGh5cKRcKI6wKTShEnS+6pPu0BGmhRVlgfQVl1LoB/8hJe
         CMCSSaex80cCeE6PIEWuCANxE9DdLS4DKuN5WanE4dS+bpc+tf8tF9Om3b4ulOzANrR8
         qPFA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 104/241] drm: rcar-du: Handle event when disabling CRTCs
Date: Mon, 19 Mar 2018 19:06:09 +0100
Message-Id: <20180319180755.502874239@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391451415626084?=
X-GMAIL-MSGID: =?utf-8?q?1595391451415626084?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>


[ Upstream commit 6dd47cfd03a058d08b8caffb06194aa0eb109cf1 ]

The driver currently handles vblank events only when updating planes on
a CRTC. The atomic update API however allows requesting an event when
disabling a CRTC. This currently leads to event objects being leaked in
the kernel and to events not being sent out. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -512,6 +512,13 @@ static void rcar_du_crtc_disable(struct
 	rcar_du_crtc_stop(rcrtc);
 	rcar_du_crtc_put(rcrtc);
 
+	spin_lock_irq(&crtc->dev->event_lock);
+	if (crtc->state->event) {
+		drm_crtc_send_vblank_event(crtc, crtc->state->event);
+		crtc->state->event = NULL;
+	}
+	spin_unlock_irq(&crtc->dev->event_lock);
+
 	rcrtc->outputs = 0;
 }
 
