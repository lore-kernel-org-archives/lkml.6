Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE11C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E21120672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E21120672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440895AbeKXESZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 23:18:25 -0500
Received: from muru.com ([72.249.23.125]:54936 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732672AbeKXESZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 23:18:25 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4BF6780D4;
        Fri, 23 Nov 2018 17:33:15 +0000 (UTC)
Date:   Fri, 23 Nov 2018 09:33:10 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Pavel Machek <pavel@ucw.cz>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv5 4/6] drm/omap: fix incorrect union usage
Message-ID: <20181123173310.GI53235@atomide.com>
References: <20181121160916.22017-1-sebastian.reichel@collabora.com>
 <20181121160916.22017-5-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121160916.22017-5-sebastian.reichel@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Sebastian Reichel <sebastian.reichel@collabora.com> [181121 16:09]:
> The DSI encoder sets dssdev->ops->dsi.set_config, which is stored at the
> same offset as dssdev->ops->hdmi.set_hdmi_mode. The code in omap_encoder
> only checks if dssdev->ops->hdmi.set_hdmi_mode is NULL. Due to the way
> union works, it won't be NULL if dsi.set_config is set. This means
> dsi_set_config will be called with config=hdmi_mode=false=NULL parameter
> resulting in a NULL dereference. Also the dereference happens while
> console is locked, so kernel hangs without any debug output without
> "fb.lockless_register_fb=1" parameter.
> 
> This restructures the code, so that the HDMI mode is only configured
> for HDMI output types. The new function also has a safe-guard directly
> before accessing the union, that can be optimized away by the compiler
> when the function is inlined and HDMI type has already been checked.
> 
> Fixes: 83910ad3f51fb ("drm/omap: Move most omap_dss_driver operations to omap_dss_device_ops")
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Works for me:

Tested-by: Tony Lindgren <tony@atomide.com>
