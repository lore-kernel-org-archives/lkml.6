Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrdJOkNEdrFGSLoAm9UHgH25erXv/TzwMyC28r5zNYuOUmJOFOXEh3nfJNB9AH9XjSAj7pf
ARC-Seal: i=1; a=rsa-sha256; t=1526280851; cv=none;
        d=google.com; s=arc-20160816;
        b=U1pqQyOqaZC7XOXI3yURs5XZ30WdEdnIaNaU6D1cuUkUqKbhU1nRVc0LYqEQ5SHcuz
         iAG8R6ebSIp/99QBYKWleVB4yyoFESOZE+tfHV2Ynb2h0CB76rMBoIRDmEcNq7ejbhYl
         ppG0jdAJtDQdYo33MS/IuuDEKUcQSWfW4xoB+Z/kv52EaxcmA6cyVq75wdZCA3yBXMjJ
         VjAhvMor4cD5LVJPfeupRWRXRIfJ+D/C8JXZCKKmGwm/d7+5wjA8x++VBZD2zVIig9mH
         BO/OMpHrjJs5+bJvKQBfvm4WClzCD/PBax8h0oZGQNx1nyYbuY4yAZTWnRaw53xUlfnx
         eXNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=FTCSLAr85VEbIlXBpj6PdYaLZnCKf9WnJ8KfuiHl0Uk=;
        b=XwaJ4X7J8UpdOgOgywdrKqjt7Mr6lGRQrujzuxp6/XjYA8Kg9+p4bqVbNzXLC8GwyR
         R+5cdg/oWRUvJFDssgmJqR3Zxan80tYnnXkzj3IWSJpqNHpFTA+ZozdeTKNIGRacIL3R
         YTi6eoXYqFrxOLGdqXauXBbm6p2RftLxgWS+RKg+FHKABDMn4TEM48SIN7F5a56kqOrL
         t4ooXiVADnWO+loeMuL2ebE70+a/E3sCBpsHKTPRBBExsG0Gxe7JMbnhOMSeA3sAcWpK
         RleZ7nizmPZzHZYOjsHYdZruzIh8SLjPGi8yorpb0uZR0tqX2fgewgjwSa66EeBd67Qs
         qwBQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ACuGJ1Fi;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ACuGJ1Fi;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Boris Brezillon <boris.brezillon@bootlin.com>,
	Eric Anholt <eric@anholt.net>
Subject: [PATCH 4.9 24/36] drm/vc4: Fix scaling of uni-planar formats
Date: Mon, 14 May 2018 08:48:58 +0200
Message-Id: <20180514064806.152478320@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064804.252823817@linuxfoundation.org>
References: <20180514064804.252823817@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421470287342593?=
X-GMAIL-MSGID: =?utf-8?q?1600421470287342593?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Brezillon <boris.brezillon@bootlin.com>

commit 9a0e9802217291e54c4dd1fc5462f189a4be14ec upstream.

When using uni-planar formats (like RGB), the scaling parameters are
stored in plane 0, not plane 1.

Fixes: fc04023fafec ("drm/vc4: Add support for YUV planes.")
Cc: stable@vger.kernel.org
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
Link: https://patchwork.freedesktop.org/patch/msgid/20180507121303.5610-1-boris.brezillon@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/vc4/vc4_plane.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -533,7 +533,7 @@ static int vc4_plane_mode_set(struct drm
 	 * the scl fields here.
 	 */
 	if (num_planes == 1) {
-		scl0 = vc4_get_scl_field(state, 1);
+		scl0 = vc4_get_scl_field(state, 0);
 		scl1 = scl0;
 	} else {
 		scl0 = vc4_get_scl_field(state, 1);
