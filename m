Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913F7C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F300206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C99R7vKA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F300206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbeI2Doy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 23:44:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbeI2Doy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 23:44:54 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C48BE206B7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 21:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538169559;
        bh=qDiVURNEcaYn/eedVgdlv1uJEy2IoQTS0iy2HTzsALk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C99R7vKAgq4fiRYr4aJlGa03SO3Na6a6k+VT9Z8N1Km+l7Dt35KlFsVax3wTZ6huE
         ThhdhqmWUW/nxkpkxi/jGhPeXg674WbcrMvvWm4DIaKIXlqsROng92JJacTF2W0pZF
         K22jkoTLsKBL8I9VZkIyl1mXbqej9/0EwYTNueyM=
Received: by mail-qt1-f177.google.com with SMTP id i10-v6so8274406qtp.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 14:19:19 -0700 (PDT)
X-Gm-Message-State: ABuFfoh9ROZuzSkTDuK9ZvE0ClX/jwLEzkbowdj16oB38JKMVNRV65/l
        eeQlQXGc3UhsQSwEaEuVESHpHbU+HXDOa8Epqg==
X-Google-Smtp-Source: ACcGV61THcpN+FLar4cCJsfKUTyEHWkgQYwDrKJl3og3O6XQ1eUhEzAa2DW49ak/rq4jyRSEJt+baG/j/TIouX6Bc30=
X-Received: by 2002:ac8:190e:: with SMTP id t14-v6mr314349qtj.327.1538169559062;
 Fri, 28 Sep 2018 14:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-38-robh@kernel.org>
 <20180828170258.GD19825@arm.com>
In-Reply-To: <20180828170258.GD19825@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 28 Sep 2018 16:19:07 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+L+vvfh_Co6FXkyhBbwct16t8sWsw3J7hmXP4uaJaaPg@mail.gmail.com>
Message-ID: <CAL_Jsq+L+vvfh_Co6FXkyhBbwct16t8sWsw3J7hmXP4uaJaaPg@mail.gmail.com>
Subject: Re: [PATCH] perf: Convert to using %pOFn instead of device_node.name
To:     Will Deacon <will.deacon@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 12:02 PM Will Deacon <will.deacon@arm.com> wrote:
>
> On Mon, Aug 27, 2018 at 08:52:39PM -0500, Rob Herring wrote:
> > In preparation to remove the node name pointer from struct device_node,
> > convert printf users to use the %pOFn format specifier.
> >
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/perf/arm_pmu_platform.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
>
> Cheers, I can queue this up for 4.20. Let me know if you'd rather take it
> along with the name pointer removal instead.

I assumed you were going to take this since I didn't say otherwise,
but looks like it is not in linux-next. Please take thru your tree.

Rob
