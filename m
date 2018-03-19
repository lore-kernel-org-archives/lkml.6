Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsDc4f8H3eUPu0UGg34DHffMlX+YqmNUGzJtenxnW31UljznRhIBBx3onwlMeIjIzUooVKZ
ARC-Seal: i=1; a=rsa-sha256; t=1521483505; cv=none;
        d=google.com; s=arc-20160816;
        b=UemGDetB88vNgJZsKbov5tcvHgDXLYyXludE4FWQByd4AatgtQTdxqVXrEPwVWUjJM
         oAdJ2Kw46MA5DZoztBAjMZ4K8u77XTNiY1sQZMui0DiOL/bS9M+P9zruhRPeQVfyhHqD
         9JTy8nfd0R+t+JphxDjq9PRhiSuhcvbXSKb3ZwWEwFp3hB09JrNVNn7OmikYuNdKPWUu
         468R+G5KpvNqtmaxUtdoPFgJmQGOILIPri4AIQl9C6/i/sA5oYtmCIphdsB2llI7Ohxf
         wLs7QOgL/eidIwBrq6JJP+SLS4LdHvl+t114+ULZlPzZgQwHMVdZjvJx88ub00zbMH/Z
         U4mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=m8tyK2XdGnjlnumf5srQW6/7ORsua7ubLGTepTgFiZU=;
        b=pRycgYaondeUxNJYH98/xGFjl0RcOCVZLaYTlAqNS2oGjtfaEHK+T0EGg0Wb7/9W1v
         qADi6f9iaaKCC82FT8Jt67jYD22c+zC1Im+nsln3FJ43ar6u3JysP8eiUbQUDZDW1eCW
         u4eJHT/GA415ETdd4YNmahaQj096iTZ58vQq1LkqSOyzEhAnTryTBXbJJaM176E7BJt0
         podCmSTlGk4ivJXH9l9uD6aP7AMXQLTjAe2HxuH8VtBfy8aIMo4t8nJFkokU4N/XV4If
         MDg+25gnBWdAnDR1v/vGy7VNAnQEa2gXuXPQldIifdpQy753pE7vk7F1KLDxqfCEotCS
         tsJQ==
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
Subject: [PATCH 4.9 014/241] drm/sun4i: Set drm_crtc.port to the underlying TCONs output port node
Date: Mon, 19 Mar 2018 19:04:39 +0100
Message-Id: <20180319180751.766649626@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391088087471466?=
X-GMAIL-MSGID: =?utf-8?q?1595391088087471466?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen-Yu Tsai <wens@csie.org>


[ Upstream commit 7544860733d158e3edbf309f27e79e258c8f66bd ]

The way drm_of_find_possible_crtcs works is it tries to match the
remote-endpoint of the given node's various endpoints to all the
crtc's .port field. Thus we need to set drm_crtc.port to the output
port node of the underlying TCON.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/sun4i/sun4i_crtc.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/gpu/drm/sun4i/sun4i_crtc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_crtc.c
@@ -19,6 +19,7 @@
 #include <linux/clk-provider.h>
 #include <linux/ioport.h>
 #include <linux/of_address.h>
+#include <linux/of_graph.h>
 #include <linux/of_irq.h>
 #include <linux/regmap.h>
 
@@ -136,5 +137,9 @@ struct sun4i_crtc *sun4i_crtc_init(struc
 
 	drm_crtc_helper_add(&scrtc->crtc, &sun4i_crtc_helper_funcs);
 
+	/* Set crtc.port to output port node of the tcon */
+	scrtc->crtc.port = of_graph_get_port_by_id(drv->tcon->dev->of_node,
+						   1);
+
 	return scrtc;
 }
