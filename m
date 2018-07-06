Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A73C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B962089D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2QX+vEdr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B962089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934364AbeGFSX3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:23:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933999AbeGFSX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:23:28 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFAD02089D;
        Fri,  6 Jul 2018 18:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530901408;
        bh=2cxrs/U0jQ7W8eodhxkVKaSNM5BxpIrfCcV3QGzpq50=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=2QX+vEdr0qVMOf/ZqIm0sN2/tAhpxBqq3+u1zOgr/BuzPFZrYni4RPQ/thLF3avrz
         Z5GHD469Xkm4GoFBYaN7JZSQ/ISJ4pQRHDaFfFe8zPJgrSXEq4OXgdKOktV8COtrht
         FIx3oVs0ew1c1z81KPMicNhc03R8wXPvVDBJL6k8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Marek Vasut <marek.vasut@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Steve Longerbeam <slongerbeam@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1527818357-8154-1-git-send-email-steve_longerbeam@mentor.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steve Longerbeam <steve_longerbeam@mentor.com>
References: <1527818357-8154-1-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <153090140728.143105.7720351459587498082@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: vc5: Avoid divide by zero when rounding or setting rates
Date:   Fri, 06 Jul 2018 11:23:27 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Steve Longerbeam (2018-05-31 18:59:17)
> Add checks in the .round_rate and .set_rate ops for zero requested
> rate or zero parent rate. If either are zero in .round_rate, just
> return zero. If either are zero in .set_rate, return -EINVAL.

Are you seeing problems when the clk is unparented and we're trying to
recalculate the rate or change rates, and thus the parent frequency
looks like 0? Should this get a Fixes: tag so that it goes back to
stable kernels?

