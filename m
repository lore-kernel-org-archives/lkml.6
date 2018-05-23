Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932364AbeEWJeu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:34:50 -0400
Received: from mga09.intel.com ([134.134.136.24]:17836 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932408AbeEWJei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:34:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,432,1520924400";
   d="scan'208";a="231059039"
Subject: Re: [PATCH v8 3/3] drm: writeback: Add client capability for exposing
 writeback connectors
To: Liviu Dudau <Liviu.Dudau@arm.com>,
        Gustavo Padovan <gustavo@padovan.org>
Cc: Sean Paul <seanpaul@chromium.org>, Jonathan Corbet <corbet@lwn.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>, Brian Starkey <brian.starkey@arm.com>,
        Alexandru-Cosmin Gheorghe <alexandru-cosmin.gheorghe@arm.com>,
        Eric Anholt <eric@anholt.net>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Stone <daniels@collabora.com>
References: <20180518151743.29937-1-Liviu.Dudau@arm.com>
 <20180518151743.29937-4-Liviu.Dudau@arm.com>
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Message-ID: <7d0201a9-8eed-f332-b6cb-241560cd05c4@linux.intel.com>
Date: Wed, 23 May 2018 11:34:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180518151743.29937-4-Liviu.Dudau@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Op 18-05-18 om 17:17 schreef Liviu Dudau:
> Due to the fact that writeback connectors behave in a special way
> in DRM (they always report being disconnected) we might confuse some
> userspace. Add a client capability for writeback connectors that will
> filter them out for clients that don't understand the capability.
>
> Re-requested-by: Sean Paul <seanpaul@chromium.org>
> Cc: Brian Starkey <brian.starkey@arm.com>
> Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
> ---
>  drivers/gpu/drm/drm_ioctl.c       | 7 +++++++
>  drivers/gpu/drm/drm_mode_config.c | 5 +++++
>  include/drm/drm_file.h            | 7 +++++++
>  include/uapi/drm/drm.h            | 9 +++++++++
>  4 files changed, 28 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index af782911c505d..59951ff3e3630 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c
> @@ -325,6 +325,13 @@ drm_setclientcap(struct drm_device *dev, void *data, struct drm_file *file_priv)
>  		file_priv->atomic = req->value;
>  		file_priv->universal_planes = req->value;
>  		break;
> +	case DRM_CLIENT_CAP_WRITEBACK_CONNECTORS:
> +		if (!file_priv->atomic || !drm_core_check_feature(dev, DRIVER_ATOMIC))
> +			return -EINVAL;
Wondering how you can set the atomic cap without DRIVER_ATOMIC. :)

That part could be dropped I think. We should probably WARN when trying to create a writeback connector without the DRIVER_ATOMIC cap set.
> +		if (req->value > 1)
> +			return -EINVAL;
> +		file_priv->writeback_connectors = req->value;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
> index e5c653357024d..21e353bd3948e 100644
> --- a/drivers/gpu/drm/drm_mode_config.c
> +++ b/drivers/gpu/drm/drm_mode_config.c
> @@ -145,6 +145,11 @@ int drm_mode_getresources(struct drm_device *dev, void *data,
>  	count = 0;
>  	connector_id = u64_to_user_ptr(card_res->connector_id_ptr);
>  	drm_for_each_connector_iter(connector, &conn_iter) {
> +		/* only expose writeback connectors if userspace understands them */
> +		if (!file_priv->writeback_connectors &&
> +		    (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK))
> +			continue;
> +
>  		if (drm_lease_held(file_priv, connector->base.id)) {
>  			if (count < card_res->count_connectors &&
>  			    put_user(connector->base.id, connector_id + count)) {
> diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
> index 5176c3797680c..2a09b3c8965c6 100644
> --- a/include/drm/drm_file.h
> +++ b/include/drm/drm_file.h
> @@ -181,6 +181,13 @@ struct drm_file {
>  	/** @atomic: True if client understands atomic properties. */
>  	unsigned atomic:1;
>  
> +	/**
> +	 * @writeback_connectors:
> +	 *
> +	 * True if client understands writeback connectors
> +	 */
> +	unsigned writeback_connectors:1;
> +
>  	/**
>  	 * @is_master:
>  	 *
> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> index 6fdff5945c8a0..59f27ea928b42 100644
> --- a/include/uapi/drm/drm.h
> +++ b/include/uapi/drm/drm.h
> @@ -680,6 +680,15 @@ struct drm_get_cap {
>   */
>  #define DRM_CLIENT_CAP_ATOMIC	3
>  
> +/**
> + * DRM_CLIENT_CAP_WRITEBACK_CONNECTORS
> + *
> + * If set to 1, the DRM core will expose special connectors to be used for
> + * writing back to memory the scene setup in the commit. Depends on client
> + * also supporting DRM_CLIENT_CAP_ATOMIC
> + */
> +#define DRM_CLIENT_CAP_WRITEBACK_CONNECTORS	4
> +
>  /** DRM_IOCTL_SET_CLIENT_CAP ioctl argument type */
>  struct drm_set_client_cap {
>  	__u64 capability;

~Maarten
