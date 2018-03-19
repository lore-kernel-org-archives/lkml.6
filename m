Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvHNQJnii9pubNlEWnLNkiRRU1ieZkRbEtmK7eBMpaxT+MoVW0OY+xFGkOKjwLmhm9UNsVp
ARC-Seal: i=1; a=rsa-sha256; t=1521483309; cv=none;
        d=google.com; s=arc-20160816;
        b=w5ZmI8YVFmolsheumN1Opaxut/INdbdzONjbRkA/2t/1oRDtwj6L6Ht3UFi3qUX65g
         wcAIabre7BZbd9nWSe8TBtGUJ4s+wETF2Bgr8lFCU9UNDDX4M9FgRAhYdeGpBEBHQ8dZ
         /ky3TeENJjuZtcEfq+GhsH1Gki3Mm9bGZUz1+coKNP8KZZJa7gdoey9oH9w+i7kUyQwx
         nY1IhpdZtZaWKK5CgtjNNXzN2GcAcJz9MRA5/k0kmEobF7dJaNx13v/qg9zV3l6e+GoH
         t+SScfPiKv4d65qclBDLJ5Xt1pGeLtIOBFLvLn2PefoYAeCaH/GoM4SPxDFJ3FMSJpPJ
         fmVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XkRcCYKUI8cx6gLLiY4NkEYxLb6WIKrzVgEmzs/gIC4=;
        b=gmNRDlOeVHGD5PlI+Ic7Ymvm5BdFH8Hspyw7KlF67U4rRuiT51B68210x7tRdOzzJW
         /WW406vWdE3S2Ium05wrIv59RDpdwkexkP5OT4rJEbwOS1oN5FMQFFmFHk6YGCbBz+ja
         su8NP0YaGOCJ9myB+b05ysyjhf0u5ee10h7WPQLUJv8KBd5+7SHdIKaOAML1SFmyFjK6
         8YMcytaNYUVtNEOWlAPQ1quaDjXc4wIOD6pqgRuIWjwqYwQWY77HmXuLAzFFVAt54IOl
         ozSE4tsRPymQzHvmrkAzJQjekc/i6JQTLWfDyl6IfkJQAv3MvX33rJEtLoNwi2Kny7RF
         H5pg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sinclair Yeh <syeh@vmware.com>,
	Thomas Hellstrom <thellstrom@vmware.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 043/134] drm/vmwgfx: Fixes to vmwgfx_fb
Date: Mon, 19 Mar 2018 19:05:26 +0100
Message-Id: <20180319171855.594348584@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390882331433865?=
X-GMAIL-MSGID: =?utf-8?q?1595390882331433865?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sinclair Yeh <syeh@vmware.com>


[ Upstream commit aa74f0687cfe998e59b20d6454f45e8aa4403c45 ]

1.  When unsetting a mode, num_connector should be set to zero
2.  The pixel_format field needs to be initialized as newer DRM internal
    functions checks this field
3.  Take the drm_modeset_lock_all() because vmw_fb_kms_detach() can
    change current mode

Signed-off-by: Sinclair Yeh <syeh@vmware.com>
Reviewed-by: Thomas Hellstrom <thellstrom@vmware.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
@@ -433,7 +433,7 @@ static int vmw_fb_kms_detach(struct vmw_
 		set.y = 0;
 		set.mode = NULL;
 		set.fb = NULL;
-		set.num_connectors = 1;
+		set.num_connectors = 0;
 		set.connectors = &par->con;
 		ret = drm_mode_set_config_internal(&set);
 		if (ret) {
@@ -821,7 +821,9 @@ int vmw_fb_off(struct vmw_private *vmw_p
 	flush_delayed_work(&par->local_work);
 
 	mutex_lock(&par->bo_mutex);
+	drm_modeset_lock_all(vmw_priv->dev);
 	(void) vmw_fb_kms_detach(par, true, false);
+	drm_modeset_unlock_all(vmw_priv->dev);
 	mutex_unlock(&par->bo_mutex);
 
 	return 0;
