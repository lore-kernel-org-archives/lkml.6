Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84ED3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BEA32252F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="idUW5q48"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BEA32252F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388503AbeKOI3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:29:50 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33883 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeKOI3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:29:49 -0500
Received: by mail-pf1-f194.google.com with SMTP id h3so2067604pfg.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 14:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U7NkUts75H0rk3Xb14F+2LIum2GGrpzqqEJV8F1ghbg=;
        b=idUW5q48c4WeMogLIBQq8TT0fOCnaQIreJjw014Tk5v0WJKm0bDWnmpUbwGacOFXVj
         a2BWwYPL1hy1ZwShPCOujiMjzlEgvdRIXGPMOlaZqiXO0q/5bzZ5GzhX3vlg23SUAqRI
         OPxIJWTSFXshAt3KLo79JzZzb/U2GuS9D5IDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U7NkUts75H0rk3Xb14F+2LIum2GGrpzqqEJV8F1ghbg=;
        b=o1NImkcKa4pDSmYsi1SzlMP0mNMUd7m+LoL8yaU1Z+otU7YSg77zC1pthsXN+SCOzg
         YrEuV+PNe6S3Z5teL9Mfkzsurh+QT6zr5kZhJ0neO1aag1dGE3Zw5rFZv19F+BpG153Z
         hjnz2yjQ/G6LM8W8qaomWQZ/Gg8mE/1ttzY3dP+Z6TGe0VM0RTfHC9U0WXbCeLoEvD4I
         MWc9fPrvK43UEm+ARTKQUtfbfVSDfC9HHX3STn2FNugmXHJVMBUaudGNdQxxlX9mR4ze
         MJJeOvRnXTa+aTVaJpPuyHgh/7ipdU3Upz9kHq/UvzPahKUAM6iPIwHGJCNA3WCqX25K
         dc8w==
X-Gm-Message-State: AGRZ1gL5hVIlFtfP+ORx749IwV+WlWynYhxS8zuXU264DdIcgWXGRohd
        zCxXZ9skqXf8pQMv5vEVYJbu+w==
X-Google-Smtp-Source: AJdET5dcqgn4djt9SwuovYhLgcY0uaNGr4FRKHaAlZtJWwVu0eabMVQ3rbZ3pe5i19xrjSA7vtfxxw==
X-Received: by 2002:a63:a441:: with SMTP id c1-v6mr3475055pgp.49.1542234285003;
        Wed, 14 Nov 2018 14:24:45 -0800 (PST)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id p2sm24443422pgc.94.2018.11.14.14.24.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 14:24:44 -0800 (PST)
Date:   Wed, 14 Nov 2018 14:24:43 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/msm/dsi: Get PHY ref clock from the DT
Message-ID: <20181114222443.GL22824@google.com>
References: <20181102214534.184593-1-mka@chromium.org>
 <20181102214534.184593-2-mka@chromium.org>
 <154154590845.88331.13649449650347478513@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <154154590845.88331.13649449650347478513@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 03:11:48PM -0800, Stephen Boyd wrote:
> Quoting Matthias Kaehlcke (2018-11-02 14:45:34)
> > @@ -630,7 +632,8 @@ static int pll_10nm_register(struct dsi_pll_10nm *pll_10nm)
> >         char clk_name[32], parent[32], vco_name[32];
> >         char parent2[32], parent3[32], parent4[32];
> >         struct clk_init_data vco_init = {
> > -               .parent_names = (const char *[]){ "xo" },
> > +               .parent_names = (const char *[]){
> > +                       __clk_get_name(pll_10nm->vco_ref_clk) },
> 
> I find this syntax odd, in addition to needing to check for NULL here as
> Sean pointed out. Preferably just have it be the address of the
> character pointer instead of making an anonymous array and then casting
> that inline, i.e
> 
> 		.parent_names = &ref_clk_name,

Ok

I'm not convinced the check for NULL is needed though, see my reply to Sean.

> >                 .num_parents = 1,
> >                 .name = vco_name,
> >                 .flags = CLK_IGNORE_UNUSED,
> > @@ -786,6 +789,12 @@ struct msm_dsi_pll *msm_dsi_pll_10nm_init(struct platform_device *pdev, int id)
> >         pll_10nm->id = id;
> >         pll_10nm_list[id] = pll_10nm;
> >  
> > +       pll_10nm->vco_ref_clk = devm_clk_get(&pdev->dev, "ref");
> > +       if (IS_ERR(pll_10nm->vco_ref_clk)) {
> > +               dev_err(&pdev->dev, "couldn't get 'ref' clock\n");
> 
> This might be because of probe defer, which may be annoying to see this
> failure many times.

Ok, will skip the logging for -EPROBE_DEFER

Cheers

Matthias
