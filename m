Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96DBC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 15:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C6320C01
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 15:48:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92C6320C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbeKYCg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 21:36:56 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45679 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725751AbeKYCg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 21:36:56 -0500
Received: by mail-wr1-f65.google.com with SMTP id v6so14800333wrr.12
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 07:48:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OjhJCjMt7u09adr1dgAc7D9jMAkviYNcYunaoMSCEio=;
        b=DSB5QXSkMrntaDCBrLGbnrWSkDY+pHJtRAxKhduQTio5k5q9uTBrvetuM/VaElsSJh
         dnAfVB7065wHf41lxud7CvrhW3lmeCdTTj8a+ivd7QwFeWCWQRAi62FIt7Ipns3B8ZJ9
         3YOgAEynArxCIKaeju8o8lvxH6Mihg+XeVd59N06A5smuxP7XuCAg7DRbKP6z0FSm7qm
         IswMTSrEAnFv2ooB39LwzWkniqjNDNVpKD3tPRUG0YqiKg4mQh2zXgIH0PM4LBqTcqfH
         jokcCw0CFTxkDQ34MrjQ5HpKXlaJ6E6NmMm+gbh03j82jmktf1uEYdhrdEvWD7RBjuRO
         4Q9A==
X-Gm-Message-State: AA+aEWa3wROgp9ZRhtVUFF6867vHhekoanNkQhCsPZaMmrQmmQQKodiq
        6IzxwQmXyF4H1Rvjp6HJigTeMOmwckd7krTXkdw9/w==
X-Google-Smtp-Source: AFSGD/UJKCO3TiThIiN5R0b7HN0rM7Pv69Oxjfpf6F/QQEgEJw1FLPojddPOfsKtCbP1lGighjfamPndyx/h0c4q6qA=
X-Received: by 2002:adf:9168:: with SMTP id j95mr1864429wrj.217.1543074492668;
 Sat, 24 Nov 2018 07:48:12 -0800 (PST)
MIME-Version: 1.0
References: <20181117015024.5771-1-lyude@redhat.com> <20181117015024.5771-3-lyude@redhat.com>
In-Reply-To: <20181117015024.5771-3-lyude@redhat.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Sat, 24 Nov 2018 16:47:59 +0100
Message-ID: <CACO55ts3DZuvj3d-gSHXcrv4wGkbzxvCsZ4qYgjqjCkQxKq_dA@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 2/2] drm/nouveau: Grab an rpm reference
 before/after DP AUX transactions
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Ben Skeggs <bskeggs@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

why the nouveau_is_rpm_worker stuff?
On Sat, Nov 17, 2018 at 2:50 AM Lyude Paul <lyude@redhat.com> wrote:
>
> Now that we have ->pre_transfer() and ->post_transfer() for DP AUX
> channel devices, we can implement these hooks in order to ensure that
> the GPU is actually woken up before AUX transactions happen. This fixes
> /dev/drm_dp_aux* not working while the GPU is suspended, along with some
> more rare issues where the GPU might runtime-suspend if the time between
> two DP AUX channel transactions ends up being longer then the runtime
> suspend delay (sometimes observed on KASAN kernels where everything is
> slow).
>
> Additionally, we add tracking for the current task that's running our
> runtime suspend/resume callbacks. We need this in order to avoid trying
> to grab a runtime power reference when nouveau uses the DP AUX channel
> for MST suspend/resume in it's runtime susped/resume callbacks.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_connector.c | 36 +++++++++++++++++++++
>  drivers/gpu/drm/nouveau/nouveau_drm.c       | 12 ++++++-
>  drivers/gpu/drm/nouveau/nouveau_drv.h       |  8 +++++
>  3 files changed, 55 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
> index fd80661dff92..d2e9752f2f91 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> @@ -1171,6 +1171,38 @@ nouveau_connector_hotplug(struct nvif_notify *notify)
>         return NVIF_NOTIFY_KEEP;
>  }
>
> +static int
> +nouveau_connector_aux_pre_xfer(struct drm_dp_aux *obj)
> +{
> +       struct nouveau_connector *nv_connector =
> +               container_of(obj, typeof(*nv_connector), aux);
> +       struct nouveau_drm *drm = nouveau_drm(nv_connector->base.dev);
> +       int ret;
> +
> +       if (nouveau_is_rpm_worker(drm))
> +               return 0;
> +
> +       ret = pm_runtime_get_sync(drm->dev->dev);
> +       if (ret < 0 && ret != -EAGAIN)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +static void
> +nouveau_connector_aux_post_xfer(struct drm_dp_aux *obj)
> +{
> +       struct nouveau_connector *nv_connector =
> +               container_of(obj, typeof(*nv_connector), aux);
> +       struct nouveau_drm *drm = nouveau_drm(nv_connector->base.dev);
> +
> +       if (nouveau_is_rpm_worker(drm))
> +               return;
> +
> +       pm_runtime_mark_last_busy(drm->dev->dev);
> +       pm_runtime_put_autosuspend(drm->dev->dev);
> +}
> +
>  static ssize_t
>  nouveau_connector_aux_xfer(struct drm_dp_aux *obj, struct drm_dp_aux_msg *msg)
>  {
> @@ -1341,6 +1373,10 @@ nouveau_connector_create(struct drm_device *dev, int index)
>         case DRM_MODE_CONNECTOR_DisplayPort:
>         case DRM_MODE_CONNECTOR_eDP:
>                 nv_connector->aux.dev = dev->dev;
> +               nv_connector->aux.pre_transfer =
> +                       nouveau_connector_aux_pre_xfer;
> +               nv_connector->aux.post_transfer =
> +                       nouveau_connector_aux_post_xfer;
>                 nv_connector->aux.transfer = nouveau_connector_aux_xfer;
>                 ret = drm_dp_aux_register(&nv_connector->aux);
>                 if (ret) {
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
> index 2b2baf6e0e0d..4323e9e61c2e 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -859,6 +859,7 @@ nouveau_pmops_runtime_suspend(struct device *dev)
>  {
>         struct pci_dev *pdev = to_pci_dev(dev);
>         struct drm_device *drm_dev = pci_get_drvdata(pdev);
> +       struct nouveau_drm *drm = nouveau_drm(drm_dev);
>         int ret;
>
>         if (!nouveau_pmops_runtime()) {
> @@ -866,6 +867,8 @@ nouveau_pmops_runtime_suspend(struct device *dev)
>                 return -EBUSY;
>         }
>
> +       drm->rpm_task = current;
> +
>         nouveau_switcheroo_optimus_dsm();
>         ret = nouveau_do_suspend(drm_dev, true);
>         pci_save_state(pdev);
> @@ -873,6 +876,8 @@ nouveau_pmops_runtime_suspend(struct device *dev)
>         pci_ignore_hotplug(pdev);
>         pci_set_power_state(pdev, PCI_D3cold);
>         drm_dev->switch_power_state = DRM_SWITCH_POWER_DYNAMIC_OFF;
> +
> +       drm->rpm_task = NULL;
>         return ret;
>  }
>
> @@ -881,6 +886,7 @@ nouveau_pmops_runtime_resume(struct device *dev)
>  {
>         struct pci_dev *pdev = to_pci_dev(dev);
>         struct drm_device *drm_dev = pci_get_drvdata(pdev);
> +       struct nouveau_drm *drm = nouveau_drm(drm_dev);
>         struct nvif_device *device = &nouveau_drm(drm_dev)->client.device;
>         int ret;
>
> @@ -889,11 +895,13 @@ nouveau_pmops_runtime_resume(struct device *dev)
>                 return -EBUSY;
>         }
>
> +       drm->rpm_task = current;
> +
>         pci_set_power_state(pdev, PCI_D0);
>         pci_restore_state(pdev);
>         ret = pci_enable_device(pdev);
>         if (ret)
> -               return ret;
> +               goto out;
>         pci_set_master(pdev);
>
>         ret = nouveau_do_resume(drm_dev, true);
> @@ -905,6 +913,8 @@ nouveau_pmops_runtime_resume(struct device *dev)
>         /* Monitors may have been connected / disconnected during suspend */
>         schedule_work(&nouveau_drm(drm_dev)->hpd_work);
>
> +out:
> +       drm->rpm_task = NULL;
>         return ret;
>  }
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h b/drivers/gpu/drm/nouveau/nouveau_drv.h
> index 0b2191fa96f7..e8d4203ddfb4 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drv.h
> +++ b/drivers/gpu/drm/nouveau/nouveau_drv.h
> @@ -212,6 +212,8 @@ struct nouveau_drm {
>         bool have_disp_power_ref;
>
>         struct dev_pm_domain vga_pm_domain;
> +
> +       struct task_struct *rpm_task;
>  };
>
>  static inline struct nouveau_drm *
> @@ -231,6 +233,12 @@ int nouveau_pmops_suspend(struct device *);
>  int nouveau_pmops_resume(struct device *);
>  bool nouveau_pmops_runtime(void);
>
> +static inline bool
> +nouveau_is_rpm_worker(struct nouveau_drm *drm)
> +{
> +       return drm->rpm_task == current;
> +}
> +
>  #include <nvkm/core/tegra.h>
>
>  struct drm_device *
> --
> 2.19.1
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
