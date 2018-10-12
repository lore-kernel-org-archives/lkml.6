Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD20C6787F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29ABD21477
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ztApA76S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29ABD21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeJMBWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:22:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726665AbeJMBWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:22:35 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42EC620644;
        Fri, 12 Oct 2018 17:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539366538;
        bh=Ak1iUSeun0foLkLjtG8/O0QnLK9KJ4noGMA0eOjORIA=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=ztApA76SByyihZKveHAjaOW6ntJ1y2Ezx5YEpMWKHKEwJ86jbiJWksvW/GpMoaiLt
         h2pyBEyvOSa9rlXoqRTpCNlBdfRD2MkgNklzq8nzXjZkL2OlZVuyS5LH68nekggYJ5
         C3IDX6NTyWLMr0T74/gaik7i8x10V3s6000yV8Xs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Bartosz Golaszewski <brgl@bgdev.pl>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <CAMRc=McmvkWEKV71pX9_PbNaYYf2VpovO2JrUQckWJ_0taqCZw@mail.gmail.com>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Roman Gushchin <guro@fb.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
References: <20180828093332.20674-1-brgl@bgdev.pl>
 <CAMRc=McmvkWEKV71pX9_PbNaYYf2VpovO2JrUQckWJ_0taqCZw@mail.gmail.com>
Message-ID: <153936653758.5275.9529030954345523691@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 0/4] devres: provide and use devm_kstrdup_const()
Date:   Fri, 12 Oct 2018 10:48:57 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bartosz Golaszewski (2018-09-20 05:59:54)
> 2018-08-28 11:33 GMT+02:00 Bartosz Golaszewski <brgl@bgdev.pl>:
> > This series implements devm_kstrdup_const() together with some
> > prerequisite changes and uses it in pmc-atom driver.
> >
> > v1 -> v2:
> > - fixed the changelog in the patch implementing devm_kstrdup_const()
> > - fixed the kernel doc
> > - moved is_kernel_rodata() to asm-generic/sections.h
> > - fixed constness
> >
> > Bartosz Golaszewski (4):
> >   devres: constify p in devm_kfree()
> >   mm: move is_kernel_rodata() to asm-generic/sections.h
> >   devres: provide devm_kstrdup_const()
> >   clk: pmc-atom: use devm_kstrdup_const()
> >
> >  drivers/base/devres.c          | 43 ++++++++++++++++++++++++++++++++--
> >  drivers/clk/x86/clk-pmc-atom.c | 19 ++++-----------
> >  include/asm-generic/sections.h | 14 +++++++++++
> >  include/linux/device.h         |  5 +++-
> >  mm/util.c                      |  7 ------
> >  5 files changed, 63 insertions(+), 25 deletions(-)
> >
> > --
> > 2.18.0
> >
> =

> If there are no objections - can this be picked up for 4.20?
> =


There are so many people on To: line who do you want to pick this up?
Maybe you can send a pull request to Greg directly.

