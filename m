Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqsbLH5CMhS/bOwmfjLj63krbVcXeTW8eBG9HhwEQeGdomgzlyr29dwZcIV4sCi274RgqUp
ARC-Seal: i=1; a=rsa-sha256; t=1525767168; cv=none;
        d=google.com; s=arc-20160816;
        b=bS1Tek/jLt1G4PQ55+RMElTPgtHC4xrMeONurXhAZVhKQxAzuYgbd0I0TjUq/6JoU1
         aSJUVCWNvrlhb+DUF7fN0CiNWS0FuB2ppH7go3kY5quPlTPCTgeoGPSmrsQvlhVliXf/
         WS3qiDAub5i74xPTH8gidGFuzQww3kqRAEmVSDHmLMOXhgZ6RC8KhEe98IcjEeGZlNYw
         goLsX/uLZ2jo3nzobZnM+UsLHGUmDFrVeLVJXMGHXJsApfY91wcn3V+RJa+Y0ziVnd1L
         sFCyg20OC+J6JWQfPQ8qfjVJtBdVaWl1AGy+LLyr9IhhwaY7HPBfbioLiitye2tY7w/z
         xhcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=6Sa1B5l2MQB3OxfZXSWVnwXEEpQzFrOZ74fRcdcGzBw=;
        b=brq4DW2McHzREGl9hUug1lth0jblWwmW0BL/GA5xYVV2UFCrxiChjVdLexWgDgiV3V
         ud3yYjtCZj85hKMSSyo7gFtNqmiMpAN614cYhN3GVIvVUMKYyFD4ENgprpWs2uFky3bm
         +QCCLMZrbqWKnqKXbeNzPqebpB/hZVGc42uhpfF7F4i/R4aRBlRhJNH+ucn7sdLXQTtX
         3evmi/EBfI+9G+YiFrIotPmNQMkGDWa6T0YJTBBvXN8fej4wSkECsTJcCqhuei4+WNg/
         4WHNUPSJ3/BF2heAUEVQ4Qj+3KoSt15SEm/IhwIuipV3d2bDDags64KXh773DRk3JiXX
         Hhxw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=A5PDoCFT;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=A5PDoCFT;
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
Subject: [PATCH 4.16 33/52] drm/bridge: vga-dac: Fix edid memory leak
Date: Tue,  8 May 2018 10:10:31 +0200
Message-Id: <20180508073932.699985625@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882834521782034?=
X-GMAIL-MSGID: =?utf-8?q?1599882834521782034?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -55,7 +55,9 @@ static int dumb_vga_get_modes(struct drm
 	}
 
 	drm_mode_connector_update_edid_property(connector, edid);
-	return drm_add_edid_modes(connector, edid);
+	ret = drm_add_edid_modes(connector, edid);
+	kfree(edid);
+	return ret;
 
 fallback:
 	/*
