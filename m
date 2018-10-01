Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E083FC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 956282084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ayQ96Ese"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956282084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbeJAOxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 10:53:35 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39625 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728749AbeJAOxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 10:53:35 -0400
Received: by mail-ed1-f67.google.com with SMTP id h4-v6so13324231edi.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 01:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bsK7dn08fRjImDu/Im+MSlC9O2G4ZzMTA+s2UIlvXFw=;
        b=ayQ96EseacH262NYg2oTpG4wgKbu7zCODd3zif/sKTCqbf4OcTtdyQCE42m6oaGssQ
         YvAOh0ceLZNq4Vm5nIhxRWiwKe8hnnfr6SwdjZClzRuXdLkCFaqmO4AmQUtUVPy0bgx7
         GzAN6sgIgV183a5nKFHfQmKBENMhTJlztEsU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=bsK7dn08fRjImDu/Im+MSlC9O2G4ZzMTA+s2UIlvXFw=;
        b=oNnkaST51PXmV+l+fKQFUnAZ3h7pwkrBKwcmIzBLj3MFofDkDbJ2l4iwUek0pUvYlo
         SvGboUGFeyk9ktArEXLptyp5i2teorP5Lu5NfUSPzWUX+p4WNXtgeGY0iAIXhPHUR8Zw
         bdIamT0t9KAKnvzs0i1GVAIC1MdQoFk++kGDZQNSw5L6DsRzCjuIDp/5VKWNP7s1y156
         5ZdBxHJV+mpJb0LpNqLoCP9NyKVrbNohxB0gA88yDZm3FHIaz497qnT2ErCCTOR7IMkV
         RDKHsy/TAleUXBuEOmjM7fa+qRzwao6gYRA55UPpXtHcUiim0Xx5rD27bUz4q9TXPZy7
         +RXQ==
X-Gm-Message-State: ABuFfoihvpHWEkYhHWOSOI03+twtu00sfgCgtg0y1o46f/EH1Lohh/To
        SZ2nEUSsGkSylUFGNIlV3u5Nyw==
X-Google-Smtp-Source: ACcGV63DUQOZrwvvB/t4fNDz8VN11Yz9Cq7QMgfDX5DVHFKvX4We+ammRHDEdaHX6s2fE9jhnhLGrA==
X-Received: by 2002:aa7:d951:: with SMTP id l17-v6mr15497899eds.37.1538381821877;
        Mon, 01 Oct 2018 01:17:01 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id m18-v6sm1976129ejk.59.2018.10.01.01.17.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 01:17:01 -0700 (PDT)
Date:   Mon, 1 Oct 2018 10:16:59 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Sean Paul <sean@poorly.run>
Subject: Re: [PATCH v2] drm: Convert to using %pOFn instead of
 device_node.name
Message-ID: <20181001081659.GW11082@phenom.ffwll.local>
Mail-Followup-To: Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Sean Paul <sean@poorly.run>
References: <20180928225044.20132-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928225044.20132-1-robh@kernel.org>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 05:50:44PM -0500, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> For drm_modes.c, the full node path is already printed out, so printing
> just the node name a 2nd time is redundant and can be removed.
> 
> Cc: Gustavo Padovan <gustavo@padovan.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@linux.ie>
> Acked-by: Rob Clark <robdclark@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-arm-msm@vger.kernel.org
> Cc: freedreno@lists.freedesktop.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
> - Add to commit msg that we're dropping redundant printing of node name.

Applied, thanks for the patch.

Aside, still don't want drm-misc commit rights so you can offload these
yourself?

Cheers, Daniel

> 
>  drivers/gpu/drm/drm_modes.c     | 4 ++--
>  drivers/gpu/drm/msm/hdmi/hdmi.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> index 02db9ac82d7a..24a750436559 100644
> --- a/drivers/gpu/drm/drm_modes.c
> +++ b/drivers/gpu/drm/drm_modes.c
> @@ -716,8 +716,8 @@ int of_get_drm_display_mode(struct device_node *np,
>  	if (bus_flags)
>  		drm_bus_flags_from_videomode(&vm, bus_flags);
>  
> -	pr_debug("%pOF: got %dx%d display mode from %s\n",
> -		np, vm.hactive, vm.vactive, np->name);
> +	pr_debug("%pOF: got %dx%d display mode\n",
> +		np, vm.hactive, vm.vactive);
>  	drm_mode_debug_printmodeline(dmode);
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
> index c79659ca5706..23670907a29d 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
> @@ -579,7 +579,7 @@ static int msm_hdmi_bind(struct device *dev, struct device *master, void *data)
>  	hdmi_cfg = (struct hdmi_platform_config *)
>  			of_device_get_match_data(dev);
>  	if (!hdmi_cfg) {
> -		dev_err(dev, "unknown hdmi_cfg: %s\n", of_node->name);
> +		dev_err(dev, "unknown hdmi_cfg: %pOFn\n", of_node);
>  		return -ENXIO;
>  	}
>  
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
