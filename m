Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A73C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1AC20842
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I23KQXYx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E1AC20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932609AbeGILw6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:52:58 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36815 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754474AbeGILwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:52:55 -0400
Received: by mail-lf0-f65.google.com with SMTP id b22-v6so2565470lfa.3;
        Mon, 09 Jul 2018 04:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VJL1I20g9tBl6/oWkkSoCrv3PhHO20Gk6E1/x0AIw0A=;
        b=I23KQXYxbKzR47+5ty+BCLH3RSXmbPc/lGnH0hfhHhDK9ICjsUeweBIc1tJHTOJxfz
         aw7Fdc93ftoRCEyrj7K4YLOZWi9uvtYfY26h/YodQru59/oZ+Ch0iIkEVz9qoVFrhdgQ
         rxaItmSDiazfhLJXXW0GPe+G/IW0VY3wPhab45b8SSNg4PG1rYfOr+4+AFb6AzyUg6O6
         A0mNAWIA+tGXxay5sn7rr+CHCSVcdn8kHcJRdgoScDdNlb3o+RZDbGbfqCSUjX3+/xtS
         W+2PKq2adLVDPXQVDs+bDBx7JAjF5NWbIb8dYf3tHNXROn9OcEvVNHppUmK1buYzZx8v
         YvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VJL1I20g9tBl6/oWkkSoCrv3PhHO20Gk6E1/x0AIw0A=;
        b=qBv3jcfmKcMA33KSLCgiK3Xc78FTYvBunhtcwalXZapC39pk9NvXTBP4SD6kwo7mbL
         Pepilj3Y7Ia4/ORqgmrs/8iQCwDD2w3s1a6Q8/3eZsuWPKLEe64Nuo8s5lasHYq63vKM
         dGjB/c2X5otLgs9KHHyHHpae+3rJ4/sMslyfIv+5EQ40ahkOKzbwr0F7jN35LGrObytw
         TtZfMJkDWHRy7ErJa1XebcB32HE06Uj5x+GAzBEA52AEkN6xmhF6kcb+WcBaUs6xSPWa
         5k9qYCyq0k2wVmrBFIoOEnyNYtuAntKkDhrWwAwklUoSbmu5OPv5bh4gNyjBTJxo92xK
         rQjg==
X-Gm-Message-State: APt69E1OSquybWBjFdgn0Xi5FaHniYPS7xgAeWxONOHo4YaIXP8HtNRM
        +XNdbkKSkt9gCnHQ8VZOD+Y=
X-Google-Smtp-Source: AAOMgpftBE5fuDx/IUsSmhckyamA0YZ8CnjFmqIOTqy3SgWNcc9sut2RyddUN08aG2jp3hL66dYBlQ==
X-Received: by 2002:a19:12df:: with SMTP id 92-v6mr13823975lfs.80.1531137173704;
        Mon, 09 Jul 2018 04:52:53 -0700 (PDT)
Received: from dimapc.localnet (109-252-91-84.nat.spd-mgts.ru. [109.252.91.84])
        by smtp.gmail.com with ESMTPSA id d75-v6sm3975172lfg.76.2018.07.09.04.52.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 04:52:53 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/8] clk: tegra20: Turn EMC clock gate into divider
Date:   Mon, 09 Jul 2018 14:52:41 +0300
Message-ID: <1722318.xXycuB2Qx5@dimapc>
In-Reply-To: <153109441777.143105.8459253820659446035@swboyd.mtv.corp.google.com>
References: <20180617145539.4758-1-digetx@gmail.com> <20180617145539.4758-7-digetx@gmail.com> <153109441777.143105.8459253820659446035@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 9 July 2018 03:00:17 MSK Stephen Boyd wrote:
> Quoting Dmitry Osipenko (2018-06-17 07:55:37)
> 
> > Kernel should never gate the EMC clock as it causes immediate lockup, so
> > removing clk-gate functionality doesn't affect anything. Turning EMC clk
> > gate into divider allows to implement glitch-less EMC scaling, avoiding
> > reparenting to a backup clock.
> > 
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> > ---
> 
> Who's supposed to apply this? Me? Thierry? The "To:" line is not
> useful when every maintainer is there.

That's up to you and Thierry to decide. Perhaps it would be less churning if 
you'll give your ack on the 'clk:' patches and Thierry will handle the whole 
series on his own.

> > diff --git a/drivers/clk/tegra/clk-tegra20.c
> > b/drivers/clk/tegra/clk-tegra20.c index cc857d4d4a86..2bd35418716a 100644
> > --- a/drivers/clk/tegra/clk-tegra20.c
> > +++ b/drivers/clk/tegra/clk-tegra20.c
> > @@ -799,6 +798,31 @@ static struct tegra_periph_init_data
> > tegra_periph_nodiv_clk_list[] = {> 
> >         TEGRA_INIT_DATA_NODIV("disp2",  mux_pllpdc_clkm, CLK_SOURCE_DISP2,
> >         30, 2, 26,  0, TEGRA20_CLK_DISP2),>  
> >  };
> > 
> > +static void __init tegra20_emc_clk_init(void)
> > +{
> > +       struct clk *clk;
> > +
> > +       clk = clk_register_mux(NULL, "emc_mux", mux_pllmcp_clkm,
> > +                              ARRAY_SIZE(mux_pllmcp_clkm),
> > +                              CLK_SET_RATE_NO_REPARENT,
> > +                              clk_base + CLK_SOURCE_EMC,
> > +                              30, 2, 0, &emc_lock);
> > +
> > +       clk = tegra_clk_register_mc("mc", "emc_mux", clk_base +
> > CLK_SOURCE_EMC, +                                   &emc_lock);
> > +       clks[TEGRA20_CLK_MC] = clk;
> > +
> > +       /*
> > +        * Note that 'emc_mux' source and 'emc' rate shouldn't be changed
> > at +        * the same time due to a HW bug, this won't happen because
> > we're +        * defining 'emc_mux' and 'emc' as a distinct clocks.
> 
> s/ a//

I can adjust the comment and re-spin the series if something more important 
will pop up, otherwise that could addressed while applying the patch. 



