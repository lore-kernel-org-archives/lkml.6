Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3A4C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40922075B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550703065;
	bh=0x9MVFXo+Y751qCaJ8GHk3d+/NV5RgOTWGaGMS1ouFA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kOP7wk2VEDE5ELnWdCe2UpbkzHVS68ba0rbzlTvggJbRADzZVRkbXjG0SjeVKkTyc
	 ZQDwzPaOoAhz4ahQBMVusC3O70lt9auX5V/FtNSsey8ESanB0x2ajbvKqodvQeoXuG
	 x7RxvWifdLxTPB5tykBxY+9TQUTjoLf7iz5E//PU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfBTWvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 17:51:04 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38654 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfBTWvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 17:51:03 -0500
Received: by mail-ot1-f65.google.com with SMTP id m1so43141405otf.5;
        Wed, 20 Feb 2019 14:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MXnskfauBnUogXYJgY5dNHOIdo9j55TU67g9oo5oqhM=;
        b=iY2UUx4XT1XIes809ngeklzqfZgg7VS8kJONQndZkEalSX1I36hQd9WW5K2h2hG9eQ
         K64z58NYOcyR7jHnFZi9cZF7uvh8PpRlYAmrvjrXmB7O7gNkg8mwKx2bYeES+o7//za5
         IPgLQ6WqCsqfixVFaJmkGOTD2hr0LZ2QhVwAGCmv++UrNsyxvnV1INi6g6An5R5/pKt+
         aCC4e6mKDJhEcD0o2gBTo15Jf/OUNbrz0tOE6xwt0V8PlBuX4N6tLVvGywNrKnKZh4qT
         1QjcXnMcErMnkIW5A1enJHm7feKkNu71QsKrvj+mbsx/0bixoiA7tLuxccMmwgjHggJT
         MPfw==
X-Gm-Message-State: AHQUAuZ/MdjdV2utkdyDRVjvBAd4jHTu8BoibtRr9dgehKWgBwuwQ6v7
        0Pd5gqFRRfFCg+DtpsP8xT0EfhAbeO7T/FmJQ4E=
X-Google-Smtp-Source: AHgI3IZRPgC4J+d8RrkM9iH9F5Zs+AMlNX5W8aBgKvrqXeUzhgCN/MVSc89/TZNlgaCEVUeLZkRcCiMgaC2iQSwbJBk=
X-Received: by 2002:aca:ed0f:: with SMTP id l15mr7586917oih.76.1550703062784;
 Wed, 20 Feb 2019 14:51:02 -0800 (PST)
MIME-Version: 1.0
References: <20190214171017.9362-1-keith.busch@intel.com> <20190214171017.9362-8-keith.busch@intel.com>
 <CAJZ5v0gjv0DZvYMTPBLnUmMtu8=g0zFd4x-cpP11Kzv+6XCwUw@mail.gmail.com>
 <9ab5d6ba-4cb6-a6f1-894d-d79b77c8bc21@intel.com> <CAJZ5v0izS-MBcC3ZsRKK59zWcJOMQ672sRuv_GCVrsYR36Wa8w@mail.gmail.com>
 <20190220224419.GC5478@localhost.localdomain>
In-Reply-To: <20190220224419.GC5478@localhost.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Feb 2019 23:50:52 +0100
Message-ID: <CAJZ5v0ji4ReBFf_L14kNbt-eAg79mdQYkYNC8MqbM=4kQa4Agg@mail.gmail.com>
Subject: Re: [PATCHv6 07/10] acpi/hmat: Register processor domain to its memory
To:     Keith Busch <keith.busch@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 11:44 PM Keith Busch <keith.busch@intel.com> wrote:
>
> On Wed, Feb 20, 2019 at 11:21:45PM +0100, Rafael J. Wysocki wrote:
> > On Wed, Feb 20, 2019 at 11:11 PM Dave Hansen <dave.hansen@intel.com> wrote:
> > > On 2/20/19 2:02 PM, Rafael J. Wysocki wrote:
> > > >> diff --git a/drivers/acpi/hmat/Kconfig b/drivers/acpi/hmat/Kconfig
> > > >> index c9637e2e7514..08e972ead159 100644
> > > >> --- a/drivers/acpi/hmat/Kconfig
> > > >> +++ b/drivers/acpi/hmat/Kconfig
> > > >> @@ -2,6 +2,7 @@
> > > >>  config ACPI_HMAT
> > > >>         bool "ACPI Heterogeneous Memory Attribute Table Support"
> > > >>         depends on ACPI_NUMA
> > > >> +       select HMEM_REPORTING
> > > > If you want to do this here, I'm not sure that defining HMEM_REPORTING
> > > > as a user-selectable option is a good idea.  In particular, I don't
> > > > really think that setting ACPI_HMAT without it makes a lot of sense.
> > > > Apart from this, the patch looks reasonable to me.
> > >
> > > I guess the question is whether we would want to allow folks to consume
> > > the HMAT inside the kernel while not reporting it out via
> > > HMEM_REPORTING.  We have some in-kernel users of the HMAT lined up like
> > > mitigations for memory-side caches.
> > >
> > > It's certainly possible that folks would want to consume those
> > > mitigations without anything in sysfs.  They might not even want or need
> > > NUMA support itself, for instance.
> > >
> > > So, what should we do?
> > >
> > > config HMEM_REPORTING
> > >         bool # no user-visible prompt
> > >         default y if ACPI_HMAT
> > >
> > > So folks can override in their .config, but they don't see a prompt?
> >
> > Maybe it would be better to make HMEM_REPORTING do "select ACPI_HMAT if ACPI".
> >
> > The mitigations could then do that too if they depend on HMAT and
> > ACPI_HMAT need not be user-visible at all.
>
> That sounds okay, though it would create unreachable code if !ACPI since
> that's the only user for the new reporting interfaces.

Until there are other users of it, you can make HMEM_REPORTING depend
on ACPI_NUMA and select ACPI_HMAT.
