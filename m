Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751514AbeFBGkl (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 02:40:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750812AbeFBGkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 02:40:37 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Rajan Vaja <RAJANV@xilinx.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <CY1PR02MB20914DBB65A193DED2BEED92B7870@CY1PR02MB2091.namprd02.prod.outlook.com>
Cc: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jolly Shah <JOLLYS@xilinx.com>, Michal Simek <michals@xilinx.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
References: <1520518500-5500-1-git-send-email-rajanv@xilinx.com>
 <152061989141.26240.15533446439693285034@swboyd.mtv.corp.google.com>
 <SN4PR0201MB3502AC253C8B1C9E57A83B7FB7DE0@SN4PR0201MB3502.namprd02.prod.outlook.com>
 <152113963269.111154.10395846178696174140@swboyd.mtv.corp.google.com>
 <SN4PR0201MB35029B265E608A24130BFEE2B7D70@SN4PR0201MB3502.namprd02.prod.outlook.com>
 <CY1PR02MB20914DBB65A193DED2BEED92B7870@CY1PR02MB2091.namprd02.prod.outlook.com>
Message-ID: <152792163637.225090.8916381060805852261@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: RE: [PATCH] clk: clk-fixed-factor: Use new macro CLK_OF_DECLARE_DRIVER
Date: Fri, 01 Jun 2018 23:40:36 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w526eki2004105

Quoting Rajan Vaja (2018-05-03 02:18:30)
> Hi Stephen,
> 
> > -----Original Message-----
> > From: Rajan Vaja
> > Sent: 16 March 2018 05:20 PM
> > To: 'Stephen Boyd' <sboyd@kernel.org>
> > Cc: linux-clk@vger.kernel.org; linux-kernel@vger.kernel.org; Jolly Shah
> > <JOLLYS@xilinx.com>; Michal Simek <michals@xilinx.com>;
> > mturquette@baylibre.com
> > Subject: RE: [PATCH] clk: clk-fixed-factor: Use new macro
> > CLK_OF_DECLARE_DRIVER
> > 
> > Hi Stephen,
> > 
> > Thanks for the comment.
> > 
> > > -----Original Message-----
> > > From: Stephen Boyd [mailto:sboyd@kernel.org]
> > > Sent: 16 March 2018 12:17 AM
> > > To: Rajan Vaja <RAJANV@xilinx.com>
> > > Cc: linux-clk@vger.kernel.org; linux-kernel@vger.kernel.org; Jolly Shah
> > > <JOLLYS@xilinx.com>; Michal Simek <michals@xilinx.com>;
> > > mturquette@baylibre.com
> > > Subject: RE: [PATCH] clk: clk-fixed-factor: Use new macro
> > > CLK_OF_DECLARE_DRIVER
> > >
> > > Quoting Rajan Vaja (2018-03-09 11:27:40)
> > > > > From: Stephen Boyd [mailto:sboyd@kernel.org]
> > > > >
> > > > > Is the intent to register the clk twice? I believe things are working as
> > > > > intended without this patch, so maybe you can explain a little more what
> > > > > you're trying to fix.
> > > > [Rajan] Yes. During of_clk_init() if some DT fixed factor clock has
> > > > parent which is neither mentioned in output-clock-names of clock
> > > > controller nor registered as clock provider, of_clk_init() will try to
> > > > forcefully register in second loop.
> > > >
> > > >                         if (force || parent_ready(clk_provider->np)) {
> > > >
> > > >                                 /* Don't populate platform devices */
> > > >                                 of_node_set_flag(clk_provider->np,
> > > >                                                  OF_POPULATED);
> > > >
> > > > So registration of this DT fixed-factor clock would fail as parent
> > > > would be NULL as below (called from _of_fixed_factor_clk_setup()):
> > > > parent_name = of_clk_get_parent_name(node, 0);
> > > >
> > > > On the other hand, even if registration failed, that node will be
> > > > marked as OF_POPULATED, so probe of clk-fixed-factor.c will also not
> > > > be called and that DT fixed-factor clock would never be registered.
> > > >
> > > > Same thing is discussed at  https://lkml.org/lkml/2017/6/5/681 .
> > >
> > > Ok. I believe the answer is to fix the DT to describe the parent chain
> > > properly with clock-output-names. Otherwise, we have no good way of
> > > figuring out what the name should be.
> > [Rajan] clock DT binding doc says that clock-output-names property
> > is optional and sometimes not recommended.
> > I think this patch fixes the issue we have which mandates to add clock-output-
> > names
> > property (for this particular case). Also, IIUC platform driver probe in clk-fixed-
> > factor.c
> > will never be called unless we use CLK_OF_DECLARE_DRIVER.
> > I completely agree that proper solution would be to stop using strings to
> > describe clock topology.
> [Rajan] Any comments on this?
> Unless we have proper solution ready, we need to have some mechanism to handle this scenario.
> clock-output-names is optional and without this, it mandates to use clock-output-names.
> 

I couldn't read your outlook sent email and I was too busy to go
translate it. Some bug in my MUA it seems.

Can you add the output-names property? In this case it's practically
mandatory, so if you can't do it I'd like to hear why not.
