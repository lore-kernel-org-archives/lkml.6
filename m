Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCBBC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E939A206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3ihogad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E939A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbeLEPuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:50:01 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35156 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbeLEPuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:50:00 -0500
Received: by mail-it1-f196.google.com with SMTP id p197so20909057itp.0;
        Wed, 05 Dec 2018 07:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=33EijjaRJn7ta0WAX4wdrpfQ/2/WNKop22PphZmV99k=;
        b=o3ihogadPxLvTJIIG5KNybtLvemQpjvcWphby7j6wQm30P7bs+xy9w3weJiELT2vjL
         J45H41juD2Dq4CLppa2478kXA7XVe/qYDmej7t/71AttCK4DCvckVVzb73C4B1Q2xUTe
         gYAo2YJAjb+eJP/0Boi4PIY1EGCs3S0RuNQ0VstihnQ5526XFEjw+gXq0/A2/fwrw/sw
         XHiQWvj83O+nezCN6x9CHEZpGgFSTQhZKoVKhjuPnlTKn9fw7VWZg8jjbRK1fYJCmP9U
         XSA6j6319gnPXkpdt2SyiKOu1OurzaMqOe8dChRZQwRdOkQ84Ld1OPJ3ft3Vf6ibwSCK
         XpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=33EijjaRJn7ta0WAX4wdrpfQ/2/WNKop22PphZmV99k=;
        b=Lg1P94usNZ9sa6IcWHX2ZSY399l+A8Q1gm7dSWF7cy18BW18sAcfFzdYucgNtf8Rhn
         jH5SqHM1wIJQJC39502JQNusEhMc9WcgfvcSQNlHwx11SmXmepta4B7jZE+tmZlgOHle
         fpQBnzpXFayGZVliG8Wwt3DtcIahRrKtlRNh2wozUI27RRbEEOS/mB0ImIW3vtvgKr1a
         GQTbfAerAt2accRicByrdD0q2WjU5WqMc4RrMHWNyr4shTzoTpsxc0VYrYoW/vKNOMdn
         m+WR4N3SWrITQAvXPacvV3FXDn2uEfyymKP2CYeEUXpFP3BdjEXFtCCOIHHzoTjGulrj
         VbZg==
X-Gm-Message-State: AA+aEWbh1hxkinnjNgUlq/rLkaXJavN9HNHJ8DxeHZQWQwRB4O2zOexD
        Qb4yz780g+kb6NQTRbuBm67SqkJ28Oue+sjYMVx9CwQXz0I=
X-Google-Smtp-Source: AFSGD/WzXyDVsSDMObQ1SC+fV736Y1dqJfBvzUG1N8P7aUgB7+Id1OqXgDcB9Sv2ltb6Jf9SYMVb1ALczuBk6okCt7M=
X-Received: by 2002:a05:660c:250:: with SMTP id t16mr15050432itk.78.1544024999722;
 Wed, 05 Dec 2018 07:49:59 -0800 (PST)
MIME-Version: 1.0
References: <20181130154249.3222-1-tiny.windzz@gmail.com> <20181205082719.GF2847@vkoul-mobl>
In-Reply-To: <20181205082719.GF2847@vkoul-mobl>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Wed, 5 Dec 2018 23:49:37 +0800
Message-ID: <CAEExFWu1ahDPqKbYWKPY_bQuw=1Kp1gUki+CpQ7Mq5sNNiy_tg@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: remove DBGFS_FUNC_DECL()
To:     vkoul@kernel.org
Cc:     dan.j.williams@intel.com, sudeep.dutt@intel.com,
        ashutosh.dixit@intel.com, daniel@zonque.org,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        robert.jarzmik@free.fr, okaya@kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 4:27 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 30-11-18, 10:42, Yangtao Li wrote:
> > We already have the DEFINE_SHOW_ATTRIBUTE,There is no need to define
> > such a macro,so remove DBGFS_FUNC_DECL.Also use macro to simplify some
> > code.
>
> Spaces after full stop and comma please
>
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/dma/amba-pl08x.c     | 14 ++------------
> >  drivers/dma/mic_x100_dma.c   | 22 +++-------------------
> >  drivers/dma/pxa_dma.c        | 24 ++++++++++++------------
> >  drivers/dma/qcom/hidma_dbg.c | 33 ++++++---------------------------
>
> Do you mind splitting it per file.
Hi Vinod:

Why not apply it once =EF=BC=9FThe change is not too big.

Thanks=EF=BC=8C
Yangtao
