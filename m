Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48ElN1ooLERBkwAMM/hZaZtyjFpRL0q6Nlx6NZDMloc0pA/5HskT6wDcnDSjB0jxwzNLZLr
ARC-Seal: i=1; a=rsa-sha256; t=1523473218; cv=none;
        d=google.com; s=arc-20160816;
        b=LxhqmdfzSi8FqRTxmoSi0F59UEkF+vGuQ0BQ5a3GmX+vD8OV9+J7S5DNv2adIuoSyI
         BcxMvdFy3hD0xXdDOKPho+ocXTZDZXUssZiwoeevRm9yWgHcs2SrM3Of/3XxIxtyISom
         ANjLVTxOSXbx0auSBctyxNVrgMuePJaVr8io0oZUlPg3/9RwpK4WPRMOJYx9Yh/9hdXc
         c3WSl3k0tdtujiJoWo5x82C6ERx4aJJQKF3tYfMPFqK8gEOhbAfmlCjmWpZdLycCd9QY
         wJRwTZAifOqOYB0+HWwaWj4tLknoaU0yXhW0CoXmy/WG9tTrIMcR55w+G/jWIFIt35+A
         VuHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pJGHhvXs9P0qLh2E3su1HAlg1A+ZXL0CbGgibL1o8wk=;
        b=CLKLndxKd7xFx0px0RZ4blDNhAgE4uaAp+zaPR+dj5DB6N6iRDA8KueD5L6Sa7nEzE
         c8DOh0/ClHPJU0XLHaHMmcILXJKsa1BOUVx1T7Ux4H+3poiQZK5of7WF9KEgEcrqMCfE
         IngibouhfyskbMhbJdzxcRSGf/IsHwcK86eBtqtxf+uOjJJEUlu7Cwo5EkTtK7yODtRg
         Qt3Sw6G22pOy30NijMp9LhKQFHu3p4kkpnLn4tBB4+BUMVi7h7OkmSqkn+dMCuFgK/e+
         H8E9Crfh2LIhglBH/+zXB4Yn9tiwocXhp/O678ntWf3N1RMG+Ur5iEkTKELk7k4SaR35
         EXrg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chen-Yu Tsai <wens@csie.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 167/310] drm/sun4i: Ignore the generic connectors for components
Date: Wed, 11 Apr 2018 20:35:06 +0200
Message-Id: <20180411183629.667084702@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477453416558998?=
X-GMAIL-MSGID: =?utf-8?q?1597477453416558998?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maxime Ripard <maxime.ripard@free-electrons.com>


[ Upstream commit 49baeb074783f5bdf770dc9fac5fbb2837190583 ]

The generic connectors such as hdmi-connector doesn't have any driver in,
so if they are added to the component list, we will be waiting forever for
a non-existing driver to probe.

Add a list of the connectors we want to ignore when building our component
list.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -212,6 +212,11 @@ static const struct component_master_ops
 	.unbind	= sun4i_drv_unbind,
 };
 
+static bool sun4i_drv_node_is_connector(struct device_node *node)
+{
+	return of_device_is_compatible(node, "hdmi-connector");
+}
+
 static bool sun4i_drv_node_is_frontend(struct device_node *node)
 {
 	return of_device_is_compatible(node, "allwinner,sun5i-a13-display-frontend") ||
@@ -252,6 +257,13 @@ static int sun4i_drv_add_endpoints(struc
 	    !of_device_is_available(node))
 		return 0;
 
+	/*
+	 * The connectors will be the last nodes in our pipeline, we
+	 * can just bail out.
+	 */
+	if (sun4i_drv_node_is_connector(node))
+		return 0;
+
 	if (!sun4i_drv_node_is_frontend(node)) {
 		/* Add current component */
 		DRM_DEBUG_DRIVER("Adding component %s\n",
