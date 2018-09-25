Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C291FECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7902520C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YAEaqUNB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7902520C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbeIYOuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 10:50:54 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:4101 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbeIYOux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 10:50:53 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ba9f56b0001>; Tue, 25 Sep 2018 01:44:27 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 25 Sep 2018 01:44:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 25 Sep 2018 01:44:25 -0700
Received: from tbergstrom-lnx.Nvidia.com (172.20.13.39) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 25 Sep 2018 08:44:25 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1002)
        id 77EA2F806DD; Tue, 25 Sep 2018 11:44:19 +0300 (EEST)
Date:   Tue, 25 Sep 2018 11:44:19 +0300
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     r yang <decatf@gmail.com>
CC:     Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: tegra: Return the exact clock rate from
 clk_round_rate
Message-ID: <20180925084419.GI7636@tbergstrom-lnx.Nvidia.com>
References: <20180921220149.17136-1-decatf@gmail.com>
 <20180924080803.GF7636@tbergstrom-lnx.Nvidia.com>
 <20180924191804.GA20060@r>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180924191804.GA20060@r>
X-NVConfidentiality: public
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1537865068; bh=aXsxd+3rtPXr+10I5nifS1fkeWU1s9jaSzVzrg3Jnhk=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
         X-NVConfidentiality:User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=YAEaqUNBYslqOGmfSw46pGXcL/63elCqP9tnw/zz+p91IOO0PyYcLb0VRJZe0ElYg
         6eMRVoxW7HMGaTvbuNNFgMLNcigr41Cvii9a1u9HeS7LdtyucciT/gAPQe65iuixii
         cOoTfSd02J9YkfszQUZMU6I3cMWxT0Y0AAN8Bks2yoXx6nu/lsVf0zTJep0NyW9TZB
         e5xlRCi6/n4wanSq6+gXjl/tLg6yQa0UTi6EEV2tUuHwYRrtFg3FBTRmQhNcbtoXQU
         kVdOYqvNksz5wxSVFEcLQk/yOQ1YQFLX0xFsdwnoIvZafXHrG8M6KpgzIJO635BWF/
         WQlSy+Y8yZcig==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 03:18:04PM -0400, r yang wrote:
> On Mon, Sep 24, 2018 at 11:08:03AM +0300, Peter De Schrijver wrote:
> > On Fri, Sep 21, 2018 at 06:01:49PM -0400, ryang wrote:
> > > The current behavior is that clk_round_rate would return the same clock
> > > rate passed to it for valid PLL configurations. This change will return
> > > the exact rate the PLL will provide in accordance with clk API.
> > > 
> > > Signed-off-by: ryang <decatf@gmail.com>
> > > ---
> > >  drivers/clk/tegra/clk-pll.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
> > > index 17a058c3bbc1..36014a6ec42e 100644
> > > --- a/drivers/clk/tegra/clk-pll.c
> > > +++ b/drivers/clk/tegra/clk-pll.c
> > > @@ -595,7 +595,12 @@ static int _calc_rate(struct clk_hw *hw, struct tegra_clk_pll_freq_table *cfg,
> > >  		return -EINVAL;
> > >  	}
> > >  
> > > -	cfg->output_rate >>= p_div;
> > > +	if (cfg->m == 0) {
> > > +		cfg->output_rate = 0;
> > 
> > I think a WARN_ON() is appropriate here. the input divider should never be 0.
> > 
> > Peter.
> > 
> 
> Should it return -EINVAL (or some error) too? _calc_rate is also in the
> clk_set_rate code path. I think we want to avoid programming the
> register to 0 input divider all together?
> 

Yes. writing 0 to the input divider is usually not allowed. In some cases it's
equivalent to writing 1, but better not count on that.

Peter.

> > > +	} else {
> > > +		cfg->output_rate = cfg->n * DIV_ROUND_UP(parent_rate, cfg->m);
> > > +		cfg->output_rate >>= p_div;
> > > +	}
> > >  
> > >  	if (pll->params->pdiv_tohw) {
> > >  		ret = _p_div_to_hw(hw, 1 << p_div);
> > > -- 
> > > 2.17.1
> > > 
