Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7083DC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191F820841
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PnWjjAW/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 191F820841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeHJCKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 22:10:46 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43584 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbeHJCKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 22:10:45 -0400
Received: by mail-pl0-f66.google.com with SMTP id x6-v6so3197528plv.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 16:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=CcqP2LpDMDxvfY9IWUfEqCAjw5WZrU13aqgW2QKeedY=;
        b=PnWjjAW/WMvq41zCpdPUk8vuvMsWIKucu3lJhwxin5iSd3pIocrk0D5oSMF314FIEw
         lw0UCPmgWzMOrjo5RGc8sgjW6APRrE7eLwPb/+ekHC7fb56zxtY5VmuaoNAU8PfU2bUD
         njDPtV76wIF8x+/5nNHkNpTnVAl1VBVNlExbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=CcqP2LpDMDxvfY9IWUfEqCAjw5WZrU13aqgW2QKeedY=;
        b=Lqb8lEVcP8lEC+U3qTpjhtBDd3n4cYlomwiA9lZ3u9CTs27Paxl26HjWVoQb6P5D9o
         zGrjosch0bABLbhpuDTWAPcUKJU2jZRvAVeoYqWCjucFsjvIqNeqKoWGjIlBQa5dNufe
         OxxeHm1AmcHrJ+e5YLgsaH8YPK7JgW/AOz2Fy4chgJteTVDOZtK2ln5LcM/epdNVb59D
         S2I2akJpbANPB2iPCZWLMjKMtjO/lT65UbhBewELEiJZ+VuHhxu8Jb+PLqUVSE4I1m4v
         RYDJphpLMalNdP/i4SHjC2pkGO0ccIQnUCS8BEmTAgjllMWocSkfIsd2dePde90A2A6q
         iFfg==
X-Gm-Message-State: AOUpUlFvPH3tagvDxQ9N23bb53Fg0P7ZlRjjmrza6vWqZxVv5nc7BhPM
        Bif2H7/XuhOJYk9SSI4NSojXnQ==
X-Google-Smtp-Source: AA+uWPyLhD1tv1YWSP2VuzrFglkByjd2ndI70pDhFL7QwWNEdGpNKGgO1AgUyF55ZQxCliM1827/mw==
X-Received: by 2002:a17:902:1001:: with SMTP id b1-v6mr3767379pla.155.1533858214540;
        Thu, 09 Aug 2018 16:43:34 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id b21-v6sm24293235pfe.148.2018.08.09.16.43.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 16:43:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Julius Werner <jwerner@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <CAODwPW-Qc3JanqsB0C42O796fbDiwvUKYOhUXNYOaS_mzgCS8g@mail.gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>, samuel@sholland.org
References: <20180809171722.144325-1-swboyd@chromium.org>
 <20180809171722.144325-7-swboyd@chromium.org>
 <CAODwPW-Qc3JanqsB0C42O796fbDiwvUKYOhUXNYOaS_mzgCS8g@mail.gmail.com>
Message-ID: <153385821305.37448.14883992808536908679@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 6/7] firmware: coreboot: Only populate devices in
 coreboot_table_init()
Date:   Thu, 09 Aug 2018 16:43:33 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Julius Werner (2018-08-09 14:02:53)
> On Thu, Aug 9, 2018 at 10:17 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > @@ -162,26 +143,37 @@ static int coreboot_table_probe(struct platform_d=
evice *pdev)
> >         if (!res->start || !len)
> >                 return -EINVAL;
> >
> > +       /* Map and check just the header first to make sure things are =
sane */
> >         header =3D memremap(res->start, sizeof(*header), MEMREMAP_WB);
> > -       if (header =3D=3D NULL)
> > +       if (!header)
> >                 return -ENOMEM;
> >
> > -       ptr =3D memremap(res->start, header->header_bytes + header->tab=
le_bytes,
> > -                      MEMREMAP_WB);
> > +       if (strncmp(header->signature, "LBIO", sizeof(header->signature=
))) {
> > +               dev_warn(dev, "coreboot table missing or corrupt!\n");
> > +               return -ENODEV;
> =

> Leaking the mapping here.

Thanks. Fixed.

