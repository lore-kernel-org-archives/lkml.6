Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4864ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 958D321471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AtBiVaJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 958D321471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbeIRIta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 04:49:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33401 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729330AbeIRIta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 04:49:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id s7-v6so290689pgc.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 20:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=9tQ2BSrjhwY6ofBq43kH3LeUH6FuOIgLiKVrLURR3R0=;
        b=AtBiVaJcgYoEZTsUDA/OSqhPC+6QjJccJAvDxvSB2ufoWskF/ZyXZqcbsdXtTOEkxz
         euYVLFTQEZ8WDzVtpyZvGUnvQYw6JgxzeaEYr3IA+T4N7DvmtaFANUFL/rHrEZs44yU9
         hieAVvCBbY26mCdwQsTc7WerGvn/xcla02xqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=9tQ2BSrjhwY6ofBq43kH3LeUH6FuOIgLiKVrLURR3R0=;
        b=VetH6gk1fLmhrqUn/MiSTODZG4GStgIqdTEgHdNB/za7JweMKa4w0UU8WfIMbAHqsN
         XGy4pY3oihCnivtML+3HeRZDNusp/+X/QDplUNPXjhdDvan6zRNWbs83YxZJT9mInu4y
         cTFtCYuAGjHgNfbz5A8qPsHW37/usRnUTdR4zK+Y157/3tphNPgPXDZ3Go8ve7fv802f
         bNrB/q6dd8o9wTunsMY+/bXgdaG+nQhRszvLbl7rMAr76PPz7ZIjCX/ROw0Lm6CWFMnM
         9pwgg9GefBltQukk4pC/DAjYa9IPiXzzwCU3CJJDpQWzuXMzB7Z+ts1WTgqWAR3ua8t9
         bXbA==
X-Gm-Message-State: APzg51AYB2IAphQEsWe6SwaCJrlrXxgh5epF2PVtNfBjq+EiiuQXcLIh
        MBDGrHCdV/mfcjVwI1902t0WFg==
X-Google-Smtp-Source: ANB0VdbBFHaPVwDd3T512TdOzaHx9KSJETM6HmXg5DnA0jQdut19TEyD2D/8FGtVvmA4wQ9ak4jGJw==
X-Received: by 2002:a62:7f0c:: with SMTP id a12-v6mr28292695pfd.257.1537240739619;
        Mon, 17 Sep 2018 20:18:59 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id 22-v6sm23262399pfl.126.2018.09.17.20.18.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 20:18:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Jordan Crouse <jcrouse@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180917211414.GC6981@jcrouse-lnx.qualcomm.com>
Cc:     Andy Gross <andy.gross@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Clark <robdclark@gmail.com>
References: <20180917204007.250862-1-swboyd@chromium.org>
 <20180917204007.250862-3-swboyd@chromium.org>
 <20180917211414.GC6981@jcrouse-lnx.qualcomm.com>
Message-ID: <153724073745.119890.15134402813455486753@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 2/2] soc: qcom: cmd-db: Stop memcpy()ing in
 cmd_db_read_aux_data()
Date:   Mon, 17 Sep 2018 20:18:57 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jordan Crouse (2018-09-17 14:14:14)
> On Mon, Sep 17, 2018 at 01:40:07PM -0700, Stephen Boyd wrote:
> > +     vals =3D cmd_db_read_aux_data(id, &len);
> >       /*
> >        * The data comes back as an array of unsigned shorts so adjust t=
he
> >        * count accordingly
> >        */
> > -     return len >> 1;
> > +     len >>=3D 1;
> > +
> > +     if (!len || WARN_ON(len > 16))
> > +             len =3D 0;
> =

> I don't think we care any more about the size of the array since there is=
n't any
> data being copied.
> =


Ok, sounds good.

> > +
> > +     *size =3D len;
> > +     return vals;
> >  }
> =

> I'm not sure this function has any value any more. We could just call
> cmd_db_read_aux_data() directly for each id and adjust the size on the fly
> when we call a6xx_gmu_rpmh_arc_votes_init.

Ok. Let me attempt to do more code reduction!

> =

> >  /* Return the 'arc-level' for the given frequency */
> > @@ -907,8 +907,8 @@ static u32 a6xx_gmu_get_arc_level(struct device *de=
v, unsigned long freq)
> >  =

> >  static int a6xx_gmu_rpmh_arc_votes_init(struct device *dev, u32 *votes,
> >               unsigned long *freqs, int freqs_count,
> > -             u16 *pri, int pri_count,
> > -             u16 *sec, int sec_count)
> > +             const u16 *pri, int pri_count,
> > +             const u16 *sec, int sec_count)
> >  {
> >       int i, j;
> >  =

> > @@ -970,14 +970,14 @@ static int a6xx_gmu_rpmh_votes_init(struct a6xx_g=
mu *gmu)
> >       struct adreno_gpu *adreno_gpu =3D &a6xx_gpu->base;
> >       struct msm_gpu *gpu =3D &adreno_gpu->base;
> >  =

> > -     u16 gx[16], cx[16], mx[16];
> > +     const u16 *gx, *cx, *mx;
> >       u32 gxcount, cxcount, mxcount;
> >       int ret;
> >  =

> >       /* Get the list of available voltage levels for each component */
> > -     gxcount =3D a6xx_gmu_rpmh_arc_cmds("gfx.lvl", gx, sizeof(gx));
> > -     cxcount =3D a6xx_gmu_rpmh_arc_cmds("cx.lvl", cx, sizeof(cx));
> > -     mxcount =3D a6xx_gmu_rpmh_arc_cmds("mx.lvl", mx, sizeof(mx));
> > +     gx =3D a6xx_gmu_rpmh_arc_cmds("gfx.lvl", &gxcount);
> > +     cx =3D a6xx_gmu_rpmh_arc_cmds("cx.lvl", &cxcount);
> > +     mx =3D a6xx_gmu_rpmh_arc_cmds("mx.lvl", &mxcount);
> >  =

> >       /* Build the GX votes */
> >       ret =3D a6xx_gmu_rpmh_arc_votes_init(&gpu->pdev->dev, gmu->gx_arc=
_votes,
> > diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
> > index 5c9cc6824891..c701b3b010f1 100644
> > --- a/drivers/soc/qcom/cmd-db.c
> > +++ b/drivers/soc/qcom/cmd-db.c
> > @@ -192,55 +192,28 @@ EXPORT_SYMBOL(cmd_db_read_addr);
> >  /**
> >   * cmd_db_read_aux_data() - Query command db for aux data.
> >   *
> > - *  @id: Resource to retrieve AUX Data on.
> > - *  @data: Data buffer to copy returned aux data to. Returns size on N=
ULL
> > - *  @len: Caller provides size of data buffer passed in.
> > + *  @id: Resource to retrieve AUX Data on
> > + *  @len: size of data buffer returned
> =

> Is the GPU the only consumer of this function?  Would it make more sense =
to
> return the number of entries rather than the size? I would suppose that w=
ould
> imply that the caller knows the size of the entries but we have to know t=
hat
> anyway if we're going to walk the list.

I think the bus scaling driver also calls this function. I don't see
much advantage to doing that here when we can just consider the aux_data
as a big blob of data that is interpreted however the consumer cares.

