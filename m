Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF99C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E439B20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrdZ3cbK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E439B20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbeIGXbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 19:31:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727648AbeIGXbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 19:31:49 -0400
Received: from mail-qt0-f174.google.com (mail-qt0-f174.google.com [209.85.216.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E787C2083D;
        Fri,  7 Sep 2018 18:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536346175;
        bh=HiUZe+WPncley1Ll9aGqHIBYjQn1CeG7b+18OmU4jIQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rrdZ3cbKZ2ILceSM57E9/NQ2vAQsOK4ML2wFIv/c2Z4D1FVEWoll0KInJf8RawyvJ
         o6yftrDXp7lWdYMVQB6EDWE7o8MIRbadMStHpfyN8E3hKbzPU6rOv+BdAuQtxgJYKz
         Olh8SK6be+lmZ74Xh32Jr7JU/XSz5Qt/gtSumQ0I=
Received: by mail-qt0-f174.google.com with SMTP id r37-v6so17317200qtc.0;
        Fri, 07 Sep 2018 11:49:34 -0700 (PDT)
X-Gm-Message-State: APzg51BFBjl3RVk9r7C27WA/ZmyMTC12mabF6e2qyce9I3zD3ifveS3D
        Ny2ZU64uVO2QqECjBY56EReL32wox++cSH3L5w==
X-Google-Smtp-Source: ANB0VdZd+i31O3ejWEbV65uX4otwyZzzeLJljPBw1ZccSC+zjuqlV+Z/LfiQpRYgdmdGCijpI+jaScQY8ZQyZfqEfvs=
X-Received: by 2002:a0c:db87:: with SMTP id m7-v6mr6832443qvk.90.1536346174072;
 Fri, 07 Sep 2018 11:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180907142247.2931-1-thierry.reding@gmail.com>
In-Reply-To: <20180907142247.2931-1-thierry.reding@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 7 Sep 2018 13:49:22 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ0VZftZ+Qve+=91tbvgYof68NW+dBf4bPv+b8uQ0y1hg@mail.gmail.com>
Message-ID: <CAL_JsqJ0VZftZ+Qve+=91tbvgYof68NW+dBf4bPv+b8uQ0y1hg@mail.gmail.com>
Subject: Re: [PATCH] of: Split up name & type in modalias generation
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 9:22 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> From: Thierry Reding <treding@nvidia.com>
>
> The kernel's vsnprintf() implementation discards all alpha-numeric
> characters following a %p conversion specifier. This is done in order to
> generically skip any of the various modifiers that the kernel supports.
> Unfortunately, the OF modalias is generated with a format string that
> violates the assumption made by vsnprintf():
>
>         of:N%pOFnT%s
>
> While processing the above format string, vsnprintf() will eat the 'T'
> character, assuming that it belongs to the preceeding %p specifier. This
> results in a modalias with an incompatible format, which in turn causes
> the automatic loading of drivers based on modalias to no longer work.
>
> To fix this, split up the generation of the name & type fields into two
> separate snprintf() calls to avoid confusing the parser.
>
> Fixes: 73813f8483b1 ("of: Convert to using %pOFn instead of device_node.name")
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Note that a more elegant fix would be to make the %p format specifier
> parser report back the exact number of characters consumed. I briefly
> tried to implement it, but quickly ran into numerous special cases
> that make this solution rather involved.
>
> I can spend some more time to improve this in general if that's what we
> ultimately want, but I think this patch is a better short-term fix to
> workaround the issue.

See my reply on the original patch. I've updated the patch in my
dt/next branch with the fix to use %c.

Rob
