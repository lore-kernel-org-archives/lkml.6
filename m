Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EC1C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B175820892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544224701;
	bh=2IEX3vYpus7rwLAYYVdx9+2qouxBr/MskvnaY//xA2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wfG4RGQrsLmOKBfiB1nKdjI7TdOXLCl7K9qDZjuebjMtYIRkPd4eAx3BRiSXVKb0K
	 ZrtfYPtiPMpZGdRr7pabbUszPPC39Lstsl7/Vdr8lCbJgR9us6cmX1G2i/PiUgdINf
	 KTI8qLs7qb0jFTBv5cq0Nmgaqrm4z/tmqPxxGAwo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B175820892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbeLGXSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 18:18:20 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41502 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbeLGXSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 18:18:20 -0500
Received: by mail-oi1-f193.google.com with SMTP id j21so4715476oii.8;
        Fri, 07 Dec 2018 15:18:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jWn3L/QSLkgJZ1Mycj9qlXwkL+5Zafy6eVDF3gdoZto=;
        b=Y++nzAhGnNhPB4qtIDWjWeFm0LCvlPvLPozFxdijPkWPdOEsUNzv11bYvJaGfCspT2
         9EPAXPKj751Gkfdk9kSy04OGiY0xcpGsOoUAEVxfJThyZT7sa/1ElPbpC0mjwpg0pBGg
         F+LM6jUm8bZ6VG1dwMvcduWSSwHaEh/hIDdALXiRnPqI0tJh885eSzJfeHMR753kCISG
         oXf0ijgnolsOP4PzOV5Dz+zI+i3KAPleIcM4sEsfiKAlRKJ4G1CQdj4txYZvEFuk+yrt
         yxSlwrf9sVvzzwV2U4GJLlPgOCIzwYjRXTG1uQtmsMAmHTUJIMHf2I6O5aoMmTTUeaBV
         2Ctw==
X-Gm-Message-State: AA+aEWbl8uqwW0si8Djrtejk54qpN5TaaT6S/b0+AwYIt4UMPIUMJo/Y
        abSOVcqkTzFLeyzDkY0+JZRFXrY=
X-Google-Smtp-Source: AFSGD/XDZoy1Vux+U7X8kD0Qql/CeN28Tdp3iBXKOzi7nqrZhU3mcyPKousW6w2WfdnHpvPAodTLEw==
X-Received: by 2002:aca:6b8c:: with SMTP id g134mr2248147oic.135.1544224699412;
        Fri, 07 Dec 2018 15:18:19 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c23sm1935616otn.21.2018.12.07.15.18.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 15:18:18 -0800 (PST)
Date:   Fri, 7 Dec 2018 17:18:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     freedreno@lists.freedesktop.org, Chris.Healy@zii.aero,
        festevam@gmail.com, Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Paul <seanpaul@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/5] drm/msm/mdp4: add lcdc-align-lsb flag to control
 lane alignment
Message-ID: <20181207231818.GA16687@bogus>
References: <20181204151702.8514-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204151702.8514-1-jonathan@marek.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  4 Dec 2018 10:16:57 -0500, Jonathan Marek wrote:
> This allows controlling which of the 8 lanes are used for 6 bit color.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
> v3: removed empty line and added documentation
> 
>  .../devicetree/bindings/display/msm/mdp4.txt  |  2 ++
>  .../gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c | 21 ++++++++++++-------
>  2 files changed, 15 insertions(+), 8 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
