Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrdPJehMwA8aOwZvQqENiSG3roV+mpO9mN0wXeMhAX/XEXS2WA+LgHA5VnN8rY50450FSMJ
ARC-Seal: i=1; a=rsa-sha256; t=1525767372; cv=none;
        d=google.com; s=arc-20160816;
        b=o8+u+uBOWXJVBwvrT51mSJTOzSRPUbyCp3xNw07AJ4c2rguIcqw6vSNboKLTdQ1zAb
         Htus2sd/jEamEdmW0OY3pYTRKeqS74fCeE+atpz7vy/7ZDCVgLBzmrJ6wyhJ8WpYfnm6
         p7uCahS6gOukX6yucwy0MM+rTE20egoFEf0xnw38mT2bjRlehUVQfFG3NdsT/eHoSCo2
         KdT0gOkn4Kg7bx3YWbJoOXN0qIpr77yVrjwdtsOS36tbMW5Bt+koLGvCR+pJIL2rhAEM
         Uqb3b1Uf+q9OfIA4xPtdOkG4GW82ibWyI/ArSQ2eV58OciLv/yAEZ4xedgpH3cxd5oqi
         TefQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=N8qjMYC/dCkmUJZ/LRc9QVFJOdEse6K2Gp8YRaCeAu8=;
        b=wIC4VHiL9AP1l+Ehl2qXZejBPBk/muW8OsZ/pTnN4+0fIb3rCEKojIBy+s+YpOgz+a
         +q0bVrt86dkiYsWmUWTBWjqxqZtACHX9bjrJGNCCzDCs8jnHs7pVEttxbFd5eiUq2AR1
         QFJRVm8ejnP+/HzXcn+zOH58lM0EXSmA/NM7mfcBn/l5yZZQfvGJTyRRvTuUYfbTlAc2
         ZxnmeQ7ypCPHoc58zPfUeVDLNuiz7L/vr88L3MBbAl3kg5u0dizY0Adh4t6JoTIMUJXo
         695MfLKVTLL5T9XGGy/Lg7RXrWMegQk9Nu6tZqihXWIrj6jyOxidCfgzyDbXz+Zgsxl0
         X2eQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=iJOwXbXx;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=iJOwXbXx;
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
Subject: [PATCH 4.14 31/43] drm/bridge: vga-dac: Fix edid memory leak
Date: Tue,  8 May 2018 10:10:50 +0200
Message-Id: <20180508074008.818953519@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074003.984433784@linuxfoundation.org>
References: <20180508074003.984433784@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882834521782034?=
X-GMAIL-MSGID: =?utf-8?q?1599883048453591600?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
