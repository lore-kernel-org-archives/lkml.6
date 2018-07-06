Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2A4C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 03:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC5D24064
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 03:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VF9di3bx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAC5D24064
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753987AbeGFDzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 23:55:54 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:41412 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753926AbeGFDzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 23:55:52 -0400
Received: by mail-io0-f196.google.com with SMTP id q9-v6so9685164ioj.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 20:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R9Z/FYdLmD7A0iLDGXhlvcjQQwxKNh70tN9sHn9tCgo=;
        b=VF9di3bxMiR4vNRhW52u7Ez4uNHvK8CdaoqajEP6m0sqpd6qNZS4Yp2xGOnc6rCMMD
         KX55cV0zgDPb25NkfX9SAm+qdnUfT1EC3NBQvFxoFjsNJ4YAtOVUfnHUDMSmVbhtaDfW
         PkPWOeXU3hMlQMdnowOvI/6gmpRIx8aBupjJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R9Z/FYdLmD7A0iLDGXhlvcjQQwxKNh70tN9sHn9tCgo=;
        b=GPi3tai7aK6K/aMCksGDQHtHJ7K8zolE4Rjk5LHisalAWQza0RmAIEmYLQu5sz245i
         hU3MxNR401RECs4THTz4iKr4p/bxe1qfTbAUbT2pnqdIVoeEpSR0T9GVlnYNC11xflgz
         XQ5DCxGZlZmRuhoSnyY1Nxz+/CtqDblIXwrzrOPloRwdxuCuV0WXlefl6GHzhtBUDwkf
         li3/yyeqlciofTMIF9Mia+tc92FGCgecDHQxM5WOxsT63FFYnGYGIdFtnJ1sT1J5G4Q4
         9KIZc6snQF7jhAAGVx6Klhd2AcgJhGV0D4zJ+ge/dtb7K6flbef/4+WaDD+YoF4HBdoB
         gUXg==
X-Gm-Message-State: APt69E1l+Rg8Ed1f27W1N3S4QBT7kOPO6fZnf4pgQ3jFVoWSZMPldrzu
        e76zDq8DF2h2vhmh+gfjvwcnEUTsWf4=
X-Google-Smtp-Source: AAOMgpcgauuA4u3oCEjRSMCSLXl37d+NiT9rWMU1gy6wntNJgtviFKe3yRs05b2tO1XDWqS+hg1AlQ==
X-Received: by 2002:a5e:d713:: with SMTP id v19-v6mr6959324iom.75.1530849351561;
        Thu, 05 Jul 2018 20:55:51 -0700 (PDT)
Received: from mail-it0-f41.google.com (mail-it0-f41.google.com. [209.85.214.41])
        by smtp.gmail.com with ESMTPSA id r80-v6sm1173104ita.20.2018.07.05.20.55.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 20:55:50 -0700 (PDT)
Received: by mail-it0-f41.google.com with SMTP id v71-v6so4796577itb.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 20:55:50 -0700 (PDT)
X-Received: by 2002:a02:579a:: with SMTP id b26-v6mr7039586jad.107.1530849350251;
 Thu, 05 Jul 2018 20:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
 <CAAFQd5CQCF=QvTgq8v6K6W6C0Cy27CzHsMxQn+FnML97w9xnCw@mail.gmail.com>
 <150eb3b4-8b64-6050-6a4e-e06cfaf113cc@xs4all.nl> <6abf8da2-b2e1-1b4f-2727-f9d074081c30@linaro.org>
 <CAPBb6MWoysaL_i8i7HaegRCsfF29bnOy2L5ZHgEwDuSJ7HVO2w@mail.gmail.com>
In-Reply-To: <CAPBb6MWoysaL_i8i7HaegRCsfF29bnOy2L5ZHgEwDuSJ7HVO2w@mail.gmail.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Fri, 6 Jul 2018 12:55:38 +0900
X-Gmail-Original-Message-ID: <CAPBb6MXoiGLdSuufbJ39va4emswC20VZq+U4X8+_PUa++yh=AQ@mail.gmail.com>
Message-ID: <CAPBb6MXoiGLdSuufbJ39va4emswC20VZq+U4X8+_PUa++yh=AQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/27] Venus updates
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, vgarodia@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 12:00 AM Alexandre Courbot <acourbot@chromium.org> wrote:
>
> On Thu, Jul 5, 2018 at 11:52 PM Stanimir Varbanov
> <stanimir.varbanov@linaro.org> wrote:
> >
> > Hi,
> >
> > On 07/05/2018 05:08 PM, Hans Verkuil wrote:
> > > On 05/07/18 16:07, Tomasz Figa wrote:
> > >> Hi Stanimir,
> > >>
> > >> On Thu, Jul 5, 2018 at 10:05 PM Stanimir Varbanov
> > >> <stanimir.varbanov@linaro.org> wrote:
> > >>>
> > >>> Hi,
> > >>>
> > >>> Changes since v4:
> > >>>  * 02/27 re-write intbufs_alloc as suggested by Alex, and
> > >>>    moved new structures in 03/27 where they are used
> > >>>  * 11/27 exit early if error occur in vdec_runtime_suspend
> > >>>    venc_runtime_suspend and avoid ORing ret variable
> > >>>  * 12/27 fixed typo in patch description
> > >>>  * added a const when declare ptype variable
> > >>>
> > >>> Previous v4 can be found at https://lkml.org/lkml/2018/6/27/404
> > >>
> > >> Thanks for the patches!
> > >>
> > >> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> >
> > Thanks Tomasz!
> >
> > >
> > > Are we waiting for anything else? Otherwise I plan to make a pull request for
> > > this tomorrow.
> >
> > I think we are done.
>
> I would just like to give this one last test - will be done by tomorrow JST.

Confirmed my unit tests were still running with this version and had a
quick look at the changes.

The series,

Reviewed-by: Alexandre Courbot <acourbot@chromium.org>
Tested-by: Alexandre Courbot <acourbot@chromium.org>
