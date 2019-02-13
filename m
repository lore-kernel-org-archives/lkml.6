Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F910C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 569D020700
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d5xYdNzC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393012AbfBMR0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:26:30 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40593 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390483AbfBMR03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:26:29 -0500
Received: by mail-ot1-f66.google.com with SMTP id s5so5599076oth.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 09:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cu1iqpGSYuCannOwpEG86HVxne6PUop+ZleJWeJ1rYM=;
        b=d5xYdNzCKbt8cWv7bDwtJj2UcXvhLXBl7WtTBqGm6ThPtMXnMNkRPUVHsR1EZkitPA
         WuVXg5DKBP5p7Vv6zcLFT2fQmsbYV8eLWTeXAIkUYhDg6uSrQ47IhYfxOviT7wvfkdR2
         01qdkOm/Jf5IwrlrqRq5KtvVUPGRWA6iUqZP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cu1iqpGSYuCannOwpEG86HVxne6PUop+ZleJWeJ1rYM=;
        b=aVZjvME+SHvCKT84f7mbfvHluNYI2x7YUrT8vJ1GJaTbfTOsiqzX8r1Vwn/ST2v+Cd
         Gfnki1hugi9HIsX3eFHSt1PK854VGvTCtWqwyVDJ869I01nB7MBjqi7xVPD4KtqF1fyU
         hOEQjUTT6KqN4zvxbKOI6JEbfsevRYff3lwIIf1VkrH0RbH/Lze2KlaH1+6iZuq9GsZo
         Saj07nzJqlyLswuh8rkWhGXPXCiImMunO+HUe82ulQ5b6raODTvLAz2SyVwt8pe6vvO0
         ySfEwJ0kl1u9CnvuzGUwzuRZAfpLDYVog+gi+FUq7OWwhx0+ScfwpfNTyQGpJHk2JnqC
         lBUg==
X-Gm-Message-State: AHQUAuZebS6/nI6hHG7WRjuefNPyylI2Y89C1/e8u+SKxZKfyzbQUbsh
        JIDVaHrBqsQ0FlxoJuofhUKKfI1hVbQ=
X-Google-Smtp-Source: AHgI3Ia/FZ89YeJCGfcxOjm64ABuD8MXH0ZEZFmlmbIu/OgzdMLrdUR9FKdWzBgQL1ia+O2KOP5kIA==
X-Received: by 2002:a9d:3464:: with SMTP id v91mr1068327otb.102.1550078787941;
        Wed, 13 Feb 2019 09:26:27 -0800 (PST)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com. [209.85.210.47])
        by smtp.gmail.com with ESMTPSA id s66sm4930621otb.65.2019.02.13.09.26.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 09:26:27 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id k98so5645428otk.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 09:26:26 -0800 (PST)
X-Received: by 2002:aca:5714:: with SMTP id l20mr844494oib.148.1550078786120;
 Wed, 13 Feb 2019 09:26:26 -0800 (PST)
MIME-Version: 1.0
References: <20190212175059.1ea4c16c@canb.auug.org.au> <94edf49b-6b37-2dac-a2db-ad454b105fd1@infradead.org>
 <CAHX4x87=Myx45wBYtFY=rwz8jVmYY-tYVQjnzod-V8HaWJSy+g@mail.gmail.com>
 <CAHX4x87nRpTR5880y6hc=r7k0OFV9YKate21U=2kkqC-ihdmCQ@mail.gmail.com> <6913db72-85b3-0b7d-5e38-9cbb6ec4c8c2@infradead.org>
In-Reply-To: <6913db72-85b3-0b7d-5e38-9cbb6ec4c8c2@infradead.org>
From:   Nick Crews <ncrews@chromium.org>
Date:   Wed, 13 Feb 2019 10:26:14 -0700
X-Gmail-Original-Message-ID: <CAHX4x84H3Z+5zeUR_WCa4vwcARWtxxxKVQCnQObcThqntFPM6Q@mail.gmail.com>
Message-ID: <CAHX4x84H3Z+5zeUR_WCa4vwcARWtxxxKVQCnQObcThqntFPM6Q@mail.gmail.com>
Subject: Re: linux-next: Tree for Feb 12 (chrome/wilco_ec/)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy,

No, I didn't test it, I'm sorry, of course I should done that.
Sorry for the formatting too, I'm new to this and wasn't sure what
tool to use. The following version of the patch was made with
"git format-patch" and now I'm replying in plaintext, it hopefully is better.

From 0cfb3db970636983c1570827b7793e31e352716e Mon Sep 17 00:00:00 2001
From: Nick Crews <ncrews@chromium.org>
Date: Tue, 12 Feb 2019 16:46:15 -0700
Subject: [PATCH] FROMLIST: wilco_ec: Fix Kconfig dependencies

In the initial version of the Wilco EC Driver, the
dependency order was wrong. It before was possible to
select CONFIG_WILCO_EC and CONFIG_CROS_EC_LPC without
having CONFIG_CROS_EC_LPC_MEC. This was wrong, since
WILCO_EC depends upon CONFIG CROS_EC_LPC_MEC, not the
other way around.

---
 drivers/platform/chrome/Kconfig          | 2 +-
 drivers/platform/chrome/wilco_ec/Kconfig | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 462eb9dfa4f2..b69561050868 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -95,7 +95,7 @@ config CROS_EC_LPC

 config CROS_EC_LPC_MEC
  bool "ChromeOS Embedded Controller LPC Microchip EC (MEC) variant"
- depends on CROS_EC_LPC || WILCO_EC
+ depends on CROS_EC_LPC
  default n
  help
    If you say Y here, a variant LPC protocol for the Microchip EC
diff --git a/drivers/platform/chrome/wilco_ec/Kconfig
b/drivers/platform/chrome/wilco_ec/Kconfig
index d8e2cddb4712..de097690fce3 100644
--- a/drivers/platform/chrome/wilco_ec/Kconfig
+++ b/drivers/platform/chrome/wilco_ec/Kconfig
@@ -1,7 +1,6 @@
 config WILCO_EC
  tristate "ChromeOS Wilco Embedded Controller"
- depends on ACPI && X86
- select CROS_EC_LPC_MEC
+ depends on ACPI && X86 && CROS_EC_LPC_MEC
  help
    If you say Y here, you get support for talking to the ChromeOS
    Wilco EC over an eSPI bus. This uses a simple byte-level protocol
--
2.20.1


On Tue, Feb 12, 2019 at 5:13 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 2/12/19 3:49 PM, Nick Crews wrote:
> > OK, here is the patch to fix this problem. We had the dependency backwards.
> >
> > Should I re-send out the entire patch series to the LKML with this fix in it?
> >
> >
> > diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> > index 462eb9dfa4f2..b69561050868 100644
> > --- a/drivers/platform/chrome/Kconfig
> > +++ b/drivers/platform/chrome/Kconfig
> > @@ -95,7 +95,7 @@ config CROS_EC_LPC
> >
> >  config CROS_EC_LPC_MEC
> >         bool "ChromeOS Embedded Controller LPC Microchip EC (MEC) variant"
> > -       depends on CROS_EC_LPC || WILCO_EC
> > +       depends on CROS_EC_LPC
> >         default n
> >         help
> >           If you say Y here, a variant LPC protocol for the Microchip EC
> > diff --git a/drivers/platform/chrome/wilco_ec/Kconfig b/drivers/platform/chrome/wilco_ec/Kconfig
> > index d8e2cddb4712..6ea2d3f64ce5 100644
> > --- a/drivers/platform/chrome/wilco_ec/Kconfig
> > +++ b/drivers/platform/chrome/wilco_ec/Kconfig
> > @@ -1,6 +1,6 @@
> >  config WILCO_EC
> >         tristate "ChromeOS Wilco Embedded Controller"
> > -       depends on ACPI && X86
> > +       depends on ACPI && X86 && CROS_EC_LPC_MEC
> >         select CROS_EC_LPC_MEC
> >         help
> >           If you say Y here, you get support for talking to the ChromeOS
> >
> >
>
> Nick,
>
> Did you test this?
>
> When I apply the patch (by hand, since it was whitespace-mangled/damaged),
> I get this:
>
> rdunlap@midway:linux-next-20190212> make ARCH=x86_64 O=X64 oldconfig
> make[1]: Entering directory '/home/rdunlap/lnx/next/linux-next-20190212/X64'
>   GEN     Makefile
> scripts/kconfig/conf  --oldconfig Kconfig
> drivers/platform/chrome/Kconfig:84:error: recursive dependency detected!
> drivers/platform/chrome/Kconfig:84:     symbol CROS_EC_LPC_MEC is selected by WILCO_EC
> drivers/platform/chrome/wilco_ec/Kconfig:1:     symbol WILCO_EC depends on CROS_EC_LPC_MEC
> For a resolution refer to Documentation/kbuild/kconfig-language.txt
> subsection "Kconfig recursive dependency limitations"
>
>
>
>
> --
> ~Randy
