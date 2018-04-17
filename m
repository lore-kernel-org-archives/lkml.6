Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752634AbeDQJAs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 05:00:48 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40146 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeDQJAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 05:00:44 -0400
X-Google-Smtp-Source: AIpwx49npCYs3NL2e42Iu+KFoJiGs2W514Cx+rlre3PoHS5C2Cps2kAiPxz8SehJ9Hct0hXN66RCTg==
Date: Tue, 17 Apr 2018 11:00:40 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1 3/4] drm/tegra: plane: Add custom colorkey properties
 for older Tegra's
Message-ID: <20180417090040.GY31310@phenom.ffwll.local>
Mail-Followup-To: Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <cover.1523880381.git.digetx@gmail.com>
 <d78f7339de922d6a8114c73f0919534f4195f572.1523880381.git.digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d78f7339de922d6a8114c73f0919534f4195f572.1523880381.git.digetx@gmail.com>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 03:16:27PM +0300, Dmitry Osipenko wrote:
> Colorkey'ing allows to draw on top of overlapping planes, like for example
> on top of a video plane. Older Tegra's have a limited colorkey'ing
> capability such that blending features are reduced when colorkey'ing is
> enabled. In particular dependent weighting isn't possible, meaning that
> cursors plane can't be displayed properly. In most cases it is more useful
> to display content on top of video overlay, sacrificing mouse cursor
> in the area of three planes intersection with colorkey mismatch. This
> patch adds a custom colorkey properties to primary plane and CRTC's of
> older Tegra's, allowing userspace like Opentegra Xorg driver to implement
> colorkey support for XVideo extension.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Since this is your own uapi, where's the userspace per

https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#open-source-userspace-requirements

And why wo we need a tegra-private colorkey property here? I thought
other's have been discussing this in the context of other drivers.
-Daniel

> ---
>  drivers/gpu/drm/tegra/dc.c    | 166 ++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/tegra/dc.h    |  18 +++-
>  drivers/gpu/drm/tegra/plane.c |  40 ++++++++
>  drivers/gpu/drm/tegra/plane.h |   9 +-
>  4 files changed, 231 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> index a54eefea2513..b19e954a223f 100644
> --- a/drivers/gpu/drm/tegra/dc.c
> +++ b/drivers/gpu/drm/tegra/dc.c
> @@ -172,6 +172,24 @@ static void tegra_plane_setup_blending_legacy(struct tegra_plane *plane)
>  
>  	state = to_tegra_plane_state(plane->base.state);
>  
> +	/*
> +	 * Assuming default zPos window order, enable color keying for cases
> +	 * of overlapping with topping windows, excluding overlap with
> +	 * window B. Due to limited HW capabilities, this allows to draw
> +	 * primary plane on top of video overlay in areas where key isn't
> +	 * matching. Though window C will be completely transparent in a
> +	 * region of three windows intersection + key mismatch.
> +	 */
> +	if (state->ckey0_enabled) {
> +		background[0] |= BLEND_COLOR_KEY_0;
> +		background[2] |= BLEND_COLOR_KEY_0;
> +	}
> +
> +	if (state->ckey1_enabled) {
> +		background[0] |= BLEND_COLOR_KEY_1;
> +		background[2] |= BLEND_COLOR_KEY_1;
> +	}
> +
>  	if (state->opaque) {
>  		/*
>  		 * Since custom fix-weight blending isn't utilized and weight
> @@ -729,6 +747,35 @@ static unsigned long tegra_plane_get_possible_crtcs(struct drm_device *drm)
>  	return 1 << drm->mode_config.num_crtc;
>  }
>  
> +static void tegra_plane_create_legacy_properties(struct tegra_plane *plane,
> +						 struct drm_device *drm)
> +{
> +	plane->props.color_key0 = drm_property_create_bool(
> +						drm, 0, "color key 0");
> +	plane->props.color_key1 = drm_property_create_bool(
> +						drm, 0, "color key 1");
> +
> +	if (!plane->props.color_key0 ||
> +	    !plane->props.color_key1)
> +		goto err_cleanup;
> +
> +	drm_object_attach_property(&plane->base.base, plane->props.color_key0,
> +				   false);
> +	drm_object_attach_property(&plane->base.base, plane->props.color_key1,
> +				   false);
> +
> +	return;
> +
> +err_cleanup:
> +	if (plane->props.color_key0)
> +		drm_property_destroy(drm, plane->props.color_key0);
> +
> +	if (plane->props.color_key1)
> +		drm_property_destroy(drm, plane->props.color_key1);
> +
> +	dev_err(plane->dc->dev, "failed to create legacy plane properties\n");
> +}
> +
>  static struct drm_plane *tegra_primary_plane_create(struct drm_device *drm,
>  						    struct tegra_dc *dc)
>  {
> @@ -764,6 +811,9 @@ static struct drm_plane *tegra_primary_plane_create(struct drm_device *drm,
>  	drm_plane_helper_add(&plane->base, &tegra_plane_helper_funcs);
>  	drm_plane_create_zpos_property(&plane->base, plane->index, 0, 255);
>  
> +	if (dc->soc->legacy_blending)
> +		tegra_plane_create_legacy_properties(plane, drm);
> +
>  	return &plane->base;
>  }
>  
> @@ -1153,6 +1203,8 @@ tegra_crtc_atomic_duplicate_state(struct drm_crtc *crtc)
>  	copy->pclk = state->pclk;
>  	copy->div = state->div;
>  	copy->planes = state->planes;
> +	copy->ckey0 = state->ckey0;
> +	copy->ckey1 = state->ckey1;
>  
>  	return &copy->base;
>  }
> @@ -1537,6 +1589,50 @@ static void tegra_dc_disable_vblank(struct drm_crtc *crtc)
>  	tegra_dc_writel(dc, value, DC_CMD_INT_MASK);
>  }
>  
> +static int tegra_crtc_atomic_set_property(struct drm_crtc *crtc,
> +					  struct drm_crtc_state *state,
> +					  struct drm_property *property,
> +					  uint64_t value)
> +{
> +	struct tegra_dc_state *tegra_state = to_dc_state(state);
> +	struct tegra_dc *dc = to_tegra_dc(crtc);
> +
> +	if (property == dc->props.ckey0_lower)
> +		tegra_state->ckey0.lower = value;
> +	else if (property == dc->props.ckey0_upper)
> +		tegra_state->ckey0.upper = value;
> +	else if (property == dc->props.ckey1_lower)
> +		tegra_state->ckey1.lower = value;
> +	else if (property == dc->props.ckey1_upper)
> +		tegra_state->ckey1.upper = value;
> +	else
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int tegra_crtc_atomic_get_property(struct drm_crtc *crtc,
> +					  const struct drm_crtc_state *state,
> +					  struct drm_property *property,
> +					  uint64_t *value)
> +{
> +	struct tegra_dc_state *tegra_state = to_dc_state(state);
> +	struct tegra_dc *dc = to_tegra_dc(crtc);
> +
> +	if (property == dc->props.ckey0_lower)
> +		*value = tegra_state->ckey0.lower;
> +	else if (property == dc->props.ckey0_upper)
> +		*value = tegra_state->ckey0.upper;
> +	else if (property == dc->props.ckey1_lower)
> +		*value = tegra_state->ckey1.lower;
> +	else if (property == dc->props.ckey1_upper)
> +		*value = tegra_state->ckey1.upper;
> +	else
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  static const struct drm_crtc_funcs tegra_crtc_funcs = {
>  	.page_flip = drm_atomic_helper_page_flip,
>  	.set_config = drm_atomic_helper_set_config,
> @@ -1549,6 +1645,8 @@ static const struct drm_crtc_funcs tegra_crtc_funcs = {
>  	.get_vblank_counter = tegra_dc_get_vblank_counter,
>  	.enable_vblank = tegra_dc_enable_vblank,
>  	.disable_vblank = tegra_dc_disable_vblank,
> +	.atomic_set_property = tegra_crtc_atomic_set_property,
> +	.atomic_get_property = tegra_crtc_atomic_get_property,
>  };
>  
>  static int tegra_dc_set_timings(struct tegra_dc *dc,
> @@ -1883,6 +1981,18 @@ static void tegra_crtc_atomic_flush(struct drm_crtc *crtc,
>  	struct tegra_dc *dc = to_tegra_dc(crtc);
>  	u32 value;
>  
> +	if (dc->soc->legacy_blending) {
> +		tegra_dc_writel(dc, state->ckey0.lower,
> +				DC_DISP_COLOR_KEY0_LOWER);
> +		tegra_dc_writel(dc, state->ckey0.upper,
> +				DC_DISP_COLOR_KEY0_UPPER);
> +
> +		tegra_dc_writel(dc, state->ckey1.lower,
> +				DC_DISP_COLOR_KEY1_LOWER);
> +		tegra_dc_writel(dc, state->ckey1.upper,
> +				DC_DISP_COLOR_KEY1_UPPER);
> +	}
> +
>  	value = state->planes << 8 | GENERAL_UPDATE;
>  	tegra_dc_writel(dc, value, DC_CMD_STATE_CONTROL);
>  	value = tegra_dc_readl(dc, DC_CMD_STATE_CONTROL);
> @@ -1944,6 +2054,56 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> +static int tegra_dc_create_legacy_properties(struct tegra_dc *dc,
> +					     struct drm_device *drm)
> +{
> +	/*
> +	 * Each color key value is represented in RGB888 format.
> +	 * All planes share the same color key values and free to choose
> +	 * among the ckey0 and ckey1.
> +	 */
> +	dc->props.ckey0_lower = drm_property_create_range(
> +			drm, 0, "color key 0 lower margin", 0, 0xffffff);
> +	dc->props.ckey0_upper = drm_property_create_range(
> +			drm, 0, "color key 0 upper margin", 0, 0xffffff);
> +	dc->props.ckey1_lower = drm_property_create_range(
> +			drm, 0, "color key 1 lower margin", 0, 0xffffff);
> +	dc->props.ckey1_upper = drm_property_create_range(
> +			drm, 0, "color key 1 upper margin", 0, 0xffffff);
> +
> +	if (!dc->props.ckey0_lower ||
> +	    !dc->props.ckey0_upper ||
> +	    !dc->props.ckey1_lower ||
> +	    !dc->props.ckey1_upper)
> +		goto err_cleanup;
> +
> +	drm_object_attach_property(&dc->base.base, dc->props.ckey0_lower,
> +				   0x000000);
> +	drm_object_attach_property(&dc->base.base, dc->props.ckey0_upper,
> +				   0x000000);
> +	drm_object_attach_property(&dc->base.base, dc->props.ckey1_lower,
> +				   0x000000);
> +	drm_object_attach_property(&dc->base.base, dc->props.ckey1_upper,
> +				   0x000000);
> +
> +	return 0;
> +
> +err_cleanup:
> +	if (dc->props.ckey0_lower)
> +		drm_property_destroy(drm, dc->props.ckey0_lower);
> +
> +	if (dc->props.ckey0_upper)
> +		drm_property_destroy(drm, dc->props.ckey0_upper);
> +
> +	if (dc->props.ckey1_lower)
> +		drm_property_destroy(drm, dc->props.ckey1_lower);
> +
> +	if (dc->props.ckey1_upper)
> +		drm_property_destroy(drm, dc->props.ckey1_upper);
> +
> +	return -ENOMEM;
> +}
> +
>  static int tegra_dc_init(struct host1x_client *client)
>  {
>  	struct drm_device *drm = dev_get_drvdata(client->parent);
> @@ -2031,6 +2191,12 @@ static int tegra_dc_init(struct host1x_client *client)
>  		goto cleanup;
>  	}
>  
> +	if (dc->soc->legacy_blending) {
> +		err = tegra_dc_create_legacy_properties(dc, drm);
> +		if (err < 0)
> +			dev_err(dc->dev, "failed to create CRTC properties\n");
> +	}
> +
>  	return 0;
>  
>  cleanup:
> diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
> index 3156006e75c6..3913d047abac 100644
> --- a/drivers/gpu/drm/tegra/dc.h
> +++ b/drivers/gpu/drm/tegra/dc.h
> @@ -18,6 +18,11 @@
>  
>  struct tegra_output;
>  
> +struct tegra_dc_color_key_state {
> +	u32 lower;
> +	u32 upper;
> +};
> +
>  struct tegra_dc_state {
>  	struct drm_crtc_state base;
>  
> @@ -26,9 +31,13 @@ struct tegra_dc_state {
>  	unsigned int div;
>  
>  	u32 planes;
> +
> +	struct tegra_dc_color_key_state ckey0;
> +	struct tegra_dc_color_key_state ckey1;
>  };
>  
> -static inline struct tegra_dc_state *to_dc_state(struct drm_crtc_state *state)
> +static inline struct tegra_dc_state *
> +to_dc_state(const struct drm_crtc_state *state)
>  {
>  	if (state)
>  		return container_of(state, struct tegra_dc_state, base);
> @@ -94,6 +103,13 @@ struct tegra_dc {
>  	const struct tegra_dc_soc_info *soc;
>  
>  	struct iommu_domain *domain;
> +
> +	struct {
> +		struct drm_property *ckey0_lower;
> +		struct drm_property *ckey0_upper;
> +		struct drm_property *ckey1_lower;
> +		struct drm_property *ckey1_upper;
> +	} props;
>  };
>  
>  static inline struct tegra_dc *
> diff --git a/drivers/gpu/drm/tegra/plane.c b/drivers/gpu/drm/tegra/plane.c
> index 0406c2ef432c..4d794f2b44df 100644
> --- a/drivers/gpu/drm/tegra/plane.c
> +++ b/drivers/gpu/drm/tegra/plane.c
> @@ -57,6 +57,8 @@ tegra_plane_atomic_duplicate_state(struct drm_plane *plane)
>  	copy->format = state->format;
>  	copy->swap = state->swap;
>  	copy->opaque = state->opaque;
> +	copy->ckey0_enabled = state->ckey0_enabled;
> +	copy->ckey1_enabled = state->ckey1_enabled;
>  
>  	for (i = 0; i < 2; i++)
>  		copy->blending[i] = state->blending[i];
> @@ -86,6 +88,42 @@ static bool tegra_plane_format_mod_supported(struct drm_plane *plane,
>  	return false;
>  }
>  
> +static int tegra_plane_set_property(struct drm_plane *plane,
> +				    struct drm_plane_state *state,
> +				    struct drm_property *property,
> +				    uint64_t value)
> +{
> +	struct tegra_plane_state *tegra_state = to_tegra_plane_state(state);
> +	struct tegra_plane *tegra = to_tegra_plane(plane);
> +
> +	if (property == tegra->props.color_key0)
> +		tegra_state->ckey0_enabled = value;
> +	else if (property == tegra->props.color_key1)
> +		tegra_state->ckey1_enabled = value;
> +	else
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int tegra_plane_get_property(struct drm_plane *plane,
> +				    const struct drm_plane_state *state,
> +				    struct drm_property *property,
> +				    uint64_t *value)
> +{
> +	struct tegra_plane_state *tegra_state = to_tegra_plane_state(state);
> +	struct tegra_plane *tegra = to_tegra_plane(plane);
> +
> +	if (property == tegra->props.color_key0)
> +		*value = tegra_state->ckey0_enabled;
> +	else if (property == tegra->props.color_key1)
> +		*value = tegra_state->ckey1_enabled;
> +	else
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  const struct drm_plane_funcs tegra_plane_funcs = {
>  	.update_plane = drm_atomic_helper_update_plane,
>  	.disable_plane = drm_atomic_helper_disable_plane,
> @@ -94,6 +132,8 @@ const struct drm_plane_funcs tegra_plane_funcs = {
>  	.atomic_duplicate_state = tegra_plane_atomic_duplicate_state,
>  	.atomic_destroy_state = tegra_plane_atomic_destroy_state,
>  	.format_mod_supported = tegra_plane_format_mod_supported,
> +	.atomic_set_property = tegra_plane_set_property,
> +	.atomic_get_property = tegra_plane_get_property,
>  };
>  
>  int tegra_plane_state_add(struct tegra_plane *plane,
> diff --git a/drivers/gpu/drm/tegra/plane.h b/drivers/gpu/drm/tegra/plane.h
> index 7360ddfafee8..dafecea73b29 100644
> --- a/drivers/gpu/drm/tegra/plane.h
> +++ b/drivers/gpu/drm/tegra/plane.h
> @@ -19,6 +19,11 @@ struct tegra_plane {
>  	struct tegra_dc *dc;
>  	unsigned int offset;
>  	unsigned int index;
> +
> +	struct {
> +		struct drm_property *color_key0;
> +		struct drm_property *color_key1;
> +	} props;
>  };
>  
>  struct tegra_cursor {
> @@ -49,10 +54,12 @@ struct tegra_plane_state {
>  	/* used for legacy blending support only */
>  	struct tegra_plane_legacy_blending_state blending[2];
>  	bool opaque;
> +	bool ckey0_enabled;
> +	bool ckey1_enabled;
>  };
>  
>  static inline struct tegra_plane_state *
> -to_tegra_plane_state(struct drm_plane_state *state)
> +to_tegra_plane_state(const struct drm_plane_state *state)
>  {
>  	if (state)
>  		return container_of(state, struct tegra_plane_state, base);
> -- 
> 2.17.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
