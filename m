Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0FCC7112C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B356520832
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugZxX7dH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B356520832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbeJXVf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 17:35:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbeJXVf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 17:35:58 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82B952064C;
        Wed, 24 Oct 2018 13:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540386474;
        bh=Ux2wTOcJdcAMlG0IVHnIbrQ10+25LJ1VZR/4E5o1AO0=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=ugZxX7dHytw3MERDa4RID+JXo3sOTB07GouKDfSPG8oYu0Gei5+IsthMRu+ZQ6lke
         UOgC8I4OY/k6TZ0h+T2h4Xu66xSAWxSB5TLgmTfuZmZ4IMtWa2zlt9EPYxlVIkAv+6
         EBNm+H9QoA9uPWykyETEUU7F9a/i9WRfElV4qg5w=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Derek Basehore <dbasehore@chromium.org>,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181024013132.115907-2-dbasehore@chromium.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-doc@vger.kernel.org,
        mturquette@baylibre.com, heiko@sntech.de, aisheng.dong@nxp.com,
        mchehab+samsung@kernel.org, corbet@lwn.net,
        Stephen Boyd <sboyd@codeaurora.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Derek Basehore <dbasehore@chromium.org>
References: <20181024013132.115907-1-dbasehore@chromium.org>
 <20181024013132.115907-2-dbasehore@chromium.org>
Message-ID: <154038647375.53599.631725372765617195@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/6] clk: Remove recursion in clk_core_{prepare,enable}()
Date:   Wed, 24 Oct 2018 06:07:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Derek Basehore (2018-10-23 18:31:27)
> From: Stephen Boyd <sboyd@codeaurora.org>
> =

> Enabling and preparing clocks can be written quite naturally with
> recursion. We start at some point in the tree and recurse up the
> tree to find the oldest parent clk that needs to be enabled or
> prepared. Then we enable/prepare and return to the caller, going
> back to the clk we started at and enabling/preparing along the
> way.
> =

> The problem is recursion isn't great for kernel code where we
> have a limited stack size. Furthermore, we may be calling this
> code inside clk_set_rate() which also has recursion in it, so
> we're really not looking good if we encounter a tall clk tree.
> =

> Let's create a stack instead by looping over the parent chain and
> collecting clks of interest. Then the enable/prepare becomes as
> simple as iterating over that list and calling enable.
> =

> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>

Did you change anything substantially? Or is it just a resend of my
patch from a while ago? If you can add a link to the original and also
describe what changed in a maintainer tag it would be much easier for me
to compare.

