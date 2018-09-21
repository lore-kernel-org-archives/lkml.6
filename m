Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE19ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A080B21532
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:12:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A080B21532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391323AbeIVBC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 21:02:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34649 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390726AbeIVBC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 21:02:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id t15so5932845wrx.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 12:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AsvpqIPUQZicoJiDjKAW6ZuncNweFxUUeLoqQl48ZFM=;
        b=tT4j+0TV2PAomj+QiHHfXDIWQq0pT6e5wjiQ+emuOTeKtiYlGYcLdnLIhZZGZegu9t
         og+pqyWEvTpZirvW5l0cIOYvsa1Vgmdg7Pg/ucgFDnQqmTelWD/RKeYahI+kgtt97nAS
         wpHUwh4+HnolkMLGGjj1uzkyferTEc2jbFdVa6HKT55vAdZo75NCTC1PN1M12MSDN6iE
         +2cC65JeIfHQxYNVUzfCBmvyK5WL/tJ6/t1zgCCq9JIyHFecu9F6KbgyX5vj7clZJGHI
         uRBLaLrIqisaGiwmf2f8c06cxNolFncbLvzJeWbcaWm8QZ/C08QHxMQp/lo80QXAlSBu
         uw3w==
X-Gm-Message-State: APzg51Ae0KMRP3QzOVwSgPO4zyIPL1LTpkgDLKQOFJZXLYNlrdgsg0xB
        zlsV/1LeRg9le3aaYUZL7wjLboj+8S8AVawxrjdbhA==
X-Google-Smtp-Source: ANB0VdbQTgdZuFmne6DxJQOAWZlrSXzOOY1huw8dRpO+KpkgCi5BKzTxZhcbdaMu1i8mpNdVCEra5L7NONoskJjg054=
X-Received: by 2002:adf:9ae5:: with SMTP id a92-v6mr41514327wrc.125.1537557161920;
 Fri, 21 Sep 2018 12:12:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:918b:0:0:0:0:0 with HTTP; Fri, 21 Sep 2018 12:12:41
 -0700 (PDT)
In-Reply-To: <20180914204407.1214-1-lyude@redhat.com>
References: <20180914204407.1214-1-lyude@redhat.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 21 Sep 2018 21:12:41 +0200
Message-ID: <CACO55tsK+hUds6HWTFXhuzAoozafs3E=LPfsjo=HskozvTpq8Q@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH] drm/nouveau: Grab runtime PM ref in nv50_mstc_detect()
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Karol Herbst <kherbst@redhat.com>

On Fri, Sep 14, 2018 at 10:44 PM, Lyude Paul <lyude@redhat.com> wrote:
> While we currently grab a runtime PM ref in nouveau's normal connector
> detection code, we apparently don't do this for MST. This means if we're
> in a scenario where the GPU is suspended and userspace attempts to do a
> connector probe on an MSTC connector, the probe will fail entirely due
> to the DP aux channel and GPU not being woken up:
>
> [  316.633489] nouveau 0000:01:00.0: i2c: aux 000a: begin idle timeout ffffffff
> [  316.635713] nouveau 0000:01:00.0: i2c: aux 000a: begin idle timeout ffffffff
> [  316.637785] nouveau 0000:01:00.0: i2c: aux 000a: begin idle timeout ffffffff
> ...
>
> So, grab a runtime PM ref here.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/gpu/drm/nouveau/dispnv50/disp.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> index c94b7f42d62d..9da0bdfe1e1c 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -938,9 +938,22 @@ static enum drm_connector_status
>  nv50_mstc_detect(struct drm_connector *connector, bool force)
>  {
>         struct nv50_mstc *mstc = nv50_mstc(connector);
> +       enum drm_connector_status conn_status;
> +       int ret;
> +
>         if (!mstc->port)
>                 return connector_status_disconnected;
> -       return drm_dp_mst_detect_port(connector, mstc->port->mgr, mstc->port);
> +
> +       ret = pm_runtime_get_sync(connector->dev->dev);
> +       if (ret < 0 && ret != -EACCES)
> +               return connector_status_disconnected;
> +
> +       conn_status = drm_dp_mst_detect_port(connector, mstc->port->mgr,
> +                                            mstc->port);
> +
> +       pm_runtime_mark_last_busy(connector->dev->dev);
> +       pm_runtime_put_autosuspend(connector->dev->dev);
> +       return conn_status;
>  }
>
>  static void
> --
> 2.17.1
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
