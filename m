Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227fuEhCzjk6+FwMj7IJBvLxCq1oVDIzrFDfao0+8jypkvc4CHFAuM5TALc3sAX3U1T+KJWq
ARC-Seal: i=1; a=rsa-sha256; t=1517591123; cv=none;
        d=google.com; s=arc-20160816;
        b=uesms+Vkdym++uJRAGZCtqX/qqyrFCpuYkBxRyqKUFtX/d50cGMeVa7h+D3bOR8A9P
         OfJOugBTmfHe13hXOvb+Fox7BW3cW/LC2S1vpaTGOX4mmWpF52EmLwYXImT/tdEbyo0G
         +LcexrW6/ildXlZV2ivSxXoCVGq/AumEYc0CIRCF4Nd05DmYQBh0wen9Tz0/bbpe92JZ
         5tJQMdMJjyOsqeQL0BuCdXdSRPtikgKUIamHeSPI7a237KcLL5b4Esms6yLffMXUw2bM
         O2J6GJ+H02OorWg/XpE5GuDgBzsdOBTYjDVTn9kp0IwCjl4xVprYqO/cHuO9jBBn49G5
         PhUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zLW4gdrmQ7D+/LGJipfwPrmSLOkI4inbMZrvi5sAK1U=;
        b=aOFF/dthLX4dfvvns2smruSs/iwQda9bnQo1RvXX/VA8R1As3HdkdxNlGICcmeESUw
         PQu86zcKvx7zVwjgnpDErL2rsV/NHcAbuNDcgj7XALo5IC+7JbJMV/oEYvQHAsBLJdlT
         NLVM+n7gvWWWQZ3MgU9TFXgYIr+hpN2xwhXYJ6GqKzJsh78uC5UO8094y8uboh7/MJ9Z
         NQlM792vZr/Hg+cB6B6T1nnKLlIg4P9x/ZAat4xag+N8ut/D6vNNwl1rwhKEk0b5w9oq
         /f6so7U56h6JhS4ofR9VSXSVzfbEiKSlDDFwUeehtEvrAxuqvYy7mDGxcV6rOOcoGRD+
         rLwQ==
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
Subject: [PATCH 4.9 60/86] drm/omap: Fix error handling path in omap_dmm_probe()
Date: Fri,  2 Feb 2018 17:58:20 +0100
Message-Id: <20180202140828.048594221@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309385535184665?=
X-GMAIL-MSGID: =?utf-8?q?1591309629522267378?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -638,7 +638,8 @@ static int omap_dmm_probe(struct platfor
 		match = of_match_node(dmm_of_match, dev->dev.of_node);
 		if (!match) {
 			dev_err(&dev->dev, "failed to find matching device node\n");
-			return -ENODEV;
+			ret = -ENODEV;
+			goto fail;
 		}
 
 		omap_dmm->plat_data = match->data;
