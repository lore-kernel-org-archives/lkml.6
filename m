Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F61C0044B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33361207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394677AbfBMU7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 15:59:48 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36829 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfBMU7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 15:59:47 -0500
Received: by mail-qt1-f193.google.com with SMTP id p25so4081081qtb.3;
        Wed, 13 Feb 2019 12:59:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ng61dfKvZf21WQ4BUQ+6Qiu9cjO+4ESaMC3MYTHsLkE=;
        b=I2dP9yLIiyYyRQcNlm1t5VDKDIiXd1OLiqQPw9jPl9FdHrbCq0E5aS7q2vHtWsQHso
         /tLIb4PmxBDKggDmAVSWl/0YZAzozlnXsWKX49w3WvtHUmvy7F3r9pSyhF0xJy3VPU6c
         6EMyqF9+CRpuZIFoaHZn8atQi2VKdEmd/2QTmd1men5pFKDT9P2nXUB4UbFkTATatjti
         jwanPqNse4EfOhlRzR5yvuF2sx5UOHKVmizWad7J82WhCUtC+h+OF/PvI+RrXmPGIPvf
         CI+o69IxJCPei28HdwFNAE8noHqpxCE5IqLAUIqZfrWHtftHV/faqG0321oJ1PXvox/i
         uN+A==
X-Gm-Message-State: AHQUAuab4TjIGL+Drm4EJTpo3fpCo1oWIKEbDVi0+CRPYD1EmIEprW/m
        fDzGvw//EKYggOgD+NQh7E9JIdLA0L8MMsSck/U=
X-Google-Smtp-Source: AHgI3IZTDIsbRkP6r1QUuY1BW6zHTWCPLmkpKUfQIt20OksmEJr861s8cpVm6GM9oo1eD7aBZLrWzIbdHTx+urBMzj8=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr123414qta.152.1550091586587;
 Wed, 13 Feb 2019 12:59:46 -0800 (PST)
MIME-Version: 1.0
References: <20190211174544.4302-1-will.deacon@arm.com> <20190211174544.4302-2-will.deacon@arm.com>
 <CAK8P3a1gmJTt+jdTbdSYZ0z43qodxf+co757K1-Hq1mj4fCqQA@mail.gmail.com> <20190213174608.GA29100@fuggles.cambridge.arm.com>
In-Reply-To: <20190213174608.GA29100@fuggles.cambridge.arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 13 Feb 2019 21:59:28 +0100
Message-ID: <CAK8P3a1-CA_d+tRRKh50+7-PU14AV=9S1JUSF4d-VUxZ+DcW4g@mail.gmail.com>
Subject: Re: [PATCH 1/2] asm-generic/io: Pass result on inX() accessor to __io_par()
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        andrew.murray@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 6:46 PM Will Deacon <will.deacon@arm.com> wrote:

> On Tue, Feb 12, 2019 at 12:55:17PM +0100, Arnd Bergmann wrote:
>
> > For all I can see, this should not conflict with the usage of the
> > same macros on RISC-V, though it does make add a significant
> > difference, so I'd like to see an Ack from the RISC-V folks as
> > well (added to Cc), or possibly a change to arch/riscv/include/asm/io.h
> > to do a corresponding change.
>
> There's already a comment in that header which says that the accesses are
> ordered wrt timer reads, so I don't think anything needs to change there.
> For consistency with the macro arguments, I could augment their __io_par to
> take the read value as an unused argument, if that's what you mean?

Yes, that's what I meant, I should have been clearer there.

     Arnd
