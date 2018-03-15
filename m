Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752566AbeCOSrP convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 14:47:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751508AbeCOSrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 14:47:14 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C259204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Rajan Vaja <RAJANV@xilinx.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <SN4PR0201MB3502AC253C8B1C9E57A83B7FB7DE0@SN4PR0201MB3502.namprd02.prod.outlook.com>
Cc: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jolly Shah <JOLLYS@xilinx.com>, Michal Simek <michals@xilinx.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
References: <1520518500-5500-1-git-send-email-rajanv@xilinx.com>
 <152061989141.26240.15533446439693285034@swboyd.mtv.corp.google.com>
 <SN4PR0201MB3502AC253C8B1C9E57A83B7FB7DE0@SN4PR0201MB3502.namprd02.prod.outlook.com>
Message-ID: <152113963269.111154.10395846178696174140@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: RE: [PATCH] clk: clk-fixed-factor: Use new macro CLK_OF_DECLARE_DRIVER
Date: Thu, 15 Mar 2018 11:47:12 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajan Vaja (2018-03-09 11:27:40)
> > From: Stephen Boyd [mailto:sboyd@kernel.org]
> > 
> > Is the intent to register the clk twice? I believe things are working as
> > intended without this patch, so maybe you can explain a little more what
> > you're trying to fix.
> [Rajan] Yes. During of_clk_init() if some DT fixed factor clock has
> parent which is neither mentioned in output-clock-names of clock
> controller nor registered as clock provider, of_clk_init() will try to
> forcefully register in second loop. 
> 
>                         if (force || parent_ready(clk_provider->np)) {
> 
>                                 /* Don't populate platform devices */
>                                 of_node_set_flag(clk_provider->np,
>                                                  OF_POPULATED);
> 
> So registration of this DT fixed-factor clock would fail as parent
> would be NULL as below (called from _of_fixed_factor_clk_setup()):
> parent_name = of_clk_get_parent_name(node, 0);
> 
> On the other hand, even if registration failed, that node will be
> marked as OF_POPULATED, so probe of clk-fixed-factor.c will also not
> be called and that DT fixed-factor clock would never be registered. 
> 
> Same thing is discussed at  https://lkml.org/lkml/2017/6/5/681 .

Ok. I believe the answer is to fix the DT to describe the parent chain
properly with clock-output-names. Otherwise, we have no good way of
figuring out what the name should be.

The alternative is to start working on a solution for having the clk
framework stop using strings to describe clk topology. My plan there is
to allow clk registration to indicate that another parent names array
should be used with clk_get() of the device or node pointer that's
associated with the clk during registration to find the parent . If we
had that, then we could hook up clks into the tree by calling clk_get()
in the framework and map through the clock-names property. This also
gets us to a point where clk names don't have to be globally unique,
which would be nice.
