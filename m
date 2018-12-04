Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35E0C07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A57A72082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="c+pdL9xs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57A72082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbeLDTvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:51:22 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45030 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbeLDTvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:51:22 -0500
Received: by mail-wr1-f67.google.com with SMTP id z5so17254469wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 11:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=5qjZ/kmbzHf7y987gu7eWk15FAWnG/grsI5l9lVQpJQ=;
        b=c+pdL9xshdGTHH5KLO0CDytstujw5+P+jTX7TXx1eTw6tDGdb84dLB8Nz8bd6pNhq1
         mewgF36KMwAt0js7y0zsPYxrQp6vnJW7J0MX0CdeqjLRLPpfC0+3I8POoPmOKjSDOwSj
         ryKzrEH3ID1qhTPMxZUEx7JtPOQYAkIzCcl+xbJJiIcxAorOkj5FIpCprrF9yRZM9xC9
         EmJ2351YM+iYMlrd1/9u7UTxm1JD5no/MfbvjS19EZaWgCqT5qkKjXWWm5oEoTh8WMjZ
         IUY+z4u1S1yZZGGo0K/GXIrQCpvd1AV0IUAGRgiAHuD6PaXOX+pEf0Pa331FGmz+dh2N
         ydNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=5qjZ/kmbzHf7y987gu7eWk15FAWnG/grsI5l9lVQpJQ=;
        b=lcylggpo8KNqLHFpo19bXBB7mERyIx3YxgBZ3x7J9b9udhaUnuw2JN0CeMGM95wydN
         2txeQNDHUM4hXoLKG0jIPkfyeaMr6nNSTf0qPCEyTXUTCoHIAZtbkgjw4iR1PqRl+TQr
         JytNFVRF4H+/Jvcftgyfi+WT4VgXgrAMhAC6PrTTLztD2ILSZxmMa3Cs+cGWNIaZcVB8
         hFTbq/D01VLHjC7+6v5s133ODZNjJP8TLEcnXOnwqPdDvpoYjV63j3sIx6GbcNyRWEYa
         E3YwvFtwwXm5IiZ5MGM36L4MLkTZSD3zNQ87PzM7HhLDf1rIezwUiJiRA5cJvhWpkrvQ
         FuaQ==
X-Gm-Message-State: AA+aEWZSxaFPQTFGvz+2H0EQsYo+5T19B4i60z1AZtvToZR0IBTbVUk3
        c6OMC08DMmCI+38t1Ny4/zvUsA==
X-Google-Smtp-Source: AFSGD/WTtk05Pe/Hq0A5oQ06JeYUhmtTz9Knb8t3RC1nbNotMqdQioRkRqEKNskXleimzWQATX027g==
X-Received: by 2002:a5d:6549:: with SMTP id z9mr18582849wrv.116.1543953080031;
        Tue, 04 Dec 2018 11:51:20 -0800 (PST)
Received: from boomer.baylibre.com (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id 125-v6sm14667527wmr.22.2018.12.04.11.51.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 11:51:19 -0800 (PST)
Message-ID: <807f2924b67239f61c6d93de7f7b124f8a1f195a.camel@baylibre.com>
Subject: Re: [PATCH] Revert "clk: fix __clk_init_parent() for single parent
 clocks"
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 04 Dec 2018 20:51:17 +0100
In-Reply-To: <154394675320.88331.12449582989130694425@swboyd.mtv.corp.google.com>
References: <20181204163257.32085-1-jbrunet@baylibre.com>
         <154394675320.88331.12449582989130694425@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-04 at 10:05 -0800, Stephen Boyd wrote:
> Quoting Jerome Brunet (2018-12-04 08:32:57)
> > This reverts commit 2430a94d1e719b7b4af2a65b781a4c036eb22e64.
> > 
> > From the original commit message:
> >   It turned out a problem because there are some single-parent clocks
> >   that implement .get_parent() callback and return non-zero index.
> >   The SOCFPGA clock is the case; the commit broke the SOCFPGA boards.
> > 
> > It is wrong for a clock to return an index >= num_parents. CCF checks
> > for this condition in clk_core_get_parent_by_index(). This function sets
> > the parent to NULL if index is incoherent, which seems like the only
> > sane choice.
> > 
> > commit 2430a94d1e71 ("clk: fix __clk_init_parent() for single parent
> > clocks")
> > appears to be a work around installed in the core framework for a problem
> > that is platform specific, and should probably be fixed in the platform
> > code.
> 
> Ouch. I see that I even pointed that out in 2016 but never got a reply
> or a fix patch[1].
> 
> > Further more, it introduces a problem in a corner case of the mux clock.
> > Take mux with multiple parents, but only one is known, the rest being
> > undocumented. The register reset has one of unknown parent set.
> > 
> > Before commit 2430a94d1e71 ("clk: fix __clk_init_parent() for single
> > parent clocks"):
> >  * get_parent() is called, register is read and give an unknown index.
> >    -> the mux is orphaned.
> >  * a call to set_rate() will reparent the mux to the only known parent.
> > 
> > With commit 2430a94d1e71 ("clk: fix __clk_init_parent() for single parent
> > clocks"):
> >  * the register is never read.
> >  * parent is wrongly assumed to be the only known one.
> >    As a consequence, all the calculation deriving from the mux will be
> >    wrong
> >  * Since we believe the only know parent to be set, set_parent() won't
> >    ever be called and the register won't be set with the correct value.
> 
> Isn't this the broken bad case all over again? Why register a clk as a
> mux and then only say it has one parent?

I understand it is a bit odd but as I explained it is a corner case.

We are really trying to drive a mux here, applying a values will change the
clock signal we get. Documentation being what it is, we only know one the
parent. The other parent could anything or maybe not connected at all, who
know. That is not the important part actually

If such mux was already set to the known entry by default, it would be OK to
ignore it. But if it is not, then we CCF to realise that and change the
setting accordingly.

This the case of the 'ao_cts_cec' clock in the following patch:
https://lore.kernel.org/patchwork/patch/1021028/

by default the value in the register is 0, but the only one that makes sense
for us is 1.

> 
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > ---
> 
> Is this related to the other patch you sent? Can you send series for
> related patches please?
> 
> [1] https://lkml.kernel.org/r/20160209181833.GA24167@codeaurora.org

Actually I was intially doing a series, and stopped when my cover letter
started with "those are two unrelated patches ..." ;)

I found these things while debugging the same thing but there is no deps
between them.


