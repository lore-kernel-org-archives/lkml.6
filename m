Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3343C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F082219EF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F082219EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbeHFLiQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:38:16 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:42740 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbeHFLiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:38:16 -0400
Received: by mail-ua0-f194.google.com with SMTP id w7-v6so11354068uan.9;
        Mon, 06 Aug 2018 02:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ibOPXNk7cCXefNDte1F78GbU5P3UIxul/MRGgITah/g=;
        b=QTaU/Mi6HapT3dtMdb4dxy7RjsAQQkgGoci0X7aIkEJUU4p1cblWkgNfDuX/DkTEU2
         nY0Md3/eQpV90rVP10eeqWnMKs/vKJDcn4BbV6pkzIMcDG14FLk+Wcv8uyOLJOfQPiQr
         2BJgJTeiPPo32hYPr8wzL6GFRx8GROzhbbgm1OCXU4A1YgWbMOx5qTvrSV74yFH8xEbK
         i7ERtSDtHDwN75mbTSDh67/5xp0/T8P25pMZOo2XXUiUksgg7S8RKV+0gQBogqraCFLP
         lJOscdteMB9McuDpqCfeqZd9nGCS8JBz+vmr3hxuAW63JN7HEcu5sQoBG5sdxPJBZ3oP
         DTwg==
X-Gm-Message-State: AOUpUlGUL0d9wSi8fPu6VnAyZ6Bvzhvi35NLLMwKHAgKJUFlSbXxR/X6
        djrgjWGav5KMvdEMBS0g60yRsRSS1XMAcNeKaUs=
X-Google-Smtp-Source: AAOMgpfhdR9WeET5CRw5ljgZ4JFQc+EOieJgLuwOdcqfRt27ievoDFRsEnwFhOLR68r+t6dT52luvU5uF0K/+CAMRzg=
X-Received: by 2002:ab0:72d1:: with SMTP id g17-v6mr10506191uap.33.1533547803436;
 Mon, 06 Aug 2018 02:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-15-songjun.wu@linux.intel.com> <20180803055640.GA32226@kroah.com>
 <763bba56-3701-7fe9-9b31-4710594b40d5@linux.intel.com> <20180803103023.GA6557@kroah.com>
 <3360edd2-f3d8-b860-13fa-ce680edbfd0a@hauke-m.de> <20180804124309.GB4920@kroah.com>
 <CAK8P3a3qs34LuhPeaef2wPHYEWbYO5N-4n7763BcaDyppiJ6DA@mail.gmail.com>
 <acd28f40-4342-7f67-8468-7d4578f614a1@linux.intel.com> <CAMuHMdWY9NuYOXq8sD9wmH48=vhMcSBomRY9ZbC+tGE3PGiTGg@mail.gmail.com>
 <0ab8e6e7-3cc2-8e50-b1f3-99616437f527@linux.intel.com>
In-Reply-To: <0ab8e6e7-3cc2-8e50-b1f3-99616437f527@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 6 Aug 2018 11:29:51 +0200
Message-ID: <CAMuHMdUJ8-bveoHWOetjrHtq2HNPnf00PidQwJ-kZD2o86KLMw@mail.gmail.com>
Subject: Re: [PATCH v2 14/18] serial: intel: Add CCF support
To:     songjun.wu@linux.intel.com
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Hauke Mehrtens <hauke@hauke-m.de>, hua.ma@linux.intel.com,
        yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Songjun,

On Mon, Aug 6, 2018 at 10:58 AM Wu, Songjun <songjun.wu@linux.intel.com> wrote:
> On 8/6/2018 3:20 PM, Geert Uytterhoeven wrote:
> > On Mon, Aug 6, 2018 at 9:15 AM Wu, Songjun <songjun.wu@linux.intel.com> wrote:
> >> On 8/5/2018 5:03 AM, Arnd Bergmann wrote:
> >>> On Sat, Aug 4, 2018 at 2:43 PM, Greg Kroah-Hartman
> >>> <gregkh@linuxfoundation.org> wrote:
> >>>> On Sat, Aug 04, 2018 at 12:54:22PM +0200, Hauke Mehrtens wrote:
> >>>>> On 08/03/2018 12:30 PM, Greg Kroah-Hartman wrote:
> >>>>>> On Fri, Aug 03, 2018 at 03:33:38PM +0800, Wu, Songjun wrote:
> >>>>> This patch makes it possible to use it with the legacy lantiq code and
> >>>>> also with the common clock framework. I see multiple options to fix this
> >>>>> problem.
> >>>>>
> >>>>> 1. The current approach to have it as a compile variant for a) legacy
> >>>>> lantiq arch code without common clock framework and b) support for SoCs
> >>>>> using the common clock framework.
> >>>>> 2. Convert the lantiq arch code to the common clock framework. This
> >>>>> would be a good approach, but it need some efforts.
> >>>>> 3. Remove the arch/mips/lantiq code. There are still users of this code.
> >>>>> 4. Use the old APIs also for the new xRX500 SoC, I do not like this
> >>>>> approach.
> >>>>> 5. Move lantiq_soc.h to somewhere in include/linux/ so it is globally
> >>>>> available and provide some better wrapper code.
> >>>> I don't really care what you do at this point in time, but you all
> >>>> should know better than the crazy #ifdef is not allowed to try to
> >>>> prevent/allow the inclusion of a .h file.  Checkpatch might have even
> >>>> warned you about it, right?
> >>>>
> >>>> So do it correctly, odds are #5 is correct, as that makes it work like
> >>>> any other device in the kernel.  You are not unique here.
> >>> The best approach here would clearly be 2. We don't want platform
> >>> specific header files for doing things that should be completely generic.
> >>>
> >>> Converting lantiq to the common-clk framework obviously requires
> >>> some work, but then again the whole arch/mips/lantiq/clk.c file
> >>> is fairly short and maybe not that hard to convert.
> >>>
> >>> >From looking at arch/mips/lantiq/xway/sysctrl.c, it appears that you
> >>> already use the clkdev lookup mechanism for some devices without
> >>> using COMMON_CLK, so I would assume that you can also use those
> >>> for the remaining clks, which would be much simpler. It registers
> >>> one anonymous clk there as
> >>>
> >>>           clkdev_add_pmu("1e100c00.serial", NULL, 0, 0, PMU_ASC1);
> >>>
> >>> so why not add replace that with two named clocks and just use
> >>> the same names in the DT for the newer chip?
> >>>
> >>>         Arnd
> >> We discussed internally and have another solution for this issue.
> >> Add one lantiq.h in the serial folder, and use "#ifdef preprocessor" in
> >> lantiq.h,
> >> also providing no-op stub functions in the #else case, then call those
> >> functions
> >> unconditionally from lantiq.c to avoid #ifdef in C file.
> >>
> >> To support CCF in legacy product is another topic, is not included in
> >> this patch.
> >>
> >> The implementation is as following：
> >> #ifdef CONFIG_LANTIQ
> >> #include <lantiq_soc.h>
> >> #else
> >> #define LTQ_EARLY_ASC 0
> >> #define CPHYSADDR(_val) 0
> >>
> >> static inline struct clk *clk_get_fpi(void)
> >> {
> >>       return NULL;
> >> }
> >> #endif
> > Why not use clkdev_add(), as Arnd suggested?
> > That would be a 3-line patch without introducing a new header file and an ugly
> > #ifdef, which complicates compile coverage testing?
> >
> The reason we add a new head file is also for two macros(LTQ_EARLY_ASC
> and CPHYSADDR)
> used by legacy product. We need to provide the no-op stub for these two
> macro for new product.

No you don't. The line number should not be obtained by comparing the
resource address with a hardcoded base address.

Perhaps the override of port->line should just be removed, as IIRC, the serial
core has already filled in that field with the (next available) line number?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
