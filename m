Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752031AbeEGL13 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 07:27:29 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36416 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751818AbeEGL10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 07:27:26 -0400
X-Google-Smtp-Source: AB8JxZqX61lh3T8kfB8EXWryUsXTh3Vw7XcAFleGEJudfWUWo310gEuuLe6mG3aVbVNN2syz3F3Jp+yzm7lWuxqHZ54=
MIME-Version: 1.0
In-Reply-To: <1525421338-1021-1-git-send-email-hl@rock-chips.com>
References: <1525421338-1021-1-git-send-email-hl@rock-chips.com>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Mon, 7 May 2018 13:27:24 +0200
Message-ID: <CAFqH_522eDgyknF+sRGyZzusL7Ld0o_N-SP1jXCG1iwmav-n0Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/rockchip: add transfer function for cdn-dp
To: Lin Huang <hl@rock-chips.com>
Cc: Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        Chris Zhong <zyw@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>,
        Doug Anderson <dianders@chromium.org>, jani.nikula@linux.intel.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, daniel.vetter@intel.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lin,

I am interested in these patches, could you cc me on newer versions? Thanks.

Some comments below.

2018-05-04 10:08 GMT+02:00 Lin Huang <hl@rock-chips.com>:
> From: Chris Zhong <zyw@rock-chips.com>
>
> We may support training outside firmware, so we need support
> dpcd read/write to get the message or do some setting with
> display.
>
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> ---
>  drivers/gpu/drm/rockchip/cdn-dp-core.c | 55 ++++++++++++++++++++++++----
>  drivers/gpu/drm/rockchip/cdn-dp-core.h |  1 +
>  drivers/gpu/drm/rockchip/cdn-dp-reg.c  | 66 +++++++++++++++++++++++++++++-----
>  drivers/gpu/drm/rockchip/cdn-dp-reg.h  | 14 ++++++--
>  4 files changed, 119 insertions(+), 17 deletions(-)
>

In general, for this patch and all the other patches in the series I
saw that checkpatch spits out some warnings, could you fix these and
ideally run checkpatch with the --strict --subjective option?

> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
> index c6fbdcd..268c190 100644
> --- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
> @@ -176,8 +176,8 @@ static int cdn_dp_get_sink_count(struct cdn_dp_device *dp, u8 *sink_count)
>         u8 value;
>
>         *sink_count = 0;
> -       ret = cdn_dp_dpcd_read(dp, DP_SINK_COUNT, &value, 1);
> -       if (ret)
> +       ret = drm_dp_dpcd_read(&dp->aux, DP_SINK_COUNT, &value, 1);
> +       if (ret < 0)
>                 return ret;
>
>         *sink_count = DP_GET_SINK_COUNT(value);
> @@ -374,9 +374,9 @@ static int cdn_dp_get_sink_capability(struct cdn_dp_device *dp)
>         if (!cdn_dp_check_sink_connection(dp))
>                 return -ENODEV;
>
> -       ret = cdn_dp_dpcd_read(dp, DP_DPCD_REV, dp->dpcd,
> -                              DP_RECEIVER_CAP_SIZE);
> -       if (ret) {
> +       ret = drm_dp_dpcd_read(&dp->aux, DP_DPCD_REV, dp->dpcd,
> +                              sizeof(dp->dpcd));
> +       if (ret < 0) {
>                 DRM_DEV_ERROR(dp->dev, "Failed to get caps %d\n", ret);
>                 return ret;
>         }
> @@ -582,8 +582,8 @@ static bool cdn_dp_check_link_status(struct cdn_dp_device *dp)
>         if (!port || !dp->link.rate || !dp->link.num_lanes)
>                 return false;
>
> -       if (cdn_dp_dpcd_read(dp, DP_LANE0_1_STATUS, link_status,
> -                            DP_LINK_STATUS_SIZE)) {
> +       if (drm_dp_dpcd_read_link_status(&dp->aux, link_status) !=
> +           DP_LINK_STATUS_SIZE) {
>                 DRM_ERROR("Failed to get link status\n");
>                 return false;
>         }
> @@ -1012,6 +1012,40 @@ static int cdn_dp_pd_event(struct notifier_block *nb,
>         return NOTIFY_DONE;
>  }
>
> +static ssize_t cdn_dp_aux_transfer(struct drm_dp_aux *aux,
> +                                  struct drm_dp_aux_msg *msg)
> +{
> +       struct cdn_dp_device *dp = container_of(aux, struct cdn_dp_device, aux);
> +       int ret;
> +       u8 status;
> +
> +       switch (msg->request & ~DP_AUX_I2C_MOT) {
> +       case DP_AUX_NATIVE_WRITE:
> +       case DP_AUX_I2C_WRITE:
> +       case DP_AUX_I2C_WRITE_STATUS_UPDATE:
> +               ret = cdn_dp_dpcd_write(dp, msg->address, msg->buffer,
> +                                       msg->size);
> +               break;
> +       case DP_AUX_NATIVE_READ:
> +       case DP_AUX_I2C_READ:
> +               ret = cdn_dp_dpcd_read(dp, msg->address, msg->buffer,
> +                                      msg->size);
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       status = cdn_dp_get_aux_status(dp);
> +       if (status == AUX_STAUS_ACK)
> +               msg->reply = DP_AUX_NATIVE_REPLY_ACK;
> +       else if (status == AUX_STAUS_NACK)
> +               msg->reply = DP_AUX_NATIVE_REPLY_NACK;
> +       else if (status == AUX_STAUS_DEFER)
> +               msg->reply = DP_AUX_NATIVE_REPLY_DEFER;
> +

I think that you would mean STATUS instead of STAUS on these defines.

What happens if the status is AUX_STATUS_SINK_ERROR or AUX_STATUS_BUS_ERROR?

> +       return ret;
> +}
> +
>  static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
>  {
>         struct cdn_dp_device *dp = dev_get_drvdata(dev);
> @@ -1030,6 +1064,13 @@ static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
>         dp->active = false;
>         dp->active_port = -1;
>         dp->fw_loaded = false;
> +       dp->aux.name = "DP-AUX";
> +       dp->aux.transfer = cdn_dp_aux_transfer;
> +       dp->aux.dev = dev;
> +
> +       ret = drm_dp_aux_register(&dp->aux);
> +       if (ret)
> +               return ret;
>
>         INIT_WORK(&dp->event_work, cdn_dp_pd_event_work);
>
> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.h b/drivers/gpu/drm/rockchip/cdn-dp-core.h
> index f57e296..46159b2 100644
> --- a/drivers/gpu/drm/rockchip/cdn-dp-core.h
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.h
> @@ -78,6 +78,7 @@ struct cdn_dp_device {
>         struct platform_device *audio_pdev;
>         struct work_struct event_work;
>         struct edid *edid;
> +       struct drm_dp_aux aux;
>
>         struct mutex lock;
>         bool connected;
> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.c b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
> index eb3042c..b2f532a 100644
> --- a/drivers/gpu/drm/rockchip/cdn-dp-reg.c
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
> @@ -221,7 +221,11 @@ static int cdn_dp_reg_write_bit(struct cdn_dp_device *dp, u16 addr,
>                                    sizeof(field), field);
>  }
>
> -int cdn_dp_dpcd_read(struct cdn_dp_device *dp, u32 addr, u8 *data, u16 len)
> +/*
> + * Returns the number of bytes transferred on success, or a negative error
> + * code on failure. -ETIMEDOUT is returned if mailbox message not send success;
> + */

Returns the number of bytes or -ETIMEDOUT, no other negative errors
can be returned, right?

I am not English native but the last phrase sounds incorrect to me,
I'd rephrase it: (open to suggestions)

 -ETIMEDOUT if fails to receive the mailbox message.

> +ssize_t cdn_dp_dpcd_read(struct cdn_dp_device *dp, u32 addr, u8 *data, u16 len)
>  {
>         u8 msg[5], reg[5];
>         int ret;
> @@ -247,24 +251,40 @@ int cdn_dp_dpcd_read(struct cdn_dp_device *dp, u32 addr, u8 *data, u16 len)
>                 goto err_dpcd_read;
>
>         ret = cdn_dp_mailbox_read_receive(dp, data, len);
> +       if (!ret)
> +               return len;
>
>  err_dpcd_read:
> +       DRM_DEV_ERROR(dp->dev, "dpcd read failed: %d\n", ret);
>         return ret;
>  }
>
> -int cdn_dp_dpcd_write(struct cdn_dp_device *dp, u32 addr, u8 value)
> +#define CDN_AUX_HEADER_SIZE    5
> +#define CDN_AUX_MSG_SIZE       20
> +/*
> + * Returns the number of bytes transferred on success, or a negative error
> + * code on failure. -ETIMEDOUT is returned if mailbox message not send success;

Same as above. Sounds incorrect to me.

> + * -EINVAL is return if get the wrong data size after message send.

Same here.

> + */
> +ssize_t cdn_dp_dpcd_write(struct cdn_dp_device *dp, u32 addr, u8 *data, u16 len)
>  {
> -       u8 msg[6], reg[5];
> +       u8 msg[CDN_AUX_MSG_SIZE + CDN_AUX_HEADER_SIZE];
> +       u8 reg[CDN_AUX_HEADER_SIZE];
>         int ret;
>
> -       msg[0] = 0;
> -       msg[1] = 1;
> +       if (WARN_ON(len > CDN_AUX_MSG_SIZE) || WARN_ON(len <= 0))
> +               return -EINVAL;
> +
> +       msg[0] = (len >> 8) & 0xff;
> +       msg[1] = len & 0xff;
>         msg[2] = (addr >> 16) & 0xff;
>         msg[3] = (addr >> 8) & 0xff;
>         msg[4] = addr & 0xff;
> -       msg[5] = value;
> +
> +       memcpy(msg + CDN_AUX_HEADER_SIZE, data, len);
> +
>         ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_WRITE_DPCD,
> -                                 sizeof(msg), msg);
> +                                 CDN_AUX_HEADER_SIZE + len, msg);
>         if (ret)
>                 goto err_dpcd_write;
>
> @@ -277,8 +297,12 @@ int cdn_dp_dpcd_write(struct cdn_dp_device *dp, u32 addr, u8 value)
>         if (ret)
>                 goto err_dpcd_write;
>
> -       if (addr != (reg[2] << 16 | reg[3] << 8 | reg[4]))
> +       if ((len != (reg[0] << 8 | reg[1])) ||
> +           (addr != (reg[2] << 16 | reg[3] << 8 | reg[4]))) {
>                 ret = -EINVAL;
> +       } else {
> +               return len;
> +       }
>
>  err_dpcd_write:
>         if (ret)
> @@ -286,6 +310,32 @@ int cdn_dp_dpcd_write(struct cdn_dp_device *dp, u32 addr, u8 value)
>         return ret;
>  }
>
> +int cdn_dp_get_aux_status(struct cdn_dp_device *dp)
> +{
> +       u8 status;
> +       int ret;
> +
> +       ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_GET_LAST_AUX_STAUS,
> +                                 0, NULL);
> +       if (ret)
> +               goto err_get_hpd;
> +
> +       ret = cdn_dp_mailbox_validate_receive(dp, MB_MODULE_ID_DP_TX,
> +                                             DPTX_GET_LAST_AUX_STAUS, sizeof(status));
> +       if (ret)
> +               goto err_get_hpd;
> +
> +       ret = cdn_dp_mailbox_read_receive(dp, &status, sizeof(status));
> +       if (ret)
> +               goto err_get_hpd;
> +
> +       return status;
> +
> +err_get_hpd:
> +       DRM_DEV_ERROR(dp->dev, "get aux status failed: %d\n", ret);
> +       return ret;
> +}
> +
>  int cdn_dp_load_firmware(struct cdn_dp_device *dp, const u32 *i_mem,
>                          u32 i_size, const u32 *d_mem, u32 d_size)
>  {
> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.h b/drivers/gpu/drm/rockchip/cdn-dp-reg.h
> index c4bbb4a83..aedf2dc 100644
> --- a/drivers/gpu/drm/rockchip/cdn-dp-reg.h
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.h
> @@ -328,6 +328,13 @@
>  #define GENERAL_BUS_SETTINGS            0x03
>  #define GENERAL_TEST_ACCESS             0x04
>
> +/* AUX status*/
> +#define AUX_STAUS_ACK                  0
> +#define AUX_STAUS_NACK                 1
> +#define AUX_STAUS_DEFER                        2
> +#define AUX_STAUS_SINK_ERROR           3
> +#define AUX_STAUS_BUS_ERROR            4
> +

For the five defines, s/STAUS/STATUS/

>  #define DPTX_SET_POWER_MNG                     0x00
>  #define DPTX_SET_HOST_CAPABILITIES             0x01
>  #define DPTX_GET_EDID                          0x02
> @@ -469,8 +476,11 @@ int cdn_dp_set_host_cap(struct cdn_dp_device *dp, u8 lanes, bool flip);
>  int cdn_dp_event_config(struct cdn_dp_device *dp);
>  u32 cdn_dp_get_event(struct cdn_dp_device *dp);
>  int cdn_dp_get_hpd_status(struct cdn_dp_device *dp);
> -int cdn_dp_dpcd_write(struct cdn_dp_device *dp, u32 addr, u8 value);
> -int cdn_dp_dpcd_read(struct cdn_dp_device *dp, u32 addr, u8 *data, u16 len);
> +ssize_t cdn_dp_dpcd_write(struct cdn_dp_device *dp, u32 addr,
> +                         u8 *data, u16 len);
> +ssize_t cdn_dp_dpcd_read(struct cdn_dp_device *dp, u32 addr,
> +                        u8 *data, u16 len);
> +int cdn_dp_get_aux_status(struct cdn_dp_device *dp);
>  int cdn_dp_get_edid_block(void *dp, u8 *edid,
>                           unsigned int block, size_t length);
>  int cdn_dp_train_link(struct cdn_dp_device *dp);
> --
> 2.7.4
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
