Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64A8C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9298D214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9298D214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbeLFK70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:59:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44814 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727763AbeLFK70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:59:26 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9D93331256C4;
        Thu,  6 Dec 2018 10:59:25 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DD2F5D9CD;
        Thu,  6 Dec 2018 10:59:25 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 7D0B5181B9E4;
        Thu,  6 Dec 2018 10:59:25 +0000 (UTC)
Date:   Thu, 6 Dec 2018 05:59:25 -0500 (EST)
From:   Frediano Ziglio <fziglio@redhat.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
Message-ID: <207905511.48580418.1544093965441.JavaMail.zimbra@redhat.com>
In-Reply-To: <20181206103352.20587-1-kraxel@redhat.com>
References: <20181206103352.20587-1-kraxel@redhat.com>
Subject: Re: [Spice-devel] [PATCH] drm/qxl: use qxl_num_crtc directly
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.33.32.16, 10.4.195.26]
Thread-Topic: drm/qxl: use qxl_num_crtc directly
Thread-Index: 6gu8SzX0lYQlCzMHMHMoA70PwbJvvQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 06 Dec 2018 10:59:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Just use qxl_num_crtc directly everywhere instead of using
> qdev->monitors_config->max_allowed.  Drops pointless indirection
> and also is less confusing.
> 

To me is MORE confusing, why comparing number of something with
another number? Previously code was comparing number of monitors
with number of monitors, not number of CRTs with number of
monitors.

Why we are optimizing code that, as yours same saying, we are
not much actively improving?

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/qxl/qxl_display.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_display.c
> b/drivers/gpu/drm/qxl/qxl_display.c
> index ce0b9c40fc..6437369a31 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -80,10 +80,10 @@ static int
> qxl_display_copy_rom_client_monitors_config(struct qxl_device *qdev)
>  		DRM_DEBUG_KMS("no client monitors configured\n");
>  		return status;
>  	}
> -	if (num_monitors > qdev->monitors_config->max_allowed) {
> +	if (num_monitors > qxl_num_crtc) {
>  		DRM_DEBUG_KMS("client monitors list will be truncated: %d < %d\n",
> -			      qdev->monitors_config->max_allowed, num_monitors);
> -		num_monitors = qdev->monitors_config->max_allowed;
> +			      qxl_num_crtc, num_monitors);
> +		num_monitors = qxl_num_crtc;
>  	} else {
>  		num_monitors = qdev->rom->client_monitors_config.count;
>  	}
> @@ -96,8 +96,7 @@ static int
> qxl_display_copy_rom_client_monitors_config(struct qxl_device *qdev)
>  		return status;
>  	}
>  	/* we copy max from the client but it isn't used */
> -	qdev->client_monitors_config->max_allowed =
> -				qdev->monitors_config->max_allowed;
> +	qdev->client_monitors_config->max_allowed = qxl_num_crtc;
>  	for (i = 0 ; i < qdev->client_monitors_config->count ; ++i) {
>  		struct qxl_urect *c_rect =
>  			&qdev->rom->client_monitors_config.heads[i];
> @@ -204,7 +203,7 @@ static int qxl_add_monitors_config_modes(struct
> drm_connector *connector,
>  
>  	if (!qdev->monitors_config)
>  		return 0;
> -	if (h >= qdev->monitors_config->max_allowed)
> +	if (h >= qxl_num_crtc)
>  		return 0;
>  	if (!qdev->client_monitors_config)
>  		return 0;
> @@ -307,8 +306,7 @@ static void qxl_crtc_update_monitors_config(struct
> drm_crtc *crtc,
>  		return;
>  	}
>  
> -	if (!qdev->monitors_config ||
> -	    qdev->monitors_config->max_allowed <= i)
> +	if (!qdev->monitors_config || qxl_num_crtc <= i)
>  		return;
>  
>  	head.id = i;
> @@ -348,9 +346,10 @@ static void qxl_crtc_update_monitors_config(struct
> drm_crtc *crtc,
>  	if (oldcount != qdev->monitors_config->count)
>  		DRM_DEBUG_KMS("active heads %d -> %d (%d total)\n",
>  			      oldcount, qdev->monitors_config->count,
> -			      qdev->monitors_config->max_allowed);
> +			      qxl_num_crtc);
>  
>  	qdev->monitors_config->heads[i] = head;
> +	qdev->monitors_config->max_allowed = qxl_num_crtc;
>  	qxl_send_monitors_config(qdev);
>  }
>  
> @@ -1097,9 +1096,8 @@ int qxl_create_monitors_object(struct qxl_device *qdev)
>  {
>  	int ret;
>  	struct drm_gem_object *gobj;
> -	int max_allowed = qxl_num_crtc;
>  	int monitors_config_size = sizeof(struct qxl_monitors_config) +
> -		max_allowed * sizeof(struct qxl_head);
> +		qxl_num_crtc * sizeof(struct qxl_head);
>  
>  	ret = qxl_gem_object_create(qdev, monitors_config_size, 0,
>  				    QXL_GEM_DOMAIN_VRAM,
> @@ -1121,7 +1119,6 @@ int qxl_create_monitors_object(struct qxl_device *qdev)
>  		qxl_bo_physical_address(qdev, qdev->monitors_config_bo, 0);
>  
>  	memset(qdev->monitors_config, 0, monitors_config_size);
> -	qdev->monitors_config->max_allowed = max_allowed;
>  	return 0;
>  }
>  

Frediano
