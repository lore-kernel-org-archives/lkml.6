Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrv641pbohXbpyY8O98zAJf9+zaTSuB46IcababoZdcymmpO6pOb0JLXhmUx9sjdaCseaLz
ARC-Seal: i=1; a=rsa-sha256; t=1525767430; cv=none;
        d=google.com; s=arc-20160816;
        b=F6ElsZcfljKPAQ32IjdAOl0rkPDAtyQJG39xe9FfVknlua0kRV9HYtwmx/DJ8bL0yo
         XAX4GXj9yFih+OyOuLQ98egoC7Dmjc6Q+5cNo2ybgV88b1BNKIgSxpvyhivssKl8kgyk
         m4C0U0458Yd5+WTbDj/wU6aWyJdgbc6RSqvPFnpAdlPPYQ709PreSfDmUErzK+bYHXmw
         HqxXZO7exRC0RBLNDC51oUfirfuea4AI/aVRQTr3PrimkxWuvhbqvsW6SlTpvL8K3tFp
         PkvE9RksfwtyhzG58mKyqz/lMbyNti2AljLMfU+hWBTyQ3kub7aFIpFacvZ7CmsRHAOA
         a89g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=aE9f9Smhe3QNVo9CvCHV3U+A/EzBWf8FL7Z45nMAA+I=;
        b=VvDpKIxozq5Tji/Usz+2kHI3Z8LpG0B+EL1Yz5X7+4bYOC0EeQZ5+OkJijdNABfPWR
         HIi7JwUw8fxY81R2egQX2NinT6JyfIHoAMUO3Dul1SygHA2esv5T2U8hESbcpi8QJn0e
         5qMMvZyM8pcmXEh/lPH8BvcyyH4iFxVKViWYDzcbsafce3cVaMVvbzinM3YJbImLrZyv
         /beDYtX/VOC6hIAZRfApwyxcQylJW2N88q9eEWBD0+XP8wbo/HOdsyys8YLPAryCAUCP
         V3Q/k22VG0PQNdgcMaYzeEsA5V8LoKLCwQ5K1WVm9cfqKCVgp4pD3LrEPYYQ/kTVImUe
         WfCA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=TGj97DSP;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=TGj97DSP;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Sean Paul <seanpaul@chromium.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Archit Taneja <architt@codeaurora.org>,
	Andrzej Hajda <a.hajda@samsung.com>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 4.9 23/32] drm/bridge: vga-dac: Fix edid memory leak
Date: Tue,  8 May 2018 10:11:03 +0200
Message-Id: <20180508074012.609115825@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074008.800421598@linuxfoundation.org>
References: <20180508074008.800421598@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882834521782034?=
X-GMAIL-MSGID: =?utf-8?q?1599883108477140067?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Paul <seanpaul@chromium.org>

commit 49ceda9de2da4d1827941d06701f3017c27c1855 upstream.

edid should be freed once it's finished being used.

Fixes: 56fe8b6f4991 ("drm/bridge: Add RGB to VGA bridge support")
Cc: Rob Herring <robh@kernel.org>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Archit Taneja <architt@codeaurora.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: <stable@vger.kernel.org> # v4.9+
Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20180420190007.1572-1-seanpaul@chromium.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/bridge/dumb-vga-dac.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
+++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
@@ -53,7 +53,9 @@ static int dumb_vga_get_modes(struct drm
 	}
 
 	drm_mode_connector_update_edid_property(connector, edid);
-	return drm_add_edid_modes(connector, edid);
+	ret = drm_add_edid_modes(connector, edid);
+	kfree(edid);
+	return ret;
 
 fallback:
 	/*
