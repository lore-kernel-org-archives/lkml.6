Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27426C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2BE6214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pL1V/6ls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2BE6214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbeLFPnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:43:49 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41151 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbeLFPnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:43:49 -0500
Received: by mail-pl1-f195.google.com with SMTP id u6so332270plm.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 07:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9vsb14mjMxveQDgWC7oIByRxzQ1NBbkaTik5siVCouI=;
        b=pL1V/6lsuhM3q5Le+K1jkr3m1cKLGYXrpoatXWviCoiiqmwKAp86gXRrJY7/mHnJBG
         vtQXZVKLnDdphqgtFJLwFJ2B0DFddf/TuXLAljN7EA9KOuuW+FHBxnonK0GIdh3obSNW
         +E8ZauIwuUn1kRASAF3wvxzgskW3NCK1spyQduALNa4NYOMo8eVSwqv6laA7j9h53auz
         +q+lXJu8Yk2z4bViPMSnR8DfI4s7pq0CypPCWmKEEVIpweQQt5qZlPPTO22aNYohG0aM
         FORnmXoaP56MAX5WO215uKDEV0gS2vkgAGY00owiCxEbETlez44jDcfyRJhdwV0XVYAl
         8rrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9vsb14mjMxveQDgWC7oIByRxzQ1NBbkaTik5siVCouI=;
        b=NkvNl/IP2aVxtiGyaM5QkAR4zZH+pH6uZlwLMhw77u2w/njbwLUDWkH0JXmI1TkklH
         gYZnk21rJRbygIO1y2H5vj5miiA4Fsj+WxhxlXXVZqHiTmpuV1MEJYAS3kuXniGSFxnN
         CTrxTcwWqyRAoA9C1foxb7bwFmDEpLnnkaYL8JujFVpK97zi1/fLQNzeWOzGVSCrdemA
         xCQB/tn3AmPs5vMlzzLyzSqEwvfPvKq2vXBjqlpIsS6w4KfWJhps3FycHilf3FAWPdu0
         1iZYKnw0fXUDMe5ievj7eLe1x7iAqyVyw1wazdbqe7jjSWKx9GymzEy+v9WYNIf9gNHU
         XABA==
X-Gm-Message-State: AA+aEWY3CCEOn8C/YPzaqhxHpYOtkc68gW/k6YuT+Bx+jBEAwlQ3/wGE
        kmUWreiuULgyFm0Gw9vny7khL0NMxJN2nn3o
X-Google-Smtp-Source: AFSGD/Wi0F1O5KNgYBIzHOdxu8NmtobV1Ae2kpqHV1AanemWGSkWUN2kdosHN3Ojqh05umzTC919Ag==
X-Received: by 2002:a17:902:6bc9:: with SMTP id m9mr9499210plt.173.1544111028216;
        Thu, 06 Dec 2018 07:43:48 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id t2sm1000385pfm.32.2018.12.06.07.43.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 07:43:47 -0800 (PST)
Date:   Thu, 6 Dec 2018 21:13:37 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     NeilBrown <neil@brown.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Cc:     devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] staging: mt7621-mmc: Remove missed lines of the #if 0
 block in sd.c
Message-ID: <20181206154333.GA14991@nishad>
References: <20181205161001.GA12511@nishad>
 <87tvjrel6f.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tvjrel6f.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 08:08:24AM +1100, NeilBrown wrote:
> On Wed, Dec 05 2018, Nishad Kamdar wrote:
> 
> > The below patch
> > https://lore.kernel.org/patchwork/patch/995533/
> > does not completely remove an #if 0 block in sd.c.
> 
> Standard practice is to identify patches by their commit id.
> In this case you could
>   git log --oneline  drivers/staging/mt7621-mmc/sd.c
> 
> choose the right patch, and copy/paste with a bit of editing, so:
> 
>   Commit 2a54e3259e2a ("staging: mt7621-mmc: Remove #if 0 blocks in
>   sd.c") does not completely ....
> 
> I have
> 
>   [alias]
>   	cm = !git --no-pager show -s --format=cm
> 	fx = !git --no-pager show -s --format=fixes
>   [pretty]
> 	fixes = Fixes: %h (\"%s\")
> 	cm = Commit %h (\"%s\")
> 
> in my $HOME/.gitconfig so I can get the text with, e.g.,
> 
>   $ git cm 2a54e3259e2a
>   Commit 2a54e3259e2a ("staging: mt7621-mmc: Remove #if 0 blocks in sd.c")
> 
> Then as that commit introduced a problem, it is best-practice to also do
> 
>   $ git fx 2a54e3259e2a
>   Fixes: 2a54e3259e2a ("staging: mt7621-mmc: Remove #if 0 blocks in sd.c")
> 
> and add the "Fixes" near the Signed-off-by line.
> 
> Thanks,
> NeilBrown
> 
> 
Ok. I'll do that and resubmit.

Thanks for the review and guidance.

Regards,
Nishad

> > This causes the function msdc_select_clksrc()
> > which was earler not compiled, to be compiled.
> > That causes an error - MSDC_CLKSRC_REG is not
> > defined.
> >
> > This patch completely removes the #if 0 block
> >
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> >  drivers/staging/mt7621-mmc/sd.c | 20 --------------------
> >  1 file changed, 20 deletions(-)
> >
> > diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
> > index 7b66f9b0a094..3d918e481bd8 100644
> > --- a/drivers/staging/mt7621-mmc/sd.c
> > +++ b/drivers/staging/mt7621-mmc/sd.c
> > @@ -216,26 +216,6 @@ static void msdc_tasklet_card(struct work_struct *work)
> >  	spin_unlock(&host->lock);
> >  }
> >  
> > -static void msdc_select_clksrc(struct msdc_host *host, unsigned char clksrc)
> > -{
> > -	u32 val;
> > -
> > -	BUG_ON(clksrc > 3);
> > -
> > -	val = readl(host->base + MSDC_CLKSRC_REG);
> > -	if (readl(host->base + MSDC_ECO_VER) >= 4) {
> > -		val &= ~(0x3  << clk_src_bit[host->id]);
> > -		val |= clksrc << clk_src_bit[host->id];
> > -	} else {
> > -		val &= ~0x3; val |= clksrc;
> > -	}
> > -	writel(val, host->base + MSDC_CLKSRC_REG);
> > -
> > -	host->hclk = hclks[clksrc];
> > -	host->hw->clk_src = clksrc;
> > -}
> > -#endif /* end of --- */
> > -
> >  static void msdc_set_mclk(struct msdc_host *host, int ddr, unsigned int hz)
> >  {
> >  	//struct msdc_hw *hw = host->hw;
> > -- 
> > 2.17.1


