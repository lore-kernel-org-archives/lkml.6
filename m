Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CFEC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 19:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC0C21850
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 19:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546196684;
	bh=rW8iXRr1qtbBl3ExdFWhmi36lQt3MhVIAPxvkwdj1ik=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fk5dhzTSPYyMcABpteKmbVfbbB8QCEjdbcOnGfKZNdgbPvO6IxFRXs6EyQj4HFuiR
	 4jIfmOduFWFO+9iGhfT/+NorPCQ9FtflshaVpnGqmiVSb13FWSqXCcVtyTQdxid2TX
	 6dfGgLiMJNfy4okJDS7/RyvfiyHbimQ3K9KlJLU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbeL3TEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 14:04:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:47404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbeL3TEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 14:04:43 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C81420861;
        Sun, 30 Dec 2018 19:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546196682;
        bh=rW8iXRr1qtbBl3ExdFWhmi36lQt3MhVIAPxvkwdj1ik=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RqN8qQskazNrmRo+bdEoNTghfvf0GkV3k4Obl6f9TAs9AgX48CRz2QTjYxZjd3pcC
         oAgP45YEmf9eZWCuzUUHvlHP0QNqigY6cKgrkCJi+1xEF5DxsnXIICjBwmEb7w3x2v
         NUjjWHNeTdUbn+RtBsdrYzbPfUksQWF2yeznZAwc=
Received: by mail-ot1-f46.google.com with SMTP id 40so22283423oth.4;
        Sun, 30 Dec 2018 11:04:42 -0800 (PST)
X-Gm-Message-State: AJcUukc3SYZdQ+wmD1KcYvayilfH1B8AeUGsB4CFq2INraemEAvFxv4o
        Lj76hAGc0HD4xhUyhPRD+oQOeYc00Y6w5ZRrJxQ=
X-Google-Smtp-Source: ALg8bN54EGWwDlgcPybX8cXGu4X3cTKAJDV70jqkEqxYABKZAXOeZl7KHQtSLWy5OPgknm7t9nLLIlyJCLEStgIdQTM=
X-Received: by 2002:a9d:2c5:: with SMTP id 63mr24381219otl.271.1546196681501;
 Sun, 30 Dec 2018 11:04:41 -0800 (PST)
MIME-Version: 1.0
References: <20181223232521.11320-1-okaya@kernel.org> <20181223232521.11320-11-okaya@kernel.org>
 <CAJZ5v0is-DSV15AxRyNG93vazzQsY_8vM6crzgZXeEmhTyQBVQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0is-DSV15AxRyNG93vazzQsY_8vM6crzgZXeEmhTyQBVQ@mail.gmail.com>
From:   Sinan Kaya <Okaya@kernel.org>
Date:   Sun, 30 Dec 2018 22:04:30 +0300
X-Gmail-Original-Message-ID: <CAK9iUCNrP6u_m1VE-vUBw9gPK6LvEeugEGK9Kc=UPDXEYjxggw@mail.gmail.com>
Message-ID: <CAK9iUCNrP6u_m1VE-vUBw9gPK6LvEeugEGK9Kc=UPDXEYjxggw@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] x86: select IOSF_MBI only when CONFIG_PCI is set
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 25, 2018 at 12:14 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Dec 24, 2018 at 12:25 AM Sinan Kaya <okaya@kernel.org> wrote:
> >
> > Need CONFIG_PCI to be set in order to be able to use IOSF_MBI
> > functionality.
> >
> > Signed-off-by: Sinan Kaya <okaya@kernel.org>
>
> The subject and changelog here don't match the changes below.  Please fix.
>

Done

> > ---
> >  arch/x86/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index cc4f0c6ee1ed..322a58ababb0 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -617,7 +617,7 @@ config X86_INTEL_QUARK
> >
> >  config X86_INTEL_LPSS
> >         bool "Intel Low Power Subsystem Support"
> > -       depends on X86 && ACPI
> > +       depends on X86 && ACPI && PCI
> >         select COMMON_CLK
> >         select PINCTRL
> >         select IOSF_MBI
> > --
> > 2.19.0
> >
