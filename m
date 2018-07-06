Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EB4C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F7C214C5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhcmrtDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F7C214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933831AbeGFRKK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:10:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933230AbeGFRKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:10:08 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E93B214C5;
        Fri,  6 Jul 2018 17:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530897007;
        bh=x9utlha9IZ/AaUJju+Ilhxh5aqqFWweGBxSzjeU7eXM=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=KhcmrtDCjMJ0P3fKV49NIxJQL8rQUbui3+kA0ElEdvjcasSng0cqMWsU8mAQMzagX
         YNUkTk+zTgvIa0bwb9UqK/2Q73WND0c0GfhXPDdnIedgypiavu66UrSJiQpkzHfMfI
         SpZbhKHSZedjc24/z9X9hyJWC9KfaNW+huynOfAI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Aapo Vienamo <avienamo@nvidia.com>,
        Peter Geis <pgwipeout@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180704105148.1e32d307@dhcp-10-21-25-168>
Cc:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <1530617721-5767-1-git-send-email-avienamo@nvidia.com>
 <46bc7178-f8a4-cc4e-ebe3-507671ffb735@gmail.com>
 <20180704105148.1e32d307@dhcp-10-21-25-168>
Message-ID: <153089700685.143105.9967468507381208265@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/3] clk: tegra: refactor 7.1 div calculation
Date:   Fri, 06 Jul 2018 10:10:06 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Aapo Vienamo (2018-07-04 00:51:48)
> On Tue, 3 Jul 2018 11:10:21 -0400
> Peter Geis <pgwipeout@gmail.com> wrote:
> =

> > Good Morning,
> > =

> > Just a heads up.
> > During compilation with your patches, I get the following warning:
> > =

> > In file included from ./arch/arm/include/asm/div64.h:127:0,
> >                   from ./include/linux/kernel.h:174,
> >                   from drivers/clk/tegra/div71.c:17:
> > drivers/clk/tegra/div71.c: In function =E2=80=98div71_get=E2=80=99:
> > ./include/asm-generic/div64.h:222:28: warning: comparison of distinct =

> > pointer types lacks a cast
> >    (void)(((typeof((n)) *)0) =3D=3D ((uint64_t *)0)); \
> >                              ^
> > drivers/clk/tegra/div71.c:40:2: note: in expansion of macro =E2=80=98do=
_div=E2=80=99
> >    do_div(divider_ux1, rate);
> >    ^~~~~~
> > =

> > Very Respectfully,
> > Peter Geis
> > =

>  =

> That's indeed true. Looks like this warning is produced only on 32-bit
> arm as it uses a different variant of the do_div macro than arm64.
> =


divider_ux1 is an s64, but the generic do_div() macro is checking to
make sure that's compatible with a u64, and it isn't. Maybe you should
use a function like div64_long()?

