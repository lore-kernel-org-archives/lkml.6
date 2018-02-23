Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751801AbeBWSP6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 13:15:58 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:44291 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751420AbeBWSP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 13:15:56 -0500
X-Google-Smtp-Source: AG47ELtnaSzjCLfaXNl1he8fNAVhG6NhRZ4dH+d04FKU9QvQi74alcngz4k8U9Sz6PZUmskUNpTHWXrC8waw/xUO1QI=
MIME-Version: 1.0
In-Reply-To: <20180223163056.GL223881@art_vandelay>
References: <20180223131758.18362-1-robdclark@gmail.com> <20180223131758.18362-5-robdclark@gmail.com>
 <20180223163056.GL223881@art_vandelay>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 23 Feb 2018 13:15:54 -0500
Message-ID: <CAF6AEGvAQu6zVO8d75YJgDLtpHJFxU0JGw8S7SR7HGOfMNPHXg@mail.gmail.com>
Subject: Re: [RFC 4/4] drm/msm/mdp5: writeback support
To: Sean Paul <seanpaul@chromium.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>, David Airlie <airlied@linux.ie>,
        Archit Taneja <architt@codeaurora.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sushmita Susheelendra <ssusheel@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 11:30 AM, Sean Paul <seanpaul@chromium.org> wrote:
> On Fri, Feb 23, 2018 at 08:17:54AM -0500, Rob Clark wrote:
>> In a way, based on the original writeback patch from Jilai Wang, but a
>> lot has shifted around since then.
>>
>> Signed-off-by: Rob Clark <robdclark@gmail.com>
>> ---
>>  drivers/gpu/drm/msm/Makefile              |   1 +
>>  drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c |  23 +-
>>  drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c  |  38 +++-
>>  drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h  |   7 +-
>>  drivers/gpu/drm/msm/disp/mdp5/mdp5_wb.c   | 367 ++++++++++++++++++++++++++++++
>>  drivers/gpu/drm/msm/dsi/dsi_host.c        |   4 +-
>>  6 files changed, 431 insertions(+), 9 deletions(-)
>>  create mode 100644 drivers/gpu/drm/msm/disp/mdp5/mdp5_wb.c
>>
>> diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
>> index cd40c050b2d7..c9f50adef2db 100644
>> --- a/drivers/gpu/drm/msm/Makefile
>> +++ b/drivers/gpu/drm/msm/Makefile
>> @@ -45,6 +45,7 @@ msm-y := \
>>       disp/mdp5/mdp5_mixer.o \
>>       disp/mdp5/mdp5_plane.o \
>>       disp/mdp5/mdp5_smp.o \
>> +     disp/mdp5/mdp5_wb.o \
>>       msm_atomic.o \
>>       msm_debugfs.o \
>>       msm_drv.o \
>> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
>> index 9893e43ba6c5..b00ca88b741d 100644
>> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
>> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
>> @@ -484,7 +484,11 @@ static void mdp5_crtc_atomic_enable(struct drm_crtc *crtc,
>>       }
>>
>>       /* Restore vblank irq handling after power is enabled */
>> -     drm_crtc_vblank_on(crtc);
>> +// TODO we can't ->get_scanout_pos() for wb (since virtual intf)..
>> +// perhaps drm core should be clever enough not to drm_reset_vblank_timestamp()
>> +// for virtual encoders / writeback?
>> +     if (mdp5_cstate->pipeline.intf->type != INTF_WB)
>> +             drm_crtc_vblank_on(crtc);
>>
>>       mdp5_crtc_mode_set_nofb(crtc);
>>
>> @@ -518,7 +522,11 @@ int mdp5_crtc_setup_pipeline(struct drm_crtc *crtc,
>>               u32 caps;
>>               int ret;
>>
>> -             caps = MDP_LM_CAP_DISPLAY;
>> +             if (pipeline->intf->type == INTF_WB)
>> +                     caps = MDP_LM_CAP_WB;
>> +             else
>> +                     caps = MDP_LM_CAP_DISPLAY;
>> +
>>               if (need_right_mixer)
>>                       caps |= MDP_LM_CAP_PAIR;
>>
>> @@ -545,6 +553,7 @@ int mdp5_crtc_setup_pipeline(struct drm_crtc *crtc,
>>       mdp5_cstate->err_irqmask = intf2err(intf->num);
>>       mdp5_cstate->vblank_irqmask = intf2vblank(pipeline->mixer, intf);
>>
>> +// XXX should we be treating WB as cmd_mode??
>>       if ((intf->type == INTF_DSI) &&
>>           (intf->mode == MDP5_INTF_DSI_MODE_COMMAND)) {
>>               mdp5_cstate->pp_done_irqmask = lm2ppdone(pipeline->mixer);
>> @@ -639,8 +648,12 @@ static int mdp5_crtc_atomic_check(struct drm_crtc *crtc,
>>       }
>>
>>       /* bail out early if there aren't any planes */
>> -     if (!cnt)
>> -             return 0;
>> +     if (!cnt) {
>> +             if (!state->active)
>> +                     return 0;
>> +             dev_err(dev->dev, "%s has no planes!\n", crtc->name);
>> +             return -EINVAL;
>> +     }
>
> This seems unrelated?
>

hmm, yeah, kinda.  It was a case that I hit before working out all the
bugs in my kmscube writeback mode, but I guess isn't directly related
to wb.

>>
>>       hw_cfg = mdp5_cfg_get_hw_config(mdp5_kms->cfg);
>>
>> @@ -1160,7 +1173,7 @@ void mdp5_crtc_wait_for_commit_done(struct drm_crtc *crtc)
>>
>>       if (mdp5_cstate->cmd_mode)
>>               mdp5_crtc_wait_for_pp_done(crtc);
>> -     else
>> +     else if (mdp5_cstate->pipeline.intf->type != INTF_WB)
>>               mdp5_crtc_wait_for_flush_done(crtc);
>>  }
>>
>> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
>> index 1f44d8f15ce1..239010905637 100644
>> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
>> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
>> @@ -427,7 +427,8 @@ static int modeset_init(struct mdp5_kms *mdp5_kms)
>>        * the MDP5 interfaces) than the number of layer mixers present in HW,
>>        * but let's be safe here anyway
>>        */
>> -     num_crtcs = min(priv->num_encoders, mdp5_kms->num_hwmixers);
>> +     num_crtcs = min(priv->num_encoders + hw_cfg->wb.count,
>> +                     mdp5_kms->num_hwmixers);
>>
>>       /*
>>        * Construct planes equaling the number of hw pipes, and CRTCs for the
>> @@ -482,6 +483,33 @@ static int modeset_init(struct mdp5_kms *mdp5_kms)
>>               encoder->possible_crtcs = (1 << priv->num_crtcs) - 1;
>>       }
>>
>> +     /*
>> +      * Lastly, construct writeback connectors.
>> +      */
>> +     for (i = 0; i < hw_cfg->wb.count; i++) {
>> +             struct drm_writeback_connector *wb_conn;
>> +             struct mdp5_ctl *ctl;
>> +
>> +             ctl = mdp5_ctlm_request(mdp5_kms->ctlm, -1);
>> +             if (!ctl) {
>> +                     dev_err(dev->dev,
>> +                             "failed to allocate ctl for writeback %d\n", i);
>> +                     continue;
>> +             }
>> +
>> +             wb_conn = mdp5_wb_connector_init(dev, ctl,
>> +                             hw_cfg->wb.instances[i].id);
>> +             if (IS_ERR(wb_conn)) {
>> +                     ret = PTR_ERR(wb_conn);
>> +                     dev_err(dev->dev,
>> +                             "failed to construct writeback connector %d (%d)\n",
>> +                             i, ret);
>> +                     goto fail;
>> +             }
>> +
>> +             wb_conn->encoder.possible_crtcs = (1 << priv->num_crtcs) - 1;
>> +     }
>> +
>>       return 0;
>>
>>  fail:
>> @@ -555,6 +583,10 @@ static bool mdp5_get_scanoutpos(struct drm_device *dev, unsigned int pipe,
>>               return false;
>>       }
>>
>> +     /* unsupported for writeback: */
>> +     if (encoder->encoder_type == DRM_MODE_ENCODER_VIRTUAL)
>> +             return false;
>> +
>>       vsw = mode->crtc_vsync_end - mode->crtc_vsync_start;
>>       vbp = mode->crtc_vtotal - mode->crtc_vsync_end;
>>
>> @@ -610,6 +642,10 @@ static u32 mdp5_get_vblank_counter(struct drm_device *dev, unsigned int pipe)
>>       if (!encoder)
>>               return 0;
>>
>> +     /* unsupported for writeback: */
>> +     if (encoder->encoder_type == DRM_MODE_ENCODER_VIRTUAL)
>> +             return 0;
>> +
>>       return mdp5_encoder_get_framecount(encoder);
>>  }
>>
>> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h
>> index 425a03d213e5..be0f93ef33e1 100644
>> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h
>> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h
>> @@ -18,6 +18,8 @@
>>  #ifndef __MDP5_KMS_H__
>>  #define __MDP5_KMS_H__
>>
>> +#include <drm/drm_writeback.h>
>> +
>>  #include "msm_drv.h"
>>  #include "msm_kms.h"
>>  #include "disp/mdp_kms.h"
>> @@ -251,7 +253,7 @@ static inline uint32_t intf2vblank(struct mdp5_hw_mixer *mixer,
>>               return MDP5_IRQ_PING_PONG_0_RD_PTR << mixer->pp;
>>
>>       if (intf->type == INTF_WB)
>> -             return MDP5_IRQ_WB_2_DONE;
>> +             return MDP5_IRQ_WB_2_DONE | MDP5_IRQ_WB_0_DONE | MDP5_IRQ_WB_1_DONE;
>>
>>       switch (intf->num) {
>>       case 0:  return MDP5_IRQ_INTF0_VSYNC;
>> @@ -330,4 +332,7 @@ static inline int mdp5_cmd_encoder_set_split_display(
>>  }
>>  #endif
>>
>> +struct drm_writeback_connector *mdp5_wb_connector_init(struct drm_device *dev,
>> +             struct mdp5_ctl *ctl, unsigned wb_id);
>> +
>>  #endif /* __MDP5_KMS_H__ */
>> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_wb.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_wb.c
>> new file mode 100644
>> index 000000000000..3dabd0a1aa8b
>> --- /dev/null
>> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_wb.c
>> @@ -0,0 +1,367 @@
>> +/*
>> + * Copyright (C) 2018 Red Hat
>> + * Author: Rob Clark <robdclark@gmail.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2 as published by
>> + * the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along with
>> + * this program.  If not, see <http://www.gnu.org/licenses/>.
>
> SPDX license
>
>> + */
>> +
>> +#include "mdp5_kms.h"
>> +
>> +/*
>> + * Writeback connector/encoder implementation:
>> + */
>> +
>> +struct mdp5_wb_connector {
>> +     struct drm_writeback_connector base;
>> +
>> +     u32 nformats;
>> +     u32 formats[32];
>> +
>> +     unsigned id;
>> +     struct mdp5_ctl *ctl;
>> +     struct mdp5_interface *intf;
>> +
>> +     struct mdp_irq wb_done;
>> +};
>> +#define to_mdp5_wb_connector(x) container_of(x, struct mdp5_wb_connector, base)
>> +
>> +
>> +static void mdp5_wb_connector_atomic_commit(struct drm_connector *connector,
>> +             struct drm_writeback_job *job);
>> +
>> +static int mdp5_wb_connector_get_modes(struct drm_connector *connector)
>> +{
>> +     struct drm_device *dev = connector->dev;
>> +
>> +     return drm_add_modes_noedid(connector, dev->mode_config.max_width,
>> +                     dev->mode_config.max_height);
>
> I guess the plan is to let userspace provide user-defined modes for wb? Is it
> ever useful to have this token mode?

/me shrugs

I just copied this from the malidp wb patch.  This actually does add
multiple modes (all the dmt modes that fit within max width/height).
Not sure if that is useful or not.

>
>> +}
>> +
>> +static enum drm_mode_status
>> +mdp5_wb_connector_mode_valid(struct drm_connector *connector,
>> +             struct drm_display_mode *mode)
>> +{
>> +     struct drm_device *dev = connector->dev;
>> +     struct drm_mode_config *mode_config = &dev->mode_config;
>> +     int w = mode->hdisplay, h = mode->vdisplay;
>> +
>> +     if ((w < mode_config->min_width) || (w > mode_config->max_width))
>> +             return MODE_BAD_HVALUE;
>> +
>> +     if ((h < mode_config->min_height) || (h > mode_config->max_height))
>> +             return MODE_BAD_VVALUE;
>> +
>> +     return MODE_OK;
>> +}
>
> Might be useful for these to migrate into drm_writeback_connector.c as helpers.

Even the _get_modes(), tbh, since I think all of these ended up the
same as malidp..

>
>> +
>> +const struct drm_connector_helper_funcs mdp5_wb_connector_helper_funcs = {
>> +     .get_modes = mdp5_wb_connector_get_modes,
>> +     .mode_valid = mdp5_wb_connector_mode_valid,
>> +     .atomic_commit = mdp5_wb_connector_atomic_commit,
>> +};
>> +
>> +static enum drm_connector_status
>> +mdp5_wb_connector_detect(struct drm_connector *connector, bool force)
>> +{
>> +     return connector_status_disconnected;
>> +}
>
> This should be a helper as well.
>
>> +
>> +static void mdp5_wb_connector_destroy(struct drm_connector *connector)
>> +{
>> +     drm_connector_cleanup(connector);
>> +}
>
> Just use drm_connector_cleanup directly below
>

actually, I seem to have lost a fixup, there is some memory to free in
_destroy()

And I suspect we need a drm_writeback_connector_cleanup()..

>> +
>> +static const struct drm_connector_funcs mdp5_wb_connector_funcs = {
>> +     .reset = drm_atomic_helper_connector_reset,
>> +     .detect = mdp5_wb_connector_detect,
>> +     .fill_modes = drm_helper_probe_single_connector_modes,
>> +     .destroy = mdp5_wb_connector_destroy,
>> +     .atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
>> +     .atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>> +};
>> +
>> +static int
>> +mdp5_wb_encoder_atomic_check(struct drm_encoder *encoder,
>> +             struct drm_crtc_state *crtc_state,
>> +             struct drm_connector_state *conn_state)
>> +{
>> +     struct msm_drm_private *priv = encoder->dev->dev_private;
>> +     struct mdp5_crtc_state *mdp5_cstate = to_mdp5_crtc_state(crtc_state);
>> +     struct mdp5_wb_connector *mdp5_wb = to_mdp5_wb_connector(
>> +             to_wb_connector(conn_state->connector));
>> +     struct drm_framebuffer *fb;
>> +     const struct msm_format *format;
>> +     const struct mdp_format *mdp_fmt;
>> +     struct drm_format_name_buf format_name;
>> +     int ret;
>> +
>> +     if (!conn_state->writeback_job || !conn_state->writeback_job->fb)
>> +             return 0;
>> +
>> +     fb = conn_state->writeback_job->fb;
>> +
>> +     DBG("wb[%u]: check writeback %ux%u@%s", mdp5_wb->id,
>> +             fb->width, fb->height,
>> +             drm_get_format_name(fb->format->format, &format_name));
>> +
>> +     format = mdp_get_format(priv->kms, fb->format->format);
>> +     if (!format) {
>> +             DBG("Invalid pixel format!");
>> +             return -EINVAL;
>> +     }
>> +
>> +     mdp_fmt = to_mdp_format(format);
>> +     if (MDP_FORMAT_IS_YUV(mdp_fmt)) {
>> +             switch (mdp_fmt->chroma_sample) {
>> +             case CHROMA_420:
>> +             case CHROMA_H2V1:
>> +                     /* supported */
>> +                     break;
>> +             case CHROMA_H1V2:
>> +             default:
>> +                     DBG("unsupported wb chroma samp=%d\n",
>> +                             mdp_fmt->chroma_sample);
>> +                     return -EINVAL;
>> +             }
>> +     }
>> +
>> +     /* TODO I think we would prefer to have proper prepare_fb()/cleanup_fb()
>> +      * vfuncs, as with plane..  Also, where to unprepare?
>> +      */
>> +     ret = msm_framebuffer_prepare(fb, priv->kms->aspace);
>> +     if (ret)
>> +             return ret;
>> +
>> +     mdp5_cstate->ctl = mdp5_wb->ctl;
>> +     mdp5_cstate->pipeline.intf = mdp5_wb->intf;
>> +     mdp5_cstate->defer_start = true;
>> +
>> +     return 0;
>> +}
>> +
>> +static void
>> +wb_csc_setup(struct mdp5_kms *mdp5_kms, u32 wb_id, struct csc_cfg *csc)
>> +{
>> +     uint32_t  i;
>> +     uint32_t *matrix;
>> +
>> +     if (unlikely(!csc))
>> +             return;
>> +
>> +     matrix = csc->matrix;
>> +     mdp5_write(mdp5_kms, REG_MDP5_WB_CSC_MATRIX_COEFF_0(wb_id),
>> +             MDP5_WB_CSC_MATRIX_COEFF_0_COEFF_11(matrix[0]) |
>> +             MDP5_WB_CSC_MATRIX_COEFF_0_COEFF_12(matrix[1]));
>> +     mdp5_write(mdp5_kms, REG_MDP5_WB_CSC_MATRIX_COEFF_1(wb_id),
>> +             MDP5_WB_CSC_MATRIX_COEFF_1_COEFF_13(matrix[2]) |
>> +             MDP5_WB_CSC_MATRIX_COEFF_1_COEFF_21(matrix[3]));
>> +     mdp5_write(mdp5_kms, REG_MDP5_WB_CSC_MATRIX_COEFF_2(wb_id),
>> +             MDP5_WB_CSC_MATRIX_COEFF_2_COEFF_22(matrix[4]) |
>> +             MDP5_WB_CSC_MATRIX_COEFF_2_COEFF_23(matrix[5]));
>> +     mdp5_write(mdp5_kms, REG_MDP5_WB_CSC_MATRIX_COEFF_3(wb_id),
>> +             MDP5_WB_CSC_MATRIX_COEFF_3_COEFF_31(matrix[6]) |
>> +             MDP5_WB_CSC_MATRIX_COEFF_3_COEFF_32(matrix[7]));
>> +     mdp5_write(mdp5_kms, REG_MDP5_WB_CSC_MATRIX_COEFF_4(wb_id),
>> +             MDP5_WB_CSC_MATRIX_COEFF_4_COEFF_33(matrix[8]));
>> +
>> +     for (i = 0; i < ARRAY_SIZE(csc->pre_bias); i++) {
>> +             uint32_t *pre_clamp = csc->pre_clamp;
>> +             uint32_t *post_clamp = csc->post_clamp;
>> +
>> +             mdp5_write(mdp5_kms, REG_MDP5_WB_CSC_COMP_PRECLAMP(wb_id, i),
>> +                     MDP5_WB_CSC_COMP_PRECLAMP_REG_HIGH(pre_clamp[2*i+1]) |
>> +                     MDP5_WB_CSC_COMP_PRECLAMP_REG_LOW(pre_clamp[2*i]));
>> +
>> +             mdp5_write(mdp5_kms, REG_MDP5_WB_CSC_COMP_POSTCLAMP(wb_id, i),
>> +                     MDP5_WB_CSC_COMP_POSTCLAMP_REG_HIGH(post_clamp[2*i+1]) |
>> +                     MDP5_WB_CSC_COMP_POSTCLAMP_REG_LOW(post_clamp[2*i]));
>> +
>> +             mdp5_write(mdp5_kms, REG_MDP5_WB_CSC_COMP_PREBIAS(wb_id, i),
>> +                     MDP5_WB_CSC_COMP_PREBIAS_REG_VALUE(csc->pre_bias[i]));
>> +
>> +             mdp5_write(mdp5_kms, REG_MDP5_WB_CSC_COMP_POSTBIAS(wb_id, i),
>> +                     MDP5_WB_CSC_COMP_POSTBIAS_REG_VALUE(csc->post_bias[i]));
>> +     }
>> +}
>> +
>> +static void
>> +mdp5_wb_connector_atomic_commit(struct drm_connector *connector,
>> +             struct drm_writeback_job *job)
>> +{
>> +     struct msm_drm_private *priv = connector->dev->dev_private;
>> +     struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(priv->kms));
>> +     struct drm_connector_state *conn_state = connector->state;
>> +     struct drm_writeback_connector *wb_conn = to_wb_connector(connector);
>> +     struct mdp5_crtc_state *mdp5_crtc_state =
>> +             to_mdp5_crtc_state(wb_conn->encoder.crtc->state);
>> +     struct mdp5_wb_connector *mdp5_wb = to_mdp5_wb_connector(wb_conn);
>> +     struct drm_framebuffer *fb = job->fb;
>> +     struct drm_format_name_buf format_name;
>> +     const struct mdp_format *fmt =
>> +             to_mdp_format(mdp_get_format(priv->kms, fb->format->format));
>> +     u32 ystride0, ystride1, outsize;
>> +     u32 dst_format, pattern, opmode = 0;
>> +
>> +     DBG("wb[%u]: kick writeback %ux%u@%s", mdp5_wb->id,
>> +             fb->width, fb->height,
>> +             drm_get_format_name(fb->format->format, &format_name));
>> +
>> +     /* queue job before anything that can trigger completion irq */
>> +     drm_writeback_queue_job(wb_conn, job);
>> +     conn_state->writeback_job = NULL;
>> +
>> +     mdp_irq_register(&mdp5_kms->base, &mdp5_wb->wb_done);
>> +
>> +     if (MDP_FORMAT_IS_YUV(fmt)) {
>> +             wb_csc_setup(mdp5_kms, mdp5_wb->id,
>> +                     mdp_get_default_csc_cfg(CSC_RGB2YUV));
>> +
>> +             opmode |= MDP5_WB_DST_OP_MODE_CSC_EN |
>> +                     MDP5_WB_DST_OP_MODE_CSC_SRC_DATA_FORMAT(DATA_FORMAT_RGB) |
>> +                     MDP5_WB_DST_OP_MODE_CSC_DST_DATA_FORMAT(DATA_FORMAT_YUV);
>> +
>> +             switch (fmt->chroma_sample) {
>> +             case CHROMA_420:
>> +             case CHROMA_H2V1:
>> +                     opmode |= MDP5_WB_DST_OP_MODE_CHROMA_DWN_SAMPLE_EN;
>> +                     break;
>> +             case CHROMA_H1V2:
>> +             default:
>> +                     WARN(1, "unsupported wb chroma samp=%d\n",
>> +                             fmt->chroma_sample);
>> +                     return;
>> +             }
>> +     }
>> +
>> +     dst_format = MDP5_WB_DST_FORMAT_DST_CHROMA_SAMP(fmt->chroma_sample) |
>> +             MDP5_WB_DST_FORMAT_WRITE_PLANES(fmt->fetch_type) |
>> +             MDP5_WB_DST_FORMAT_DSTC3_OUT(fmt->bpc_a) |
>> +             MDP5_WB_DST_FORMAT_DSTC2_OUT(fmt->bpc_r) |
>> +             MDP5_WB_DST_FORMAT_DSTC1_OUT(fmt->bpc_b) |
>> +             MDP5_WB_DST_FORMAT_DSTC0_OUT(fmt->bpc_g) |
>> +             COND(fmt->unpack_tight, MDP5_WB_DST_FORMAT_PACK_TIGHT) |
>> +             MDP5_WB_DST_FORMAT_PACK_COUNT(fmt->unpack_count - 1) |
>> +             MDP5_WB_DST_FORMAT_DST_BPP(fmt->cpp - 1);
>> +
>> +     if (fmt->bpc_a || fmt->alpha_enable) {
>> +             dst_format |= MDP5_WB_DST_FORMAT_DSTC3_EN;
>> +             if (!fmt->alpha_enable)
>> +                     dst_format |= MDP5_WB_DST_FORMAT_DST_ALPHA_X;
>> +     }
>> +
>> +     pattern = MDP5_WB_DST_PACK_PATTERN_ELEMENT3(fmt->unpack[3]) |
>> +             MDP5_WB_DST_PACK_PATTERN_ELEMENT2(fmt->unpack[2]) |
>> +             MDP5_WB_DST_PACK_PATTERN_ELEMENT1(fmt->unpack[1]) |
>> +             MDP5_WB_DST_PACK_PATTERN_ELEMENT0(fmt->unpack[0]);
>> +
>> +     ystride0 = MDP5_WB_DST_YSTRIDE0_DST0_YSTRIDE(fb->pitches[0]) |
>> +             MDP5_WB_DST_YSTRIDE0_DST1_YSTRIDE(fb->pitches[1]);
>> +     ystride1 = MDP5_WB_DST_YSTRIDE1_DST2_YSTRIDE(fb->pitches[2]) |
>> +             MDP5_WB_DST_YSTRIDE1_DST3_YSTRIDE(fb->pitches[3]);
>> +
>> +     /* get the output resolution from WB device */
>> +     outsize = MDP5_WB_OUT_SIZE_DST_H(fb->height) |
>> +             MDP5_WB_OUT_SIZE_DST_W(fb->width);
>> +
>> +     mdp5_write(mdp5_kms, REG_MDP5_WB_ALPHA_X_VALUE(mdp5_wb->id), 0xff);
>> +     mdp5_write(mdp5_kms, REG_MDP5_WB_DST_FORMAT(mdp5_wb->id), dst_format);
>> +     mdp5_write(mdp5_kms, REG_MDP5_WB_DST_OP_MODE(mdp5_wb->id), opmode);
>> +     mdp5_write(mdp5_kms, REG_MDP5_WB_DST_PACK_PATTERN(mdp5_wb->id), pattern);
>> +     mdp5_write(mdp5_kms, REG_MDP5_WB_DST_YSTRIDE0(mdp5_wb->id), ystride0);
>> +     mdp5_write(mdp5_kms, REG_MDP5_WB_DST_YSTRIDE1(mdp5_wb->id), ystride1);
>> +     mdp5_write(mdp5_kms, REG_MDP5_WB_OUT_SIZE(mdp5_wb->id), outsize);
>> +
>> +     mdp5_crtc_set_pipeline(wb_conn->encoder.crtc);
>> +
>> +     mdp5_write(mdp5_kms, REG_MDP5_WB_DST0_ADDR(mdp5_wb->id),
>> +             msm_framebuffer_iova(fb, priv->kms->aspace, 0));
>> +     mdp5_write(mdp5_kms, REG_MDP5_WB_DST1_ADDR(mdp5_wb->id),
>> +             msm_framebuffer_iova(fb, priv->kms->aspace, 1));
>> +     mdp5_write(mdp5_kms, REG_MDP5_WB_DST2_ADDR(mdp5_wb->id),
>> +             msm_framebuffer_iova(fb, priv->kms->aspace, 2));
>> +     mdp5_write(mdp5_kms, REG_MDP5_WB_DST3_ADDR(mdp5_wb->id),
>> +             msm_framebuffer_iova(fb, priv->kms->aspace, 3));
>> +
>> +     /* Notify ctl that wb buffer is ready to trigger start */
>> +     mdp5_ctl_commit(mdp5_wb->ctl, &mdp5_crtc_state->pipeline,
>> +             MDP5_CTL_FLUSH_WB, true);
>> +
>> +     mdp5_ctl_set_encoder_state(mdp5_wb->ctl,
>> +             &mdp5_crtc_state->pipeline, true);
>> +}
>> +
>> +static void mdp5_wb_done_irq(struct mdp_irq *irq, uint32_t irqstatus)
>> +{
>> +     struct mdp5_wb_connector *mdp5_wb =
>> +             container_of(irq, struct mdp5_wb_connector, wb_done);
>> +     struct mdp5_crtc_state *mdp5_crtc_state =
>> +             to_mdp5_crtc_state(mdp5_wb->base.encoder.crtc->state);
>> +     struct msm_drm_private *priv = mdp5_wb->base.base.dev->dev_private;
>> +
>> +     mdp_irq_unregister(to_mdp_kms(priv->kms), &mdp5_wb->wb_done);
>> +
>> +     mdp5_ctl_set_encoder_state(mdp5_wb->ctl,
>> +             &mdp5_crtc_state->pipeline, false);
>> +
>> +     drm_writeback_signal_completion(&mdp5_wb->base, 0);
>> +}
>> +
>> +static const struct drm_encoder_helper_funcs mdp5_wb_encoder_helper_funcs = {
>> +     .atomic_check = mdp5_wb_encoder_atomic_check,
>> +};
>> +
>> +struct drm_writeback_connector *
>> +mdp5_wb_connector_init(struct drm_device *dev, struct mdp5_ctl *ctl,
>> +             unsigned wb_id)
>> +{
>> +     struct drm_connector *connector = NULL;
>> +     struct mdp5_wb_connector *mdp5_wb;
>> +
>> +     mdp5_wb = kzalloc(sizeof(*mdp5_wb), GFP_KERNEL);
>> +     if (!mdp5_wb)
>> +             return ERR_PTR(-ENOMEM);
>> +
>> +     mdp5_wb->id = wb_id;
>> +     mdp5_wb->ctl = ctl;
>> +
>> +     /* construct a dummy intf for WB: */
>> +// TODO un-inline this (and also in interface_init())
>> +     mdp5_wb->intf = kzalloc(sizeof(*mdp5_wb->intf), GFP_KERNEL);
>> +     mdp5_wb->intf->num = -1;
>> +     mdp5_wb->intf->type = INTF_WB;
>> +     mdp5_wb->intf->mode = MDP5_INTF_WB_MODE_LINE;
>> +     mdp5_wb->intf->idx = -1;
>> +
>> +     mdp5_wb->wb_done.irq = mdp5_wb_done_irq;
>> +// TODO just register for all wb irq's until I figure out the mapping..
>> +     mdp5_wb->wb_done.irqmask = MDP5_IRQ_WB_0_DONE | MDP5_IRQ_WB_1_DONE | MDP5_IRQ_WB_2_DONE;
>> +
>> +     connector = &mdp5_wb->base.base;
>> +
>> +     drm_connector_helper_add(connector, &mdp5_wb_connector_helper_funcs);
>> +
>> +     mdp5_wb->nformats = mdp_get_formats(mdp5_wb->formats,
>> +             ARRAY_SIZE(mdp5_wb->formats), false);
>> +
>> +     drm_writeback_connector_init(dev,
>> +             &mdp5_wb->base,
>> +             &mdp5_wb_connector_funcs,
>> +             &mdp5_wb_encoder_helper_funcs,
>> +             mdp5_wb->formats,
>> +             mdp5_wb->nformats);
>> +
>> +     connector->interlace_allowed = 0;
>> +     connector->doublescan_allowed = 0;
>
> These are handled by drm_writeback_connector_init (and kzalloc)

hmm, not doublescan_allowed, although perhaps it should be.

BR,
-R

>
>> +
>> +     return &mdp5_wb->base;
>> +}
>> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
>> index 7a03a9489708..422f524f7562 100644
>> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
>> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
>> @@ -741,7 +741,7 @@ static void dsi_intr_ctrl(struct msm_dsi_host *msm_host, u32 mask, int enable)
>>       else
>>               intr &= ~mask;
>>
>> -     DBG("intr=%x enable=%d", intr, enable);
>> +     VERB("intr=%x enable=%d", intr, enable);
>>
>>       dsi_write(msm_host, REG_DSI_INTR_CTRL, intr);
>>       spin_unlock_irqrestore(&msm_host->intr_lock, flags);
>> @@ -1465,7 +1465,7 @@ static irqreturn_t dsi_host_irq(int irq, void *ptr)
>>       dsi_write(msm_host, REG_DSI_INTR_CTRL, isr);
>>       spin_unlock_irqrestore(&msm_host->intr_lock, flags);
>>
>> -     DBG("isr=0x%x, id=%d", isr, msm_host->id);
>> +     VERB("isr=0x%x, id=%d", isr, msm_host->id);
>>
>>       if (isr & DSI_IRQ_ERROR)
>>               dsi_error(msm_host);
>> --
>> 2.14.3
>>
>
> --
> Sean Paul, Software Engineer, Google / Chromium OS
