Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F40C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A1720827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXkc91Dv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A1720827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbeKJGMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 01:12:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:55628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725752AbeKJGMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 01:12:25 -0500
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE38B20855;
        Fri,  9 Nov 2018 20:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541795414;
        bh=FE20sDvxDhncOVjwoP8r07R2t8W9wrGdHDL3J8lhQec=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HXkc91DvVVfj9WfNAVXpMEL2xx/cXHAICB2H3M/MoMUgi3NCQtt3A/87l76ruFuu9
         te4BYy5hY//0AEMja2SFfr9rYAFUdZKxSMdKPo9qfJJe8gdy7Nk7t+PItV1KH8TisG
         IywRbjZ/sQnLIearkixZ+ngbrjAiM05YfN9kW/kA=
Received: by mail-qk1-f175.google.com with SMTP id d135so3919642qkc.12;
        Fri, 09 Nov 2018 12:30:13 -0800 (PST)
X-Gm-Message-State: AGRZ1gIfVe3WiG1PbpBIvrRJkmuGDPAj+J/J2tN441J4D/Re0OAYmJX5
        GoWl/gc4AjkLg/NkVFS7R+FSJQ43j1SkGhvxxA==
X-Google-Smtp-Source: AJdET5fPgij4RCkORfx2mHJ6rZzAr1iCdvJ6hrZq3J9+4BzNLT+jy1rye/LworA6QNRTiGPxYauGz+Yj4NqeRBfUgHE=
X-Received: by 2002:ae9:edd8:: with SMTP id c207mr9353262qkg.184.1541795413044;
 Fri, 09 Nov 2018 12:30:13 -0800 (PST)
MIME-Version: 1.0
References: <20181107223151.14991-1-robh@kernel.org> <20181107223151.14991-3-robh@kernel.org>
 <20181108.191116.1317160901826988583.davem@davemloft.net>
In-Reply-To: <20181108.191116.1317160901826988583.davem@davemloft.net>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 9 Nov 2018 14:30:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLs7P81KiT3b3W5G=qt6JfU0tvM1TKdtJJ5Vq1HSzRW3w@mail.gmail.com>
Message-ID: <CAL_JsqLs7P81KiT3b3W5G=qt6JfU0tvM1TKdtJJ5Vq1HSzRW3w@mail.gmail.com>
Subject: Re: [PATCH 2/8] of: Drop full path from Sparc PDT full_name
To:     David Miller <davem@davemloft.net>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 9:11 PM David Miller <davem@davemloft.net> wrote:
>
> From: Rob Herring <robh@kernel.org>
> Date: Wed,  7 Nov 2018 16:31:45 -0600
>
> > @@ -32,24 +32,7 @@ unsigned int of_pdt_unique_id __initdata;
> >
> >  static char * __init of_pdt_build_full_name(struct device_node *dp)
> >  {
> > -     int len, ourlen, plen;
> > -     char *n;
> > -
> > -     dp->path_component_name = build_path_component(dp);
> > -
> > -     plen = strlen(dp->parent->full_name);
> > -     ourlen = strlen(dp->path_component_name);
> > -     len = ourlen + plen + 2;
> > -
> > -     n = prom_early_alloc(len);
> > -     strcpy(n, dp->parent->full_name);
> > -     if (!of_node_is_root(dp->parent)) {
> > -             strcpy(n + plen, "/");
> > -             plen++;
> > -     }
> > -     strcpy(n + plen, dp->path_component_name);
> > -
> > -     return n;
> > +     return build_path_component(dp);
> >  }
> >
> >  #else /* CONFIG_SPARC */
>
> Hmmm, shouldn't this be doing what the non-SPARC version of
> of_pdt_build_full_name() does which is to return the component string
> appended to the parent's full_name?
>
> You're just returning the component string here.

That is the intent. With this change we stop storing the full path for
every node. Everywhere that needs the full path, generates it with the
%pOF printf specifier. Other than users in arch/sparc converted in
this series all the users of full_name have been converted already or
use kbasename(full_name) so they work either way. BTW, I've found a
couple more, so I'll be sending you a v2.

And of_pdt_build_full_name for !SPARC does need to be converted too,
but I'll do that separately.

Rob
