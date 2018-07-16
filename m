Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7274FECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F352084A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBeKmgbh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F352084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbeGPPE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 11:04:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbeGPPE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 11:04:29 -0400
Received: from mail-it0-f47.google.com (mail-it0-f47.google.com [209.85.214.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55BEF2084A;
        Mon, 16 Jul 2018 14:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531751806;
        bh=5qSEQRDihN5Np+PlgyQ8GgHncxRboBpB6cBhnROBW+E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DBeKmgbh2/HI0b5D1IQO0Jp9g4veMJgHd6CW9At1LpWpNqEdLLHlQnLrMgTHkuGej
         mjhXEMpRQfv9MR1ITxzmtx3hnx2gLmWOKxsr0D68YbJGiUWUNuh5uPAUNS9oXhVwe/
         syjXgyCu8xQn1DkE2dNgG2iJb6q9QiSL1F5wBG10=
Received: by mail-it0-f47.google.com with SMTP id h2-v6so19355691itj.1;
        Mon, 16 Jul 2018 07:36:46 -0700 (PDT)
X-Gm-Message-State: AOUpUlE6hDzVzEle8m+PCy58UUs0LNEYlSzey9oqfX2Rq/netnWctvF/
        DZcQ3coL48BiJkHOx65hHgE/+VQ+ZPKsQzVukg==
X-Google-Smtp-Source: AAOMgpcF6NmWOA2KnsxNhYNrfGOTf6/Bu2dh0hbhd9VYoV5s9akmUqpN1TijJ1pNhyphPFRKO1sofzeF3lOMLVJIDdc=
X-Received: by 2002:a02:986d:: with SMTP id x42-v6mr14718167jaj.131.1531751805799;
 Mon, 16 Jul 2018 07:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180706113715.30053-1-mark.rutland@arm.com> <c1f615b6-6e56-414c-b4f8-e75ad4c114e7@gmail.com>
In-Reply-To: <c1f615b6-6e56-414c-b4f8-e75ad4c114e7@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 16 Jul 2018 08:36:34 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJLyf8-szrAQKWSEpy6gG_j0Cyu9miijOQiO_YSPx_dGQ@mail.gmail.com>
Message-ID: <CAL_JsqJLyf8-szrAQKWSEpy6gG_j0Cyu9miijOQiO_YSPx_dGQ@mail.gmail.com>
Subject: Re: [PATCH] of/fdt: avoid undefined behaviour in populate_properties()
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 10:51 AM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 07/06/18 04:37, Mark Rutland wrote:
> > We unflatten a device tree in two passes: the first calculating the size
> > of the unflattened tree, and the second performing the actual
> > unflattening into a suitably-sized buffer.

[...]

> > @@ -187,7 +187,9 @@ static void populate_properties(const void *blob,
> >       int cur;
> >       bool has_name = false;
> >
> > -     pprev = &np->properties;
> > +     if (!dryrun)
> > +             pprev = &np->properties;
> > +
> >       for (cur = fdt_first_property_offset(blob, offset);
> >            cur >= 0;
> >            cur = fdt_next_property_offset(blob, cur)) {
> >
>
> Please add a one line comment explaining why "if (!dryrun)" so that no one
> decides to remove the test in the future as not needed.  Otherwise,

Please re-spin ASAP with the comment if you'd like this in 4.18.

Rob
