Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641E0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F792243E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dxx5n77F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F792243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbeKOJgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 04:36:01 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39751 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbeKOJgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 04:36:01 -0500
Received: by mail-pg1-f193.google.com with SMTP id r9-v6so8081376pgv.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 15:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=Bl59/C4A8+USwYNc6zhb4hhu1dOhC+TgGyfMIwaIZJw=;
        b=Dxx5n77FLI6DuL5YVCvRgYvup2+akZD6kNwFHp0FMdKmfEYnehnXBA7KK405AZMEX3
         YzJ/mnRvT2ZEwv1HAQ260LwGdZh2C9fznTgVl2ZHbOMCbiICPKNHbE3ImJqfnKYV3T7V
         xuA/Z5UmYXwZo0NuMfLjupJHZ42nXUsXBhW6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=Bl59/C4A8+USwYNc6zhb4hhu1dOhC+TgGyfMIwaIZJw=;
        b=h+6HmA9ViTnZshlEtgVvCTByFzXPj3Of/HVkBvhHB2t2jOPYbV0JAjLd8agBCejPoV
         1cCgm686LSHz15BaApzFN1/P12j/IRh5N8CTVepxBZq0L28PYuz+fZsGwOCc9rjnz6hH
         EFsbY7uf7bYDm3IDlIjZPgfNuo1vLskDrvBZKdp+OrGlrqjt/N4tpl0Y4pV/FYMYQ20G
         ENxJ0zLsjt8OcclYww8foFWAkAJN53xYqwonN+dWoq22102Jjyr7FwxLFlpTKPVy5dGC
         NsHQ3Of1ObPY6oZX7Irv5kzWa8W39yl8Kdk+mTu0B53MEQ3eo9XUG3/nl2z8JgGv6Lk2
         XCqA==
X-Gm-Message-State: AGRZ1gLSOvBW8Zswb6lPtNhy4UY94sVLQkWo9bEd5oc7Ezfoo7MbochI
        9D5cUS65SH+hvKgXt0zwnX5Dow==
X-Google-Smtp-Source: AJdET5fJb3xnv2YOT9ppCCwYs5rof+OASPxTwbPokyrcPltiDjFPDY5l3jQq6OskeZEgYTNG4+woCg==
X-Received: by 2002:a63:dd15:: with SMTP id t21mr3456143pgg.347.1542238238486;
        Wed, 14 Nov 2018 15:30:38 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id y10-v6sm7901565pfl.187.2018.11.14.15.30.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 15:30:37 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Matthias Kaehlcke <mka@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181114222443.GL22824@google.com>
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
References: <20181102214534.184593-1-mka@chromium.org>
 <20181102214534.184593-2-mka@chromium.org>
 <154154590845.88331.13649449650347478513@swboyd.mtv.corp.google.com>
 <20181114222443.GL22824@google.com>
Message-ID: <154223823699.88331.1641898155126305025@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] drm/msm/dsi: Get PHY ref clock from the DT
Date:   Wed, 14 Nov 2018 15:30:36 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2018-11-14 14:24:43)
> On Tue, Nov 06, 2018 at 03:11:48PM -0800, Stephen Boyd wrote:
> > Quoting Matthias Kaehlcke (2018-11-02 14:45:34)
> > > @@ -630,7 +632,8 @@ static int pll_10nm_register(struct dsi_pll_10nm =
*pll_10nm)
> > >         char clk_name[32], parent[32], vco_name[32];
> > >         char parent2[32], parent3[32], parent4[32];
> > >         struct clk_init_data vco_init =3D {
> > > -               .parent_names =3D (const char *[]){ "xo" },
> > > +               .parent_names =3D (const char *[]){
> > > +                       __clk_get_name(pll_10nm->vco_ref_clk) },
> > =

> > I find this syntax odd, in addition to needing to check for NULL here as
> > Sean pointed out. Preferably just have it be the address of the
> > character pointer instead of making an anonymous array and then casting
> > that inline, i.e
> > =

> >               .parent_names =3D &ref_clk_name,
> =

> Ok
> =

> I'm not convinced the check for NULL is needed though, see my reply to Se=
an.

Ok! I'm fine either way on the NULL stuff.

