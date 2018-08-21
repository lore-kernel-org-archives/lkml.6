Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C1CC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C330214C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C330214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbeHUUOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:14:32 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33430 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbeHUUOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:14:31 -0400
Received: by mail-qt0-f194.google.com with SMTP id r37-v6so13742602qtc.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 09:53:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:mime-version
         :content-transfer-encoding;
        bh=SDKXSbh5mgR/zKSPdGYzaUv12cBLHu4VQN2jq/vQFuo=;
        b=RQg1Lq78/hRYJyk/+w9Z9HU5tUkqmXnQ/wliEFj/WWrXEENYRwMWtnReOc2deU+TYK
         22BZIY90YXvq49X3ZdCgvxOueA10w3gt8vYsh3fthbboE+7x2fPRRtQx1oumODBMmuuo
         sDwStwpuU3pGYqvzRrRDjNVmxyeCDzaEQuAkLmD/Co41apFecu9DO+luSLZ+YCd3FYXe
         FSMo20wH5fTVpFG+ljFeYo0SfyYjkBZqG1kK26p0Mdb15xKdoynIrx2mwKVOrnnSGvkG
         nHBOwCx75KK+Z7sX0Rv+6W62IqwFXeQriuDm7qCwRVU2kS0l26zuDnc4jgqubw8cBwVF
         wtaA==
X-Gm-Message-State: AOUpUlHZx+Du0nF4J8ac+KNYI3p9v9vcwfOd7cWJdBzSGuYHJyvhuYrA
        ndeAorIrIjao+w2HJAhGWA1Iqg==
X-Google-Smtp-Source: AA+uWPzOYxowT8vjDxleR+BMEa/UFXMyBjdZdwEKuqmylBuUvqW2l2Q+fs4Y0iPWdUzPfJ1ni+u9Ig==
X-Received: by 2002:a0c:b792:: with SMTP id l18-v6mr46803769qve.110.1534870415946;
        Tue, 21 Aug 2018 09:53:35 -0700 (PDT)
Received: from whitewolf.lyude.net (pool-72-74-165-95.bstnma.fios.verizon.net. [72.74.165.95])
        by smtp.gmail.com with ESMTPSA id d16-v6sm4070538qtd.7.2018.08.21.09.53.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 09:53:35 -0700 (PDT)
Message-ID: <7ca062538b41a4190eb6ef78c3f729ab784cfd40.camel@redhat.com>
Subject: Re: [PATCH 2/2] drm/nouveau: Fix GM107 disp dmac chan init on
 ThinkPad P50
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     nouveau@lists.freedesktop.org
Cc:     Karol Herbst <karolherbst@gmail.com>, stable@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Tue, 21 Aug 2018 12:53:33 -0400
In-Reply-To: <20180820172030.10963-3-lyude@redhat.com>
References: <20180820172030.10963-1-lyude@redhat.com>
         <20180820172030.10963-3-lyude@redhat.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a note: I don't think this patch is ready /just/ yet now as I just hit this
problem again this morning (and it looks like I'm checking the wrong mask for
dmac, it appears to be slightly different from the core), looking into this now

On Mon, 2018-08-20 at 13:20 -0400, Lyude Paul wrote:
> Just like how the P50 will occasionally leave the disp's core channel on
> before nouveau starts initializing, it will occasionally do the same
> thing with the rest of the dmac channel in addition to the core channel.
> Example:
> 
> [    1.604375] nouveau 0000:01:00.0: disp: outp 04:0006:0f81: no heads (0 3 4)
> [    1.604858] nouveau 0000:01:00.0: disp: outp 04:0006:0f81: aux power ->
> always
> [    1.605354] nouveau 0000:01:00.0: disp: outp 04:0006:0f81: aux power ->
> demand
> [    1.605815] nouveau 0000:01:00.0: disp: outp 05:0002:0f81: no heads (0 3 2)
> [    1.607289] nouveau 0000:01:00.0: disp: chid 0 mthd 0000 data 00000400
> 00001000 00000002
> [    1.608818] nouveau 0000:01:00.0: disp: chid 1 mthd 0000 data 00000400
> 00001000 00000002
> [    1.609500] nouveau 0000:01:00.0: disp: chid 2 mthd 0000 data 00000400
> 00001000 00000002
> 
> Which of course, later causes other parts of the card to start timing
> out and failing. Closer inspection shows the same thing happening as
> with our core channel; 0x610490 + (ctrl * 0x10) always has the same
> unknown 0x000a0000 mask set when the phantom mthd failures start
> appearing.
> 
> So, implement the same workaround we use for the core disp channel to
> the rest of the disp channels.
> 
> This along with the previous patch fix random initialization failures
> observed with the Thinkpad P50.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Karol Herbst <karolherbst@gmail.com>
> Cc: stable@vger.kernel.org
> ---
>  .../drm/nouveau/nvkm/engine/disp/dmacgf119.c  | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/dmacgf119.c
> b/drivers/gpu/drm/nouveau/nvkm/engine/disp/dmacgf119.c
> index edf7dd0d931d..7bc91f260e27 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/dmacgf119.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/dmacgf119.c
> @@ -35,8 +35,8 @@ gf119_disp_dmac_bind(struct nv50_disp_chan *chan,
>  				 chan->chid.user << 27 | 0x00000001);
>  }
>  
> -void
> -gf119_disp_dmac_fini(struct nv50_disp_chan *chan)
> +static bool
> +gf119_disp_dmac_deactivate(struct nv50_disp_chan *chan)
>  {
>  	struct nvkm_subdev *subdev = &chan->disp->base.engine.subdev;
>  	struct nvkm_device *device = subdev->device;
> @@ -52,7 +52,16 @@ gf119_disp_dmac_fini(struct nv50_disp_chan *chan)
>  	) < 0) {
>  		nvkm_error(subdev, "ch %d fini: %08x\n", user,
>  			   nvkm_rd32(device, 0x610490 + (ctrl * 0x10)));
> +		return false;
>  	}
> +
> +	return true;
> +}
> +
> +void
> +gf119_disp_dmac_fini(struct nv50_disp_chan *chan)
> +{
> +	gf119_disp_dmac_deactivate(chan);
>  }
>  
>  static int
> @@ -63,6 +72,12 @@ gf119_disp_dmac_init(struct nv50_disp_chan *chan)
>  	int ctrl = chan->chid.ctrl;
>  	int user = chan->chid.user;
>  
> +	/* shut down the channel if it was left on, probably by the VBIOS */
> +	if ((nvkm_rd32(device, 0x610490 + (ctrl * 0x10)) & 0x000a0000) ==
> 0x000a0000 &&
> +	    WARN_ON(!gf119_disp_dmac_deactivate(chan))) {
> +		return -EBUSY;
> +	}
> +
>  	/* initialise channel for dma command submission */
>  	nvkm_wr32(device, 0x610494 + (ctrl * 0x0010), chan->push);
>  	nvkm_wr32(device, 0x610498 + (ctrl * 0x0010), 0x00010000);

