Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F66C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CDCB2087A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHsaa3kc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CDCB2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbeH2CHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 22:07:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:59540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbeH2CHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 22:07:09 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 849AD2083B;
        Tue, 28 Aug 2018 22:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535494408;
        bh=a/BSTxajlUOVRse+IpRQwwZyRaBWi8907g0RiNv0Yo0=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=sHsaa3kchp47VukBewo57ihQqyLi1Hl61vklV4UiKGs1hAHParA2LjVc5Dk6psLoC
         2V2NnSv3sjB18E8OD3es9df7Sc+TX/B53eZvxM/ytRpcv+Es+rgH8yxlWPCeVRyNpC
         XcRpFMcflf2zKmwlsRyHQ0wnoVuE1vmQnTPDctP4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nancy Yuen <yuenn@google.com>,
        Patrick Venture <venture@google.com>,
        Tomer Maimon <tmaimon77@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180823230654.GA11576@embeddedor.com>
Cc:     openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
References: <20180823230654.GA11576@embeddedor.com>
Message-ID: <153549440786.129321.7169734992268309360@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: npcm7xx: fix memory allocation
Date:   Tue, 28 Aug 2018 15:13:27 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gustavo A. R. Silva (2018-08-23 16:06:54)
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> =

> struct foo {
>         int stuff;
>         void *entry[];
> };
> =

> instance =3D kzalloc(sizeof(struct foo) + sizeof(void *) * count,
> GFP_KERNEL);
> =

> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> =

> instance =3D kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
> =

> Notice that, currently, there is a bug during the allocation:
>         =

> sizeof(npcm7xx_clk_data) should be sizeof(*npcm7xx_clk_data)
> =

> Fix this bug by using struct_size() in kzalloc()
> =

> This issue was detected with the help of Coccinelle.
> =

> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---

Applied to clk-fixes

