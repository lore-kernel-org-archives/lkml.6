Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 417B8C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 014E5208E5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 014E5208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965845AbeFOLNY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 07:13:24 -0400
Received: from muru.com ([72.249.23.125]:47388 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965626AbeFOLNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 07:13:21 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4ED2D82AE;
        Fri, 15 Jun 2018 11:15:59 +0000 (UTC)
Date:   Fri, 15 Jun 2018 04:13:18 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@pyra-handheld.com
Subject: Re: BUG: drivers/pinctrl/core: races in pinctrl_groups and deferred
 probing
Message-ID: <20180615111318.GJ112168@atomide.com>
References: <F20BD6B3-D4D7-4D5D-B464-64402650BDE5@goldelico.com>
 <20180614120157.GE112168@atomide.com>
 <FC373DE9-6D6B-40C5-ACED-C07B1B524469@goldelico.com>
 <20180615065810.GI112168@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180615065810.GI112168@atomide.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [180615 07:00]:
> * H. Nikolaus Schaller <hns@goldelico.com> [180614 12:15]:
> > Hi Tony,
> > 
> > > Am 14.06.2018 um 14:01 schrieb Tony Lindgren <tony@atomide.com>:
> > > 
> > > * H. Nikolaus Schaller <hns@goldelico.com> [180613 12:41]:
> > >> 
> > >> Now if I look into pinctrl_generic_add_group() and pinctrl_generic_get_group_name(),
> > >> pctldev->num_groups++ is not protected if pinctrl_generic_add_group() may be called by
> > >> two threads in parallel for the same pctldev. Hence a second thread may try to insert
> > >> a different node into the radix tree at the same selector index. This fails but there
> > >> is no error check - and the second entry is completely missing (but probably assumed to
> > >> be there).
> > > 
> > > Sounds like pinctrl-single.c is missing mutex around calls to
> > > pinctrl_generic_add_group()?
> > 
> > Yes, that could be. I didn't research the call path, just the one of
> > devm_pinctrl_get(). That uses a mutex in
> 
> In addition to missing mutex lock around the generic pinctrl functions
> we also have racy helpers pinctrl_generic_remove_last_group() and
> pinmux_generic_remove_last_function() like you pointed out. I'll post
> a patch for you later on today to test.

OK I posted a series to fix these issues hopefully as thread
"[PATCH 0/5] pinctrl fixes for generic functions and groups".

Can you please test and see if that is enough to fix the issues
you're seeing?

Regards,

Tony

