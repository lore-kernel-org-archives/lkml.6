Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226V4uiMd72jriWGZEKSBtFBTpNGBUaaxi1QAsGrN4fm7g9StM/uxUYGBemulTAlpeNFmG0+
ARC-Seal: i=1; a=rsa-sha256; t=1517590890; cv=none;
        d=google.com; s=arc-20160816;
        b=o6yGRUPbV1QNLiUWaWBvrs6RnVII3PmWLmG35PR/686ZGmP8z0disSM82Gm5kaXppR
         ew/0EGwGcWbumLdSKvUn10a67N5Z+RnWJ+Lj/dv4BY4qB4F7wrf5liVyP/Lgoq8XEwUg
         gm5OY369pyIBB3/GYVxEbvIkyDlUV7vQZldCtpkQKW7FzIHRsnUFaEWMqNqAvWqiR6xk
         nsxf8w7FtR0GOxFMslTfYSHwf2WzHi8JQ8pDMArOvHgu5Nv+H01aLUN6CrUYA9EdrH1N
         yuMMS1HWzZ4yg0mYzAocZ51DM0vCodvfuyUzJL/tMVZWijIkle2PMp9wxshqIcArzVmJ
         UHPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9MipztKd0Lqbi5ssS4qqrxpcF+6QWCZnSM1gUueu0mg=;
        b=kQ2q3pL4zOWsk92bTMu9nH5WwDq6Cmin8R/Bdu9y2HtwtyxBYoeYAGvdFjmAOOE6E8
         nDdu2CWUgFCYvDD2Al6o/vVVo6R1cc7pQVAnTOwBgx/gZ6+77xJL2OfD+vQDBo+TGzR0
         WwGiuptNe2SbEGFjQA6FGIMirzBRvHOQ35gYOIjExz5nJI8y/bkv43mi3spXcZ8p+yhr
         oEoCU82w2R7Rj5FqkK/qIC6DSGy+ktC+a4NQQPq8bDVncKkm1Hva95wglULj4FNKw4Q+
         lZ/9DRhLGPm2Xd5BEpwB8vEUN9zQ0u7mXI5rjEQkFrhlwX2uw+NAVQyLWDVecDdJ23v6
         b+Pw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 48/67] drm/omap: Fix error handling path in omap_dmm_probe()
Date: Fri,  2 Feb 2018 17:58:17 +0100
Message-Id: <20180202140820.676180442@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309385535184665?=
X-GMAIL-MSGID: =?utf-8?q?1591309385535184665?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


[ Upstream commit 8677b1ac2db021ab30bb1fa34f1e56ebe0051ec3 ]

If we don't find a matching device node, we must free the memory allocated
in 'omap_dmm' a few lines above.

Fixes: 7cb0d6c17b96 ("drm/omap: fix TILER on OMAP5")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
+++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
@@ -611,7 +611,8 @@ static int omap_dmm_probe(struct platfor
 		match = of_match_node(dmm_of_match, dev->dev.of_node);
 		if (!match) {
 			dev_err(&dev->dev, "failed to find matching device node\n");
-			return -ENODEV;
+			ret = -ENODEV;
+			goto fail;
 		}
 
 		omap_dmm->plat_data = match->data;
