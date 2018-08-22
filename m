Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83765C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 07:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4080421473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 07:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4080421473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbeHVK53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 06:57:29 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:44631 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeHVK53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 06:57:29 -0400
Received: by mail-qk0-f193.google.com with SMTP id d131-v6so606616qke.11;
        Wed, 22 Aug 2018 00:33:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YfRQ8LNTIdnMy3HeT5xDDir0OXJpj20CM46u1WGTJN0=;
        b=PxZ9ifZKwqlAh34vtdY/+uwPWRzH7TdEUYGXpNXgQrDb3eXO3KTDY5hI/dcJgIpu49
         +pURLxS7XngDbCn0j/qs0LU+TsfqxiUzwF9mP+FCSnm7B0d2f75aZ0Q35N6NHIQWxufH
         G1KhMc0B4/krWl0VHx2mj0wUDrJDzIk5yjQ0FLQ5a80hCpi9Ixi79bCemcKjK2UCawup
         Cnz4XmWSCPGH5CrReERHv8cJQatQIhcQe8Bf0y4FzHVwyUw/43S7OwROKbMToHMNMfPU
         TrJnTtm8AK5N70vHxQK34Q+uz5QCuJFrl/a7NfACUEBVQz2WmLlLkA+NTMRk2SWEs782
         fMbg==
X-Gm-Message-State: AOUpUlFTUBVbLp2DhB2nFoVj+3Db5fu7IT8Bf0s/eYX2DT/V/HoomgyA
        hIHmzl+NlnszVAvORbaF9a6zjYhUOzBnd2rs/Xo=
X-Google-Smtp-Source: AA+uWPw3zMXSuC9Mhq3gxgcTIB7OIb9+2jjr70ir0dQy6XKgP9JvDWVCf3ZioIGwRAxzZq/xC/SRtRScOsCzDJUSXQo=
X-Received: by 2002:a37:6b03:: with SMTP id g3-v6mr48021300qkc.107.1534923228754;
 Wed, 22 Aug 2018 00:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180821142100.2250647-1-arnd@arndb.de> <20180822031813.GA1313@ziepe.ca>
In-Reply-To: <20180822031813.GA1313@ziepe.ca>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 22 Aug 2018 09:33:32 +0200
Message-ID: <CAK8P3a043WTUs92521a1KJ8LEn5sjyw9Bxj7CFfK-z15AgfPHg@mail.gmail.com>
Subject: Re: [PATCH] IB/ucm: fix UCM link error
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Matan Barak <matanb@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 5:18 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Aug 21, 2018 at 04:20:44PM +0200, Arnd Bergmann wrote:
> > Building UCM with CONFIG_INFINIBAND_USER_ACCESS=m results in a
> > set of link errors including:
> >
> > drivers/infiniband/core/ucm.o: In function `ib_ucm_event_handler':
> > ucm.c:(.text+0x6dc): undefined reference to `ib_copy_path_rec_to_user'
> > drivers/infiniband/core/ucma.o: In function `ucma_event_handler':
> > ucma.c:(.text+0xdc0): undefined reference to `ib_copy_ah_attr_to_user'
> >
> > To get it to build-test again, this makes the option itself a
> > tristate, which lets Kconfig figure out the dependency correctly.
> >
> > Fixes: 486edfb1039d ("IB/ucm: Fix compiling ucm.c")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/infiniband/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Applied to for-rc
>
> But that fixes line isn't right is it?
>
> Should it be
>
> commit 7a8690ed6f5346f6738971892205e91d39b6b901
> Author: Leon Romanovsky <leonro@mellanox.com>
> Date:   Wed May 23 08:22:11 2018 +0300
>
>     RDMA/ucm: Mark UCM interface as BROKEN
>
> Which added the config in the first place??

The commit I cited is the one that caused the build regression for me.

The first one (7a8690ed6f) caused the interface to disappear,
the second one (486edfb1039d) brought it back in a way that
fails in some random configurations.

       Arnd
