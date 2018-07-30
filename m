Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F193DFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A098120892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A098120892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbeG3JeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 05:34:02 -0400
Received: from mga14.intel.com ([192.55.52.115]:35346 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbeG3JeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 05:34:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 01:00:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,422,1526367600"; 
   d="scan'208";a="68566893"
Received: from chanse1-mobl.ger.corp.intel.com (HELO [10.252.51.109]) ([10.252.51.109])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Jul 2018 01:00:12 -0700
Subject: Re: [PATCH] drm/kms/atomic: Improved the func
 drm_atomic_set_crtc_for_connector
To:     Satendra Singh Thakur <satendra.t@samsung.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     vineet.j@samsung.com, hemanshu.s@samsung.com, sst2005@gmail.com
References: <CGME20180730061450epcas5p137fd022ec7fda83eeadea2102a62ae4f@epcas5p1.samsung.com>
 <20180730061450epcas5p137fd022ec7fda83eeadea2102a62ae4f~GEOMmSYCD1391313913epcas5p1G@epcas5p1.samsung.com>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Message-ID: <4fd92ffb-2518-1e9a-881e-5f4b0e4d4922@linux.intel.com>
Date:   Mon, 30 Jul 2018 10:00:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180730061450epcas5p137fd022ec7fda83eeadea2102a62ae4f~GEOMmSYCD1391313913epcas5p1G@epcas5p1.samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Op 30-07-18 om 08:14 schreef Satendra Singh Thakur:
> a. Used drm_atomic_get_crtc_state instead of drm_atomic_get_new_crtc_state.
>    Anyway new_state and state are same, this should make no difference.
>    This change will make the code of this func and the func
>    drm_atomic_set_crtc_for_plane similar.
> b. Added error checking after this func call
> c. Currently conn_state->crtc is getting assigned a value at two places
>    We can just reduce this assignment to one
>
> Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
> ---
>  drivers/gpu/drm/drm_atomic.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 895741e..907fb2d 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -1552,16 +1552,16 @@ drm_atomic_set_crtc_for_connector(struct drm_connector_state *conn_state,
>  		return 0;
>  
>  	if (conn_state->crtc) {
> -		crtc_state = drm_atomic_get_new_crtc_state(conn_state->state,
> +		crtc_state = drm_atomic_get_crtc_state(conn_state->state,
>  							   conn_state->crtc);
> +		if (IS_ERR(crtc_state))
> +			return PTR_ERR(crtc_state);
The error checking is not required when using drm_atomic_get_new_crtc_state,
because the end of drm_atomic_get_connector_state() will fetch it for us.

The other place where conn_state->crtc is assigned is in drm_atomic_set_crtc_for_connector(),
which also makes sure we have the crtc_state part of the commit.

It would be a bug if we would have a conn_state without conn_state->crtc's state.
Did you hit a crash here?
>  		crtc_state->connector_mask &=
>  			~(1 << drm_connector_index(conn_state->connector));
>  
>  		drm_connector_put(conn_state->connector);
> -		conn_state->crtc = NULL;
>  	}
> -
>  	if (crtc) {
>  		crtc_state = drm_atomic_get_crtc_state(conn_state->state, crtc);
>  		if (IS_ERR(crtc_state))
> @@ -1571,7 +1571,6 @@ drm_atomic_set_crtc_for_connector(struct drm_connector_state *conn_state,
>  			1 << drm_connector_index(conn_state->connector);
>  
>  		drm_connector_get(conn_state->connector);
> -		conn_state->crtc = crtc;
>  
>  		DRM_DEBUG_ATOMIC("Link connector state %p to [CRTC:%d:%s]\n",
>  				 conn_state, crtc->base.id, crtc->name);
> @@ -1579,7 +1578,7 @@ drm_atomic_set_crtc_for_connector(struct drm_connector_state *conn_state,
>  		DRM_DEBUG_ATOMIC("Link connector state %p to [NOCRTC]\n",
>  				 conn_state);
>  	}
> -
> +	conn_state->crtc = crtc;
>  	return 0;
>  }
>  EXPORT_SYMBOL(drm_atomic_set_crtc_for_connector);

~Maarten

