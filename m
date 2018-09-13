Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FADFC6182
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC8220882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wA0qLRaI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC8220882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbeINCP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 22:15:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727995AbeINCPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 22:15:25 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A5622146E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 21:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536872653;
        bh=d/8oUQ59SBvtkx7hXLyOZRjobVqFEj1M6AXqCL0R370=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wA0qLRaI7d1oGjTP3Pb31rnOG8NZ21eQzOVrdMfYpQNyHz5iGMCpGMnCBgLWvgy96
         KwprQANKFgfB+JZgKplEXaxxgFHnLMguW0a0fcU3xJgwDHu4gRSriVA2BUYAzCjXpi
         jzJf6Brt3A5ZaJpM2FMw0C6kp/hJIK4zS6Y5xN34=
Received: by mail-wr1-f44.google.com with SMTP id v17-v6so8106296wrr.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 14:04:13 -0700 (PDT)
X-Gm-Message-State: APzg51A0kQCDeXPT9nElM/Qa3f4eSQfM8Ewo33uPTkkDTrtQFulE1dtL
        9h4X34aK0HvbhypiMCEQbqC8zcyJDLg8RsEBFQUGzw==
X-Google-Smtp-Source: ANB0VdbkkCEHClT5tfTdO8nIJZKAPWCRrX5U+ECcnIKnhmGhaxlCSLyHjfgAbpuwJOVuvnPsMR47bwYb9YYWEGwUL0I=
X-Received: by 2002:a1c:8e81:: with SMTP id q123-v6mr6795244wmd.56.1536872651805;
 Thu, 13 Sep 2018 14:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180913202428.7284-1-abrodkin@synopsys.com>
In-Reply-To: <20180913202428.7284-1-abrodkin@synopsys.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 13 Sep 2018 16:04:00 -0500
X-Gmail-Original-Message-ID: <CABGGisxY5yLxT1QDQYOOQYJEJ+Wx8uK3ZmSvPEqvYyfAHbhScQ@mail.gmail.com>
Message-ID: <CABGGisxY5yLxT1QDQYOOQYJEJ+Wx8uK3ZmSvPEqvYyfAHbhScQ@mail.gmail.com>
Subject: Re: [PATCH] ARC: Get rid of toolchain check
To:     Alexey.Brodkin@synopsys.com
Cc:     linux-snps-arc@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vineet.Gupta1@synopsys.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 3:24 PM Alexey Brodkin
<Alexey.Brodkin@synopsys.com> wrote:
>
> This check is very naive: we simply test if GCC invoked without
> "-mcpu=XXX" has ARC700 define set. In that case we think that GCC
> was built with "--with-cpu=arc700" and has libgcc built for ARC700.
>
> Otherwise if ARC700 is not defined we think that everythng was built
> for ARCv2.
>
> But in reality our life is much more interesting.
>
> 1. Regardless of GCC configuration (i.e. what we pass in "--with-cpu"
>    it may generate code for any ARC core).
>
> 2. libgcc might be built with explicitly specified "--mcpu=YYY"
>
> That's exactly what happens in case of multilibbed toolchains:
>  - GCC is configured with default settings
>  - All the libs built for many different CPU flavors
>
> I.e. that check gets in the way of usage of multilibbed
> toolchains. And even non-multilibbed toolchains are affected.
> OpenEmbedded also builds GCC without "--with-cpu" because
> each and every target component later is compiled with explicitly
> set "-mcpu=ZZZ".
>
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> ---
>  arch/arc/Makefile | 14 --------------
>  1 file changed, 14 deletions(-)

+1 for this. Removing it also helps with my work to be able to build
all the .dts files with only a host compiler. That also needs the hunk
setting CROSS_COMPILE removed and not having a built-in dtb by
default, but this is a step in the right direction.

Acked-by: Rob Herring <robh@kernel.org>

Rob
