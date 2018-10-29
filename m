Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BF4C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253482080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 253482080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbeJ3CeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:34:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:19857 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbeJ3CeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:34:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2018 10:44:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,441,1534834800"; 
   d="scan'208";a="103514549"
Received: from vmabille-mobl.ger.corp.intel.com (HELO localhost) ([10.252.39.241])
  by fmsmga001.fm.intel.com with ESMTP; 29 Oct 2018 10:44:28 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list\:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v3] drm/bochs: add edid support.
In-Reply-To: <20181029134507.7775-1-kraxel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20181029134507.7775-1-kraxel@redhat.com>
Date:   Mon, 29 Oct 2018 19:44:28 +0200
Message-ID: <87in1kejgj.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2018, Gerd Hoffmann <kraxel@redhat.com> wrote:
> Recent qemu (latest master branch, upcoming 3.1 release) got support
> for EDID data.  This patch adds guest driver support.
>
> EDID support in qemu is not (yet) enabled by default, so please use
> 'qemu -device VGA,edid=on' for testing.

Any chance of making this use drm_get_edid() (requires an i2c_adapter)
or at least drm_do_get_edid()?

BR,
Jani.

>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/bochs/bochs.h     |  1 +
>  drivers/gpu/drm/bochs/bochs_hw.c  | 39 +++++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/bochs/bochs_kms.c | 18 +++++++++++++++---
>  3 files changed, 55 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
> index e7a69077e4..06b8166efa 100644
> --- a/drivers/gpu/drm/bochs/bochs.h
> +++ b/drivers/gpu/drm/bochs/bochs.h
> @@ -66,6 +66,7 @@ struct bochs_device {
>  	u16 yres_virtual;
>  	u32 stride;
>  	u32 bpp;
> +	struct edid *edid;
>  
>  	/* drm */
>  	struct drm_device  *dev;
> diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
> index cacff73a64..db4afe94c5 100644
> --- a/drivers/gpu/drm/bochs/bochs_hw.c
> +++ b/drivers/gpu/drm/bochs/bochs_hw.c
> @@ -69,6 +69,41 @@ static void bochs_hw_set_little_endian(struct bochs_device *bochs)
>  #define bochs_hw_set_native_endian(_b) bochs_hw_set_little_endian(_b)
>  #endif
>  
> +static int bochs_load_edid(struct bochs_device *bochs)
> +{
> +	uint8_t *blob;
> +	size_t i, len;
> +	uint8_t num_exts;
> +
> +	if (!bochs->mmio)
> +		return -1;
> +
> +	if ((readb(bochs->mmio+0) != 0x00 ||
> +	     readb(bochs->mmio+1) != 0xff))
> +		return -1;
> +
> +	num_exts = readb(bochs->mmio + 126);
> +	len = EDID_LENGTH * (1 + num_exts);
> +	if (len > 0x400 /* vga register offset */)
> +		return -1;
> +
> +	kfree(bochs->edid);
> +	bochs->edid = kmalloc(len, GFP_KERNEL);
> +	blob = (void *)bochs->edid;
> +	for (i = 0; i < len; i++) {
> +		blob[i] = readb(bochs->mmio+i);
> +	}
> +
> +	if (!drm_edid_is_valid(bochs->edid)) {
> +		DRM_ERROR("EDID is not valid, ignoring.\n");
> +		kfree(bochs->edid);
> +		bochs->edid = NULL;
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
>  int bochs_hw_init(struct drm_device *dev)
>  {
>  	struct bochs_device *bochs = dev->dev_private;
> @@ -150,6 +185,9 @@ int bochs_hw_init(struct drm_device *dev)
>  	}
>  
>  noext:
> +	if (bochs_load_edid(bochs) == 0)
> +		DRM_INFO("Found EDID data blob.\n");
> +
>  	return 0;
>  }
>  
> @@ -164,6 +202,7 @@ void bochs_hw_fini(struct drm_device *dev)
>  	if (bochs->fb_map)
>  		iounmap(bochs->fb_map);
>  	pci_release_regions(dev->pdev);
> +	kfree(bochs->edid);
>  }
>  
>  void bochs_hw_setmode(struct bochs_device *bochs,
> diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
> index 9bc5b438ae..b9931443a7 100644
> --- a/drivers/gpu/drm/bochs/bochs_kms.c
> +++ b/drivers/gpu/drm/bochs/bochs_kms.c
> @@ -213,10 +213,17 @@ static void bochs_encoder_init(struct drm_device *dev)
>  
>  static int bochs_connector_get_modes(struct drm_connector *connector)
>  {
> -	int count;
> +	struct bochs_device *bochs =
> +		container_of(connector, struct bochs_device, connector);
> +	int count = 0;
>  
> -	count = drm_add_modes_noedid(connector, 8192, 8192);
> -	drm_set_preferred_mode(connector, defx, defy);
> +	if (bochs->edid)
> +		count = drm_add_edid_modes(connector, bochs->edid);
> +
> +	if (!count) {
> +		count = drm_add_modes_noedid(connector, 8192, 8192);
> +		drm_set_preferred_mode(connector, defx, defy);
> +	}
>  	return count;
>  }
>  
> @@ -271,6 +278,11 @@ static void bochs_connector_init(struct drm_device *dev)
>  	drm_connector_helper_add(connector,
>  				 &bochs_connector_connector_helper_funcs);
>  	drm_connector_register(connector);
> +
> +	if (bochs->edid) {
> +		drm_connector_attach_edid_property(connector);
> +		drm_connector_update_edid_property(connector, bochs->edid);
> +	}
>  }

-- 
Jani Nikula, Intel Open Source Graphics Center
