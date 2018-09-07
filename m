Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11341C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8DD920652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EY59Iein"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8DD920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeIGWdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:33:32 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37976 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbeIGWdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:33:32 -0400
Received: by mail-io1-f66.google.com with SMTP id y3-v6so2183603ioc.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 10:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J1Zd/AvADAB38+rQMNEYXeZC+Sxxuq8J7wFH5eJZqgk=;
        b=EY59Iein4G3rjwqc0OZEZOhKjTwykAete1pXmgjknHAm2loGHPIiOdyL+Fx9iAcv3r
         LcXp7fuDVCT/Uo3fQoURKNK4X3epBcobmFJEILt0gwXQqorJBzh0efTGd0LKvhs4CcBD
         Ydsl+cKHjSGCNsCQzcXTrdrgKMbJZF9UUFQWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J1Zd/AvADAB38+rQMNEYXeZC+Sxxuq8J7wFH5eJZqgk=;
        b=ZZq3ItW/3ItDW3BjEHOg1zcLFcFO14OYAkk/GxNxq5o3a2lkpGOHBp8NMltBjRVoU2
         B7uF2xjUHX0ZYb1cUwrovpd3u0CS0sivN0oiv4/iMn7U4yDm+oBCbTSUWFiCoaW/I+aa
         LrmDH9kLtm6NcXwb8DhOslmJflEyxtGPk8lfjFHdxRdGyQuJAF2AisZ5+HZaiaxyTSG+
         /DYVXw15+8D6EvMbRXR8D88IfidfyALuMDQglrY8jOVaKOSk/nf3Brwvwjl4mgWBrcMO
         S9UEMz8MJdZ8hU0jx1ZfeXl3F+V5uPxAnyaooFHeklIzu29YL+mxE7L//EE/ScclZynO
         8q5g==
X-Gm-Message-State: APzg51DdeqghrD2+vRHk5jUecjh3+F3GA+A4h8PSYXqnaOWCNzp9krW7
        XuFwkWRc1l3QBxUtbTvL5wE0KF1Ik0FuBlA/ApdaRt0Y
X-Google-Smtp-Source: ANB0VdZ8sv7oQpGsK467ngH7PI0ByXr32wR5KWXZ13pSaMns2PBzEaeotSVCotqlKmNcHPHNeF5knJ35L08ai0ZcG5s=
X-Received: by 2002:a6b:f609:: with SMTP id n9-v6mr7780337ioh.259.1536342689971;
 Fri, 07 Sep 2018 10:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180907154516.GG12788@arm.com>
In-Reply-To: <20180907154516.GG12788@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Sep 2018 10:51:19 -0700
Message-ID: <CA+55aFw97E=pUTRejXDAVYbK90cgF=1R3MPxE3t9fDoKctOGNA@mail.gmail.com>
Subject: Re: [GIT PULL] arm64: fix for -rc3
To:     Will Deacon <will.deacon@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 8:45 AM Will Deacon <will.deacon@arm.com> wrote:
>
> Just one small fix here, preventing a VM_WARN_ON when a !present PMD/PUD
> is "freed" as part of a huge ioremap() operation. The correct behaviour
> is to skip the free silently in this case, which is a little weird (the
> function is a bit of a misnomer), but it follows the x86 implementation.

Hmm. I've obviously pulled it, but it does strike me that maybe the
confusing semantics could be fixed?

There's only one call site, and only two implementations (x86 and arm64).

Maybe the whole "read pmd, check for present" could just be in the
caller, avoiding that oddity wrt name-vs-behavior.

I'm not entirely sure why that code has that special case to begin
with. I guess this is the only case of a kernel mapping of a hugepage,
and people wanted to avoid polluting the generic code with stuff that
was only relevant for architectures that implemented it? But we
already have that ioremap_pmd_enabled() guard, so architectures that
don't do this wouldn't actually have any extra code.

Anyway, I'll let it be, but I think it could be a good idea to simply
change the semantics, and in the process also make it a lot clearer
what that thing actually is expected to do.

                 Linus
