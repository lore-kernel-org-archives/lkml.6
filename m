Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226yrpvz0SYM63eaiHcBkTjON6vE//bD8pG9IdC+Fvrv0w2GuLe3USgWaQSpX0pQMny+PYyZ
ARC-Seal: i=1; a=rsa-sha256; t=1517591598; cv=none;
        d=google.com; s=arc-20160816;
        b=jjqr/AfyOR3h0QQ1EjxK2HZmzPLgyecek/n+pBASbMozk7ksYTcQquQ6Ec1dLPfXv4
         2QhWGLbjVg/Hi4yszwqXptOH2lLNMw1iRFFvfVpbo/TlBtLeU2ELat+aGWE5q9u1gUeI
         NgE/BdXNaqrDiFvjTqAi2igMNhnTeXJacr93i/BaSIgkCY/ApsiMnmMryAKt57LoBi0e
         9bllzepLykIioBtBt40NaE5R9reBaOh68EF4yhrNlflabQhzHFKq3E9j4AMKCpb/JxVG
         9SQiYoeTnnJLjgiszigd87OQrxzwRFJ87MVafEX4Qh8vQYiMKRRgugH/2PSbMkjdWqZL
         dbyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=W3KA7AQs6iywzvC50lPypbbMkmkxzBJ6ZZ4u85LOROU=;
        b=UkFxsxwc8x7rKNI3B4Tgxo5EGl5i5D3+zfDpTh9KmjTlmFxYM3dDL8/IFxNIPDQyfj
         m5MzFhZnjZ5yEe0Ab4ouanfh/v54526pa2Q3J7M0eNJ1HD0LMn9hqMhaQ0jbL0LfbpXA
         HSv5MDD6j56mVddP4jmpfPb+9aG/T0pvEYnHgAZlLJ3CX2+V33A8LxLez+tg3vQZfiU/
         sBlJwdPMxNmATH86VMgsC4AQQaV6JmP9INncIapsa4+zv5lAxp92oYwBCukM3I4mnO1/
         HnSLvbwAzseLf2li1PC9W3FFGSEmFinKfTr2rGeKgsIWNob8iB1J67+FTvn0KsBvM74V
         jApA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Anholt <eric@anholt.net>,
	=?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>,
	Archit Taneja <architt@codeaurora.org>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 105/156] drm/bridge: Fix lvds-encoder since the panel_bridge rework.
Date: Fri,  2 Feb 2018 17:58:06 +0100
Message-Id: <20180202140844.939317667@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591310127977588938?=
X-GMAIL-MSGID: =?utf-8?q?1591310127977588938?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Anholt <eric@anholt.net>


[ Upstream commit dbb58bfd9ae6c885b2ca001a9a5ab8b881fb4ba9 ]

The panel_bridge bridge attaches to the panel's OF node, not the
lvds-encoder's node.  Put in a little no-op bridge of our own so that
our consumers can still find a bridge where they expect.

This also fixes an unintended unregistration and leak of the
panel-bridge on module remove.

Signed-off-by: Eric Anholt <eric@anholt.net>
Fixes: 13dfc0540a57 ("drm/bridge: Refactor out the panel wrapper from the lvds-encoder bri
dge.")
Tested-by: Lothar Waßmann <LW@KARO-electronics.de>
Signed-off-by: Archit Taneja <architt@codeaurora.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20171114191647.22207-1-eric@anholt.net

Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/bridge/lvds-encoder.c |   48 +++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 7 deletions(-)

--- a/drivers/gpu/drm/bridge/lvds-encoder.c
+++ b/drivers/gpu/drm/bridge/lvds-encoder.c
@@ -13,13 +13,37 @@
 
 #include <linux/of_graph.h>
 
+struct lvds_encoder {
+	struct drm_bridge bridge;
+	struct drm_bridge *panel_bridge;
+};
+
+static int lvds_encoder_attach(struct drm_bridge *bridge)
+{
+	struct lvds_encoder *lvds_encoder = container_of(bridge,
+							 struct lvds_encoder,
+							 bridge);
+
+	return drm_bridge_attach(bridge->encoder, lvds_encoder->panel_bridge,
+				 bridge);
+}
+
+static struct drm_bridge_funcs funcs = {
+	.attach = lvds_encoder_attach,
+};
+
 static int lvds_encoder_probe(struct platform_device *pdev)
 {
 	struct device_node *port;
 	struct device_node *endpoint;
 	struct device_node *panel_node;
 	struct drm_panel *panel;
-	struct drm_bridge *bridge;
+	struct lvds_encoder *lvds_encoder;
+
+	lvds_encoder = devm_kzalloc(&pdev->dev, sizeof(*lvds_encoder),
+				    GFP_KERNEL);
+	if (!lvds_encoder)
+		return -ENOMEM;
 
 	/* Locate the panel DT node. */
 	port = of_graph_get_port_by_id(pdev->dev.of_node, 1);
@@ -49,20 +73,30 @@ static int lvds_encoder_probe(struct pla
 		return -EPROBE_DEFER;
 	}
 
-	bridge = drm_panel_bridge_add(panel, DRM_MODE_CONNECTOR_LVDS);
-	if (IS_ERR(bridge))
-		return PTR_ERR(bridge);
+	lvds_encoder->panel_bridge =
+		devm_drm_panel_bridge_add(&pdev->dev,
+					  panel, DRM_MODE_CONNECTOR_LVDS);
+	if (IS_ERR(lvds_encoder->panel_bridge))
+		return PTR_ERR(lvds_encoder->panel_bridge);
+
+	/* The panel_bridge bridge is attached to the panel's of_node,
+	 * but we need a bridge attached to our of_node for our user
+	 * to look up.
+	 */
+	lvds_encoder->bridge.of_node = pdev->dev.of_node;
+	lvds_encoder->bridge.funcs = &funcs;
+	drm_bridge_add(&lvds_encoder->bridge);
 
-	platform_set_drvdata(pdev, bridge);
+	platform_set_drvdata(pdev, lvds_encoder);
 
 	return 0;
 }
 
 static int lvds_encoder_remove(struct platform_device *pdev)
 {
-	struct drm_bridge *bridge = platform_get_drvdata(pdev);
+	struct lvds_encoder *lvds_encoder = platform_get_drvdata(pdev);
 
-	drm_bridge_remove(bridge);
+	drm_bridge_remove(&lvds_encoder->bridge);
 
 	return 0;
 }
