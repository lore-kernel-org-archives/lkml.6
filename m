Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52537C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F8D20989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PtfqTHsx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04F8D20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbeK3Jtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:49:41 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35833 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeK3Jtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 04:49:41 -0500
Received: by mail-oi1-f196.google.com with SMTP id v6so3131718oif.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 14:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AjC9mgriRN0LP5/i352ByFedKXXyljq0Tw1jexu8YxI=;
        b=PtfqTHsxl6T1aNf0xojBdLJL2v9MbOIxqkmi4EBvOIsB6/VNvqeZXyexp3+NuL/5VZ
         UphWUEJCTG5j+lozKPie/tnYgMcaqEL39/ZVqJ8TSBMcpOYnFnwOtn560U04O15uWFwP
         0oolYz+G70vSSLEB9DHVm6eGFlnmvBGrXN/cQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AjC9mgriRN0LP5/i352ByFedKXXyljq0Tw1jexu8YxI=;
        b=nO25M09ZIFiXUcYOHDGcigYWjaeraPXMupDE3u/OHUeM8YskbyKHgO6zEflbWTPbig
         G6elUIvNoZH5ITpMxtMgAJ5TEk3f/NiS+VXpb4JGEusNE7sVKZnWmHFeUzsNpwuJkTac
         LLKUeeSXFG3fMoahVEHLQ1n9cSkhzLg9yEw07VpkQj3e3xs5k+du31Msraygyoq6fzOr
         r7f0tPibLXzA3K/KIPsYvf8hhpWEZ/fgyLNVQ/KotUKM3a4UVMIc5+IEz0oM46AErVD6
         qWQke5S90AWAiLRgJdIwMvrdy3EtDEW9Wr5iSM8tsdE2VJjBIGQElF/kP//wPbVIMU6S
         1e8A==
X-Gm-Message-State: AA+aEWaGehw9fwmWnZYmFg1uIENythX7v2KiH2VLiB/sSpE8DE+YCjOQ
        4tlZr9HjttzueFohmR1s08a1IBDOMnAvJw==
X-Google-Smtp-Source: AFSGD/V/06Xq6gnWR7jgDlscc4uygAlxATa8cSpa9hZ+lbm/T3kTLecXbfMv00/Cc9Fm634nupYJWA==
X-Received: by 2002:aca:e495:: with SMTP id b143mr1864251oih.286.1543531356404;
        Thu, 29 Nov 2018 14:42:36 -0800 (PST)
Received: from localhost ([2600:1700:141:4960:d408:b2c2:72bf:467a])
        by smtp.gmail.com with ESMTPSA id y17sm2507709oie.41.2018.11.29.14.42.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 14:42:35 -0800 (PST)
Date:   Thu, 29 Nov 2018 16:42:34 -0600
From:   Andy Gross <andy.gross@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kbuild test robot <lkp@intel.com>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH] drm: msm: Check cmd_db_read_aux_data() for failure
Message-ID: <20181129224234.GD32306@hector.attlocal.net>
References: <20181129163826.178670-1-swboyd@chromium.org>
 <20181129223600.GC32306@hector.attlocal.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129223600.GC32306@hector.attlocal.net>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 04:36:00PM -0600, Andy Gross wrote:
> On Thu, Nov 29, 2018 at 08:38:26AM -0800, Stephen Boyd wrote:
> > We need to check the call to cmd_db_read_aux_data() for the error case,
> > so that we don't continue and use potentially uninitialized values for
> > 'pri_count' and 'sec_count'. Otherwise, we get the following compiler
> > warnings:
> > 
> >    drivers/gpu/drm/msm/adreno/a6xx_gmu.c: In function 'a6xx_gmu_rpmh_arc_votes_init.isra.12':
> >    drivers/gpu/drm/msm/adreno/a6xx_gmu.c:943:12: warning: 'pri_count' is used uninitialized in this function [-Wuninitialized]
> >      pri_count >>= 1;
> >                ^~~
> >    drivers/gpu/drm/msm/adreno/a6xx_gmu.c:948:12: warning: 'sec_count' may be used uninitialized in this function
> > [-Wmaybe-uninitialized]
> >      sec_count >>= 1;
> >                ^~~
> > 
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Cc: Jordan Crouse <jcrouse@codeaurora.org>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Evan Green <evgreen@chromium.org>
> > Cc: Jordan Crouse <jcrouse@codeaurora.org>
> > Cc: Rob Clark <robdclark@gmail.com>
> > Fixes: ed3cafa79ea7 ("soc: qcom: cmd-db: Stop memcpy()ing in cmd_db_read_aux_data()")
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>

On second thought, this needs to go through drm tree.

Reviewed-by: Andy Gross <andy.gross@linaro.org>
