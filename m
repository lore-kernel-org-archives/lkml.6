Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D16C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 10:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8948C20C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 10:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8948C20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbeIMPiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 11:38:09 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37027 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbeIMPiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 11:38:09 -0400
Received: by mail-qt0-f194.google.com with SMTP id n6-v6so4822652qtl.4;
        Thu, 13 Sep 2018 03:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d3syHV27SIXgKwY6Ph9XLOevIOx6TOILxBDaFeGQ94c=;
        b=I2DcdjegwOtxVQTnA8Ja2tm0Sk9mGo81fUqRRLJLCZ6uLP/XaMuKKwH8pAJ33MhHOQ
         ght6rH6rDvlxMHG7Rt80VsHyj2WasbO0B0esW+eZmZxyXo1mCEKWLzY3zRmDXP7siWAe
         VRj2BsvVS4OrNIOVZ6ib//VGJKUg4nYzp7d4lDy2JS1IH5Oa4xjmPx2sKwsQ6jCTyO4M
         wkpkUhlfvLsznbjwkxovOvJbaEtk0m6TnKqcM+YwUUZD0uCLd7bjfr5bBvfriKpL86CV
         jv11vf8NK0/p4hEffhkNMWuiwehWRYSzWT2DPqXArnm1Oj8dMGVUqWXngZyJFVS6spbH
         /A4g==
X-Gm-Message-State: APzg51CsM8Nflzjk17TCDlFcu67+ZS+6nOGX0/UTuSLHSug+0Rt9VaBZ
        mEKGXuxuF7ocGtQ4HBcoVV1IYYCaUvQX4z9aUGkmiHbX
X-Google-Smtp-Source: ANB0VdboGSLOx6FRwpky/fjL/EdO79cvq1QiZiRwaUufCSAnagBZPGDP33veF+y05k+1XZlaM3OaR7p8g76mK66IN64=
X-Received: by 2002:a0c:fb08:: with SMTP id c8-v6mr4576342qvp.149.1536834558305;
 Thu, 13 Sep 2018 03:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180912150142.157913-1-arnd@arndb.de> <20180913020757.GP19965@ZenIV.linux.org.uk>
In-Reply-To: <20180913020757.GP19965@ZenIV.linux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 13 Sep 2018 12:29:02 +0200
Message-ID: <CAK8P3a2PTaanqmJycLCJ5QgNFXONb7nVye1=TJST639wDBNpAQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/17] compat_ioctl: add generic_compat_ioctl_ptrarg()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 4:07 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Sep 12, 2018 at 05:01:02PM +0200, Arnd Bergmann wrote:
> > Many drivers have ioctl() handlers that are completely compatible
> > between 32-bit and 64-bit architectures, except for the argument
> > that is passed down from user space and may have to be passed
> > through compat_ptr() in order to become a valid 64-bit pointer.
> >
> > Using ".compat_ptr=generic_compat_ioctl_ptrarg" in file operations
> > should let us simplify a lot of those drivers to avoid #ifdef
> > checks, and convert additional drivers that don't have proper
> > compat handling yet.
>
> Just keep in mind that this should *only* be used when all
> ioctls implemented in a given instance do take pointers.
> Because otherwise you are asking for trouble - e.g. if one of
> them takes an u32 used as a bitmap, this will run into trouble
> as soon as somebody uses bit 31.  With no visible warnings.
>
> IOW, it shouldn't be used blindly and it should come with big
> fat warning.

I was hoping that the _ptrarg suffix gives enough warning here,
but maybe not. I was careful to only use it in cases that I
checked are safe, either using only pointer arguments, or
no arguments.

What we might do for further clarification (besides adding a
comment next to the declaration), would be to add a
complementary generic_compat_ioctl_intarg() that skips
the compat_ptr(). There are only a handful of drivers that
would use this though.

       Arnd
