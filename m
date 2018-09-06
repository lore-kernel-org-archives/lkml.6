Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232B3C4321E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEEC720659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LSzx3H62"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEEC720659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeIGDSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 23:18:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38745 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbeIGDSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 23:18:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id t84-v6so4102234pgb.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 15:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SvELnhw6aMdBs6vjAAEtj3MBDdQ3yN+NyVwI5K3jCDU=;
        b=LSzx3H62NZxQM6zdKXZWw7wF63ubMSeR2hBjRQ3rrYVL1/xXlPx8/R3CPPfMpI/eV/
         UsvMTmNI2nic+p8SsDb+FPZSdL2JXF6ci+KN1m2GhqoUWHymRp60AGTFq1dMD5oF6IE/
         bKmFm+T+3P9tKxsyrDeoEedbyMv5WbBpr3MeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SvELnhw6aMdBs6vjAAEtj3MBDdQ3yN+NyVwI5K3jCDU=;
        b=g3Hrmyon8X/b2MEaOXqRs7V49cXulHVvVPr2+ghThR4uMyFTwAs+lzW2hbsdwXk+oI
         +gILmJxpfd+RlB0enW8McxmvDNkL0i4Nv0vg0cwLpW8gmCYPb7Tfka+VE7QONWkbuyY3
         JSarihGpBW5vexviFDaWhB1yqhP7F/U667Wm8Yt+raoWlYEhVpsyb0ernlUoACPnheg/
         +F5rfZaUwlOvwFSG59SIeHQXJdikmcJFUPfPOkdh6/8tfXLln5Dako9FfO7+nHm5bUSn
         +YOXxjNbn14ppDs9SF8uYXb1IUmkSNFyrLsdRSlthLPxrQ8iZmH5HY8U/ANdI6nT3npk
         YvfA==
X-Gm-Message-State: APzg51BJXHNhr24DmesMOb0CqGRcn/Mvamg8g2u6insME5OGkC4DE5fc
        ZxX+L023AepmsHnxe0eH1rO8+Q==
X-Google-Smtp-Source: ANB0Vda0NOG0mcZl/tKucV2X+z0MhDP3824Ji2GS+HFnOXBLh+eDwPFosygtAVp3hxtZhNwCA7bo2g==
X-Received: by 2002:a62:d44a:: with SMTP id u10-v6mr5339529pfl.144.1536273633170;
        Thu, 06 Sep 2018 15:40:33 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id s195-v6sm12956023pgs.76.2018.09.06.15.40.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 15:40:32 -0700 (PDT)
Date:   Thu, 6 Sep 2018 15:40:32 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        David Brown <david.brown@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] soc: qcom: geni: Don't ignore clk_round_rate()
 errors in geni_se_clk_tbl_get()
Message-ID: <20180906224032.GF22824@google.com>
References: <20180906163241.166165-1-dianders@chromium.org>
 <201809070658.q1aRNwTN%fengguang.wu@intel.com>
 <CAD=FV=W=qcLijE3bUm7SO+cwWzno8SeiYM9zQz+vkipbpafNmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=W=qcLijE3bUm7SO+cwWzno8SeiYM9zQz+vkipbpafNmg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 03:39:04PM -0700, Doug Anderson wrote:
> Hi
> 
> On Thu, Sep 6, 2018 at 3:35 PM, kbuild test robot <lkp@intel.com> wrote:
> > Hi Douglas,
> >
> > Thank you for the patch! Perhaps something to improve:
> >
> > [auto build test WARNING on agross/for-next]
> > [also build test WARNING on v4.19-rc2 next-20180906]
> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> >
> > url:    https://github.com/0day-ci/linux/commits/Douglas-Anderson/soc-qcom-geni-Don-t-ignore-clk_round_rate-errors-in-geni_se_clk_tbl_get/20180907-045155
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git for-next
> > config: i386-allmodconfig (attached as .config)
> > compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> > reproduce:
> >         # save the attached .config to linux build tree
> >         make ARCH=i386
> >
> > Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
> > http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings
> >
> > All warnings (new ones prefixed by >>):
> >
> >    drivers/soc/qcom/qcom-geni-se.c: In function 'geni_se_clk_tbl_get':
> >>> drivers/soc/qcom/qcom-geni-se.c:531:39: warning: 'freq' may be used uninitialized in this function [-Wmaybe-uninitialized]
> >       freq = clk_round_rate(se->clk, freq + 1);
> >                                      ~~~~~^~~
> 
> Oh crud.  Yeah.  ...so v1 was right after all.  :(

Sorry about the misguided suggestion :/
